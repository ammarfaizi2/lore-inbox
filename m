Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbUKHQcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbUKHQcp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbUKHQcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:32:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261864AbUKHOe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:34:56 -0500
Date: Mon, 8 Nov 2004 14:34:16 GMT
Message-Id: <200411081434.iA8EYGid023489@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 2/20] FRV: Fujitsu FR-V arch documentation
In-Reply-To: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
References: <44bd214c-3193-11d9-8962-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides the arch-specific documentation for the Fujitsu
FR-V CPU arch.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-docs-2610rc1mm3.diff
 README.txt      |   51 +++++++++
 atomic-ops.txt  |  134 ++++++++++++++++++++++++
 booting.txt     |  181 ++++++++++++++++++++++++++++++++
 clock.txt       |   65 +++++++++++
 configuring.txt |  125 ++++++++++++++++++++++
 features.txt    |  310 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 gdbinit         |  102 ++++++++++++++++++
 gdbstub.txt     |  130 +++++++++++++++++++++++
 mmu-layout.txt  |  306 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1404 insertions(+)

diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/atomic-ops.txt linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/atomic-ops.txt
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/atomic-ops.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/atomic-ops.txt	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,134 @@
+			       =====================================
+			       FUJITSU FR-V KERNEL ATOMIC OPERATIONS
+			       =====================================
+
+On the FR-V CPUs, there is only one atomic Read-Modify-Write operation: the SWAP/SWAPI
+instruction. Unfortunately, this alone can't be used to implement the following operations:
+
+ (*) Atomic add to memory
+
+ (*) Atomic subtract from memory
+
+ (*) Atomic bit modification (set, clear or invert)
+
+ (*) Atomic compare and exchange
+
+On such CPUs, the standard way of emulating such operations in uniprocessor mode is to disable
+interrupts, but on the FR-V CPUs, modifying the PSR takes a lot of clock cycles, and it has to be
+done twice. This means the CPU runs for a relatively long time with interrupts disabled,
+potentially having a great effect on interrupt latency.
+
+
+=============
+NEW ALGORITHM
+=============
+
+To get around this, the following algorithm has been implemented. It operates in a way similar to
+the LL/SC instruction pairs supported on a number of platforms.
+
+ (*) The CCCR.CC3 register is reserved within the kernel to act as an atomic modify abort flag.
+
+ (*) In the exception prologues run on kernel->kernel entry, CCCR.CC3 is set to 0 (Undefined
+     state).
+
+ (*) All atomic operations can then be broken down into the following algorithm:
+
+     (1) Set ICC3.Z to true and set CC3 to True (ORCC/CKEQ/ORCR).
+
+     (2) Load the value currently in the memory to be modified into a register.
+
+     (3) Make changes to the value.
+
+     (4) If CC3 is still True, simultaneously and atomically (by VLIW packing):
+
+	 (a) Store the modified value back to memory.
+
+	 (b) Set ICC3.Z to false (CORCC on GR29 is sufficient for this - GR29 holds the current
+	     task pointer in the kernel, and so is guaranteed to be non-zero).
+
+     (5) If ICC3.Z is still true, go back to step (1).
+
+This works in a non-SMP environment because any interrupt or other exception that happens between
+steps (1) and (4) will set CC3 to the Undefined, thus aborting the store in (4a), and causing the
+condition in ICC3 to remain with the Z flag set, thus causing step (5) to loop back to step (1).
+
+
+This algorithm suffers from two problems:
+
+ (1) The condition CCCR.CC3 is cleared unconditionally by an exception, irrespective of whether or
+     not any changes were made to the target memory location during that exception.
+
+ (2) The branch from step (5) back to step (1) may have to happen more than once until the store
+     manages to take place. In theory, this loop could cycle forever because there are too many
+     interrupts coming in, but it's unlikely.
+
+
+=======
+EXAMPLE
+=======
+
+Taking an example from include/asm-frv/atomic.h:
+
+	static inline int atomic_add_return(int i, atomic_t *v)
+	{
+		unsigned long val;
+
+		asm("0:						\n"
+
+It starts by setting ICC3.Z to true for later use, and also transforming that into CC3 being in the
+True state.
+
+		    "	orcc		gr0,gr0,gr0,icc3	\n"	<-- (1)
+		    "	ckeq		icc3,cc7		\n"	<-- (1)
+
+Then it does the load. Note that the final phase of step (1) is done at the same time as the
+load. The VLIW packing ensures they are done simultaneously. The ".p" on the load must not be
+removed without swapping the order of these two instructions.
+
+		    "	ld.p		%M0,%1			\n"	<-- (2)
+		    "	orcr		cc7,cc7,cc3		\n"	<-- (1)
+
+Then the proposed modification is generated. Note that the old value can be retained if required
+(such as in test_and_set_bit()).
+
+		    "	add%I2		%1,%2,%1		\n"	<-- (3)
+
+Then it attempts to store the value back, contingent on no exception having cleared CC3 since it
+was set to True.
+
+		    "	cst.p		%1,%M0		,cc3,#1	\n"	<-- (4a)
+
+It simultaneously records the success or failure of the store in ICC3.Z.
+
+		    "	corcc		gr29,gr29,gr0	,cc3,#1	\n"	<-- (4b)
+
+Such that the branch can then be taken if the operation was aborted.
+
+		    "	beq		icc3,#0,0b		\n"	<-- (5)
+		    : "+U"(v->counter), "=&r"(val)
+		    : "NPr"(i)
+		    : "memory", "cc7", "cc3", "icc3"
+		    );
+
+		return val;
+	}
+
+
+=============
+CONFIGURATION
+=============
+
+The atomic ops implementation can be made inline or out-of-line by changing the
+CONFIG_FRV_OUTOFLINE_ATOMIC_OPS configuration variable. Making it out-of-line has a number of
+advantages:
+
+ - The resulting kernel image may be smaller
+ - Debugging is easier as atomic ops can just be stepped over and they can be breakpointed
+
+Keeping it inline also has a number of advantages:
+
+ - The resulting kernel may be Faster
+   - no out-of-line function calls need to be made
+   - the compiler doesn't have half its registers clobbered by making a call
+
+The out-of-line implementations live in arch/frv/lib/atomic-ops.S.
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/booting.txt linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/booting.txt
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/booting.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/booting.txt	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,181 @@
+			  =========================
+			  BOOTING FR-V LINUX KERNEL
+			  =========================
+
+======================
+PROVIDING A FILESYSTEM
+======================
+
+First of all, a root filesystem must be made available. This can be done in
+one of two ways:
+
+  (1) NFS Export
+
+      A filesystem should be constructed in a directory on an NFS server that
+      the target board can reach. This directory should then be NFS exported
+      such that the target board can read and write into it as root.
+
+  (2) Flash Filesystem (JFFS2 Recommended)
+
+      In this case, the image must be stored or built up on flash before it
+      can be used. A complete image can be built using the mkfs.jffs2 or
+      similar program and then downloaded and stored into flash by RedBoot.
+
+
+========================
+LOADING THE KERNEL IMAGE
+========================
+
+The kernel will need to be loaded into RAM by RedBoot (or by some alternative
+boot loader) before it can be run. The kernel image (arch/frv/boot/Image) may
+be loaded in one of three ways:
+
+  (1) Load from Flash
+
+      This is the simplest. RedBoot can store an image in the flash (see the
+      RedBoot documentation) and then load it back into RAM. RedBoot keeps
+      track of the load address, entry point and size, so the command to do
+      this is simply:
+
+	fis load linux
+
+      The image is then ready to be executed.
+
+  (2) Load by TFTP
+
+      The following command will download a raw binary kernel image from the
+      default server (as negotiated by BOOTP) and store it into RAM:
+      
+	load -b 0x00100000 -r /tftpboot/image.bin
+
+      The image is then ready to be executed.
+
+  (3) Load by Y-Modem
+
+      The following command will download a raw binary kernel image across the
+      serial port that RedBoot is currently using:
+      
+	load -m ymodem -b 0x00100000 -r zImage
+
+      The serial client (such as minicom) must then be told to transmit the
+      program by Y-Modem.
+
+      When finished, the image will then be ready to be executed.
+
+
+==================
+BOOTING THE KERNEL
+==================
+
+Boot the image with the following RedBoot command:
+
+	exec -c "<CMDLINE>" 0x00100000
+
+For example:
+
+	exec -c "console=ttySM0,115200 ip=:::::dhcp root=/dev/mtdblock2 rw"
+
+This will start the kernel running. Note that if the GDB-stub is compiled in,
+then the kernel will immediately wait for GDB to connect over serial before
+doing anything else. See the section on kernel debugging with GDB.
+
+The kernel command line <CMDLINE> tells the kernel where its console is and
+how to find its root filesystem. This is made up of the following components,
+separated by spaces:
+
+  (*) console=ttyS<x>[,<baud>[<parity>[<bits>[<flow>]]]]
+
+      This specifies that the system console should output through on-chip
+      serial port <x> (which can be "0" or "1").
+
+      <baud> is a standard baud rate between 1200 and 115200 (default 9600).
+
+      <parity> is a parity setting of "N", "O", "E", "M" or "S" for None, Odd,
+      Even, Mark or Space. "None" is the default.
+
+      <stop> is "7" or "8" for the number of bits per character. "8" is the
+      default.
+
+      <flow> is "r" to use flow control (XCTS on serial port 2 only). The
+      default is to not use flow control.
+
+      For example:
+
+	console=ttyS0,115200
+
+      To use the first on-chip serial port at baud rate 115200, no parity, 8
+      bits, and no flow control.
+
+  (*) root=/dev/<xxxx>
+
+      This specifies the device upon which the root filesystem resides. For
+      example:
+
+	/dev/nfs	NFS root filesystem
+	/dev/mtdblock3	Fourth RedBoot partition on the System Flash
+
+  (*) rw
+
+      Start with the root filesystem mounted Read/Write.
+
+  The remaining components are all optional:
+
+  (*) ip=<ip>::::<host>:<iface>:<cfg>
+
+      Configure the network interface. If <cfg> is "off" then <ip> should
+      specify the IP address for the network device <iface>. <host> provide
+      the hostname for the device.
+
+      If <cfg> is "bootp" or "dhcp", then all of these parameters will be
+      discovered by consulting a BOOTP or DHCP server.
+
+      For example, the following might be used:
+
+	ip=192.168.73.12::::frv:eth0:off
+
+      This sets the IP address on the VDK motherboard RTL8029 ethernet chipset
+      (eth0) to be 192.168.73.12, and sets the board's hostname to be "frv".
+
+  (*) nfsroot=<server>:<dir>[,v<vers>]
+
+      This is mandatory if "root=/dev/nfs" is given as an option. It tells the
+      kernel the IP address of the NFS server providing its root filesystem,
+      and the pathname on that server of the filesystem.
+
+      The NFS version to use can also be specified. v2 and v3 are supported by
+      Linux.
+
+      For example:
+
+	nfsroot=192.168.73.1:/nfsroot-frv
+
+  (*) profile=1
+
+      Turns on the kernel profiler (accessible through /proc/profile).
+
+  (*) console=gdb0
+
+      This can be used as an alternative to the "console=ttyS..." listed
+      above. I tells the kernel to pass the console output to GDB if the
+      gdbstub is compiled in to the kernel.
+
+      If this is used, then the gdbstub passes the text to GDB, which then
+      simply dumps it to its standard output.
+
+  (*) mem=<xxx>M
+
+      Normally the kernel will work out how much SDRAM it has by reading the
+      SDRAM controller registers. That can be overridden with this
+      option. This allows the kernel to be told that it has <xxx> megabytes of
+      memory available.
+
+  (*) init=<prog> [<arg> [<arg> [<arg> ...]]]
+
+      This tells the kernel what program to run initially. By default this is
+      /sbin/init, but /sbin/sash or /bin/sh are common alternatives.
+
+  (*) vdc=...
+
+      This option configures the MB93493 companion chip visual display
+      driver. Please see Documentation/fujitsu/mb93493/vdc.txt for more
+      information.
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/clock.txt linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/clock.txt
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/clock.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/clock.txt	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,65 @@
+Clock scaling
+-------------
+
+The kernel supports scaling of CLCK.CMODE, CLCK.CM and CLKC.P0 clock
+registers. If built with CONFIG_PM and CONFIG_SYSCTL options enabled, four
+extra files will appear in the directory /proc/sys/pm/. Reading these files
+will show:
+
+      p0		-- current value of the P0 bit in CLKC register.
+      cm		-- current value of the CM bits in CLKC register.
+      cmode		-- current value of the CMODE bits in CLKC register.
+
+On all boards, the 'p0' file should also be writable, and either '1' or '0'
+can be rewritten, to set or clear the CLKC_P0 bit respectively, hence
+controlling whether the resource bus rate clock is halved.
+
+The 'cm' file should also be available on all boards. '0' can be written to it
+to shift the board into High-Speed mode (normal), and '1' can be written to
+shift the board into Medium-Speed mode. Selecting Low-Speed mode is not
+supported by this interface, even though some CPUs do support it.
+
+On the boards with FR405 CPU (i.e. CB60 and CB70), the 'cmode' file is also
+writable, allowing the CPU core speed (and other clock speeds) to be
+controlled from userspace.
+
+
+Determining current and possible settings
+-----------------------------------------
+
+The current state and the available masks can be found in /proc/cpuinfo. For
+example, on the CB70:
+
+	# cat /proc/cpuinfo
+	CPU-Series:     fr400
+	CPU-Core:       fr405, gr0-31, BE, CCCR
+	CPU:            mb93405
+	MMU:            Prot
+	FP-Media:       fr0-31, Media
+	System:         mb93091-cb70, mb93090-mb00
+	PM-Controls:    cmode=0xd31f, cm=0x3, p0=0x3, suspend=0x9
+	PM-Status:      cmode=3, cm=0, p0=0
+	Clock-In:       50.00 MHz
+	Clock-Core:     300.00 MHz
+	Clock-SDRAM:    100.00 MHz
+	Clock-CBus:     100.00 MHz
+	Clock-Res:      50.00 MHz
+	Clock-Ext:      50.00 MHz
+	Clock-DSU:      25.00 MHz
+	BogoMips:       300.00
+
+And on the PDK, the PM lines look like the following:
+
+	PM-Controls:    cm=0x3, p0=0x3, suspend=0x9
+	PM-Status:      cmode=9, cm=0, p0=0
+
+The PM-Controls line, if present, will indicate which /proc/sys/pm files can
+be set to what values. The specification values are bitmasks; so, for example,
+"suspend=0x9" indicates that 0 and 3 can be written validly to
+/proc/sys/pm/suspend.
+
+The PM-Controls line will only be present if CONFIG_PM is configured to Y.
+
+The PM-Status line indicates which clock controls are set to which value. If
+the file can be read, then the suspend value must be 0, and so that's not
+included.
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/configuring.txt linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/configuring.txt
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/configuring.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/configuring.txt	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,125 @@
+		   =======================================
+		   FUJITSU FR-V LINUX KERNEL CONFIGURATION
+		   =======================================
+
+=====================
+CONFIGURATION OPTIONS
+=====================
+
+The most important setting is in the "MMU support options" tab (the first
+presented in the configuration tools available):
+
+ (*) "Kernel Type"
+
+     This options allows selection of normal, MMU-requiring linux, and uClinux
+     (which doesn't require an MMU and doesn't have inter-process protection).
+
+There are a number of settings in the "Processor type and features" section of
+the kernel configuration that need to be considered.
+
+ (*) "CPU"
+
+     The register and instruction sets at the core of the processor. This can
+     only be set to "FR40x/45x/55x" at the moment - but this permits usage of
+     the kernel with MB93091 CB10, CB11, CB30, CB41, CB60, CB70 and CB451
+     CPU boards, and with the MB93093 PDK board.
+
+ (*) "System"
+
+     This option allows a choice of basic system. This governs the peripherals
+     that are expected to be available.
+
+ (*) "Motherboard"
+
+     This specifies the type of motherboard being used, and the peripherals
+     upon it. Currently only "MB93090-MB00" can be set here.
+
+ (*) "Default cache-write mode"
+
+     This controls the initial data cache write management mode. By default
+     Write-Through is selected, but Write-Back (Copy-Back) can also be
+     selected. This can be changed dynamically once the kernel is running (see
+     features.txt).
+
+There are some architecture specific configuration options in the "General
+Setup" section of the kernel configuration too:
+
+ (*) "Reserve memory uncached for (PCI) DMA"
+
+     This requests that a uClinux kernel set aside some memory in an uncached
+     window for the use as consistent DMA memory (mainly for PCI). At least a
+     megabyte will be allocated in this way, possibly more. Any memory so
+     reserved will not be available for normal allocations.
+
+ (*) "Kernel support for ELF-FDPIC binaries"
+
+     This enables the binary-format driver for the new FDPIC ELF binaries that
+     this platform normally uses. These binaries are totally relocatable -
+     their separate sections can relocated independently, allowing them to be
+     shared on uClinux where possible. This should normally be enabled.
+
+ (*) "Kernel image protection"
+
+     This makes the protection register governing access to the core kernel
+     image prohibit access by userspace programs. This option is available on
+     uClinux only.
+
+There are also a number of settings in the "Kernel Hacking" section of the
+kernel configuration especially for debugging a kernel on this
+architecture. See the "gdbstub.txt" file for information about those.
+
+
+======================
+DEFAULT CONFIGURATIONS
+======================
+
+The kernel sources include a number of example default configurations:
+
+ (*) defconfig-mb93091
+
+     Default configuration for the MB93091-VDK with both CPU board and
+     MB93090-MB00 motherboard running uClinux.
+
+
+ (*) defconfig-mb93091-fb
+
+     Default configuration for the MB93091-VDK with CPU board,
+     MB93090-MB00 motherboard, and DAV board running uClinux.
+     Includes framebuffer driver.
+
+
+ (*) defconfig-mb93093
+
+     Default configuration for the MB93093-PDK board running uClinux.
+
+
+ (*) defconfig-cb70-standalone
+
+     Default configuration for the MB93091-VDK with only CB70 CPU board
+     running uClinux. This will use the CB70's DM9000 for network access.
+
+
+ (*) defconfig-mmu
+
+     Default configuration for the MB93091-VDK with both CB451 CPU board and
+     MB93090-MB00 motherboard running MMU linux.
+
+ (*) defconfig-mmu-audio
+
+     Default configuration for the MB93091-VDK with CB451 CPU board, DAV
+     board, and MB93090-MB00 motherboard running MMU linux. Includes
+     audio driver.
+
+ (*) defconfig-mmu-fb
+
+     Default configuration for the MB93091-VDK with CB451 CPU board, DAV
+     board, and MB93090-MB00 motherboard running MMU linux. Includes
+     framebuffer driver.
+
+ (*) defconfig-mmu-standalone
+
+     Default configuration for the MB93091-VDK with only CB451 CPU board
+     running MMU linux.
+
+
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/features.txt linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/features.txt
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/features.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/features.txt	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,310 @@
+			 ===========================
+			 FUJITSU FR-V LINUX FEATURES
+			 ===========================
+
+This kernel port has a number of features of which the user should be aware:
+
+ (*) Linux and uClinux
+
+     The FR-V architecture port supports both normal MMU linux and uClinux out
+     of the same sources.
+
+
+ (*) CPU support
+
+     Support for the FR401, FR403, FR405, FR451 and FR555 CPUs should work with
+     the same uClinux kernel configuration.
+
+     In normal (MMU) Linux mode, only the FR451 CPU will work as that is the
+     only one with a suitably featured CPU.
+
+     The kernel is written and compiled with the assumption that only the
+     bottom 32 GR registers and no FR registers will be used by the kernel
+     itself, however all extra userspace registers will be saved on context
+     switch. Note that since most CPUs can't support lazy switching, no attempt
+     is made to do lazy register saving where that would be possible (FR555
+     only currently).
+
+
+ (*) Board support
+
+     The board on which the kernel will run can be configured on the "Processor
+     type and features" configuration tab.
+
+     Set the System to "MB93093-PDK" to boot from the MB93093 (FR403) PDK.
+
+     Set the System to "MB93091-VDK" to boot from the CB11, CB30, CB41, CB60,
+     CB70 or CB451 VDK boards. Set the Motherboard setting to "MB93090-MB00" to
+     boot with the standard ATA90590B VDK motherboard, and set it to "None" to
+     boot without any motherboard.
+
+
+ (*) Binary Formats
+
+     The only userspace binary format supported is FDPIC ELF. Normal ELF, FLAT
+     and AOUT binaries are not supported for this architecture.
+
+     FDPIC ELF supports shared library and program interpreter facilities.
+
+
+ (*) Scheduler Speed
+
+     The kernel scheduler runs at 100Hz irrespective of the clock speed on this
+     architecture. This value is set in asm/param.h (see the HZ macro defined
+     there).
+
+
+ (*) Normal (MMU) Linux Memory Layout.
+
+     See mmu-layout.txt in this directory for a description of the normal linux
+     memory layout
+
+     See include/asm-frv/mem-layout.h for constants pertaining to the memory
+     layout.
+
+     See include/asm-frv/mb-regs.h for the constants pertaining to the I/O bus
+     controller configuration.
+
+
+ (*) uClinux Memory Layout
+
+     The memory layout used by the uClinux kernel is as follows:
+
+	0x00000000 - 0x00000FFF		Null pointer catch page
+	0x20000000 - 0x200FFFFF CS2#    [PDK] FPGA
+	0xC0000000 - 0xCFFFFFFF		SDRAM
+	0xC0000000			Base of Linux kernel image
+	0xE0000000 - 0xEFFFFFFF	CS2#	[VDK] SLBUS/PCI window
+	0xF0000000 - 0xF0FFFFFF	CS5#	MB93493 CSC area (DAV daughter board)
+	0xF1000000 - 0xF1FFFFFF	CS7#	[CB70/CB451] CPU-card PCMCIA port space
+	0xFC000000 - 0xFC0FFFFF	CS1#	[VDK] MB86943 config space
+	0xFC100000 - 0xFC1FFFFF	CS6#	[CB70/CB451] CPU-card DM9000 NIC space
+	0xFC100000 - 0xFC1FFFFF	CS6#	[PDK] AX88796 NIC space
+	0xFC200000 - 0xFC2FFFFF	CS3#	MB93493 CSR area (DAV daughter board)
+	0xFD000000 - 0xFDFFFFFF	CS4#	[CB70/CB451] CPU-card extra flash space
+	0xFE000000 - 0xFEFFFFFF		Internal CPU peripherals
+	0xFF000000 - 0xFF1FFFFF	CS0#	Flash 1
+	0xFF200000 - 0xFF3FFFFF	CS0#	Flash 2
+	0xFFC00000 - 0xFFC0001F	CS0#	[VDK] FPGA
+
+     The kernel reads the size of the SDRAM from the memory bus controller
+     registers by default.
+
+     The kernel initialisation code (1) adjusts the SDRAM base addresses to
+     move the SDRAM to desired address, (2) moves the kernel image down to the
+     bottom of SDRAM, (3) adjusts the bus controller registers to move I/O
+     windows, and (4) rearranges the protection registers to protect all of
+     this.
+
+     The reasons for doing this are: (1) the page at address 0 should be
+     inaccessible so that NULL pointer errors can be caught; and (2) the bottom
+     three quarters are left unoccupied so that an FR-V CPU with an MMU can use
+     it for virtual userspace mappings.
+
+     See include/asm-frv/mem-layout.h for constants pertaining to the memory
+     layout.
+
+     See include/asm-frv/mb-regs.h for the constants pertaining to the I/O bus
+     controller configuration.
+
+
+ (*) uClinux Memory Protection
+
+     A DAMPR register is used to cover the entire region used for I/O
+     (0xE0000000 - 0xFFFFFFFF). This permits the kernel to make uncached
+     accesses to this region. Userspace is not permitted to access it.
+
+     The DAMPR/IAMPR protection registers not in use for any other purpose are
+     tiled over the top of the SDRAM such that:
+
+	(1) The core kernel image is covered by as small a tile as possible
+            granting only the kernel access to the underlying data, whilst
+            making sure no SDRAM is actually made unavailable by this approach.
+
+	(2) All other tiles are arranged to permit userspace access to the rest
+            of the SDRAM.
+
+     Barring point (1), there is nothing to protect kernel data against
+     userspace damage - but this is uClinux.
+
+
+ (*) Exceptions and Fixups
+
+     Since the FR40x and FR55x CPUs that do not have full MMUs generate
+     imprecise data error exceptions, there are currently no automatic fixup
+     services available in uClinux. This includes misaligned memory access
+     fixups.
+
+     Userspace EFAULT errors can be trapped by issuing a MEMBAR instruction and
+     forcing the fault to happen there.
+
+     On the FR451, however, data exceptions are mostly precise, and so
+     exception fixup handling is implemented as normal.
+
+
+ (*) Userspace Breakpoints
+
+     The ptrace() system call supports the following userspace debugging
+     features:
+
+	(1) Hardware assisted single step.
+
+	(2) Breakpoint via the FR-V "BREAK" instruction.
+
+	(3) Breakpoint via the FR-V "TIRA GR0, #1" instruction.
+
+	(4) Syscall entry/exit trap.
+
+     Each of the above generates a SIGTRAP.
+
+
+ (*) On-Chip Serial Ports
+
+     The FR-V on-chip serial ports are made available as ttyS0 and ttyS1. Note
+     that if the GDB stub is compiled in, ttyS1 will not actually be available
+     as it will be being used for the GDB stub.
+
+     These ports can be made by:
+
+	mknod /dev/ttyS0 c 4 64
+	mknod /dev/ttyS1 c 4 65
+
+
+ (*) Maskable Interrupts
+
+     Level 15 (Non-maskable) interrupts are dealt with by the GDB stub if
+     present, and cause a panic if not. If the GDB stub is present, ttyS1's
+     interrupts are rated at level 15.
+
+     All other interrupts are distributed over the set of available priorities
+     so that no IRQs are shared where possible. The arch interrupt handling
+     routines attempt to disentangle the various sources available through the
+     CPU's own multiplexor, and those on off-CPU peripherals.
+
+
+ (*) Accessing PCI Devices
+
+     Where PCI is available, care must be taken when dealing with drivers that
+     access PCI devices. PCI devices present their data in little-endian form,
+     but the CPU sees it in big-endian form. The macros in asm/io.h try to get
+     this right, but may not under all circumstances...
+
+
+ (*) Ax88796 Ethernet Driver
+
+     The MB93093 PDK board has an Ax88796 ethernet chipset (an NE2000 clone). A
+     driver has been written to deal specifically with this. The driver
+     provides MII services for the card.
+
+     The driver can be configured by running make xconfig, and going to:
+
+	(*) Network device support
+	    - turn on "Network device support"
+	    (*) Ethernet (10 or 100Mbit)
+		- turn on "Ethernet (10 or 100Mbit)"
+		- turn on "AX88796 NE2000 compatible chipset"
+
+     The driver can be found in:
+
+	drivers/net/ax88796.c
+	include/asm/ax88796.h
+
+
+ (*) WorkRAM Driver
+
+     This driver provides a character device that permits access to the WorkRAM
+     that can be found on the FR451 CPU. Each page is accessible through a
+     separate minor number, thereby permitting each page to have its own
+     filesystem permissions set on the device file.
+
+     The device files should be:
+
+	mknod /dev/frv/workram0 c 240 0
+	mknod /dev/frv/workram1 c 240 1
+	mknod /dev/frv/workram2 c 240 2
+	...
+
+     The driver will not permit the opening of any device file that does not
+     correspond to at least a partial page of WorkRAM. So the first device file
+     is the only one available on the FR451. If any other CPU is detected, none
+     of the devices will be openable.
+
+     The devices can be accessed with read, write and llseek, and can also be
+     mmapped. If they're mmapped, they will only map at the appropriate
+     0x7e8nnnnn address on linux and at the 0xfe8nnnnn address on uClinux. If
+     MAP_FIXED is not specified, the appropriate address will be chosen anyway.
+
+     The mappings must be MAP_SHARED not MAP_PRIVATE, and must not be
+     PROT_EXEC. They must also start at file offset 0, and must not be longer
+     than one page in size.
+
+     This driver can be configured by running make xconfig, and going to:
+
+	(*) Character devices
+	    - turn on "Fujitsu FR-V CPU WorkRAM support"
+
+
+ (*) Dynamic data cache write mode changing
+
+     It is possible to view and to change the data cache's write mode through
+     the /proc/sys/frv/cache-mode file while the kernel is running. There are
+     two modes available:
+
+	NAME	MEANING
+	=====	==========================================
+	wthru	Data cache is in Write-Through mode
+	wback	Data cache is in Write-Back/Copy-Back mode
+
+     To read the cache mode:
+
+	# cat /proc/sys/frv/cache-mode
+	wthru
+
+     To change the cache mode:
+
+	# echo wback >/proc/sys/frv/cache-mode
+	# cat /proc/sys/frv/cache-mode
+	wback
+
+
+ (*) MMU Context IDs and Pinning
+
+     On MMU Linux the CPU supports the concept of a context ID in its MMU to
+     make it more efficient (TLB entries are labelled with a context ID to link
+     them to specific tasks).
+
+     Normally once a context ID is allocated, it will remain affixed to a task
+     or CLONE_VM'd group of tasks for as long as it exists. However, since the
+     kernel is capable of supporting more tasks than there are possible ID
+     numbers, the kernel will pass context IDs from one task to another if
+     there are insufficient available.
+
+     The context ID currently in use by a task can be viewed in /proc:
+
+	# grep CXNR /proc/1/status
+	CXNR: 1
+
+     Note that kernel threads do not have a userspace context, and so will not
+     show a CXNR entry in that file.
+
+     Under some circumstances, however, it is desirable to pin a context ID on
+     a process such that the kernel won't pass it on. This can be done by
+     writing the process ID of the target process to a special file:
+
+	# echo 17 >/proc/sys/frv/pin-cxnr
+
+     Reading from the file will then show the context ID pinned.
+
+	# cat /proc/sys/frv/pin-cxnr
+	4
+
+     The context ID will remain pinned as long as any process is using that
+     context, i.e.: when the all the subscribing processes have exited or
+     exec'd; or when an unpinning request happens:
+
+	# echo 0 >/proc/sys/frv/pin-cxnr
+
+     When there isn't a pinned context, the file shows -1:
+
+	# cat /proc/sys/frv/pin-cxnr
+	-1
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/gdbinit linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/gdbinit
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/gdbinit	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/gdbinit	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,102 @@
+set remotebreak 1
+
+define _amr
+
+printf "AMRx           DAMR                    IAMR         \n"
+printf "====   =====================   =====================\n"
+printf "amr0 : L:%08lx P:%08lx : L:%08lx P:%08lx\n",__debug_mmu.damr[0x0].L,__debug_mmu.damr[0x0].P,__debug_mmu.iamr[0x0].L,__debug_mmu.iamr[0x0].P
+printf "amr1 : L:%08lx P:%08lx : L:%08lx P:%08lx\n",__debug_mmu.damr[0x1].L,__debug_mmu.damr[0x1].P,__debug_mmu.iamr[0x1].L,__debug_mmu.iamr[0x1].P
+printf "amr2 : L:%08lx P:%08lx : L:%08lx P:%08lx\n",__debug_mmu.damr[0x2].L,__debug_mmu.damr[0x2].P,__debug_mmu.iamr[0x2].L,__debug_mmu.iamr[0x2].P
+printf "amr3 : L:%08lx P:%08lx : L:%08lx P:%08lx\n",__debug_mmu.damr[0x3].L,__debug_mmu.damr[0x3].P,__debug_mmu.iamr[0x3].L,__debug_mmu.iamr[0x3].P
+printf "amr4 : L:%08lx P:%08lx : L:%08lx P:%08lx\n",__debug_mmu.damr[0x4].L,__debug_mmu.damr[0x4].P,__debug_mmu.iamr[0x4].L,__debug_mmu.iamr[0x4].P
+printf "amr5 : L:%08lx P:%08lx : L:%08lx P:%08lx\n",__debug_mmu.damr[0x5].L,__debug_mmu.damr[0x5].P,__debug_mmu.iamr[0x5].L,__debug_mmu.iamr[0x5].P
+printf "amr6 : L:%08lx P:%08lx : L:%08lx P:%08lx\n",__debug_mmu.damr[0x6].L,__debug_mmu.damr[0x6].P,__debug_mmu.iamr[0x6].L,__debug_mmu.iamr[0x6].P
+printf "amr7 : L:%08lx P:%08lx : L:%08lx P:%08lx\n",__debug_mmu.damr[0x7].L,__debug_mmu.damr[0x7].P,__debug_mmu.iamr[0x7].L,__debug_mmu.iamr[0x7].P
+
+printf "amr8 : L:%08lx P:%08lx\n",__debug_mmu.damr[0x8].L,__debug_mmu.damr[0x8].P
+printf "amr9 : L:%08lx P:%08lx\n",__debug_mmu.damr[0x9].L,__debug_mmu.damr[0x9].P
+printf "amr10: L:%08lx P:%08lx\n",__debug_mmu.damr[0xa].L,__debug_mmu.damr[0xa].P
+printf "amr11: L:%08lx P:%08lx\n",__debug_mmu.damr[0xb].L,__debug_mmu.damr[0xb].P
+
+end
+
+
+define _tlb
+printf "tlb[0x00]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x0].L,__debug_mmu.tlb[0x0].P,__debug_mmu.tlb[0x40+0x0].L,__debug_mmu.tlb[0x40+0x0].P
+printf "tlb[0x01]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x1].L,__debug_mmu.tlb[0x1].P,__debug_mmu.tlb[0x40+0x1].L,__debug_mmu.tlb[0x40+0x1].P
+printf "tlb[0x02]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x2].L,__debug_mmu.tlb[0x2].P,__debug_mmu.tlb[0x40+0x2].L,__debug_mmu.tlb[0x40+0x2].P
+printf "tlb[0x03]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x3].L,__debug_mmu.tlb[0x3].P,__debug_mmu.tlb[0x40+0x3].L,__debug_mmu.tlb[0x40+0x3].P
+printf "tlb[0x04]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x4].L,__debug_mmu.tlb[0x4].P,__debug_mmu.tlb[0x40+0x4].L,__debug_mmu.tlb[0x40+0x4].P
+printf "tlb[0x05]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x5].L,__debug_mmu.tlb[0x5].P,__debug_mmu.tlb[0x40+0x5].L,__debug_mmu.tlb[0x40+0x5].P
+printf "tlb[0x06]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x6].L,__debug_mmu.tlb[0x6].P,__debug_mmu.tlb[0x40+0x6].L,__debug_mmu.tlb[0x40+0x6].P
+printf "tlb[0x07]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x7].L,__debug_mmu.tlb[0x7].P,__debug_mmu.tlb[0x40+0x7].L,__debug_mmu.tlb[0x40+0x7].P
+printf "tlb[0x08]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x8].L,__debug_mmu.tlb[0x8].P,__debug_mmu.tlb[0x40+0x8].L,__debug_mmu.tlb[0x40+0x8].P
+printf "tlb[0x09]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x9].L,__debug_mmu.tlb[0x9].P,__debug_mmu.tlb[0x40+0x9].L,__debug_mmu.tlb[0x40+0x9].P
+printf "tlb[0x0a]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0xa].L,__debug_mmu.tlb[0xa].P,__debug_mmu.tlb[0x40+0xa].L,__debug_mmu.tlb[0x40+0xa].P
+printf "tlb[0x0b]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0xb].L,__debug_mmu.tlb[0xb].P,__debug_mmu.tlb[0x40+0xb].L,__debug_mmu.tlb[0x40+0xb].P
+printf "tlb[0x0c]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0xc].L,__debug_mmu.tlb[0xc].P,__debug_mmu.tlb[0x40+0xc].L,__debug_mmu.tlb[0x40+0xc].P
+printf "tlb[0x0d]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0xd].L,__debug_mmu.tlb[0xd].P,__debug_mmu.tlb[0x40+0xd].L,__debug_mmu.tlb[0x40+0xd].P
+printf "tlb[0x0e]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0xe].L,__debug_mmu.tlb[0xe].P,__debug_mmu.tlb[0x40+0xe].L,__debug_mmu.tlb[0x40+0xe].P
+printf "tlb[0x0f]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0xf].L,__debug_mmu.tlb[0xf].P,__debug_mmu.tlb[0x40+0xf].L,__debug_mmu.tlb[0x40+0xf].P
+printf "tlb[0x10]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x10].L,__debug_mmu.tlb[0x10].P,__debug_mmu.tlb[0x40+0x10].L,__debug_mmu.tlb[0x40+0x10].P
+printf "tlb[0x11]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x11].L,__debug_mmu.tlb[0x11].P,__debug_mmu.tlb[0x40+0x11].L,__debug_mmu.tlb[0x40+0x11].P
+printf "tlb[0x12]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x12].L,__debug_mmu.tlb[0x12].P,__debug_mmu.tlb[0x40+0x12].L,__debug_mmu.tlb[0x40+0x12].P
+printf "tlb[0x13]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x13].L,__debug_mmu.tlb[0x13].P,__debug_mmu.tlb[0x40+0x13].L,__debug_mmu.tlb[0x40+0x13].P
+printf "tlb[0x14]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x14].L,__debug_mmu.tlb[0x14].P,__debug_mmu.tlb[0x40+0x14].L,__debug_mmu.tlb[0x40+0x14].P
+printf "tlb[0x15]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x15].L,__debug_mmu.tlb[0x15].P,__debug_mmu.tlb[0x40+0x15].L,__debug_mmu.tlb[0x40+0x15].P
+printf "tlb[0x16]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x16].L,__debug_mmu.tlb[0x16].P,__debug_mmu.tlb[0x40+0x16].L,__debug_mmu.tlb[0x40+0x16].P
+printf "tlb[0x17]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x17].L,__debug_mmu.tlb[0x17].P,__debug_mmu.tlb[0x40+0x17].L,__debug_mmu.tlb[0x40+0x17].P
+printf "tlb[0x18]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x18].L,__debug_mmu.tlb[0x18].P,__debug_mmu.tlb[0x40+0x18].L,__debug_mmu.tlb[0x40+0x18].P
+printf "tlb[0x19]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x19].L,__debug_mmu.tlb[0x19].P,__debug_mmu.tlb[0x40+0x19].L,__debug_mmu.tlb[0x40+0x19].P
+printf "tlb[0x1a]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x1a].L,__debug_mmu.tlb[0x1a].P,__debug_mmu.tlb[0x40+0x1a].L,__debug_mmu.tlb[0x40+0x1a].P
+printf "tlb[0x1b]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x1b].L,__debug_mmu.tlb[0x1b].P,__debug_mmu.tlb[0x40+0x1b].L,__debug_mmu.tlb[0x40+0x1b].P
+printf "tlb[0x1c]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x1c].L,__debug_mmu.tlb[0x1c].P,__debug_mmu.tlb[0x40+0x1c].L,__debug_mmu.tlb[0x40+0x1c].P
+printf "tlb[0x1d]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x1d].L,__debug_mmu.tlb[0x1d].P,__debug_mmu.tlb[0x40+0x1d].L,__debug_mmu.tlb[0x40+0x1d].P
+printf "tlb[0x1e]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x1e].L,__debug_mmu.tlb[0x1e].P,__debug_mmu.tlb[0x40+0x1e].L,__debug_mmu.tlb[0x40+0x1e].P
+printf "tlb[0x1f]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x1f].L,__debug_mmu.tlb[0x1f].P,__debug_mmu.tlb[0x40+0x1f].L,__debug_mmu.tlb[0x40+0x1f].P
+printf "tlb[0x20]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x20].L,__debug_mmu.tlb[0x20].P,__debug_mmu.tlb[0x40+0x20].L,__debug_mmu.tlb[0x40+0x20].P
+printf "tlb[0x21]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x21].L,__debug_mmu.tlb[0x21].P,__debug_mmu.tlb[0x40+0x21].L,__debug_mmu.tlb[0x40+0x21].P
+printf "tlb[0x22]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x22].L,__debug_mmu.tlb[0x22].P,__debug_mmu.tlb[0x40+0x22].L,__debug_mmu.tlb[0x40+0x22].P
+printf "tlb[0x23]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x23].L,__debug_mmu.tlb[0x23].P,__debug_mmu.tlb[0x40+0x23].L,__debug_mmu.tlb[0x40+0x23].P
+printf "tlb[0x24]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x24].L,__debug_mmu.tlb[0x24].P,__debug_mmu.tlb[0x40+0x24].L,__debug_mmu.tlb[0x40+0x24].P
+printf "tlb[0x25]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x25].L,__debug_mmu.tlb[0x25].P,__debug_mmu.tlb[0x40+0x25].L,__debug_mmu.tlb[0x40+0x25].P
+printf "tlb[0x26]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x26].L,__debug_mmu.tlb[0x26].P,__debug_mmu.tlb[0x40+0x26].L,__debug_mmu.tlb[0x40+0x26].P
+printf "tlb[0x27]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x27].L,__debug_mmu.tlb[0x27].P,__debug_mmu.tlb[0x40+0x27].L,__debug_mmu.tlb[0x40+0x27].P
+printf "tlb[0x28]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x28].L,__debug_mmu.tlb[0x28].P,__debug_mmu.tlb[0x40+0x28].L,__debug_mmu.tlb[0x40+0x28].P
+printf "tlb[0x29]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x29].L,__debug_mmu.tlb[0x29].P,__debug_mmu.tlb[0x40+0x29].L,__debug_mmu.tlb[0x40+0x29].P
+printf "tlb[0x2a]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x2a].L,__debug_mmu.tlb[0x2a].P,__debug_mmu.tlb[0x40+0x2a].L,__debug_mmu.tlb[0x40+0x2a].P
+printf "tlb[0x2b]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x2b].L,__debug_mmu.tlb[0x2b].P,__debug_mmu.tlb[0x40+0x2b].L,__debug_mmu.tlb[0x40+0x2b].P
+printf "tlb[0x2c]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x2c].L,__debug_mmu.tlb[0x2c].P,__debug_mmu.tlb[0x40+0x2c].L,__debug_mmu.tlb[0x40+0x2c].P
+printf "tlb[0x2d]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x2d].L,__debug_mmu.tlb[0x2d].P,__debug_mmu.tlb[0x40+0x2d].L,__debug_mmu.tlb[0x40+0x2d].P
+printf "tlb[0x2e]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x2e].L,__debug_mmu.tlb[0x2e].P,__debug_mmu.tlb[0x40+0x2e].L,__debug_mmu.tlb[0x40+0x2e].P
+printf "tlb[0x2f]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x2f].L,__debug_mmu.tlb[0x2f].P,__debug_mmu.tlb[0x40+0x2f].L,__debug_mmu.tlb[0x40+0x2f].P
+printf "tlb[0x30]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x30].L,__debug_mmu.tlb[0x30].P,__debug_mmu.tlb[0x40+0x30].L,__debug_mmu.tlb[0x40+0x30].P
+printf "tlb[0x31]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x31].L,__debug_mmu.tlb[0x31].P,__debug_mmu.tlb[0x40+0x31].L,__debug_mmu.tlb[0x40+0x31].P
+printf "tlb[0x32]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x32].L,__debug_mmu.tlb[0x32].P,__debug_mmu.tlb[0x40+0x32].L,__debug_mmu.tlb[0x40+0x32].P
+printf "tlb[0x33]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x33].L,__debug_mmu.tlb[0x33].P,__debug_mmu.tlb[0x40+0x33].L,__debug_mmu.tlb[0x40+0x33].P
+printf "tlb[0x34]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x34].L,__debug_mmu.tlb[0x34].P,__debug_mmu.tlb[0x40+0x34].L,__debug_mmu.tlb[0x40+0x34].P
+printf "tlb[0x35]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x35].L,__debug_mmu.tlb[0x35].P,__debug_mmu.tlb[0x40+0x35].L,__debug_mmu.tlb[0x40+0x35].P
+printf "tlb[0x36]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x36].L,__debug_mmu.tlb[0x36].P,__debug_mmu.tlb[0x40+0x36].L,__debug_mmu.tlb[0x40+0x36].P
+printf "tlb[0x37]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x37].L,__debug_mmu.tlb[0x37].P,__debug_mmu.tlb[0x40+0x37].L,__debug_mmu.tlb[0x40+0x37].P
+printf "tlb[0x38]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x38].L,__debug_mmu.tlb[0x38].P,__debug_mmu.tlb[0x40+0x38].L,__debug_mmu.tlb[0x40+0x38].P
+printf "tlb[0x39]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x39].L,__debug_mmu.tlb[0x39].P,__debug_mmu.tlb[0x40+0x39].L,__debug_mmu.tlb[0x40+0x39].P
+printf "tlb[0x3a]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x3a].L,__debug_mmu.tlb[0x3a].P,__debug_mmu.tlb[0x40+0x3a].L,__debug_mmu.tlb[0x40+0x3a].P
+printf "tlb[0x3b]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x3b].L,__debug_mmu.tlb[0x3b].P,__debug_mmu.tlb[0x40+0x3b].L,__debug_mmu.tlb[0x40+0x3b].P
+printf "tlb[0x3c]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x3c].L,__debug_mmu.tlb[0x3c].P,__debug_mmu.tlb[0x40+0x3c].L,__debug_mmu.tlb[0x40+0x3c].P
+printf "tlb[0x3d]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x3d].L,__debug_mmu.tlb[0x3d].P,__debug_mmu.tlb[0x40+0x3d].L,__debug_mmu.tlb[0x40+0x3d].P
+printf "tlb[0x3e]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x3e].L,__debug_mmu.tlb[0x3e].P,__debug_mmu.tlb[0x40+0x3e].L,__debug_mmu.tlb[0x40+0x3e].P
+printf "tlb[0x3f]: %08lx %08lx  %08lx %08lx\n",__debug_mmu.tlb[0x3f].L,__debug_mmu.tlb[0x3f].P,__debug_mmu.tlb[0x40+0x3f].L,__debug_mmu.tlb[0x40+0x3f].P
+end
+
+
+define _pgd
+p (pgd_t[0x40])*(pgd_t*)(__debug_mmu.damr[0x3].L)
+end
+
+define _ptd_i
+p (pte_t[0x1000])*(pte_t*)(__debug_mmu.damr[0x4].L)
+end
+
+define _ptd_d
+p (pte_t[0x1000])*(pte_t*)(__debug_mmu.damr[0x5].L)
+end
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/gdbstub.txt linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/gdbstub.txt
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/gdbstub.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/gdbstub.txt	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,130 @@
+			     ====================
+			     DEBUGGING FR-V LINUX
+			     ====================
+
+
+The kernel contains a GDB stub that talks GDB remote protocol across a serial
+port. This permits GDB to single step through the kernel, set breakpoints and
+trap exceptions that happen in kernel space and interrupt execution. It also
+permits the NMI interrupt button or serial port events to jump the kernel into
+the debugger.
+
+On the CPUs that have on-chip UARTs (FR400, FR403, FR405, FR555), the
+GDB stub hijacks a serial port for its own purposes, and makes it
+generate level 15 interrupts (NMI). The kernel proper cannot see the serial
+port in question under these conditions.
+
+On the MB93091-VDK CPU boards, the GDB stub uses UART1, which would otherwise
+be /dev/ttyS1. On the MB93093-PDK, the GDB stub uses UART0. Therefore, on the
+PDK there is no externally accessible serial port and the serial port to
+which the touch screen is attached becomes /dev/ttyS0.
+
+Note that the GDB stub runs entirely within CPU debug mode, and so should not
+incur any exceptions or interrupts whilst it is active. In particular, note
+that the clock will lose time since it is implemented in software.
+
+
+==================
+KERNEL PREPARATION
+==================
+
+Firstly, a debuggable kernel must be built. To do this, unpack the kernel tree
+and copy the configuration that you wish to use to .config. Then reconfigure
+the following things on the "Kernel Hacking" tab:
+
+  (*) "Include debugging information"
+
+      Set this to "Y". This causes all C and Assembly files to be compiled
+      to include debugging information.
+
+  (*) "In-kernel GDB stub"
+
+      Set this to "Y". This causes the GDB stub to be compiled into the
+      kernel.
+
+  (*) "Immediate activation"
+
+      Set this to "Y" if you want the GDB stub to activate as soon as possible
+      and wait for GDB to connect. This allows you to start tracing right from
+      the beginning of start_kernel() in init/main.c.
+
+  (*) "Console through GDB stub"
+
+      Set this to "Y" if you wish to be able to use "console=gdb0" on the
+      command line. That tells the kernel to pass system console messages to
+      GDB (which then prints them on its standard output). This is useful when
+      debugging the serial drivers that'd otherwise be used to pass console
+      messages to the outside world.
+
+Then build as usual, download to the board and execute. Note that if
+"Immediate activation" was selected, then the kernel will wait for GDB to
+attach. If not, then the kernel will boot immediately and GDB will have to
+interupt it or wait for an exception to occur if before doing anything with
+the kernel.
+
+
+=========================
+KERNEL DEBUGGING WITH GDB
+=========================
+
+Set the serial port on the computer that's going to run GDB to the appropriate
+baud rate. Assuming the board's debug port is connected to ttyS0/COM1 on the
+computer doing the debugging:
+
+	stty -F /dev/ttyS0 115200
+
+Then start GDB in the base of the kernel tree:
+
+	frv-uclinux-gdb linux		[uClinux]
+
+Or:
+
+	frv-uclinux-gdb vmlinux		[MMU linux]
+
+When the prompt appears:
+
+	GNU gdb frv-031024
+	Copyright 2003 Free Software Foundation, Inc.
+	GDB is free software, covered by the GNU General Public License, and you are
+	welcome to change it and/or distribute copies of it under certain conditions.
+	Type "show copying" to see the conditions.
+	There is absolutely no warranty for GDB.  Type "show warranty" for details.
+	This GDB was configured as "--host=i686-pc-linux-gnu --target=frv-uclinux"...
+	(gdb) 
+
+Attach to the board like this:
+
+        (gdb) target remote /dev/ttyS0
+	Remote debugging using /dev/ttyS0
+	start_kernel () at init/main.c:395
+	(gdb) 
+
+This should show the appropriate lines from the source too. The kernel can
+then be debugged almost as if it's any other program.
+
+
+===============================
+INTERRUPTING THE RUNNING KERNEL
+===============================
+
+The kernel can be interrupted whilst it is running, causing a jump back to the
+GDB stub and the debugger:
+
+  (*) Pressing Ctrl-C in GDB. This will cause GDB to try and interrupt the
+      kernel by sending an RS232 BREAK over the serial line to the GDB
+      stub. This will (mostly) immediately interrupt the kernel and return it
+      to the debugger.
+
+  (*) Pressing the NMI button on the board will also cause a jump into the
+      debugger.
+
+  (*) Setting a software breakpoint. This sets a break instruction at the
+      desired location which the GDB stub then traps the exception for.
+
+  (*) Setting a hardware breakpoint. The GDB stub is capable of using the IBAR
+      and DBAR registers to assist debugging.
+
+Furthermore, the GDB stub will intercept a number of exceptions automatically
+if they are caused by kernel execution. It will also intercept BUG() macro
+invokation.
+
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/mmu-layout.txt linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/mmu-layout.txt
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/mmu-layout.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/mmu-layout.txt	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,306 @@
+				 =================================
+				 FR451 MMU LINUX MEMORY MANAGEMENT
+				 =================================
+
+============
+MMU HARDWARE
+============
+
+FR451 MMU Linux puts the MMU into EDAT mode whilst running. This means that it uses both the SAT
+registers and the DAT TLB to perform address translation.
+
+There are 8 IAMLR/IAMPR register pairs and 16 DAMLR/DAMPR register pairs for SAT mode.
+
+In DAT mode, there is also a TLB organised in cache format as 64 lines x 2 ways. Each line spans a
+16KB range of addresses, but can match a larger region.
+
+
+===========================
+MEMORY MANAGEMENT REGISTERS
+===========================
+
+Certain control registers are used by the kernel memory management routines:
+
+	REGISTERS		USAGE
+	======================	==================================================
+	IAMR0, DAMR0		Kernel image and data mappings
+	IAMR1, DAMR1		First-chance TLB lookup mapping
+	DAMR2			Page attachment for cache flush by page
+	DAMR3			Current PGD mapping
+	SCR0, DAMR4		Instruction TLB PGE/PTD cache
+	SCR1, DAMR5		Data TLB PGE/PTD cache
+	DAMR6-10		kmap_atomic() mappings
+	DAMR11			I/O mapping
+	CXNR			mm_struct context ID
+	TTBR			Page directory (PGD) pointer (physical address)
+
+
+=====================
+GENERAL MEMORY LAYOUT
+=====================
+
+The physical memory layout is as follows:
+
+  PHYSICAL ADDRESS	CONTROLLER	DEVICE
+  ===================	==============	=======================================
+  00000000 - BFFFFFFF	SDRAM		SDRAM area
+  E0000000 - EFFFFFFF	L-BUS CS2#	VDK SLBUS/PCI window
+  F0000000 - F0FFFFFF	L-BUS CS5#	MB93493 CSC area (DAV daughter board)
+  F1000000 - F1FFFFFF	L-BUS CS7#	(CB70 CPU-card PCMCIA port I/O space)
+  FC000000 - FC0FFFFF	L-BUS CS1#	VDK MB86943 config space
+  FC100000 - FC1FFFFF	L-BUS CS6#	DM9000 NIC I/O space
+  FC200000 - FC2FFFFF	L-BUS CS3#	MB93493 CSR area (DAV daughter board)
+  FD000000 - FDFFFFFF	L-BUS CS4#	(CB70 CPU-card extra flash space)
+  FE000000 - FEFFFFFF			Internal CPU peripherals
+  FF000000 - FF1FFFFF	L-BUS CS0#	Flash 1
+  FF200000 - FF3FFFFF	L-BUS CS0#	Flash 2
+  FFC00000 - FFC0001F	L-BUS CS0#	FPGA
+
+The virtual memory layout is:
+
+  VIRTUAL ADDRESS    PHYSICAL	TRANSLATOR	FLAGS	SIZE	OCCUPATION
+  =================  ========	==============	=======	=======	===================================
+  00004000-BFFFFFFF  various	TLB,xAMR1	D-N-??V	3GB	Userspace
+  C0000000-CFFFFFFF  00000000	xAMPR0		-L-S--V	256MB	Kernel image and data
+  D0000000-D7FFFFFF  various	TLB,xAMR1	D-NS??V	128MB	vmalloc area
+  D8000000-DBFFFFFF  various	TLB,xAMR1	D-NS??V	64MB	kmap() area
+  DC000000-DCFFFFFF  various	TLB			1MB	Secondary kmap_atomic() frame
+  DD000000-DD27FFFF  various	DAMR			160KB	Primary kmap_atomic() frame
+  DD040000			DAMR2/IAMR2	-L-S--V	page	Page cache flush attachment point
+  DD080000			DAMR3		-L-SC-V	page	Page Directory (PGD)
+  DD0C0000			DAMR4		-L-SC-V	page	Cached insn TLB Page Table lookup
+  DD100000			DAMR5		-L-SC-V	page	Cached data TLB Page Table lookup
+  DD140000			DAMR6		-L-S--V	page	kmap_atomic(KM_BOUNCE_READ)
+  DD180000			DAMR7		-L-S--V	page	kmap_atomic(KM_SKB_SUNRPC_DATA)
+  DD1C0000			DAMR8		-L-S--V	page	kmap_atomic(KM_SKB_DATA_SOFTIRQ)
+  DD200000			DAMR9		-L-S--V	page	kmap_atomic(KM_USER0)
+  DD240000			DAMR10		-L-S--V	page	kmap_atomic(KM_USER1)
+  E0000000-FFFFFFFF  E0000000	DAMR11		-L-SC-V	512MB	I/O region
+
+IAMPR1 and DAMPR1 are used as an extension to the TLB.
+
+
+====================
+KMAP AND KMAP_ATOMIC
+====================
+
+To access pages in the page cache (which may not be directly accessible if highmem is available),
+the kernel calls kmap(), does the access and then calls kunmap(); or it calls kmap_atomic(), does
+the access and then calls kunmap_atomic().
+
+kmap() creates an attachment between an arbitrary inaccessible page and a range of virtual
+addresses by installing a PTE in a special page table. The kernel can then access this page as it
+wills. When it's finished, the kernel calls kunmap() to clear the PTE.
+
+kmap_atomic() does something slightly different. In the interests of speed, it chooses one of two
+strategies:
+
+ (1) If possible, kmap_atomic() attaches the requested page to one of DAMPR5 through DAMPR10
+     register pairs; and the matching kunmap_atomic() clears the DAMPR. This makes high memory
+     support really fast as there's no need to flush the TLB or modify the page tables. The DAMLR
+     registers being used for this are preset during boot and don't change over the lifetime of the
+     process. There's a direct mapping between the first few kmap_atomic() types, DAMR number and
+     virtual address slot.
+
+     However, there are more kmap_atomic() types defined than there are DAMR registers available,
+     so we fall back to:
+
+ (2) kmap_atomic() uses a slot in the secondary frame (determined by the type parameter), and then
+     locks an entry in the TLB to translate that slot to the specified page. The number of slots is
+     obviously limited, and their positions are controlled such that each slot is matched by a
+     different line in the TLB. kunmap() ejects the entry from the TLB.
+
+Note that the first three kmap atomic types are really just declared as placeholders. The DAMPR
+registers involved are actually modified directly.
+
+Also note that kmap() itself may sleep, kmap_atomic() may never sleep and both always succeed;
+furthermore, a driver using kmap() may sleep before calling kunmap(), but may not sleep before
+calling kunmap_atomic() if it had previously called kmap_atomic().
+
+
+===============================
+USING MORE THAN 256MB OF MEMORY
+===============================
+
+The kernel cannot access more than 256MB of memory directly. The physical layout, however, permits
+up to 3GB of SDRAM (possibly 3.25GB) to be made available. By using CONFIG_HIGHMEM, the kernel can
+allow userspace (by way of page tables) and itself (by way of kmap) to deal with the memory
+allocation.
+
+External devices can, of course, still DMA to and from all of the SDRAM, even if the kernel can't
+see it directly. The kernel translates page references into real addresses for communicating to the
+devices.
+
+
+===================
+PAGE TABLE TOPOLOGY
+===================
+
+The page tables are arranged in 2-layer format. There is a middle layer (PMD) that would be used in
+3-layer format tables but that is folded into the top layer (PGD) and so consumes no extra memory
+or processing power.
+
+  +------+     PGD    PMD
+  | TTBR |--->+-------------------+
+  +------+    |      |      : STE |
+              | PGE0 | PME0 : STE |
+              |      |      : STE |
+              +-------------------+              Page Table
+              |      |      : STE -------------->+--------+ +0x0000
+              | PGE1 | PME0 : STE -----------+   | PTE0   |
+              |      |      : STE -------+   |   +--------+
+              +-------------------+      |   |   | PTE63  |
+              |      |      : STE |      |   +-->+--------+ +0x0100
+              | PGE2 | PME0 : STE |      |       | PTE64  |
+              |      |      : STE |      |       +--------+
+              +-------------------+      |       | PTE127 |
+              |      |      : STE |      +------>+--------+ +0x0200
+              | PGE3 | PME0 : STE |              | PTE128 |
+              |      |      : STE |              +--------+
+              +-------------------+              | PTE191 |
+                                                 +--------+ +0x0300
+
+Each Page Directory (PGD) is 16KB (page size) in size and is divided into 64 entries (PGEs). Each
+PGE contains one Page Mid Directory (PMD).
+
+Each PMD is 256 bytes in size and contains a single entry (PME). Each PME holds 64 FR451 MMU
+segment table entries of 4 bytes apiece. Each PME "points to" a page table. In practice, each STE
+points to a subset of the page table, the first to PT+0x0000, the second to PT+0x0100, the third to
+PT+0x200, and so on.
+
+Each PGE and PME covers 64MB of the total virtual address space.
+
+Each Page Table (PTD) is 16KB (page size) in size, and is divided into 4096 entries (PTEs). Each
+entry can point to one 16KB page. In practice, each Linux page table is subdivided into 64 FR451
+MMU page tables. But they are all grouped together to make management easier, in particular rmap
+support is then trivial.
+
+Grouping page tables in this fashion makes PGE caching in SCR0/SCR1 more efficient because the
+coverage of the cached item is greater.
+
+Page tables for the vmalloc area are allocated at boot time and shared between all mm_structs.
+
+
+=================
+USER SPACE LAYOUT
+=================
+
+For MMU capable Linux, the regions userspace code are allowed to access are kept entirely separate
+from those dedicated to the kernel:
+
+	VIRTUAL ADDRESS    SIZE   PURPOSE
+	=================  =====  ===================================
+	00000000-00003fff  4KB    NULL pointer access trap
+	00004000-01ffffff  ~32MB  lower mmap space (grows up)
+	02000000-021fffff  2MB    Stack space (grows down from top)
+	02200000-nnnnnnnn         Executable mapping
+        nnnnnnnn-                 brk space (grows up)
+	        -bfffffff         upper mmap space (grows down)
+
+This is so arranged so as to make best use of the 16KB page tables and the way in which PGEs/PMEs
+are cached by the TLB handler. The lower mmap space is filled first, and then the upper mmap space
+is filled.
+
+
+===============================
+GDB-STUB MMU DEBUGGING SERVICES
+===============================
+
+The gdb-stub included in this kernel provides a number of services to aid in the debugging of MMU
+related kernel services:
+
+ (*) Every time the kernel stops, certain state information is dumped into __debug_mmu. This
+     variable is defined in arch/frv/kernel/gdb-stub.c. Note that the gdbinit file in this
+     directory has some useful macros for dealing with this.
+
+     (*) __debug_mmu.tlb[]
+
+	 This receives the current TLB contents. This can be viewed with the _tlb GDB macro:
+
+		(gdb) _tlb
+		tlb[0x00]: 01000005 00718203  01000002 00718203
+		tlb[0x01]: 01004002 006d4201  01004005 006d4203
+		tlb[0x02]: 01008002 006d0201  01008006 00004200
+		tlb[0x03]: 0100c006 007f4202  0100c002 0064c202
+		tlb[0x04]: 01110005 00774201  01110002 00774201
+		tlb[0x05]: 01114005 00770201  01114002 00770201
+		tlb[0x06]: 01118002 0076c201  01118005 0076c201
+		...
+		tlb[0x3d]: 010f4002 00790200  001f4002 0054ca02
+		tlb[0x3e]: 010f8005 0078c201  010f8002 0078c201
+		tlb[0x3f]: 001fc002 0056ca01  001fc005 00538a01
+
+     (*) __debug_mmu.iamr[]
+     (*) __debug_mmu.damr[]
+
+	 These receive the current IAMR and DAMR contents. These can be viewed with with the _amr
+	 GDB macro:
+
+		(gdb) _amr
+		AMRx           DAMR                    IAMR         
+		====   =====================   =====================
+		amr0 : L:c0000000 P:00000cb9 : L:c0000000 P:000004b9
+		amr1 : L:01070005 P:006f9203 : L:0102c005 P:006a1201
+		amr2 : L:d8d00000 P:00000000 : L:d8d00000 P:00000000
+		amr3 : L:d8d04000 P:00534c0d : L:00000000 P:00000000
+		amr4 : L:d8d08000 P:00554c0d : L:00000000 P:00000000
+		amr5 : L:d8d0c000 P:00554c0d : L:00000000 P:00000000
+		amr6 : L:d8d10000 P:00000000 : L:00000000 P:00000000
+		amr7 : L:d8d14000 P:00000000 : L:00000000 P:00000000
+		amr8 : L:d8d18000 P:00000000
+		amr9 : L:d8d1c000 P:00000000
+		amr10: L:d8d20000 P:00000000
+		amr11: L:e0000000 P:e0000ccd
+
+ (*) The current task's page directory is bound to DAMR3.
+
+     This can be viewed with the _pgd GDB macro:
+	
+	(gdb) _pgd
+	$3 = {{pge = {{ste = {0x554001, 0x554101, 0x554201, 0x554301, 0x554401, 
+		  0x554501, 0x554601, 0x554701, 0x554801, 0x554901, 0x554a01, 
+		  0x554b01, 0x554c01, 0x554d01, 0x554e01, 0x554f01, 0x555001, 
+		  0x555101, 0x555201, 0x555301, 0x555401, 0x555501, 0x555601, 
+		  0x555701, 0x555801, 0x555901, 0x555a01, 0x555b01, 0x555c01, 
+		  0x555d01, 0x555e01, 0x555f01, 0x556001, 0x556101, 0x556201, 
+		  0x556301, 0x556401, 0x556501, 0x556601, 0x556701, 0x556801, 
+		  0x556901, 0x556a01, 0x556b01, 0x556c01, 0x556d01, 0x556e01, 
+		  0x556f01, 0x557001, 0x557101, 0x557201, 0x557301, 0x557401, 
+		  0x557501, 0x557601, 0x557701, 0x557801, 0x557901, 0x557a01, 
+		  0x557b01, 0x557c01, 0x557d01, 0x557e01, 0x557f01}}}}, {pge = {{
+		ste = {0x0 <repeats 64 times>}}}} <repeats 51 times>, {pge = {{ste = {
+		  0x248001, 0x248101, 0x248201, 0x248301, 0x248401, 0x248501, 
+		  0x248601, 0x248701, 0x248801, 0x248901, 0x248a01, 0x248b01, 
+		  0x248c01, 0x248d01, 0x248e01, 0x248f01, 0x249001, 0x249101, 
+		  0x249201, 0x249301, 0x249401, 0x249501, 0x249601, 0x249701, 
+		  0x249801, 0x249901, 0x249a01, 0x249b01, 0x249c01, 0x249d01, 
+		  0x249e01, 0x249f01, 0x24a001, 0x24a101, 0x24a201, 0x24a301, 
+		  0x24a401, 0x24a501, 0x24a601, 0x24a701, 0x24a801, 0x24a901, 
+		  0x24aa01, 0x24ab01, 0x24ac01, 0x24ad01, 0x24ae01, 0x24af01, 
+		  0x24b001, 0x24b101, 0x24b201, 0x24b301, 0x24b401, 0x24b501, 
+		  0x24b601, 0x24b701, 0x24b801, 0x24b901, 0x24ba01, 0x24bb01, 
+		  0x24bc01, 0x24bd01, 0x24be01, 0x24bf01}}}}, {pge = {{ste = {
+		  0x0 <repeats 64 times>}}}} <repeats 11 times>}
+
+ (*) The PTD last used by the instruction TLB miss handler is attached to DAMR4.
+ (*) The PTD last used by the data TLB miss handler is attached to DAMR5.
+
+     These can be viewed with the _ptd_i and _ptd_d GDB macros:
+
+	(gdb) _ptd_d
+	$5 = {{pte = 0x0} <repeats 127 times>, {pte = 0x539b01}, {
+	    pte = 0x0} <repeats 896 times>, {pte = 0x719303}, {pte = 0x6d5303}, {
+	    pte = 0x0}, {pte = 0x0}, {pte = 0x0}, {pte = 0x0}, {pte = 0x0}, {
+	    pte = 0x0}, {pte = 0x0}, {pte = 0x0}, {pte = 0x0}, {pte = 0x6a1303}, {
+	    pte = 0x0} <repeats 12 times>, {pte = 0x709303}, {pte = 0x0}, {pte = 0x0}, 
+	  {pte = 0x6fd303}, {pte = 0x6f9303}, {pte = 0x6f5303}, {pte = 0x0}, {
+	    pte = 0x6ed303}, {pte = 0x531b01}, {pte = 0x50db01}, {
+	    pte = 0x0} <repeats 13 times>, {pte = 0x5303}, {pte = 0x7f5303}, {
+	    pte = 0x509b01}, {pte = 0x505b01}, {pte = 0x7c9303}, {pte = 0x7b9303}, {
+	    pte = 0x7b5303}, {pte = 0x7b1303}, {pte = 0x7ad303}, {pte = 0x0}, {
+	    pte = 0x0}, {pte = 0x7a1303}, {pte = 0x0}, {pte = 0x795303}, {pte = 0x0}, {
+	    pte = 0x78d303}, {pte = 0x0}, {pte = 0x0}, {pte = 0x0}, {pte = 0x0}, {
+	    pte = 0x0}, {pte = 0x775303}, {pte = 0x771303}, {pte = 0x76d303}, {
+	    pte = 0x0}, {pte = 0x765303}, {pte = 0x7c5303}, {pte = 0x501b01}, {
+	    pte = 0x4f1b01}, {pte = 0x4edb01}, {pte = 0x0}, {pte = 0x4f9b01}, {
+	    pte = 0x4fdb01}, {pte = 0x0} <repeats 2992 times>}
diff -uNrp /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/README.txt linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/README.txt
--- /warthog/kernels/linux-2.6.10-rc1-mm3/Documentation/fujitsu/frv/README.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10-rc1-mm3-frv/Documentation/fujitsu/frv/README.txt	2004-11-05 14:13:03.000000000 +0000
@@ -0,0 +1,51 @@
+		       ================================
+		       Fujitsu FR-V LINUX DOCUMENTATION
+		       ================================
+
+This directory contains documentation for the Fujitsu FR-V CPU architecture
+port of Linux.
+
+The following documents are available:
+
+ (*) features.txt
+
+     A description of the basic features inherent in this architecture port.
+
+
+ (*) configuring.txt
+
+     A summary of the configuration options particular to this architecture.
+
+
+ (*) booting.txt
+
+     A description of how to boot the kernel image and a summary of the kernel
+     command line options.
+
+
+ (*) gdbstub.txt
+
+     A description of how to debug the kernel using GDB attached by serial
+     port, and a summary of the services available.
+
+
+ (*) mmu-layout.txt
+
+     A description of the virtual and physical memory layout used in the
+     MMU linux kernel, and the registers used to support it.
+
+
+ (*) gdbinit
+
+     An example .gdbinit file for use with GDB. It includes macros for viewing
+     MMU state on the FR451. See mmu-layout.txt for more information.
+
+
+ (*) clock.txt
+
+     A description of the CPU clock scaling interface.
+
+
+ (*) atomic-ops.txt
+
+     A description of how the FR-V kernel's atomic operations work.
