Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUELVOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUELVOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUELVNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:13:37 -0400
Received: from ltgp.iram.es ([150.214.224.138]:38530 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S263750AbUELVMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:12:48 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 12 May 2004 23:11:24 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6-BK] x86_64 has buggy ffs() implementation
Message-ID: <20040512211124.GA6005@iram.es>
References: <1084369416.16624.53.camel@imp.csi.cam.ac.uk> <c7u1js$1h2$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7u1js$1h2$1@terminus.zytor.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 08:31:56PM +0000, H. Peter Anvin wrote:
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

Either I'm asleep or you are emulating bsrl, not bsfl. It
should rather be:

	if ( y & 0x00000001) return 1;
	if ( y & 0x00000002) return 2;
	if ( y & 0x00000004) return 3;
	...
	if ( y & 0x80000000) return 32;
	return 0;

No need for the else clauses either because of the return.
But maybe even __builtin_ffs(y) would work in this case.

	Gabriel
