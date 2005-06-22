Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVFVHv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVFVHv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVFVHuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:50:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:40082 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262837AbVFVHQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 03:16:01 -0400
Date: Wed, 22 Jun 2005 09:14:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Variation in measure_migration_cost() with scheduler-cache-hot-autodetect.patch in -mm
Message-ID: <20050622071458.GA16042@elte.hu>
References: <200506220319.j5M3JRg30716@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506220319.j5M3JRg30716@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> I'm consistently getting a smaller than expected cache migration cost 
> as measured by Ingo's scheduler-cache-hot-autodetect.patch currently 
> in -mm tree.  In this patch, the memory used to calibrate migration 
> cost is obtained by vmalloc call.  Would it make sense to use 
> __get_free_pages() instead?  I did the following experiments on a 
> variety of machines I have access to:
> 
> 				migration cost		migration cost
> 				with vmalloc mem		with __get_free_pages
> 3.0GHz Xeon, 8MB cache		6.23 ms		6.32 ms
> 3.4GHz Xeon, 2MB cache		1.62 ms		2.00 ms
> 1.6GHz Itanium2, 9MB		9.2 ms		10.2 ms
> 1.4GHz Itanium2, 4MB		4.2 ms		 4.4 ms
> 
> Why the discrepancy?  Possible cache coloring issue?

probably coloring effects, yes. Another reason could be that 
touch_cache() touches 6 separate areas of memory, which combined with 
the stack give a minimum of 7 hugepage TLBs. How many are there in these 
Xeons? If there are say 4 of them then we could be trashing these TLB 
entries. There are much more 4K TLBs. To reduce the number of TLBs
utilized, could you change touch_cache() to do something like:

        unsigned long size = __size/sizeof(long), chunk1 = size/2;
        unsigned long *cache = __cache;
        int i;

        for (i = 0; i < size/4; i += 8) {
                switch (i % 4) {
                        case 0: cache[i]++;
                        case 1: cache[size-1-i]++;
                        case 2: cache[chunk1-i]++;
                        case 3: cache[chunk1+i]++;
                }
        }

does this change the migration-cost values? Btw., how did you determine 
the value of the 'ideal' migration cost? Was this based on the database 
benchmark measurements?

There are a couple of reasons vmalloc() is better than gfp(): 1) it has 
no size limit in the measured range, and 2) it more accurately mimics 
migration costs of userspace apps, which typically have most of their 
cache-footprint in paged memory, not in hugepage memory.

	Ingo
