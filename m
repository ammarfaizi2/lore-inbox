Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVFWBtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVFWBtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVFWBrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:47:43 -0400
Received: from fmr22.intel.com ([143.183.121.14]:63687 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261967AbVFWBl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:41:57 -0400
Message-Id: <200506230141.j5N1fsg12336@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Variation in measure_migration_cost() with scheduler-cache-hot-autodetect.patch in -mm
Date: Wed, 22 Jun 2005 18:41:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcV3BY5OU4SZ2HHSTSS7JdsXnsIgaQAjTQdQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20050622071458.GA16042@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Wednesday, June 22, 2005 12:15 AM
> probably coloring effects, yes. Another reason could be that 
> touch_cache() touches 6 separate areas of memory, which combined with 
> the stack give a minimum of 7 hugepage TLBs. How many are there in these 
> Xeons? If there are say 4 of them then we could be trashing these TLB 
> entries. There are much more 4K TLBs. To reduce the number of TLBs
> utilized, could you change touch_cache() to do something like:
> 
>         unsigned long size = __size/sizeof(long), chunk1 = size/2;
>         unsigned long *cache = __cache;
>         int i;
> 
>         for (i = 0; i < size/4; i += 8) {
>                 switch (i % 4) {
>                         case 0: cache[i]++;
>                         case 1: cache[size-1-i]++;
>                         case 2: cache[chunk1-i]++;
>                         case 3: cache[chunk1+i]++;
>                 }
>         }
> 
> does this change the migration-cost values?

Yes it does.  On one processor, it goes down, but goes up on another.
So I'm not sure if I completely understand the behavior.

			vmalloc'ed	__get_free_pages
3.0GHz Xeon, 8MB	6.46ms	 7.05ms
3.4GHz Xeon, 2MB	0.93ms	 1.22ms
1.6GHz ia64, 9MB	9.72ms	10.06ms

What I'm really after though is to have the parameter close to an
experimentally determined optimal value.  So either algorithm with
__get_free_pages appears to be closer.


> Btw., how did you determine the value of the 'ideal' migration cost?
> Was this based on the database benchmark measurements?

Yes, it is based on my favorite "industry standard transaction processing
database" bench (I probably should use a shorter name like OLTP).

