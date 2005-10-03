Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVJCElN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVJCElN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJCElN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:41:13 -0400
Received: from gold.veritas.com ([143.127.12.110]:59536 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932150AbVJCElN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:41:13 -0400
Date: Mon, 3 Oct 2005 05:40:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Christian Seiler <christian.seiler@selfhtml.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug at mm/rmap.c:493, Kernel 2.6.13.2
In-Reply-To: <4340108F.7030604@selfhtml.org>
Message-ID: <Pine.LNX.4.61.0510030532340.3832@goblin.wat.veritas.com>
References: <4340108F.7030604@selfhtml.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Oct 2005 04:41:12.0768 (UTC) FILETIME=[AEAFD400:01C5C7D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005, Christian Seiler wrote:
> 
> In the kernel log of a computer I'm administrating a strange message
> appeared stating there was a kernel bug in mm/rmap.c, line 493. I put
> together the kernel log message (including the stack trace), the kernel
> configuration, the output of lspci -v, lsmod, uname -a and gcc/ld
> -version here:
> 
> http://src.selfhtml.org/lkml/
> 
> Although the message says a reboot is needed, the server still seems to
> work after that message (login using SSH is possible, all services still
> respond normally). After a reboot the same message reappears inside the
> log after some time.
> 
> The distribution is Gentoo Linux, but the kernel is built from vanilla
> sources. The system is entirely 64bit - no 32bit libraries are
> installed. The server itself is a Sun Fire V20z with two Opteron 244, 2
> GiB of RAM and hardware RAID-1 with two U320 SCSI disks.

Please try Linus' patch at the bottom: on dual Opteron, our best guess
is that yours is a different manifestation of the same underlying issue.  
(I believe there's now a more finely targetted version of the patch in
-rc3, but this will do if it is your problem).  Please get back to me
if you find this doesn't fix it - thanks.

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
