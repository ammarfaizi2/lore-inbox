Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269032AbUJENgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbUJENgR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269028AbUJENgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:36:17 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:42404 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S269079AbUJENgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:36:00 -0400
Message-ID: <4162A359.8030701@sdl.hitachi.co.jp>
Date: Tue, 05 Oct 2004 22:36:25 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: akpm@osdl.org, riel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6]  vm-thrashing-control-tuning
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Token based thrashing control has a good effect in thrashing situation.
In current implementation, token timeout is a fixed value as SWAP_TOKEN_TIMEOUT. I think that administrators can improve thrashing behavior if the value can be changed.

This patch adds "swap_token_timeout" parameter in /proc/sys/vm.
The parameter means expired time of token. Unit of the value is HZ, and the default value is the same as current SWAP_TOKEN_TIMEOUT
(i.e. HZ * 300). The patch can be applied to both 2.6.9-rc2 and 2.6.9-rc3.

I tested the patch on an IA-32 4 way machine which has 4GB memory.
Based kernel was 2.6.9-rc1. I tested five swap_token_time_out values.
I created 256 workload generation processes on the machine. Each process
generated same workload: repeating random file writing and memory access
(Memory region is 18MB). I ran the processes for one hour and calculated
write throughput of workload processes. The result was following.

swap_token_time_out   Write throughput [MB/s]
-------------------   ----------------------
30,000,000            6.71
 3,000,000            8.26
   300,000 (DEFAULT)  7.90
    30,000            8.16
     3,000            7.43

As you can see, it may be possible to improve application performance
according to tune swap_token_time_out. Additionally, I think it is better to decrease default value. One reason is that the other values gained good performance. The other is that behavior of kernel may be unstable if swap_token_time_out is too long.

I am exploring tuning policy.

Any comments or suggestions?


Best regards,

Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.

----

Signed-off-by: Hideo Aoki <aoki@sdl.hitachi.co.jp>

diff -uprN linux-2.6.9-rc2/include/linux/swap.h linux-2.6.9-rc2-tbtc_tune/include/linux/swap.h
--- linux-2.6.9-rc2/include/linux/swap.h    2004-09-15 12:20:40.000000000 +0900
+++ linux-2.6.9-rc2-tbtc_tune/include/linux/swap.h    2004-09-28 15:12:33.000000000 +0900
@@ -230,6 +230,7 @@ extern spinlock_t swaplock;

/* linux/mm/thrash.c */
extern struct mm_struct * swap_token_mm;
+extern unsigned long swap_token_default_timeout;
extern void grab_swap_token(void);
extern void __put_swap_token(struct mm_struct *);

diff -uprN linux-2.6.9-rc2/include/linux/sysctl.h linux-2.6.9-rc2-tbtc_tune/include/linux/sysctl.h
--- linux-2.6.9-rc2/include/linux/sysctl.h    2004-09-15 12:20:40.000000000 +0900
+++ linux-2.6.9-rc2-tbtc_tune/include/linux/sysctl.h    2004-09-28 15:12:33.000000000 +0900
@@ -167,6 +167,7 @@ enum
    VM_HUGETLB_GROUP=25,    /* permitted hugetlb group */
    VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
    VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
+    VM_SWAP_TOKEN_TIMEOUT=28 /* default time for token time out */
};


diff -uprN linux-2.6.9-rc2/kernel/sysctl.c linux-2.6.9-rc2-tbtc_tune/kernel/sysctl.c
--- linux-2.6.9-rc2/kernel/sysctl.c    2004-09-15 12:20:41.000000000 +0900
+++ linux-2.6.9-rc2-tbtc_tune/kernel/sysctl.c    2004-09-28 15:12:33.000000000 +0900
@@ -800,6 +800,15 @@ static ctl_table vm_table[] = {
        .extra1        = &zero,
    },
#endif
+    {
+        .ctl_name    = VM_SWAP_TOKEN_TIMEOUT,
+        .procname    = "swap_token_timeout",
+        .data        = &swap_token_default_timeout,
+        .maxlen        = sizeof(swap_token_default_timeout),
+        .mode        = 0644,
+        .proc_handler    = &proc_dointvec,
+        .strategy    = &sysctl_intvec,
+    },
    { .ctl_name = 0 }
};

diff -uprN linux-2.6.9-rc2/mm/thrash.c linux-2.6.9-rc2-tbtc_tune/mm/thrash.c
--- linux-2.6.9-rc2/mm/thrash.c    2004-09-15 12:20:42.000000000 +0900
+++ linux-2.6.9-rc2-tbtc_tune/mm/thrash.c    2004-09-28 15:12:33.000000000 +0900
@@ -20,6 +20,8 @@ struct mm_struct * swap_token_mm = &init

#define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
#define SWAP_TOKEN_TIMEOUT (HZ * 300)
+unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
+

/*
 * Take the token away if the process had no page faults
@@ -75,10 +77,10 @@ void grab_swap_token(void)
        if ((reason = should_release_swap_token(mm))) {
            unsigned long eligible = jiffies;
            if (reason == SWAP_TOKEN_TIMED_OUT) {
-                eligible += SWAP_TOKEN_TIMEOUT;
+                eligible += swap_token_default_timeout;
            }
            mm->swap_token_time = eligible;
-            swap_token_timeout = jiffies + SWAP_TOKEN_TIMEOUT;
+            swap_token_timeout = jiffies + swap_token_default_timeout;
            swap_token_mm = current->mm;
        }
        spin_unlock(&swap_token_lock);


