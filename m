Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWF3COj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWF3COj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWF3COi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:14:38 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:40576 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751406AbWF3COi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:14:38 -0400
Date: Thu, 29 Jun 2006 19:14:07 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Dave Hansen <haveblue@us.ibm.com>,
       Toralf Foerster <toralf.foerster@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] solve config broken: undefined reference to `online_page'
Message-ID: <20060630021407.GC11977@sequoia.sous-sol.org>
References: <44A1204F.3070704@shadowen.org> <20060628110338.9B6A.Y-GOTO@jp.fujitsu.com> <20060629114417.2A02.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629114417.2A02.Y-GOTO@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Yasunori Goto (y-goto@jp.fujitsu.com) wrote:
> I made a small patch for compile error of 2.6.17(.1).
> If CONFIG_HIGHMEM is not set and CONFIG_MEMORY_HOTPLUG is set on i386
> box, the trouble occurs. Its trouble report is here.
> http://marc.theaimsgroup.com/?t=115104987100003&r=1&w=2
> 
> At first, I wanted to send stable kernel which is 2.6.17.x.
> But, Documentation/stable_kernel_rules.txt says that config
> broken trouble is not acceptable for it. So, I would like to send
> this to 2.6.18-rcX.

This is fine for stable.  It fixes a compile bug.  The
stable kernel rules are referring to features that are marked
broken (meaning 'depends on BROKEN') in Kconfig.  This patch didn't
quite apply to 2.6.17.2, so I fixed it up, could you double check
please?

thanks,
-chris

---
> From cc57637b0b015fb5d70dbbec740de516d33af07d Mon Sep 17 00:00:00 2001
From: Yasunori Goto <y-goto@jp.fujitsu.com>
Subject: solve config broken: undefined reference to `online_page'

Memory hotplug code of i386 adds memory to only highmem.  So, if
CONFIG_HIGHMEM is not set, CONFIG_MEMORY_HOTPLUG shouldn't be set.
Otherwise, it causes compile error.

In addition, many architecture can't use memory hotplug feature yet.  So, I
introduce CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/Kconfig    |    3 +++
 arch/ia64/Kconfig    |    3 +++
 arch/powerpc/Kconfig |    3 +++
 arch/x86_64/Kconfig  |    2 ++
 mm/Kconfig           |    2 +-
 5 files changed, 12 insertions(+), 1 deletions(-)

--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -794,6 +794,9 @@ config COMPAT_VDSO
 
 endmenu
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+	depends on HIGHMEM
 
 menu "Power management options (ACPI, APM)"
 	depends on !X86_VOYAGER
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index a56df7b..5faacbb 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -271,6 +271,9 @@ config HOTPLUG_CPU
 	  can be controlled through /sys/devices/system/cpu/cpu#.
 	  Say N if you want to disable CPU hotplug.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config SCHED_SMT
 	bool "SMT scheduler support"
 	depends on SMP
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e922a88..e2e9df3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -618,6 +618,9 @@ config HOTPLUG_CPU
 
 	  Say N if you are unsure.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
+
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
 	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index ccc4a7f..9103984 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -370,6 +370,8 @@ config HOTPLUG_CPU
 		can be controlled through /sys/devices/system/cpu/cpu#.
 		Say N if you want to disable CPU hotplug.
 
+config ARCH_ENABLE_MEMORY_HOTPLUG
+	def_bool y
 
 config HPET_TIMER
 	bool
diff --git a/mm/Kconfig b/mm/Kconfig
index e76c023..8391729 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -115,7 +115,7 @@ config SPARSEMEM_EXTREME
 # eventually, we can have this option just 'select SPARSEMEM'
 config MEMORY_HOTPLUG
 	bool "Allow for memory hot-add"
-	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
+	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND && ARCH_ENABLE_MEMORY_HOTPLUG
 	depends on (IA64 || X86 || PPC64)
 
 comment "Memory hotplug is currently incompatible with Software Suspend"
