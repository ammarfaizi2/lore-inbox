Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267366AbUGNK5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267366AbUGNK5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267369AbUGNK5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:57:34 -0400
Received: from holomorphy.com ([207.189.100.168]:11164 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267366AbUGNK5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:57:19 -0400
Date: Wed, 14 Jul 2004 03:57:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
Message-ID: <20040714105713.GP3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Osterlund <petero2@telia.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <m2fz82hq8c.fsf@telia.com> <20040708012005.6232a781.akpm@osdl.org> <40ED049B.2020406@yahoo.com.au> <Pine.LNX.4.58.0407081126360.3104@telia.com> <20040714052010.GE3411@holomorphy.com> <m2u0wayisp.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2u0wayisp.fsf@telia.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:
>> Probably not what will get merged, but does the following brutal hack
>> do anything for you?

On Wed, Jul 14, 2004 at 12:39:18PM +0200, Peter Osterlund wrote:
> Doesn't help. I added some printk's to your patch and got this:

Brilliant, about zero dirty. Okay, I'm desperate. Could you try running
this and see what it spews when the OOM kill happens?


-- wli

Index: for_akpm-2.6.8-rc1/mm/oom_kill.c
===================================================================
--- for_akpm-2.6.8-rc1.orig/mm/oom_kill.c	2004-07-11 10:34:39.000000000 -0700
+++ for_akpm-2.6.8-rc1/mm/oom_kill.c	2004-07-14 03:54:23.990164640 -0700
@@ -220,7 +220,7 @@
 /**
  * out_of_memory - is the system out of memory?
  */
-void out_of_memory(void)
+void out_of_memory(unsigned gfp_mask, int order)
 {
 	/*
 	 * oom_lock protects out_of_memory()'s static variables.
@@ -273,6 +273,10 @@
 
 	/* oom_kill() sleeps */
 	spin_unlock(&oom_lock);
+	printk("Out of memory: pid %d, comm %-13.13s, gfp 0x%u, order %d\n",
+		current->pid, current->comm, gfp_mask, order);
+	show_free_areas();
+	dump_stack();
 	oom_kill();
 	spin_lock(&oom_lock);
 
Index: for_akpm-2.6.8-rc1/mm/vmscan.c
===================================================================
--- for_akpm-2.6.8-rc1.orig/mm/vmscan.c	2004-07-13 22:18:04.193959000 -0700
+++ for_akpm-2.6.8-rc1/mm/vmscan.c	2004-07-14 03:53:31.422156192 -0700
@@ -942,7 +942,7 @@
 	}
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
 		if (!laptop_mode || sc.may_writepage)
-			out_of_memory();
+			out_of_memory(gfp_mask, order);
 		else {
 			sc.may_writepage = 1;
 			goto retry;
Index: for_akpm-2.6.8-rc1/include/linux/swap.h
===================================================================
--- for_akpm-2.6.8-rc1.orig/include/linux/swap.h	2004-07-13 22:57:05.104087536 -0700
+++ for_akpm-2.6.8-rc1/include/linux/swap.h	2004-07-14 03:53:09.308517976 -0700
@@ -148,7 +148,7 @@
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
 
 /* linux/mm/oom_kill.c */
-extern void out_of_memory(void);
+void out_of_memory(unsigned, int);
 
 /* linux/mm/memory.c */
 extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
