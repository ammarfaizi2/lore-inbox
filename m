Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTHSUop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTHSUmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:42:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:64467 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261388AbTHSUc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:32:58 -0400
Subject: Gcov-kernel patch update for 2.6.0-test3
From: Paul Larson <plars@linuxtestproject.org>
To: ltp-coverage@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-hc1kGdlVjSaDjgepFA3S"
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Aug 2003 15:32:48 -0500
Message-Id: <1061325169.3910.196.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hc1kGdlVjSaDjgepFA3S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's another resync of the kernel patch (originally by Hubertus Franke
and Rajan Ravindran) to allow the gcov coverage analysis tool to be used
on Linux kernel code.

This is mostly just an update for 2.6.0-test3 but also includes the port
to s390/s390x, but I have not been able to test this yet.

These patche is attached, and can also be downloaded from:
https://sourceforge.net/project/showfiles.php?group_id=3382

The LCOV tools to analyze the results that come out of this can also be
downloaded there.  For more information about this patch, please see:
http://ltp.sourceforge.net/coverage/gcov-kernel.php

Thanks,
Paul Larson




--=-hc1kGdlVjSaDjgepFA3S
Content-Disposition: attachment; filename=gcov-2.6.0-test3.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=gcov-2.6.0-test3.patch; charset=ISO-8859-1

# Makefile                            |   12=20
# arch/i386/Kconfig                   |   30 +
# arch/i386/boot/compressed/Makefile  |    1=20
# arch/i386/kernel/head.S             |   21 +
# arch/ppc/Kconfig                    |   30 +
# arch/ppc/boot/openfirmware/common.c |    4=20
# arch/ppc/boot/prep/misc.c           |    4=20
# arch/ppc/kernel/Makefile            |    4=20
# arch/ppc/kernel/entry.S             |   16=20
# arch/ppc/kernel/head.S              |   22 +
# arch/ppc/syslib/prom_init.c         |    4=20
# arch/ppc64/Kconfig                  |   31 +
# arch/ppc64/kernel/head.S            |   21 +
# arch/s390/Kconfig                   |   30 +
# arch/s390/kernel/head.S             |   20 +
# arch/s390/kernel/head64.S           |   20 +
# arch/x86_64/Kconfig                 |   31 +
# arch/x86_64/kernel/head.S           |   20 +
# drivers/Makefile                    |    1=20
# drivers/gcov/Makefile               |    8=20
# drivers/gcov/gcov-proc.c            |  713 ++++++++++++++++++++++++++++++=
++++++
# include/linux/module.h              |    5=20
# init/main.c                         |    4=20
# kernel/Makefile                     |    6=20
# kernel/gcov.c                       |  158 +++++++
# kernel/module.c                     |   23 +
# scripts/Makefile.build              |   24 +
# 27 files changed, 1257 insertions(+), 6 deletions(-)

diff -Naurp linux-2.6.0-test3/Makefile linux-2.6.0-test3-gcov/Makefile
--- linux-2.6.0-test3/Makefile	Fri Aug  8 23:38:16 2003
+++ linux-2.6.0-test3-gcov/Makefile	Mon Aug 18 16:48:46 2003
@@ -1,7 +1,7 @@
 VERSION =3D 2
 PATCHLEVEL =3D 6
 SUBLEVEL =3D 0
-EXTRAVERSION =3D -test3
+EXTRAVERSION =3D -test3-gcov
=20
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
@@ -76,6 +76,8 @@ HOSTCXX  	=3D g++
 HOSTCFLAGS	=3D -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
 HOSTCXXFLAGS	=3D -O2
=20
+GCOV_FLAGS	=3D -fprofile-arcs -ftest-coverage
+
=20
 # 	That's our default target when none is given on the command line
 #	Note that 'modules' will be added as a prerequisite as well,=20
@@ -235,6 +237,8 @@ export	VERSION PATCHLEVEL SUBLEVEL EXTRA
 export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE=20
 export AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
+export CFLAGS_NOGCOV
+
=20
 export MODVERDIR :=3D .tmp_versions
=20
@@ -534,6 +538,11 @@ depend dep:
 # ------------------------------------------------------------------------=
---
 # Modules
=20
+CFLAGS_NOGCOV :=3D $(CFLAGS)
+ifdef CONFIG_GCOV_ALL
+CFLAGS +=3D $(GCOV_FLAGS)
+endif
+
 ifdef CONFIG_MODULES
=20
 # 	By default, build modules as well
@@ -716,6 +725,7 @@ clean: archclean $(clean-dirs)
 	$(call cmd,rmclean)
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
+		-o -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
 		-type f -print | xargs rm -f
=20
diff -Naurp linux-2.6.0-test3/arch/i386/Kconfig linux-2.6.0-test3-gcov/arch=
/i386/Kconfig
--- linux-2.6.0-test3/arch/i386/Kconfig	Fri Aug  8 23:32:43 2003
+++ linux-2.6.0-test3-gcov/arch/i386/Kconfig	Mon Aug 18 16:48:25 2003
@@ -1245,6 +1245,36 @@ source "net/bluetooth/Kconfig"
=20
 source "arch/i386/oprofile/Kconfig"
=20
+menu "GCOV coverage profiling"
+
+config GCOV_PROFILE
+	bool "GCOV coverage profiling"
+	---help---
+	Provide infrastructure for coverage support for the kernel. This
+	will not compile the kernel by default with the necessary flags.
+	To obtain coverage information for the entire kernel, one should
+	enable the subsequent option (Profile entire kernel). If only
+	particular files or directories of the kernel are desired, then
+	one must provide the following compile options for such targets:
+      		"-fprofile-arcs -ftest-coverage" in the CFLAGS. To obtain
+	access to the coverage data one must insmod the gcov-proc kernel
+	module.
+
+config GCOV_ALL
+	bool "GCOV_ALL"
+	depends on GCOV_PROFILE
+	---help---
+	If you say Y here, it will compile the entire kernel with coverage
+	option enabled.
+
+config GCOV_PROC
+	tristate "gcov-proc module"
+	depends on GCOV_PROFILE && PROC_FS
+	---help---
+	This is the gcov-proc module that exposes gcov data through the=20
+	/proc filesystem
+
+endmenu
=20
 menu "Kernel hacking"
=20
diff -Naurp linux-2.6.0-test3/arch/i386/boot/compressed/Makefile linux-2.6.=
0-test3-gcov/arch/i386/boot/compressed/Makefile
--- linux-2.6.0-test3/arch/i386/boot/compressed/Makefile	Fri Aug  8 23:38:5=
2 2003
+++ linux-2.6.0-test3-gcov/arch/i386/boot/compressed/Makefile	Mon Aug 18 16=
:48:25 2003
@@ -7,6 +7,7 @@
 targets		:=3D vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
 EXTRA_AFLAGS	:=3D -traditional
=20
+CFLAGS :=3D $(CFLAGS_NOGCOV)
 LDFLAGS_vmlinux :=3D -Ttext $(IMAGE_OFFSET) -e startup_32
=20
 $(obj)/vmlinux: $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o FORCE
diff -Naurp linux-2.6.0-test3/arch/i386/kernel/head.S linux-2.6.0-test3-gco=
v/arch/i386/kernel/head.S
--- linux-2.6.0-test3/arch/i386/kernel/head.S	Fri Aug  8 23:32:32 2003
+++ linux-2.6.0-test3-gcov/arch/i386/kernel/head.S	Mon Aug 18 16:48:25 2003
@@ -487,3 +487,24 @@ ENTRY(cpu_gdt_table)
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
 #endif
