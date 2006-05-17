Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWEQIZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWEQIZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 04:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWEQIZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 04:25:19 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:61377 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932484AbWEQIZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 04:25:17 -0400
Date: Wed, 17 May 2006 04:20:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Segfault on the i386 enter instruction
To: Andi Kleen <ak@suse.de>
Cc: Tomasz Malesinski <tmal@mimuw.edu.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stas Sergeev <stsp@aknet.ru>, Denis Vlasenko <vda@ilport.com.ua>
Message-ID: <200605170423_MC3-1-C007-8857@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200605161132.18610.ak@suse.de>

On Tue, 16 May 2006 11:32:18 +0200, Andi Kleen wrote:

> On Tuesday 16 May 2006 04:29, Chuck Ebbert wrote:
> > In-Reply-To: <44676F42.7080907@aknet.ru>
> > 
> > On Sun, 14 May 2006 21:56:18 +0400, Stas Sergeev wrote:
> > 
> > > Andi Kleen wrote:
> > > > Handling it like you expect would require to disassemble 
> > > > the function in the page fault handler and it's probably not 
> > > > worth doing that for this weird case.
> > > Just wondering, is this case really that weird?
> > > In fact, the check against %esp that the kernel
> > > does, looks strange. I realize that it can catch a
> > > (very rare) user-space bug of accessing below %esp, but
> > > other than that it looks redundant (IMHO) and as soon as
> > > it triggers the false-positives, what is it really good for?
> > 
> > I can't get a SIGSEGV on any native i386 kernel, not even when
> > running on AMD64.  It only happens on native x86_64 kernels.
> 
> I reproduced the original SIGSEGV on several i386 kernels.

OK, I got SIGSEGV on a 2.6.9 i386 kernel in addition to ia32 mode on x86_64.
But it doesn't happen on any recent 2.6, even with "enter $65535,$0".
Digging, I found the stack vma is 22 pages (88k) on recent i386
kernels while it's only 8k on 2.6.9 and 12k in x86_64 ia32 emulation.
So you have to go deeper into the stack before you will hit this on
recent i386 kernels.
 
> > Intel says nothing about a write check.  Is that a mistake in the manual
> > or is that something only AMD64 does, and then only in long mode?
> 
> In 98+% of all cases when Intel and AMD documentation differ
> in subtle detail it's a documentation bug.

Yeah, that's why it's good to have both on hand.  But sometimes it can be
hard to tell which one is wrong. :)


BTW one easy way to fix this bug would be to enlarge the window for
access below the stack pointer to allow for the largest possible enter
instruction, i.e. "enter $65535,$31".  On x86_64 that would be 65536+256
instead of the current 128 bytes.

-- 
Chuck
"The x86 isn't all that complex -- it just doesn't make a lot of sense."
                                                        -- Mike Johnson
