Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUCQXQS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUCQXPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:15:00 -0500
Received: from lists.us.dell.com ([143.166.224.162]:46013 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262147AbUCQXJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:09:46 -0500
Date: Wed, 17 Mar 2004 17:09:07 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] move EDD code from i386-specific locations to generic
Message-ID: <20040317230907.GD30399@lists.us.dell.com>
References: <20040317230540.GA30399@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <20040317230540.GA30399@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

EDD: split EDD assembly code from setup.S into edd.S

This will enable it to be #included into x86-64 too.


 edd.S   |  127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 setup.S |  125 -----------------------------------------------------------=
---
 2 files changed, 128 insertions, 124 deletions

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -urNp --exclude-from=3D/home/mdomsch/excludes --minimal -u linux-2.6.5=
-rc1-mm1-edd/arch/i386/boot/edd.S linux-2.6.5-rc1-mm1-edd2/arch/i386/boot/e=
dd.S
--- linux-2.6.5-rc1-mm1-edd/arch/i386/boot/edd.S	Wed Dec 31 18:00:00 1969
+++ linux-2.6.5-rc1-mm1-edd2/arch/i386/boot/edd.S	Wed Mar 17 16:52:19 2004
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
+# in the boot_params at EDDBUF.  The first four bytes of which are
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
+# A second one-byte buffer, EDDNR, in the boot_params stores
+# the number of BIOS devices which exist, up to EDDMAXNR.
+# In setup.c, copy_edd() stores both boot_params buffers away
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
diff -urNp --exclude-from=3D/home/mdomsch/excludes --minimal -u linux-2.6.5=
-rc1-mm1-edd/arch/i386/boot/setup.S linux-2.6.5-rc1-mm1-edd2/arch/i386/boot=
/setup.S
--- linux-2.6.5-rc1-mm1-edd/arch/i386/boot/setup.S	Wed Mar 17 16:51:37 2004
+++ linux-2.6.5-rc1-mm1-edd2/arch/i386/boot/setup.S	Wed Mar 17 16:52:22 2004
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
@@ -581,120 +571,7 @@ no_32_apm_bios:
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
-# in the boot_params at EDDBUF.  The first four bytes of which are
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
-# A second one-byte buffer, EDDNR, in boot_params stores
-# the number of BIOS devices which exist, up to EDDMAXNR.
-# In setup.c, copy_edd() stores both boot_params buffers away
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

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAWNqTIavu95Lw/AkRAm47AJ9YchAIuCbsg4UP0Cg103nCec5KFACfW73X
cdoO0uTG5EvNSfcUpazmDAE=
=S3sb
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
