Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUAPIfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 03:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUAPIfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 03:35:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:54462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265326AbUAPIfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 03:35:13 -0500
Date: Fri, 16 Jan 2004 00:35:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040116003520.3b55aa8e.akpm@osdl.org>
In-Reply-To: <m3n08o1erp.fsf@averell.firstfloor.org>
References: <1bpdu-5jP-35@gated-at.bofh.it>
	<1brIi-Y0-57@gated-at.bofh.it>
	<1bIf6-fh-21@gated-at.bofh.it>
	<1bRiA-4PD-19@gated-at.bofh.it>
	<1bRrZ-58C-9@gated-at.bofh.it>
	<1bSHD-Xz-21@gated-at.bofh.it>
	<1e2sZ-rG-19@gated-at.bofh.it>
	<1e3Ih-1V0-1@gated-at.bofh.it>
	<1e7Cd-4qD-5@gated-at.bofh.it>
	<1einZ-64E-11@gated-at.bofh.it>
	<1ekpM-87C-1@gated-at.bofh.it>
	<1euyS-Eb-19@gated-at.bofh.it>
	<1euSb-U8-3@gated-at.bofh.it>
	<m3n08o1erp.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > +void bitmap_complement(unsigned long *bitmap, int bits)
> > +{
> > +	int k;
> > +
> > +	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
> > +		bitmap[k] = ~bitmap[k];
> > +}
> > +EXPORT_SYMBOL(bitmap_complement);
> 
> I actually had to change that one in my NUMA API patchkit (which uses
> bitmap functions for its node maps), because gcc 3.2 miscompiled the
> loop.
>
> Please add something like that (looks silly, but makes a big 
> difference):
> 
>  static inline void bitmap_complement(unsigned long *bitmap, int bits)
>  {
>         int k;
> +       int max = BITS_TO_LONGS(bits);
>  
> -       for (k = 0; k < BITS_TO_LONGS(bits); ++k)
> +       for (k = 0; k < max; ++k)
>                 bitmap[k] = ~bitmap[k];

OK.  bitmap_and() and bitmap_or() were converted to this form a while back
because they too were hitting the bug.  On ia32.  It might no longer
happen now they're uninlined but whatever - you don't have to look
at the code and think "gee, I hope the compiler moves that arith out
of the loop".