=20
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ *
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */
+
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
+
diff -Naurp linux-2.6.0-test3/arch/ppc/Kconfig linux-2.6.0-test3-gcov/arch/=
ppc/Kconfig
--- linux-2.6.0-test3/arch/ppc/Kconfig	Fri Aug  8 23:42:16 2003
+++ linux-2.6.0-test3-gcov/arch/ppc/Kconfig	Mon Aug 18 16:48:25 2003
@@ -1378,6 +1378,36 @@ source "net/bluetooth/Kconfig"
=20
 source "lib/Kconfig"
=20
+menu "GCOV coverage profiling"
+
+config GCOV_PROFILE
+	bool "GCOV coverage profiling"
+	---help---
+	Provide infrastructure for coverage support for the kernel. This
+	will not compile the kernel by default with the necessary flags.
+	To obtain coverage information for the entire kernel, one should
+	enable the subsequent option (Profile entire kernel). If only
+	particular files or directories of the kernel are desired, then
+	one must provide the following compile options for such targets:
+		"-fprofile-arcs -ftest-coverage" in the CFLAGS. To obtain
+	access to the coverage data one must insmod the gcov-prof kernel
+	module.
+
+config GCOV_ALL
+	bool "GCOV_ALL"
+	depends on GCOV_PROFILE
+	---help---
+	If you say Y here, it will compile the entire kernel with coverage
+	option enabled.
+
+config GCOV_PROC
+        tristate "gcov-proc module"
+        depends on GCOV_PROFILE && PROC_FS
+        ---help---
+        This is the gcov-proc module that exposes gcov data through the
+        /proc filesystem
+
+endmenu
=20
 menu "Kernel hacking"
