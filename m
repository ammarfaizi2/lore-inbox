Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTIEKTA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 06:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTIEKTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 06:19:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26893 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262378AbTIEKS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 06:18:58 -0400
Date: Fri, 5 Sep 2003 11:18:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixes to allow ARM to build in Linus' tree
Message-ID: <20030905111854.E27623@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In addition to the MODULE_ALIAS_LDISC patch, the following changes to
generic code are needed to allow ARM to build in Linus' tree.

The first is to add PT_SINGLESTEP to ptrace.h so we do the right thing
when adding/removing breakpoint instructions into processes (see
arch/arm/kernel/{signal.c,ptrace.c} for usage.)

The second is needed because pmd_clear() needs to flush the pmd.
However, we can't include tlbflush.h into pgtable.h without causing
a circular dependency (tlbflush.h needs vm_area_struct and mm_struct
which are in mm.h, which needs pgtable.h.)  swapfile.c seems to be the
only file affected.

===== include/linux/ptrace.h 1.10 vs edited =====
--- 1.10/include/linux/ptrace.h	Fri Jun  6 07:36:40 2003
+++ edited/include/linux/ptrace.h	Fri Sep  5 00:18:59 2003
@@ -65,6 +65,7 @@
 #define PT_TRACE_EXIT	0x00000200
 
 #define PT_TRACE_MASK	0x000003f4
+#define PT_SINGLESTEP	0x80000000	/* single stepping (used on ARM) */
 
 #include <linux/compiler.h>		/* For unlikely.  */
 #include <linux/sched.h>		/* For struct task_struct.  */
===== mm/swapfile.c 1.83 vs edited =====
--- 1.83/mm/swapfile.c	Mon Sep  1 00:15:45 2003
+++ edited/mm/swapfile.c	Fri Sep  5 01:40:09 2003
@@ -25,6 +25,7 @@
 #include <linux/security.h>
 
 #include <asm/pgtable.h>
+#include <asm/tlbflush.h>
 #include <linux/swapops.h>
 
 spinlock_t swaplock = SPIN_LOCK_UNLOCKED;

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
