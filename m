Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUDOBYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 21:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUDOBYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 21:24:11 -0400
Received: from mail.gmx.de ([213.165.64.20]:51097 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261712AbUDOBXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 21:23:20 -0400
X-Authenticated: #21910825
Message-ID: <407DD631.5020308@gmx.net>
Date: Thu, 15 Apr 2004 02:24:17 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: medley@lists.infowares.com, Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: [RFC] [DRAFT] [udev PATCH] First attempt at vendor RAID support in
 2.6
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040004080608090009010001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040004080608090009010001
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

some time ago, I started to work on a 2.6 kernel compatible successor for
ATARAID.

Since this project is becoming bigger and bigger and I would like some
input, the current version of my raiddetect program is attached for criticism.

The fact that I did not extend Wilfried Weissmann's EVMS plugin is not
meant to discredit his work, however I found it easier to implement
something outside EVMS. I made the structure of my program as generic as
possible so integration into EVMS should be really easy if you want that.


What works:
- SilicomImage/Promise/Highpoint RAIDs are recognized and a list of disks
belonging to an ATARAID is output if you call "raiddetect -s"

What doesn't work:
- Distinguishing between disks that are part of an ATARAID array and those
 that are not if both have an ATARIAD superblock. (Well, it should work
for Highpoint)
- Setting up the ATARAID devices via device-mapper

What I need:
- People looking at the *_sb_helper functions to tell me if there is more
magic I can check for
- Criticism of coding style/ missing abstraction
- People checking the numerous FIXMEs
- More data about Medley/Highpoint vendor superblocks (can I check for
bogus values?)
- Help with sorting out who owns which copyrights

A few words about my implementation:
The hasraidmagic bitfield in struct harddisk is probably a misnomer. If a
bit is set it means that we found a superblock of the corresponding type
and the disk can not be accessed as a plain disk (i.e. we need to setup
something).
raiddetect is a patch against udev-023 and should compile cleanly against
klibc and glibc.
Executing "raiddetect" will show nearly all info gathered about the block
devices present in the system, whereas "raiddetect -s" should give you
only a list of devices currently suspected to be part of an ATARAID array.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------040004080608090009010001
Content-Type: text/plain;
 name="raiddetect_v9.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="raiddetect_v9.diff"

diff -urN udev-023-orig/bios_hpt.h udev-023/bios_hpt.h
--- udev-023-orig/bios_hpt.h	1970-01-01 01:00:00.000000000 +0100
+++ udev-023/bios_hpt.h	2004-04-15 02:16:45.401151544 +0200
@@ -0,0 +1,132 @@
+#ifndef __BIOS_HPT_H__
+#define __BIOS_HPT_H__ 1
+
+/*
+ *   Copyright (c) 2003,2004 Wilfried Weissmann
+ *   Copyright (c) 2000,2001 S=F8ren Schmidt (see also notice below)
+ *
+ *   This program is free software;  you can redistribute it and/or modi=
fy
+ *   it under the terms of the GNU General Public License as published b=
y
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
+ */
+
+/*-
+ * Copyright (c) 2000,2001 S=F8ren Schmidt <sos@FreeBSD.org>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer,
+ *    without modification, immediately at the beginning of the file.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ * 3. The name of the author may not be used to endorse or promote produ=
cts
+ *    derived from this software without specific prior written permissi=
on.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE AUTHOR `AS IS'' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRAN=
TIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIME=
D.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, =
BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY=

+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+                           =20
+struct highpoint_raid_conf
+{
+       int8_t  filler1[32];
+       u_int32_t       magic;
+#define HPT_MAGIC_OK   0x5a7816f0
+#define HPT_MAGIC_BAD  0x5a7816fd =20
+
+       u_int32_t       magic_0;
+       u_int32_t       magic_1;
+       u_int32_t       order; =20
+#define HPT_O_MIRROR   0x01 =20
+#define HPT_O_STRIPE   0x02
+#define HPT_O_OK       0x04
+
+       u_int8_t        raid_disks;
+       u_int8_t        raid0_shift;=20
+       u_int8_t        type;
+#define HPT_T_RAID_0   0x00=20
+#define HPT_T_RAID_1   0x01
+#define HPT_T_RAID_01_RAID_0   0x02
+#define HPT_T_SPAN             0x03
+#define HPT_T_RAID_3           0x04  =20
+#define HPT_T_RAID_5           0x05
+#define HPT_T_SINGLEDISK       0x06
+#define HPT_T_RAID_01_RAID_1   0x07
+
+       u_int8_t        disk_number;
+       u_int32_t       total_secs;=20
+       u_int32_t       disk_mode; =20
+       u_int32_t       boot_mode;
+       u_int8_t        boot_disk;=20
+       u_int8_t        boot_protect;
+       u_int8_t        error_log_entries;
+       u_int8_t        error_log_index; =20
+       struct
+       {
+               u_int32_t       timestamp;
+               u_int8_t        reason;  =20
+#define HPT_R_REMOVED          0xfe     =20
+#define HPT_R_BROKEN           0xff     =20
+
+               u_int8_t        disk;
+               u_int8_t        status;
+               u_int8_t        sectors;
+               u_int32_t       lba;
+       } errorlog[32];
+       u_int8_t        filler[60];
+};
+
+#ifndef O_DIRECT
+#define O_DIRECT	0
+#endif
+
+#define BLKGETSIZE64	_IOR(0x12,114,size_t)
+#define BLKSSZGET	_IO(0x12,104)
+#define BLKBSZGET	_IOR(0x12,112,size_t)
+#define BLKBSZSET	_IOW(0x12,113,size_t)
+#define HDIO_GETGEO	0x0301
+#define HDIO_GETGEO_BIG	0x0330
+
+#define HPT_SUPERBLOCKOFFSET (4096+512)
+
+/* HPT IDs from http://pciids.sf.net */
+#define PCI_VENDOR_ID_TTI		0x1103
+#define PCI_DEVICE_ID_TTI_HPT343	0x0003
+#define PCI_DEVICE_ID_TTI_HPT366	0x0004
+#define PCI_DEVICE_ID_TTI_HPT372	0x0005
+#define PCI_DEVICE_ID_TTI_HPT302	0x0006
+#define PCI_DEVICE_ID_TTI_HPT371	0x0007
+#define PCI_DEVICE_ID_TTI_HPT374	0x0008
+
+static struct biospci_s hptpci[] =3D {
+	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT343 },
+	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366 },
+	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372 },
+	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT302 },
+	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT371 },
+	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT374 },
+};
+
+#endif
diff -urN udev-023-orig/bios_pdc.h udev-023/bios_pdc.h
--- udev-023-orig/bios_pdc.h	1970-01-01 01:00:00.000000000 +0100
+++ udev-023/bios_pdc.h	2004-04-15 02:18:26.271816872 +0200
@@ -0,0 +1,96 @@
+#ifndef __BIOS_PDC_H__
+#define __BIOS_PDC_H__ 1
+
+/*
+ *   probably Copyright (c) Red Hat Inc
+ *   probably Copyright (c) S=F8ren Schmidt
+ *   Copyright (c) 2004 Carl-Daniel Hailfinger
+ */
+
+#define PCI_VENDOR_ID_PROMISE		0x105a
+#define PCI_DEVICE_ID_PROMISE_20246	0x4d33
+#define PCI_DEVICE_ID_PROMISE_20265	0x0d30
+#define PCI_DEVICE_ID_PROMISE_20267	0x4d30
+#define PCI_DEVICE_ID_PROMISE_20262	0x4d38
+#define PCI_DEVICE_ID_PROMISE_20263	0x0d38
+#define PCI_DEVICE_ID_PROMISE_20268	0x4d68
+#define PCI_DEVICE_ID_PROMISE_20268R	0x6268
+#define PCI_DEVICE_ID_PROMISE_20269	0x4d69
+#define PCI_DEVICE_ID_PROMISE_20270	0x6268
+#define PCI_DEVICE_ID_PROMISE_20271	0x6269
+#define PCI_DEVICE_ID_PROMISE_20275	0x1275
+#define PCI_DEVICE_ID_PROMISE_20276	0x5275
+#define PCI_DEVICE_ID_PROMISE_20277	0x7275
+
+static struct biospci_s pdcpci[] =3D {
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20270 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20271 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20277 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20263 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20265 },
+	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20267 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3371 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3373 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3375 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3376 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3318 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x6622 },
+	{ PCI_VENDOR_ID_PROMISE, 0x8000 },
+	{ PCI_VENDOR_ID_PROMISE, 0x8002 },
+};
+
+struct promise_raid_conf {
+    char                promise_id[24];
+
+    u_int32_t             dummy_0;
+    u_int32_t             magic_0;
+    u_int32_t             dummy_1;
+    u_int32_t             magic_1;
+    u_int16_t             dummy_2;
+    u_int8_t              filler1[470];
+    struct {
+        u_int32_t flags;                          /* 0x200 */
+        u_int8_t          dummy_0;
+        u_int8_t          disk_number;
+        u_int8_t          channel;
+        u_int8_t          device;
+        u_int32_t         magic_0;
+        u_int32_t         dummy_1;
+        u_int32_t         dummy_2;                /* 0x210 */
+        u_int32_t         disk_secs;
+        u_int32_t         dummy_3;
+        u_int16_t         dummy_4;
+        u_int8_t          status;
+        u_int8_t          type;
+        u_int8_t        total_disks;            /* 0x220 */
+        u_int8_t        raid0_shift;
+        u_int8_t        raid0_disks;
+        u_int8_t        array_number;
+        u_int32_t       total_secs;
+        u_int16_t       cylinders;
+        u_int8_t        heads;
+        u_int8_t        sectors;
+        u_int32_t         magic_1;
+        u_int32_t         dummy_5;                /* 0x230 */
+        struct {
+            u_int16_t     dummy_0;
+            u_int8_t      channel;
+            u_int8_t      device;
+            u_int32_t     magic_0;
+            u_int32_t     disk_number;
+        } disk[8];
+    } raid;
+    u_int32_t             filler2[346];
+    u_int32_t            checksum;
+};
+
+#define PR_MAGIC        "Promise Technology, Inc."
+
+#endif
diff -urN udev-023-orig/bios_sil.h udev-023/bios_sil.h
--- udev-023-orig/bios_sil.h	1970-01-01 01:00:00.000000000 +0100
+++ udev-023/bios_sil.h	2004-04-02 20:54:13.000000000 +0200
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2003 Thomas Horsten <thomas@horsten.com>
+ */
+
+#ifndef __BIOS_SIL_H__
+#define __BIOS_SIL_H__ 1
+
+#define PCI_VENDOR_ID_CMD		0x1095
+#define PCI_DEVICE_ID_SII_3112		0x3112
+
+static struct biospci_s silpci[] =3D {
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112 },
+	{ PCI_VENDOR_ID_CMD, 0x3114 },
+	{ PCI_VENDOR_ID_CMD, 0x3512 },
+};
+
+/*
+ * Medley RAID metadata structure.
+ *
+ * The metadata structure is based on the ATA drive ID from the drive it=
self,
+ * with the RAID information in the vendor specific regions.
+ *
+ * We do not use all the fields, since we only support Striped Sets.
+ */
+struct medley_raid_conf {
+	u_int8_t  driveid0[46];
+	u_int8_t  ascii_version[8];
+	u_int8_t  driveid1[52];
+	u_int32_t total_sectors_low;
+	u_int32_t total_sectors_high;
+	u_int16_t reserved0;
+	u_int8_t  driveid2[142];
+	u_int16_t product_id;
+	u_int16_t vendor_id;
+	u_int16_t minor_ver;
+	u_int16_t major_ver;
+	u_int16_t creation_timestamp[3];
+	u_int16_t chunk_size;
+	u_int16_t reserved1;
+	u_int8_t  drive_number;
+	u_int8_t  raid_type;
+	u_int8_t  drives_per_striped_set;
+	u_int8_t  striped_set_number;
+	u_int8_t  drives_per_mirrored_set;
+	u_int8_t  mirrored_set_number;
+	u_int32_t rebuild_ptr_low;
+	u_int32_t rebuild_ptr_high;
+	u_int32_t incarnation_no;
+	u_int8_t  member_status;
+	u_int8_t  mirrored_set_state;
+	u_int8_t  reported_device_location;
+	u_int8_t  member_location;
+	u_int8_t  auto_rebuild;
+	u_int8_t  reserved3[17];
+	u_int16_t checksum;
+};
+
+#endif
diff -urN udev-023-orig/Makefile udev-023/Makefile
--- udev-023-orig/Makefile	2004-03-25 01:09:50.000000000 +0100
+++ udev-023/Makefile	2004-03-31 16:59:50.000000000 +0200
@@ -30,6 +30,7 @@
 DAEMON =3D	udevd
 SENDER =3D	udevsend
 INFO =3D		udevinfo
