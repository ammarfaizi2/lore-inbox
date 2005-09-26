Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVIZO5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVIZO5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVIZO5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:57:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932149AbVIZO5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:57:22 -0400
Date: Mon, 26 Sep 2005 07:57:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 1/4] NTFS: Fix sparse warnings that have crept in over
 time.
In-Reply-To: <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0509260746130.3308@g5.osdl.org>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Sep 2005, Anton Altaparmakov wrote:
>
> NTFS: Fix sparse warnings that have crept in over time.

I think this is wrong.

What was the warning that caused this (and the two other things that look 
the same)?

>  #define MK_MREF(m, s)	((MFT_REF)(((MFT_REF)(s) << 48) |		\
> -					((MFT_REF)(m) & MFT_REF_MASK_CPU)))
> +					((MFT_REF)(m) & (u64)MFT_REF_MASK_CPU)))

Also, side note: how you defined "MFT_REF_MASK_CPU" is pretty debatable in 
the first place:

	typedef enum {
	        MFT_REF_MASK_CPU        = 0x0000ffffffffffffULL,
	        MFT_REF_MASK_LE         = const_cpu_to_le64(0x0000ffffffffffffULL),
	} MFT_REF_CONSTS;

and this just _happens_ to work with gcc, but it's not real C.

The issue? "enum" is really an integer type. As in "int". Trying to put a 
larger value than one that fits in "int" is not guaranteed to work.

There's another issue, namely that the type of the snum is not only of 
undefined size (is it the same size as an "int"? Is it an "unsigned long 
long"?) but the "endianness" of it is also now totally undefined. You have 
two different endiannesses inside the _same_ enum. What is the type of the 
enum?

You _really_ probably should use just

	#define MFT_REF_MASK_CPU 0x0000ffffffffffffULL
	#define MFT_REF_MASK_LE const_cpu_to_le64(MFT_REF_MASK_CPU)

instead. That way the type of that thing is well-defined.

Depending on what warning you're trying to shut up, that may well fix it 
too. Because now "MFT_REF_MASK_CPU" is clearly a regular constant, while 
MFT_REF_MASK_LE is clearly a little-endian constant. Before, they were of 
the same enum type, which made it very unclear what the hell they were.

		Linus
