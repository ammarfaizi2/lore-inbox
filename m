Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUELUdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUELUdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUELUdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:33:04 -0400
Received: from hera.kernel.org ([63.209.29.2]:30341 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263167AbUELUdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:33:00 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [2.6.6-BK] x86_64 has buggy ffs() implementation
Date: Wed, 12 May 2004 20:31:56 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c7u1js$1h2$1@terminus.zytor.com>
References: <1084369416.16624.53.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1084393916 1571 127.0.0.1 (12 May 2004 20:31:56 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 12 May 2004 20:31:56 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1084369416.16624.53.camel@imp.csi.cam.ac.uk>
By author:    Anton Altaparmakov <aia21@cam.ac.uk>
In newsgroup: linux.dev.kernel
>
> Hi Andi, Andrew, Linus,
> 
> x86_64 has incorrect include/asm-x86_64/bitops.h::ffs() implementation. 
> It uses "g" instead of "rm" in the insline assembled bsfl instruction. 
> (This was spotted by Yuri Per.)
> 
> bsfl does not accept constant values but only memory ones.  On i386 the
> correct "rm" is used.
> 
> This causes NTFS build to fail as gcc optimizes a variable into a
> constant and ffs() then fails to assemble.
> 

Of course, this is a good reason to do a __builtin_constant_p()
wrapper that gcc can optimize:

static __inline__ __attribute_const__ int ffs(int x)
{  
	if ( __builtin_constant_p(x) ) {
		unsigned int y = (unsigned int)x;
		if ( y >= 0x80000000 )
			return 32;
		else if ( y >= 0x40000000 )
			return 31;
		else if /* ... you get the idea ... */
	} else {
		__asm__("bsfl %1,%0\n\t"
			"cmovzl %2,%0" 
			: "=r" (r) : "rm" (x), "r" (-1));
		return r+1;
	}
}

	-hpa
