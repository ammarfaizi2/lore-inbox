Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUELVNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUELVNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUELVMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:12:34 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:38288 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263769AbUELVIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:08:13 -0400
Date: Wed, 12 May 2004 22:08:12 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6-BK] x86_64 has buggy ffs() implementation
In-Reply-To: <c7u1js$1h2$1@terminus.zytor.com>
Message-ID: <Pine.SOL.4.58.0405122205450.17746@yellow.csi.cam.ac.uk>
References: <1084369416.16624.53.camel@imp.csi.cam.ac.uk> <c7u1js$1h2$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, H. Peter Anvin wrote:
> Followup to:  <1084369416.16624.53.camel@imp.csi.cam.ac.uk>
> By author:    Anton Altaparmakov <aia21@cam.ac.uk>
> In newsgroup: linux.dev.kernel
> >
> > Hi Andi, Andrew, Linus,
> >
> > x86_64 has incorrect include/asm-x86_64/bitops.h::ffs() implementation.
> > It uses "g" instead of "rm" in the insline assembled bsfl instruction.
> > (This was spotted by Yuri Per.)
> >
> > bsfl does not accept constant values but only memory ones.  On i386 the
> > correct "rm" is used.
> >
> > This causes NTFS build to fail as gcc optimizes a variable into a
> > constant and ffs() then fails to assemble.
> >
>
> Of course, this is a good reason to do a __builtin_constant_p()
> wrapper that gcc can optimize:
>
> static __inline__ __attribute_const__ int ffs(int x)
> {
> 	if ( __builtin_constant_p(x) ) {
> 		unsigned int y = (unsigned int)x;
> 		if ( y >= 0x80000000 )
> 			return 32;
> 		else if ( y >= 0x40000000 )
> 			return 31;
> 		else if /* ... you get the idea ... */

If you are going to play with that why not just use generic_ffs() instead
of doing it by hand?

Best regards,

	Anton

> 	} else {
> 		__asm__("bsfl %1,%0\n\t"
> 			"cmovzl %2,%0"
> 			: "=r" (r) : "rm" (x), "r" (-1));
> 		return r+1;
> 	}
> }

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