+RAID =3D		raiddetect
 TESTER =3D	udevtest
 STARTER =3D	udevstart
 RULER =3D		udevruler
@@ -172,7 +173,7 @@
=20
 CFLAGS +=3D -I$(PWD)/libsysfs
=20
-all: $(ROOT) $(SENDER) $(DAEMON) $(INFO) $(TESTER) $(STARTER)
+all: $(ROOT) $(SENDER) $(DAEMON) $(INFO) $(RAID) $(TESTER) $(STARTER)
 	@extras=3D"$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
 		$(MAKE) prefix=3D$(prefix) \
@@ -250,6 +251,7 @@
 $(ROOT).o: $(GEN_HEADERS)
 $(TESTER).o: $(GEN_HEADERS)
 $(INFO).o: $(GEN_HEADERS)
+$(RAID).o: $(GEN_HEADERS)
 $(DAEMON).o: $(GEN_HEADERS)
 $(SENDER).o: $(GEN_HEADERS)
 $(STARTER).o: $(GEN_HEADERS)
@@ -266,6 +268,10 @@
 	$(LD) $(LDFLAGS) -o $@ $(CRT0) udevinfo.o udev_lib.o udev_config.o udev=
db.o $(SYSFS) $(TDB) $(LIB_OBJS) $(ARCH_LIB_OBJS)
 	$(STRIPCMD) $@
