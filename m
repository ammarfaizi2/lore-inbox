Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWINDke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWINDke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWINDke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:40:34 -0400
Received: from tomts43.bellnexxia.net ([209.226.175.110]:47276 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750864AbWINDkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:40:32 -0400
Date: Wed, 13 Sep 2006 23:40:30 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 1/11] LTTng-core 0.5.108 : build
Message-ID: <20060914034030.GB2194@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-31631-1158205230-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 23:38:29 up 22 days, 47 min,  6 users,  load average: 0.24, 0.16, 0.10
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-31631-1158205230-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

1- LTTng menu options and Makefiles
(do not enable blktrace for now : kernel/relay.o is disabled)
patch-2.6.17-lttng-core-0.5.108-build.diff


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-31631-1158205230-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-core-0.5.108-build.diff"

--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,9 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION =
+EXTRAVERSION =-lttng-0.5.108-core
 NAME=Crazed Snow-Weasel
+NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
@@ -518,7 +519,7 @@ export MODLIB
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ ltt/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -25,6 +25,10 @@ obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_KEXEC) += kexec.o
+obj-$(CONFIG_LTT) += ltt-base.o
+obj-$(CONFIG_LTT) += ltt-facilities.o
+obj-$(CONFIG_LTT_USERSPACE_GENERIC) += ltt-syscall.o
+obj-$(CONFIG_LTT_HEARTBEAT) += ltt-heartbeat.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_IKCONFIG) += configs.o
@@ -37,7 +41,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
-obj-$(CONFIG_RELAY) += relay.o
+#obj-$(CONFIG_RELAY) += relay.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
@@ -61,3 +65,4 @@ quiet_cmd_ikconfiggz = IKCFG   $@
 targets += config_data.h
 $(obj)/config_data.h: $(obj)/config_data.gz FORCE
 	$(call if_changed,ikconfiggz)
