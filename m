Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUDPUI4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUDPUI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:08:56 -0400
Received: from mail.gmx.de ([213.165.64.20]:16815 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263607AbUDPUFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:05:13 -0400
X-Authenticated: #21910825
Message-ID: <40803C61.503@gmx.net>
Date: Fri, 16 Apr 2004 22:04:49 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Thomas Horsten <thomas@horsten.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       medley@lists.infowares.com, linux-hotplug-devel@lists.sourceforge.net,
       Wilfried Weissmann <Wilfried.Weissmann@gmx.at>,
       Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Greg KH <greg@kroah.com>
Subject: Re: [RFC] [DRAFT] [udev PATCH] First attempt at vendor RAID support
 in 2.6
References: <Pine.LNX.4.40.0404151458450.30892-100000@jehova.dsm.dk>
In-Reply-To: <Pine.LNX.4.40.0404151458450.30892-100000@jehova.dsm.dk>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010303000906070103050805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010303000906070103050805
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

[this is not only a reply to Thomas' mail, but also an update about the
current state of my vendor RAID support]

Greg: Would you accept this patch into your udev package?

Thomas Horsten wrote:
> Hi Carl-Daniel,
> 
> On Thu, 15 Apr 2004, Carl-Daniel Hailfinger wrote:
> 
> 
>>What I need:
>>- People looking at the *_sb_helper functions to tell me if there is more
>>magic I can check for

Partly solved, check below.


>>- Criticism of coding style/ missing abstraction

I got a mail from Barlomiej Zolnierkiewicz where he suggested to split the
vendor dependent code out of raiddetect.c. This will happen in one of the
next revisions.


>>- People checking the numerous FIXMEs

I now have the following FIXMEs (aka "I have no idea about it"):
- 5 FIXMEs in the Medley RAID code. Thomas, could you comment once you're
back?
- 3 FIXMEs in the Highpoint RAID code. Wilfried, could you please take a
look at them?
- 2 FIXMEs in the Promise RAID code. I will on those myself.
- some generic FIXMEs:
  - Is the sector size of a harddisk always 512 bytes?
  - Is /sys/block/*/size always in 512-byte units?
  - Are there controllers out there which occupy more than one PCI device?
  - How can I find out if a block device under /sys/block is a disk?


>>- More data about Medley/Highpoint vendor superblocks (can I check for
>>bogus values?)

Wilfried, is there any consistency check I can add for Highpoint?


>>- Help with sorting out who owns which copyrights

This is still a _big issue_.


> I'm on holiday in New York right now so I don't have time to give you a
> complete breakdown. But I can give you a couple of comments on Medley RAID
> and get back to you when I return next week.

Thanks!


> First: It should not be called "SIL", "SII", or "Silicon Image" RAID in
> the parts of the code exposed to the user. This is because other vendors
> than Silicon Image use the Medley RAID specification (such as the CMD680R
> SATA controller and others). When refering specifically to Silicon Image,
> SII is the correct abbreviation, not "SIL".

Changed.


> You are asking for more magic to detect Medley RAID. The probe function
> for Medley in my patch (medley_probe_drive()) first calls
> medley_get_metadata() which uses the checksum to determine if it is a
> Medley superblock. In my version, it also checks the PCI vendor ID/product
> ID against that stored in the Medley superblock. This is consistent with
> how the Medley BIOS verifies a valid Medley superblock and you should rely
> on this for automatic detection. But since users might want to move the
> RAID set to a different controller, e.g. if their on-board controller
> breaks down, there should be an option to force detection to bypass the
> PCI ID verification.

medley_sb_helper now has a parameter ignore_vendorid (default off).


> After you have a correct checksum there are several other things you can
> check for, which I do in my medley_probe_drive() after obtaining the
> superblock:
> 
> - Check raid_type, it should be 0 for striped sets (RAID0) - I will get
> you the values for RAID1 and RAID1+0 when I return from NY.

Will be added as soon as I get the data.


> - Check major_ver, it should be 1 or 2 (other major versions may have a
> different superblock and can not be supported).

Will be added once I have more info about the expected checksum value for
different superblock versions (see FIXME there).


> - Check that the chunk_size looks reasonable, that there is more than

The chunk_size>0 check is now in. Can I do better chunk_size checking?


> 1 drive in the set (drives_per_striped_set), and that the drive_number
> is within the range 0-(drives_per_striped_set-1).

Done.


> If you do all these checks and still come out with a valid candidate, it's
> probably safe to assume that the drive belongs to a set if all the disks
> are present.

Attached is my current version of raiddetect.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------010303000906070103050805
Content-Type: text/plain;
 name="raiddetect_v41.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="raiddetect_v41.diff"

diff -urN udev-023-orig/bios_hpt.h udev-023/bios_hpt.h
--- udev-023-orig/bios_hpt.h	1970-01-01 01:00:00.000000000 +0100
+++ udev-023/bios_hpt.h	2004-04-15 02:16:45.000000000 +0200
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
diff -urN udev-023-orig/bios_medley.h udev-023/bios_medley.h
--- udev-023-orig/bios_medley.h	1970-01-01 01:00:00.000000000 +0100
+++ udev-023/bios_medley.h	2004-04-16 19:22:40.952996232 +0200
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2003 Thomas Horsten <thomas@horsten.com>
+ */
+
+#ifndef __BIOS_MEDLEY_H__
+#define __BIOS_MEDLEY_H__ 1
+
+#define PCI_VENDOR_ID_CMD		0x1095
+#define PCI_DEVICE_ID_SII_3112		0x3112
+
+static struct biospci_s medleypci[] =3D {
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
diff -urN udev-023-orig/bios_pdc.h udev-023/bios_pdc.h
--- udev-023-orig/bios_pdc.h	1970-01-01 01:00:00.000000000 +0100
+++ udev-023/bios_pdc.h	2004-04-15 02:18:26.000000000 +0200
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
+++ udev-023/raiddetect.c	2004-04-16 21:31:03.691002064 +0200
@@ -0,0 +1,750 @@
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
+#include "bios_medley.h"
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
+#define llseek lseek64
+#endif
+
+
+static int medley_sb_helper(struct harddisk *thisdisk, int disk_fd, loff=
_t sb_offset, int ignore_vendorid)
+{
+	unsigned char buffer[512];
+	struct medley_raid_conf *medley_conf;
+	int i;
+	u_int16_t medley_checksum =3D 0;
+	u_int16_t * medley_checksum_ptr =3D 0;
+
+	if (llseek(disk_fd, sb_offset, SEEK_SET) !=3D sb_offset) {
+		fprintf(stderr, "could not seek to Medley superblock for %s\n", thisdi=
sk->devname);
+		return -1;
+	}
+	if (read(disk_fd, buffer, 512) !=3D 512) {
+		fprintf(stderr, "could not read Medley superblock for %s\n", thisdisk-=
>devname);
+		return -1;
+	}
+
+	medley_conf =3D (struct medley_raid_conf *)buffer;
+
+	medley_checksum_ptr =3D (u_int16_t *)buffer;
+
+	if ((!ignore_vendorid) &&
+		(thisdisk->vendorid !=3D medley_conf->vendor_id || thisdisk->deviceid =
!=3D medley_conf->product_id))
+		return 0;
+
+	for (i =3D 0; i < 160; i++)
+		medley_checksum +=3D *medley_checksum_ptr++;
+
+	/* FIXME: can (medley_checksum =3D=3D 0) happen with (medley_conf->majo=
r_ver =3D=3D 1) ? */
+	/* FIXME: add check for (medley_conf->major_ver =3D=3D {1,2}) into chec=
ksum check below */
+	if (((medley_checksum =3D=3D 0xffff) && (medley_conf->major_ver =3D=3D =
1)) || (medley_checksum =3D=3D 0)) {
+		/* We have a valid superblock. Now do additional checks */
+		switch (medley_conf->raid_type) {
+			case 0x0:
+				if ((medley_conf->drives_per_striped_set > 1) &&
+					(medley_conf->drive_number < medley_conf->drives_per_striped_set) &=
&
+					(medley_conf->chunk_size > 0)) {
+					/* FIXME: Check for reasonable medley_conf->chunk_size here, is >0 =
enough? */
+					thisdisk->hasraidmagic |=3D 1 << PCI_MEDLEYRAID;
+					return 1;
+				}
+				/* superblock suggests RAID 0, but the disk configuration data is bo=
gus */
+				return 3;
+			default:
+			/* FIXME: This is a valid superblock, but we don't know how to handle=
 it */
+				thisdisk->hasraidmagic |=3D 1 << PCI_MEDLEYRAID_UNKNOWN;
+				return 2;
+		}
+		=09
+	}
+	return 0;
+}
+
+static int medley_get_sb(struct harddisk *thisdisk, int disk_fd)
+{
+	int pos;
+	int res;
+	loff_t sb_block =3D 0;
+
+	sb_block =3D (thisdisk->devsize - 1);
+	for (pos =3D 0; pos < 4; pos++, sb_block -=3D 0x200) {
+		switch (res =3D medley_sb_helper(thisdisk, disk_fd, sb_block * 512, 0)=
) {
+			case -1:
+			case 1:
+			case 2:
+			case 3:
+			/* FIXME: do we want to continue scanning if the superblock itself is=

+			   valid, but the data in it is garbage? If so, remove case 3: above =
*/
+				return res;
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
+				/* FIXME: Does "no array defined" correspond to HPT_T_SINGLEDISK? */=

+				fprintf(stderr, "superblock with good HPT magic found suggesting sin=
gle disk\n");
+				break;
+			//case HPT_T_RAID_01_RAID_1:
+				/* FIXME: Is HPT_T_RAID_01_RAID_1 a value that can ever be found? */=

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
+		thisdisk->hasraidmagic |=3D 1 << PCI_HPTRAID_UNKNOWN;
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
+	if (llseek(disk_fd, pdc_superblockoffset, SEEK_SET) !=3D pdc_superblock=
offset) {
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
+	for(i=3D0; i < sizeof(medleypci)/sizeof(struct biospci_s); i++) {
+		if(medleypci[i].vendor =3D=3D thisdisk->vendorid &&
+				(onlyvendor || medleypci[i].device =3D=3D thisdisk->deviceid)) {
+			thisdisk->controllertype =3D 1 << PCI_MEDLEYRAID;
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
+	printf("The following disks hang off a Medley RAID capable IDE controll=
er:\n");
+	for (i =3D 0; i < bdev_count; i++)
+		if (harddisks[i].controllertype =3D=3D 1 << PCI_MEDLEYRAID)
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
+		if ((harddisks[i].hasraidmagic & harddisks[i].controllertype) ||
+			((harddisks[i].hasraidmagic >> RAIDTYPE_UNKNOWN_SHIFT) & harddisks[i]=
=2Econtrollertype))
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
+++ udev-023/raiddetect.h	2004-04-16 19:52:02.220242912 +0200
@@ -0,0 +1,44 @@
+#ifndef __RAIDDETECT_H__
+#define __RAIDDETECT_H__ 1
+
+#define RAIDTYPE_COUNT 3
+#define RAIDTYPE_UNKNOWN_SHIFT RAIDTYPE_COUNT
+#define PCI_HPTRAID 0
+#define PCI_PDCRAID 1
+#define PCI_MEDLEYRAID 2
+#define PCI_HPTRAID_UNKNOWN (PCI_HPTRAID + RAIDTYPE_UNKNOWN_SHIFT)
+#define PCI_PDCRAID_UNKNOWN (PCI_PDCRAID + RAIDTYPE_UNKNOWN_SHIFT)
+#define PCI_MEDLEYRAID_UNKNOWN (PCI_MEDLEYRAID + RAIDTYPE_UNKNOWN_SHIFT)=

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

--------------010303000906070103050805--

