Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUDOVAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUDOVAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:00:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:62126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262744AbUDOU6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:58:43 -0400
Date: Thu, 15 Apr 2004 13:52:29 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: jgarzik@pobox.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH] Kconfig.debug family
Message-Id: <20040415135229.75964100.rddunlap@osdl.org>
In-Reply-To: <20040414212539.GE1175@waste.org>
References: <407CEB91.1080503@pobox.com>
	<20040414005832.083de325.akpm@osdl.org>
	<20040414010240.0e9f4115.akpm@osdl.org>
	<407CF201.408@pobox.com>
	<20040414011653.22c690d9.akpm@osdl.org>
	<407CFFF9.5010500@pobox.com>
	<20040414212539.GE1175@waste.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 16:25:39 -0500 Matt Mackall wrote:

| Sticking this in arch/*/Kconfig seems silly (as does much of the
| duplication in said files). Can we stick this and other debug bits
| under the kallsyms option in init/Kconfig instead? Or alternately move
| debugging bits into their own file that gets included as appropriate.


This patch:
- creates lib/Kconfig.debug for generic kernel debug options
- creates arch/*/Kconfig.debug for arch-specific debug options
- moves KALLSYMS to the generic kernel debug options list


This is a first cut for review/comments.  I will double-check
the generic options list to see how it needs to be corrected...

Applies to 2.6.6-rc1.
All arches have been tested by using 'make ARCH=foo {menu|x}config'.
However, ARCH=cris fails due to a missing file:
source "arch/cris/drivers/Kconfig".

--
~Randy


 arch/alpha/Kconfig.debug     |   54 ++++++++++++++
 arch/arm/Kconfig             |  159 -------------------------------------------
 arch/arm/Kconfig.debug       |  113 ++++++++++++++++++++++++++++++
 arch/arm26/Kconfig.debug     |   58 +++++++++++++++
 arch/cris/Kconfig.debug      |   15 ++++
 arch/h8300/Kconfig           |   71 -------------------
 arch/h8300/Kconfig.debug     |   67 ++++++++++++++++++
 arch/i386/Kconfig            |  124 ---------------------------------
 arch/i386/Kconfig.debug      |   15 ++++
 arch/ia64/Kconfig            |  113 ------------------------------
 arch/ia64/Kconfig.debug      |   63 +++++++++++++++++
 arch/m68k/Kconfig.debug      |    9 ++
 arch/m68knommu/Kconfig       |   54 --------------
 arch/m68knommu/Kconfig.debug |   42 +++++++++++
 arch/mips/Kconfig.debug      |   67 ++++++++++++++++++
 arch/parisc/Kconfig.debug    |    5 +
 arch/ppc/Kconfig.debug       |   72 +++++++++++++++++++
 arch/ppc64/Kconfig           |   79 ---------------------
 arch/ppc64/Kconfig.debug     |   27 +++++++
 arch/s390/Kconfig.debug      |    5 +
 arch/sh/Kconfig.debug        |  111 ++++++++++++++++++++++++++++++
 arch/sparc/Kconfig.debug     |   13 +++
 arch/sparc64/Kconfig.debug   |   38 ++++++++++
 arch/um/Kconfig              |   59 ---------------
 arch/um/Kconfig.debug        |   35 +++++++++
 arch/v850/Kconfig.debug      |   10 ++
 arch/x86_64/Kconfig          |  100 ---------------------------
 arch/x86_64/Kconfig.debug    |   47 ++++++++++++
 init/Kconfig                 |    8 --
 lib/Kconfig.debug            |  151 ++++++++++++++++++++++++++++++++++++++++
 30 files changed, 1033 insertions(+), 751 deletions(-)


diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/alpha/Kconfig.debug linux-266-rc1-kdebug/arch/alpha/Kconfig.debug
--- linux-266-rc1-pv/arch/alpha/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/alpha/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,54 @@
+
+menu "Alpha kernel hacking"
+
+config ALPHA_LEGACY_START_ADDRESS
+	bool "Legacy kernel start address"
+	depends on ALPHA_GENERIC
+	default n
+	---help---
+	  The 2.4 kernel changed the kernel start address from 0x310000
+	  to 0x810000 to make room for the Wildfire's larger SRM console.
+	  Recent consoles on Titan and Marvel machines also require the
+	  extra room.
+
+	  If you're using aboot 0.7 or later, the bootloader will examine the
+	  ELF headers to determine where to transfer control. Unfortunately,
+	  most older bootloaders -- APB or MILO -- hardcoded the kernel start
+	  address rather than examining the ELF headers, and the result is a
+	  hard lockup.
+
+	  Say Y if you have a broken bootloader.  Say N if you do not, or if
+	  you wish to run on Wildfire, Titan, or Marvel.
+
+config ALPHA_LEGACY_START_ADDRESS
+	bool
+	depends on !ALPHA_GENERIC && !ALPHA_TITAN && !ALPHA_MARVEL && !ALPHA_WILDFIRE
+	default y
+
+config MATHEMU
+	tristate "Kernel FP software completion" if DEBUG_KERNEL
+	default y if !DEBUG_KERNEL
+	help
+	  This option is required for IEEE compliant floating point arithmetic
+	  on the Alpha. The only time you would ever not say Y is to say M in
+	  order to debug the code. Say Y unless you know what you are doing.
+
+config DEBUG_RWLOCK
+	bool "Read-write spinlock debugging"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here then read-write lock processing will count how many
+	  times it has tried to get the lock and issue an error message after
+	  too many attempts.  If you suspect a rwlock problem or a kernel
+	  hacker asks for this option then say Y.  Otherwise say N.
+
+config DEBUG_SEMAPHORE
+	bool "Semaphore debugging"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here then semaphore processing will issue lots of
+	  verbose debugging messages.  If you suspect a semaphore problem or a
+	  kernel hacker asks for this option then say Y.  Otherwise say N.
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/arm/Kconfig linux-266-rc1-kdebug/arch/arm/Kconfig
--- linux-266-rc1-pv/arch/arm/Kconfig	2004-04-15 14:00:10.000000000 -0700
+++ linux-266-rc1-kdebug/arch/arm/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -621,164 +621,9 @@ source "drivers/misc/Kconfig"
 
 source "drivers/usb/Kconfig"
 
-
 menu "Kernel hacking"
