Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWJNScc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWJNScc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWJNScc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:32:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422770AbWJNScb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:32:31 -0400
Date: Sat, 14 Oct 2006 11:32:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: swhiteho@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gfs2 endianness bug: be16 assigned to be32 field
In-Reply-To: <20061014154930.GL29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610141123580.3952@g5.osdl.org>
References: <20061014154930.GL29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Oct 2006, Al Viro wrote:
>
> -	leaf->lf_dirent_format = cpu_to_be16(GFS2_FORMAT_DE);
> +	leaf->lf_dirent_format = cpu_to_be32(GFS2_FORMAT_DE);

Hmm. Doesn't this change the on-disk format on a LE machine (eg x86)?

In other words, this change makes me nervous. A quick grep seems to 
indicate that nothing actually _uses_ this field, so maybe we don't really 
care, but I think we should double-check that this is what the GFS2 people 
really want.

If we don't want to change the format on a LE machine, then maybe the 
gfs2_leaf structure should be changed to be

	..
	__be16 lf_dirent_format;
	__be16 lf_unused;
	..

which should keep the bits in the same position on LE.

Regardless, the old code was clearly wrong, since it gives different 
on-disk format for a big-endian and a little-endian machine. Al's fix is 
proper, but perhaps people would prefer something that breaks the BE 
format rather than the LE format. Hmm?

Steven?

		Linus
