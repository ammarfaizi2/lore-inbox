Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbTGIFCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 01:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbTGIFCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 01:02:02 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:31136 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265667AbTGIFB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 01:01:58 -0400
Subject: Re: [announce, patch] 4G/4G split on x86, 64 GB RAM (and more)
	support
From: Dave Hansen <haveblue@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0307082332450.17252-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1057727763.1615.3.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Jul 2003 22:16:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks very interesting.  A few concerns, though, some stylish.  Although
I know, if I had done something half as complex, it would look much
worse :) If you're still planning on doing cleanups I can wait, but
otherwise, I can send patches.

Have you looked at the impact on high interrupt load workloads?  I saw
you mention the per-syscall TLB overhead, but you only mentioned the
interrupt overhead in passing.  Doesn't this make it increasingly
important to coalesce interrupts, especially when you're running with
lots of user time?  Any particular workloads have you've tested this
on?  I can try to get a couple of large webserver benchmark runs in on
it, if you like.

It's a lot harder now to drop back to 4k stacks, because of the
hard-coded 2 page kmap sequences.  But those patches are out-of-tree, so
they're of relatively little consequence.  

It might be nice to some more abstraction of the size of the trampoline
window.  There's a stuff this:
        pgd[PTRS_PER_PGD-2] = swapper_pg_dir[PTRS_PER_PGD-2];
        pgd[PTRS_PER_PGD-1] = swapper_pg_dir[PTRS_PER_PGD-1];
Being clever, I think some of these can be the same as the generic code.
The sepmd and banana_split patches in -mjb demonstrate some relatively 
nice ways to do this.

There seems to be quite a bit of duplication of code in the new 
__kmap_atomic* functions.  __kmap_atomic_vaddr() could replace all of
the
duplicated 
        idx = type + KM_TYPE_NR*smp_processor_id();
        vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
lines.  Also, it might nice to combine __kmap_atomic{,_noflush}()

Are you hoping to get this integrated for 2.6, or will it be more of an 
add-on for 2.6 distro releases?
-- 
Dave Hansen
haveblue@us.ibm.com

