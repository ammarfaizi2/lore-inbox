Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUCAP43 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 10:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbUCAP43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 10:56:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56210 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261347AbUCAP41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 10:56:27 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6.4-rc1 fix x86 early_printk and make it early
References: <m165dp9m2r.fsf@ebiederm.dsl.xmission.com>
	<20040301115813.6194f2fe.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Mar 2004 08:47:55 -0700
In-Reply-To: <20040301115813.6194f2fe.ak@suse.de>
Message-ID: <m1r7wc8t78.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On 29 Feb 2004 22:24:12 -0700
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> >   o That is problematic with PAE support, because there is a moment
> >     during paging_init() when the physical identity mappings do not
> >     work. 
> 
> Just don't printk in that moment then.
> 
> >   o Using raw physical addresses is in bad form, and doesn't always work.
> 
> On x86-64 it's that __pa() doesn't always work very early.
> 
> >   o I can't possibly see how Andrew's Changelog that using __pa
> >     is more friendly to the 4G/4G split is correct.  Unless someone
> >     was hard coding a virtual address previously.
> 
> Yes, it shouldn't make any difference for 4/4.
> 
> > The second hunk in early_printk.c redefines VGABASE as __va(0xb8000).
> > This is correct on both x86 and x86-64 so we don't need any more
> > special cases.  
> 
> Please don't do that on x86-64. On x86-64 there are two ways to reach this
> address and the previous one is available earlier.  Keep the current
> address for x86-64 please.

???  I checked the x86-64 early page tables and it does appear to work.
That is why I consolidated the change.  

In particular from arch/x86_64/head.S:

.org 0x1000
ENTRY(init_level4_pgt)
	.quad	0x0000000000102007		/* -> level3_ident_pgt */
	.fill	255,8,0
	.quad	0x000000000010a007
	.fill	254,8,0
	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
	.quad	0x0000000000103007		/* -> level3_kernel_pgt */

.org 0x3000
ENTRY(level3_kernel_pgt)
	.fill	510,8,0
	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
	.quad	0x0000000000105007		/* -> level2_kernel_pgt */
	.fill	1,8,0

.org 0xa000
ENTRY(level3_physmem_pgt)
	.quad	0x0000000000105007		/* -> level2_kernel_pgt (so that __va works even before pagetable_init) */

0x0000010000000000 is handled by the pointer: 0x000000000010a007
0xffffffff80000000 is handled by the pointer: 0x0000000000103007

And then they both point to: 0x0000000000103007 which is the physical mapping.

And of course there is the comment on the 0xa000 entry:
(so that __va works even before pagetable_init)

So I don't see how using __va() early in the code is incorrect.  I can
buy that __va() adds the wrong constant but that is another matter.

Eric
