Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277834AbRJRReC>; Thu, 18 Oct 2001 13:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277836AbRJRRdx>; Thu, 18 Oct 2001 13:33:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45832 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277834AbRJRRdm>; Thu, 18 Oct 2001 13:33:42 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: libz, libbz2, ramfs and cramfs
Date: 18 Oct 2001 10:33:36 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9qn3pg$73i$1@cesium.transmeta.com>
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com> <3BCE4BB5.8060603@zytor.com> <15310.33191.397106.8530@cargo.ozlabs.ibm.com> <15310.51180.802846.33348@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <15310.51180.802846.33348@cargo.ozlabs.ibm.com>
By author:    Paul Mackerras <paulus@samba.org>
In newsgroup: linux.dev.kernel
> 
> ppp_deflate doesn't use next_out = NULL in this case, but it does use
> next_out = NULL when we are compressing a packet and the compressed
> packet turns out to be larger than the uncompressed.  With deflate
> there is a limit on how much larger the compressed packet would be, so
> it would be possible to give it a small extra buffer on the stack
> instead of using next_out = NULL.
> 

Discarding data is an important operation -- in zisofs that can happen
on a page lock conflict; I just use a dummy page for that.

> If we were going to standardize on a newer zlib in the kernel, I could
> change ppp_deflate to cope with that without too much pain, I think.
> The main thing I would want to add is a way to check what state the
> decompressor is in at the end of each packet - we want
> strm->state->blocks->mode == LENS at that point, which is not
> something that can be checked using the existing zlib interface.

The big issue is memory management.  I *think* the memory policy I
implemented in inflate_fs would work for PPP (you have to provide a
memory area of sufficient size, about 40K, at the time you open a
stream.  In the case of PPP this could probably just be vmalloc()'d at
the time the interface is created.  In the fs case, this is not
acceptable; rather, the filesystem in question has to maintain a
preallocation of memory and mutex it properly.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
