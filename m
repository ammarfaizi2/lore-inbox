Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262533AbSJBS21>; Wed, 2 Oct 2002 14:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262538AbSJBS21>; Wed, 2 Oct 2002 14:28:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:9431 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262533AbSJBS2Z>;
	Wed, 2 Oct 2002 14:28:25 -0400
Subject: Re: [RFC] Simple NUMA scheduler patch
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200210021954.39358.efocht@ess.nec.de>
References: <Pine.LNX.4.44.0209050905180.8086-100000@localhost.localdomain>
	<1033516540.1209.144.camel@dyn9-47-17-164.beaverton.ibm.com> 
	<200210021954.39358.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Oct 2002 11:30:46 -0700
Message-Id: <1033583446.25427.28.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 10:54, Erich Focht wrote:

> With simple benchmarks you will most probably beat the plain O(1)
> scheduler on NUMA if you implement (a) in just 1. and 2. as your node
> is already somewhat "sticky". In complicated benchmarks (like a kernel
> compile ;-) it could already be too difficult to understand when the
> load balancer did what and why...
> 
> It would be nice to see some numbers.

Here are kernbench results with profiles and a brief analysis provided
by Martin Bligh:

2.5.38-mm1 + per-cpu hot pages
Elapsed: 19.798s User: 191.61s System: 43.322s CPU: 1186.4%

2.5.38-mm1 + per-cpu hot pages + sched
Elapsed: 19.528s User: 189.088s System: 40.488s CPU: 1175.6%

Much improved - user, system, and elapsed are all down.

Some diffs, only things over 50 change printed.

diffprofile nosched sched2

827 default_idle
294 .text.lock.file_table
138 get_empty_filp
124 __fput
97 do_softirq
80 schedule
70 strnlen_user
60 atomic_dec_and_lock
51 path_lookup
-54 __generic_copy_to_user
-55 find_get_page
-61 release_pages
-62 d_lookup
-66 do_wp_page
-75 __set_page_dirty_buffers
-86 file_read_actor
-88 pte_alloc_one
-94 free_percpu_page
-124 clear_page_tables
-160 vm_enough_memory
-224 page_remove_rmap
-253 zap_pte_range
-292 alloc_percpu_page
-940 do_anonymous_page
-967 __generic_copy_from_user
-1900 total

As you can see, all the VM operations take a diet, very cool.
(do_anonymous_page does all the page zeroing for new pages).
Head of new profile now looks like this:

83010 default_idle
5194 do_anonymous_page
4207 page_remove_rmap
2306 page_add_rmap
2226 d_lookup
1761 vm_enough_memory
1675 .text.lock.file_table
1480 file_read_actor
1254 get_empty_filp
1113 find_get_page
937 do_no_page
916 __generic_copy_from_user
875 atomic_dec_and_lock
764 do_page_fault
744 zap_pte_range
668 alloc_percpu_page
662 follow_mount
622 __fput
581 do_softirq
554 path_lookup
520 schedule

M.

> 
> Best regards,
> Erich
> 
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

