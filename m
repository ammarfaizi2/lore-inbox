Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbUCPQmB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUCPQlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:41:07 -0500
Received: from linux.us.dell.com ([143.166.224.162]:18376 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263995AbUCPQYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:24:54 -0500
Date: Tue, 16 Mar 2004 10:23:44 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: ak@suse.de, akpm@osdl.org, davej@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] let EDD work on x86-64 too
Message-ID: <20040316162344.GA20289@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andi, I'm proposing allowing my BIOS Enhanced Disk Drive (EDD) code to
work on x86-64 as it does on x86 today.  The patch below moves some
files around out of arch/i386/kernel and include/asm-i386 into more
generic locations, and allows EDD to work.  I've tested this against BK-cur=
rent
(from my POV it's 2.6.4 plus the edd-legacychs patch Andrew forwarded
to Linus and is now in BK); I see there will be conflicts with the
empty_zero_page-cleanup.patch which is in -mm right now - they're just
comment conflicts, but I'll need to clean that up once it's in BK.

Feedback welcome.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


ChangeSet@1.1631, 2004-03-16 10:02:58-06:00, Matt_Domsch@dell.com
  EDD: perform EDD calls on x86_64, move edd.c to new dir drivers/firmware
 =20
  This patch allows the BIOS EDD code, previously built only for x86, to be
  built and used on x86_64 as well, with minimal duplication of code.
 =20
  arch/i386/kernel/edd.c moves to drivers/firmware/edd.c
  include/asm-i386/edd.h moves to include/linux/edd.h
  EDD assembly code moves from arch/i386/boot/setup.S into arch/i386/boot/e=
dd.S
  and is #included into setup.S for both i386 and x86_64 arches.


 arch/i386/kernel/edd.c               |  837 ------------------------------=
-----
 b/Documentation/x86_64/zero-page.txt |   84 +++
 b/arch/i386/Kconfig                  |   11=20
 b/arch/i386/boot/edd.S               |  127 +++++
 b/arch/i386/boot/setup.S             |  125 -----
 b/arch/i386/kernel/Makefile          |    1=20
 b/arch/i386/kernel/setup.c           |    2=20
 b/arch/x86_64/Kconfig                |    2=20
 b/arch/x86_64/boot/setup.S           |    2=20
 b/arch/x86_64/defconfig              |    1=20
 b/arch/x86_64/kernel/setup.c         |   26 +
 b/drivers/Makefile                   |    1=20
 b/drivers/firmware/Kconfig           |   19=20
 b/drivers/firmware/Makefile          |    4=20
 b/drivers/firmware/edd.c             |  837 ++++++++++++++++++++++++++++++=
+++++
 b/include/asm-x86_64/bootsetup.h     |    3=20
 b/include/linux/edd.h                |  181 +++++++
 include/asm-i386/edd.h               |  180 -------
 18 files changed, 1290 insertions, 1153 deletions


diff -Nru a/Documentation/x86_64/zero-page.txt b/Documentation/x86_64/zero-=
page.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/x86_64/zero-page.txt	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,84 @@
+Summary of empty_zero_page layout (kernel point of view)
+     ( collected by Hans Lermen and Martin Mares )
+=20
+The contents of empty_zero_page are used to pass parameters from the
+16-bit realmode code of the kernel to the 32-bit part. References/settings
+to it mainly are in:
+
+  arch/i386/boot/setup.S
+  arch/i386/boot/video.S
+  arch/i386/kernel/head.S
+  arch/i386/kernel/setup.c
+=20
+
+Offset	Type		Description
+------  ----		-----------
+    0	32 bytes	struct screen_info, SCREEN_INFO
+			ATTENTION, overlaps the following !!!
+    2	unsigned short	EXT_MEM_K, extended memory size in Kb (from int 0x15)
+ 0x20	unsigned short	CL_MAGIC, commandline magic number (=3D0xA33F)
+ 0x22	unsigned short	CL_OFFSET, commandline offset
+			Address of commandline is calculated:
+			  0x90000 + contents of CL_OFFSET
+			(only taken, when CL_MAGIC =3D 0xA33F)
+ 0x40	20 bytes	struct apm_bios_info, APM_BIOS_INFO
+ 0x60	16 bytes	Intel SpeedStep (IST) BIOS support information
+ 0x80	16 bytes	hd0-disk-parameter from intvector 0x41
+ 0x90	16 bytes	hd1-disk-parameter from intvector 0x46
+
+ 0xa0	16 bytes	System description table truncated to 16 bytes.
+			( struct sys_desc_table_struct )
+ 0xb0 - 0x1c3		Free. Add more parameters here if you really need them.
+
+0x1c4	unsigned long	EFI system table pointer
+0x1c8	unsigned long	EFI memory descriptor size
+0x1cc	unsigned long	EFI memory descriptor version
+0x1d0	unsigned long	EFI memory descriptor map pointer
+0x1d4	unsigned long	EFI memory descriptor map size
+0x1e0	unsigned long	ALT_MEM_K, alternative mem check, in Kb
+0x1e8	char		number of entries in E820MAP (below)
+0x1e9	unsigned char	number of entries in EDDBUF (below)
+0x1f1	char		size of setup.S, number of sectors
+0x1f2	unsigned short	MOUNT_ROOT_RDONLY (if !=3D0)
+0x1f4	unsigned short	size of compressed kernel-part in the
+			(b)zImage-file (in 16 byte units, rounded up)
+0x1f6	unsigned short	swap_dev (unused AFAIK)
+0x1f8	unsigned short	RAMDISK_FLAGS
+0x1fa	unsigned short	VGA-Mode (old one)
+0x1fc	unsigned short	ORIG_ROOT_DEV (high=3DMajor, low=3Dminor)
+0x1ff	char		AUX_DEVICE_INFO
+
+0x200	short jump to start of setup code aka "reserved" field.
+0x202	4 bytes		Signature for SETUP-header, =3D"HdrS"
+0x206	unsigned short	Version number of header format
+			Current version is 0x0201...
+0x208	8 bytes		(used by setup.S for communication with boot loaders,
+			 look there)
+0x210	char		LOADER_TYPE, =3D 0, old one
+			else it is set by the loader:
+			0xTV: T=3D0 for LILO
+				1 for Loadlin
+				2 for bootsect-loader
+				3 for SYSLINUX
+				4 for ETHERBOOT
+				V =3D version
+0x211	char		loadflags:
+			bit0 =3D 1: kernel is loaded high (bzImage)
+			bit7 =3D 1: Heap and pointer (see below) set by boot
+				  loader.
+0x212	unsigned short	(setup.S)
+0x214	unsigned long	KERNEL_START, where the loader started the kernel
+0x218	unsigned long	INITRD_START, address of loaded ramdisk image
+0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
+0x220	4 bytes		(setup.S)
+0x224	unsigned short	setup.S heap end pointer
+0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
+0x2d0 - 0x600		E820MAP
+0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
+0x600 - 0x7eb		EDDBUF (setup.S) for edd data
+
+0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
+			copied using CL_OFFSET.
+			Note: this will be copied once more by setup.c
+			into a local buffer which is only 256 bytes long.
+			( #define COMMAND_LINE_SIZE 256 )
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Mar 16 10:03:36 2004
+++ b/arch/i386/Kconfig	Tue Mar 16 10:03:36 2004
@@ -637,16 +637,7 @@
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
=20
-config EDD
-	tristate "BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTA=
L)"
-	depends on EXPERIMENTAL
-	help
-	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
-	  Services real mode BIOS calls to determine which disk
-	  BIOS tries boot from.  This information is then exported via driverfs.
-
-	  This option is experimental, but believed to be safe,
-	  and most disk controller BIOS vendors do not yet implement this feature.
+source "drivers/firmware/Kconfig"
=20
 choice
 	prompt "High Memory Support"
diff -Nru a/arch/i386/boot/edd.S b/arch/i386/boot/edd.S
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/boot/edd.S	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,127 @@
+/*
+ * BIOS Enhanced Disk Drive support
+ * by Matt Domsch <Matt_Domsch@dell.com> October 2002
+ * conformant to T13 Committee www.t13.org
+ *   projects 1572D, 1484D, 1386D, 1226DT
+ * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
+ *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
+ * legacy CHS retreival by Patrick J. LoPresti <patl@users.sourceforge.net>
+ *      March 2004
+ */
+
+#include <linux/edd.h>
+
+#if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+# Read the first sector of device 80h and store the 4-byte signature
+	movl	$0xFFFFFFFF, %eax
+	movl	%eax, (DISK80_SIG_BUFFER)	# assume failure
+	movb	$READ_SECTORS, %ah
+	movb	$1, %al				# read 1 sector
+	movb	$0x80, %dl			# from device 80
+	movb	$0, %dh				# at head 0
+	movw	$1, %cx				# cylinder 0, sector 0
+	pushw	%es
+	pushw	%ds
+	popw	%es
+	movw	$EDDBUF, %bx
+	pushw   %dx             # work around buggy BIOSes
+	stc                     # work around buggy BIOSes
+	int     $0x13
+	sti                     # work around buggy BIOSes
+	popw    %dx
+	jc	disk_sig_done
+	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
+	movl	%eax, (DISK80_SIG_BUFFER)	# store success
+disk_sig_done:
+	popw	%es
+
+# Do the BIOS Enhanced Disk Drive calls
+# This consists of two calls:
+#    int 13h ah=3D41h "Check Extensions Present"
+#    int 13h ah=3D48h "Get Device Parameters"
+#    int 13h ah=3D08h "Legacy Get Device Parameters"
+#
+# A buffer of size EDDMAXNR*(EDDEXTSIZE+EDDPARMSIZE) is reserved for our u=
se
+# in the empty_zero_page at EDDBUF.  The first four bytes of which are
+# used to store the device number, interface support map and version
+# results from fn41.  The next four bytes are used to store the legacy
+# cylinders, heads, and sectors from fn08. The following 74 bytes are used=
 to
+# store the results from fn48.  Starting from device 80h, fn41, then fn48
+# are called and their results stored in EDDBUF+n*(EDDEXTSIZE+EDDPARMIZE).
+# Then the pointer is incremented to store the data for the next call.
+# This repeats until either a device doesn't exist, or until EDDMAXNR
+# devices have been stored.
+# The one tricky part is that ds:si always points EDDEXTSIZE bytes into
+# the structure, and the fn41 and fn08 results are stored at offsets
+# from there.  This removes the need to increment the pointer for
+# every store, and leaves it ready for the fn48 call.
+# A second one-byte buffer, EDDNR, in the empty_zero_page stores
+# the number of BIOS devices which exist, up to EDDMAXNR.
+# In setup.c, copy_edd() stores both empty_zero_page buffers away
+# for later use, as they would get overwritten otherwise.
+# This code is sensitive to the size of the structs in edd.h
+edd_start:
+						# %ds points to the bootsector
+       						# result buffer for fn48
+	movw	$EDDBUF+EDDEXTSIZE, %si		# in ds:si, fn41 results
+						# kept just before that
+	movb	$0, (EDDNR)			# zero value at EDDNR
+	movb	$0x80, %dl			# BIOS device 0x80
+
+edd_check_ext:
+	movb	$CHECKEXTENSIONSPRESENT, %ah    # Function 41
+	movw	$EDDMAGIC1, %bx			# magic
+	int	$0x13				# make the call
+	jc	edd_done			# no more BIOS devices
+
+	cmpw	$EDDMAGIC2, %bx			# is magic right?
+	jne	edd_next			# nope, next...
+
+	movb	%dl, %ds:-8(%si)		# store device number
+	movb	%ah, %ds:-7(%si)		# store version
+	movw	%cx, %ds:-6(%si)		# store extensions
+	incb	(EDDNR)				# note that we stored something
+
+edd_get_device_params:
+	movw	$EDDPARMSIZE, %ds:(%si)		# put size
+	movw	$0x0, %ds:2(%si)		# work around buggy BIOSes
+	movb	$GETDEVICEPARAMETERS, %ah	# Function 48
+	int	$0x13				# make the call
+						# Don't check for fail return
+						# it doesn't matter.
+edd_get_legacy_chs:
+	xorw    %ax, %ax
+	movw    %ax, %ds:-4(%si)
+	movw    %ax, %ds:-2(%si)
+        # Ralf Brown's Interrupt List says to set ES:DI to
+	# 0000h:0000h "to guard against BIOS bugs"
+	pushw   %es
+	movw    %ax, %es
+	movw    %ax, %di
+	pushw   %dx                             # legacy call clobbers %dl
+	movb    $LEGACYGETDEVICEPARAMETERS, %ah # Function 08
+	int     $0x13                           # make the call
+	jc      edd_legacy_done                 # failed
+	movb    %cl, %al                        # Low 6 bits are max
+	andb    $0x3F, %al                      #   sector number
+	movb	%al, %ds:-1(%si)                # Record max sect
+	movb    %dh, %ds:-2(%si)                # Record max head number
+	movb    %ch, %al                        # Low 8 bits of max cyl
+	shr     $6, %cl
+	movb    %cl, %ah                        # High 2 bits of max cyl
+	movw    %ax, %ds:-4(%si)
+
+edd_legacy_done:
+	popw    %dx
+	popw    %es
+	movw	%si, %ax			# increment si
+	addw	$EDDPARMSIZE+EDDEXTSIZE, %ax
+	movw	%ax, %si
+
+edd_next:
+	incb	%dl				# increment to next device
+	cmpb	$EDDMAXNR, (EDDNR) 		# Out of space?
+	jb	edd_check_ext			# keep looping
+
+edd_done:
+#endif
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Tue Mar 16 10:03:36 2004
+++ b/arch/i386/boot/setup.S	Tue Mar 16 10:03:36 2004
@@ -44,15 +44,6 @@
  *
  * New A20 code ported from SYSLINUX by H. Peter Anvin. AMD Elan bugfixes
  * by Robert Schwebel, December 2001 <robert@schwebel.de>
