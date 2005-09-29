Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVI2Qch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVI2Qch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVI2Qch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:32:37 -0400
Received: from silver.veritas.com ([143.127.12.111]:18595 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932217AbVI2Qcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:32:36 -0400
Date: Thu, 29 Sep 2005 17:31:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Balazs Csak <bcsak@cfa.harvard.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c bug(?) in the 2.6.12 kernel
In-Reply-To: <20050929052413.42816b81.bcsak@cfa.harvard.edu>
Message-ID: <Pine.LNX.4.61.0509291724270.651@goblin.wat.veritas.com>
References: <20050929052413.42816b81.bcsak@cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 29 Sep 2005 16:32:35.0777 (UTC) FILETIME=[66172310:01C5C513]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Balazs Csak wrote:
> 
> I've got an oops on a dual Opteron machine that's running on 2.6.12.3
> kernel. Under heavy load the system hangs and we get this oops on the
> screen:
> ...
> <ffffffff8013477d>{printk+141} <ffffffff8012db83>{try_to_wake_up+915}
> <ffffffff8010e445>{error_exit+0} <ffffffff80170ec6>{page_remove_rmap+38}
> <ffffffff80168fde>{unmap_vmas+1342} <ffffffff8016ea63>{exit_mmap+163}
> <ffffffff801317a1>{mmput+49} <ffffffff80136432>{do_exit+338}
> <ffffffff80136f5f>{do_group_exit+239}
> <ffffffff8010da46>{system_call+126}
> 
> This problem has been described here, earlier:
> http://seclists.org/lists/linux-kernel/2005/May/6369.html
> 
> Our setup is: 2x Opteron 246, Tyan Thunder K8S MB, 3ware 9500-8,
> 4 G RAM, Fedora Core 3 x86_64, 2.6.12.3 kernel.
> 
> Memtest shows nothing special...
> Does anyone know something useful for this problem?

Please try Linus' patch at the bottom: our best guess now is that
yours is a different manifestation of the same underlying issue.  
Here's what Linus said on 20 Sep:

On Tue, 20 Sep 2005, Charles McCreary wrote:
>
> Another datapoint for this thread. The box spewing the bad pmds messages is a 
> dual opteron 246 on a TYAN S2885 Thunder K8W motherboard. Kernel is 
> 2.6.11.4-20a-smp.

This is quite possibly the result of an Opteron errata (tlb flush
filtering is broken on SMP) that we worked around as of 2.6.14-rc4.

So either just try 2.6.14-rc2, or try the appended patch (it has since 
been confirmed by many more people).

		Linus

---
diff-tree bc5e8fdfc622b03acf5ac974a1b8b26da6511c99 (from 61ffcafafb3d985e1ab8463be0187b421614775c)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Sat Sep 17 15:41:04 2005 -0700

    x86-64/smp: fix random SIGSEGV issues
    
    They seem to have been due to AMD errata 63/122; the fix is to disable
    TLB flush filtering in SMP configurations.
    
    Confirmed to fix the problem by Andrew Walrond <andrew@walrond.org>
    
    [ Let's see if we'll have a better fix eventually, this is the Q&D
      "let's get this fixed and out there" version ]
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -831,11 +831,26 @@ static void __init amd_detect_cmp(struct
 #endif
 }
 
+#define HWCR 0xc0010015
+
 static int __init init_amd(struct cpuinfo_x86 *c)
 {
 	int r;
 	int level;
 
+#ifdef CONFIG_SMP
+	unsigned long value;
+
+	// Disable TLB flush filter by setting HWCR.FFDIS:
+	// bit 6 of msr C001_0015
+	//
+	// Errata 63 for SH-B3 steppings
+	// Errata 122 for all(?) steppings
+	rdmsrl(HWCR, value);
+	value |= 1 << 6;
+	wrmsrl(HWCR, value);
+#endif
+
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
 	clear_bit(0*32+31, &c->x86_capability);
