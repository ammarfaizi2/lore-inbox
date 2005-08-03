Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVHCSFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVHCSFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVHCSFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 14:05:25 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:27930 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262380AbVHCSFX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 14:05:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WECpJq2VOGUmJ/ijI4wRsclP4fc89AgpDoHP8CC/19I0HUcUrvwqkzPNfnDgO923LImw41zT+asfFSVlhuKS20i3gesOuzvyTCnXKL35wnBPECVnFvGIlFu8F1YaeQCdvf+9pEaMnrDEociUBSBemhSpiRhk3fWKhnSUNVR/aVI=
Message-ID: <58cb370e05080311056a9276c0@mail.gmail.com>
Date: Wed, 3 Aug 2005 20:05:20 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mark Bellon <mbellon@mvista.com>
Subject: Re: [PATCH] IDE disks show invalid geometries in /proc/ide/hd*/geometry
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <42F100C8.8040700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EFE547.3010206@mvista.com>
	 <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>
	 <58cb370e05080310195c244f72@mail.gmail.com>
	 <42F100C8.8040700@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/05, Mark Bellon <mbellon@mvista.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >Hi,
> >
> >The topic was discussed to death on linux-kernel.
> >
> >Mark, you need to fix your applications and stop using /proc/ide/hd*/geometry
> >or/and HDIO_GET_GEO ioctl (which BTW your patch also affects).
> >
> >
> Fixing the applications I can understand but the patch still seems
> necessary, to me, so the
> HDIO_GET_GEO returns "rational" values.
> 
> I tested  HDIO_GET_GEO and it returns the same broken values as go into
> /proc (no surprises) without my patch.

Please explain.

> If a drive is in LBA mode (28 or 48 bit) the existing code doesn't
> always "fix up" the geometry properly for some value returns. It only
> tries with 48 bit mode and it fails there for some values.  My patch
> forces a complete geometry and appears (to me) to preserve the side
> efefcts of the existing code.
> 
> Am I missing something?

diff -Naur linux-2.6.13-rc3-git9-orig/drivers/ide/ide-disk.c
linux-2.6.13-rc3-git9/drivers/ide/ide-disk.c
--- linux-2.6.13-rc3-git9-orig/drivers/ide/ide-disk.c	2005-08-01
13:48:21.000000000 -0700
+++ linux-2.6.13-rc3-git9/drivers/ide/ide-disk.c	2005-08-02
12:14:43.000000000 -0700
@@ -884,10 +884,17 @@
  	ide_add_setting(drive,	"max_failures",		SETTING_RW,					-1,			-1,			TYPE_INT,	0,	65535,				1,	1,	&drive->max_failures,		NULL);
 }
 
+static uint32_t do_div64_32 (__u64 n, uint32_t d)
+{
+	do_div(n, d);
+
+	return n;
+}
+
 static void idedisk_setup (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
-	unsigned long long capacity;
+	__u64 capacity;
 	int barrier;
 
 	idedisk_add_settings(drive);
@@ -949,27 +956,32 @@
 	 */
 	capacity = idedisk_capacity (drive);
 	if (!drive->forced_geom) {
+		uint32_t cylsz, cyl;
 
-		if (idedisk_supports_lba48(drive->id)) {
-			/* compatibility */
-			drive->bios_sect = 63;
-			drive->bios_head = 255;
+		/*
+		 * In LBA mode the geometry isn't used to talk to the drive
+		 * so always create a "rational" geometry from the capacity.
+		 */
+		if (drive->select.b.lba) {

why are you forcing drive->bios_sect and drive->bios_head
values for LBA28 drives?

+			drive->bios_sect = drive->sect = 63;
+			drive->bios_head = drive->head = 255;

changing drive->sect and drive->head is just wrong,
these are values reported by the device - do not touch them

+
+			cylsz = drive->bios_sect * drive->bios_head;
+			cyl = do_div64_32(capacity, cylsz);

division by zero now is possible (yes, 0/0/0 is possible)

+
+			/* "fake out" works up to ~500 GB */
+			cyl = (cyl > 65535) ? 65535 : cyl;
+			drive->bios_cyl = drive->cyl = cyl;

drive->cyl shouldn't be changed

 		}
 
 		if (drive->bios_sect && drive->bios_head) {
-			unsigned int cap0 = capacity; /* truncate to 32 bits */
-			unsigned int cylsz, cyl;
+			cylsz = drive->bios_sect * drive->bios_head;
+			cyl = do_div64_32(capacity, cylsz);
 
-			if (cap0 != capacity)
-				drive->bios_cyl = 65535;

cap0 != capacity => set the max possible drive->bios_cyl,
no need for adjusting it

-			else {

cap0 == capacity => no need for do_div(), only lower 32-bits are used,
adjust drive->bios_cyl

-				cylsz = drive->bios_sect * drive->bios_head;
-				cyl = cap0 / cylsz;
-				if (cyl > 65535)
-					cyl = 65535;
-				if (cyl > drive->bios_cyl)
-					drive->bios_cyl = cyl;
-			}
+			if (cyl > 65535)
+				cyl = 65535;
+			if (cyl > drive->bios_cyl)
+				drive->bios_cyl = cyl;
 		}
 	}
 	printk(KERN_INFO "%s: %llu sectors (%llu MB)",

> mark
> 
> >Bartlomiej
> >
> >On 8/3/05, Andre Hedrick <andre@linux-ide.org> wrote:
> >
> >
> >>Did you read ATA-1 through ATA-7 to understand all the variations?
> >>
> >>On Tue, 2 Aug 2005, Mark Bellon wrote:
> >>
> >>
> >>
> >>>The ATA specification tells large disk drives to return C/H/S data of
> >>>16383/16/63 regardless of their actual size (other variations on this
> >>>return include 15 heads and/or 4092 cylinders). Unfortunately these CHS
> >>>data confuse the existing IDE code and cause it to report invalid
> >>>geometries in /proc when the disk runs in LBA mode.
> >>>
> >>>The invalid geometries can cause failures in the partitioning tools;
> >>>partitioning may be impossible or illogical size limitations occur. This
> >>>also leads to various forms of human confusion.
> >>>
> >>>I attach a patch that fixes this problem while strongly attempting to
> >>>not break any existing side effects and await any comments.
> >>>
> >>>mark
> >>>
> >>>Signed-off-by: Mark Bellon <mbellon@mvista.com>