=20
+$(RAID): $(RAID).o $(OBJS) $(HEADERS) $(LIBC)
+	$(LD) $(LDFLAGS) -o $@ $(CRT0) raiddetect.o $(SYSFS) $(LIB_OBJS) $(ARCH=
_LIB_OBJS)
+	$(STRIPCMD) $@
+
 $(DAEMON): $(DAEMON).o udevd.h $(LIBC)
 	$(LD) $(LDFLAGS) -o $@ $(CRT0) udevd.o $(LIB_OBJS) $(ARCH_LIB_OBJS)
 	$(STRIPCMD) $@
@@ -285,7 +291,7 @@
 clean:
 	-find . \( -not -type d \) -and \( -name '*~' -o -name '*.[oas]' \) -ty=
pe f -print \
 	 | xargs rm -f=20
-	-rm -f core $(ROOT) $(GEN_HEADERS) $(GEN_CONFIGS) $(INFO) $(DAEMON) $(S=
ENDER) $(TESTER) $(STARTER) $(RULER)
+	-rm -f core $(ROOT) $(GEN_HEADERS) $(GEN_CONFIGS) $(INFO) $(RAID) $(DAE=
MON) $(SENDER) $(TESTER) $(STARTER) $(RULER)
 	$(MAKE) -C klibc clean
 	@extras=3D"$(EXTRAS)" ; for target in $$extras ; do \
 		echo $$target ; \
@@ -361,6 +367,7 @@
 	$(INSTALL_PROGRAM) -D $(DAEMON) $(DESTDIR)$(sbindir)/$(DAEMON)
 	$(INSTALL_PROGRAM) -D $(SENDER) $(DESTDIR)$(sbindir)/$(SENDER)
 	$(INSTALL_PROGRAM) -D $(INFO) $(DESTDIR)$(usrbindir)/$(INFO)
+	$(INSTALL_PROGRAM) -D $(RAID) $(DESTDIR)$(sbindir)/$(RAID)
 	$(INSTALL_PROGRAM) -D $(TESTER) $(DESTDIR)$(usrbindir)/$(TESTER)
 	$(INSTALL_PROGRAM) -D $(STARTER) $(DESTDIR)$(sbindir)/$(STARTER)
 	$(INSTALL_DATA) -D udev.8 $(DESTDIR)$(mandir)/man8/udev.8
@@ -396,6 +403,7 @@
 	- rm $(sbindir)/$(DAEMON)
 	- rm $(sbindir)/$(SENDER)
 	- rm $(usrbindir)/$(INFO)
+	- rm $(usrbindir)/$(RAID)
 	- rmdir $(hotplugdir)
 	- rmdir $(configdir)
 	- rmdir $(dev_ddir)default
