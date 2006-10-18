Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWJRQVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWJRQVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWJRQVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:21:11 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:3335 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1751280AbWJRQVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:21:09 -0400
Date: Wed, 18 Oct 2006 12:20:57 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Jan Beulich <jbeulich@novell.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] Undeprecate the sysctl system call
In-Reply-To: <200610181508.54237.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610181214060.7303@lancer.cnet.absolutedigital.net>
References: <453519EE.76E4.0078.0@novell.com> <200610181441.51748.ak@suse.de>
 <1161176382.9363.35.camel@localhost.localdomain> <200610181508.54237.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Until something better comes along this'll get us back to the status quo.

@Andrew, this patch is a replacement for the one from yesterday.

From: Cal Peake <cp@absolutedigital.net>

Undeprecate the sysctl system call and default to always include it with
the option for embedded folks to exclude it.  Also, remove it's entry from
the feature removal file and fixup the comment in it's header file.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- ./include/linux/sysctl.h~orig	2006-10-18 11:55:23.000000000 -0400
+++ ./include/linux/sysctl.h	2006-10-18 12:10:12.000000000 -0400
@@ -6,10 +6,9 @@
  ****************************************************************
  ****************************************************************
  **
- **  The values in this file are exported to user space via 
+ **  The values in this file are exported to user space via
  **  the sysctl() binary interface.  However this interface
- **  is unstable and deprecated and will be removed in the future. 
- **  For a stable interface use /proc/sys.
+ **  is obsolete; instead use /proc/sys.
  **
  ****************************************************************
  ****************************************************************
--- ./init/Kconfig~orig	2006-10-17 17:54:09.000000000 -0400
+++ ./init/Kconfig	2006-10-17 18:49:36.000000000 -0400
@@ -303,20 +303,20 @@ config UID16
 
 config SYSCTL_SYSCALL
 	bool "Sysctl syscall support" if EMBEDDED
-	default n
+	default y
 	select SYSCTL
 	---help---
-	  Enable the deprecated sysctl system call.  sys_sysctl uses
-	  binary paths that have been found to be a major pain to maintain
-	  and use.  The interface in /proc/sys is now the primary and what
-	  everyone uses.
-
-	  Nothing has been using the binary sysctl interface for some
-	  time now so nothing should break if you disable sysctl syscall
-	  support, and your kernel will get marginally smaller.
+	  This option allows you to specify whether or not to build into
+	  your kernel support for the sysctl system call.  You can disable
+	  this if you are building a kernel for a system with limited
+	  resources (e.g. an embedded device) and your kernel image will
+	  shrink by a few kilobytes.
+
+	  NOTE: Disabling this option will cause a warning to be printed
+	        if a program attempts to use this system call.
 
-	  Unless you have an application that uses the sys_sysctl interface
- 	  you should probably say N here.
+	  If you are sure your userspace enviroment has no need for this
+	  system call you can say N here.
 
 config KALLSYMS
 	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
--- ./Documentation/feature-removal-schedule.txt~orig	2006-10-17 17:54:04.000000000 -0400
+++ ./Documentation/feature-removal-schedule.txt	2006-10-17 18:10:35.000000000 -0400
@@ -53,18 +53,6 @@ Who:	Mauro Carvalho Chehab <mchehab@brtu
 
 ---------------------------
 
-What:	sys_sysctl
-When:	January 2007
-Why:	The same information is available through /proc/sys and that is the
-	interface user space prefers to use. And there do not appear to be
-	any existing user in user space of sys_sysctl.  The additional
-	maintenance overhead of keeping a set of binary names gets
-	in the way of doing a good job of maintaining this interface.
-
-Who:	Eric Biederman <ebiederm@xmission.com>
-
----------------------------
-
 What:	PCMCIA control ioctl (needed for pcmcia-cs [cardmgr, cardctl])
 When:	November 2005
 Files:	drivers/pcmcia/: pcmcia_ioctl.c
