Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTIEBub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbTIEBub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:50:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:12467 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261711AbTIEBuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:50:21 -0400
Date: Thu, 4 Sep 2003 18:48:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: shemminger@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ikconfig - resolve rebuild permissions
Message-Id: <20030904184812.4226080a.rddunlap@osdl.org>
In-Reply-To: <20030904191353.GA10448@mars.ravnborg.org>
References: <20030904113133.3f950a51.shemminger@osdl.org>
	<20030904191353.GA10448@mars.ravnborg.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 21:13:53 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:

| On Thu, Sep 04, 2003 at 11:31:33AM -0700, Stephen Hemminger wrote:
| > This patch fixes it by removing the configs.o file when
| > needed.
| 
| A better approach would be to remove the need for compile.h from
| configs.c. See attached patch for the makefile change.
| It just took the relevant part from mk_compile and
| used it in the Makefile.
| Example only - I expect Randy to integrate it properly.

Steve, can you test this?  I don't have/see the problem.
Anyway, configs.c no longer uses compile.h with this patch,
so hopefully this will fix it.

Thanks for the patch, Sam.

This patch is against 2.6.0-test4-current of 2003-09-04 evening PST.

--
~Randy


patch_name:	no_compile_h.patch
patch_version:	2003-09-04.18:36:25
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	don't use compile.h in kernel/configs.c
product:	Linux
product_versions: 260-904
diffstat:	=
 kernel/Makefile  |    1 +
 kernel/configs.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-

diff -Naur ./kernel/Makefile~compile ./kernel/Makefile
--- ./kernel/Makefile~compile	2003-09-04 16:34:58.000000000 -0700
+++ ./kernel/Makefile	2003-09-04 18:23:07.000000000 -0700
@@ -20,6 +20,7 @@
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
+CFLAGS_configs.o = -DLINUX_COMPILER="$(shell $(CC) -v 2>&1 | tail -n 1)"
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Naur ./kernel/configs.c~compile ./kernel/configs.c
--- ./kernel/configs.c~compile	2003-09-04 16:34:58.000000000 -0700
+++ ./kernel/configs.c	2003-09-04 18:30:40.000000000 -0700
@@ -28,8 +28,8 @@
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/stringify.h>
 #include <linux/init.h>
-#include <linux/compile.h>
 #include <linux/version.h>
 #include <asm/uaccess.h>
 
@@ -81,7 +81,7 @@
 {
 	seq_printf(seq,
 		   "Kernel:    %s\nCompiler:  %s\nVersion_in_Makefile: %s\n",
-		   ikconfig_build_info, LINUX_COMPILER, UTS_RELEASE);
+		   ikconfig_build_info, __stringify(LINUX_COMPILER), UTS_RELEASE);
 	return 0;
 }
 
