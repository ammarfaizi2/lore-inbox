Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTJAI3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTJAI3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:29:24 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:59777
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261971AbTJAI3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:29:19 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: mrproper@ximian.com, linux-kernel@vger.kernel.org
Subject: [patch] Re: make install problems
Date: Wed, 1 Oct 2003 03:26:11 -0500
User-Agent: KMail/1.5
References: <1064927778.1575.0.camel@localhost.localdomain>
In-Reply-To: <1064927778.1575.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310010326.13187.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 September 2003 08:16, Kevin Breit wrote:
> Hey,
> 	I setup a test6 kernel without module support.  I did a make install
> and got:
>
> Kernel: arch/i386/boot/bzImage is ready
> sh /usr/src/linux-2.6.0-test6/arch/i386/boot/install.sh 2.6.0-test6
> arch/i386/boot/bzImage System.map ""
> /lib/modules/2.6.0-test6 is not a directory.
> mkinitrd failed
>
> How can I fix this?

Make modules_install before make install.

Here's a patch to do that automatically for i386 (untested).

The problem is that Red Hat 9's kernel install script tries to make an
initrd, which includes the modules directory, and barfs if it isn't there...

--- linux-old/Makefile	2003-10-01 02:52:49.000000000 -0500
+++ linux-2.6.0-test6/Makefile	2003-10-01 03:03:09.859448696 -0500
@@ -708,10 +708,7 @@
 modules modules_install: FORCE
 	@echo
 	@echo "The present kernel configuration has modules disabled."
-	@echo "Type 'make config' and enable loadable module support."
-	@echo "Then build a kernel with module support enabled."
-	@echo
-	@exit 1
+	mkdir -p $(MODLIB)  # Needed by some install scripts.
 
 endif # CONFIG_MODULES
 
--- linux-old/arch/i386/boot/Makefile	2003-10-01 02:52:40.000000000 -0500
+++ linux-2.6.0-test6/arch/i386/boot/Makefile	2003-10-01 02:54:49.000000000 -0500
@@ -98,5 +98,5 @@
 	cp System.map $(INSTALL_PATH)/
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
-install: $(BOOTIMAGE)
+install: $(BOOTIMAGE) modules_install
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"

