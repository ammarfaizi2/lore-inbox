Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWF2DXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWF2DXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 23:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWF2DXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 23:23:31 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:42152 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750836AbWF2DXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 23:23:30 -0400
Date: Thu, 29 Jun 2006 12:21:41 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] solve config broken: undefined reference to `online_page'
Cc: Andy Whitcroft <apw@shadowen.org>, Dave Hansen <haveblue@us.ibm.com>,
       Toralf Foerster <toralf.foerster@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <20060628110338.9B6A.Y-GOTO@jp.fujitsu.com>
References: <44A1204F.3070704@shadowen.org> <20060628110338.9B6A.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060629114417.2A02.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew-san.

I made a small patch for compile error of 2.6.17(.1).
If CONFIG_HIGHMEM is not set and CONFIG_MEMORY_HOTPLUG is set on i386
box, the trouble occurs. Its trouble report is here.
http://marc.theaimsgroup.com/?t=115104987100003&r=1&w=2

At first, I wanted to send stable kernel which is 2.6.17.x.
But, Documentation/stable_kernel_rules.txt says that config
broken trouble is not acceptable for it. So, I would like to send
this to 2.6.18-rcX.

Please apply.

Thanks.

-----

Memory hotplug code of i386 adds memory to only highmem.
So, if CONFIG_HIGHMEM is not set, CONFIG_MEMORY_HOTPLUG shouldn't be
set. Otherwise, it causes compile error.

In addition, many architecture can't use memory hotplug feature yet.
So, I introduce CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

---
 arch/i386/Kconfig    |    3 +++
 arch/ia64/Kconfig    |    3 +++
 arch/powerpc/Kconfig |    3 +++
 arch/x86_64/Kconfig  |    2 ++
 mm/Kconfig           |    2 +-
 5 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-2.6.17/mm/Kconfig
===================================================================
--- linux-2.6.17.orig/mm/Kconfig	2006-06-26 14:19:11.000000000 +0900
+++ linux-2.6.17/mm/Kconfig	2006-06-27 16:54:56.000000000 +0900
@@ -115,7 +115,7 @@ config SPARSEMEM_EXTREME
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
-	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
+	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND && ARCH_ENABLE_MEMORY_HOTPLUG
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
 	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND
Index: linux-2.6.17/arch/i386/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/i386/Kconfig	2006-06-21 15:05:17.000000000 +0900
+++ linux-2.6.17/arch/i386/Kconfig	2006-06-27 16:44:01.000000000 +0900
@@ -762,6 +762,9 @@ config HOTPLUG_CPU
 	  enable suspend on SMP systems. CPUs can be controlled through
 	  /sys/devices/system/cpu.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+	depends on HIGHMEM
 
 endmenu
 
Index: linux-2.6.17/arch/ia64/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/ia64/Kconfig	2006-06-21 15:05:18.000000000 +0900
+++ linux-2.6.17/arch/ia64/Kconfig	2006-06-27 16:52:51.000000000 +0900
@@ -270,6 +270,9 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config SCHED_SMT
 	bool "SMT scheduler support"
 	depends on SMP
Index: linux-2.6.17/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/powerpc/Kconfig	2006-06-21 15:05:29.000000000 +0900
+++ linux-2.6.17/arch/powerpc/Kconfig	2006-06-27 16:54:35.000000000 +0900
@@ -599,6 +599,9 @@ config HOTPLUG_CPU
 
 	  Say N if you are unsure.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
 	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
Index: linux-2.6.17/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.17.orig/arch/x86_64/Kconfig	2006-06-21 15:05:40.000000000 +0900
+++ linux-2.6.17/arch/x86_64/Kconfig	2006-06-27 16:55:41.000000000 +0900
@@ -369,6 +369,8 @@ config HOTPLUG_CPU
 		can be controlled through /sys/devices/system/cpu/cpu#.
 		Say N if you want to disable CPU hotplug.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
 
 config HPET_TIMER
 	bool

-- 
Yasunori Goto 


