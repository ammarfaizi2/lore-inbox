Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUDFVEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264014AbUDFVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:04:09 -0400
Received: from atlas.pnl.gov ([130.20.248.194]:11462 "EHLO atlas.pnl.gov")
	by vger.kernel.org with ESMTP id S264016AbUDFVAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:00:44 -0400
Date: Tue, 06 Apr 2004 14:00:40 -0700
From: Evan Felix <evan.felix@pnl.gov>
Subject: [PATCH] Linux Raid5/6 abover 2 Terabytes
To: linux-raid <linux-raid@vger.kernel.org>, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Message-id: <1081285240.2219.43.camel@e-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: multipart/mixed; boundary="=-cvR/jb5B1E4Y7CSV/Pgw"
X-OriginalArrivalTime: 06 Apr 2004 21:00:40.0570 (UTC)
 FILETIME=[37E505A0:01C41C1A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cvR/jb5B1E4Y7CSV/Pgw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a patch that fixes a major issue in the raid5/6 code.  It seems
that the code:

logical_sector = bi->bi_sector & ~(STRIPE_SECTORS-1);
(sector_t)     = (sector_t)    & (constant)

that the right side of the & does not get extended correctly when the
constant is promoted to the sector_t type.  I have CONFIG_LBD turned on
so sector_t should be 64bits wide.  This fails to properly mask the
value of 4294967296 (2TB/512) to 4294967296.  in my case it was coming
out 0.  this cause the loop following this code to read from 0 to
4294967296 blocks so it could write one character.

As you might imagine this makes a format of a 3.5TB filesystem take a
very long time.

Here is the patch:
Binary files linux-2.6.5/drivers/md/mktables and
linux-2.6.5fixraid/drivers/md/mktables differ
diff -urN -X /home/efelix/.cvsignore linux-2.6.5/drivers/md/raid5.c
linux-2.6.5fixraid/drivers/md/raid5.c
--- linux-2.6.5/drivers/md/raid5.c	2004-04-04 03:36:26.000000000 +0000
+++ linux-2.6.5fixraid/drivers/md/raid5.c	2004-04-06 18:26:05.000000000
+0000
@@ -1334,8 +1334,9 @@
 		disk_stat_add(mddev->gendisk, read_sectors, bio_sectors(bi));
 	}

-	logical_sector = bi->bi_sector & ~(STRIPE_SECTORS-1);
+	logical_sector = bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
 	last_sector = bi->bi_sector + (bi->bi_size>>9);
+	PRINTK("Bio: %Lu logical %Lu   last
%Lu\n",bi->bi_sector,logical_sector,last_sector);
 
 	bi->bi_next = NULL;
 	bi->bi_phys_segments = 1;	/* over-loaded to count active stripes */
diff -urN -X /home/efelix/.cvsignore linux-2.6.5/drivers/md/raid6main.c
linux-2.6.5fixraid/drivers/md/raid6main.c
--- linux-2.6.5/drivers/md/raid6main.c	2004-04-04 03:36:14.000000000
+0000
+++ linux-2.6.5fixraid/drivers/md/raid6main.c	2004-04-06
18:31:30.000000000 +0000
@@ -1496,7 +1496,7 @@
 		disk_stat_add(mddev->gendisk, read_sectors, bio_sectors(bi));
 	}
 
-	logical_sector = bi->bi_sector & ~(STRIPE_SECTORS-1);
+	logical_sector = bi->bi_sector & ~((sector_t)STRIPE_SECTORS-1);
 	last_sector = bi->bi_sector + (bi->bi_size>>9);
 
 	bi->bi_next = NULL;


I have tested this on at least 2 arrays, with ext2 and some long dd's

Evan
-- 
-------------------------
Evan Felix
Administrator of Supercomputer #5 in Top 500, Nov 2003
Environmental Molecular Sciences Laboratory
Pacific Northwest National Laboratory
Operated for the U.S. DOE by Battelle

--=-cvR/jb5B1E4Y7CSV/Pgw
Content-Disposition: attachment; filename=fix_block_mask.patch
Content-Type: text/x-patch; name=fix_block_mask.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64

