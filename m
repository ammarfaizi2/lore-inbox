Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVEPUnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVEPUnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVEPUnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:43:49 -0400
Received: from serv01.siteground.net ([70.85.91.68]:60076 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261852AbVEPUnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:43:39 -0400
Date: Mon, 16 May 2005 12:45:29 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: linux-kernel@vger.kernel.org
cc: shai@scalex86.org, akpm@osdl.org
Subject: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-ID: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the timer frequency selectable. The timer interrupt may cause bus
and memory contention in large NUMA systems since the interrupt occurs
on each processor HZ times per second.

Signed-off-by: Christoph Lameter <christoph@scale86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.11/arch/i386/Kconfig
===================================================================
--- linux-2.6.11.orig/arch/i386/Kconfig	2005-05-16 12:07:31.000000000 -0700
+++ linux-2.6.11/arch/i386/Kconfig	2005-05-16 12:39:48.000000000 -0700
@@ -939,6 +939,20 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config HZ
+	int "Frequency of the Timer Interrupt (1000 or 100)"
+	range 100 1000
+	default 1000
+	help
+	  Allows the configuration of the timer frequency. It is customary
+	  to have the timer interrupt run at 1000 HZ but 100 HZ may be more
+	  beneficial for servers and NUMA systems that do not need to have
+	  a fast response for user interaction and that may experience bus
+	  contention and cacheline bounces as a result of timer interrupts.
+	  Note that the timer interrupt occurs on each processor in an SMP
+	  environment leading to NR_CPUS * HZ number of timer interrupts
+	  per second.
+
 endmenu
 
 
Index: linux-2.6.11/include/asm-i386/param.h
===================================================================
--- linux-2.6.11.orig/include/asm-i386/param.h	2005-05-16 12:07:25.000000000 -0700
+++ linux-2.6.11/include/asm-i386/param.h	2005-05-16 12:09:04.000000000 -0700
@@ -2,7 +2,7 @@
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
 #endif