diff -urN udev-023-orig/raiddetect.c udev-023/raiddetect.c
--- udev-023-orig/raiddetect.c	1970-01-01 01:00:00.000000000 +0100
+++ udev-023/raiddetect.c	2004-04-15 02:11:38.764767360 +0200
@@ -0,0 +1,734 @@
+/*
+ * raiddetect - A program to spit out the details of all FakeRAIDs in th=
e system
+ *
+ * Copyright (C) 2004 Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004=
@gmx.net>
+ *
+ *
+ *	This program is free software; you can redistribute it and/or modify =
it
+ *	under the terms of the GNU General Public License as published by the=

+ *	Free Software Foundation version 2 of the License.
+ *=20
+ *	This program is distributed in the hope that it will be useful, but
+ *	WITHOUT ANY WARRANTY; without even the implied warranty of
+ *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *	General Public License for more details.
+ *=20
+ *	You should have received a copy of the GNU General Public License alo=
ng
+ *	with this program; if not, write to the Free Software Foundation, Inc=
=2E,
+ *	675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/param.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+
+#include "libsysfs/sysfs/libsysfs.h"
+#include "libsysfs/dlist.h"
+#include "logging.h"
+#include "raiddetect.h"
+#include "bios_hpt.h"
+#include "bios_pdc.h"
+#include "bios_sil.h"
+
+
+#ifdef LOG
+unsigned char logname[LOGNAME_SIZE];
+void log_message (int level, const char *format, ...)
+{
+	va_list	args;
+
+	va_start(args, format);
+	vsyslog(level, format, args);
+	va_end(args);
+}
+#endif
+
+#ifndef __KLIBC__
+#define my_llseek lseek64
+#else
+#define my_llseek llseek
+#endif
+
+
+static int medley_sb_helper(struct harddisk *thisdisk, int disk_fd, loff=
_t sb_offset)
+{
+	unsigned char buffer[512];
+	struct medley_raid_conf *sil_conf;
+	int i;
+	u_int16_t sil_checksum =3D 0;
+	u_int16_t * sil_checksum_ptr =3D 0;
+
+	if (my_llseek(disk_fd, sb_offset, SEEK_SET) !=3D sb_offset) {
+		fprintf(stderr, "could not seek to SIL superblock for %s\n", thisdisk-=
>devname);
+		return -1;
+	}
+	if (read(disk_fd, buffer, 512) !=3D 512) {
+		fprintf(stderr, "could not read SIL superblock for %s\n", thisdisk->de=
vname);
+		return -1;
+	}
+
+	sil_conf =3D (struct medley_raid_conf *)buffer;
+
+	sil_checksum_ptr =3D (u_int16_t *)buffer;
+
+	if (thisdisk->vendorid !=3D sil_conf->vendor_id || thisdisk->deviceid !=
=3D sil_conf->product_id)
+		return 0;
+
+	for (i =3D 0; i < 160; i++)
+		sil_checksum +=3D *sil_checksum_ptr++;
+
+	if (((sil_checksum =3D=3D 0xffff) && (sil_conf->major_ver =3D=3D 1)) ||=
 (sil_checksum =3D=3D 0)) {
+		/* FIXME: There has to be more magic than a checksum and eight bytes o=
f vendor/product */
+		//printf("SIL superblock found");
+		thisdisk->hasraidmagic |=3D 1 << PCI_SILRAID;
+		return 1;
+	} else {
+		/* FIXME: Does this message make any sense or should we just abort? */=

+		fprintf(stderr, "SIL superblock with bad checksum found for %s\n", thi=
sdisk->devname);
+		return 2;
+	}
+	return 0;
+}
+
+static int medley_get_sb(struct harddisk *thisdisk, int disk_fd)
+{
+	int pos;
+	loff_t sb_block =3D 0;
+
+	sb_block =3D (thisdisk->devsize - 1);
+	for (pos =3D 0; pos < 4; pos++, sb_block -=3D 0x200) {
+		switch (medley_sb_helper(thisdisk, disk_fd, sb_block * 512)) {
+			case -1: /* read/seek error */
+				return -1;
+			case 1:
+				return 1;
+			case 2:
+				return 2;
+		}
+	}
+	=09
+	return 0;
+}
+
+static int highpoint_sb_helper(struct harddisk *thisdisk, int disk_fd)
+{
+	unsigned char buffer[512];
+	struct highpoint_raid_conf *hpt_conf;
+
+	if (lseek(disk_fd, HPT_SUPERBLOCKOFFSET, SEEK_SET) !=3D HPT_SUPERBLOCKO=
FFSET) {
+		fprintf(stderr, "could not seek to HPT superblock for %s\n", thisdisk-=
>devname);
+		return -1;
+	}
+
+	if (read(disk_fd, buffer, 512) !=3D 512) {
+		fprintf(stderr, "could not read HPT superblock for %s\n", thisdisk->de=
vname);
+		return -1;
+	}
+
+	hpt_conf =3D (struct highpoint_raid_conf *)buffer;
+
+	if (hpt_conf->magic =3D=3D HPT_MAGIC_OK) {
+		//printf("superblock with good HPT magic found, disk_number: %u\n", hp=
t_conf->disk_number);
+		//printf("superblock with HPT magic found\n");
+	        switch (hpt_conf->type) {
+			case HPT_T_SPAN:
+			case HPT_T_RAID_0:
+			case HPT_T_RAID_1:
+			case HPT_T_RAID_01_RAID_0:
+			case HPT_T_RAID_3:
+			case HPT_T_RAID_5:
+				if (hpt_conf->disk_number <=3D 8) {
+					thisdisk->hasraidmagic |=3D 1 << PCI_HPTRAID;
+					return 1;
+				} else {
+					fprintf(stderr, "superblock with good HPT magic found, invalid disk=
_number: %u\n", hpt_conf->disk_number);
+					break;
+				}
+			case HPT_T_SINGLEDISK:
+				fprintf(stderr, "superblock with good HPT magic found suggesting sin=
gle disk\n");
+				break;
+			//case HPT_T_RAID_01_RAID_1:
+			default:
+				fprintf(stderr, "superblock with good HPT magic, but unexpected raid=
 id %i found\n", hpt_conf->type);
+		}
+		return 3;
+	}
+
+	if (hpt_conf->magic =3D=3D HPT_MAGIC_BAD) {
+		/* FIXME: what does HPT_MAGIC_BAD mean? */
+		fprintf(stderr, "superblock with bad HPT magic found\n");
+		//thisdisk->hasraidmagic |=3D 1 << PCI_HPTRAID;
+		return 2;
+	}
+
+	return 0;
+}
+
+static int highpoint_get_sb(struct harddisk *thisdisk, int disk_fd)
+{
+	return highpoint_sb_helper(thisdisk, disk_fd);
+}
+
+static int promise_sb_helper(struct harddisk *thisdisk, int disk_fd, uns=
igned int heads, unsigned int sectors)
+{
+	u_int32_t pdc_checksum =3D 0;
+	loff_t pdc_superblockoffset =3D 0;
+	loff_t pdc_superblockblockoffset =3D 0;
+	u_int32_t *pdc_checksum_ptr;
+	unsigned char buffer[2048];
+	struct promise_raid_conf *pdc_conf;
+	unsigned int i;
+
+
+	/* FIXME: We assume 512 byte sector size */
+	pdc_superblockoffset =3D ((thisdisk->devsize / (heads * sectors)) * hea=
ds - 1) * sectors * 512;
+	pdc_superblockblockoffset =3D ((thisdisk->devsize / (heads * sectors)) =
* heads - 1) * sectors;
+
+	if (my_llseek(disk_fd, pdc_superblockoffset, SEEK_SET) !=3D pdc_superbl=
ockoffset) {
+		fprintf(stderr, "could not seek to PDC superblock for %s\n", thisdisk-=
>devname);
+		return -1;
+	}
+
+	if (read(disk_fd, buffer, 2048) !=3D 2048) {
+		fprintf(stderr, "could not read PDC superblock for %s\n", thisdisk->de=
vname);
+		return -1;
+	}
+
+	pdc_conf =3D (struct promise_raid_conf *)buffer;
+
+	if (strncmp(pdc_conf->promise_id, PR_MAGIC, 24) =3D=3D 0) {
+		//printf("found PDC superblock magic\n");
+		pdc_checksum_ptr =3D (unsigned int *)buffer;
+
+		for (i =3D 0; i < 511; i++)
+			pdc_checksum +=3D *pdc_checksum_ptr++;
+
+		if (pdc_conf->checksum =3D=3D pdc_checksum) {
+			/* FIXME: Check if it is a plain disk with valid superblock */
+			//printf("superblock with PDC magic found\n");
+			thisdisk->hasraidmagic |=3D 1 << PCI_PDCRAID;
+			return 1;
+		} else {
+			fprintf(stderr, "PDC superblock with bad checksum found for %s\n", th=
isdisk->devname);
+			return 2;
+		}
+	}
+
+	return 0;
+}
+
+static int promise_get_sb(struct harddisk *thisdisk, int disk_fd)
+{
+	struct hd_geometry geom;
+
+	if (ioctl(disk_fd, HDIO_GETGEO, &geom) !=3D 0) {
+		fprintf(stderr, "could not get device geometry for %s, probably not a =
disk\n", thisdisk->devname);
+		return -1;
+	}
+
+	switch (promise_sb_helper(thisdisk, disk_fd, geom.heads, geom.sectors))=
 {
+		case -1: /* read/seek error */
+			return -1;
+		case 0:
+			switch (promise_sb_helper(thisdisk, disk_fd, 256, 63)) {
+				case -1: /* read/seek error */
+					return -1;
+				case 0:
+					switch (promise_sb_helper(thisdisk, disk_fd, 16, 255)) {
+						case -1: /* read/seek error */
+							return -1;
+						case 0:
+							switch (promise_sb_helper(thisdisk, disk_fd, 16, 63)) {
+								case -1: /* read/seek error */
+									return -1;
+								case 0:
+									return promise_sb_helper(thisdisk, disk_fd, 255, 63);
+							}
+					}
+			}
+	}
+
+	return 1;
+}
+
+static int add_disk_to_raidlists(struct harddisk *thisdisk)
+{
+	int retval =3D 0;
+	struct stat disk_stat;
+	int disk_fd;
+
+	disk_fd =3D open(thisdisk->devdevname, O_RDONLY|O_LARGEFILE);
+	if (disk_fd < 0) {
+		fprintf(stderr, "could not open %s\n", thisdisk->devdevname);
+		return -1;
+	}
+
+	if (fstat(disk_fd, &disk_stat) < 0) {
+		fprintf(stderr, "could not stat %s\n", thisdisk->devdevname);
+		retval =3D -1;
+		goto exit;
+	}
+
+	if ((major(disk_stat.st_rdev) !=3D major(thisdisk->device)) ||
+		(minor(disk_stat.st_rdev) !=3D minor(thisdisk->device))) {
+		fprintf(stderr, "unexpected major/minor mismatch between kernel name %=
s and /dev name %s\n",
+			thisdisk->devname, thisdisk->devdevname);
+		retval =3D -1;
+		goto exit;
+	}
+
+	/* look for promise RAID first. promise_get_sb checks the geometry and =
aborts if it is a cdrom */
+	switch (promise_get_sb(thisdisk, disk_fd)) {
+		case -1: /* read/seek error */
+			retval =3D -1;
+			goto exit;
+	}
+	=09
+	switch (highpoint_get_sb(thisdisk, disk_fd)) {
+		case -1: /* read/seek error */
+			retval =3D -1;
+			goto exit;
+	}
+	=09
+	switch (medley_get_sb(thisdisk, disk_fd)) {
+		case -1: /* read/seek error */
+			retval =3D -1;
+			goto exit;
+	}
+	=09
+exit:
+	close(disk_fd);
+	return 0;
+}
+
+static int attached_to_raidcontroller(struct harddisk *thisdisk, int onl=
yvendor)
+{
+	unsigned int i;
+	for(i=3D0; i < sizeof(hptpci)/sizeof(struct biospci_s); i++) {
+		if(hptpci[i].vendor =3D=3D thisdisk->vendorid &&
+				(onlyvendor || hptpci[i].device =3D=3D thisdisk->deviceid)) {
+			thisdisk->controllertype =3D 1 << PCI_HPTRAID;
+			return 0;
+		}
+	}
+	for(i=3D0; i < sizeof(pdcpci)/sizeof(struct biospci_s); i++) {
+		if(pdcpci[i].vendor =3D=3D thisdisk->vendorid &&
+				(onlyvendor || pdcpci[i].device =3D=3D thisdisk->deviceid)) {
+			thisdisk->controllertype =3D 1 << PCI_PDCRAID;
+			return 0;
+		}
+	}
+	for(i=3D0; i < sizeof(silpci)/sizeof(struct biospci_s); i++) {
+		if(silpci[i].vendor =3D=3D thisdisk->vendorid &&
+				(onlyvendor || silpci[i].device =3D=3D thisdisk->deviceid)) {
+			thisdisk->controllertype =3D 1 << PCI_SILRAID;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+static int same_controllertype(struct harddisk *disk1, struct harddisk *=
disk2)
+{
+	int retval =3D 0;
+	if (disk1->vendorid !=3D disk2->vendorid)
+		retval =3D -1;
+	if (disk1->deviceid !=3D disk2->deviceid)
+		retval =3D -1;
+	if (disk1->subsystem_vendorid !=3D disk2->subsystem_vendorid)
+		retval =3D -1;
+	if (disk1->subsystem_deviceid !=3D disk2->subsystem_deviceid)
+		retval =3D -1;
+	return retval;
+}
+
+static int same_controller(struct harddisk *disk1, struct harddisk *disk=
2)
+{
+	int retval =3D 0;
+	if (same_controllertype(disk1, disk2))
+		retval =3D -1;
+	/* FIXME: we assume that everything after the dot is subdevice */
+	/* clever hack or ugly code, you decide */
+	if (strncmp(disk1->controllerid, disk2->controllerid, strchr(disk1->con=
trollerid, '.') - disk1->controllerid))
+		retval =3D -1;
+	return retval;
+}
+
+static int same_disk(struct harddisk *disk1, struct harddisk *disk2)
+{
+	int retval =3D 0;
+	if (same_controller(disk1, disk2))
+		retval =3D -1;
+	if (strcmp(disk1->devname, disk2->devname))
+		retval =3D -1;
+	return retval;
+}
+
+static int print_harddisk_info(struct harddisk *thisdisk)
+{
+	printf("name: %s, /dev name: %s, major: %u, minor: %u, size: %llu, atta=
ched to: %s, controller: %i, "
+		"vendorid: 0x%x, deviceid: 0x%x, "
+		"subsystem_vendorid: 0x%x, subsystem_deviceid: 0x%x, controllertype: %=
i, hasraidmagic: %i\n",
+		thisdisk->devname, thisdisk->devdevname, major(thisdisk->device), mino=
r(thisdisk->device),
+		thisdisk->devsize, thisdisk->controllerid, thisdisk->controller,
+		thisdisk->vendorid, thisdisk->deviceid,
+		thisdisk->subsystem_vendorid, thisdisk->subsystem_deviceid, thisdisk->=
controllertype, thisdisk->hasraidmagic);
+	return 0;
+}
+
+static int print_all_harddisks_grouped(struct harddisk *harddisks, unsig=
ned int bdev_count)
+{
+	unsigned int i =3D 0;
+
+	printf("The following disks hang off a HPT IDE controller:\n");
+	for (i =3D 0; i < bdev_count; i++)
+		if (harddisks[i].controllertype =3D=3D 1 << PCI_HPTRAID)
+			print_harddisk_info(&harddisks[i]);
+
+	printf("The following disks hang off a PDC IDE controller:\n");
+	for (i =3D 0; i < bdev_count; i++)
+		if (harddisks[i].controllertype =3D=3D 1 << PCI_PDCRAID)
+			print_harddisk_info(&harddisks[i]);
+
+	printf("The following disks hang off a SIL IDE controller:\n");
+	for (i =3D 0; i < bdev_count; i++)
+		if (harddisks[i].controllertype =3D=3D 1 << PCI_SILRAID)
+			print_harddisk_info(&harddisks[i]);
+
+	printf("The following disks are unclassified:\n");
+	for (i =3D 0; i < bdev_count; i++)
+		if (harddisks[i].controllertype =3D=3D 0)
+			print_harddisk_info(&harddisks[i]);
+
+	return 0;
+}
+
+static int print_all_harddisks_onlyraid_silent(struct harddisk *harddisk=
s, unsigned int bdev_count)
+{
+	unsigned int i =3D 0;
+
+	/* Explanation: The bitwise AND below helps us to show only disks
+	   which have RAID magic vendor matching controller vendor */
+	for (i =3D 0; i < bdev_count; i++)
+		if (harddisks[i].hasraidmagic & harddisks[i].controllertype)
+			printf("%s\n", harddisks[i].devname);
+
+	return 0;
+}
+
+static int fill_disk_size(const char *path, struct harddisk *thisdisk)
+{
+	struct dlist *attributes;
+	struct sysfs_directory *sysfs_dir;
+	char *myval =3D NULL;
+	int retval =3D 0;
+	int devmajor =3D 0;
+	int devminor =3D 0;
+
+	sysfs_dir =3D sysfs_open_directory(path);
+	if (sysfs_dir =3D=3D NULL)
+		return -1;
+
+	attributes =3D sysfs_get_dir_attributes(sysfs_dir);
+	if (attributes =3D=3D NULL) {
+		retval =3D -1;
+		goto exit;
+	}
+	myval =3D sysfs_get_value_from_attributes(attributes, "dev");
+	if (myval) {
+		//printf("dev: %s", myval);
+		devmajor =3D strtoul(myval, &myval, 0);
+		devminor =3D strtoul(++myval, NULL, 0);
+		thisdisk->device =3D makedev(devmajor, devminor);
+	} else {
+		retval =3D -1;
+		goto exit;
+	}
+	myval =3D sysfs_get_value_from_attributes(attributes, "size");
+	if (myval) {
+		thisdisk->devsize =3D strtoull(myval, NULL, 0);
+		//printf("size: %s", myval);
+	} else {
+		retval =3D -1;
+		goto exit;
+	}
+exit:
+	sysfs_close_directory(sysfs_dir);
+
+	return retval;
+}
+
+static int fill_disk_pci_ids(const char *path, struct harddisk *thisdisk=
)
+{
+	struct dlist *attributes;
+	struct sysfs_directory *sysfs_dir;
+	char *myval =3D NULL;
+	int retval =3D 0;
+
+	sysfs_dir =3D sysfs_open_directory(path);
+	if (sysfs_dir =3D=3D NULL)
+		return -1;
+
+	attributes =3D sysfs_get_dir_attributes(sysfs_dir);
+	if (attributes =3D=3D NULL) {
+		retval =3D -1;
+		goto exit;
+	}
+	myval =3D sysfs_get_value_from_attributes(attributes, "vendor");
+	if (myval) {
+		thisdisk->vendorid =3D (unsigned int)strtoul(myval, NULL, 0);
+		//printf("vendor: %s", myval);
+	} else {
+		retval =3D -1;
+		goto exit;
+	}
+	myval =3D sysfs_get_value_from_attributes(attributes, "device");
+	if (myval) {
+		thisdisk->deviceid =3D (unsigned int)strtoul(myval, NULL, 0);
+		//printf("device: %s", myval);
+	} else {
+		retval =3D -1;
+		goto exit;
+	}
+	myval =3D sysfs_get_value_from_attributes(attributes, "subsystem_vendor=
");
+	if (myval) {
+		thisdisk->subsystem_vendorid =3D (unsigned int)strtoul(myval, NULL, 0)=
;
+		//printf("subsystem_vendor: %s", myval);
+	} else {
+		retval =3D -1;
+		goto exit;
+	}
+	myval =3D sysfs_get_value_from_attributes(attributes, "subsystem_device=
");
+	if (myval) {
+		thisdisk->subsystem_deviceid =3D (unsigned int)strtoul(myval, NULL, 0)=
;
+		//printf("subsystem_device: %s", myval);
+	} else {
+		retval =3D -1;
+		goto exit;
+	}
+exit:
+	sysfs_close_directory(sysfs_dir);
+
+	return retval;
+}
+
+static int fill_disk_info(const char *path, struct harddisk *thisdisk)
+{
+	struct sysfs_class_device *class_dev;
+	struct sysfs_class_device *class_dev_basedev;
+	struct sysfs_attribute *attr;
+	struct sysfs_device *sysfs_dev;
+	struct sysfs_device *sysfs_dev_parent;
+	int retval =3D 0;
+
+	if (strstr(path, "/sys/block/") =3D=3D NULL) {
+		fprintf(stderr, "working on a non-block device. This should not happen=
\n");
+		return -1;
+	}
+
+	/*  get the class dev */
+	class_dev =3D sysfs_open_class_device_path(path);
+	if (class_dev =3D=3D NULL) {
+		fprintf(stderr, "couldn't get the class device\n");
+		return -1;
+	}
+
+	/* read the 'dev' file for major/minor*/
+	attr =3D sysfs_get_classdev_attr(class_dev, "dev");
+	if (attr =3D=3D NULL) {
+		fprintf(stderr, "couldn't get the \"dev\" file\n");
+		retval =3D -1;
+		goto exit;
+	}
+
+	/* if parent exists, use that instead */
+	class_dev_basedev =3D sysfs_get_classdev_parent(class_dev) ? : class_de=
v;
+
+	if (!class_dev_basedev->path) {
+		fprintf(stderr, "path of basedev is NULL\n");
+		retval =3D -1;
+		goto exit;
+	}
+
+	strncpy(thisdisk->devname, class_dev_basedev->path, sizeof(thisdisk->de=
vname) - 1);
+
+	/* FIXME: We assume that devname has "/sys/block/" prepending the name =
also found in /dev */
+	strncpy(thisdisk->devdevname, "/dev/", sizeof(thisdisk->devdevname) - 1=
);
+	strncat(thisdisk->devdevname,
+		strstr(thisdisk->devname, "/sys/block/") + strlen("/sys/block/"),
+		sizeof(thisdisk->devdevname) - strlen("/dev/") - 1);
+
+	if (fill_disk_size(class_dev_basedev->path, thisdisk) !=3D 0) {
+		fprintf(stderr, "couldn't open base class device directory for %s\n", =
thisdisk->devname);
+		retval =3D -1;
+		goto exit;
+	}
+
+	/* get the device link */
+	sysfs_dev =3D sysfs_get_classdev_device(class_dev_basedev);
+=09
+	if (!sysfs_dev) {
+		fprintf(stderr, "couldn't get the class device of the base device\n");=

+		retval =3D -1;
+		goto exit;
+	}
+
+	/* look the device chain upwards until we find the underlying pci devic=
e */
+	while (sysfs_dev !=3D NULL) {
+		if (strcmp(sysfs_dev->bus, "pci") =3D=3D 0) {
+			/* we found the pci device, fill in the info */
+			strncpy(thisdisk->controllerid, sysfs_dev->bus_id, sizeof(thisdisk->c=
ontrollerid) - 1);
+			fill_disk_pci_ids(sysfs_dev->path, thisdisk);
+			/* check if it is attached to a known raid controller */
+			/* For now, play safe and check only the vendor id to catch unknown d=
evice ids */
+			attached_to_raidcontroller(thisdisk, 1);
+			break;
+		}
+
+		sysfs_dev_parent =3D sysfs_get_device_parent(sysfs_dev);
+		/* check if we arrived at the top before getting the pci device */
+		if (sysfs_dev_parent =3D=3D NULL) {
+			retval =3D -1;
+			goto exit;
+		}
+
+		sysfs_dev =3D sysfs_dev_parent;
+	}
+exit:
+	sysfs_close_class_device(class_dev);
+	return retval;
+}
+
+/* BIG FAT WARNING: You have to free harddisks after calling this functi=
on */
+static int enumerate_all_bdevs(const char *sysblockpath, struct harddisk=
 **harddisks_p)
+{
+	int retval =3D 0;
+	unsigned int bdev_count =3D 0;
+	unsigned int contrlr_count =3D 0;
+	unsigned int i =3D 0;
+	unsigned int j =3D 0;
+	struct dlist *sysfs_blockdirs;
+	struct sysfs_directory *sysfs_blockdir;
+	struct sysfs_directory *sysfs_dir;
+	struct harddisk *harddisks;
+
+	/* This may seem backwards, but sysfs_path_is_dir returns 0 on success =
*/
+	if (sysfs_path_is_dir(sysblockpath))
+		return -1;
+	sysfs_dir =3D sysfs_open_directory(sysblockpath);
+	if (!sysfs_dir)
+		return -1;
+
+	sysfs_blockdirs =3D sysfs_get_dir_subdirs(sysfs_dir);
+=09
+	if (!sysfs_blockdirs) {
+		fprintf(stderr, "no subdirectories of %s found\n", sysblockpath);
+		retval =3D -1;
+		goto exit;
+	}
+
+	dlist_for_each_data(sysfs_blockdirs, sysfs_blockdir, struct sysfs_direc=
tory) {
+		if (sysfs_blockdir->name) {
+			if (!strncmp(sysfs_blockdir->name, "hd", 2) || !strncmp(sysfs_blockdi=
r->name, "sd", 2)) {
+				bdev_count++;
+			}
+		}
+	}
+	//printf("%u disks found\n", bdev_count);
+
+	if (bdev_count =3D=3D 0) {
+		retval =3D -1;
+		goto exit;
+	}
+
+	harddisks =3D malloc(sizeof(struct harddisk) * bdev_count);
+	if (!harddisks) {
+		retval =3D -1;
+		goto exit;
+	}
+	memset (harddisks, 0, sizeof(struct harddisk) * bdev_count);
+
+	dlist_for_each_data(sysfs_blockdirs, sysfs_blockdir, struct sysfs_direc=
tory) {
+		if (sysfs_blockdir->name) {
+			if (!strncmp(sysfs_blockdir->name, "hd", 2) || !strncmp(sysfs_blockdi=
r->name, "sd", 2)) {
+				if (fill_disk_info(sysfs_blockdir->path, &harddisks[i]) =3D=3D 0) {
+					i++;
+				} else {
+					bdev_count--;
+					fprintf(stderr, "disk %s with incomplete sysfs entries discarded, %=
u disks remaining\n", sysfs_blockdir->path, bdev_count);
+				}
+			}
+		}
+	}
+
+	/* for (i =3D 0; i < bdev_count; i++)
+		print_harddisk_info(&harddisks[i]); */
+
+	/* start with number 1 */
+	for (i =3D 0; i < bdev_count; i++) {
+		if (harddisks[i].controller =3D=3D 0) {
+			contrlr_count++;
+			harddisks[i].controller =3D contrlr_count;
+		}
+		=09
+		for (j =3D i + 1; j < bdev_count; j++) {
+			/* only check devices not marked before */
+			if (harddisks[j].controller =3D=3D 0) {
+				if (same_controller(&harddisks[i], &harddisks[j]) =3D=3D 0) {
+					if (same_disk(&harddisks[i], &harddisks[j]) =3D=3D 0)
+						continue;
+					harddisks[j].controller =3D harddisks[i].controller;
+				}
+			}
+		}
+	}
+
+	for (i =3D 0; i < bdev_count; i++)
+		add_disk_to_raidlists(&harddisks[i]);
+
+	*harddisks_p =3D harddisks;
+	//free(harddisks);
+exit:
+	sysfs_close_directory(sysfs_dir);
+	return retval ? : bdev_count;
+}
+
+int main(int argc, char *argv[])
+{
+	int option;
+	int retval;
+	unsigned int bdev_count;
+	struct harddisk *harddisks =3D NULL;
+
+	retval =3D enumerate_all_bdevs("/sys/block", &harddisks);
+
+	if (retval < 0) {
+		fprintf(stderr, "an error occured in enumerate_all_bdevs!\n");
+		exit(1);
+	}
+
+	bdev_count =3D retval;
+
+	option =3D getopt(argc, argv, "s");
+	switch (option) {
+		case 's':
+			print_all_harddisks_onlyraid_silent(harddisks, bdev_count);
+			break;
+		default:
+			print_all_harddisks_grouped(harddisks, bdev_count);
+	}
+
+	free(harddisks);
+
+	exit(0);
+}
diff -urN udev-023-orig/raiddetect.h udev-023/raiddetect.h
--- udev-023-orig/raiddetect.h	1970-01-01 01:00:00.000000000 +0100
+++ udev-023/raiddetect.h	2004-04-04 21:35:31.000000000 +0200
@@ -0,0 +1,40 @@
+#ifndef __RAIDDETECT_H__
+#define __RAIDDETECT_H__ 1
+
+#define PCI_HPTRAID 0
+#define PCI_PDCRAID 1
+#define PCI_SILRAID 2
+#define RAIDTYPE_COUNT 3
+
+struct harddisk {
+	char devname[SYSFS_PATH_MAX];
+	char devdevname[PATH_MAX];
+	char controllerid[SYSFS_PATH_MAX];
+	int controller;
+	char controllertype;
+	char claimed;
+	char hasraidmagic;
+	dev_t device;
+	unsigned long long devsize;
+	unsigned int hardsectorsize;
+	unsigned int blocksize;
+	unsigned int vendorid;
+	unsigned int deviceid;
+	unsigned int subsystem_vendorid;
+	unsigned int subsystem_deviceid;
+};
+
+        /* list of the pci ids of the supported controllers */
+struct biospci_s {
+	u_int16_t vendor;
+	u_int16_t device;
+};
+
+struct hd_geometry {
+	unsigned char heads;
+	unsigned char sectors;
+	unsigned short cylinders;
+	unsigned long start;
+};
+
+#endif

--------------040004080608090009010001--