-
-# RMK wants arm kernels compiled with frame pointers so hardwire this to y.
-# If you know what you are doing and are willing to live without stack
-# traces, you can get a slightly smaller kernel by setting this option to
-# n, but then RMK will have to kill you ;).
-config FRAME_POINTER
-	bool
-	default y
-	help
-	  If you say N here, the resulting kernel will be slightly smaller and
-	  faster. However, when a problem occurs with the kernel, the
-	  information that is reported is severely limited. Most people
-	  should say Y here.
-
-config DEBUG_USER
-	bool "Verbose user fault messages"
-	help
-	  When a user program crashes due to an exception, the kernel can
-	  print a brief message explaining what the problem was. This is
-	  sometimes helpful for debugging but serves no purpose on a
-	  production system. Most people should say N here.
-
-	  In addition, you need to pass user_debug=N on the kernel command
-	  line to enable this feature.  N consists of the sum of:
-
-	      1 - undefined instruction events
-	      2 - system calls
-	      4 - invalid data aborts
-	      8 - SIGSEGV faults
-	     16 - SIGBUS faults
-
-config DEBUG_INFO
-	bool "Include GDB debugging information in kernel binary"
-	help
-	  Say Y here to include source-level debugging information in the
-	  `vmlinux' binary image. This is handy if you want to use gdb or
-	  addr2line to debug the kernel. It has no impact on the in-memory
-	  footprint of the running kernel but it can increase the amount of
-	  time and disk space needed for compilation of the kernel. If in
-	  doubt say N.
-
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). This is accomplished
-	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
-	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
-	  unless you really know what this hack does.
-
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
-config DEBUG_WAITQ
-	bool "Wait queue debugging"
-	depends on DEBUG_KERNEL
-
-config DEBUG_BUGVERBOSE
-	bool "Verbose BUG() reporting (adds 70K)"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to make BUG() panics output the file name and line number
-	  of the BUG call as well as the EIP and oops trace.  This aids
-	  debugging but costs about 70-100K of memory.
-
-config DEBUG_ERRORS
-	bool "Verbose kernel error messages"
-	depends on DEBUG_KERNEL
-	help
-	  This option controls verbose debugging information which can be
-	  printed when the kernel detects an internal error. This debugging
-	  information is useful to kernel hackers when tracking down problems,
-	  but mostly meaningless to other people. It's safe to say Y unless
-	  you are concerned with the code size or don't want to see these
-	  messages.
-
-# These options are only for real kernel hackers who want to get their hands dirty. 
-config DEBUG_LL
-	bool "Kernel low-level debugging functions"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to include definitions of printascii, printchar, printhex
-	  in the kernel.  This is helpful if you are debugging code that
-	  executes before the console is initialized.
-
-config DEBUG_ICEDCC
-	bool "Kernel low-level debugging via EmbeddedICE DCC channel"
-	depends on DEBUG_LL
-	help
-	  Say Y here if you want the debug print routines to direct their
-	  output to the EmbeddedICE macrocell's DCC channel using
-	  co-processor 14. This is known to work on the ARM9 style ICE
-	  channel.
-
-	  It does include a timeout to ensure that the system does not
-	  totally freeze when there is nothing connected to read.
-
-config DEBUG_DC21285_PORT
-	bool "Kernel low-level debugging messages via footbridge serial port"
-	depends on DEBUG_LL && FOOTBRIDGE
-	help
-	  Say Y here if you want the debug print routines to direct their
-	  output to the serial port in the DC21285 (Footbridge). Saying N
-	  will cause the debug messages to appear on the first 16550
-	  serial port.
-
-config DEBUG_CLPS711X_UART2
-	bool "Kernel low-level debugging messages via UART2"
-	depends on DEBUG_LL && ARCH_CLPS711X
-	help
-	  Say Y here if you want the debug print routines to direct their
-	  output to the second serial port on these devices.  Saying N will
-	  cause the debug messages to appear on the first serial port.
-
-config DEBUG_S3C2410_PORT
-	depends on DEBUG_LL && ARCH_S3C2410
-	bool "Kernel low-level debugging messages via S3C2410 UART"
-	help
-	  Say Y here if you want debug print routines to go to one of the
-	  S3C2410 internal UARTs. The chosen UART must have been configured
-	  before it is used.
-
-config DEBUG_S3C2410_UART
-	int
-	depends on DEBUG_LL && ARCH_S3C2410
-	default "0"
-	help
-	  Choice for UART for kernel low-level using S3C2410 UARTS,
-	  should be between zero and two. The port must have been
-	  initalised by the boot-loader before use.
-
+source "lib/Kconfig.debug"
+source "arch/arm/Kconfig.debug"
 endmenu
 
 source "security/Kconfig"
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/arm/Kconfig.debug linux-266-rc1-kdebug/arch/arm/Kconfig.debug
--- linux-266-rc1-pv/arch/arm/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/arm/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,113 @@
+
+menu "ARM kernel hacking"
+
+# RMK wants arm kernels compiled with frame pointers so hardwire this to y.
+# If you know what you are doing and are willing to live without stack
+# traces, you can get a slightly smaller kernel by setting this option to
+# n, but then RMK will have to kill you ;).
+config FRAME_POINTER
+	bool
+	default y
+	help
+	  If you say N here, the resulting kernel will be slightly smaller and
+	  faster. However, when a problem occurs with the kernel, the
+	  information that is reported is severely limited. Most people
+	  should say Y here.
+
+config DEBUG_USER
+	bool "Verbose user fault messages"
+	help
+	  When a user program crashes due to an exception, the kernel can
+	  print a brief message explaining what the problem was. This is
+	  sometimes helpful for debugging but serves no purpose on a
+	  production system. Most people should say N here.
+
+	  In addition, you need to pass user_debug=N on the kernel command
+	  line to enable this feature.  N consists of the sum of:
+
+	      1 - undefined instruction events
+	      2 - system calls
+	      4 - invalid data aborts
+	      8 - SIGSEGV faults
+	     16 - SIGBUS faults
+
+config DEBUG_WAITQ
+	bool "Wait queue debugging"
+	depends on DEBUG_KERNEL
+
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting (adds 70K)"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to make BUG() panics output the file name and line number
+	  of the BUG call as well as the EIP and oops trace.  This aids
+	  debugging but costs about 70-100K of memory.
+
+config DEBUG_ERRORS
+	bool "Verbose kernel error messages"
+	depends on DEBUG_KERNEL
+	help
+	  This option controls verbose debugging information which can be
+	  printed when the kernel detects an internal error. This debugging
+	  information is useful to kernel hackers when tracking down problems,
+	  but mostly meaningless to other people. It's safe to say Y unless
+	  you are concerned with the code size or don't want to see these
+	  messages.
+
+# These options are only for real kernel hackers who want to get their hands dirty. 
+config DEBUG_LL
+	bool "Kernel low-level debugging functions"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to include definitions of printascii, printchar, printhex
+	  in the kernel.  This is helpful if you are debugging code that
+	  executes before the console is initialized.
+
+config DEBUG_ICEDCC
+	bool "Kernel low-level debugging via EmbeddedICE DCC channel"
+	depends on DEBUG_LL
+	help
+	  Say Y here if you want the debug print routines to direct their
+	  output to the EmbeddedICE macrocell's DCC channel using
+	  co-processor 14. This is known to work on the ARM9 style ICE
+	  channel.
+
+	  It does include a timeout to ensure that the system does not
+	  totally freeze when there is nothing connected to read.
+
+config DEBUG_DC21285_PORT
+	bool "Kernel low-level debugging messages via footbridge serial port"
+	depends on DEBUG_LL && FOOTBRIDGE
+	help
+	  Say Y here if you want the debug print routines to direct their
+	  output to the serial port in the DC21285 (Footbridge). Saying N
+	  will cause the debug messages to appear on the first 16550
+	  serial port.
+
+config DEBUG_CLPS711X_UART2
+	bool "Kernel low-level debugging messages via UART2"
+	depends on DEBUG_LL && ARCH_CLPS711X
+	help
+	  Say Y here if you want the debug print routines to direct their
+	  output to the second serial port on these devices.  Saying N will
+	  cause the debug messages to appear on the first serial port.
+
+config DEBUG_S3C2410_PORT
+	depends on DEBUG_LL && ARCH_S3C2410
+	bool "Kernel low-level debugging messages via S3C2410 UART"
+	help
+	  Say Y here if you want debug print routines to go to one of the
+	  S3C2410 internal UARTs. The chosen UART must have been configured
+	  before it is used.
+
+config DEBUG_S3C2410_UART
+	int
+	depends on DEBUG_LL && ARCH_S3C2410
+	default "0"
+	help
+	  Choice for UART for kernel low-level using S3C2410 UARTS,
+	  should be between zero and two. The port must have been
+	  initalised by the boot-loader before use.
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/arm26/Kconfig.debug linux-266-rc1-kdebug/arch/arm26/Kconfig.debug
--- linux-266-rc1-pv/arch/arm26/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/arm26/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,58 @@
+
+menu "ARM26 kernel hacking"
+
+# RMK wants arm kernels compiled with frame pointers so hardwire this to y.
+# If you know what you are doing and are willing to live without stack
+# traces, you can get a slightly smaller kernel by setting this option to
+# n, but then RMK will have to kill you ;).
+config FRAME_POINTER
+	bool
+	default y
+	help
+	  If you say N here, the resulting kernel will be slightly smaller and
+	  faster. However, when a problem occurs with the kernel, the
+	  information that is reported is severely limited. Most people
+	  should say Y here.
+
+config DEBUG_USER
+	bool "Verbose user fault messages"
+	help
+	  When a user program crashes due to an exception, the kernel can
+	  print a brief message explaining what the problem was. This is
+	  sometimes helpful for debugging but serves no purpose on a
+	  production system. Most people should say N here.
+
+config DEBUG_WAITQ
+	bool "Wait queue debugging"
+	depends on DEBUG_KERNEL
+
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting (adds 70K)"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to make BUG() panics output the file name and line number
+	  of the BUG call as well as the EIP and oops trace.  This aids
+	  debugging but costs about 70-100K of memory.
+
+config DEBUG_ERRORS
+	bool "Verbose kernel error messages"
+	depends on DEBUG_KERNEL
+	help
+	  This option controls verbose debugging information which can be
+	  printed when the kernel detects an internal error. This debugging
+	  information is useful to kernel hackers when tracking down problems,
+	  but mostly meaningless to other people. It's safe to say Y unless
+	  you are concerned with the code size or don't want to see these
+	  messages.
+
+# These options are only for real kernel hackers who want to get their hands dirty. 
+config DEBUG_LL
+	bool "Kernel low-level debugging functions"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to include definitions of printascii, printchar, printhex
+	  in the kernel.  This is helpful if you are debugging code that
+	  executes before the console is initialized.
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/cris/Kconfig.debug linux-266-rc1-kdebug/arch/cris/Kconfig.debug
--- linux-266-rc1-pv/arch/cris/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/cris/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,15 @@
+
+menu "CRIS kernel hacking"
+
+#bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
+
+config PROFILE
+	bool "Kernel profiling support"
+
+config PROFILE_SHIFT
+	int "Profile shift count"
+	depends on PROFILE
+	default "2"
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/h8300/Kconfig linux-266-rc1-kdebug/arch/h8300/Kconfig
--- linux-266-rc1-pv/arch/h8300/Kconfig	2004-04-15 14:00:10.000000000 -0700
+++ linux-266-rc1-kdebug/arch/h8300/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -297,75 +297,8 @@ endmenu
 source "fs/Kconfig"
 
 menu "Kernel hacking"
-
-config FULLDEBUG
-	bool "Full Symbolic/Source Debugging support"
-	help
-	  Enable debugging symbols on kernel build.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	help
-	  Enables console device to interprent special characters as
-	  commands to dump state information.
-
-config HIGHPROFILE
-	bool "Use fast second timer for profiling"
-	help
-	  Use a fast secondary clock to produce profiling information.
-
-config NO_KERNEL_MSG
-	bool "Suppress Kernel BUG Messages"
-	help
-	  Do not output any debug BUG messages within the kernel.
-
-config GDB_MAGICPRINT
-	bool "Message Output for GDB MagicPrint service"
-	depends on (H8300H_SIM || H8S_SIM)
-	help
-	  kernel messages output useing MagicPrint service from GDB
-
-config SYSCALL_PRINT
-	bool "SystemCall trace print"
-	help
-	  outout history of systemcall
-
-config GDB_DEBUG
-   	bool "Use gdb stub"
-	depends on (!H8300H_SIM && !H8S_SIM)
-	help
-	  gdb stub exception support
-
-config CONFIG_SH_STANDARD_BIOS
-	bool "Use gdb protocol serial console"
-	depends on (!H8300H_SIM && H8S_SIM)
-	help
-	  serial console output using GDB protocol.
-	  Require eCos/RedBoot
-
-config DEFAULT_CMDLINE
-	bool "Use buildin commandline"
-	default n
-	help
-	  buildin kernel commandline enabled.
-
-config KERNEL_COMMAND
-	string "Buildin commmand string"
-	depends on DEFAULT_CMDLINE
-	help
-	  buildin kernel commandline strings.
-
-config BLKDEV_RESERVE
-	bool "BLKDEV Reserved Memory"
-	default n
-	help
-	  Reserved BLKDEV area.
-
-config CONFIG_BLKDEV_RESERVE_ADDRESS
-	hex 'start address'
-	depends on BLKDEV_RESERVE
-	help
-	  BLKDEV start address.
+source "lib/Kconfig.debug"
+source "arch/h8300/Kconfig.debug"
 endmenu
 
 source "security/Kconfig"
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/h8300/Kconfig.debug linux-266-rc1-kdebug/arch/h8300/Kconfig.debug
--- linux-266-rc1-pv/arch/h8300/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/h8300/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,67 @@
+
+menu "H8300 kernel hacking"
+
+config FULLDEBUG
+	bool "Full Symbolic/Source Debugging support"
+	help
+	  Enable debugging symbols on kernel build.
+
+config HIGHPROFILE
+	bool "Use fast second timer for profiling"
+	help
+	  Use a fast secondary clock to produce profiling information.
+
+config NO_KERNEL_MSG
+	bool "Suppress Kernel BUG Messages"
+	help
+	  Do not output any debug BUG messages within the kernel.
+
+config GDB_MAGICPRINT
+	bool "Message Output for GDB MagicPrint service"
+	depends on (H8300H_SIM || H8S_SIM)
+	help
+	  kernel messages output useing MagicPrint service from GDB
+
+config SYSCALL_PRINT
+	bool "SystemCall trace print"
+	help
+	  outout history of systemcall
+
+config GDB_DEBUG
+   	bool "Use gdb stub"
+	depends on (!H8300H_SIM && !H8S_SIM)
+	help
+	  gdb stub exception support
+
+config CONFIG_SH_STANDARD_BIOS
+	bool "Use gdb protocol serial console"
+	depends on (!H8300H_SIM && H8S_SIM)
+	help
+	  serial console output using GDB protocol.
+	  Require eCos/RedBoot
+
+config DEFAULT_CMDLINE
+	bool "Use buildin commandline"
+	default n
+	help
+	  buildin kernel commandline enabled.
+
+config KERNEL_COMMAND
+	string "Buildin commmand string"
+	depends on DEFAULT_CMDLINE
+	help
+	  buildin kernel commandline strings.
+
+config BLKDEV_RESERVE
+	bool "BLKDEV Reserved Memory"
+	default n
+	help
+	  Reserved BLKDEV area.
+
+config CONFIG_BLKDEV_RESERVE_ADDRESS
+	hex 'start address'
+	depends on BLKDEV_RESERVE
+	help
+	  BLKDEV start address.
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/i386/Kconfig linux-266-rc1-kdebug/arch/i386/Kconfig
--- linux-266-rc1-pv/arch/i386/Kconfig	2004-04-15 14:00:10.000000000 -0700
+++ linux-266-rc1-kdebug/arch/i386/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -1190,129 +1190,9 @@ source "fs/Kconfig"
 
 source "arch/i386/oprofile/Kconfig"
 
-
 menu "Kernel hacking"
-
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config EARLY_PRINTK
-	bool "Early printk" if EMBEDDED
-	default y
-	help
-	  Write kernel log output directly into the VGA buffer or to a serial
-	  port.
-
-	  This is useful for kernel debugging when your machine crashes very
-	  early before the console code is initialized. For normal operation
-	  it is not recommended because it looks ugly and doesn't cooperate
-	  with klogd/syslogd or the X server. You should normally N here,
-	  unless you want to debug such a crash.
-
-config DEBUG_STACKOVERFLOW
-	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
-
-config DEBUG_STACK_USAGE
-	bool "Stack utilization instrumentation"
-	depends on DEBUG_KERNEL
-	help
-	  Enables the display of the minimum amount of free stack which each
-	  task has ever had available in the sysrq-T and sysrq-P debug output.
-
-	  This option will slow down process creation somewhat.
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). This is accomplished
-	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
-	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
-	  unless you really know what this hack does.
-
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
-config DEBUG_PAGEALLOC
-	bool "Page alloc debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Unmap pages from the kernel linear mapping after free_pages().
-	  This results in a large slowdown, but helps to find certain types
-	  of memory corruptions.
-
-config DEBUG_HIGHMEM
-	bool "Highmem debugging"
-	depends on DEBUG_KERNEL && HIGHMEM
-	help
-	  This options enables addition error checking for high memory systems.
-	  Disable for production systems.
-
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-	  
-config DEBUG_SPINLOCK_SLEEP
-	bool "Sleep-inside-spinlock checking"
-	help
-	  If you say Y here, various routines which may sleep will become very
-	  noisy if they are called with a spinlock held.	
-
-config FRAME_POINTER
-	bool "Compile the kernel with frame pointers"
-	help
-	  If you say Y here the resulting kernel image will be slightly larger
-	  and slower, but it will give very useful debugging information.
-	  If you don't debug the kernel, you can say N, but we may not be able
-	  to solve problems without frame pointers.
-
-config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb"
-	help
-	  If you say Y here the kernel will use a 4Kb stacksize for the
-	  kernel stack attached to each process/thread. This facilitates
-	  running more threads on a system and also reduces the pressure
-	  on the VM subsystem for higher order allocations. This option
-	  will also use IRQ stacks to compensate for the reduced stackspace.
-
-config X86_FIND_SMP_CONFIG
-	bool
-	depends on X86_LOCAL_APIC || X86_VOYAGER
-	default y
-
-config X86_MPPARSE
-	bool
-	depends on X86_LOCAL_APIC && !X86_VISWS
-	default y
-
+source "lib/Kconfig.debug"
+source "arch/i386/Kconfig.debug"
 endmenu
 
 source "security/Kconfig"
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/i386/Kconfig.debug linux-266-rc1-kdebug/arch/i386/Kconfig.debug
--- linux-266-rc1-pv/arch/i386/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/i386/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,15 @@
+
+menu "X86 kernel hacking"
+
+config X86_FIND_SMP_CONFIG
+	bool
+	depends on X86_LOCAL_APIC || X86_VOYAGER
+	default y
+
+config X86_MPPARSE
+	bool
+	depends on X86_LOCAL_APIC && !X86_VISWS
+	default y
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/ia64/Kconfig linux-266-rc1-kdebug/arch/ia64/Kconfig
--- linux-266-rc1-pv/arch/ia64/Kconfig	2004-04-15 14:00:10.000000000 -0700
+++ linux-266-rc1-kdebug/arch/ia64/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -396,117 +396,8 @@ source "arch/ia64/hp/sim/Kconfig"
 source "arch/ia64/oprofile/Kconfig"
 
 menu "Kernel hacking"
-
-choice
-	prompt "Physical memory granularity"
-	default IA64_GRANULE_64MB
-
-config IA64_GRANULE_16MB
-	bool "16MB"
-	help
-	  IA-64 identity-mapped regions use a large page size called "granules".
-
-	  Select "16MB" for a small granule size.
-	  Select "64MB" for a large granule size.  This is the current default.
-
-config IA64_GRANULE_64MB
-	bool "64MB"
-	depends on !(IA64_GENERIC || IA64_HP_ZX1)
-
-endchoice
-
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config IA64_PRINT_HAZARDS
-	bool "Print possible IA-64 dependency violations to console"
-	depends on DEBUG_KERNEL
-	help
-	  Selecting this option prints more information for Illegal Dependency
-	  Faults, that is, for Read-after-Write (RAW), Write-after-Write (WAW),
-	  or Write-after-Read (WAR) violations.  This option is ignored if you
-	  are compiling for an Itanium A step processor
-	  (CONFIG_ITANIUM_ASTEP_SPECIFIC).  If you're unsure, select Y.
-
-config DISABLE_VHPT
-	bool "Disable VHPT"
-	depends on DEBUG_KERNEL
-	help
-	  The Virtual Hash Page Table (VHPT) enhances virtual address
-	  translation performance.  Normally you want the VHPT active but you
-	  can select this option to disable the VHPT for debugging.  If you're
-	  unsure, answer N.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). This is accomplished
-	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
-	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
-	  unless you really know what this hack does.
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
-config DEBUG_SPINLOCK_SLEEP
-	  bool "Sleep-inside-spinlock checking"
-	  help
-	    If you say Y here, various routines which may sleep will become very
-	    noisy if they are called with a spinlock held.
-
-config IA64_DEBUG_CMPXCHG
-	bool "Turn on compare-and-exchange bug checking (slow!)"
-	depends on DEBUG_KERNEL
-	help
-	  Selecting this option turns on bug checking for the IA-64
-	  compare-and-exchange instructions.  This is slow!  Itaniums
-	  from step B3 or later don't have this problem. If you're unsure,
-	  select N.
-
-config IA64_DEBUG_IRQ
-	bool "Turn on irq debug checks (slow!)"
-	depends on DEBUG_KERNEL
-	help
-	  Selecting this option turns on bug checking for the IA-64 irq_save
-	  and restore instructions.  It's useful for tracking down spinlock
-	  problems, but slow!  If you're unsure, select N.
-
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-
-config SYSVIPC_COMPAT
-	bool
-	depends on COMPAT && SYSVIPC
-	default y
+source "lib/Kconfig.debug"
+source "arch/ia64/Kconfig.debug"
 endmenu
 
 source "security/Kconfig"
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/ia64/Kconfig.debug linux-266-rc1-kdebug/arch/ia64/Kconfig.debug
--- linux-266-rc1-pv/arch/ia64/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/ia64/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,63 @@
+
+menu "IA64 kernel hacking"
+
+choice
+	prompt "Physical memory granularity"
+	default IA64_GRANULE_64MB
+
+config IA64_GRANULE_16MB
+	bool "16MB"
+	help
+	  IA-64 identity-mapped regions use a large page size called "granules".
+
+	  Select "16MB" for a small granule size.
+	  Select "64MB" for a large granule size.  This is the current default.
+
+config IA64_GRANULE_64MB
+	bool "64MB"
+	depends on !(IA64_GENERIC || IA64_HP_ZX1)
+
+endchoice
+
+config IA64_PRINT_HAZARDS
+	bool "Print possible IA-64 dependency violations to console"
+	depends on DEBUG_KERNEL
+	help
+	  Selecting this option prints more information for Illegal Dependency
+	  Faults, that is, for Read-after-Write (RAW), Write-after-Write (WAW),
+	  or Write-after-Read (WAR) violations.  This option is ignored if you
+	  are compiling for an Itanium A step processor
+	  (CONFIG_ITANIUM_ASTEP_SPECIFIC).  If you're unsure, select Y.
+
+config DISABLE_VHPT
+	bool "Disable VHPT"
+	depends on DEBUG_KERNEL
+	help
+	  The Virtual Hash Page Table (VHPT) enhances virtual address
+	  translation performance.  Normally you want the VHPT active but you
+	  can select this option to disable the VHPT for debugging.  If you're
+	  unsure, answer N.
+
+config IA64_DEBUG_CMPXCHG
+	bool "Turn on compare-and-exchange bug checking (slow!)"
+	depends on DEBUG_KERNEL
+	help
+	  Selecting this option turns on bug checking for the IA-64
+	  compare-and-exchange instructions.  This is slow!  Itaniums
+	  from step B3 or later don't have this problem. If you're unsure,
+	  select N.
+
+config IA64_DEBUG_IRQ
+	bool "Turn on irq debug checks (slow!)"
+	depends on DEBUG_KERNEL
+	help
+	  Selecting this option turns on bug checking for the IA-64 irq_save
+	  and restore instructions.  It's useful for tracking down spinlock
+	  problems, but slow!  If you're unsure, select N.
+
+config SYSVIPC_COMPAT
+	bool
+	depends on COMPAT && SYSVIPC
+	default y
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/m68k/Kconfig.debug linux-266-rc1-kdebug/arch/m68k/Kconfig.debug
--- linux-266-rc1-pv/arch/m68k/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/m68k/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,9 @@
+
+menu "M68K kernel hacking"
+
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting"
+	depends on DEBUG_KERNEL
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/m68knommu/Kconfig linux-266-rc1-kdebug/arch/m68knommu/Kconfig
--- linux-266-rc1-pv/arch/m68knommu/Kconfig	2004-04-15 14:00:10.000000000 -0700
+++ linux-266-rc1-kdebug/arch/m68knommu/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -512,58 +512,8 @@ source "drivers/Kconfig"
 source "fs/Kconfig"
 
 menu "Kernel hacking"
-
-config FULLDEBUG
-	bool "Full Symbolic/Source Debugging support"
-	help
-	  Enable debuging symbols on kernel build.
-
-config FRAME_POINTER
-	bool "Compile the kernel with frame pointers"
-	help
-	  If you say Y here the resulting kernel image will be slightly larger
-	  and slower, but it will give very useful debugging information.
-	  If you don't debug the kernel, you can say N, but we may not be able
-	  to solve problems without frame pointers.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	help
-	  Enables console device to interpret special characters as
-	  commands to dump state information.
-
-config HIGHPROFILE
-	bool "Use fast second timer for profiling"
-	depends on COLDFIRE
-	help
-	  Use a fast secondary clock to produce profiling information.
-
-config BOOTPARAM
-	bool 'Compiled-in Kernel Boot Parameter'
-
-config BOOTPARAM_STRING 
-	string 'Kernel Boot Parameter'
-	default 'console=ttyS0,19200'
-	depends on BOOTPARAM
-
-config DUMPTOFLASH
-	bool "Panic/Dump to FLASH"
-	depends on COLDFIRE
-	help
-	  Dump any panic of trap output into a flash memory segment
-	  for later analysis.
-
-config NO_KERNEL_MSG
-	bool "Suppress Kernel BUG Messages"
-	help
-	  Do not output any debug BUG messages within the kernel.
-
-config BDM_DISABLE
-	bool "Disable BDM signals"
-	depends on (EXPERIMENTAL && COLDFIRE)
-	help
-	  Disable the ColdFire CPU's BDM signals.
-
+source "lib/Kconfig.debug"
+source "arch/m68knommu/Kconfig.debug"
 endmenu
 
 source "security/Kconfig"
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/m68knommu/Kconfig.debug linux-266-rc1-kdebug/arch/m68knommu/Kconfig.debug
--- linux-266-rc1-pv/arch/m68knommu/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/m68knommu/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,42 @@
+
+menu "M68K-nommu kernel hacking"
+
+config FULLDEBUG
+	bool "Full Symbolic/Source Debugging support"
+	help
+	  Enable debuging symbols on kernel build.
+
+config HIGHPROFILE
+	bool "Use fast second timer for profiling"
+	depends on COLDFIRE
+	help
+	  Use a fast secondary clock to produce profiling information.
+
+config BOOTPARAM
+	bool 'Compiled-in Kernel Boot Parameter'
+
+config BOOTPARAM_STRING 
+	string 'Kernel Boot Parameter'
+	default 'console=ttyS0,19200'
+	depends on BOOTPARAM
+
+config DUMPTOFLASH
+	bool "Panic/Dump to FLASH"
+	depends on COLDFIRE
+	help
+	  Dump any panic of trap output into a flash memory segment
+	  for later analysis.
+
+config NO_KERNEL_MSG
+	bool "Suppress Kernel BUG Messages"
+	help
+	  Do not output any debug BUG messages within the kernel.
+
+config BDM_DISABLE
+	bool "Disable BDM signals"
+	depends on (EXPERIMENTAL && COLDFIRE)
+	help
+	  Disable the ColdFire CPU's BDM signals.
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/mips/Kconfig.debug linux-266-rc1-kdebug/arch/mips/Kconfig.debug
--- linux-266-rc1-pv/arch/mips/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/mips/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,67 @@
+
+menu "MIPS kernel hacking"
+
+config CROSSCOMPILE
+	bool "Are you using a crosscompiler"
+	help
+	  Say Y here if you are compiling the kernel on a different
+	  architecture than the one it is intended to run on.
+
+config CMDLINE
+	string "Default kernel command string"
+	default ""
+	help
+          On some platforms, there is currently no way for the boot loader to
+          pass arguments to the kernel. For these platforms, you can supply
+          some command-line options at build time by entering them here.  In
+          other cases you can specify kernel args so that you don't have
+	  to set them up in board prom initialization routines.
+
+config KGDB
+	bool "Remote GDB kernel debugging"
+	depends on DEBUG_KERNEL
+	select DEBUG_INFO
+	help
+	  If you say Y here, it will be possible to remotely debug the MIPS
+	  kernel using gdb. This enlarges your kernel image disk size by
+	  several megabytes and requires a machine with more than 16 MB,
+	  better 32 MB RAM to avoid excessive linking time. This is only
+	  useful for kernel hackers. If unsure, say N.
+
+config GDB_CONSOLE
+	bool "Console output to GDB"
+	depends on KGDB
+	help
+	  If you are using GDB for remote debugging over a serial port and
+	  would like kernel messages to be formatted into GDB $O packets so
+	  that GDB prints them as program output, say 'Y'.
+
+config SB1XXX_CORELIS
+	bool "Corelis Debugger"
+	depends on SIBYTE_SB1xxx_SOC && DEBUG_INFO
+	help
+	  Select compile flags that produce code that can be processed by the
+	  Corelis mksym utility and UDB Emulator.
+
+config RUNTIME_DEBUG
+	bool "Enable run-time debugging"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, some debugging macros will do run-time checking.
+	  If you say N here, those macros will mostly turn to no-ops.  See 
+	  include/asm-mips/debug.h for debuging macros.
+	  If unsure, say N.
+
+
+config MIPS_UNCACHED
+	bool "Run uncached"
+	depends on DEBUG_KERNEL && !SMP && !SGI_IP27
+	help
+	  If you say Y here there kernel will disable all CPU caches.  This will
+	  reduce the system's performance dramatically but can help finding
+	  otherwise hard to track bugs.  It can also useful if you're doing
+	  hardware debugging with a logic analyzer and need to see all traffic
+	  on the bus.
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/parisc/Kconfig.debug linux-266-rc1-kdebug/arch/parisc/Kconfig.debug
--- linux-266-rc1-pv/arch/parisc/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/parisc/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,5 @@
+
+menu "PA-RISC kernel hacking"
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/ppc/Kconfig.debug linux-266-rc1-kdebug/arch/ppc/Kconfig.debug
--- linux-266-rc1-pv/arch/ppc/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/ppc/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,72 @@
+
+menu "PPC kernel hacking"
+
+config KGDB
+	bool "Include kgdb kernel debugger"
+	depends on DEBUG_KERNEL
+	select DEBUG_INFO
+	help
+	  Include in-kernel hooks for kgdb, the Linux kernel source level
+	  debugger.  See <http://kgdb.sourceforge.net/> for more information.
+	  Unless you are intending to debug the kernel, say N here.
+
+choice
+	prompt "Serial Port"
+	depends on KGDB
+	default KGDB_TTYS1
+
+config KGDB_TTYS0
+	bool "ttyS0"
+
+config KGDB_TTYS1
+	bool "ttyS1"
+
+config KGDB_TTYS2
+	bool "ttyS2"
+
+config KGDB_TTYS3
+	bool "ttyS3"
+
+endchoice
+
+config KGDB_CONSOLE
+	bool "Enable serial console thru kgdb port"
+	depends on KGDB && 8xx || 8260
+	help
+	  If you enable this, all serial console messages will be sent
+	  over the gdb stub.
+	  If unsure, say N.
+
+config XMON
+	bool "Include xmon kernel debugger"
+	depends on DEBUG_KERNEL
+	help
+	  Include in-kernel hooks for the xmon kernel monitor/debugger.
+	  Unless you are intending to debug the kernel, say N here.
+
+config BDI_SWITCH
+	bool "Include BDI-2000 user context switcher"
+	depends on DEBUG_KERNEL
+	help
+	  Include in-kernel support for the Abatron BDI2000 debugger.
+	  Unless you are intending to debug the kernel with one of these
+	  machines, say N here.
+
+config BOOTX_TEXT
+	bool "Support for early boot text console (BootX or OpenFirmware only)"
+	depends PPC_OF
+	help
+	  Say Y here to see progress messages from the boot firmware in text
+	  mode. Requires either BootX or Open Firmware.
+
+config SERIAL_TEXT_DEBUG
+	bool "Support for early boot texts over serial port"
+	depends on 4xx || GT64260 || LOPEC || PPLUS || PRPMC800 || PPC_GEN550
+
+config OCP
+	bool
+	depends on IBM_OCP
+	default y
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/ppc64/Kconfig linux-266-rc1-kdebug/arch/ppc64/Kconfig
--- linux-266-rc1-pv/arch/ppc64/Kconfig	2004-04-15 14:00:10.000000000 -0700
+++ linux-266-rc1-kdebug/arch/ppc64/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -28,10 +28,6 @@ config HAVE_DEC_LOCK
 	bool
 	default y
 
-config EARLY_PRINTK
-	bool
-	default y
-
 config COMPAT
 	bool
 	default y
@@ -322,79 +318,8 @@ config VIOPATH
 source "arch/ppc64/oprofile/Kconfig"
 
 menu "Kernel hacking"
-
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config DEBUG_STACKOVERFLOW
-	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
-
-config DEBUG_STACK_USAGE
-	bool "Stack utilization instrumentation"
-	depends on DEBUG_KERNEL
-	help
-	  Enables the display of the minimum amount of free stack which each
-	  task has ever had available in the sysrq-T and sysrq-P debug output.
-
-	  This option will slow down process creation somewhat.
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). This is accomplished
-	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
-	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
-	  unless you really know what this hack does.
-
-config DEBUGGER
-	bool "Enable debugger hooks"
-	depends on DEBUG_KERNEL
-	help
-	  Include in-kernel hooks for kernel debuggers. Unless you are
-	  intending to debug the kernel, say N here.
-
-config XMON
-	bool "Include xmon kernel debugger"
-	depends on DEBUGGER
-	help
-	  Include in-kernel hooks for the xmon kernel monitor/debugger.
-	  Unless you are intending to debug the kernel, say N here.
-
-config XMON_DEFAULT
-	bool "Enable xmon by default"
-	depends on XMON
-
-config PPCDBG
-	bool "Include PPCDBG realtime debugging"
-	depends on DEBUG_KERNEL
-
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-	  
+source "lib/Kconfig.debug"
+source "arch/ppc64/Kconfig.debug"
 endmenu
 
 source "security/Kconfig"
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/ppc64/Kconfig.debug linux-266-rc1-kdebug/arch/ppc64/Kconfig.debug
--- linux-266-rc1-pv/arch/ppc64/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/ppc64/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,27 @@
+
+menu "PPC64 kernel hacking"
+
+config DEBUGGER
+	bool "Enable debugger hooks"
+	depends on DEBUG_KERNEL
+	help
+	  Include in-kernel hooks for kernel debuggers. Unless you are
+	  intending to debug the kernel, say N here.
+
+config XMON
+	bool "Include xmon kernel debugger"
+	depends on DEBUGGER
+	help
+	  Include in-kernel hooks for the xmon kernel monitor/debugger.
+	  Unless you are intending to debug the kernel, say N here.
+
+config XMON_DEFAULT
+	bool "Enable xmon by default"
+	depends on XMON
+
+config PPCDBG
+	bool "Include PPCDBG realtime debugging"
+	depends on DEBUG_KERNEL
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/s390/Kconfig.debug linux-266-rc1-kdebug/arch/s390/Kconfig.debug
--- linux-266-rc1-pv/arch/s390/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/s390/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,5 @@
+
+menu "S/390 kernel hacking"
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/sh/Kconfig.debug linux-266-rc1-kdebug/arch/sh/Kconfig.debug
--- linux-266-rc1-pv/arch/sh/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/sh/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,111 @@
+
+menu "SuperH kernel hacking"
+
+config SH_STANDARD_BIOS
+	bool "Use LinuxSH standard BIOS"
+	help
+	  Say Y here if your target has the gdb-sh-stub
+	  package from www.m17n.org (or any conforming standard LinuxSH BIOS)
+	  in FLASH or EPROM.  The kernel will use standard BIOS calls during
+	  boot for various housekeeping tasks (including calls to read and
+	  write characters to a system console, get a MAC address from an
+	  on-board Ethernet interface, and shut down the hardware).  Note this
+	  does not work with machines with an existing operating system in
+	  mask ROM and no flash (WindowsCE machines fall in this category).
+	  If unsure, say N.
+
+config SH_EARLY_PRINTK
+	bool "Early printk support"
+	depends on SH_STANDARD_BIOS
+	help
+	  Say Y here to redirect kernel printk messages to the serial port
+	  used by the SH-IPL bootloader, starting very early in the boot
+	  process and ending when the kernel's serial console is initialised.
+	  This option is only useful porting the kernel to a new machine,
+	  when the kernel may crash or hang before the serial console is
+	  initialised. If unsure, say N.
+
+config KGDB
+	bool "Include KGDB kernel debugger"
+	help
+	  Include in-kernel hooks for kgdb, the Linux kernel source level
+	  debugger.  See <http://kgdb.sourceforge.net/> for more information.
+	  Unless you are intending to debug the kernel, say N here.
+
+menu "KGDB configuration options"
+	depends on KGDB
+
+config MORE_COMPILE_OPTIONS
+	bool "Add any additional compile options"
+	help
+	  If you want to add additional CFLAGS to the kernel build, enable this
+	  option and then enter what you would like to add in the next question.
+	  Note however that -g is already appended with the selection of KGDB.
+
+config COMPILE_OPTIONS
+	string "Additional compile arguments"
+	depends on MORE_COMPILE_OPTIONS
+
+config KGDB_NMI
+	bool "Enter KGDB on NMI"
+	default n
+
+config KGDB_THREAD
+	bool "Include KGDB thread support"
+	default y
+
+config SH_KGDB_CONSOLE
+	bool "Console messages through GDB"
+	default n
+
+config KGDB_SYSRQ
+	bool "Allow SysRq 'G' to enter KGDB"
+	default y
+
+config KGDB_KERNEL_ASSERTS
+	bool "Include KGDB kernel assertions"
+	default n
+
+comment "Serial port setup"
+
+config KGDB_DEFPORT
+	int "Port number (ttySCn)"
+	default "1"
+
+config KGDB_DEFBAUD
+	int "Baud rate"
+	default "115200"
+
+choice
+	prompt "Parity"
+	depends on KGDB
+	default KGDB_DEFPARITY_N
+
+config KGDB_DEFPARITY_N
+	bool "None"
+
+config KGDB_DEFPARITY_E
+	bool "Even"
+
+config KGDB_DEFPARITY_O
+	bool "Odd"
+
+endchoice
+
+choice
+	prompt "Data bits"
+	depends on KGDB
+	default KGDB_DEFBITS_8
+
+config KGDB_DEFBITS_8
+	bool "8"
+
+config KGDB_DEFBITS_7
+	bool "7"
+
+endchoice
+
+endmenu
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/sparc/Kconfig.debug linux-266-rc1-kdebug/arch/sparc/Kconfig.debug
--- linux-266-rc1-pv/arch/sparc/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/sparc/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,13 @@
+
+menu "SPARC kernel hacking"
+
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting (adds 70K)"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to make BUG() panics output the file name and line number
+	  of the BUG call as well as the EIP and oops trace.  This aids
+	  debugging but costs about 70-100K of memory.
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/sparc64/Kconfig.debug linux-266-rc1-kdebug/arch/sparc64/Kconfig.debug
--- linux-266-rc1-pv/arch/sparc64/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/sparc64/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,38 @@
+
+menu "UltraSPARC kernel hacking"
+
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting (adds 70K)"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to make BUG() panics output the file name and line number
+	  of the BUG call as well as the EIP and oops trace.  This aids
+	  debugging but costs about 70-100K of memory.
+
+config DEBUG_DCFLUSH
+	bool "D-cache flush debugging"
+	depends on DEBUG_KERNEL
+
+config STACK_DEBUG
+	depends on DEBUG_KERNEL
+	bool "Stack Overflow Detection Support"
+
+config DEBUG_BOOTMEM
+	depends on DEBUG_KERNEL
+	bool "Debug BOOTMEM initialization"
+
+# We have a custom atomic_dec_and_lock() implementation but it's not
+# compatible with spinlock debugging so we need to fall back on
+# the generic version in that case.
+config HAVE_DEC_LOCK
+	bool
+	depends on SMP && !DEBUG_SPINLOCK
+	default y
+
+config MCOUNT
+	bool
+	depends on STACK_DEBUG
+	default y
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/um/Kconfig linux-266-rc1-kdebug/arch/um/Kconfig
--- linux-266-rc1-pv/arch/um/Kconfig	2004-04-15 14:00:11.000000000 -0700
+++ linux-266-rc1-kdebug/arch/um/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -102,10 +102,6 @@ config MCONSOLE
 
         It is safe to say 'Y' here.
 
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on MCONSOLE
-
 config HOST_2G_2G
 	bool "2G/2G host address space split"
 
@@ -213,59 +209,8 @@ source "drivers/md/Kconfig"
 
 source "drivers/mtd/Kconfig"
 
-
 menu "Kernel hacking"
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-
-config DEBUG_SPINLOCK
-	bool "Debug spinlocks usage"
-
-config DEBUG_INFO
-	bool "Enable kernel debugging symbols"
-	help
-        When this is enabled, the User-Mode Linux binary will include
-        debugging symbols.  This enlarges the binary by a few megabytes,
-        but aids in tracking down kernel problems in UML.  It is required
-        if you intend to do any kernel development.
-
-        If you're truly short on disk space or don't expect to report any
-        bugs back to the UML developers, say N, otherwise say Y.
-
-config FRAME_POINTER
-	bool
-	default y if DEBUG_INFO
-
-config PT_PROXY
-	bool "Enable ptrace proxy"
-	depends on XTERM_CHAN && DEBUG_INFO
-
-config GPROF
-	bool "Enable gprof support"
-	depends on DEBUG_INFO
-	help
-        This allows profiling of a User-Mode Linux kernel with the gprof
-        utility.
-
-        See <http://user-mode-linux.sourceforge.net/gprof.html> for more
-        details.
-
-        If you're involved in UML kernel development and want to use gprof,
-        say Y.  If you're unsure, say N.
-
-config GCOV
-	bool "Enable gcov support"
-	depends on DEBUG_INFO
-	help
-        This option allows developers to retrieve coverage data from a UML
-        session.
-
-        See <http://user-mode-linux.sourceforge.net/gprof.html> for more
-        details.
-
-        If you're involved in UML kernel development and want to use gcov,
-        say Y.  If you're unsure, say N.
-
+source "lib/Kconfig.debug"
+source "arch/um/Kconfig.debug"
 endmenu
 
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/um/Kconfig.debug linux-266-rc1-kdebug/arch/um/Kconfig.debug
--- linux-266-rc1-pv/arch/um/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/um/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,35 @@
+
+menu "UML kernel hacking"
+
+config PT_PROXY
+	bool "Enable ptrace proxy"
+	depends on XTERM_CHAN && DEBUG_INFO
+
+config GPROF
+	bool "Enable gprof support"
+	depends on DEBUG_INFO
+	help
+        This allows profiling of a User-Mode Linux kernel with the gprof
+        utility.
+
+        See <http://user-mode-linux.sourceforge.net/gprof.html> for more
+        details.
+
+        If you're involved in UML kernel development and want to use gprof,
+        say Y.  If you're unsure, say N.
+
+config GCOV
+	bool "Enable gcov support"
+	depends on DEBUG_INFO
+	help
+        This option allows developers to retrieve coverage data from a UML
+        session.
+
+        See <http://user-mode-linux.sourceforge.net/gprof.html> for more
+        details.
+
+        If you're involved in UML kernel development and want to use gcov,
+        say Y.  If you're unsure, say N.
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/v850/Kconfig.debug linux-266-rc1-kdebug/arch/v850/Kconfig.debug
--- linux-266-rc1-pv/arch/v850/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/v850/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,10 @@
+
+menu "V850 kernel hacking"
+
+config NO_KERNEL_MSG
+	bool "Suppress Kernel BUG Messages"
+	help
+	  Do not output any debug BUG messages within the kernel.
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/x86_64/Kconfig linux-266-rc1-kdebug/arch/x86_64/Kconfig
--- linux-266-rc1-pv/arch/x86_64/Kconfig	2004-04-15 14:00:11.000000000 -0700
+++ linux-266-rc1-kdebug/arch/x86_64/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -410,104 +410,8 @@ source fs/Kconfig
 source "arch/x86_64/oprofile/Kconfig"
 
 menu "Kernel hacking"
-
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). This is accomplished
-	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
-	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
-	  unless you really know what this hack does.
-
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
-# !SMP for now because the context switch early causes GPF in segment reloading
-# and the GS base checking does the wrong thing then, causing a hang.
-config CHECKING
-	bool "Additional run-time checks"
-	depends on DEBUG_KERNEL && !SMP
-	help
-	  Enables some internal consistency checks for kernel debugging.
-	  You should normally say N.
-
-config INIT_DEBUG
-	bool "Debug __init statements"
-	depends on DEBUG_KERNEL
-	help
-	  Fill __init and __initdata at the end of boot. This helps debugging
-	  illegal uses of __init and __initdata after initialization.	  
-
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  Please note that this option requires new binutils.
-	  If you don't debug the kernel, you can say N.
-	  
-config FRAME_POINTER
-       bool "Compile the kernel with frame pointers"
-       help
-	 Compile the kernel with frame pointers. This may help for some 
-	 debugging with external debuggers. Note the standard oops backtracer 
-	 doesn't make use of this  and the x86-64 kernel doesn't ensure an consistent
-	 frame pointer through inline assembly (semaphores etc.)
-	 Normally you should say N.
-
-config IOMMU_DEBUG
-       depends on GART_IOMMU && DEBUG_KERNEL
-       bool "Enable IOMMU debugging"
-       help
-         Force the IOMMU to on even when you have less than 4GB of
-	 memory and add debugging code. On overflow always panic. And
-	 allow to enable IOMMU leak tracing. Can be disabled at boot
-	 time with iommu=noforce. This will also enable scatter gather
-	 list merging.  Currently not recommended for production
-	 code. When you use it make sure you have a big enough
-	 IOMMU/AGP aperture.  Most of the options enabled by this can
-	 be set more finegrained using the iommu= command line
-	 options. See Documentation/x86_64/boot-options.txt for more
-	 details.
-
-config IOMMU_LEAK
-       bool "IOMMU leak tracing"
-       depends on DEBUG_KERNEL
-       depends on IOMMU_DEBUG
-       help
-         Add a simple leak tracer to the IOMMU code. This is useful when you
-	 are debugging a buggy device driver that leaks IOMMU mappings.
-       
-#config X86_REMOTE_DEBUG
-#       bool "kgdb debugging stub"
-
+source "lib/Kconfig.debug"
+source "arch/x86_64/Kconfig.debug"
 endmenu
 
 source "security/Kconfig"
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/arch/x86_64/Kconfig.debug linux-266-rc1-kdebug/arch/x86_64/Kconfig.debug
--- linux-266-rc1-pv/arch/x86_64/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/arch/x86_64/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,47 @@
+
+menu "X86-64 kernel hacking"
+
+# !SMP for now because the context switch early causes GPF in segment reloading
+# and the GS base checking does the wrong thing then, causing a hang.
+config CHECKING
+	bool "Additional run-time checks"
+	depends on DEBUG_KERNEL && !SMP
+	help
+	  Enables some internal consistency checks for kernel debugging.
+	  You should normally say N.
+
+config INIT_DEBUG
+	bool "Debug __init statements"
+	depends on DEBUG_KERNEL
+	help
+	  Fill __init and __initdata at the end of boot. This helps debugging
+	  illegal uses of __init and __initdata after initialization.	  
+
+config IOMMU_DEBUG
+       depends on GART_IOMMU && DEBUG_KERNEL
+       bool "Enable IOMMU debugging"
+       help
+         Force the IOMMU to on even when you have less than 4GB of
+	 memory and add debugging code. On overflow always panic. And
+	 allow to enable IOMMU leak tracing. Can be disabled at boot
+	 time with iommu=noforce. This will also enable scatter gather
+	 list merging.  Currently not recommended for production
+	 code. When you use it make sure you have a big enough
+	 IOMMU/AGP aperture.  Most of the options enabled by this can
+	 be set more finegrained using the iommu= command line
+	 options. See Documentation/x86_64/boot-options.txt for more
+	 details.
+
+config IOMMU_LEAK
+       bool "IOMMU leak tracing"
+       depends on DEBUG_KERNEL
+       depends on IOMMU_DEBUG
+       help
+         Add a simple leak tracer to the IOMMU code. This is useful when you
+	 are debugging a buggy device driver that leaks IOMMU mappings.
+       
+#config X86_REMOTE_DEBUG
+#       bool "kgdb debugging stub"
+
+endmenu
+
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/init/Kconfig linux-266-rc1-kdebug/init/Kconfig
--- linux-266-rc1-pv/init/Kconfig	2004-04-15 14:00:13.000000000 -0700
+++ linux-266-rc1-kdebug/init/Kconfig	2004-04-15 14:00:56.000000000 -0700
@@ -227,14 +227,6 @@ menuconfig EMBEDDED
           environments which can tolerate a "non-standard" kernel.
           Only use this if you really know what you are doing.
 
-config KALLSYMS
-	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
-	 default y
-	 help
-	   Say Y here to let the kernel print out symbolic crash information and
-	   symbolic stack backtraces. This increases the size of the kernel
-	   somewhat, as all symbols have to be loaded into the kernel image.
-
 config FUTEX
 	bool "Enable futex support" if EMBEDDED
 	default y
diff -Naurp -X /home/rddunlap/doc/dontdiff-osdl linux-266-rc1-pv/lib/Kconfig.debug linux-266-rc1-kdebug/lib/Kconfig.debug
--- linux-266-rc1-pv/lib/Kconfig.debug	1969-12-31 16:00:00.000000000 -0800
+++ linux-266-rc1-kdebug/lib/Kconfig.debug	2004-04-15 14:00:56.000000000 -0700
@@ -0,0 +1,151 @@
+
+menu "Generic kernel hacking"
+
+if !CRIS && !H8300
+
+config DEBUG_KERNEL
+	bool "Kernel debugging"
+	default y if USERMODE
+	help
+	  Say Y here if you are developing drivers or trying to debug and
+	  identify kernel problems.
+
+config MAGIC_SYSRQ
+	bool "Magic SysRq key" if !CRIS
+	depends on DEBUG_KERNEL || MCONSOLE
+	help
+	  If you say Y here, you will have some control over the system even
+	  if the system crashes for example during kernel debugging (e.g., you
+	  will be able to flush the buffer cache to disk, reboot the system
+	  immediately or dump some status information). This is accomplished
+	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
+	  also works on a serial console (on PC hardware at least), if you
+	  send a BREAK and then within 5 seconds a command keypress. The
+	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
+	  unless you really know what this hack does.
+
+config KALLSYMS
+	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
+	 default y if !ARCH_S390
+	 help
+	   Say Y here to let the kernel print out symbolic crash information and
+	   symbolic stack backtraces. This increases the size of the kernel
+	   somewhat, as all symbols have to be loaded into the kernel image.
+
+if X86 || X86_64 || MACH_DECSTATION || ALPHA_GENERIC || ALPHA_SRM || PPC64
+
+config EARLY_PRINTK
+	bool "Early printk" if EMBEDDED
+	default y
+	help
+	  Write kernel log output directly into the VGA buffer or to a serial
+	  port.
+
+	  This is useful for kernel debugging when your machine crashes very
+	  early before the console code is initialized. For normal operation
+	  it is not recommended because it looks ugly and doesn't cooperate
+	  with klogd/syslogd or the X server. You should normally N here,
+	  unless you want to debug such a crash.
+
+endif
+
+config DEBUG_STACKOVERFLOW
+	bool "Check for stack overflows"
+	depends on DEBUG_KERNEL && !ALPHA
+
+config DEBUG_STACK_USAGE
+	bool "Stack utilization instrumentation"
+	depends on DEBUG_KERNEL && !ALPHA
+	help
+	  Enables the display of the minimum amount of free stack which each
+	  task has ever had available in the sysrq-T and sysrq-P debug output.
+
+	  This option will slow down process creation somewhat.
+
+config DEBUG_SLAB
+	bool "Debug memory allocations"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here to have the kernel do limited verification on memory
+	  allocation as well as poisoning memory on free to catch use of freed
+	  memory.
+
+config DEBUG_SPINLOCK
+	bool "Spinlock debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here and build SMP to catch missing spinlock initialization
+	  and certain other kinds of spinlock errors commonly made.  This is
+	  best used in conjunction with the NMI watchdog so that spinlock
+	  deadlocks are also debuggable.
+
+config DEBUG_PAGEALLOC
+	bool "Page alloc debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Unmap pages from the kernel linear mapping after free_pages().
+	  This results in a large slowdown, but helps to find certain types
+	  of memory corruptions.
+
+config DEBUG_HIGHMEM
+	bool "Highmem debugging"
+	depends on DEBUG_KERNEL && HIGHMEM
+	help
+	  This options enables addition error checking for high memory systems.
+	  Disable for production systems.
+
+config DEBUG_INFO
+	bool "Compile the kernel with debug info"
+	depends on DEBUG_KERNEL
+	help
+          If you say Y here the resulting kernel image will include
+	  debugging info resulting in a larger kernel image.
+	  Say Y here only if you plan to use gdb to debug the kernel.
+	  If you don't debug the kernel, you can say N.
+	  
+config DEBUG_SPINLOCK_SLEEP
+	bool "Sleep-inside-spinlock checking"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here, various routines which may sleep will become very
+	  noisy if they are called with a spinlock held.	
+
+if !ARM && !ARM26 && !X86_64
+config FRAME_POINTER
+	bool "Compile the kernel with frame pointers"
+	default y if (SUPERH && KGDB) || (USERMODE && DEBUG_INFO)
+	help
+	  If you say Y here the resulting kernel image will be slightly larger
+	  and slower, but it will give very useful debugging information.
+	  If you don't debug the kernel, you can say N, but we may not be able
+	  to solve problems without frame pointers.
+endif
+if X86_64
+config FRAME_POINTER
+	bool "Compile the kernel with frame pointers"
+	help
+	  If you say Y here the resulting kernel image will be slightly larger
+	  and slower, but it will give very useful debugging information.
+	  If you don't debug the kernel, you can say N, but we may not be able
+	  to solve problems without frame pointers.
+	  This may help for some debugging with external debuggers.
+	  Note the standard oops backtracer doesn't make use of this and
+	  the x86-64 kernel doesn't ensure a consistent
+	  frame pointer through inline assembly (semaphores etc.)
+	  Normally you should say N.
+endif
+
+config 4KSTACKS
+	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	help
+	  If you say Y here the kernel will use a 4Kb stacksize for the
+	  kernel stack attached to each process/thread. This facilitates
+	  running more threads on a system and also reduces the pressure
+	  on the VM subsystem for higher order allocations. This option
+	  will also use IRQ stacks to compensate for the reduced stackspace.
+
+endif
+#end for !CRIS && !H8300
+
+endmenu
+
