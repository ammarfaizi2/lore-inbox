Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267430AbSLLHPK>; Thu, 12 Dec 2002 02:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbSLLHPJ>; Thu, 12 Dec 2002 02:15:09 -0500
Received: from x101-201-249-dhcp.reshalls.umn.edu ([128.101.201.249]:1924 "EHLO
	arashi.yi.org") by vger.kernel.org with ESMTP id <S267430AbSLLHPI>;
	Thu, 12 Dec 2002 02:15:08 -0500
Date: Thu, 12 Dec 2002 01:21:01 -0600
From: Matt Reppert <arashi@arashi.yi.org>
To: wz6b@arrl.net
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: 2.5.50 Up and running but
Message-Id: <20021212012101.238ae459.arashi@arashi.yi.org>
In-Reply-To: <200212112259.10079.wz6b@arrl.net>
References: <200212112259.10079.wz6b@arrl.net>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002 22:59:10 -0800
Matt Young <wz6b@arrl.net> wrote:

> Boot couldn't find the module dependency file, even though I did make modules 
> and make modules_install

Yeah, the make rule for depmod got removed in one of the module merges. This
will put it back. (Untested, my init scripts run depmod so it's not a big deal
for me.) Rusty, am I being stupid or is this okay now that depmod works?

--- a/Makefile	Sun Nov 10 19:05:55 2002
+++ b/Makefile	Fri Nov  8 20:08:32 2002
@@ -157,7 +157,6 @@
 OBJDUMP		= $(CROSS_COMPILE)objdump
 AWK		= awk
 GENKSYMS	= /sbin/genksyms
+DEPMOD		= /sbin/depmod
 KALLSYMS	= /sbin/kallsyms
 PERL		= perl
 MODFLAGS	= -DMODULE
@@ -516,7 +515,7 @@
 #	Install modules
 
 .PHONY: modules_install
-modules_install: _modinst_ $(patsubst %, _modinst_%, $(SUBDIRS))
+modules_install: _modinst_ $(patsubst %, _modinst_%, $(SUBDIRS)) _modinst_post
 
 .PHONY: _modinst_
 _modinst_:
@@ -524,20 +523,6 @@
 	@rm -f $(MODLIB)/build
 	@mkdir -p $(MODLIB)/kernel
 	@ln -s $(TOPDIR) $(MODLIB)/build
+
+# If System.map exists, run depmod.  This deliberately does not have a
+# dependency on System.map since that would run the dependency tree on
+# vmlinux.  This depmod is only for convenience to give the initial
+# boot a modules.dep even before / is mounted read-write.  However the
+# boot script depmod is the master version.
+ifeq "$(strip $(INSTALL_MOD_PATH))" ""
+depmod_opts	:=
+else
+depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
+endif
+.PHONY: _modinst_post
+_modinst_post:
+	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
 .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
 $(patsubst %, _modinst_%, $(SUBDIRS)) :
.
 
> Also the make config did not select the right Intel processor 

???

> nor is there a mouse driver

What kind of mouse? What config option?

Matt
