Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135900AbRDZTZP>; Thu, 26 Apr 2001 15:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135898AbRDZTZF>; Thu, 26 Apr 2001 15:25:05 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:6926 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135897AbRDZTYs>; Thu, 26 Apr 2001 15:24:48 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200104261924.VAA15695@green.mif.pg.gda.pl>
Subject: [PATCH] R/W disk statistics
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 26 Apr 2001 21:24:12 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list), mingo@redhat.com
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From kufel!ankry  Thu Apr 26 21:20:09 2001
Return-Path: <kufel!ankry>
Received: from kufel.UUCP (uucp@localhost)
	by green.mif.pg.gda.pl (8.9.3/8.9.3) with UUCP id VAA15655
	for green.mif.pg.gda.pl!ankry; Thu, 26 Apr 2001 21:20:09 +0200
Received: (from ankry@localhost)
	by kufel.dom (8.9.3/8.9.3) id VAA00689
	for ankry@green; Thu, 26 Apr 2001 21:20:17 +0200
Date: Thu, 26 Apr 2001 21:20:17 +0200
From: Andrzej Krzysztofowicz <kufel!ankry>
Message-Id: <200104261920.VAA00689@kufel.dom>
To: kufel!green.mif.pg.gda.pl!ankry
Subject: stat

Alan, Linus, lk, mingo@redhat.com
Hi,
   The following patch adds more devices to the R/W statistics in /proc/stat.
It also changes slightly the format for hdc/hdd signatures in this file:

       old format           new format
hda     (3,0)                 same
hdb     (3,1)                 same
hdc     (22,2)                (22,0)
hdd     (22,3)                (22,1)
hde     none                  (33,0)
hdf     none                  (33,1)

It shouldn't break any tools as even the "old" format is quite new and has
already significantly changed since 2.2.x (where the report was not so
detailed). Having the format unchanged needs a bit more time consuming code...

md devices seem to rely on these data on sync. So lack of them may cause
sync on md devices which base on either SCSI disks with number 17+ (sdq,...)
or IDE disks on the 3rd+ interface (hde,...) not to be performed properly.

I did not add any non-x86 devices here, however. While the same md problems 
concern them also (IMHO).

diff -uNr include/linux/genhd.h~ include/linux/genhd.h
--- include/linux/genhd.h~	Tue Apr 24 22:37:32 2001
+++ include/linux/genhd.h	Wed Apr 25 02:22:46 2001
@@ -252,14 +252,27 @@
 			index = (minor & 0x00f8) >> 3;
 			break;
 		case SCSI_DISK0_MAJOR:
+		case SCSI_DISK1_MAJOR:
+		case SCSI_DISK2_MAJOR:
+		case SCSI_DISK3_MAJOR:
+		case SCSI_DISK4_MAJOR:
+		case SCSI_DISK5_MAJOR:
+		case SCSI_DISK6_MAJOR:
+		case SCSI_DISK7_MAJOR:
 			index = (minor & 0x00f0) >> 4;
 			break;
 		case IDE0_MAJOR:	/* same as HD_MAJOR */
+		case IDE1_MAJOR:
+		case IDE2_MAJOR:
+		case IDE3_MAJOR:
+		case IDE4_MAJOR:
+		case IDE5_MAJOR:
+		case IDE6_MAJOR:
+		case IDE7_MAJOR:
+		case IDE8_MAJOR:
+		case IDE9_MAJOR:
 		case XT_DISK_MAJOR:
 			index = (minor & 0x0040) >> 6;
-			break;
-		case IDE1_MAJOR:
-			index = ((minor & 0x0040) >> 6) + 2;
 			break;
 		default:
 			return 0;


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
