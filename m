Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265661AbUHHPoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUHHPoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 11:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUHHPoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 11:44:24 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:12433 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265661AbUHHPoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 11:44:18 -0400
Date: Sun, 8 Aug 2004 17:46:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix kallsyms dependency
Message-ID: <20040808154610.GA18740@mars.ravnborg.org>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040808123230.B7589@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808123230.B7589@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 12:32:30PM +0100, Russell King wrote:
> Hi,
> 
> It appears that kallsyms data is not updated if the kallsyms program is
> changed.  The following patch adds an appropriate dependency.

Added, and implemented your suggestion in scripts/Makefile
with a few other CONFIG selections.

Btw. any specific reason to hack kallsyms? Just curious if something
shows up in this area.

Patch added for reference.

	Sam
	
===== Makefile 1.510 vs edited =====
--- 1.510/Makefile	2004-08-07 21:35:27 +02:00
+++ edited/Makefile	2004-08-08 17:26:49 +02:00
@@ -584,7 +584,7 @@
 .tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
 
-.tmp_kallsyms%.S: .tmp_vmlinux%
+.tmp_kallsyms%.S: .tmp_vmlinux% $(KALLSYMS)
 	$(call cmd,kallsyms)
 
 .tmp_vmlinux1: $(vmlinux-objs) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
===== scripts/Makefile 1.40 vs edited =====
--- 1.40/scripts/Makefile	2004-07-23 01:27:54 +02:00
+++ edited/scripts/Makefile	2004-08-08 17:31:59 +02:00
@@ -5,11 +5,14 @@
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml docs
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
-host-progs	:= conmakehash kallsyms pnmtologo bin2c
+host-progs-$(CONFIG_KALLSYMS) += kallsyms
+host-progs-$(CONFIG_LOGO)     += pnmtologo
+
+host-progs	:= $(host-progs-y) conmakehash bin2c
 always		:= $(host-progs)
 
-subdir-$(CONFIG_MODVERSIONS)	+= genksyms
-subdir-y	+= mod
+subdir-$(CONFIG_MODVERSIONS) += genksyms
+subdir-$(CONFIG_MODULES)     += mod
 
 # Let clean descend into subdirs
 subdir-	+= basic lxdialog kconfig package
