Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVAaQQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVAaQQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVAaQQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:16:13 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:20060 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261250AbVAaQP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:15:56 -0500
Date: Mon, 31 Jan 2005 17:17:53 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050131161753.GA15674@mars.ravnborg.org>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124154326.A5541@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 03:43:26PM +0000, Russell King wrote:
> Sam,
> 
> Where did the hacks go which detect the silent failure of the ARM binutils?

They weant away because it caused lots of troubles with sparc and um.
Can you use this (untested patch) for arm?

	Sam

===== Makefile 1.85 vs edited =====
--- 1.85/arch/arm/Makefile	2004-10-24 00:50:16 +02:00
+++ edited/Makefile	2005-01-31 17:15:55 +01:00
@@ -181,10 +181,19 @@
 # Convert bzImage to zImage
 bzImage: zImage
 
-zImage Image xipImage bootpImage uImage: vmlinux
+# Check for undefined symbols. Broken arm binutils may leave symbols undefined
+.PHONY: check-vmlinux
+vmlinux: check-vmlinux
+	if [ "`$(NM) -u vmlinux`" != "" ]; then              \
+	echo "vmlinux: error: undefined symbol(s) found:";   \
+	$(NM) -u vmlinux;                                    \
+	exit 1;                                              \
+	fi
+ 
+zImage Image xipImage bootpImage uImage: check-vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 
-zinstall install: vmlinux
+zinstall install: check-vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@
 
 CLEAN_FILES += include/asm-arm/constants.h* include/asm-arm/mach-types.h \
