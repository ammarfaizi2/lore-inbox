Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQLFAqO>; Tue, 5 Dec 2000 19:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129521AbQLFAqF>; Tue, 5 Dec 2000 19:46:05 -0500
Received: from nread2.inwind.it ([212.141.53.75]:58519 "EHLO relay4.inwind.it")
	by vger.kernel.org with ESMTP id <S129764AbQLFApv>;
	Tue, 5 Dec 2000 19:45:51 -0500
From: Roberto Ragusa <robertoragusa@technologist.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Date: Wed, 06 Dec 2000 01:08:27 +0200
Message-ID: <yam8375.1358.149393648@a4000>
In-Reply-To: <14893.25967.936504.881427@notabene.cse.unsw.edu.au>
X-Mailer: YAM 2.1 [060] AmigaOS E-Mail Client (c) 1995-2000 by Marcel Beck  http://www.yam.ch
Subject: Re: kernel panic in SoftwareRAID autodetection
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Dec-00, Neil Brown wrote:

> The following patch isn't *correct*, but if it makes a difference for
> you, then it means that we have found the problem.. please let me
> know.
[one line patch]

Yes, it makes a difference :-) . The boot doesn't fail anymore and
all the RAID partitions are correctly detected.

BTW, here is a little patch regarding a silly problem I found
about RAID partitions naming (/proc/partitions).
No more "md8" "md9" "md:" "md;" ... but "md8" "md9" "md10" "md11" ...
Well, this patch should work up to "md99".

--- fs/partitions/check.c    Thu Nov  2 12:22:50 2000
+++ fs/partitions/check.c    Wed Dec  6 00:34:46 2000
@@ -121,10 +121,17 @@
 			unit += 2;
 		case IDE0_MAJOR:
 			maj = "hd";
-			break;
-		case MD_MAJOR:
-			unit -= 'a'-'0';
-			break;
+	}
+	if (hd->major == MD_MAJOR) {
+		unit -= 'a';
+		if (unit<10) {
+			sprintf(buf, "%s%c", maj, '0' + unit);
+			return buf;
+		}
+		else {
+			sprintf(buf, "%s%c%c", maj, '0' + unit / 10, '0' + unit % 10);
+			return buf;
+		}
 	}
 	if (hd->major >= SCSI_DISK1_MAJOR && hd->major <= SCSI_DISK7_MAJOR) {
 		unit = unit + (hd->major - SCSI_DISK1_MAJOR + 1) * 16;


For 2.2.x kernels, the file to be patched is drivers/block/genhd.c.

>> Please CC to me because I'm not a LKML subscriber.
> 
> Ofcourse.  I think it is common courtesy to reply to the author, and
> cc to the list if appropriate.

OK.

-- 
       Roberto Ragusa   robertoragusa at technologist.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
