Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWHPTYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWHPTYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWHPTYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:24:45 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:41192 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932178AbWHPTYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:24:44 -0400
Subject: Re: [patch 5/5] -fstack-protector feature: Enable the compiler
	flags in CFLAGS
From: Arjan van de Ven <arjan@linux.intel.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
In-Reply-To: <20060816185538.GE5852@mars.ravnborg.org>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org>
	 <1155747197.3023.73.camel@laptopd505.fenrus.org>
	 <20060816185538.GE5852@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 21:24:25 +0200
Message-Id: <1155756265.3023.133.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 20:55 +0200, Sam Ravnborg wrote:
> stack-protector = $(shell $(CONFIG_SHELL) \
> 
> $(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(1))
> cflags-$(CONFIG_CC_STACKPROTECTOR) += \
>                    $(call stack-protector, $(CC) -fstack-protector)
> cflags-$(CONFIG_CC_STACKPROTECTOR_ALL) += \
>                    $(call stack-protector, $(CC)
> -fstack-protector-all)

ok that works (I've tested it ;)

Subject: [patch 5/5] Add the -fstack-protector option to the CFLAGS
From: Arjan van de Ven <arjan@linux.intel.com>

Add a feature check that checks that the gcc compiler has stack-protector
support and has the bugfix for PR28281 to make this work in kernel mode.
The easiest solution I could find was to have a shell script in scripts/
to do the detection; if needed we can make this fancier in the future 
without making the makefile too complex.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
CC: Andi Kleen <ak@suse.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

---
 arch/x86_64/Makefile                      |    3 +++
 scripts/gcc-x86_64-has-stack-protector.sh |    8 ++++++++
 2 files changed, 11 insertions(+)

Index: linux-2.6.18-rc4-stackprot/arch/x86_64/Makefile
===================================================================
--- linux-2.6.18-rc4-stackprot.orig/arch/x86_64/Makefile
+++ linux-2.6.18-rc4-stackprot/arch/x86_64/Makefile
@@ -55,6 +55,15 @@ cflags-y += $(call cc-option,-funit-at-a
 # prevent gcc from generating any FP code by mistake
 cflags-y += $(call cc-option,-mno-sse -mno-mmx -mno-sse2 -mno-3dnow,)
 
+
+stack-protector = $(shell $(CONFIG_SHELL) \
+	$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(1))
+
+cflags-$(CONFIG_CC_STACKPROTECTOR) += \
+	$(call stack-protector, $(CC) -fstack-protector)
+cflags-$(CONFIG_CC_STACKPROTECTOR_ALL) += \
+	$(call stack-protector, $(CC) -fstack-protector-all)
+
 CFLAGS += $(cflags-y)
 CFLAGS_KERNEL += $(cflags-kernel-y)
 AFLAGS += -m64
Index: linux-2.6.18-rc4-stackprot/scripts/gcc-x86_64-has-stack-protector.sh
===================================================================
--- /dev/null
+++ linux-2.6.18-rc4-stackprot/scripts/gcc-x86_64-has-stack-protector.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+
+echo "int foo(void) { char X[200]; return 3; }" | $1 -S -xc -c -O0 -mcmodel=kernel -fstack-protector - -o - | grep -q "%gs"
+if [ "$?" -eq "0" ] ; then
+	echo $2
+fi

