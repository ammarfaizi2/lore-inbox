Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263069AbTDBRWW>; Wed, 2 Apr 2003 12:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbTDBRWW>; Wed, 2 Apr 2003 12:22:22 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:20126 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263069AbTDBRWS>;
	Wed, 2 Apr 2003 12:22:18 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 64-bit kdev_t - just for playing
Date: Wed, 2 Apr 2003 09:31:38 -0800
User-Agent: KMail/1.4.1
Cc: Joel.Becker@oracle.com, <linux-kernel@vger.kernel.org>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304021413210.12110-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0304021413210.12110-100000@serv>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_QO8QFRZ8OGLD9796OD9R"
Message-Id: <200304020931.38671.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_QO8QFRZ8OGLD9796OD9R
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 02 April 2003 04:18 am, Roman Zippel wrote:
> Hi,
>
> On Mon, 31 Mar 2003, Badari Pulavarty wrote:
> > I have been playing with supporting 4000 disks on IA32 machines.
> > There are bunch of issues we need to resolve before we could
> > do that.
> >
> > I am using scsi_debug to simulate 4000 disks. (Ofcourse, I had
> > to hack "sd" to support more than 256 disks).
>
> Could you please post your changes to sd.c and anything relevant to it?
> Thanks.
>
> bye, Roman

Roman,

Here is the patch for sd to allow more than 256 disks.
There are few issues with the patch that need to be resolved.

1) With the patch I get 16 bits for minor. Since 4 bits are used for
partition, we get 12 bits to represent disks. So each major can support
2^12 =3D 4096 disks. Disks 0 - 4095 are mapped to major=3D8,=20
disks 4096 - 8191 to major =3D 65 and so on..

This means ..

(i) I need to create nodes in /dev/ to match new <major, minor> for=20
these disks.  Currently "mknod" is broken due to glibc issues with dev_t.

(ii) We need to worry about backward compatibility. For example:
17th disk used to have <65, 0>. Now its major, minor is <8, 256>.
So /dev/ entires need to be re-created to match these, everytime
you reboot 2.4/2.5 etc. Greg KH udev might fix this for us.=20

2) Do we still need 16 majors for disks ?

We could change my patch to work around major/minor assignment
issues and maintain backward compatibility.=20

Thanks,
Badari




--------------Boundary-00=_QO8QFRZ8OGLD9796OD9R
Content-Type: text/x-diff;
  charset="iso-8859-1";
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
 

--------------Boundary-00=_QO8QFRZ8OGLD9796OD9R--