+
--- /dev/null
+++ b/ltt/Kconfig
@@ -0,0 +1,132 @@
+config LTT
+	bool "Linux Trace Toolkit Instrumentation Support"
+	select LTT_FACILITY_CORE
+	depends on EXPERIMENTAL
+	select LTT_HEARTBEAT if MIPS
+	select LTT_SYNTHETIC_TSC if MIPS
+	default n
+	help
+	  It is possible for the kernel to log important events to a trace
+	  facility. Doing so, enables the use of the generated traces in order
+	  to reconstruct the dynamic behavior of the kernel, and hence the
+	  whole system.
+
+	  The tracing process contains 4 parts :
+	      1) The logging of events by key parts of the kernel.
+	      2) The tracer that keeps the events in a data buffer (uses
+	         relayfs).
+	      3) A trace daemon that interacts with the tracer and is
+	         notified every time there is a certain quantity of data to
+	         read from the tracer.
+	      4) A trace event data decoder that reads the accumulated data
+	         and formats it in a human-readable format.
+
+	  If you say Y, the first component will be built into the kernel.
+
+	  For more information on kernel tracing, the trace daemon or the event
+	  decoder, please check the following address :
+	       http://www.opersys.com/ltt
+	  See also the experimental page of the project :
+	       http://ltt.polymtl.ca
+
+config LTT_TRACER
+	tristate "Linux Trace Toolkit Tracer"
+	depends on LTT
+	default y
+	help
+	  If you enable this option, the Linux Trace Toolkit Tracer will be
+	  either built in the kernel or as module.
+
+	  Critical parts of the kernel will call upon the kernel tracing
+	  function. The data is then recorded by the tracer if a trace daemon
+	  is running in user-space and has issued a "start" command.
+
+	  For more information on kernel tracing, the trace daemon or the event
+	  decoder, please check the following address :
+	       http://www.opersys.com/ltt
+	  See also the experimental page of the project :
+	       http://ltt.polymtl.ca
+
+config LTT_RELAY
+	tristate "Linux Trace Toolkit RelayFS Support"
+	select RELAY
+	depends on LTT
+	depends on LTT_TRACER
+	default y
+	help
+	  Support using relayfs to log the data obtained through LTT.
+
+	  If you don't have special hardware, you almost certainly want
+	  to say Y here.
+
+config LTT_ALIGNMENT
+	bool "Align Linux Trace Toolkit Traces"
+	depends on LTT
+	default y
+	help
+	  This option enables dynamic alignment of data in buffers. The
+	  alignment is made on the smallest size between architecture size
+	  and the size of the value to be written.
+
+	  Dynamically calculating the offset of the data has a performance cost,
+	  but it is more efficient on some architectures (especially 64 bits) to
+	  align data than to write it unaligned.
+
+config LTT_HEARTBEAT
+	bool "Activate Linux Trace Toolkit Heartbeat Timer"
+	depends on LTT
+	default n
+	help
+	  The Linux Trace Toolkit Heartbeat Timer fires at an interval small
+	  enough to guarantee that the 32 bits truncated TSC won't overflow
+	  between two timer execution.
+
+config LTT_HEARTBEAT_EVENT
+	bool "Write heartbeat event to shrink traces"
+	depends on LTT_HEARTBEAT
+	default y
+	help
+	  This option makes the heartbeat timer write an event in each tracefile
+	  at an interval that is one tenth of the time it takes to overflow 32
+	  bits at your CPU frequency.
+
+	  If this option is not enabled, 64 bits fields must be used in each
+	  event header to save the full TSC : it can make traces about 1/10
+	  bigger. It is suggested that you enable this option to make more
+	  compact traces.
+
+config LTT_SYNTHETIC_TSC
+	bool "Keep a synthetic cpu timestamp counter"
+	depends on LTT_HEARTBEAT
+	default n
+	help
+	  This option is only useful on archtecture lacking a 64 bits timestamp
+	  counter : it generates a "synthetic" 64 bits timestamp by updating
+	  the 32 MSB at each heartbeat atomically. See kernel/ltt-heartbeat.c
+	  for details.
+
+config LTT_USERSPACE_GENERIC
+	bool "Allow tracing from userspace"
+	depends on LTT
+	default y
+	help
+	  This options allows processes to trace through the ltt_trace_generic
+	  system call after they have registered their facilities with
+	  ltt_register_generic.
+
+config LTT_NETLINK_CONTROL
+	tristate "Linux Trace Toolkit Netlink Controller"
+	depends on LTT_TRACER
+	default m
+	help
+	  If you enable this option, the Linux Trace Toolkit Netlink Controller
+	  will be either built in the kernel of as module.
+
+config LTT_FACILITY_CORE
+	bool "Linux Trace Toolkit Core Facility"
+	depends on LTT
+	default y
+	help
+	  LTT core facility. Contains event definition for facility load/unload
+	  and heartbeat.
+
--- /dev/null
+++ b/ltt/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the LTT objects.
+#
+obj-$(CONFIG_LTT_FACILITY_CORE)		+= ltt-facility-loader-core.o
+
+obj-$(CONFIG_LTT_TRACER)		+= ltt-core.o
+obj-$(CONFIG_LTT_RELAY)			+= ltt-relay.o
+obj-$(CONFIG_LTT_NETLINK_CONTROL)	+= ltt-control.o
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1081,6 +1081,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "ltt/Kconfig"
+
 endmenu
 
 source "arch/i386/Kconfig.debug"
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1417,3 +1417,9 @@ source "arch/ppc/Kconfig.debug"
 source "security/Kconfig"
 
 source "crypto/Kconfig"
+
+menu "Instrumentation Support"
+
+source "ltt/Kconfig"
+
+endmenu
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1011,6 +1011,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "ltt/Kconfig"
+  
 endmenu
 
 source "arch/powerpc/Kconfig.debug"
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -871,6 +871,12 @@ source "fs/Kconfig"
 
 source "arch/arm/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "ltt/Kconfig"
+
+endmenu
+
 source "arch/arm/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1857,3 +1857,9 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+menu "Instrumentation Support"
+
+source "ltt/Kconfig"
+
+endmenu
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -611,6 +611,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "ltt/Kconfig"
+
 endmenu
 
 source "arch/x86_64/Kconfig.debug"

--=_Krystal-31631-1158205230-0001-2--
