Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269237AbUJFMTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbUJFMTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269213AbUJFMTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:19:39 -0400
Received: from mail6.hitachi.co.jp ([133.145.228.41]:4094 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S269237AbUJFMTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:19:02 -0400
Message-ID: <4163E2C0.5050109@sdl.hitachi.co.jp>
Date: Wed, 06 Oct 2004 21:19:12 +0900
From: Hideo AOKI <aoki@sdl.hitachi.co.jp>
Organization: Systems Development Lab., Hitachi, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 2.6]  vm-thrashing-control-tuning
References: <2LXI2-3a5-21@gated-at.bofh.it> <m3ekkd46a8.fsf@averell.firstfloor.org>
In-Reply-To: <m3ekkd46a8.fsf@averell.firstfloor.org>
Content-Type: multipart/mixed;
 boundary="------------090903070807040505000004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090903070807040505000004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

> Hideo AOKI <aoki@sdl.hitachi.co.jp> writes:
> 
>>This patch adds "swap_token_timeout" parameter in /proc/sys/vm.
>>The parameter means expired time of token. Unit of the value is HZ, and the default value is the same as current SWAP_TOKEN_TIMEOUT
>>(i.e. HZ * 300). The patch can be applied to both 2.6.9-rc2 and 2.6.9-rc3.
> 
> Please don't export any sysctls as jiffies. The values of jiffies changes.
> Use s or ms instead. sysctl has convenience functions for this.

Andi,

Thank you very much for useful suggestion.
I changed unit of the parameter from jiffies to second.


Andrew,

I apologize for wasting for your time in last mail.
Attached patch is fixed the unit issue Andi noticed.
Additionally, the patch is fixed writespace issue.  

Best regards,
Hideo AOKI

Systems Development Laboratory, Hitachi, Ltd.


--------------090903070807040505000004
Content-Type: text/plain;
 name="vm-thrashing-control-tuning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-thrashing-control-tuning.patch"

 include/linux/swap.h   |    1 +
 include/linux/sysctl.h |    1 +
 kernel/sysctl.c        |    9 +++++++++
 mm/thrash.c            |    5 +++--
 4 files changed, 14 insertions(+), 2 deletions(-)

Signed-off-by: Hideo Aoki <aoki@sdl.hitachi.co.jp>

diff -uprN linux-2.6.9-rc3/include/linux/swap.h linux-2.6.9-rc3-vm-thrashing-control-tuning/include/linux/swap.h
--- linux-2.6.9-rc3/include/linux/swap.h	2004-09-30 15:01:04.000000000 +0900
+++ linux-2.6.9-rc3-vm-thrashing-control-tuning/include/linux/swap.h	2004-10-04 13:45:11.000000000 +0900
@@ -230,6 +230,7 @@ extern spinlock_t swaplock;
 
 /* linux/mm/thrash.c */
 extern struct mm_struct * swap_token_mm;
+extern unsigned long swap_token_default_timeout;
 extern void grab_swap_token(void);
 extern void __put_swap_token(struct mm_struct *);
 
diff -uprN linux-2.6.9-rc3/include/linux/sysctl.h linux-2.6.9-rc3-vm-thrashing-control-tuning/include/linux/sysctl.h
--- linux-2.6.9-rc3/include/linux/sysctl.h	2004-09-30 15:01:04.000000000 +0900
+++ linux-2.6.9-rc3-vm-thrashing-control-tuning/include/linux/sysctl.h	2004-10-04 13:45:11.000000000 +0900
@@ -167,6 +167,7 @@ enum
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
+	VM_SWAP_TOKEN_TIMEOUT=28 /* default time for token time out */
 };
 
 
diff -uprN linux-2.6.9-rc3/kernel/sysctl.c linux-2.6.9-rc3-vm-thrashing-control-tuning/kernel/sysctl.c
--- linux-2.6.9-rc3/kernel/sysctl.c	2004-09-30 15:01:05.000000000 +0900
+++ linux-2.6.9-rc3-vm-thrashing-control-tuning/kernel/sysctl.c	2004-10-06 17:39:48.000000000 +0900
@@ -800,6 +800,15 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 	},
 #endif
+	{
+		.ctl_name	= VM_SWAP_TOKEN_TIMEOUT,
+		.procname	= "swap_token_timeout",
+		.data		= &swap_token_default_timeout,
+		.maxlen		= sizeof(swap_token_default_timeout),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_jiffies,
+		.strategy	= &sysctl_jiffies,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -uprN linux-2.6.9-rc3/mm/thrash.c linux-2.6.9-rc3-vm-thrashing-control-tuning/mm/thrash.c
--- linux-2.6.9-rc3/mm/thrash.c	2004-09-30 15:01:06.000000000 +0900
+++ linux-2.6.9-rc3-vm-thrashing-control-tuning/mm/thrash.c	2004-10-06 18:53:10.000000000 +0900
@@ -20,6 +20,7 @@ struct mm_struct * swap_token_mm = &init
 
 #define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
 #define SWAP_TOKEN_TIMEOUT (HZ * 300)
+unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
 
 /*
  * Take the token away if the process had no page faults
@@ -75,10 +76,10 @@ void grab_swap_token(void)
 		if ((reason = should_release_swap_token(mm))) {
 			unsigned long eligible = jiffies;
 			if (reason == SWAP_TOKEN_TIMED_OUT) {
-				eligible += SWAP_TOKEN_TIMEOUT;
+				eligible += swap_token_default_timeout;
 			}
 			mm->swap_token_time = eligible;
-			swap_token_timeout = jiffies + SWAP_TOKEN_TIMEOUT;
+			swap_token_timeout = jiffies + swap_token_default_timeout;
 			swap_token_mm = current->mm;
 		}
 		spin_unlock(&swap_token_lock);

--------------090903070807040505000004--