- *   =20
- * BIOS Enhanced Disk Drive support
- * by Matt Domsch <Matt_Domsch@dell.com> October 2002
- * conformant to T13 Committee www.t13.org
- *   projects 1572D, 1484D, 1386D, 1226DT
- * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
- *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
- * legacy CHS retreival by Patrick J. LoPresti <patl@users.sourceforge.net>
- *      March 2004
  */
=20
 #include <linux/config.h>
@@ -61,7 +52,6 @@
 #include <linux/compile.h>
 #include <asm/boot.h>
 #include <asm/e820.h>
-#include <asm/edd.h>   =20
 #include <asm/page.h>
 =09
 /* Signature words to ensure LILO loaded us right */
@@ -581,120 +571,7 @@
 done_apm_bios:
 #endif
=20
-#if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
-# Read the first sector of device 80h and store the 4-byte signature
-	movl	$0xFFFFFFFF, %eax
-	movl	%eax, (DISK80_SIG_BUFFER)	# assume failure
-	movb	$READ_SECTORS, %ah
-	movb	$1, %al				# read 1 sector
-	movb	$0x80, %dl			# from device 80
-	movb	$0, %dh				# at head 0
-	movw	$1, %cx				# cylinder 0, sector 0
-	pushw	%es
-	pushw	%ds
-	popw	%es
-	movw	$EDDBUF, %bx
-	pushw   %dx             # work around buggy BIOSes
-	stc                     # work around buggy BIOSes
-	int     $0x13
-	sti                     # work around buggy BIOSes
-	popw    %dx
-	jc	disk_sig_done
-	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
-	movl	%eax, (DISK80_SIG_BUFFER)	# store success
-disk_sig_done:
-	popw	%es
-
-# Do the BIOS Enhanced Disk Drive calls
-# This consists of two calls:
-#    int 13h ah=3D41h "Check Extensions Present"
-#    int 13h ah=3D48h "Get Device Parameters"
-#    int 13h ah=3D08h "Legacy Get Device Parameters"
-#
-# A buffer of size EDDMAXNR*(EDDEXTSIZE+EDDPARMSIZE) is reserved for our u=
se
-# in the empty_zero_page at EDDBUF.  The first four bytes of which are
-# used to store the device number, interface support map and version
-# results from fn41.  The next four bytes are used to store the legacy
-# cylinders, heads, and sectors from fn08. The following 74 bytes are used=
 to
-# store the results from fn48.  Starting from device 80h, fn41, then fn48
-# are called and their results stored in EDDBUF+n*(EDDEXTSIZE+EDDPARMIZE).
-# Then the pointer is incremented to store the data for the next call.
-# This repeats until either a device doesn't exist, or until EDDMAXNR
-# devices have been stored.
-# The one tricky part is that ds:si always points EDDEXTSIZE bytes into
-# the structure, and the fn41 and fn08 results are stored at offsets
-# from there.  This removes the need to increment the pointer for
-# every store, and leaves it ready for the fn48 call.
-# A second one-byte buffer, EDDNR, in the empty_zero_page stores
-# the number of BIOS devices which exist, up to EDDMAXNR.
-# In setup.c, copy_edd() stores both empty_zero_page buffers away
-# for later use, as they would get overwritten otherwise.
-# This code is sensitive to the size of the structs in edd.h
-edd_start:
-						# %ds points to the bootsector
-       						# result buffer for fn48
-	movw	$EDDBUF+EDDEXTSIZE, %si		# in ds:si, fn41 results
-						# kept just before that
-	movb	$0, (EDDNR)			# zero value at EDDNR
-	movb	$0x80, %dl			# BIOS device 0x80
-
-edd_check_ext:
-	movb	$CHECKEXTENSIONSPRESENT, %ah    # Function 41
-	movw	$EDDMAGIC1, %bx			# magic
-	int	$0x13				# make the call
-	jc	edd_done			# no more BIOS devices
-
-	cmpw	$EDDMAGIC2, %bx			# is magic right?
-	jne	edd_next			# nope, next...
-
-	movb	%dl, %ds:-8(%si)		# store device number
-	movb	%ah, %ds:-7(%si)		# store version
-	movw	%cx, %ds:-6(%si)		# store extensions
-	incb	(EDDNR)				# note that we stored something
-
-edd_get_device_params:
-	movw	$EDDPARMSIZE, %ds:(%si)		# put size
-	movw	$0x0, %ds:2(%si)		# work around buggy BIOSes
-	movb	$GETDEVICEPARAMETERS, %ah	# Function 48
-	int	$0x13				# make the call
-						# Don't check for fail return
-						# it doesn't matter.
-edd_get_legacy_chs:
-	xorw    %ax, %ax
-	movw    %ax, %ds:-4(%si)
-	movw    %ax, %ds:-2(%si)
-        # Ralf Brown's Interrupt List says to set ES:DI to
-	# 0000h:0000h "to guard against BIOS bugs"
-	pushw   %es
-	movw    %ax, %es
-	movw    %ax, %di
-	pushw   %dx                             # legacy call clobbers %dl
-	movb    $LEGACYGETDEVICEPARAMETERS, %ah # Function 08
-	int     $0x13                           # make the call
-	jc      edd_legacy_done                 # failed
-	movb    %cl, %al                        # Low 6 bits are max
-	andb    $0x3F, %al                      #   sector number
-	movb	%al, %ds:-1(%si)                # Record max sect
-	movb    %dh, %ds:-2(%si)                # Record max head number
-	movb    %ch, %al                        # Low 8 bits of max cyl
-	shr     $6, %cl
-	movb    %cl, %ah                        # High 2 bits of max cyl
-	movw    %ax, %ds:-4(%si)
-
-edd_legacy_done:
-	popw    %dx
-	popw    %es
-	movw	%si, %ax			# increment si
-	addw	$EDDPARMSIZE+EDDEXTSIZE, %ax
-	movw	%ax, %si
-
-edd_next:
-	incb	%dl				# increment to next device
-	cmpb	$EDDMAXNR, (EDDNR) 		# Out of space?
-	jb	edd_check_ext			# keep looping
-
-edd_done:
-#endif
+#include "edd.S"
=20
 # Now we want to move to protected mode ...
 	cmpw	$0, %cs:realmode_swtch
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Tue Mar 16 10:03:36 2004
+++ b/arch/i386/kernel/Makefile	Tue Mar 16 10:03:36 2004
@@ -25,7 +25,6 @@
 obj-$(CONFIG_X86_IO_APIC)	+=3D io_apic.o
 obj-$(CONFIG_X86_NUMAQ)		+=3D numaq.o
 obj-$(CONFIG_X86_SUMMIT_NUMA)	+=3D summit.o
-obj-$(CONFIG_EDD)             	+=3D edd.o
 obj-$(CONFIG_MODULES)		+=3D module.o
 obj-y				+=3D sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+=3D srat.o
diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Tue Mar 16 10:03:36 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,837 +0,0 @@
-/*
- * linux/arch/i386/kernel/edd.c
- *  Copyright (C) 2002, 2003, 2004 Dell Inc.
- *  by Matt Domsch <Matt_Domsch@dell.com>
- *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
- *  legacy CHS by Patrick J. LoPresti <patl@users.sourceforge.net>
- *
- * BIOS Enhanced Disk Drive Services (EDD)
- * conformant to T13 Committee www.t13.org
- *   projects 1572D, 1484D, 1386D, 1226DT
- *
- * This code takes information provided by BIOS EDD calls
- * fn41 - Check Extensions Present and
- * fn48 - Get Device Parametes with EDD extensions
- * made in setup.S, copied to safe structures in setup.c,
- * and presents it in sysfs.
- *
- * Please see http://domsch.com/linux/edd30/results.html for
- * the list of BIOSs which have been reported to implement EDD.
- * If you don't see yours listed, please send a report as described there.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License v2.0 as published =
by
- * the Free Software Foundation
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-/*
- * Known issues:
- * - refcounting of struct device objects could be improved.
- *
- * TODO:
- * - Add IDE and USB disk device support
- * - move edd.[ch] to better locations if/when one is decided
- */
-
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/stat.h>
-#include <linux/err.h>
-#include <linux/ctype.h>
-#include <linux/slab.h>
-#include <linux/limits.h>
-#include <linux/device.h>
-#include <linux/pci.h>
-#include <linux/device.h>
-#include <linux/blkdev.h>
-#include <asm/edd.h>
-/* FIXME - this really belongs in include/scsi/scsi.h */
-#include <../drivers/scsi/scsi.h>
-#include <../drivers/scsi/hosts.h>
-
-MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
-MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
-MODULE_LICENSE("GPL");
-
-#define EDD_VERSION "0.13 2004-Mar-09"
-#define EDD_DEVICE_NAME_SIZE 16
-#define REPORT_URL "http://linux.dell.com/edd/results.html"
-
-#define left (PAGE_SIZE - (p - buf) - 1)
-
-struct edd_device {
-	struct edd_info *info;
-	struct kobject kobj;
-};
-
-struct edd_attribute {
-	struct attribute attr;
-	ssize_t(*show) (struct edd_device * edev, char *buf);
-	int (*test) (struct edd_device * edev);
-};
-
-/* forward declarations */
-static int edd_dev_is_type(struct edd_device *edev, const char *type);
-static struct pci_dev *edd_get_pci_dev(struct edd_device *edev);
-
-static struct edd_device *edd_devices[EDDMAXNR];
-
-#define EDD_DEVICE_ATTR(_name,_mode,_show,_test) \
-struct edd_attribute edd_attr_##_name =3D { 	\
-	.attr =3D {.name =3D __stringify(_name), .mode =3D _mode },	\
-	.show	=3D _show,				\
-	.test	=3D _test,				\
-};
-
-static inline struct edd_info *
-edd_dev_get_info(struct edd_device *edev)
-{
-	return edev->info;
-}
-
-static inline void
-edd_dev_set_info(struct edd_device *edev, struct edd_info *info)
-{
-	edev->info =3D info;
-}
-
-#define to_edd_attr(_attr) container_of(_attr,struct edd_attribute,attr)
-#define to_edd_device(obj) container_of(obj,struct edd_device,kobj)
-
-static ssize_t
-edd_attr_show(struct kobject * kobj, struct attribute *attr, char *buf)
-{
-	struct edd_device *dev =3D to_edd_device(kobj);
-	struct edd_attribute *edd_attr =3D to_edd_attr(attr);
-	ssize_t ret =3D 0;
-
-	if (edd_attr->show)
-		ret =3D edd_attr->show(dev, buf);
-	return ret;
-}
-
-static struct sysfs_ops edd_attr_ops =3D {
-	.show =3D edd_attr_show,
-};
-
-static ssize_t
-edd_show_host_bus(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	int i;
-
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	for (i =3D 0; i < 4; i++) {
-		if (isprint(info->params.host_bus_type[i])) {
-			p +=3D scnprintf(p, left, "%c", info->params.host_bus_type[i]);
-		} else {
-			p +=3D scnprintf(p, left, " ");
-		}
-	}
-
-	if (!strncmp(info->params.host_bus_type, "ISA", 3)) {
-		p +=3D scnprintf(p, left, "\tbase_address: %x\n",
-			     info->params.interface_path.isa.base_address);
-	} else if (!strncmp(info->params.host_bus_type, "PCIX", 4) ||
-		   !strncmp(info->params.host_bus_type, "PCI", 3)) {
-		p +=3D scnprintf(p, left,
-			     "\t%02x:%02x.%d  channel: %u\n",
-			     info->params.interface_path.pci.bus,
-			     info->params.interface_path.pci.slot,
-			     info->params.interface_path.pci.function,
-			     info->params.interface_path.pci.channel);
-	} else if (!strncmp(info->params.host_bus_type, "IBND", 4) ||
-		   !strncmp(info->params.host_bus_type, "XPRS", 4) ||
-		   !strncmp(info->params.host_bus_type, "HTPT", 4)) {
-		p +=3D scnprintf(p, left,
-			     "\tTBD: %llx\n",
-			     info->params.interface_path.ibnd.reserved);
-
-	} else {
-		p +=3D scnprintf(p, left, "\tunknown: %llx\n",
-			     info->params.interface_path.unknown.reserved);
-	}
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_interface(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	int i;
-
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	for (i =3D 0; i < 8; i++) {
-		if (isprint(info->params.interface_type[i])) {
-			p +=3D scnprintf(p, left, "%c", info->params.interface_type[i]);
-		} else {
-			p +=3D scnprintf(p, left, " ");
-		}
-	}
-	if (!strncmp(info->params.interface_type, "ATAPI", 5)) {
-		p +=3D scnprintf(p, left, "\tdevice: %u  lun: %u\n",
-			     info->params.device_path.atapi.device,
-			     info->params.device_path.atapi.lun);
-	} else if (!strncmp(info->params.interface_type, "ATA", 3)) {
-		p +=3D scnprintf(p, left, "\tdevice: %u\n",
-			     info->params.device_path.ata.device);
-	} else if (!strncmp(info->params.interface_type, "SCSI", 4)) {
-		p +=3D scnprintf(p, left, "\tid: %u  lun: %llu\n",
-			     info->params.device_path.scsi.id,
-			     info->params.device_path.scsi.lun);
-	} else if (!strncmp(info->params.interface_type, "USB", 3)) {
-		p +=3D scnprintf(p, left, "\tserial_number: %llx\n",
-			     info->params.device_path.usb.serial_number);
-	} else if (!strncmp(info->params.interface_type, "1394", 4)) {
-		p +=3D scnprintf(p, left, "\teui: %llx\n",
-			     info->params.device_path.i1394.eui);
-	} else if (!strncmp(info->params.interface_type, "FIBRE", 5)) {
-		p +=3D scnprintf(p, left, "\twwid: %llx lun: %llx\n",
-			     info->params.device_path.fibre.wwid,
-			     info->params.device_path.fibre.lun);
-	} else if (!strncmp(info->params.interface_type, "I2O", 3)) {
-		p +=3D scnprintf(p, left, "\tidentity_tag: %llx\n",
-			     info->params.device_path.i2o.identity_tag);
-	} else if (!strncmp(info->params.interface_type, "RAID", 4)) {
-		p +=3D scnprintf(p, left, "\tidentity_tag: %x\n",
-			     info->params.device_path.raid.array_number);
-	} else if (!strncmp(info->params.interface_type, "SATA", 4)) {
-		p +=3D scnprintf(p, left, "\tdevice: %u\n",
-			     info->params.device_path.sata.device);
-	} else {
-		p +=3D scnprintf(p, left, "\tunknown: %llx %llx\n",
-			     info->params.device_path.unknown.reserved1,
-			     info->params.device_path.unknown.reserved2);
-	}
-
-	return (p - buf);
-}
-
-/**
- * edd_show_raw_data() - copies raw data to buffer for userspace to parse
- *
- * Returns: number of bytes written, or -EINVAL on failure
- */
-static ssize_t
-edd_show_raw_data(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	ssize_t len =3D sizeof (info->params);
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	if (!(info->params.key =3D=3D 0xBEDD || info->params.key =3D=3D 0xDDBE))
-		len =3D info->params.length;
-
-	/* In case of buggy BIOSs */
-	if (len > (sizeof(info->params)))
-		len =3D sizeof(info->params);
-
-	memcpy(buf, &info->params, len);
-	return len;
-}
-
-static ssize_t
-edd_show_version(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%02x\n", info->version);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_disk80_sig(struct edd_device *edev, char *buf)
-{
-	char *p =3D buf;
-	p +=3D scnprintf(p, left, "0x%08x\n", edd_disk80_sig);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_extensions(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	if (info->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
-		p +=3D scnprintf(p, left, "Fixed disk access\n");
-	}
-	if (info->interface_support & EDD_EXT_DEVICE_LOCKING_AND_EJECTING) {
-		p +=3D scnprintf(p, left, "Device locking and ejecting\n");
-	}
-	if (info->interface_support & EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT) {
-		p +=3D scnprintf(p, left, "Enhanced Disk Drive support\n");
-	}
-	if (info->interface_support & EDD_EXT_64BIT_EXTENSIONS) {
-		p +=3D scnprintf(p, left, "64-bit extensions\n");
-	}
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_info_flags(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	if (info->params.info_flags & EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT)
-		p +=3D scnprintf(p, left, "DMA boundary error transparent\n");
-	if (info->params.info_flags & EDD_INFO_GEOMETRY_VALID)
-		p +=3D scnprintf(p, left, "geometry valid\n");
-	if (info->params.info_flags & EDD_INFO_REMOVABLE)
-		p +=3D scnprintf(p, left, "removable\n");
-	if (info->params.info_flags & EDD_INFO_WRITE_VERIFY)
-		p +=3D scnprintf(p, left, "write verify\n");
-	if (info->params.info_flags & EDD_INFO_MEDIA_CHANGE_NOTIFICATION)
-		p +=3D scnprintf(p, left, "media change notification\n");
-	if (info->params.info_flags & EDD_INFO_LOCKABLE)
-		p +=3D scnprintf(p, left, "lockable\n");
-	if (info->params.info_flags & EDD_INFO_NO_MEDIA_PRESENT)
-		p +=3D scnprintf(p, left, "no media present\n");
-	if (info->params.info_flags & EDD_INFO_USE_INT13_FN50)
-		p +=3D scnprintf(p, left, "use int13 fn50\n");
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_legacy_cylinders(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D snprintf(p, left, "0x%x\n", info->legacy_cylinders);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_legacy_heads(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D snprintf(p, left, "0x%x\n", info->legacy_heads);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_legacy_sectors(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D snprintf(p, left, "0x%x\n", info->legacy_sectors);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_default_cylinders(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_default_heads(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%x\n", info->params.num_default_heads);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_default_sectors_per_track(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%x\n", info->params.sectors_per_track);
-	return (p - buf);
-}
-
-static ssize_t
-edd_show_sectors(struct edd_device *edev, char *buf)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	char *p =3D buf;
-	if (!edev || !info || !buf) {
-		return -EINVAL;
-	}
-
-	p +=3D scnprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
-	return (p - buf);
-}
-
-
-/*
- * Some device instances may not have all the above attributes,
- * or the attribute values may be meaningless (i.e. if
- * the device is < EDD 3.0, it won't have host_bus and interface
- * information), so don't bother making files for them.  Likewise
- * if the default_{cylinders,heads,sectors_per_track} values
- * are zero, the BIOS doesn't provide sane values, don't bother
- * creating files for them either.
- */
-
-static int
-edd_has_legacy_cylinders(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->legacy_cylinders > 0;
-}
-
-static int
-edd_has_legacy_heads(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->legacy_heads > 0;
-}
-
-static int
-edd_has_legacy_sectors(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->legacy_sectors > 0;
-}
-
-static int
-edd_has_default_cylinders(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->params.num_default_cylinders > 0;
-}
-
-static int
-edd_has_default_heads(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->params.num_default_heads > 0;
-}
-
-static int
-edd_has_default_sectors_per_track(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return -EINVAL;
-	return info->params.sectors_per_track > 0;
-}
-
-static int
-edd_has_edd30(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	int i, nonzero_path =3D 0;
-	char c;
-
-	if (!edev || !info)
-		return 0;
-
-	if (!(info->params.key =3D=3D 0xBEDD || info->params.key =3D=3D 0xDDBE)) {
-		return 0;
-	}
-
-	for (i =3D 30; i <=3D 73; i++) {
-		c =3D *(((uint8_t *) info) + i + 4);
-		if (c) {
-			nonzero_path++;
-			break;
-		}
-	}
-	if (!nonzero_path) {
-		return 0;
-	}
-
-	return 1;
-}
-
-static int
-edd_has_disk80_sig(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-	if (!edev || !info)
-		return 0;
-	return info->device =3D=3D 0x80;
-}
-
-static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
-static EDD_DEVICE_ATTR(version, 0444, edd_show_version, NULL);
-static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
-static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, NULL);
-static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
-static EDD_DEVICE_ATTR(legacy_cylinders, 0444, edd_show_legacy_cylinders,
-		       edd_has_legacy_cylinders);
-static EDD_DEVICE_ATTR(legacy_heads, 0444, edd_show_legacy_heads,
-		       edd_has_legacy_heads);
-static EDD_DEVICE_ATTR(legacy_sectors, 0444, edd_show_legacy_sectors,
-		       edd_has_legacy_sectors);
-static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
-		       edd_has_default_cylinders);
-static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
-		       edd_has_default_heads);
-static EDD_DEVICE_ATTR(default_sectors_per_track, 0444,
-		       edd_show_default_sectors_per_track,
-		       edd_has_default_sectors_per_track);
-static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
-static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
-static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_disk80_sig, edd_has_d=
isk80_sig);
-
-
-/* These are default attributes that are added for every edd
- * device discovered.
- */
-static struct attribute * def_attrs[] =3D {
-	&edd_attr_raw_data.attr,
-	&edd_attr_version.attr,
-	&edd_attr_extensions.attr,
-	&edd_attr_info_flags.attr,
-	&edd_attr_sectors.attr,
-	NULL,
-};
-
-/* These attributes are conditional and only added for some devices. */
-static struct edd_attribute * edd_attrs[] =3D {
-	&edd_attr_legacy_cylinders,
-	&edd_attr_legacy_heads,
-	&edd_attr_legacy_sectors,
-	&edd_attr_default_cylinders,
-	&edd_attr_default_heads,
-	&edd_attr_default_sectors_per_track,
-	&edd_attr_interface,
-	&edd_attr_host_bus,
-	&edd_attr_mbr_signature,
-	NULL,
-};
-
-/**
- *	edd_release - free edd structure
- *	@kobj:	kobject of edd structure
- *
- *	This is called when the refcount of the edd structure
- *	reaches 0. This should happen right after we unregister,
- *	but just in case, we use the release callback anyway.
- */
-
-static void edd_release(struct kobject * kobj)
-{
-	struct edd_device * dev =3D to_edd_device(kobj);
-	kfree(dev);
-}
-
-static struct kobj_type ktype_edd =3D {
-	.release	=3D edd_release,
-	.sysfs_ops	=3D &edd_attr_ops,
-	.default_attrs	=3D def_attrs,
-};
-
-static decl_subsys(edd,&ktype_edd,NULL);
-
-
-/**
- * edd_dev_is_type() - is this EDD device a 'type' device?
- * @edev
- * @type - a host bus or interface identifier string per the EDD spec
- *
- * Returns 1 (TRUE) if it is a 'type' device, 0 otherwise.
- */
-static int
-edd_dev_is_type(struct edd_device *edev, const char *type)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-
-	if (edev && type && info) {
-		if (!strncmp(info->params.host_bus_type, type, strlen(type)) ||
-		    !strncmp(info->params.interface_type, type, strlen(type)))
-			return 1;
-	}
-	return 0;
-}
-
-/**
- * edd_get_pci_dev() - finds pci_dev that matches edev
- * @edev - edd_device
- *
- * Returns pci_dev if found, or NULL
- */
-static struct pci_dev *
-edd_get_pci_dev(struct edd_device *edev)
-{
-	struct edd_info *info =3D edd_dev_get_info(edev);
-
-	if (edd_dev_is_type(edev, "PCI")) {
-		return pci_find_slot(info->params.interface_path.pci.bus,
-				     PCI_DEVFN(info->params.interface_path.pci.slot,
-					       info->params.interface_path.pci.
-					       function));
-	}
-	return NULL;
-}
-
-static int
-edd_create_symlink_to_pcidev(struct edd_device *edev)
-{
-
-	struct pci_dev *pci_dev =3D edd_get_pci_dev(edev);
-	if (!pci_dev)
-		return 1;
-	return sysfs_create_link(&edev->kobj,&pci_dev->dev.kobj,"pci_dev");
-}
-
-/*
- * FIXME - as of 15-Jan-2003, there are some non-"scsi_device"s on the
- * scsi_bus list.  The following functions could possibly mis-access
- * memory in that case.  This is actually a problem with the SCSI
- * layer, which is being addressed there.  Until then, don't use the
- * SCSI functions.
- */
-
-#undef CONFIG_SCSI
-#undef CONFIG_SCSI_MODULE
-#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
-
-struct edd_match_data {
-	struct edd_device	* edev;
-	struct scsi_device	* sd;
-};
-
-/**
- * edd_match_scsidev()
- * @edev - EDD device is a known SCSI device
- * @sd - scsi_device with host who's parent is a PCI controller
- *=20
- * returns 1 if a match is found, 0 if not.
- */
-static int edd_match_scsidev(struct device * dev, void * d)
-{
-	struct edd_match_data * data =3D (struct edd_match_data *)d;
-	struct edd_info *info =3D edd_dev_get_info(data->edev);
-	struct scsi_device * sd =3D to_scsi_device(dev);
-
-	if (info) {
-		if ((sd->channel =3D=3D info->params.interface_path.pci.channel) &&
-		    (sd->id =3D=3D info->params.device_path.scsi.id) &&
-		    (sd->lun =3D=3D info->params.device_path.scsi.lun)) {
-			data->sd =3D sd;
-			return 1;
-		}
-	}
-	return 0;
-}
-
-/**
- * edd_find_matching_device()
- * @edev - edd_device to match
- *
- * Search the SCSI devices for a drive that matches the EDD=20
- * device descriptor we have. If we find a match, return it,
- * otherwise, return NULL.
- */
-
-static struct scsi_device *
-edd_find_matching_scsi_device(struct edd_device *edev)
-{
-	struct edd_match_data data;
-	struct bus_type * scsi_bus =3D find_bus("scsi");
-
-	if (!scsi_bus) {
-		return NULL;
-	}
-
-	data.edev =3D edev;
-
-	if (edd_dev_is_type(edev, "SCSI")) {
-		if (bus_for_each_dev(scsi_bus,NULL,&data,edd_match_scsidev))
-			return data.sd;
-	}
-	return NULL;
-}
-
-static int
-edd_create_symlink_to_scsidev(struct edd_device *edev)
-{
-	struct pci_dev *pci_dev;
-	int rc =3D -EINVAL;
-
-	pci_dev =3D edd_get_pci_dev(edev);
-	if (pci_dev) {
-		struct scsi_device * sdev =3D edd_find_matching_scsi_device(edev);
-		if (sdev && get_device(&sdev->sdev_driverfs_dev)) {
-			rc =3D sysfs_create_link(&edev->kobj,
-					       &sdev->sdev_driverfs_dev.kobj,
-					       "disc");
-			put_device(&sdev->sdev_driverfs_dev);
-		}
-	}
-	return rc;
-}
-
-#else
-static int
-edd_create_symlink_to_scsidev(struct edd_device *edev)
-{
-	return -ENOSYS;
-}
-#endif
-
-
-static inline void
-edd_device_unregister(struct edd_device *edev)
-{
-	kobject_unregister(&edev->kobj);
-}
-
-static void edd_populate_dir(struct edd_device * edev)
-{
-	struct edd_attribute * attr;
-	int error =3D 0;
-	int i;
-
-	for (i =3D 0; (attr =3D edd_attrs[i]) && !error; i++) {
-		if (!attr->test ||
-		    (attr->test && attr->test(edev)))
-			error =3D sysfs_create_file(&edev->kobj,&attr->attr);
-	}
-
-	if (!error) {
-		edd_create_symlink_to_pcidev(edev);
-		edd_create_symlink_to_scsidev(edev);
-	}
-}
-
-static int
-edd_device_register(struct edd_device *edev, int i)
-{
-	int error;
-
-	if (!edev)
-		return 1;
-	memset(edev, 0, sizeof (*edev));
-	edd_dev_set_info(edev, &edd[i]);
-	snprintf(edev->kobj.name, EDD_DEVICE_NAME_SIZE, "int13_dev%02x",
-		 edd[i].device);
-	kobj_set_kset_s(edev,edd_subsys);
-	error =3D kobject_register(&edev->kobj);
-	if (!error)
-		edd_populate_dir(edev);
-	return error;
-}
-
-/**
- * edd_init() - creates sysfs tree of EDD data
- *
- * This assumes that eddnr and edd were
- * assigned in setup.c already.
- */
-static int __init
-edd_init(void)
-{
-	unsigned int i;
-	int rc=3D0;
-	struct edd_device *edev;
-
-	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",
-	       EDD_VERSION, eddnr);
-	printk(KERN_INFO "Please report your BIOS at %s\n", REPORT_URL);
-
-	if (!eddnr) {
-		printk(KERN_INFO "EDD information not available.\n");
-		return 1;
-	}
-
-	rc =3D firmware_register(&edd_subsys);
-	if (rc)
-		return rc;
-
-	for (i =3D 0; i < eddnr && i < EDDMAXNR && !rc; i++) {
-		edev =3D kmalloc(sizeof (*edev), GFP_KERNEL);
-		if (!edev)
-			return -ENOMEM;
-
-		rc =3D edd_device_register(edev, i);
-		if (rc) {
-			kfree(edev);
-			break;
-		}
-		edd_devices[i] =3D edev;
-	}
-
-	if (rc)
-		firmware_unregister(&edd_subsys);
-	return rc;
-}
-
-static void __exit
-edd_exit(void)
-{
-	int i;
-	struct edd_device *edev;
-
-	for (i =3D 0; i < eddnr && i < EDDMAXNR; i++) {
-		if ((edev =3D edd_devices[i]))
-			edd_device_unregister(edev);
-	}
-	firmware_unregister(&edd_subsys);
-}
-
-late_initcall(edd_init);
-module_exit(edd_exit);
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Tue Mar 16 10:03:36 2004
+++ b/arch/i386/kernel/setup.c	Tue Mar 16 10:03:36 2004
@@ -38,10 +38,10 @@
 #include <linux/module.h>
 #include <linux/efi.h>
 #include <linux/init.h>
+#include <linux/edd.h>
 #include <video/edid.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
-#include <asm/edd.h>
 #include <asm/setup.h>
 #include <asm/arch_hooks.h>
 #include <asm/sections.h>
diff -Nru a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	Tue Mar 16 10:03:36 2004
+++ b/arch/x86_64/Kconfig	Tue Mar 16 10:03:36 2004
@@ -397,6 +397,8 @@
=20
 source drivers/Kconfig
=20
+source "drivers/firmware/Kconfig"
+
 source fs/Kconfig
=20
 source "arch/x86_64/oprofile/Kconfig"
diff -Nru a/arch/x86_64/boot/setup.S b/arch/x86_64/boot/setup.S
--- a/arch/x86_64/boot/setup.S	Tue Mar 16 10:03:36 2004
+++ b/arch/x86_64/boot/setup.S	Tue Mar 16 10:03:36 2004
@@ -533,6 +533,8 @@
 	movw	$0xAA, (0x1ff)			# device present
 no_psmouse:
=20
+#include "../../i386/boot/edd.S"
+
 # Now we want to move to protected mode ...
 	cmpw	$0, %cs:realmode_swtch
 	jz	rmodeswtch_normal
diff -Nru a/arch/x86_64/defconfig b/arch/x86_64/defconfig
--- a/arch/x86_64/defconfig	Tue Mar 16 10:03:36 2004
+++ b/arch/x86_64/defconfig	Tue Mar 16 10:03:36 2004
@@ -136,6 +136,7 @@
 #
 # Device Drivers
 #
+CONFIG_EDD=3Dm
=20
 #
 # Generic Driver Options
diff -Nru a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
--- a/arch/x86_64/kernel/setup.c	Tue Mar 16 10:03:36 2004
+++ b/arch/x86_64/kernel/setup.c	Tue Mar 16 10:03:36 2004
@@ -39,6 +39,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/kallsyms.h>
+#include <linux/edd.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -346,6 +347,30 @@
=20
 __setup("noreplacement", noreplacement_setup);=20
=20
+#if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+unsigned char eddnr;
+struct edd_info edd[EDDMAXNR];
+unsigned int edd_disk80_sig;
+#ifdef CONFIG_EDD_MODULE
+EXPORT_SYMBOL(eddnr);
+EXPORT_SYMBOL(edd);
+EXPORT_SYMBOL(edd_disk80_sig);
+#endif
+/**
+ * copy_edd() - Copy the BIOS EDD information
+ *              from empty_zero_page into a safe place.
+ *
+ */
+static inline void copy_edd(void)
+{
+     eddnr =3D EDD_NR;
+     memcpy(edd, EDD_BUF, sizeof(edd));
+     edd_disk80_sig =3D DISK80_SIGNATURE;
+}
+#else
+#define copy_edd() do {} while (0)
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long low_mem_size;
@@ -364,6 +389,7 @@
 	rd_doload =3D ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) !=3D 0);
 #endif
 	setup_memory_region();
