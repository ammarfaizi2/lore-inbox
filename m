Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966236AbWKXWFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966236AbWKXWFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 17:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966256AbWKXWFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 17:05:06 -0500
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:26050 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966252AbWKXWFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 17:05:01 -0500
Date: Fri, 24 Nov 2006 17:04:58 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 16/16] LTTng 0.6.36 for 2.6.18 : Build
Message-ID: <20061124220458.GQ25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 17:04:15 up 93 days, 19:12,  3 users,  load average: 1.42, 1.04, 0.64
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Build (Makefile and Kconfig) for markers and LTTng.

patch16-2.6.18-lttng-core-0.6.36-build.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 18
-EXTRAVERSION =
+EXTRAVERSION =-lttng-0.6.36
 NAME=Avast! A bilge rat!
 
 # *DOCUMENTATION*
@@ -303,7 +303,8 @@ # Use LINUXINCLUDE when you must referen
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
                    $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
-		   -include include/linux/autoconf.h
+		   -include include/linux/autoconf.h \
+		   -include linux/marker.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
@@ -552,7 +553,7 @@ export mod_strip_cmd
 
 
 ifeq ($(KBUILD_EXTMOD),)
-core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/ ltt/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
--- /dev/null
+++ b/ltt/Kconfig
@@ -0,0 +1,123 @@
+config LTT
+	bool "Linux Trace Toolkit Instrumentation Support"
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
+	tristate "Linux Trace Toolkit Relay+DebugFS Support"
+	select RELAY
+	select DEBUG_FS
+	depends on LTT
+	depends on LTT_TRACER
+	default y
+	help
+	  Support using relay and debugfs to log the data obtained through LTT.
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
+	depends on LTT_TRACER
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
--- /dev/null
+++ b/ltt/Makefile
@@ -0,0 +1,12 @@
+#
+# Makefile for the LTT objects.
+#
+obj-$(CONFIG_LTT)			+= ltt-core.o
+obj-$(CONFIG_LTT)			+= ltt-facilities.o
+obj-$(CONFIG_LTT_USERSPACE_GENERIC)	+= ltt-syscall.o
+obj-$(CONFIG_LTT_HEARTBEAT)		+= ltt-heartbeat.o
+obj-$(CONFIG_LTT_TRACER)		+= ltt-tracer.o
+obj-$(CONFIG_LTT_RELAY)			+= ltt-relay.o
+obj-$(CONFIG_LTT_NETLINK_CONTROL)	+= ltt-control.o
+
+obj-$(CONFIG_LTT)			+= facilities/
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -630,6 +630,12 @@ source "fs/Kconfig"
 
 source "arch/alpha/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/alpha/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/cris/Kconfig
+++ b/arch/cris/Kconfig
@@ -183,6 +183,12 @@ source "sound/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/cris/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -349,6 +349,12 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/frv/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -197,6 +197,12 @@ endmenu
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/h8300/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -1138,6 +1138,11 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
+source "ltt/Kconfig"
+
 endmenu
 
 source "arch/i386/Kconfig.debug"
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -521,6 +521,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/ia64/Kconfig.debug"
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -386,6 +386,12 @@ source "fs/Kconfig"
 
 source "arch/m32r/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m32r/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -652,6 +652,12 @@ endmenu
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m68k/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/m68knommu/Kconfig
+++ b/arch/m68knommu/Kconfig
@@ -661,6 +661,12 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/m68knommu/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1416,8 +1416,20 @@ source "lib/Kconfig"
 
 source "arch/powerpc/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/ppc/Kconfig.debug"
 
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
@@ -1065,6 +1065,11 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
+source "ltt/Kconfig"
+  
 endmenu
 
 source "arch/powerpc/Kconfig.debug"
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -255,6 +255,12 @@ source "fs/Kconfig"
 
 source "arch/parisc/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/parisc/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -905,6 +905,14 @@ source "fs/Kconfig"
 
 source "arch/arm/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+source "ltt/Kconfig"
+
+endmenu
+
 source "arch/arm/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -232,6 +232,12 @@ source "drivers/misc/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/arm26/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2055,6 +2055,12 @@ source "fs/Kconfig"
 
 source "arch/mips/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/mips/Kconfig.debug"
 
 source "security/Kconfig"
@@ -2062,3 +2068,9 @@ source "security/Kconfig"
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
+
+menu "Instrumentation Support"
+
+source "ltt/Kconfig"
+
+endmenu
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -489,6 +489,12 @@ source "fs/Kconfig"
 
 source "arch/s390/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/s390/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/sh64/Kconfig
+++ b/arch/sh64/Kconfig
@@ -276,6 +276,12 @@ source "fs/Kconfig"
 
 source "arch/sh64/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/sh64/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -644,6 +644,12 @@ source "fs/Kconfig"
 
 source "arch/sh/oprofile/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/sh/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -427,6 +427,9 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
 endmenu
 
 source "arch/sparc64/Kconfig.debug"
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -289,6 +289,12 @@ endmenu
 
 source "fs/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/sparc/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -312,4 +312,10 @@ config INPUT
 	bool
 	default n
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/um/Kconfig.debug"
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -324,6 +324,12 @@ source "sound/Kconfig"
 
 source "drivers/usb/Kconfig"
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/v850/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -251,6 +251,12 @@ config EMBEDDED_RAMDISK_IMAGE
 	  provide one yourself.
 endmenu
 
+menu "Instrumentation Support"
+
+source "kernel/Kconfig.marker"
+
+endmenu
+
 source "arch/xtensa/Kconfig.debug"
 
 source "security/Kconfig"
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -650,6 +650,11 @@ config KPROBES
 	  a probepoint and specifies the callback.  Kprobes is useful
 	  for kernel debugging, non-intrusive instrumentation and testing.
 	  If in doubt, say "N".
+
+source "kernel/Kconfig.marker"
+
+source "ltt/Kconfig"
+
 endmenu
 
 source "arch/x86_64/Kconfig.debug"
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