=20
diff -Naurp linux-2.6.0-test3/arch/ppc/boot/openfirmware/common.c linux-2.6=
.0-test3-gcov/arch/ppc/boot/openfirmware/common.c
--- linux-2.6.0-test3/arch/ppc/boot/openfirmware/common.c	Fri Aug  8 23:40:=
10 2003
+++ linux-2.6.0-test3-gcov/arch/ppc/boot/openfirmware/common.c	Mon Aug 18 1=
6:48:25 2003
@@ -30,6 +30,10 @@ struct memchunk {
=20
 static struct memchunk *freechunks;
=20
+#ifdef CONFIG_GCOV_PROFILE
+void __bb_init_func (void *ptr /* struct bb *blocks */) { }
+#endif
+
 static void *zalloc(void *x, unsigned items, unsigned size)
 {
     void *p;
diff -Naurp linux-2.6.0-test3/arch/ppc/boot/prep/misc.c linux-2.6.0-test3-g=
cov/arch/ppc/boot/prep/misc.c
--- linux-2.6.0-test3/arch/ppc/boot/prep/misc.c	Fri Aug  8 23:38:39 2003
+++ linux-2.6.0-test3-gcov/arch/ppc/boot/prep/misc.c	Mon Aug 18 16:48:25 20=
03
@@ -71,6 +71,10 @@ extern unsigned long serial_init(int cha
 extern void serial_fixups(void);
 extern unsigned long get_mem_size(void);
=20
+#ifdef CONFIG_GCOV_PROFILE
+void __bb_init_func (void *ptr /* struct bb *blocks */) { }
+#endif
+
 void
 writel(unsigned int val, unsigned int address)
 {
diff -Naurp linux-2.6.0-test3/arch/ppc/kernel/Makefile linux-2.6.0-test3-gc=
ov/arch/ppc/kernel/Makefile
--- linux-2.6.0-test3/arch/ppc/kernel/Makefile	Fri Aug  8 23:40:55 2003
+++ linux-2.6.0-test3-gcov/arch/ppc/kernel/Makefile	Mon Aug 18 16:48:25 200=
3
@@ -15,8 +15,8 @@ extra-$(CONFIG_40x)		:=3D head_4xx.o
 extra-$(CONFIG_8xx)		:=3D head_8xx.o
 extra-$(CONFIG_6xx)		+=3D idle_6xx.o
=20
-obj-y				:=3D entry.o traps.o irq.o idle.o time.o misc.o \
-					process.o signal.o ptrace.o align.o \
+obj-y				:=3D entry.o ptrace.o traps.o irq.o idle.o time.o misc.o \
+					process.o signal.o align.o \
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o
 obj-$(CONFIG_6xx)		+=3D l2cr.o cpu_setup_6xx.o
diff -Naurp linux-2.6.0-test3/arch/ppc/kernel/entry.S linux-2.6.0-test3-gco=
v/arch/ppc/kernel/entry.S
--- linux-2.6.0-test3/arch/ppc/kernel/entry.S	Fri Aug  8 23:40:51 2003
+++ linux-2.6.0-test3-gcov/arch/ppc/kernel/entry.S	Mon Aug 18 16:48:25 2003
@@ -106,10 +106,26 @@ transfer_to_handler:
 	mfspr	r11,SPRN_HID0
 	mtcr	r11
 BEGIN_FTR_SECTION
+#ifdef CONFIG_GCOV_PROFILE
+	bt-	8,near1_power_save_6xx_restore	/* Check DOZE */
+	b       skip1_power_save_6xx_restore   =20
+near1_power_save_6xx_restore:
+	b	power_save_6xx_restore
+skip1_power_save_6xx_restore:
+#else
 	bt-	8,power_save_6xx_restore	/* Check DOZE */
+#endif
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
 BEGIN_FTR_SECTION
+#ifdef CONFIG_GCOV_PROFILE
+	bt-	9,near2_power_save_6xx_restore	/* Check NAP */
+	b	skip2_power_save_6xx_restore
+near2_power_save_6xx_restore:
+	b	power_save_6xx_restore
+skip2_power_save_6xx_restore:
+#else
 	bt-	9,power_save_6xx_restore	/* Check NAP */
+#endif
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #endif /* CONFIG_6xx */
 	.globl transfer_to_handler_cont
diff -Naurp linux-2.6.0-test3/arch/ppc/kernel/head.S linux-2.6.0-test3-gcov=
/arch/ppc/kernel/head.S
--- linux-2.6.0-test3/arch/ppc/kernel/head.S	Fri Aug  8 23:37:20 2003
+++ linux-2.6.0-test3-gcov/arch/ppc/kernel/head.S	Mon Aug 18 16:48:25 2003
@@ -1643,3 +1643,25 @@ intercept_table:
  */
 abatron_pteptrs:
 	.space	8
+
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ * =20
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */=20
+=20
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
+
diff -Naurp linux-2.6.0-test3/arch/ppc/syslib/prom_init.c linux-2.6.0-test3=
-gcov/arch/ppc/syslib/prom_init.c
--- linux-2.6.0-test3/arch/ppc/syslib/prom_init.c	Fri Aug  8 23:42:16 2003
+++ linux-2.6.0-test3-gcov/arch/ppc/syslib/prom_init.c	Mon Aug 18 16:48:25 =
2003
@@ -667,7 +667,11 @@ prom_instantiate_rtas(void)
 		 * Actually OF has bugs so we just arbitrarily
 		 * use memory at the 6MB point.
 		 */
+#ifdef CONFIG_GCOV_PROFILE
+		rtas_data =3D 0x990000;
+#else
 		rtas_data =3D 6 << 20;
+#endif
 		prom_print(" at ");
 		prom_print_hex(rtas_data);
 	}
diff -Naurp linux-2.6.0-test3/arch/ppc64/Kconfig linux-2.6.0-test3-gcov/arc=
h/ppc64/Kconfig
--- linux-2.6.0-test3/arch/ppc64/Kconfig	Fri Aug  8 23:37:19 2003
+++ linux-2.6.0-test3-gcov/arch/ppc64/Kconfig	Mon Aug 18 16:48:25 2003
@@ -342,6 +342,37 @@ config VIOPATH
=20
 source "arch/ppc64/oprofile/Kconfig"
=20
+menu "GCOV coverage profiling"
+
+config GCOV_PROFILE
+        bool "GCOV coverage profiling"
+        ---help---
+        Provide infrastructure for coverage support for the kernel. This
+        will not compile the kernel by default with the necessary flags.
+        To obtain coverage information for the entire kernel, one should
+        enable the subsequent option (Profile entire kernel). If only
+        particular files or directories of the kernel are desired, then
+        one must provide the following compile options for such targets:
+                "-fprofile-arcs -ftest-coverage" in the CFLAGS. To obtain
+        access to the coverage data one must insmod the gcov-prof kernel
+        module.
+
+config GCOV_ALL
+        bool "GCOV_ALL"
+        depends on GCOV_PROFILE
+        ---help---
+        If you say Y here, it will compile the entire kernel with coverage
+        option enabled.
+
+config GCOV_PROC
+        tristate "gcov-proc module"
+        depends on GCOV_PROFILE && PROC_FS
+        ---help---
+        This is the gcov-proc module that exposes gcov data through the
+        /proc filesystem
+
+endmenu
+
 menu "Kernel hacking"
=20
 config DEBUG_KERNEL
diff -Naurp linux-2.6.0-test3/arch/ppc64/kernel/head.S linux-2.6.0-test3-gc=
ov/arch/ppc64/kernel/head.S
--- linux-2.6.0-test3/arch/ppc64/kernel/head.S	Fri Aug  8 23:36:51 2003
+++ linux-2.6.0-test3-gcov/arch/ppc64/kernel/head.S	Mon Aug 18 16:48:25 200=
3
@@ -2015,3 +2015,24 @@ stab_array:
 	.globl	cmd_line
 cmd_line:
 	.space	512
+
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ *
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */
+
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
diff -Naurp linux-2.6.0-test3/arch/s390/Kconfig linux-2.6.0-test3-gcov/arch=
/s390/Kconfig
--- linux-2.6.0-test3/arch/s390/Kconfig	Fri Aug  8 23:34:49 2003
+++ linux-2.6.0-test3-gcov/arch/s390/Kconfig	Mon Aug 18 16:53:24 2003
@@ -267,6 +267,36 @@ source "net/Kconfig"
=20
 source "fs/Kconfig"
=20
+menu "GCOV coverage profiling"
+
+config GCOV_PROFILE
+        bool "GCOV coverage profiling"
+        ---help---
+        Provide infrastructure for coverage support for the kernel. This
+        will not compile the kernel by default with the necessary flags.
+        To obtain coverage information for the entire kernel, one should
+        enable the subsequent option (Profile entire kernel). If only
+        particular files or directories of the kernel are desired, then
+        one must provide the following compile options for such targets:
+                "-fprofile-arcs -ftest-coverage" in the CFLAGS. To obtain
+        access to the coverage data one must insmod the gcov-proc kernel
+        module.
+
+config GCOV_ALL
+        bool "GCOV_ALL"
+        depends on GCOV_PROFILE
+        ---help---
+        If you say Y here, it will compile the entire kernel with coverage
+        option enabled.
+
+config GCOV_PROC
+        tristate "gcov-proc module"
+        depends on GCOV_PROFILE && PROC_FS
+        ---help---
+        This is the gcov-proc module that exposes gcov data through the
+        /proc filesystem
+
+endmenu
=20
 menu "Kernel hacking"
=20
diff -Naurp linux-2.6.0-test3/arch/s390/kernel/head.S linux-2.6.0-test3-gco=
v/arch/s390/kernel/head.S
--- linux-2.6.0-test3/arch/s390/kernel/head.S	Fri Aug  8 23:34:03 2003
+++ linux-2.6.0-test3-gcov/arch/s390/kernel/head.S	Mon Aug 18 16:51:48 2003
@@ -660,3 +660,23 @@ _stext:	basr  %r13,0                   =20
 .Lstart:    .long  start_kernel
 .Laregs:    .long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
=20
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ *
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */
+
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
diff -Naurp linux-2.6.0-test3/arch/s390/kernel/head64.S linux-2.6.0-test3-g=
cov/arch/s390/kernel/head64.S
--- linux-2.6.0-test3/arch/s390/kernel/head64.S	Fri Aug  8 23:34:38 2003
+++ linux-2.6.0-test3-gcov/arch/s390/kernel/head64.S	Mon Aug 18 16:52:03 20=
03
@@ -666,3 +666,23 @@ _stext:	basr  %r13,0                   =20
 .Ldw:       .quad  0x0002000180000000,0x0000000000000000
 .Laregs:    .long  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
=20
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ *
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */
+
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
diff -Naurp linux-2.6.0-test3/arch/x86_64/Kconfig linux-2.6.0-test3-gcov/ar=
ch/x86_64/Kconfig
--- linux-2.6.0-test3/arch/x86_64/Kconfig	Fri Aug  8 23:39:34 2003
+++ linux-2.6.0-test3-gcov/arch/x86_64/Kconfig	Mon Aug 18 16:48:25 2003
@@ -451,6 +451,37 @@ source "net/bluetooth/Kconfig"
=20
 source "arch/x86_64/oprofile/Kconfig"
=20
+menu "GCOV coverage profiling"
+
+config GCOV_PROFILE
+        bool "GCOV coverage profiling"
+        ---help---
+        Provide infrastructure for coverage support for the kernel. This
+        will not compile the kernel by default with the necessary flags.
+        To obtain coverage information for the entire kernel, one should
+        enable the subsequent option (Profile entire kernel). If only
+        particular files or directories of the kernel are desired, then
+        one must provide the following compile options for such targets:
+                "-fprofile-arcs -ftest-coverage" in the CFLAGS. To obtain
+        access to the coverage data one must insmod the gcov-prof kernel
+        module.
+
+config GCOV_ALL
+        bool "GCOV_ALL"
+        depends on GCOV_PROFILE
+        ---help---
+        If you say Y here, it will compile the entire kernel with coverage
+        option enabled.
+
+config GCOV_PROC
+        tristate "gcov-proc module"
+        depends on GCOV_PROFILE && PROC_FS
+        ---help---
+        This is the gcov-proc module that exposes gcov data through the
+        /proc filesystem
+
+endmenu
+
 menu "Kernel hacking"
=20
 config DEBUG_KERNEL
diff -Naurp linux-2.6.0-test3/arch/x86_64/kernel/head.S linux-2.6.0-test3-g=
cov/arch/x86_64/kernel/head.S
--- linux-2.6.0-test3/arch/x86_64/kernel/head.S	Fri Aug  8 23:38:15 2003
+++ linux-2.6.0-test3-gcov/arch/x86_64/kernel/head.S	Mon Aug 18 16:48:25 20=
03
@@ -383,3 +383,23 @@ ENTRY(idt_table)=09
 	.quad 	0
 	.endr
=20
+#ifdef CONFIG_GCOV_PROFILE
+/*
+ * The .ctors-section contains a list of pointers to constructor
+ * functions which are used to initialize gcov structures.
+ *
+ * Because there is no NULL at the end of the constructor list
+ * in the kernel we need the addresses of both the constructor
+ * as well as the destructor list which are supposed to be
+ * adjacent.
+ */
+
+.section ".ctors","aw"
+.globl  __CTOR_LIST__
+.type   __CTOR_LIST__,@object
+__CTOR_LIST__:
+.section ".dtors","aw"
+.globl  __DTOR_LIST__
+.type   __DTOR_LIST__,@object
+__DTOR_LIST__:
+#endif
diff -Naurp linux-2.6.0-test3/drivers/Makefile linux-2.6.0-test3-gcov/drive=
rs/Makefile
--- linux-2.6.0-test3/drivers/Makefile	Fri Aug  8 23:39:36 2003
+++ linux-2.6.0-test3-gcov/drivers/Makefile	Mon Aug 18 16:48:25 2003
@@ -49,3 +49,4 @@ obj-$(CONFIG_ISDN_BOOL)		+=3D isdn/
 obj-$(CONFIG_MCA)		+=3D mca/
 obj-$(CONFIG_EISA)		+=3D eisa/
 obj-$(CONFIG_CPU_FREQ)		+=3D cpufreq/
+obj-$(CONFIG_GCOV_PROC)		+=3D gcov/
diff -Naurp linux-2.6.0-test3/drivers/gcov/Makefile linux-2.6.0-test3-gcov/=
drivers/gcov/Makefile
--- linux-2.6.0-test3/drivers/gcov/Makefile	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test3-gcov/drivers/gcov/Makefile	Mon Aug 18 16:48:25 2003
@@ -0,0 +1,8 @@
+#
+# Makefile for GCOV profiling kernel module
+#
+
+obj-$(CONFIG_GCOV_PROC)	+=3D gcov-proc.o
+
+$(obj)/gcov-proc.o: $(obj)/gcov-proc.c
+
diff -Naurp linux-2.6.0-test3/drivers/gcov/gcov-proc.c linux-2.6.0-test3-gc=
ov/drivers/gcov/gcov-proc.c
--- linux-2.6.0-test3/drivers/gcov/gcov-proc.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test3-gcov/drivers/gcov/gcov-proc.c	Mon Aug 18 16:48:25 200=
3
@@ -0,0 +1,713 @@
+/*
+ * This kernel module provides access to coverage data produced by
+ * an instrumented kernel via an entry in the proc file system
+ * at /proc/gcov/.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, U=
SA.
+ *
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ * Author: Hubertus Franke <frankeh@us.ibm.com>
+ *         Rajan Ravindran <rajancr@us.ibm.com>
+ *
+ * 	Bugfixes by Peter.Oberparleiter@de.ibm.com:
+ * 	Changes by Paul Larson
+ * 		Automatically detect gcc version for gcov_type
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>  =20
+#include <linux/module.h>  =20
+
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+
+MODULE_LICENSE("GPL");
+#define GCOV_PROF_PROC		"gcov"
+
+static DECLARE_MUTEX_LOCKED(gcov_lock); =20
+#define DOWN()  down(&gcov_lock);
+#define UP()    up(&gcov_lock);
+#define PAD8(x)	((x + 7) & ~7)
+
+//#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,4))
+//static inline struct proc_dir_entry *PDE(const struct inode *inode)
+//{
+//	return ((struct proc_dir_entry *) inode->u.generic_ip);
+//}
+//#endif
+
+/* ###################################################################
+   # NOTICE ##########################################################
+   ###################################################################
+
+   GCOV_TYPE defines the count type used by the instrumentation code.
+   Kernels compiled with a gcc version prior to 3.1 should use LONG,
+   otherwise LONG LONG.  */
+
+#if __GNUC__ >=3D 3 && __GNUC_MINOR__ >=3D 1
+typedef long long gcov_type;
+#else
+typedef long gcov_type;
+#endif
+
+
+struct bb
+{
+  long zero_word;
+  const char *filename;
+  gcov_type *counts;
+  long ncounts;
+  struct bb *next;
+  const unsigned long *addresses;
+
+  /* Older GCC's did not emit these fields.  */
+  long nwords;
+  const char **functions;
+  const long *line_nums;
+  const char **filenames;
+  char *flags;
+};
+
+extern struct bb *bb_head;
+static struct file_operations proc_gcov_operations;
+extern char   *gcov_kernelpath;
+extern void   (*gcov_callback)(int cmd, struct bb *);
+extern void   do_global_ctors(char *, char *, struct module *, int);
+=20
+static int create_bb_links =3D 1;
+static int kernel_path_len;
+
+int debug =3D 0;
+#define PPRINTK(x) do { if (debug) { printk x ; } } while (0)
+
+struct gcov_ftree_node
+{
+	int   isdir;    /* directory or file */
+	char *fname;    /* only the name within the hierachy */
+	struct gcov_ftree_node *sibling;   /* sibling of tree  */
+	struct gcov_ftree_node *files;  /* children of tree */
+	struct gcov_ftree_node *parent; /* parent of current gcov_ftree_node */
+	struct proc_dir_entry  *proc[4];
+	struct bb	      *bb;
+	/* below only valid for leaf nodes =3D=3D files */
+	unsigned long  offset;	  /* offset in global file */
+	struct gcov_ftree_node *next;   /* next leave node       */
+};
+
+static struct proc_dir_entry  *proc_vmlinux =3D NULL;
+static struct gcov_ftree_node *leave_nodes =3D NULL;
+static struct gcov_ftree_node *dumpall_cached_node =3D NULL;
+static struct gcov_ftree_node tree_root  =3D=20
+	{ 1, GCOV_PROF_PROC, NULL, NULL, NULL,
+	  { NULL, NULL, NULL, NULL} , NULL, 0,NULL };
+static char *endings[3] =3D { ".bb", ".bbg", ".c" };
+
+
+/* Calculate the header size of an entry in the vmlinux-tracefile which
+   contains the collection of trace data of all instrumented kernel object=
s.
+
+   An entry header is defined as:
+     0:  length of filename of the respective .da file padded to 8 bytes
+     8:  filename padded to 8 bytes
+
+ */
+
+static inline unsigned long
+hdr_ofs (struct gcov_ftree_node *tptr)
+{
+	return 8 + PAD8(strlen (tptr->bb->filename) + 1);
+}
+
+
+/* Calculate the total size of an entry in the vmlinux-tracefile.
+   An entry consists of the header, an 8 byte word for the number
+   of counts in this entry and the actual array of 8 byte counts.  */
+
+static inline unsigned long
+dump_size(struct gcov_ftree_node *tptr)
+{
+	return (hdr_ofs(tptr) + (tptr->bb->ncounts+1)*8);
+}
+
+
+/* Store a portable representation of VALUE in DEST using BYTES*8-1 bits.
+   Return a non-zero value if VALUE requires more than BYTES*8-1 bits
+   to store (this is adapted code from gcc/gcov-io.h).  */
+
+static int
+store_gcov_type (gcov_type value, void *buf, int offset, int len)
+{
+	const size_t bytes =3D 8;
+	char dest[10];
+	int upper_bit =3D (value < 0 ? 128 : 0);
+	size_t i;
+=20
+	if (value < 0) {
+		gcov_type oldvalue =3D value;
+		value =3D -value;
+		if (oldvalue !=3D -value)
+		return 1;
+	}
+=20
+	for(i =3D 0 ;
+	    i < (sizeof (value) < bytes ? sizeof (value) : bytes) ;
+	    i++) {
+		dest[i] =3D value & (i =3D=3D (bytes - 1) ? 127 : 255);
+		value =3D value / 256;
+	}
+=20
+	if (value && value !=3D -1)
+		return 1;
+=20
+	for(; i < bytes ; i++)
+	  dest[i] =3D 0;
+	dest[bytes - 1] |=3D upper_bit;
+	copy_to_user(buf,&dest[offset],len);
+	return 0;
+}
+
+
+/* Create a directory entry in the proc file system and fill in
+   the respective fields in the provided tree node. Return a
+   non-zero value on error.  */
+
+int
+create_dir_proc (struct gcov_ftree_node *bt, char *fname)=20
+{
+	bt->proc[0] =3D proc_mkdir(fname, bt->parent->proc[0]);
+	bt->proc[1] =3D bt->proc[2] =3D bt->proc[3] =3D NULL;
+	return (bt->proc[0] =3D=3D NULL);
+}
+
+
+/* Replace file ending <end> in <fname> with <newend>. Return a new
+   string containing the new filename or NULL on error.  */
+
+static=20
+char* replace_ending (const char *fname,char *end, char *newend)
+{
+	char *newfname;
+	char *cptr =3D strstr(fname,end);
+	int len;
+	if (cptr =3D=3D NULL)=20
+		return NULL;
+	len =3D cptr - fname;
+	newfname =3D (char*)kmalloc(len+strlen(newend)+1,GFP_KERNEL);
+	if (newfname =3D=3D NULL)=20
+		return NULL;
+	memcpy(newfname,fname,len);
+	strcpy(newfname+len,newend);
+	return newfname;=09
+}=20
+=09
+
+/* Create a file entry in the proc file system and update the respective
+   fields on the tree node. Optionally try to create links to the
+   source, .bb and .bbg files. Return a non-zero value on error.  */
+
+int
+create_file_proc (struct gcov_ftree_node *bt, struct bb *bptr, char *fname=
,
+		  const char *fullname)=20
+{
+	bt->proc[0]  =3D create_proc_entry(fname, S_IWUSR | S_IRUGO,=20
+					 bt->parent->proc[0]);
+	if (!bt->proc[0]) {
+		PPRINTK(("error creating file proc <%s>\n", fname));
+		return 1;
+	}
+
+	bt->proc[0]->proc_fops =3D &proc_gcov_operations;
+	bt->proc[0]->size =3D 8 + (8 * bptr->ncounts);
+
+	if (create_bb_links) {
+		int i;
+		for (i=3D0;i<3;i++) {
+			char *newfname;
+			char *newfullname;
+			newfname    =3D replace_ending(fname,".da",endings[i]);
+			newfullname =3D replace_ending(fullname,".da",endings[i]);
+			if ((newfname) && (newfullname)) {
+				bt->proc[i+1]  =3D proc_symlink(newfname,bt->parent->proc[0],newfullna=
me);
+			}
+			if (newfname) kfree(newfname);
+			if (newfullname) kfree(newfullname);
+		}
+	} else {
+		bt->proc[1] =3D bt->proc[2] =3D bt->proc[3] =3D NULL;=20
+	}
+	return 0;
+}
+
+
+/* Recursively check and if necessary create the file specified by <name>
+   and all its path components, both in the proc file-system as
+   well as in the internal tree structure.  */
+
+void=20
+check_proc_fs(const char *fullname, struct gcov_ftree_node *parent,=20
+		   char *name, struct bb *bbptr)
+{
+	char dirname[128];
+	char *localname =3D name;
+	char *tname;
+	int  isdir;
+	struct gcov_ftree_node *tptr;
+
+	tname =3D strstr(name, "/");
+	if ((isdir =3D (tname !=3D NULL))) {
+		memcpy(dirname,name,tname-name);
+		dirname[tname-name] =3D '\0';
+		localname =3D dirname;
+	}
+
+	/* search the list of files in gcov_ftree_node and=20
+	 * see whether file already exists in this directory level */
+	for ( tptr =3D parent->files ; tptr ; tptr =3D tptr->sibling) {
+		if (!strcmp(tptr->fname,localname))
+			break;
+	}
+	if (!tptr) {
+		/* no entry yet */
+		tptr =3D (struct gcov_ftree_node*)
+			kmalloc(sizeof(struct gcov_ftree_node),GFP_KERNEL);
+		tptr->parent  =3D parent;
+
+		if (!isdir) {
+			if (create_file_proc(tptr, bbptr, localname,fullname)) {
+				kfree(tptr);
+				return;
+			}
+			tptr->bb	 =3D bbptr;
+			tptr->proc[0]->data =3D tptr;
+			tptr->next =3D leave_nodes;
+			leave_nodes =3D tptr;
+		} else {
+			int len =3D strlen(dirname)+1;
+			localname =3D (char*)kmalloc(len,GFP_KERNEL);
+			strncpy(localname,dirname,len);
+			if (create_dir_proc(tptr,localname)) {
+				kfree(tptr);
+				kfree(localname);
+				return;
+			}
+			tptr->bb	 =3D NULL;
+			tptr->proc[0]->data =3D NULL;
+			tptr->next       =3D NULL;
+		}
+		tptr->isdir   =3D isdir;
+		tptr->fname   =3D localname;
+		tptr->files   =3D NULL;
+		tptr->sibling =3D parent->files;
+		parent->files =3D tptr;
+	}
+	if (isdir)
+		check_proc_fs(fullname,tptr,tname+1,bbptr);
+}
+
+
+/* Read out tracefile data to user space. Return the number of bytes
+   read.  */
+
+static ssize_t=20
+read_gcov(struct file *file, char *buf,
+			 size_t count, loff_t *ppos)
+{
+	unsigned long p =3D *ppos;
+	ssize_t read;
+	gcov_type ncnt;
+	struct bb *bbptr;
+	gcov_type slen;
+	gcov_type *wptr;
+	struct gcov_ftree_node *treeptr;=20
+	struct proc_dir_entry * de;
+	int dumpall;
+	unsigned int hdrofs;
+	unsigned long poffs;
+
+	DOWN();
+
+	read   =3D 0;
+	hdrofs =3D 0;
+	poffs  =3D 0;
+	de =3D PDE(file->f_dentry->d_inode);
+
+	/* Check whether this is a request to /proc/gcov/vmlinux in
+	   which case we should dump the complete tracefile.  */
+	dumpall =3D (de =3D=3D proc_vmlinux);
+
+
+	/* Have treeptr point to the tree node to be dumped.  */
+
+	if (!dumpall)
+		treeptr =3D (struct gcov_ftree_node*) (de ? de->data : NULL);
+	else {
+		/* dumpall_cached_node will speed up things in case
+		   of a sequential read.  */
+		if (dumpall_cached_node && (p >=3D dumpall_cached_node->offset)) {
+			treeptr =3D dumpall_cached_node;
+		}
+		else
+			treeptr =3D leave_nodes;
+
+		/* Search the tree node that covers the requested
+		   tracefile offset.  */
+		while (treeptr) {
+			struct gcov_ftree_node *next =3D treeptr->next;
+			if ((next =3D=3D NULL) || (p < next->offset)) {
+				hdrofs =3D hdr_ofs(treeptr);
+				poffs  =3D treeptr->offset;
+				break;
+			}
+			treeptr =3D next;
+		}
+		dumpall_cached_node =3D treeptr;
+	}
+
+	bbptr =3D treeptr ? treeptr->bb : NULL;
+
+	if (bbptr =3D=3D NULL)
+		goto out;
+
+	ncnt =3D (gcov_type) bbptr->ncounts;
+	p -=3D poffs;
+
+	do {=20
+		if (p < hdrofs) {
+			/* User wants to read parts of the header.  */
+
+			slen =3D PAD8(strlen(treeptr->bb->filename)+1);
+
+			if (p >=3D 8) {
+				/* Read filename */
+				if (slen > (gcov_type) count) slen =3D count;
+				copy_to_user (buf, &treeptr->bb->filename[p-8],
+					      slen);
+				count-=3Dslen;buf+=3D slen;read+=3Dslen;p+=3Dslen;
+				continue;
+			}
+			wptr =3D &slen;
+		}=20
+		else if (p < (hdrofs + 8)) {
+			/* User wants to read the number of counts in this
+			   entry.  */
+
+			wptr =3D &ncnt;
+		}
+		else if (p < (hdrofs) + (unsigned long) (ncnt+1)*8) {
+			/* User wants to read actual counters */
+
+			wptr =3D &bbptr->counts[((p-hdrofs)/8)-1];
+		}
+		else
+			break;
+
+		/* do we have to write partial word */=09
+
+		if ((count < 8) || (p & 0x7)) {
+			/* partial write */
+			unsigned long offset =3D p & 0x7;
+			unsigned long length =3D (count+offset)<8?count:(8-offset);
+
+			store_gcov_type(*wptr,buf, offset, length);
+			buf+=3Dlength;p+=3Dlength;count-=3Dlength;read+=3Dlength;
+			break;
+		} else {
+			store_gcov_type(*wptr,buf, 0, 8);
+			buf+=3D8;p+=3D8;count-=3D8;read+=3D8;
+		}
+	} while (count > 0);
+	*ppos =3D p + poffs;
+out:
+	UP();
+	return read;
+}
+
+
+/* A write to any of our proc file-system entries is interpreted
+   as a request to reset the data from that node.  */
+
+static ssize_t=20
+write_gcov(struct file * file, const char * buf,
+		       size_t count, loff_t *ppos)
+{
+	struct bb *ptr;
+	struct proc_dir_entry * de;
+	int resetall, i;
+	struct gcov_ftree_node *tptr;=20
+
+	DOWN();
+
+	de =3D PDE(file->f_dentry->d_inode);
+
+	if (de =3D=3D NULL) {=20
+		count =3D 0;
+		goto out;
+	}
+
+	/* Check for a write to /proc/gcov/vmlinux */
+	resetall =3D (de =3D=3D proc_vmlinux);
+
+	if (resetall) {
+		/* Reset all nodes */
+		for (ptr =3D bb_head; ptr !=3D (struct bb *) 0; ptr =3D ptr->next)
+		{
+       			int i;
+			if (ptr->counts =3D=3D NULL) continue;
+			for (i =3D 0; i < ptr->ncounts; i++)=20
+				ptr->counts[i]=3D0;
+		}
+	} else {
+		/* Reset a single node */
+		tptr =3D (struct gcov_ftree_node*)(de->data);
+		if (tptr =3D=3D NULL)
+			goto out;
+		ptr =3D tptr->bb;=20
+		if (ptr->ncounts !=3D 0) {
+			for (i =3D 0; i < ptr->ncounts; i++)=20
+				ptr->counts[i]=3D0;
+		}
+	}
+out:
+	UP();
+	return count;
+}
+
+
+/* This struct identifies the functions to be used for proc file-system
+   interaction.  */
+
+static struct file_operations proc_gcov_operations =3D {
+	read:	read_gcov,
+	write:	write_gcov
+};
+
+
+/* Recursively remove a node and all its children from the internal
+   data tree and from the proc file-system.  */
+
+void=20
+cleanup_node(struct gcov_ftree_node *node, int delname, int del_in_parent)
+{
+	struct gcov_ftree_node *next,*tptr;
+	struct proc_dir_entry *par_proc;
+
+	PPRINTK(("parent n:%p p:%p f:%p s:%p <%s>\n", node,=20
+		node->parent, node->files, node->sibling, node->fname));
+	if ((tptr =3D node->parent)) {=20
+		if (del_in_parent) {
+			/* Remove node from parent's list of children */
+			struct gcov_ftree_node *cptr,*prev_cptr;
+			for ( prev_cptr =3D NULL, cptr =3D tptr->files; cptr && (cptr !=3D node=
);
+			      prev_cptr =3D cptr, cptr =3D cptr->sibling);=20
+			if (prev_cptr =3D=3D NULL)
+				tptr->files =3D cptr->sibling;
+			else
+				prev_cptr->sibling =3D cptr->sibling;
+		}
+		par_proc =3D (struct proc_dir_entry*)(tptr->proc[0]);
+	} else
+		par_proc =3D &proc_root;
+
+	if (node->isdir) {
+		/* In case of a directory, clean up all child nodes.  */
+		next =3D node->files;
+		node->files =3D NULL;
+		for (tptr =3D next ; tptr; ) {
+			next =3D tptr->sibling;
+			cleanup_node(tptr,1,0);
+			tptr =3D next;
+		}
+		remove_proc_entry(node->fname, par_proc);
+		if (delname) kfree(node->fname);
+	} else {
+		/* Remove file entry and optional links.  */
+		remove_proc_entry(node->fname, par_proc);
+		if (create_bb_links) {
+			int i;
+			for (i=3D0;i<3;i++) {
+				char *newfname;
+				if (node->proc[i+1] =3D=3D NULL) continue;
+				newfname    =3D replace_ending(node->fname,".da",endings[i]);
+				if (newfname) {
+					PPRINTK(("remove_proc_entry <%s>\n", node->fname));
+					remove_proc_entry(newfname, par_proc);
+					kfree(newfname);
+				}
+			}
+		}    =20
+	}
+	/* free the data */
+	if (node !=3D &tree_root)=20
+		kfree(node);
+}
+
+
+/* Create a tree node for the given bb struct and initiate the
+   creation of a corresponding proc file-system entry.  */
+
+static void
+create_node_tree(struct bb *bbptr)
+{
+	const char *tmp;
+	const char *filename =3D bbptr->filename;
+	char *modname;
+	int len;
+
+	PPRINTK(("kernelpath <%s> <%s>\n", gcov_kernelpath, filename));
+
+	/* Check whether this is a file located in the kernel source
+	   directory.  */
+	if (!strncmp (filename, gcov_kernelpath, kernel_path_len))
+	{
+		/* Remove kernel path and create relative proc-file-system
+		   entry.  */
+		tmp =3D filename + kernel_path_len+1;
+		if (*tmp =3D=3D '0') return;=20
+		check_proc_fs(filename, &tree_root, (char*)tmp, bbptr);
+	}=20
+	else {
+		/* Insert entry to module sub-directory.  */
+		len =3D strlen(filename);
+ 		modname =3D (char *)kmalloc (len + 7, GFP_KERNEL);
+		strcpy(modname, "module");
+		strcat (modname, filename);
+		check_proc_fs(filename, &tree_root, modname, bbptr);
+	}
+}
+
+
+/* This function will be used as gcov_callback, i.e. it is
+   called from constructor and destructor code of all instrumented
+   object files. It updates the local tree structure and the proc
+   file-system entries.  */
+
+static void=20
+gcov_cleanup(int cmd, struct bb *bbptr)
+{
+	unsigned long offset =3D 0;
+	struct gcov_ftree_node *tptr;
+	struct gcov_ftree_node *parent;
+	struct gcov_ftree_node *prev_cptr;
+
+	DOWN();=20
+	switch (cmd) {
+	case 0:
+		/* remove leave node */
+		prev_cptr =3D NULL;
+		for (tptr =3D leave_nodes; tptr ; prev_cptr =3D tptr, tptr =3D tptr->nex=
t) {
+			if (tptr->bb =3D=3D bbptr) break;
+		}
+		if (!tptr) {
+			PPRINTK(("Can't find module in /proc/gcov\n"));
+			UP();
+			return;
+		}
+		if (prev_cptr)
+			prev_cptr->next =3D tptr->next;
+		else
+			leave_nodes =3D tptr->next;
+		dumpall_cached_node =3D NULL;
+
+
+		/* Find highest level node without further siblings */
+=09
+		parent =3D tptr->parent;
+		do {
+			if (parent->files->sibling !=3D NULL) break;
+			tptr =3D parent;
+			parent =3D parent->parent;
+		} while (parent);
+		cleanup_node(tptr,0,1);
+
+		/* Update the offsets at which a certain node can
+		   be found in the tracefile.  */
+		for (tptr =3D leave_nodes; tptr; tptr =3D tptr->next) {
+			tptr->offset =3D offset;=20
+			offset +=3D dump_size(tptr);
+		}
+		break;
+
+	case 1:
+		/* insert node */
+		create_node_tree(bbptr);
+
+		/* Update the offsets at which a certain node can
+		   be found in the tracefile.  */
+		for (tptr =3D leave_nodes; tptr; tptr =3D tptr->next) {
+			tptr->offset =3D offset;=20
+			offset +=3D dump_size(tptr);
+		}
+
+		break;
+	}
+	UP();
+}
+
+
+/* Initialize the data structure by calling the constructor code
+   of all instrumented object files and creating the proc
+   file-system entries.  */
+
+int=20
+init_module(void)
+{
+	struct bb *bbptr;
+	unsigned long offset =3D 0;
+	struct gcov_ftree_node *tptr;=20
+
+	PPRINTK(("init module <%s>\n\n", GCOV_PROF_PROC));
+
+	do_global_ctors(NULL, NULL, NULL, 0);
+=09
+	tree_root.proc[0] =3D proc_mkdir(GCOV_PROF_PROC, 0);
+	kernel_path_len =3D strlen(gcov_kernelpath);
+
+	for (bbptr =3D bb_head; bbptr ; bbptr =3D bbptr->next) {
+		create_node_tree(bbptr);
+	}
+
+	/* Fill in the offset at which a certain node can
+	   be found in the tracefile.  */
+	for (tptr =3D leave_nodes; tptr; tptr =3D tptr->next) {
+		tptr->offset =3D offset;=20
+		offset +=3D dump_size(tptr);
+	}
+
+	proc_vmlinux =3D create_proc_entry("vmlinux",S_IWUSR | S_IRUGO,=20
+					 tree_root.proc[0]);
+	if (proc_vmlinux)
+		proc_vmlinux->proc_fops =3D &proc_gcov_operations;
+
+	gcov_callback =3D gcov_cleanup;
+	UP();
+	return 0;
+}
+
+
+void=20
+cleanup_module(void)
+{
+	PPRINTK(("remove module <%s>\n\n", GCOV_PROF_PROC));
+	gcov_callback =3D NULL;
+	DOWN();
+	cleanup_node(&tree_root,0,0);=20
+}
+
+//module_init(gcov_init_module);
+//module_exit(gcov_cleanup_module);
diff -Naurp linux-2.6.0-test3/include/linux/module.h linux-2.6.0-test3-gcov=
/include/linux/module.h
--- linux-2.6.0-test3/include/linux/module.h	Fri Aug  8 23:39:31 2003
+++ linux-2.6.0-test3-gcov/include/linux/module.h	Mon Aug 18 16:48:25 2003
@@ -257,6 +257,11 @@ struct module
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
+
+#ifdef CONFIG_GCOV_PROFILE
+	const char *ctors_start;        /* Pointer to start of .ctors-section */
+	const char *ctors_end;          /* Pointer to end of .ctors-section */
+#endif
 };
=20
 /* FIXME: It'd be nice to isolate modules during init, too, so they
diff -Naurp linux-2.6.0-test3/init/main.c linux-2.6.0-test3-gcov/init/main.=
c
--- linux-2.6.0-test3/init/main.c	Fri Aug  8 23:33:15 2003
+++ linux-2.6.0-test3-gcov/init/main.c	Mon Aug 18 16:48:25 2003
@@ -115,6 +115,10 @@ char *execute_command;
 /* Setup configured maximum number of CPUs to activate */
 static unsigned int max_cpus =3D NR_CPUS;
=20
+#if defined(CONFIG_GCOV_PROFILE) && (defined(CONFIG_PPC32) || defined(CONF=
IG_PPC64))
+void __bb_fork_func (void) { }
+#endif
+
 /*
  * Setup routine for controlling SMP activation
  *
diff -Naurp linux-2.6.0-test3/kernel/Makefile linux-2.6.0-test3-gcov/kernel=
/Makefile
--- linux-2.6.0-test3/kernel/Makefile	Fri Aug  8 23:33:21 2003
+++ linux-2.6.0-test3-gcov/kernel/Makefile	Mon Aug 18 16:48:25 2003
@@ -8,6 +8,12 @@ obj-y     =3D sched.o fork.o exec_domain.o
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o
=20
+ifdef CONFIG_GCOV_PROFILE
+obj-y +=3D gcov.o
+export-objs +=3D gcov.o
+CFLAGS_gcov.o :=3D -DGCOV_PATH=3D'"$(TOPDIR)"'
+endif
+
 obj-$(CONFIG_FUTEX) +=3D futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) +=3D dma.o
 obj-$(CONFIG_SMP) +=3D cpu.o
diff -Naurp linux-2.6.0-test3/kernel/gcov.c linux-2.6.0-test3-gcov/kernel/g=
cov.c
--- linux-2.6.0-test3/kernel/gcov.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test3-gcov/kernel/gcov.c	Mon Aug 18 16:48:25 2003
@@ -0,0 +1,158 @@
+/*
+ * Coverage support under Linux
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, U=
SA.
+ *
+ * Copyright (c) International Business Machines Corp., 2002
+ *
+ * Author: Hubertus Franke <frankeh@us.ibm.com>
+ *         Rajan Ravindran <rajancr@us.ibm.com>
+ *
+ * Modified by <Peter.Oberparleiter@de.ibm.com>
+ */
+
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/completion.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+
+struct bb
+{
+  long zero_word;
+  const char *filename;
+  long *counts;
+  long ncounts;
+  struct bb *next;
+  const unsigned long *addresses;
+
+  /* Older GCC's did not emit these fields.  */
+  long nwords;
+  const char **functions;
+  const long *line_nums;
+  const char **filenames;
+  char *flags;
+};
+
+struct bb *bb_head;
+struct module *bb_context_address;
+void (*gcov_callback)(int cmd, struct bb *bbptr) =3D NULL;
+
+#ifdef GCOV_PATH
+char *gcov_kernelpath =3D GCOV_PATH;
+#else
+char *gcov_kernelpath =3D __FILE__;
+#endif
+
+
+void
+__bb_init_func (struct bb *blocks)
+{
+  if (blocks->zero_word)
+    return;
+
+  /* Set up linked list.  */
+  blocks->zero_word =3D 1;
+
+  /* Store the address of the module of which this object-file is a part
+     of (set in do_global_ctors). */
+  blocks->addresses =3D (unsigned long *) bb_context_address;
+
+  blocks->next =3D bb_head;
+  bb_head =3D blocks;
+
+  if (gcov_callback && bb_context_address)=20
+    (*gcov_callback)(1,blocks);
+}
+
+/* Call constructors for all kernel objects and dynamic modules. This func=
tion
+ * is called both during module initialization and when the gcov kernel
+ * module is insmod'ed. The list of constructors is compiled into the
+ * kernel at &__CTOR_LIST__ to &__DTOR_LIST__ (labels are defined in
+ * head.S). In the case of a dynamic module the list is located at
+ * ctors_start to ctors_end.
+ *
+ * The constructors in turn call __bb_init_func, reporting the respective
+ * struct bb for each object file.
+ */
+
+void
+do_global_ctors (char *ctors_start, char *ctors_end, struct module *addr, =
int mod_flag)
+{
+  extern char __CTOR_LIST__;
+  extern char __DTOR_LIST__;
+  typedef void (*func_ptr)(void) ;
+  func_ptr *constructor_ptr=3DNULL;
+=20
+  if (!mod_flag) {
+    /* Set start and end ptr from global kernel constructor list. */
+    ctors_start =3D &__CTOR_LIST__;
+    ctors_end =3D &__DTOR_LIST__;
+    bb_context_address =3D NULL;
+  } else {
+    /* Set context to current module address. */
+    bb_context_address =3D addr;
+  }
+
+  if (!ctors_start)
+    return;
+
+  /* Call all constructor functions until either the end of the
+     list is reached or until a NULL is encountered. */
+  for (constructor_ptr =3D (func_ptr *) ctors_start;
+       (constructor_ptr !=3D (func_ptr *) ctors_end) &&
+         (*constructor_ptr !=3D NULL);
+       constructor_ptr++) {
+    	(*constructor_ptr) ();
+  }
+}       =20
+
+
+/* When a module is unloaded, this function is called to remove
+ * the respective bb entries from our list. context specifies
+ * the address of the module that is unloaded. */
+
+void
+remove_bb_link (struct module *context)
+{
+  struct bb *bbptr;
+  struct bb *prev =3D NULL;
+
+  /* search for all the module's bbptrs */
+  for (bbptr =3D bb_head; bbptr ; bbptr =3D bbptr->next) {
+    if (bbptr->addresses =3D=3D (unsigned long *) context) {
+      if (gcov_callback)
+        (*gcov_callback)(0,bbptr);
+      if (prev =3D=3D NULL)=20
+        bb_head =3D bbptr->next;
+      else
+        prev->next =3D bbptr->next;
+    }
+    else
+      prev =3D bbptr;
+  }
+}
+
+EXPORT_SYMBOL(bb_head);
+EXPORT_SYMBOL(__bb_init_func);
+EXPORT_SYMBOL(do_global_ctors);
+EXPORT_SYMBOL(gcov_kernelpath);
+EXPORT_SYMBOL(gcov_callback);
diff -Naurp linux-2.6.0-test3/kernel/module.c linux-2.6.0-test3-gcov/kernel=
/module.c
--- linux-2.6.0-test3/kernel/module.c	Fri Aug  8 23:38:55 2003
+++ linux-2.6.0-test3-gcov/kernel/module.c	Mon Aug 18 16:48:25 2003
@@ -83,6 +83,11 @@ int unregister_module_notifier(struct no
 }
 EXPORT_SYMBOL(unregister_module_notifier);
