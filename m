Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUCWPdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 10:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUCWPdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 10:33:23 -0500
Received: from linux.us.dell.com ([143.166.224.162]:47959 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262634AbUCWPcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 10:32:43 -0500
Date: Tue, 23 Mar 2004 09:31:42 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] let EDD work on x86-64 too
Message-ID: <20040323153142.GA20267@lists.us.dell.com>
References: <20040316162344.GA20289@lists.us.dell.com> <20040316165127.GB6145@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20040316165127.GB6145@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2004 at 05:51:27PM +0100, Andi Kleen wrote:
> On Tue, Mar 16, 2004 at 10:23:44AM -0600, Matt Domsch wrote:
> > Andi, I'm proposing allowing my BIOS Enhanced Disk Drive (EDD) code to
> > work on x86-64 as it does on x86 today.  The patch below moves some
> > files around out of arch/i386/kernel and include/asm-i386 into more
> > generic locations, and allows EDD to work.
>=20
> I have no problems with the x86-64 changes (assuming they work).
>=20
> But I won't push the i386 changes. I would suggest you get that into
> mainline first and when it's there send me a patch with just the x86-64
> bits.

The i386 changes have hit 2.6.5-rc2.  x86-64 patch below for your
consideration.  I'm intentionally not copying the
Documentation/i386/zero_page.txt file as it's the same as x86 in this
regard.  This boots and works for me.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


EDD: Enable x86_64

reserve boot_params space
include arch/i386/boot/edd.S
include EDD in Kconfig and defconfig
reserve global vars in setup.c, copy data

 arch/x86_64/Kconfig            |    2 ++
 arch/x86_64/boot/setup.S       |    2 ++
 arch/x86_64/defconfig          |    1 +
 arch/x86_64/kernel/setup.c     |   26 ++++++++++++++++++++++++++
 include/asm-x86_64/bootsetup.h |    3 +++
 5 files changed, 34 insertions(+)

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

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAYFheIavu95Lw/AkRAjWFAJ92O0cexTGIfgEbVMczM93I4Zx6PwCghp8/
uGymTcQ5fIdrD9AHzJj36Po=
=P+sy
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