+	copy_edd();
=20
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &=3D ~MS_RDONLY;
diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	Tue Mar 16 10:03:36 2004
+++ b/drivers/Makefile	Tue Mar 16 10:03:36 2004
@@ -49,3 +49,4 @@
 obj-$(CONFIG_MCA)		+=3D mca/
 obj-$(CONFIG_EISA)		+=3D eisa/
 obj-$(CONFIG_CPU_FREQ)		+=3D cpufreq/
+obj-y				+=3D firmware/
diff -Nru a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/Kconfig	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,19 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+
+menu "Firmware Drivers"
+
+config EDD
+	tristate "BIOS Enhanced Disk Drive calls determine boot disk (EXPERIMENTA=
L)"
+	depends on EXPERIMENTAL
+	help
+	  Say Y or M here if you want to enable BIOS Enhanced Disk Drive
+	  Services real mode BIOS calls to determine which disk
+	  BIOS tries boot from.  This information is then exported via driverfs.
+
+	  This option is experimental, but believed to be safe,
+	  and most disk controller BIOS vendors do not yet implement this feature.
+
+endmenu
diff -Nru a/drivers/firmware/Makefile b/drivers/firmware/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/Makefile	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,4 @@
+#
+# Makefile for the linux kernel.
+#
+obj-$(CONFIG_EDD)             	+=3D edd.o
diff -Nru a/drivers/firmware/edd.c b/drivers/firmware/edd.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/firmware/edd.c	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,837 @@
+/*
+ * linux/arch/i386/kernel/edd.c
+ *  Copyright (C) 2002, 2003, 2004 Dell Inc.
+ *  by Matt Domsch <Matt_Domsch@dell.com>
+ *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
+ *  legacy CHS by Patrick J. LoPresti <patl@users.sourceforge.net>
+ *
+ * BIOS Enhanced Disk Drive Services (EDD)
+ * conformant to T13 Committee www.t13.org
+ *   projects 1572D, 1484D, 1386D, 1226DT
+ *
+ * This code takes information provided by BIOS EDD calls
+ * fn41 - Check Extensions Present and
+ * fn48 - Get Device Parametes with EDD extensions
+ * made in setup.S, copied to safe structures in setup.c,
+ * and presents it in sysfs.
+ *
+ * Please see http://domsch.com/linux/edd30/results.html for
+ * the list of BIOSs which have been reported to implement EDD.
+ * If you don't see yours listed, please send a report as described there.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published =
by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+/*
+ * Known issues:
+ * - refcounting of struct device objects could be improved.
+ *
+ * TODO:
+ * - Add IDE and USB disk device support
+ * - move edd.[ch] to better locations if/when one is decided
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/stat.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+#include <linux/slab.h>
+#include <linux/limits.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/device.h>
+#include <linux/blkdev.h>
+#include <linux/edd.h>
+/* FIXME - this really belongs in include/scsi/scsi.h */
+#include <../drivers/scsi/scsi.h>
+#include <../drivers/scsi/hosts.h>
+
+MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
+MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
+MODULE_LICENSE("GPL");
+
+#define EDD_VERSION "0.13 2004-Mar-09"
+#define EDD_DEVICE_NAME_SIZE 16
+#define REPORT_URL "http://linux.dell.com/edd/results.html"
+
+#define left (PAGE_SIZE - (p - buf) - 1)
+
+struct edd_device {
+	struct edd_info *info;
+	struct kobject kobj;
+};
+
+struct edd_attribute {
+	struct attribute attr;
+	ssize_t(*show) (struct edd_device * edev, char *buf);
+	int (*test) (struct edd_device * edev);
+};
+
+/* forward declarations */
+static int edd_dev_is_type(struct edd_device *edev, const char *type);
+static struct pci_dev *edd_get_pci_dev(struct edd_device *edev);
+
+static struct edd_device *edd_devices[EDDMAXNR];
+
+#define EDD_DEVICE_ATTR(_name,_mode,_show,_test) \
+struct edd_attribute edd_attr_##_name =3D { 	\
+	.attr =3D {.name =3D __stringify(_name), .mode =3D _mode },	\
+	.show	=3D _show,				\
+	.test	=3D _test,				\
+};
+
+static inline struct edd_info *
+edd_dev_get_info(struct edd_device *edev)
+{
+	return edev->info;
+}
+
+static inline void
+edd_dev_set_info(struct edd_device *edev, struct edd_info *info)
+{
+	edev->info =3D info;
+}
+
+#define to_edd_attr(_attr) container_of(_attr,struct edd_attribute,attr)
+#define to_edd_device(obj) container_of(obj,struct edd_device,kobj)
+
+static ssize_t
+edd_attr_show(struct kobject * kobj, struct attribute *attr, char *buf)
+{
+	struct edd_device *dev =3D to_edd_device(kobj);
+	struct edd_attribute *edd_attr =3D to_edd_attr(attr);
+	ssize_t ret =3D 0;
+
+	if (edd_attr->show)
+		ret =3D edd_attr->show(dev, buf);
+	return ret;
+}
+
+static struct sysfs_ops edd_attr_ops =3D {
+	.show =3D edd_attr_show,
+};
+
+static ssize_t
+edd_show_host_bus(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	int i;
+
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < 4; i++) {
+		if (isprint(info->params.host_bus_type[i])) {
+			p +=3D scnprintf(p, left, "%c", info->params.host_bus_type[i]);
+		} else {
+			p +=3D scnprintf(p, left, " ");
+		}
+	}
+
+	if (!strncmp(info->params.host_bus_type, "ISA", 3)) {
+		p +=3D scnprintf(p, left, "\tbase_address: %x\n",
+			     info->params.interface_path.isa.base_address);
+	} else if (!strncmp(info->params.host_bus_type, "PCIX", 4) ||
+		   !strncmp(info->params.host_bus_type, "PCI", 3)) {
+		p +=3D scnprintf(p, left,
+			     "\t%02x:%02x.%d  channel: %u\n",
+			     info->params.interface_path.pci.bus,
+			     info->params.interface_path.pci.slot,
+			     info->params.interface_path.pci.function,
+			     info->params.interface_path.pci.channel);
+	} else if (!strncmp(info->params.host_bus_type, "IBND", 4) ||
+		   !strncmp(info->params.host_bus_type, "XPRS", 4) ||
+		   !strncmp(info->params.host_bus_type, "HTPT", 4)) {
+		p +=3D scnprintf(p, left,
+			     "\tTBD: %llx\n",
+			     info->params.interface_path.ibnd.reserved);
+
+	} else {
+		p +=3D scnprintf(p, left, "\tunknown: %llx\n",
+			     info->params.interface_path.unknown.reserved);
+	}
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_interface(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	int i;
+
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < 8; i++) {
+		if (isprint(info->params.interface_type[i])) {
+			p +=3D scnprintf(p, left, "%c", info->params.interface_type[i]);
+		} else {
+			p +=3D scnprintf(p, left, " ");
+		}
+	}
+	if (!strncmp(info->params.interface_type, "ATAPI", 5)) {
+		p +=3D scnprintf(p, left, "\tdevice: %u  lun: %u\n",
+			     info->params.device_path.atapi.device,
+			     info->params.device_path.atapi.lun);
+	} else if (!strncmp(info->params.interface_type, "ATA", 3)) {
+		p +=3D scnprintf(p, left, "\tdevice: %u\n",
+			     info->params.device_path.ata.device);
+	} else if (!strncmp(info->params.interface_type, "SCSI", 4)) {
+		p +=3D scnprintf(p, left, "\tid: %u  lun: %llu\n",
+			     info->params.device_path.scsi.id,
+			     info->params.device_path.scsi.lun);
+	} else if (!strncmp(info->params.interface_type, "USB", 3)) {
+		p +=3D scnprintf(p, left, "\tserial_number: %llx\n",
+			     info->params.device_path.usb.serial_number);
+	} else if (!strncmp(info->params.interface_type, "1394", 4)) {
+		p +=3D scnprintf(p, left, "\teui: %llx\n",
+			     info->params.device_path.i1394.eui);
+	} else if (!strncmp(info->params.interface_type, "FIBRE", 5)) {
+		p +=3D scnprintf(p, left, "\twwid: %llx lun: %llx\n",
+			     info->params.device_path.fibre.wwid,
+			     info->params.device_path.fibre.lun);
+	} else if (!strncmp(info->params.interface_type, "I2O", 3)) {
+		p +=3D scnprintf(p, left, "\tidentity_tag: %llx\n",
+			     info->params.device_path.i2o.identity_tag);
+	} else if (!strncmp(info->params.interface_type, "RAID", 4)) {
+		p +=3D scnprintf(p, left, "\tidentity_tag: %x\n",
+			     info->params.device_path.raid.array_number);
+	} else if (!strncmp(info->params.interface_type, "SATA", 4)) {
+		p +=3D scnprintf(p, left, "\tdevice: %u\n",
+			     info->params.device_path.sata.device);
+	} else {
+		p +=3D scnprintf(p, left, "\tunknown: %llx %llx\n",
+			     info->params.device_path.unknown.reserved1,
+			     info->params.device_path.unknown.reserved2);
+	}
+
+	return (p - buf);
+}
+
+/**
+ * edd_show_raw_data() - copies raw data to buffer for userspace to parse
+ *
+ * Returns: number of bytes written, or -EINVAL on failure
+ */
+static ssize_t
+edd_show_raw_data(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	ssize_t len =3D sizeof (info->params);
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	if (!(info->params.key =3D=3D 0xBEDD || info->params.key =3D=3D 0xDDBE))
+		len =3D info->params.length;
+
+	/* In case of buggy BIOSs */
+	if (len > (sizeof(info->params)))
+		len =3D sizeof(info->params);
+
+	memcpy(buf, &info->params, len);
+	return len;
+}
+
+static ssize_t
+edd_show_version(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%02x\n", info->version);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_disk80_sig(struct edd_device *edev, char *buf)
+{
+	char *p =3D buf;
+	p +=3D scnprintf(p, left, "0x%08x\n", edd_disk80_sig);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_extensions(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	if (info->interface_support & EDD_EXT_FIXED_DISK_ACCESS) {
+		p +=3D scnprintf(p, left, "Fixed disk access\n");
+	}
+	if (info->interface_support & EDD_EXT_DEVICE_LOCKING_AND_EJECTING) {
+		p +=3D scnprintf(p, left, "Device locking and ejecting\n");
+	}
+	if (info->interface_support & EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT) {
+		p +=3D scnprintf(p, left, "Enhanced Disk Drive support\n");
+	}
+	if (info->interface_support & EDD_EXT_64BIT_EXTENSIONS) {
+		p +=3D scnprintf(p, left, "64-bit extensions\n");
+	}
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_info_flags(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	if (info->params.info_flags & EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT)
+		p +=3D scnprintf(p, left, "DMA boundary error transparent\n");
+	if (info->params.info_flags & EDD_INFO_GEOMETRY_VALID)
+		p +=3D scnprintf(p, left, "geometry valid\n");
+	if (info->params.info_flags & EDD_INFO_REMOVABLE)
+		p +=3D scnprintf(p, left, "removable\n");
+	if (info->params.info_flags & EDD_INFO_WRITE_VERIFY)
+		p +=3D scnprintf(p, left, "write verify\n");
+	if (info->params.info_flags & EDD_INFO_MEDIA_CHANGE_NOTIFICATION)
+		p +=3D scnprintf(p, left, "media change notification\n");
+	if (info->params.info_flags & EDD_INFO_LOCKABLE)
+		p +=3D scnprintf(p, left, "lockable\n");
+	if (info->params.info_flags & EDD_INFO_NO_MEDIA_PRESENT)
+		p +=3D scnprintf(p, left, "no media present\n");
+	if (info->params.info_flags & EDD_INFO_USE_INT13_FN50)
+		p +=3D scnprintf(p, left, "use int13 fn50\n");
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_legacy_cylinders(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_cylinders);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_legacy_heads(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_heads);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_legacy_sectors(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D snprintf(p, left, "0x%x\n", info->legacy_sectors);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_cylinders(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_heads(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%x\n", info->params.num_default_heads);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_default_sectors_per_track(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%x\n", info->params.sectors_per_track);
+	return (p - buf);
+}
+
+static ssize_t
+edd_show_sectors(struct edd_device *edev, char *buf)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	char *p =3D buf;
+	if (!edev || !info || !buf) {
+		return -EINVAL;
+	}
+
+	p +=3D scnprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
+	return (p - buf);
+}
+
+
+/*
+ * Some device instances may not have all the above attributes,
+ * or the attribute values may be meaningless (i.e. if
+ * the device is < EDD 3.0, it won't have host_bus and interface
+ * information), so don't bother making files for them.  Likewise
+ * if the default_{cylinders,heads,sectors_per_track} values
+ * are zero, the BIOS doesn't provide sane values, don't bother
+ * creating files for them either.
+ */
+
+static int
+edd_has_legacy_cylinders(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_cylinders > 0;
+}
+
+static int
+edd_has_legacy_heads(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_heads > 0;
+}
+
+static int
+edd_has_legacy_sectors(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->legacy_sectors > 0;
+}
+
+static int
+edd_has_default_cylinders(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->params.num_default_cylinders > 0;
+}
+
+static int
+edd_has_default_heads(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->params.num_default_heads > 0;
+}
+
+static int
+edd_has_default_sectors_per_track(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return -EINVAL;
+	return info->params.sectors_per_track > 0;
+}
+
+static int
+edd_has_edd30(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	int i, nonzero_path =3D 0;
+	char c;
+
+	if (!edev || !info)
+		return 0;
+
+	if (!(info->params.key =3D=3D 0xBEDD || info->params.key =3D=3D 0xDDBE)) {
+		return 0;
+	}
+
+	for (i =3D 30; i <=3D 73; i++) {
+		c =3D *(((uint8_t *) info) + i + 4);
+		if (c) {
+			nonzero_path++;
+			break;
+		}
+	}
+	if (!nonzero_path) {
+		return 0;
+	}
+
+	return 1;
+}
+
+static int
+edd_has_disk80_sig(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+	if (!edev || !info)
+		return 0;
+	return info->device =3D=3D 0x80;
+}
+
+static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
+static EDD_DEVICE_ATTR(version, 0444, edd_show_version, NULL);
+static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
+static EDD_DEVICE_ATTR(info_flags, 0444, edd_show_info_flags, NULL);
+static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
+static EDD_DEVICE_ATTR(legacy_cylinders, 0444, edd_show_legacy_cylinders,
+		       edd_has_legacy_cylinders);
+static EDD_DEVICE_ATTR(legacy_heads, 0444, edd_show_legacy_heads,
+		       edd_has_legacy_heads);
+static EDD_DEVICE_ATTR(legacy_sectors, 0444, edd_show_legacy_sectors,
+		       edd_has_legacy_sectors);
+static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
+		       edd_has_default_cylinders);
+static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
+		       edd_has_default_heads);
+static EDD_DEVICE_ATTR(default_sectors_per_track, 0444,
+		       edd_show_default_sectors_per_track,
+		       edd_has_default_sectors_per_track);
+static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
+static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
+static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_disk80_sig, edd_has_d=
isk80_sig);
+
+
+/* These are default attributes that are added for every edd
+ * device discovered.
+ */
+static struct attribute * def_attrs[] =3D {
+	&edd_attr_raw_data.attr,
+	&edd_attr_version.attr,
+	&edd_attr_extensions.attr,
+	&edd_attr_info_flags.attr,
+	&edd_attr_sectors.attr,
+	NULL,
+};
+
+/* These attributes are conditional and only added for some devices. */
+static struct edd_attribute * edd_attrs[] =3D {
+	&edd_attr_legacy_cylinders,
+	&edd_attr_legacy_heads,
+	&edd_attr_legacy_sectors,
+	&edd_attr_default_cylinders,
+	&edd_attr_default_heads,
+	&edd_attr_default_sectors_per_track,
+	&edd_attr_interface,
+	&edd_attr_host_bus,
+	&edd_attr_mbr_signature,
+	NULL,
+};
+
+/**
+ *	edd_release - free edd structure
+ *	@kobj:	kobject of edd structure
+ *
+ *	This is called when the refcount of the edd structure
+ *	reaches 0. This should happen right after we unregister,
+ *	but just in case, we use the release callback anyway.
+ */
+
+static void edd_release(struct kobject * kobj)
+{
+	struct edd_device * dev =3D to_edd_device(kobj);
+	kfree(dev);
+}
+
+static struct kobj_type ktype_edd =3D {
+	.release	=3D edd_release,
+	.sysfs_ops	=3D &edd_attr_ops,
+	.default_attrs	=3D def_attrs,
+};
+
+static decl_subsys(edd,&ktype_edd,NULL);
+
+
+/**
+ * edd_dev_is_type() - is this EDD device a 'type' device?
+ * @edev
+ * @type - a host bus or interface identifier string per the EDD spec
+ *
+ * Returns 1 (TRUE) if it is a 'type' device, 0 otherwise.
+ */
+static int
+edd_dev_is_type(struct edd_device *edev, const char *type)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+
+	if (edev && type && info) {
+		if (!strncmp(info->params.host_bus_type, type, strlen(type)) ||
+		    !strncmp(info->params.interface_type, type, strlen(type)))
+			return 1;
+	}
+	return 0;
+}
+
+/**
+ * edd_get_pci_dev() - finds pci_dev that matches edev
+ * @edev - edd_device
+ *
+ * Returns pci_dev if found, or NULL
+ */
+static struct pci_dev *
+edd_get_pci_dev(struct edd_device *edev)
+{
+	struct edd_info *info =3D edd_dev_get_info(edev);
+
+	if (edd_dev_is_type(edev, "PCI")) {
+		return pci_find_slot(info->params.interface_path.pci.bus,
+				     PCI_DEVFN(info->params.interface_path.pci.slot,
+					       info->params.interface_path.pci.
+					       function));
+	}
+	return NULL;
+}
+
+static int
+edd_create_symlink_to_pcidev(struct edd_device *edev)
+{
+
+	struct pci_dev *pci_dev =3D edd_get_pci_dev(edev);
+	if (!pci_dev)
+		return 1;
+	return sysfs_create_link(&edev->kobj,&pci_dev->dev.kobj,"pci_dev");
+}
+
+/*
+ * FIXME - as of 15-Jan-2003, there are some non-"scsi_device"s on the
+ * scsi_bus list.  The following functions could possibly mis-access
+ * memory in that case.  This is actually a problem with the SCSI
+ * layer, which is being addressed there.  Until then, don't use the
+ * SCSI functions.
+ */
+
+#undef CONFIG_SCSI
+#undef CONFIG_SCSI_MODULE
+#if defined(CONFIG_SCSI) || defined(CONFIG_SCSI_MODULE)
+
+struct edd_match_data {
+	struct edd_device	* edev;
+	struct scsi_device	* sd;
+};
+
+/**
+ * edd_match_scsidev()
+ * @edev - EDD device is a known SCSI device
+ * @sd - scsi_device with host who's parent is a PCI controller
+ *=20
+ * returns 1 if a match is found, 0 if not.
+ */
+static int edd_match_scsidev(struct device * dev, void * d)
+{
+	struct edd_match_data * data =3D (struct edd_match_data *)d;
+	struct edd_info *info =3D edd_dev_get_info(data->edev);
+	struct scsi_device * sd =3D to_scsi_device(dev);
+
+	if (info) {
+		if ((sd->channel =3D=3D info->params.interface_path.pci.channel) &&
+		    (sd->id =3D=3D info->params.device_path.scsi.id) &&
+		    (sd->lun =3D=3D info->params.device_path.scsi.lun)) {
+			data->sd =3D sd;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+/**
+ * edd_find_matching_device()
+ * @edev - edd_device to match
+ *
+ * Search the SCSI devices for a drive that matches the EDD=20
+ * device descriptor we have. If we find a match, return it,
+ * otherwise, return NULL.
+ */
+
+static struct scsi_device *
+edd_find_matching_scsi_device(struct edd_device *edev)
+{
+	struct edd_match_data data;
+	struct bus_type * scsi_bus =3D find_bus("scsi");
+
+	if (!scsi_bus) {
+		return NULL;
+	}
+
+	data.edev =3D edev;
+
+	if (edd_dev_is_type(edev, "SCSI")) {
+		if (bus_for_each_dev(scsi_bus,NULL,&data,edd_match_scsidev))
+			return data.sd;
+	}
+	return NULL;
+}
+
+static int
+edd_create_symlink_to_scsidev(struct edd_device *edev)
+{
+	struct pci_dev *pci_dev;
+	int rc =3D -EINVAL;
+
+	pci_dev =3D edd_get_pci_dev(edev);
+	if (pci_dev) {
+		struct scsi_device * sdev =3D edd_find_matching_scsi_device(edev);
+		if (sdev && get_device(&sdev->sdev_driverfs_dev)) {
+			rc =3D sysfs_create_link(&edev->kobj,
+					       &sdev->sdev_driverfs_dev.kobj,
+					       "disc");
+			put_device(&sdev->sdev_driverfs_dev);
+		}
+	}
+	return rc;
+}
+
+#else
+static int
+edd_create_symlink_to_scsidev(struct edd_device *edev)
+{
+	return -ENOSYS;
+}
+#endif
+
+
+static inline void
+edd_device_unregister(struct edd_device *edev)
+{
+	kobject_unregister(&edev->kobj);
+}
+
+static void edd_populate_dir(struct edd_device * edev)
+{
+	struct edd_attribute * attr;
+	int error =3D 0;
+	int i;
+
+	for (i =3D 0; (attr =3D edd_attrs[i]) && !error; i++) {
+		if (!attr->test ||
+		    (attr->test && attr->test(edev)))
+			error =3D sysfs_create_file(&edev->kobj,&attr->attr);
+	}
+
+	if (!error) {
+		edd_create_symlink_to_pcidev(edev);
+		edd_create_symlink_to_scsidev(edev);
+	}
+}
+
+static int
+edd_device_register(struct edd_device *edev, int i)
+{
+	int error;
+
+	if (!edev)
+		return 1;
+	memset(edev, 0, sizeof (*edev));
+	edd_dev_set_info(edev, &edd[i]);
+	snprintf(edev->kobj.name, EDD_DEVICE_NAME_SIZE, "int13_dev%02x",
+		 edd[i].device);
+	kobj_set_kset_s(edev,edd_subsys);
+	error =3D kobject_register(&edev->kobj);
+	if (!error)
+		edd_populate_dir(edev);
+	return error;
+}
+
+/**
+ * edd_init() - creates sysfs tree of EDD data
+ *
+ * This assumes that eddnr and edd were
+ * assigned in setup.c already.
+ */
+static int __init
+edd_init(void)
+{
+	unsigned int i;
+	int rc=3D0;
+	struct edd_device *edev;
+
+	printk(KERN_INFO "BIOS EDD facility v%s, %d devices found\n",
+	       EDD_VERSION, eddnr);
+	printk(KERN_INFO "Please report your BIOS at %s\n", REPORT_URL);
+
+	if (!eddnr) {
+		printk(KERN_INFO "EDD information not available.\n");
+		return 1;
+	}
+
+	rc =3D firmware_register(&edd_subsys);
+	if (rc)
+		return rc;
+
+	for (i =3D 0; i < eddnr && i < EDDMAXNR && !rc; i++) {
+		edev =3D kmalloc(sizeof (*edev), GFP_KERNEL);
+		if (!edev)
+			return -ENOMEM;
+
+		rc =3D edd_device_register(edev, i);
+		if (rc) {
+			kfree(edev);
+			break;
+		}
+		edd_devices[i] =3D edev;
+	}
+
+	if (rc)
+		firmware_unregister(&edd_subsys);
+	return rc;
+}
+
+static void __exit
+edd_exit(void)
+{
+	int i;
+	struct edd_device *edev;
+
+	for (i =3D 0; i < eddnr && i < EDDMAXNR; i++) {
+		if ((edev =3D edd_devices[i]))
+			edd_device_unregister(edev);
+	}
+	firmware_unregister(&edd_subsys);
+}
+
+late_initcall(edd_init);
+module_exit(edd_exit);
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Tue Mar 16 10:03:36 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,180 +0,0 @@
-/*
- * linux/include/asm-i386/edd.h
- *  Copyright (C) 2002, 2003 Dell Inc.
- *  by Matt Domsch <Matt_Domsch@dell.com>
- *
- * structures and definitions for the int 13h, ax=3D{41,48}h
- * BIOS Enhanced Disk Drive Services
- * This is based on the T13 group document D1572 Revision 0 (August 14 200=
2)
- * available at http://www.t13.org/docs2002/d1572r0.pdf.  It is
- * very similar to D1484 Revision 3 http://www.t13.org/docs2002/d1484r3.pdf
- *
- * In a nutshell, arch/i386/boot/setup.S populates a scratch table
- * in the empty_zero_block that contains a list of BIOS-enumerated
- * boot devices.
- * In arch/i386/kernel/setup.c, this information is
- * transferred into the edd structure, and in arch/i386/kernel/edd.c, that
- * information is used to identify BIOS boot disk.  The code in setup.S
- * is very sensitive to the size of these structures.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License v2.0 as published =
by
- * the Free Software Foundation
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-#ifndef _ASM_I386_EDD_H
-#define _ASM_I386_EDD_H
-
-#define EDDNR 0x1e9		/* addr of number of edd_info structs at EDDBUF
-				   in empty_zero_block - treat this as 1 byte  */
-#define EDDBUF	0x600		/* addr of edd_info structs in empty_zero_block */
-#define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
-#define EDDEXTSIZE 8		/* change these if you muck with the structures */
-#define EDDPARMSIZE 74
-#define CHECKEXTENSIONSPRESENT 0x41
-#define GETDEVICEPARAMETERS 0x48
-#define LEGACYGETDEVICEPARAMETERS 0x08
-#define EDDMAGIC1 0x55AA
-#define EDDMAGIC2 0xAA55
-
-#define READ_SECTORS 0x02
-#define MBR_SIG_OFFSET 0x1B8
-#define DISK80_SIG_BUFFER 0x2cc
-#ifndef __ASSEMBLY__
-
-#define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
-#define EDD_EXT_DEVICE_LOCKING_AND_EJECTING (1 << 1)
-#define EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT (1 << 2)
-#define EDD_EXT_64BIT_EXTENSIONS            (1 << 3)
-
-#define EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT (1 << 0)
-#define EDD_INFO_GEOMETRY_VALID                (1 << 1)
-#define EDD_INFO_REMOVABLE                     (1 << 2)
-#define EDD_INFO_WRITE_VERIFY                  (1 << 3)
-#define EDD_INFO_MEDIA_CHANGE_NOTIFICATION     (1 << 4)
-#define EDD_INFO_LOCKABLE                      (1 << 5)
-#define EDD_INFO_NO_MEDIA_PRESENT              (1 << 6)
-#define EDD_INFO_USE_INT13_FN50                (1 << 7)
-
-struct edd_device_params {
-	u16 length;
-	u16 info_flags;
-	u32 num_default_cylinders;
-	u32 num_default_heads;
-	u32 sectors_per_track;
-	u64 number_of_sectors;
-	u16 bytes_per_sector;
-	u32 dpte_ptr;		/* 0xFFFFFFFF for our purposes */
-	u16 key;		/* =3D 0xBEDD */
-	u8 device_path_info_length;	/* =3D 44 */
-	u8 reserved2;
-	u16 reserved3;
-	u8 host_bus_type[4];
-	u8 interface_type[8];
-	union {
-		struct {
-			u16 base_address;
-			u16 reserved1;
-			u32 reserved2;
-		} __attribute__ ((packed)) isa;
-		struct {
-			u8 bus;
-			u8 slot;
-			u8 function;
-			u8 channel;
-			u32 reserved;
-		} __attribute__ ((packed)) pci;
-		/* pcix is same as pci */
-		struct {
-			u64 reserved;
-		} __attribute__ ((packed)) ibnd;
-		struct {
-			u64 reserved;
-		} __attribute__ ((packed)) xprs;
-		struct {
-			u64 reserved;
-		} __attribute__ ((packed)) htpt;
-		struct {
-			u64 reserved;
-		} __attribute__ ((packed)) unknown;
-	} interface_path;
-	union {
-		struct {
-			u8 device;
-			u8 reserved1;
-			u16 reserved2;
-			u32 reserved3;
-			u64 reserved4;
-		} __attribute__ ((packed)) ata;
-		struct {
-			u8 device;
-			u8 lun;
-			u8 reserved1;
-			u8 reserved2;
-			u32 reserved3;
-			u64 reserved4;
-		} __attribute__ ((packed)) atapi;
-		struct {
-			u16 id;
-			u64 lun;
-			u16 reserved1;
-			u32 reserved2;
-		} __attribute__ ((packed)) scsi;
-		struct {
-			u64 serial_number;
-			u64 reserved;
-		} __attribute__ ((packed)) usb;
-		struct {
-			u64 eui;
-			u64 reserved;
-		} __attribute__ ((packed)) i1394;
-		struct {
-			u64 wwid;
-			u64 lun;
-		} __attribute__ ((packed)) fibre;
-		struct {
-			u64 identity_tag;
-			u64 reserved;
-		} __attribute__ ((packed)) i2o;
-		struct {
-			u32 array_number;
-			u32 reserved1;
-			u64 reserved2;
-		} __attribute__ ((packed)) raid;
-		struct {
-			u8 device;
-			u8 reserved1;
-			u16 reserved2;
-			u32 reserved3;
-			u64 reserved4;
-		} __attribute__ ((packed)) sata;
-		struct {
-			u64 reserved1;
-			u64 reserved2;
-		} __attribute__ ((packed)) unknown;
-	} device_path;
-	u8 reserved4;
-	u8 checksum;
-} __attribute__ ((packed));
-
-struct edd_info {
-	u8 device;
-	u8 version;
-	u16 interface_support;
-	u16 legacy_cylinders;
-	u8 legacy_heads;
-	u8 legacy_sectors;
-	struct edd_device_params params;
-} __attribute__ ((packed));
-
-extern struct edd_info edd[EDDMAXNR];
-extern unsigned char eddnr;
-extern unsigned int edd_disk80_sig;
-#endif				/*!__ASSEMBLY__ */
-
-#endif				/* _ASM_I386_EDD_H */
diff -Nru a/include/asm-x86_64/bootsetup.h b/include/asm-x86_64/bootsetup.h
--- a/include/asm-x86_64/bootsetup.h	Tue Mar 16 10:03:36 2004
+++ b/include/asm-x86_64/bootsetup.h	Tue Mar 16 10:03:36 2004
@@ -26,6 +26,9 @@
 #define INITRD_START (*(unsigned int *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned int *) (PARAM+0x21c))
 #define EDID_INFO (*(struct edid_info *) (PARAM+0x440))
+#define DISK80_SIGNATURE (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
+#define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
+#define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE saved_command_line
 #define COMMAND_LINE_SIZE 256
=20
diff -Nru a/include/linux/edd.h b/include/linux/edd.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/edd.h	Tue Mar 16 10:03:36 2004
@@ -0,0 +1,181 @@
+/*
+ * linux/include/linux/edd.h
+ *  Copyright (C) 2002, 2003 Dell Inc.
+ *  by Matt Domsch <Matt_Domsch@dell.com>
+ *
+ * structures and definitions for the int 13h, ax=3D{41,48}h
+ * BIOS Enhanced Disk Drive Services
+ * This is based on the T13 group document D1572 Revision 0 (August 14 200=
2)
+ * available at http://www.t13.org/docs2002/d1572r0.pdf.  It is
+ * very similar to D1484 Revision 3 http://www.t13.org/docs2002/d1484r3.pdf
+ *
+ * In a nutshell, arch/{i386,x86_64}/boot/setup.S populates a scratch table
+ * in the empty_zero_block that contains a list of BIOS-enumerated
+ * boot devices.
+ * In arch/{i386,x86_64}/kernel/setup.c, this information is
+ * transferred into the edd structure, and in drivers/firmware/edd.c, that
+ * information is used to identify BIOS boot disk.  The code in setup.S
+ * is very sensitive to the size of these structures.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License v2.0 as published =
by
+ * the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef _LINUX_EDD_H
+#define _LINUX_EDD_H
+
+#define EDDNR 0x1e9		/* addr of number of edd_info structs at EDDBUF
+				   in empty_zero_block - treat this as 1 byte  */
+#define EDDBUF	0x600		/* addr of edd_info structs in empty_zero_block */
+#define EDDMAXNR 6		/* number of edd_info structs starting at EDDBUF  */
+#define EDDEXTSIZE 8		/* change these if you muck with the structures */
+#define EDDPARMSIZE 74
+#define CHECKEXTENSIONSPRESENT 0x41
+#define GETDEVICEPARAMETERS 0x48
+#define LEGACYGETDEVICEPARAMETERS 0x08
+#define EDDMAGIC1 0x55AA
+#define EDDMAGIC2 0xAA55
+
+#define READ_SECTORS 0x02
+#define MBR_SIG_OFFSET 0x1B8
+#define DISK80_SIG_BUFFER 0x2cc
+#ifndef __ASSEMBLY__
+
+#define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
+#define EDD_EXT_DEVICE_LOCKING_AND_EJECTING (1 << 1)
+#define EDD_EXT_ENHANCED_DISK_DRIVE_SUPPORT (1 << 2)
+#define EDD_EXT_64BIT_EXTENSIONS            (1 << 3)
+
+#define EDD_INFO_DMA_BOUNDARY_ERROR_TRANSPARENT (1 << 0)
+#define EDD_INFO_GEOMETRY_VALID                (1 << 1)
+#define EDD_INFO_REMOVABLE                     (1 << 2)
+#define EDD_INFO_WRITE_VERIFY                  (1 << 3)
+#define EDD_INFO_MEDIA_CHANGE_NOTIFICATION     (1 << 4)
+#define EDD_INFO_LOCKABLE                      (1 << 5)
+#define EDD_INFO_NO_MEDIA_PRESENT              (1 << 6)
+#define EDD_INFO_USE_INT13_FN50                (1 << 7)
+
+struct edd_device_params {
+	u16 length;
+	u16 info_flags;
+	u32 num_default_cylinders;
+	u32 num_default_heads;
+	u32 sectors_per_track;
+	u64 number_of_sectors;
+	u16 bytes_per_sector;
+	u32 dpte_ptr;		/* 0xFFFFFFFF for our purposes */
+	u16 key;		/* =3D 0xBEDD */
+	u8 device_path_info_length;	/* =3D 44 */
+	u8 reserved2;
+	u16 reserved3;
+	u8 host_bus_type[4];
+	u8 interface_type[8];
+	union {
+		struct {
+			u16 base_address;
+			u16 reserved1;
+			u32 reserved2;
+		} __attribute__ ((packed)) isa;
+		struct {
+			u8 bus;
+			u8 slot;
+			u8 function;
+			u8 channel;
+			u32 reserved;
+		} __attribute__ ((packed)) pci;
+		/* pcix is same as pci */
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) ibnd;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) xprs;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) htpt;
+		struct {
+			u64 reserved;
+		} __attribute__ ((packed)) unknown;
+	} interface_path;
+	union {
+		struct {
+			u8 device;
+			u8 reserved1;
+			u16 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) ata;
+		struct {
+			u8 device;
+			u8 lun;
+			u8 reserved1;
+			u8 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) atapi;
+		struct {
+			u16 id;
+			u64 lun;
+			u16 reserved1;
+			u32 reserved2;
+		} __attribute__ ((packed)) scsi;
+		struct {
+			u64 serial_number;
+			u64 reserved;
+		} __attribute__ ((packed)) usb;
+		struct {
+			u64 eui;
+			u64 reserved;
+		} __attribute__ ((packed)) i1394;
+		struct {
+			u64 wwid;
+			u64 lun;
+		} __attribute__ ((packed)) fibre;
+		struct {
+			u64 identity_tag;
+			u64 reserved;
+		} __attribute__ ((packed)) i2o;
+		struct {
+			u32 array_number;
+			u32 reserved1;
+			u64 reserved2;
+		} __attribute__ ((packed)) raid;
+		struct {
+			u8 device;
+			u8 reserved1;
+			u16 reserved2;
+			u32 reserved3;
+			u64 reserved4;
+		} __attribute__ ((packed)) sata;
+		struct {
+			u64 reserved1;
+			u64 reserved2;
+		} __attribute__ ((packed)) unknown;
+	} device_path;
+	u8 reserved4;
+	u8 checksum;
+} __attribute__ ((packed));
+
+struct edd_info {
+	u8 device;
+	u8 version;
+	u16 interface_support;
+	u16 legacy_cylinders;
+	u8 legacy_heads;
+	u8 legacy_sectors;
+	struct edd_device_params params;
+} __attribute__ ((packed));
+
+extern struct edd_info edd[EDDMAXNR];
+extern unsigned char eddnr;
+extern unsigned int edd_disk80_sig;
+
+#endif				/*!__ASSEMBLY__ */
+
+#endif				/* _LINUX_EDD_H */

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