=20
+#ifdef CONFIG_GCOV_PROFILE
+extern void remove_bb_link (struct module *);
+extern void do_global_ctors (char *, char *, struct module *, int);
+#endif
+
 /* We require a truly strong try_module_get() */
 static inline int strong_try_module_get(struct module *mod)
 {
@@ -1082,6 +1087,11 @@ static void free_module(struct module *m
 	/* Arch-specific cleanup. */
 	module_arch_cleanup(mod);
=20
+#ifdef CONFIG_GCOV_PROFILE
+	if (mod->ctors_start && mod->ctors_end)
+		remove_bb_link(mod);
+#endif
+
 	/* Module unload stuff */
 	module_unload_free(mod);
=20
@@ -1573,6 +1583,13 @@ static struct module *load_module(void _
 	/* Module has been moved. */
 	mod =3D (void *)sechdrs[modindex].sh_addr;
=20
+#ifdef CONFIG_GCOV_PROFILE
+	modindex =3D find_sec(hdr, sechdrs, secstrings, ".ctors");
+	mod->ctors_start =3D (char *)sechdrs[modindex].sh_addr;
+	mod->ctors_end   =3D (char *)(mod->ctors_start +
+				sechdrs[modindex].sh_size);
+#endif
+
 	/* Now we've moved module, initialize linked lists, etc. */
 	module_unload_init(mod);
=20
@@ -1722,6 +1739,12 @@ sys_init_module(void __user *umod,
=20
 	/* Start the module */
 	ret =3D mod->init();
+
+#ifdef CONFIG_GCOV_PROFILE
+	if (mod->ctors_start && mod->ctors_end) {
+		do_global_ctors(mod->ctors_start, mod->ctors_end, mod, 1);
+	}
+#endif
 	if (ret < 0) {
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
diff -Naurp linux-2.6.0-test3/scripts/Makefile.build linux-2.6.0-test3-gcov=
/scripts/Makefile.build
--- linux-2.6.0-test3/scripts/Makefile.build	Fri Aug  8 23:40:08 2003
+++ linux-2.6.0-test3-gcov/scripts/Makefile.build	Mon Aug 18 16:48:25 2003
@@ -119,7 +119,16 @@ cmd_cc_i_c       =3D $(CPP) $(c_flags)   -
 quiet_cmd_cc_o_c =3D CC $(quiet_modtag)  $@
=20
 ifndef CONFIG_MODVERSIONS
-cmd_cc_o_c =3D $(CC) $(c_flags) -c -o $@ $<
+new1_c_flags =3D $(c_flags:-I%=3D-I$(TOPDIR)/%)
+new2_c_flags =3D $(new1_c_flags:-Wp%=3D)
+PWD =3D $(TOPDIR)
+
+quiet_cmd_cc_o_c =3D CC $(quiet_modtag)  $@
+cmd_cc_o_c =3D $(CC) $(c_flags) -E -o $@ $< \
+		&& cd $(dir $<) \
+		&& $(CC) $(new2_c_flags) -c -o $(notdir $@) $(notdir $<) \
+		&& cd $(TOPDIR)
+#cmd_cc_o_c =3D $(CC) $(c_flags) -c -o $@ $<
=20
 else
 # When module versioning is enabled the following steps are executed:
@@ -134,12 +143,21 @@ else
 #   replace the unresolved symbols __crc_exported_symbol with
 #   the actual value of the checksum generated by genksyms
=20
-cmd_cc_o_c =3D $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
+new1_c_flags =3D $(c_flags:-I%=3D-I$(TOPDIR)/%)
+new2_c_flags =3D $(new1_c_flags:-Wp%=3D)
+PWD =3D $(TOPDIR)
+
+quiet_cmd_cc_o_c =3D CC $(quiet_modtag)  $@
+cmd_cc_o_c =3D $(CC) $(c_flags) -E -o $@ $< \
+		&& cd $(dir $<) \
+		&& $(CC) $(new2_c_flags) -c -o .tmp_$(@F) $(notdir $<) \
+		&& cd $(TOPDIR)
+#cmd_cc_o_c =3D $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
 cmd_modversions =3D							\
 	if ! $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then	\
 		mv $(@D)/.tmp_$(@F) $@;					\
 	else								\
-		$(CPP) -D__GENKSYMS__ $(c_flags) $<			\
+		$(CPP) -D__GENKSYMS__ $(new2_c_flags) $<		\
 		| $(GENKSYMS)						\
 		> $(@D)/.tmp_$(@F:.o=3D.ver);				\
 									\

--=-hc1kGdlVjSaDjgepFA3S--