QmluYXJ5IGZpbGVzIGxpbnV4LTIuNi41L2RyaXZlcnMvbWQvbWt0YWJsZXMgYW5kIGxpbnV4LTIu
Ni41Zml4cmFpZC9kcml2ZXJzL21kL21rdGFibGVzIGRpZmZlcg0KZGlmZiAtdXJOIC1YIC9ob21l
L2VmZWxpeC8uY3ZzaWdub3JlIGxpbnV4LTIuNi41L2RyaXZlcnMvbWQvcmFpZDUuYyBsaW51eC0y
LjYuNWZpeHJhaWQvZHJpdmVycy9tZC9yYWlkNS5jDQotLS0gbGludXgtMi42LjUvZHJpdmVycy9t
ZC9yYWlkNS5jCTIwMDQtMDQtMDQgMDM6MzY6MjYuMDAwMDAwMDAwICswMDAwDQorKysgbGludXgt
Mi42LjVmaXhyYWlkL2RyaXZlcnMvbWQvcmFpZDUuYwkyMDA0LTA0LTA2IDE4OjI2OjA1LjAwMDAw
MDAwMCArMDAwMA0KQEAgLTEzMzQsOCArMTMzNCw5IEBADQogCQlkaXNrX3N0YXRfYWRkKG1kZGV2
LT5nZW5kaXNrLCByZWFkX3NlY3RvcnMsIGJpb19zZWN0b3JzKGJpKSk7DQogCX0NCg0KLQlsb2dp
Y2FsX3NlY3RvciA9IGJpLT5iaV9zZWN0b3IgJiB+KFNUUklQRV9TRUNUT1JTLTEpOw0KKwlsb2dp
Y2FsX3NlY3RvciA9IGJpLT5iaV9zZWN0b3IgJiB+KChzZWN0b3JfdClTVFJJUEVfU0VDVE9SUy0x
KTsNCiAJbGFzdF9zZWN0b3IgPSBiaS0+Ymlfc2VjdG9yICsgKGJpLT5iaV9zaXplPj45KTsNCisJ
UFJJTlRLKCJCaW86ICVMdSBsb2dpY2FsICVMdSAgIGxhc3QgJUx1XG4iLGJpLT5iaV9zZWN0b3Is
bG9naWNhbF9zZWN0b3IsbGFzdF9zZWN0b3IpOw0KIA0KIAliaS0+YmlfbmV4dCA9IE5VTEw7DQog
CWJpLT5iaV9waHlzX3NlZ21lbnRzID0gMTsJLyogb3Zlci1sb2FkZWQgdG8gY291bnQgYWN0aXZl
IHN0cmlwZXMgKi8NCmRpZmYgLXVyTiAtWCAvaG9tZS9lZmVsaXgvLmN2c2lnbm9yZSBsaW51eC0y
LjYuNS9kcml2ZXJzL21kL3JhaWQ2bWFpbi5jIGxpbnV4LTIuNi41Zml4cmFpZC9kcml2ZXJzL21k
L3JhaWQ2bWFpbi5jDQotLS0gbGludXgtMi42LjUvZHJpdmVycy9tZC9yYWlkNm1haW4uYwkyMDA0
LTA0LTA0IDAzOjM2OjE0LjAwMDAwMDAwMCArMDAwMA0KKysrIGxpbnV4LTIuNi41Zml4cmFpZC9k
cml2ZXJzL21kL3JhaWQ2bWFpbi5jCTIwMDQtMDQtMDYgMTg6MzE6MzAuMDAwMDAwMDAwICswMDAw
DQpAQCAtMTQ5Niw3ICsxNDk2LDcgQEANCiAJCWRpc2tfc3RhdF9hZGQobWRkZXYtPmdlbmRpc2ss
IHJlYWRfc2VjdG9ycywgYmlvX3NlY3RvcnMoYmkpKTsNCiAJfQ0KIA0KLQlsb2dpY2FsX3NlY3Rv
ciA9IGJpLT5iaV9zZWN0b3IgJiB+KFNUUklQRV9TRUNUT1JTLTEpOw0KKwlsb2dpY2FsX3NlY3Rv
ciA9IGJpLT5iaV9zZWN0b3IgJiB+KChzZWN0b3JfdClTVFJJUEVfU0VDVE9SUy0xKTsNCiAJbGFz
dF9zZWN0b3IgPSBiaS0+Ymlfc2VjdG9yICsgKGJpLT5iaV9zaXplPj45KTsNCiANCiAJYmktPmJp
X25leHQgPSBOVUxMOw0K

--=-cvR/jb5B1E4Y7CSV/Pgw--