This BitKeeper patch contains the following changesets:
1.1631
## Wrapped with gzip_uu ##


M'XL( %@E5T   ]1;>W/:R);_6WR*GF12U[[!6"] 4./9$(,3UL\"DLWLSA8E
MI,8H%A(E"0-3?/C]G6X)Q,MV,LGN7B9C&^GTZ?-^J?6:?8IY5%>N[23I-\-Q
M[(P*K]G',$[JBLM]O^2$8USHA"$NG([",3\=3DNP+L=3D/!PREWWU/>"Z?Q$+Y5/
M\.UD;E4J9@$K[NS$&;%''L5U12L9JRO)8L+K2J?UX=3D-5HU,HG)VQ\Y$=3DW/,N
M3]C962$)HT?;=3D^-W=3DC+RPZ"41'80CWEB$R'+%>A25U4=3D_Y6UJJ&6*TNMHIK5
MI:.YFF:;&G=3D5W;1 QPK;9.+4JFHIC%V_%$;WFXA,U=3D!,75<UPP(BW3 +3::5
MM(JA,=3D4\58U3K<(TM:[J];)UHE;JJLIRXGJ7B8F]!=3DR)6GC/?BP3YP6'M9K-
M.IOP:!A&8_K"'-OW8Q8&# +O5\PB&X>/G$$#)0?;LX#/F.M%S(T\4L'IT(O&
M,SOB0(5_O9$7LXE0!]"$LY@E(\[>MV^[$G?H\B*;1/S1"Z>QOV"#J><GV Q_
M@@#:LDB;# B=3DO&<'+IO&W%U3Q.R8S2"9(IMYR8B-O< ;VSYSIQ/?<^S$ V X
M%%N5)%%V!)OR#*MR^L"C@/NGDAGB*Z;=3DMEF1]['0"QQ_ZO)3.QZ?B/5T8[1>
MF-T7ABIO2HF"Q)B/!^"*R$@7#"-H<DW+ (9_&O-D.BEU@0GHMNX1OBZ1#PE=20
MJJ_3W5P)G*TDL0U"R($6"MA,2L#&XU+ADE4TV$'A;NT.A9-O_!0*JJT6?M]K
MG,L=3D\5W;#WSH^3SS .Q?KI5KL,)R&598UFU8H.'P:G58JUK?C;2BXK-4R[JA
M'R)MO^:%=3DVBJ6B/'+)M+K:Q7S66M4JE5A\/JP':-8=3D5V7DC7"N.:T\JR;%C5
M"HAZVEUWJ),Z=3D7+>:X+0I5DU-'5I:RI<MVIJ0\UQ]&KYA1SG<*XI+"\U"Z$!
M%-H/[\93I^1RN5+:SH9MIM1H!J15-?2E892UVG)0J6E#U3*MFF/5JI6GJ#F=20
M,R\O!"GC,#4N'SIA,/3N=3DTBI0M#+LFF:M:JN&T9UZ)2K[O.D;" D.JJ:9FBZ
MM=3D2AM]J+[?QR$XED!DCT"HR*&W;--2T^Y*HV,"WM[^"L+<NZ*JS\+V\RX?X[
MF1G'%>N!<LY_96;VWQM<YE#!V@T@-" DD >!+7G-X:I95EU'=3D6V[IC\OM,MM
MD:G(8_JR7*E5M&=3D-/>,S[\4K$U=3DKRXII58VERW6[X@R&Y8I9U6K& :+VX<H;
MDUFK5*U#2MP?TK<C@F%9L ;N#@9ES:[:*HS<1 I^$F,N">R$ TM]PKSW.O_*
MQE6K4M67M>' JM5T;A@5TRD/[.?5=3D<C]K7(9K%$M8CX?-=3D=3DY:).E*F*Y8>E+
M%\5-=3D:#9K@DK&)2?<KTG\5F( "B47FK@ M<^\];@?6;% G^:;FB6:@]J6KE:
M40\$\[W(-J(DY%W94%S>?G*!38IYM*D\ ^LU#2Y2K9D&U^#'0T>WG=3DKSEKD?
M\X9)E:MJ]1LRS)Z(GN87=3D:EI%+ JJFMI QL*M7AUJ ]?I,N]\;R\+*N6:GU[
M_ML;'2@!FD8%2+4!=3DX=3D#I K'M57G66/;@S1/(_!;Y4,NT R=3DZ9@'B2@G,Y?Z
MBT?AR<2^YZ5DGFPK!&&UK"^KCE&ME6%SEH8:6ST0P;X5.]Q-APQ$3_/\6FIV
M;E"E$]/U%\ 7AHPSL_ 9_Q=3D^JC!$\Z.N.Q^U5B_C7^7)SD?]&8V/P]Y[R27G
MZ'N$F-A+^\_3%XCSD@GV47"_ +C#=3DJ3TA:ES2]>^HTC_7U"?]HWJL\R?T[A>
M, V"EFYQRTZBF?@'(;Q(ZM\NVK;*++/0G8['=3DK2@_I*/)\FB3VC[A);Y]B*<
M)NQ(1ATV"=3D&E$=3DRCQV?'!4:?(W2#OL^=3D!#W<8,$^0@+LBD>@5?1MUW:4> ']
M0K.()84>6F?DI02\Q/NV!*!LC=3D$.3M!QXD=3DD0Z8HCF2SB=3DZ[H%5.!E["(F[[
M8^I%14,*9-27I[1B.7TS=3D $))$F)=3D5"X1CQP>$PQ'G3=3DQP7J>!,VMCUJUVES
M+Z@7_@1O^Y/"[HU'S^7AUHTT2H^X[>Z_DU8PD,>?A=3DOA$%^5WF+"%:7)8R?R
M)J3E5*&,T4]%R6N.!*\JJ"4'BX3'2IQ$4R=3DA6,EYT/>"85ADW?-.JW73;]]<
MW!8416GT>JV;7OOVILC0MT>^/9%3C&%($PU(@OWRRR\"KZY,@]B[#Z"">!1&
MB=3D+ZTNM?MZ[[ET7&Y] ;=3D>MC/@YA,K'W%PF,70[8D5 .V8<ZU\K0M#K7U6U4
MYU?]Z\:']GD1&H/1!2ZB$8?P[SV'!=3D/Q )'KZ$R=3D-PSC0F+8(088;B\NNJW>
M)HI0R% PZKHPM5A.2]8 7DPS(&?JVS#4.@%"@O,:=3D=3DOL[89!KG8@H",QQ4F0
M;8,BFXU@U!D+[(SE"#5515<WM6%/QOV!%\:I/AIWUWT:&4F-8$E%51!OY)(V
MMO=3D9=3D\*YVTWXA!VUN[UC.6&*IY,)&&>$)1H+]Z?55F[UR%5/7"]^.%FY"LN4
M\0C'#",B4"L(?O.KM.=3D75<@5U+F=3D6]=3D=3DQ D?,W=3DMJ)#/ .D&; <.B9=3D\+P,O
M"2FRS$(7<9\6]L6*?GI52'" G$BFXQB*<@$[+C%HDL'*>#X"C#AYZ) A+ GO
MAW("3CN.^+@$6@F!N;89!.5[I771IHV):$FH"&,\$L#6'N#4N#,.(0FR<P'N
MO B<.CG2$U:XZHM6C.U)GBQW'P_[5V6D\>V-&E<KM[5]X U@.X^<L#!GQ)V'
MHG1<L=3D92G)$=3D*4KJ@Q26@R3R$+(!T[)T];IQQXX&'*'B6"RHK3<3*_<O;#;?
M?[K(KQMJZ48B<  ZC:I%MD80"^.+!?B.^U_??KKI]3NWM_C1O+VY^H,=3DP1I^
M.5,E>G,;/ML'H6!"80$W9 0FJR>G$NF$3'1P_%<;@8B?B-+I"'=3D2$V;3P$OB
M(HO"J0A]TXG<J[*SU\R>P+H?V=3D$T$!FL<=3D%H7TI@:QNXT[ANMKN7_8NKQH>N
M +&W03Y_:)Q<4V(["GV:%'.)RMF&N^VT/TB1-%N?V=3D'(NQ^=3D7=3DM?PZ@(0YB=3D
MC;T@C.3282K]QJ<O!-L^;\EH1'Z#&D41^-C7Z7A"+APG)*),23+'V@\V>P5!
M\NB1NZ]09G+?+8G5NF*F 4+I@CH[F49<S'$123_=3DG5 JY*#H[-5'-^J^$DMV
M)/A9^DW.&.0R)D,?Z>E\&B&#)YF+45Q7YZBMM%))TF$I5D;'D=3D "BI+\6)F2
M C2:SM3%L)W2.$1%.\5%D1K\,'P@RXB$S-&)IX*[NFTT6YU^[X^[5I$2 )*I
M5 VMXG[,J98 2=3DB0]J4$*_&*C*/.>Y_KK'>F"D*NVE<B,RN:_ HX9"IQ14\'
MX-0H.\F)1"'N&%*D?W2OVC>?OHA+IKC4ZGUL=3D=3D[#",2USR!N'81T+7,[PC3T
M[?M8T(/"2 6@5L]J)E N]G(9&1$<5[K$<0I<E< ?.<(.U79IP&)',>=3D,.GG&
M.=3D$N*&&I (1RM!U_/DI5(\6\'?4N6YV;UE6_VVMT>B+]PJ36,I4&*H-_RH'=20
MLAW2VS?M7J>98;'7]4'**Y(+Y4'F$:\"PW:4SS"T_Q-JSVH>862$9F<]ZIZ5
M+VPPJ._&I]0R1R13OI8I02/9K-!0K+!44/"ACY!ZT>JP#<2N3)X5^+"2ANN"
M^"HN5^'X2A:,LV7":@3=3D\<I=3DD5'=3D-/[FE_/!@>7H()EK)[8((!8%$,3^X+[(
M]$ODIKER?GM]W;AI]F&L$%RN.,]79G9,AN*$$X^":TREZ*H$$]7#39B@Y4_H
M(=3DS,\WU8&DNA0Y3RLD18.;E#*^2#)^@.)1\;3(>H^F$]GC,B"Q<5G5Y.ZQ.A
MX+1(>>WR(5&4)ULH78 ?BTG%OK'?YFQB[P.OYZ81WS^=3D/#!_J/XKS1_VB@R-
M,#&,WG?O[0[;D<2/GC'\3:7L3A6>5HJF5W_F6$$.H[?&"GM%^UV#!%!?./UG
M@?TS?3 >@$P'/MJD$-.DIQM9*T,P\%<2 I-"8+_MD\CO[!:1B H!8I16T3R;
M*@'D?SAX3S/8.0*)ER3(/[/9K)1H!DW6"92Q211^12B+F5:NZLTBTTS+I%]@
MEG[I>J79(\A],?!%Y&&Q0FFP$2"CS-A_>/Y#S'Z3W_KB6XZ5+I^@ 4F9,6A?
MG]_;SH*=3D?^QBSR3BWB,%JP6=3D^X@\YX']>PDUP1UR5>*QWR9VXK]#.1/%I3B<
M1@Z''.YY*>#)[Y);?*Y)F83>Q*53Q.3LX3K[+?<8YW=3DQ8\ADK'./SF]O+I!5
M$-^/V7*YYW+_^K;YZ:IU3,=3D:2#9B:N!%<9)F"DJ!J'H]A&)+'8G"($["-%.;
M)Z*$7HFWH(S#1U_Y59U?I)\B>\/M>7J=3D_BRRHYUL=3DZR\IM,'TS&VMCT_0S10
M?NVT&DC,K?/>;0=3D=3DQ!M[E-W0Z)M/)<AKJ5,MRVPI &4LP+B^ !&M[XJ-%0P!
MC"02.Q'5*),W9W('9RYO.@N(F&H2K$C% KC)-![-P%2\^M.E/\-)>E'BD:D5
MR ;S% [*?./.6?[SFLW"Z '^2ET(<MK]_4(X&J&)$X?M^SRUA@8U]($8-(-0
M>-^,@OA@DM2"\M51R)'ZT'3?%06Q4.B19.[M]?N.4*=3D,Z\<O5KJTI'CJ.*C9
M"AL[U'.2A$G#5W/'<O9$'W$$"'#B- \B2>S%<N"3S$)YLXZ[^)!H- .6/#HS
MM1%[=3D4[=3D,FO1Z(L*ZIB14Z('>;4+;@'\ RK@IC2DN]7@8A=3D6)=3D@K&0,.+<&B
M1E:_4!]&E2<$>MWX<M/Y)XFV]:5']<E;_'G7Z%S3W\=3D4XV0=3DFJC2$"]HH@ID
MLMW=3D';DF::M>8JRW\NXAK5L5N;)\HB-1KU?CV;6;IXXC^S8:+("!H>VL0KZ8
M5%!DR)H2\LEXZB?I3'<8F%JZ><#G&WOGY\'K#67P+*P=3D#PTZ>2=3D^B0 D9P@9
M<M4J2<96P\ZJN8N^\#JWP39YP,"ZB1AFWV\%BU%1T"\*W$#  A/A):,"9B((
MM[QHA51LXZY')&^#?=3DHD99:$P7*IMZS?\FBZXD2<G@?L: +EN-!ZDLF2J"AE
M=3DA^A.K-!P31(/)]QCWI<5,HI+V[(X^ ?">-S^ 9ZVRB%RVP.6"1DS$;V(_5\
MH$PRDQ)*O3 3^6O!Y(2%QLPP,#>NQQZS_9F]B"4C,5NSG"J#ZG;@(=3D+E:!"!
MOIC)3PA9?"&%KF1)@D[E:2?I')C</'M6$'%A6(+W](R;D(P4W$J.&P*&_("!
MPU@7$K<DPN<VK9</'MS%2LRD\I68&V1\82"F C+Y20<N$KLWG>(A)Q3[Q"GW
MZP&("&>9T*43IMJ9BB%-IAK:NAUD31 -QR>+/A+^T7&*69ZGV]Y5T@8I0B\D
M-'!$$W(1,(IT)A'4+) #IK[+[A&EZ-G!+****V A27?FQ;RTCJHNE^,/1$HQ
M;4R?PF1CN+5FQ8!0'B[$S[YHY<500J13Y,G,2%(,V3 $FDE34P8K#2$+D\2!
M<,&-Y/IV;6I(/;%'Z["_,$KIO9D]K4AX0,'&ODX1" =3D4;'%AQKFZX$BH\UC=20
MDCP9RK=3DI%DOA*GNKC)PVQ0P?B8NX%_/8/IRUGBT[_]@ZOP3%K9MN^_:F>]=3DI
M=3D5LW/5'@R+1\,0T<,<$RM1RKXLF$)DH)L9]XLB*2O2(2O9)>?9#!@FQ6I&XB
M@G*JN!V$LJ?.FQX(59SQ)+>+OMX%&I>/<"+O?I3\&S "$Z&D^).BG,"<Z"N-
MZ?Y,N8142#1Q_<0Z@E*.E57"W\@G&;0]2J&K6]!94I%R0$V6PE6VX/@JA9-(
MG(&RUJ&@,9%*9K-51(G1P"8CA/Q447"!OJ2M+QY*Q/6<\+,,+'=3D?[3V9)G)(
MGT*J<U5"Z"N0PS66M(8/K9X<UV*+QG6KUTIK725O!]9S>DX-NQE2B!<F)[T%
M!35U(-,H6,$@Q&6Y8(S6A\9W&?LR\\)DB?=3DY&,D2D"JX-VE%E[M"6C %F_ON
M2 $4UK5FQ_81\:)P%OPC9O1,+(JF\,(KCYH-2ASRB#!K=3D>O--F5LD$I/\$9U
M\9.]POW[J1TA%=3DS;7H!5PH8A4E13Z](Z*[W7U.Q><;W#M?AND9SV<B1GYOCA
M8$ Q%>8M%2CJ[*O6A\;Y'X<TF?=3DHU=3DHJSY_<>L>9Y0U25ZHJ<NP]"TGOW%U3
M^,;Q1<MT>*NK<,8J;."E67=3D,^D9>'*2$&A=3D/K*?R-VV,MKPZBP&:L(;=3D=3D1VD
M4V@4NPD$.8+=3DT88A/;E4M&[YG27+HQ>P;$F6D;X($0I.M$NC2 #\6J$>T-\1
MXN@PQH\T6=3D=3DW41YT'!EY<KJL;[5>JR^KEO(-934@DKZ\*G%BV+3MNIO1:C,U
M9BZL2#*P0FX?R.0DHJ9,9AN8Q2L4J#5E;!2I8I"FBB]4\Z2!EM&JVZE\J#1!
M?T"Y8J!LI, T^?()/829K$.OY/PU#UQO*":Q^P^MTRSVAY^:+]@/D_&[[&V8
MO0<WMY'2C%"GDZETEMNH&%4Q$M3U;"98%J_(U.IF^?]B4-OA ;K,^J&72$Y^
M/_3ZR"73JKJZ/44\ /RCYK!/OYY0!I<UL[Q4!65"RL8WGN?2V(GV\]Y#$H6%
M>-^('H^+EVW2@Q:;I[9W7KZ!M.4[%S]+W,TRS+#0%C\/# OW>EIZL'CSN<<A
MJ&>???R]5Q .//]X^LVS_V?//PZ*CDY=3D@NE].L] .FQ'(C_Z.<@/4-#NLY!G
M7@VL_<Q'(?+%D^>\*I/PMXN1'H?4Q/CN(I3CE?59J:P+7@0)4K_X)N>1V&H:
MR5,)9#U%&D=3DQOG7P\X'>'W1/'R3\B0_^I^GY3W3A2)4 G;)7%RD/<O1)L\0_
M"ZG/(B05E"1"28T^G[UZ>EP*RE&$C^FAJ#@D(9Z5'+6^W+4Z[6LTI(VK8Q36
M+DP^<,7KE?E;!67$_4E!8:QK+]@?-$ZZWCC -4L?Y" 9T;&L0Z0(##R2(Q Z
M],7$F4\!+JFDUQU7A,HA"5%*"P64/)$D.*#(FPV$<D?JY)R*!^@1:5Z)_1\]
M.S6)82Q:UG11.,G@ <HC3^@&1=3D]@2I,"W^./<K(T@([M(=3D2(A30\&H=3DQ*C\Z
M;!C1F=3DE(4O<(X=3D&PT@TI5; %&AQO//&SL11V&G+Q\(3( "RI>']<SMX*>"8P
M9V#?'IF_[27( Z&Y]B\=3DFE?"H^?3X'I?Y%C!=3D-B.3'YZ</X.'>U&YZ=3DU]%./
MOXM77Y^+S2L)?U=3DP-D5L7GE+-L<5^D^/J% T#0=3D?3W[=3D>$":_RAOST0U%PI?
MW//"W,%6Y.^\KG>P%3F,=3D*,5J?Q/,U?6TS80A)_K7[&B+TFX[/7Z:H34TE"5
MJH4*J-2J5%%*3!LI(5$.I CX[YV9];6^@@UN*P$!XUU[=3DXZ=3D\W,M>2)[BB?"
MW5=3D"_$M/I* K'3R1O'YTE#TOPR5Y=3DSZ7F)4T1((#PETAP '!=3DR)YJMH/Y+)=3D
MYZ\Z(&E7@^KBPB;[>=3D0F@8WVLL^SD:WN<70_\ ?60]!4>1/W#+K/"&X\O@&3
MZF:U7/PFO 3R8>^09W;D^S^H* 2SZ8RJ_A<P"LPPB:J!!@?,:S$.\]J,A_-F
MYU(;-G;D@:Q:#CB82 7;-@^A#"C',QRF$UF8=3D<AUWW9D@J%GZOA.I@$_7XZN
M;X;^->M3L2?58KS7PB(UY>*QX3BP.9>P)%>GO:(/&2W!8,U^1QF ]2%1-5M.
M*SNJKN=3DJHL>)%JN%#S,5]'1GFRZYX1J> '5WSUTC !AQ*\H4;Q1<)+!99?U?
M;)1*>W04H7KX@_EX+0M55S,JPK*RPE2T%W4.-\NTB',"9WYK;V\?OE(57N@.
MI,D?P0<4T[XB9,%FPA=3D %CC@26+_/5(=3DEE,YEM,@V5%+Q@;!P005:4#J:#%@
MQS@ZAZ, O'>"7B@A=3DSRH!JT-TP4A3[Y.AJJJ]BHF;9UV_<WT+6O7Q]))1\B=20
MG<FKRG:SR$%(902\^36>_@3)OAW,1RCMY&@6KV\'AF/:G8;*.@P,\Z53[O)L
M6/@$.A1-O8?6+R@'Y!J)8U#"-:DFPAJL(XSBD-^Q*5S&1<TJ0:4O"/7CS;RK
M!8U>&,?'HQ-_^1YF!WYTXS&8]J)@/_C)KHZE7EU\#3P$,X_2CKY^/CV[Z)]_
M^W1X^K%%3VIWLU?SKB4> /\.D@K[G8XL,HTJ)W;96Z2G@O:D].%UU.Q.+KV#
M8G0,!K#9>' %;CSK4(4FAF!&",A$=3D?"WT]$P?CC^U=3D;N9'*4UL8.\/G]D[.N
MO#CQ)U>S-:Z&2DOZ5$.(B>;I-2V[W8T&)Y8+L\2%=3DB=3DO+KZ<'76U!]B",5:(
M!;9%8@N&4W;W@#$5;(K2V^%>70*7V#;PT(OXWJ[B".4C/J@:Z#EP)_*UT.:9
M3=3DW6'8XUT<:]X+:P21.)BHK(;%0/!>3 8@3D).KS 1:D2A/%RE!9#HUV0M(H
M,-KS-Z6.&N$N,R.N2?,5:W5:2<GNM%F+TM[;V5+/=3DC2+Y''BW.1XTB;Q##*?
MJ(["_A0:UDJK&V4<W-;.[>5(V+[- 9 \(I68AT$2^N^&Z5E!DBMK#Y>G$C')
M!5J],68E!S,+$U<&$%<$#P?\2U@KY<T*]:WDGG"8I_5 <L#(M%SX,(1V;'M.
M\E#<"DQEE5-2^"M5F*46'HSV83 !Z^!PNEQ.)V-__?I\Z?OCH[6/DY=3DEHM-A
M0-!SE@Y6%R(*><1!5E4.TAM-D\KR3.(@<*56XPSK!"U^8%4CQDTA;Z367RLL
M@79U+MT3AG23,'B/+SA(V=3D;PS6T\*QTOQ.4TLM'=3DS8JB8351,0LN<?TV4?PI
MYK!>; [WA BX(8W1MID+ZB'$%5(_'R2.&YX.KC=3DW[X5KZ++01%3UJ)IWF]-A
M+R1T(IDB >X*XOY/"?=3D;Z.I@*'^-@;#M Q;%W5(BGJAJ: BPK;HR3V7:0R4N
M7(];@7AG8\V;Q;M!4I-\AUNYI&8.18WG8=3D.BB!,H7:&(U\_%PRD/PJW#\2X\
M8 39/<>VBK+]6YD02E6VJ -4N3F4D@M4:=3DQ;IF,%$F__5_'1,(02[A["@JRU
M=3D\P&_\U& X\0-DMB'$^HOC ]C_%'4/HR!MZF\L/%:G)P[>A@:%N^]@<, @,L
$ZEL    =20
=20

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAVyoQIavu95Lw/AkRAkenAJ9+FJzx1e2YqCTYbKjvLqxTp6LHHQCfTgI0
xC6GoWhYAetgZyPJt8mNVOQ=
=qptX
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
