Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUDJOSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUDJOSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 10:18:14 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:59908 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262027AbUDJOSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 10:18:13 -0400
Date: Sat, 10 Apr 2004 16:24:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Force build error on undefined symbols
Message-ID: <20040410142401.GA2439@mars.ravnborg.org>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040410131028.A4221@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410131028.A4221@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Therefore, I propose the following patch to detect undefined symbols
> in the final image and force an error if this is the case.
> 
> Comments?

Do we really want to do this for all architectures?
You could use something like the attached to restrict it to arm.

	Sam

--- v2.6/arch/arm/Makefile	2004-04-05 23:23:54.000000000 +0200
+++ mm4/arch/arm/Makefile	2004-04-10 16:21:29.000000000 +0200
@@ -140,14 +143,19 @@
 maketools: include/asm-arm/constants.h include/linux/version.h FORCE
 	$(Q)$(MAKE) $(build)=arch/arm/tools include/asm-arm/mach-types.h
 
+check-undefsyms = $(NM) $^ | egrep -q '^ +U ' && { echo "Link failed: undefined symbols found in $^:"; $(NM) $^ | egrep '^ +U '; rm -f $^; exit 1; } || : endef
+
 # Convert bzImage to zImage
 bzImage: vmlinux
+	$(check-undefsyms)
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/zImage
 
 zImage Image bootpImage uImage: vmlinux
+	$(check-undefsyms)
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 zinstall install: vmlinux
+	$(check-undefsyms)
 	$(Q)$(MAKE) $(build)=$(boot) $@
 
 CLEAN_FILES += include/asm-arm/constants.h* include/asm-arm/mach-types.h \
