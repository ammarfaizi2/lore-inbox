Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263806AbTCUSvp>; Fri, 21 Mar 2003 13:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbTCUSuf>; Fri, 21 Mar 2003 13:50:35 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:51628 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263801AbTCUSts>;
	Fri, 21 Mar 2003 13:49:48 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch for playing] 2.5.65 patch to support > 256 disks
Date: Fri, 21 Mar 2003 10:56:04 -0800
User-Agent: KMail/1.4.1
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_GL44BUSW346PXEXQ8DJ7"
Message-Id: <200303211056.04060.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_GL44BUSW346PXEXQ8DJ7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Andries Brouwer recently submitted 32 bit dev_t patches,
which are in 2.5.65-mm2. This patch applies on those patches to support=20
more than 256 disks.  This is for playing only.

I tested this with 4000 disks using scsi_debug. I attached my actual
disks (50) after 4000 scsi_debug disks. I am able to access my disks
fine and do IO on them.

Problems (so far):

1) sd.c -  sd_index_bits[] arrys became big - need to be fixed.

2) 4000 disks eats up lots of low memory (~460 MB). Here is the
/proc/meminfo output before & after insmod.

Before:
MemTotal:      3883276 kB
MemFree:       3808028 kB
Buffers:          3240 kB
Cached:          41860 kB
SwapCached:          0 kB
Active:          45360 kB
Inactive:         7288 kB
HighTotal:     3014616 kB
HighFree:      2961856 kB
LowTotal:       868660 kB
LowFree:        846172 kB
SwapTotal:     2040244 kB
SwapFree:      2040244 kB
Dirty:             192 kB
Writeback:           0 kB
Mapped:          14916 kB
Slab:             7164 kB
Committed_AS:    12952 kB
PageTables:        312 kB
ReverseMaps:      1895
=3D=3D=3D=3D
After:
MemTotal:      3883276 kB
MemFree:       3224140 kB
Buffers:          3880 kB
Cached:         140376 kB
SwapCached:          0 kB
Active:          47512 kB
Inactive:       105508 kB
HighTotal:     3014616 kB
HighFree:      2838144 kB
LowTotal:       868660 kB
LowFree:        385996 kB
SwapTotal:     2040244 kB
SwapFree:      2040244 kB
Dirty:              92 kB
Writeback:           0 kB
Mapped:          16172 kB
Slab:           464364 kB
Committed_AS:    14996 kB
PageTables:        412 kB
ReverseMaps:      2209

--------------Boundary-00=_GL44BUSW346PXEXQ8DJ7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sd.patch"

--- linux/drivers/scsi/sd.c	Thu Mar 20 15:06:00 2003
+++ linux.new/drivers/scsi/sd.c	Fri Mar 21 11:50:54 2003
@@ -56,7 +56,9 @@
  * Remaining dev_t-handling stuff
  */
 #define SD_MAJORS	16
-#define SD_DISKS	(SD_MAJORS << 4)
+#define SD_DISKS_PER_MAJOR_SHIFT	(KDEV_MINOR_BITS - 4)
+#define SD_DISKS_PER_MAJOR	(1 << SD_DISKS_PER_MAJOR_SHIFT)
+#define SD_DISKS	(SD_MAJORS << SD_DISKS_PER_MAJOR_SHIFT)
 
 /*
  * Time out in seconds for disks and Magneto-opticals (which are slower).
@@ -1328,17 +1330,23 @@ static int sd_attach(struct scsi_device 
 	sdkp->index = index;
 
 	gd->de = sdp->de;
-	gd->major = sd_major(index >> 4);
-	gd->first_minor = (index & 15) << 4;
+	gd->major = sd_major(index >> SD_DISKS_PER_MAJOR_SHIFT);
+	gd->first_minor = (index & (SD_DISKS_PER_MAJOR - 1)) << 4;
 	gd->minors = 16;
 	gd->fops = &sd_fops;
 
-	if (index >= 26) {
+	if (index < 26) {
+		sprintf(gd->disk_name, "sd%c", 'a' + index % 26);
+	} else if (index < (26*27)) {
 		sprintf(gd->disk_name, "sd%c%c",
 			'a' + index/26-1,'a' + index % 26);
 	} else {
-		sprintf(gd->disk_name, "sd%c", 'a' + index % 26);
-	}
+		const unsigned int m1 = (index/ 26 - 1) / 26 - 1;
+		const unsigned int m2 = (index / 26 - 1) % 26;
+		const unsigned int m3 = index % 26;
+		sprintf(gd->disk_name, "sd%c%c%c", 
+			'a' + m1, 'a' + m2, 'a' + m3);
+	}	
 
 	sd_init_onedisk(sdkp, gd);
 

--------------Boundary-00=_GL44BUSW346PXEXQ8DJ7--

