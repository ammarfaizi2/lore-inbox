Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264523AbTE1GaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 02:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264552AbTE1GaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 02:30:18 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:64013 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S264523AbTE1GaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 02:30:18 -0400
Date: Wed, 28 May 2003 01:43:27 -0500 (CDT)
Message-Id: <200305280643.h4S6hRQF028038@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [PATCH] fix oops on resume from apm bios initiated suspend
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pavel.

Didn't know if you caught this one, but it fixes it for me and others
who responded on the list.  

mm is NULL for kernel threads without their own context.  active_mm is
maintained the one we lazly switch from.

Without this patch, apm bios initiated suspend events (eg panel close) 
cause an oops on resume in the LDT restore, killing kapmd, which causes
further events to not be polled.

milton

===== arch/i386/kernel/suspend.c 1.16 vs edited =====
--- 1.16/arch/i386/kernel/suspend.c	Sat May 17 16:09:37 2003
+++ edited/arch/i386/kernel/suspend.c	Sat May 24 05:00:02 2003
@@ -114,7 +114,7 @@
         cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
-	load_LDT(&current->mm->context);	/* This does lldt */
+	load_LDT(&current->active_mm->context);	/* This does lldt */
 
 	/*
 	 * Now maybe reload the debug registers
