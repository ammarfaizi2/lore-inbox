Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135373AbQLOAk6>; Thu, 14 Dec 2000 19:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135305AbQLOAkj>; Thu, 14 Dec 2000 19:40:39 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:18864 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S133105AbQLOAkh>; Thu, 14 Dec 2000 19:40:37 -0500
Date: Thu, 14 Dec 2000 19:09:30 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, chaffee@cs.berkeley.edu
Subject: PATCH: fix FAT32 filesystems on 64-bit platforms
Message-ID: <20001214190930.C12088@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	chaffee@cs.berkeley.edu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This fixes FAT32 on 64-bit platforms (notably, IA-64 and Alpha);
without this you can't mount any FAT32 filesystems. A similar patch
is already in 2.2.18.

Bill

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.0-test12-vfat.patch"

--- linux/fs/fat/cache.c.foo	Sat Nov 25 16:30:47 2000
+++ linux/fs/fat/cache.c	Sat Nov 25 16:32:29 2000
@@ -70,7 +70,7 @@
 	}
 	if (MSDOS_SB(sb)->fat_bits == 32) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
-		next = CF_LE_L(((unsigned long *) bh->b_data)[(first &
+		next = CF_LE_L(((__u32 *) bh->b_data)[(first &
 		    (SECTOR_SIZE-1)) >> 2]);
 		/* Fscking Microsoft marketing department. Their "32" is 28. */
 		next &= 0xfffffff;
@@ -79,12 +79,12 @@
 
 	} else if (MSDOS_SB(sb)->fat_bits == 16) {
 		p_first = p_last = NULL; /* GCC needs that stuff */
-		next = CF_LE_W(((unsigned short *) bh->b_data)[(first &
+		next = CF_LE_W(((__u16 *) bh->b_data)[(first &
 		    (SECTOR_SIZE-1)) >> 1]);
 		if (next >= 0xfff7) next = -1;
 	} else {
-		p_first = &((unsigned char *) bh->b_data)[first & (SECTOR_SIZE-1)];
-		p_last = &((unsigned char *) bh2->b_data)[(first+1) &
+		p_first = &((__u8 *) bh->b_data)[first & (SECTOR_SIZE-1)];
+		p_last = &((__u8 *) bh2->b_data)[(first+1) &
 		    (SECTOR_SIZE-1)];
 		if (nr & 1) next = ((*p_first >> 4) | (*p_last << 4)) & 0xfff;
 		else next = (*p_first+(*p_last << 8)) & 0xfff;
@@ -92,10 +92,10 @@
 	}
 	if (new_value != -1) {
 		if (MSDOS_SB(sb)->fat_bits == 32) {
-			((unsigned long *) bh->b_data)[(first & (SECTOR_SIZE-1)) >>
+			((__u32 *) bh->b_data)[(first & (SECTOR_SIZE-1)) >>
 			    2] = CT_LE_L(new_value);
 		} else if (MSDOS_SB(sb)->fat_bits == 16) {
-			((unsigned short *) bh->b_data)[(first & (SECTOR_SIZE-1)) >>
+			((__u16 *) bh->b_data)[(first & (SECTOR_SIZE-1)) >>
 			    1] = CT_LE_W(new_value);
 		} else {
 			if (nr & 1) {

--PEIAKu/WMn1b1Hv9--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
