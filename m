Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993135AbWJUQ41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993135AbWJUQ41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993140AbWJUQzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:55:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:43932 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S2993135AbWJUQv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:29 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: jbeulich@novell.com, patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [8/19] x86: Use -maccumulate-outgoing-args
Message-Id: <20061021165128.23A8913C4D@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:28 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This avoids some problems with gcc 4.x and earlier generating
invalid unwind information. In 4.1 the option is default
when unwind information is enabled.

And it seems to generate smaller code too, so it's probably
a good thing on its own. With gcc 4.0:

i386:
4683198  902112  480868 6066178  5c9002 vmlinux (before)
4449895  902112  480868 5832875  5900ab vmlinux (after) 

x86-64:
4939761 1449584  648216 7037561  6b6279 vmlinux (before)
4854193 1449584  648216 6951993  6a1439 vmlinux (after) 

On 4.1 it shouldn't make much difference because it is 
default when unwind is enabled anyways.

Suggested by Michael Matz and Jan Beulich

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/Makefile   |    4 ++++
 arch/x86_64/Makefile |    4 ++++
 2 files changed, 8 insertions(+)

Index: linux/arch/i386/Makefile
===================================================================
--- linux.orig/arch/i386/Makefile
+++ linux/arch/i386/Makefile
@@ -42,6 +42,10 @@ cflags-$(CONFIG_REGPARM) += -mregparm=3
 # temporary until string.h is fixed
 cflags-y += -ffreestanding
 
+# this works around some issues with generating unwind tables in older gccs
+# newer gccs do it by default
+cflags-y += -maccumulate-outgoing-args
+
 # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
 # a lot more stack due to the lack of sharing of stacklots:
 CFLAGS				+= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo $(call cc-option,-fno-unit-at-a-time); fi ;)
Index: linux/arch/x86_64/Makefile
===================================================================
--- linux.orig/arch/x86_64/Makefile
+++ linux/arch/x86_64/Makefile
@@ -54,6 +54,10 @@ endif
 cflags-y += $(call cc-option,-funit-at-a-time)
 # prevent gcc from generating any FP code by mistake
 cflags-y += $(call cc-option,-mno-sse -mno-mmx -mno-sse2 -mno-3dnow,)
+# this works around some issues with generating unwind tables in older gccs
+# newer gccs do it by default
+cflags-y += -maccumulate-outgoing-args
+
 # do binutils support CFI?
 cflags-y += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
 AFLAGS += $(call as-instr,.cfi_startproc\n.cfi_endproc,-DCONFIG_AS_CFI=1,)
