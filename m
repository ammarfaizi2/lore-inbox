Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVG1TX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVG1TX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVG1TVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:21:16 -0400
Received: from fmr23.intel.com ([143.183.121.15]:34703 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262139AbVG1TUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:20:19 -0400
Message-Id: <200507281914.j6SJErg31398@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Keith Owens" <kaos@ocs.com.au>
Cc: <David.Mosberger@acm.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Add prefetch switch stack hook in scheduler function
Date: Thu, 28 Jul 2005 12:14:53 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWTVCwHLNP28pShTxOtWqeKd3BCagAUaoiw
In-Reply-To: <20050728090948.GA24222@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i.e. like the patch below. Boot-tested on x86. x86, x64 and ia64 have a 
> real kernel_stack() implementation, the other architectures all return 
> 'next'. (I've also cleaned up a couple of other things in the 
> prefetch-next area, see the changelog below.)
> 
> Ken, would this patch generate a sufficient amount of prefetching on 
> ia64?

Sorry, this is not enough.  Switch stack on ia64 is 528 bytes.  We need to
prefetch 5 lines.  It probably should use prefetch_range().  But on ia64,
prefetch_range stride L1_CACHE_BYTES, where I really want to stride L3 cache
line size.

We also want to prefetch switch stack for current task, since processor
state is saved onto the stack for outgoing process.  And that stack is
almost guaranteed to be cold because switch stack is created below current
stack pointer. 

Can we just go back to prefetch_stack() or prefetch_task() (or use plural
name) and let each arch decide what to do with it?

- Ken

