Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129661AbRBFVew>; Tue, 6 Feb 2001 16:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRBFVen>; Tue, 6 Feb 2001 16:34:43 -0500
Received: from smtp5.us.dell.com ([143.166.83.100]:43786 "EHLO
	smtp5.us.dell.com") by vger.kernel.org with ESMTP
	id <S129661AbRBFVe0>; Tue, 6 Feb 2001 16:34:26 -0500
Date: Tue, 6 Feb 2001 15:34:10 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: <linux-kernel@vger.kernel.org>
cc: "Domsch, Matt" <Matt_Domsch@dell.com>
Subject: [RFC][PATCH] block ioctl to read/write last sector
Message-ID: <Pine.LNX.4.30.0102061520480.26194-200000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1500554619-978057057-981495250=:26194"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1500554619-978057057-981495250=:26194
Content-Type: TEXT/PLAIN; charset=US-ASCII


Problem Summary:
  There is no function exported to userspace to read or write the last
512-byte sector of an odd-size disk.

  The block device uses 1K blocksize, and will prevent userspace from
seeing the odd-block at the end of the disk, if the disk is odd-size.

  IA-64 architecture defines a new partitioning scheme where there is a
backup of the partition table header in the last sector of the disk. While
we can read and write to this sector in the kernel partition code, we have
no way for userspace to update this partition block.

Solution:
  As an interim solution, I propose the following IOCTLs for the block
device layer: BLKGETLASTSECT and BLKSETLASTSECT.  These ioctls will take a
userspace pointer to a char[512] and read/write the last sector. Below is
a patch to do this.

I have attached the patch as well, because I've heard that Pine will eat
patches. :-(

--
Michael Brown
Linux System Group
Dell Computer Corp


diff -ruP linux/drivers/block/blkpg.c linux-meb-clean/drivers/block/blkpg.c
--- linux/drivers/block/blkpg.c	Fri Oct 27 01:35:47 2000
+++ linux-meb-clean/drivers/block/blkpg.c	Mon Jan 22 10:00:04 2001
@@ -39,6 +39,9 @@

 #include <asm/uaccess.h>

+static int set_last_sector( kdev_t dev, char *sect );
+static int get_last_sector( kdev_t dev, char *sect );
+
 /*
  * What is the data describing a partition?
  *
@@ -208,8 +211,19 @@
 int blk_ioctl(kdev_t dev, unsigned int cmd, unsigned long arg)
 {
 	int intval;
+        unsigned long longval;

 	switch (cmd) {
+		case BLKGETLASTSECT:
+			return get_last_sector(dev, (char *)(arg));
+
+		case BLKSETLASTSECT:
+			if( is_read_only(dev) )
+				return -EACCES;
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+			return set_last_sector(dev, (char *)(arg));
+
 		case BLKROSET:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
@@ -281,3 +295,140 @@
 }

 EXPORT_SYMBOL(blk_ioctl);
+
+ /*********************
+  * get_last_sector()
+  *
+  * Description: This function will return the first 512 bytes of the last sector of
+  *    a block device.
+  * Why: Normal read/write calls through the block layer will not read the last sector
+  *    of an odd-size disk.
+  * parameters:
+  *    dev: a kdev_t that represents the device for which we want the last sector
+  *    sect: a userspace pointer, should be at least char[512] to hold the last sector contents
+  * return:
+  *    0 on success
+  *   -ERRVAL on error.
+  *********************/
+int get_last_sector( kdev_t dev, char *sect )
+{
+        struct buffer_head *bh;
+        struct gendisk *g;
+        int m, rc = 0;
+        unsigned int lba;
+        int orig_blksize = BLOCK_SIZE;
+        int hardblocksize;
+
+        if( !dev ) return -EINVAL;
+
+        m = MAJOR(dev);
+        for (g = gendisk_head; g; g = g->next)
+                if (g->major == m)
+                        break;
+
+        if( !g ) return -EINVAL;
+
+        lba = g->part[MINOR(dev)].nr_sects - 1;
+
+        if( !lba ) return -EINVAL;
+
+        hardblocksize = get_hardblocksize(dev);
+        if( ! hardblocksize ) hardblocksize = 512;
+
+         /* Need to change the block size that the block layer uses */
+        if (blksize_size[MAJOR(dev)]){
+                orig_blksize = blksize_size[MAJOR(dev)][MINOR(dev)];
+        }
+        if (orig_blksize != hardblocksize)
+                   set_blocksize(dev, hardblocksize);
+
+        bh =  bread(dev, lba, hardblocksize);
+        if (!bh) {
+                       /* We hit the end of the disk */
+                       printk(KERN_WARNING
+                              "get_last_sector ioctl: bread returned NULL.\n");
+                       return -1;
+        }
+
+        rc = copy_to_user(sect, bh->b_data, (bh->b_size > 512) ? 512 : bh->b_size );
+
+        brelse(bh);
+
+        /* change block size back */
+        if (orig_blksize != hardblocksize)
+                   set_blocksize(dev, orig_blksize);
+
+        return rc;
+}
+
+
+ /*********************
+  * set_last_sector()
+  *
+  * Description: This function will write the first 512 bytes of the last sector of
+  *    a block device.
+  * Why: Normal read/write calls through the block layer will not read the last sector
+  *    of an odd-size disk.
+  * parameters:
+  *    dev: a kdev_t that represents the device for which we want the last sector
+  *    sect: a userspace pointer, should be at least char[512] to hold the last sector contents
+  * return:
+  *    0 on success
+  *   -ERRVAL on error.
+  *********************/
+int set_last_sector( kdev_t dev, char *sect )
+{
+        struct buffer_head *bh;
+        struct gendisk *g;
+        int m, rc = 0;
+        unsigned int lba;
+        int orig_blksize = BLOCK_SIZE;
+        int hardblocksize;
+
+        if( !dev ) return -EINVAL;
+
+        m = MAJOR(dev);
+        for (g = gendisk_head; g; g = g->next)
+                    if (g->major == m)
+                            break;
+
+        if( !g ) return -EINVAL;
+
+        lba = g->part[MINOR(dev)].nr_sects - 1;
+
+        if( !lba ) return -EINVAL;
+
+        hardblocksize = get_hardblocksize(dev);
+        if( ! hardblocksize ) hardblocksize = 512;
+
+         /* Need to change the block size that the block layer uses */
+        if (blksize_size[MAJOR(dev)]){
+                orig_blksize = blksize_size[MAJOR(dev)][MINOR(dev)];
+        }
+        if (orig_blksize != hardblocksize)
+                 set_blocksize(dev, hardblocksize);
+
+        bh =  getblk(dev, lba, hardblocksize);
+        if (!bh) {
+                         /* We hit the end of the disk */
+                         printk(KERN_WARNING
+                                "get_last_sector ioctl: getblk returned NULL.\n");
+                         return -1;
+        }
+
+        copy_from_user(bh->b_data, sect, (bh->b_size > 512) ? 512 : bh->b_size);
+
+        mark_buffer_dirty(bh);
+        ll_rw_block (WRITE, 1, &bh);
+        wait_on_buffer (bh);
+        if (!buffer_uptodate(bh))
+          rc=-1;
+
+        brelse(bh);
+
+        /* change block size back */
+        if (orig_blksize != hardblocksize)
+                 set_blocksize(dev, orig_blksize);
+
+       return rc;
+}
diff -ruP linux/drivers/ide/ide.c linux-meb-clean/drivers/ide/ide.c
--- linux/drivers/ide/ide.c	Wed Dec  6 14:06:19 2000
+++ linux-meb-clean/drivers/ide/ide.c	Fri Jan 19 16:18:51 2001
@@ -2665,6 +2665,8 @@
 			}
 			return 0;

+		case BLKGETLASTSECT:
+		case BLKSETLASTSECT:
 		case BLKROSET:
 		case BLKROGET:
 		case BLKFLSBUF:
diff -ruP linux/drivers/scsi/sd.c linux-meb-clean/drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c	Fri Oct 27 01:35:48 2000
+++ linux-meb-clean/drivers/scsi/sd.c	Fri Jan 19 11:13:03 2001
@@ -225,6 +225,8 @@
 				return -EINVAL;
 			return put_user(sd[SD_PARTITION(inode->i_rdev)].nr_sects, (long *) arg);

+		case BLKGETLASTSECT:
+		case BLKSETLASTSECT:
 		case BLKROSET:
 		case BLKROGET:
 		case BLKRASET:
diff -ruP linux/include/linux/fs.h linux-meb-clean/include/linux/fs.h
--- linux/include/linux/fs.h	Thu Jan  4 16:50:47 2001
+++ linux-meb-clean/include/linux/fs.h	Fri Jan 19 22:23:48 2001
@@ -180,6 +180,8 @@
 /* This was here just to show that the number is taken -
    probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
 #endif
+#define BLKGETLASTSECT  _IO(0x12,108) /* get last sector of block device */
+#define BLKSETLASTSECT  _IO(0x12,109) /* get last sector of block device */


 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */

---1500554619-978057057-981495250=:26194
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch-getlastsector-20010122
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0102061534100.26194@blap.linuxdev.us.dell.com>
Content-Description: 
Content-Disposition: attachment; filename=patch-getlastsector-20010122

ZGlmZiAtcnVQIGxpbnV4L2RyaXZlcnMvYmxvY2svYmxrcGcuYyBsaW51eC1t
ZWItY2xlYW4vZHJpdmVycy9ibG9jay9ibGtwZy5jDQotLS0gbGludXgvZHJp
dmVycy9ibG9jay9ibGtwZy5jCUZyaSBPY3QgMjcgMDE6MzU6NDcgMjAwMA0K
KysrIGxpbnV4LW1lYi1jbGVhbi9kcml2ZXJzL2Jsb2NrL2Jsa3BnLmMJTW9u
IEphbiAyMiAxMDowMDowNCAyMDAxDQpAQCAtMzksNiArMzksOSBAQA0KIA0K
ICNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPg0KIA0KK3N0YXRpYyBpbnQgc2V0
X2xhc3Rfc2VjdG9yKCBrZGV2X3QgZGV2LCBjaGFyICpzZWN0ICk7DQorc3Rh
dGljIGludCBnZXRfbGFzdF9zZWN0b3IoIGtkZXZfdCBkZXYsIGNoYXIgKnNl
Y3QgKTsNCisNCiAvKg0KICAqIFdoYXQgaXMgdGhlIGRhdGEgZGVzY3JpYmlu
ZyBhIHBhcnRpdGlvbj8NCiAgKg0KQEAgLTIwOCw4ICsyMTEsMTkgQEANCiBp
bnQgYmxrX2lvY3RsKGtkZXZfdCBkZXYsIHVuc2lnbmVkIGludCBjbWQsIHVu
c2lnbmVkIGxvbmcgYXJnKQ0KIHsNCiAJaW50IGludHZhbDsNCisgICAgICAg
IHVuc2lnbmVkIGxvbmcgbG9uZ3ZhbDsNCiANCiAJc3dpdGNoIChjbWQpIHsN
CisJCWNhc2UgQkxLR0VUTEFTVFNFQ1Q6DQorCQkJcmV0dXJuIGdldF9sYXN0
X3NlY3RvcihkZXYsIChjaGFyICopKGFyZykpOw0KKw0KKwkJY2FzZSBCTEtT
RVRMQVNUU0VDVDoNCisJCQlpZiggaXNfcmVhZF9vbmx5KGRldikgKQ0KKwkJ
CQlyZXR1cm4gLUVBQ0NFUzsNCisJCQlpZiAoIWNhcGFibGUoQ0FQX1NZU19B
RE1JTikpDQorCQkJCXJldHVybiAtRUFDQ0VTOw0KKwkJCXJldHVybiBzZXRf
bGFzdF9zZWN0b3IoZGV2LCAoY2hhciAqKShhcmcpKTsNCisNCiAJCWNhc2Ug
QkxLUk9TRVQ6DQogCQkJaWYgKCFjYXBhYmxlKENBUF9TWVNfQURNSU4pKQ0K
IAkJCQlyZXR1cm4gLUVBQ0NFUzsNCkBAIC0yODEsMyArMjk1LDE0MCBAQA0K
IH0NCiANCiBFWFBPUlRfU1lNQk9MKGJsa19pb2N0bCk7DQorDQorIC8qKioq
KioqKioqKioqKioqKioqKioNCisgICogZ2V0X2xhc3Rfc2VjdG9yKCkNCisg
ICogIA0KKyAgKiBEZXNjcmlwdGlvbjogVGhpcyBmdW5jdGlvbiB3aWxsIHJl
dHVybiB0aGUgZmlyc3QgNTEyIGJ5dGVzIG9mIHRoZSBsYXN0IHNlY3RvciBv
ZiANCisgICogICAgYSBibG9jayBkZXZpY2UuDQorICAqIFdoeTogTm9ybWFs
IHJlYWQvd3JpdGUgY2FsbHMgdGhyb3VnaCB0aGUgYmxvY2sgbGF5ZXIgd2ls
bCBub3QgcmVhZCB0aGUgbGFzdCBzZWN0b3IgDQorICAqICAgIG9mIGFuIG9k
ZC1zaXplIGRpc2suIA0KKyAgKiBwYXJhbWV0ZXJzOiANCisgICogICAgZGV2
OiBhIGtkZXZfdCB0aGF0IHJlcHJlc2VudHMgdGhlIGRldmljZSBmb3Igd2hp
Y2ggd2Ugd2FudCB0aGUgbGFzdCBzZWN0b3INCisgICogICAgc2VjdDogYSB1
c2Vyc3BhY2UgcG9pbnRlciwgc2hvdWxkIGJlIGF0IGxlYXN0IGNoYXJbNTEy
XSB0byBob2xkIHRoZSBsYXN0IHNlY3RvciBjb250ZW50cw0KKyAgKiByZXR1
cm46IA0KKyAgKiAgICAwIG9uIHN1Y2Nlc3MNCisgICogICAtRVJSVkFMIG9u
IGVycm9yLg0KKyAgKioqKioqKioqKioqKioqKioqKioqLw0KK2ludCBnZXRf
bGFzdF9zZWN0b3IoIGtkZXZfdCBkZXYsIGNoYXIgKnNlY3QgKQ0KK3sgICAN
CisgICAgICAgIHN0cnVjdCBidWZmZXJfaGVhZCAqYmg7DQorICAgICAgICBz
dHJ1Y3QgZ2VuZGlzayAqZzsNCisgICAgICAgIGludCBtLCByYyA9IDA7DQor
ICAgICAgICB1bnNpZ25lZCBpbnQgbGJhOw0KKyAgICAgICAgaW50IG9yaWdf
Ymxrc2l6ZSA9IEJMT0NLX1NJWkU7DQorICAgICAgICBpbnQgaGFyZGJsb2Nr
c2l6ZTsNCisNCisgICAgICAgIGlmKCAhZGV2ICkgcmV0dXJuIC1FSU5WQUw7
DQorDQorICAgICAgICBtID0gTUFKT1IoZGV2KTsNCisgICAgICAgIGZvciAo
ZyA9IGdlbmRpc2tfaGVhZDsgZzsgZyA9IGctPm5leHQpDQorICAgICAgICAg
ICAgICAgIGlmIChnLT5tYWpvciA9PSBtKQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KKw0KKyAgICAgICAgaWYoICFnICkgcmV0dXJuIC1F
SU5WQUw7DQorDQorICAgICAgICBsYmEgPSBnLT5wYXJ0W01JTk9SKGRldild
Lm5yX3NlY3RzIC0gMTsNCisNCisgICAgICAgIGlmKCAhbGJhICkgcmV0dXJu
IC1FSU5WQUw7DQorDQorICAgICAgICBoYXJkYmxvY2tzaXplID0gZ2V0X2hh
cmRibG9ja3NpemUoZGV2KTsNCisgICAgICAgIGlmKCAhIGhhcmRibG9ja3Np
emUgKSBoYXJkYmxvY2tzaXplID0gNTEyOw0KKw0KKyAgICAgICAgIC8qIE5l
ZWQgdG8gY2hhbmdlIHRoZSBibG9jayBzaXplIHRoYXQgdGhlIGJsb2NrIGxh
eWVyIHVzZXMgKi8NCisgICAgICAgIGlmIChibGtzaXplX3NpemVbTUFKT1Io
ZGV2KV0pew0KKyAgICAgICAgICAgICAgICBvcmlnX2Jsa3NpemUgPSBibGtz
aXplX3NpemVbTUFKT1IoZGV2KV1bTUlOT1IoZGV2KV07DQorICAgICAgICB9
DQorICAgICAgICBpZiAob3JpZ19ibGtzaXplICE9IGhhcmRibG9ja3NpemUp
DQorICAgICAgICAgICAgICAgICAgIHNldF9ibG9ja3NpemUoZGV2LCBoYXJk
YmxvY2tzaXplKTsNCisNCisgICAgICAgIGJoID0gIGJyZWFkKGRldiwgbGJh
LCBoYXJkYmxvY2tzaXplKTsNCisgICAgICAgIGlmICghYmgpIHsNCisgICAg
ICAgICAgICAgICAgICAgICAgIC8qIFdlIGhpdCB0aGUgZW5kIG9mIHRoZSBk
aXNrICovDQorICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoS0VSTl9X
QVJOSU5HDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImdldF9s
YXN0X3NlY3RvciBpb2N0bDogYnJlYWQgcmV0dXJuZWQgTlVMTC5cbiIpOw0K
KyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KKyAgICAgICAg
fQ0KKw0KKyAgICAgICAgcmMgPSBjb3B5X3RvX3VzZXIoc2VjdCwgYmgtPmJf
ZGF0YSwgKGJoLT5iX3NpemUgPiA1MTIpID8gNTEyIDogYmgtPmJfc2l6ZSAp
Ow0KKw0KKyAgICAgICAgYnJlbHNlKGJoKTsNCisNCisgICAgICAgIC8qIGNo
YW5nZSBibG9jayBzaXplIGJhY2sgKi8NCisgICAgICAgIGlmIChvcmlnX2Js
a3NpemUgIT0gaGFyZGJsb2Nrc2l6ZSkNCisgICAgICAgICAgICAgICAgICAg
c2V0X2Jsb2Nrc2l6ZShkZXYsIG9yaWdfYmxrc2l6ZSk7DQorICAgDQorICAg
ICAgICByZXR1cm4gcmM7DQorfQ0KKw0KKw0KKyAvKioqKioqKioqKioqKioq
KioqKioqDQorICAqIHNldF9sYXN0X3NlY3RvcigpDQorICAqICANCisgICog
RGVzY3JpcHRpb246IFRoaXMgZnVuY3Rpb24gd2lsbCB3cml0ZSB0aGUgZmly
c3QgNTEyIGJ5dGVzIG9mIHRoZSBsYXN0IHNlY3RvciBvZiANCisgICogICAg
YSBibG9jayBkZXZpY2UuDQorICAqIFdoeTogTm9ybWFsIHJlYWQvd3JpdGUg
Y2FsbHMgdGhyb3VnaCB0aGUgYmxvY2sgbGF5ZXIgd2lsbCBub3QgcmVhZCB0
aGUgbGFzdCBzZWN0b3IgDQorICAqICAgIG9mIGFuIG9kZC1zaXplIGRpc2su
IA0KKyAgKiBwYXJhbWV0ZXJzOiANCisgICogICAgZGV2OiBhIGtkZXZfdCB0
aGF0IHJlcHJlc2VudHMgdGhlIGRldmljZSBmb3Igd2hpY2ggd2Ugd2FudCB0
aGUgbGFzdCBzZWN0b3INCisgICogICAgc2VjdDogYSB1c2Vyc3BhY2UgcG9p
bnRlciwgc2hvdWxkIGJlIGF0IGxlYXN0IGNoYXJbNTEyXSB0byBob2xkIHRo
ZSBsYXN0IHNlY3RvciBjb250ZW50cw0KKyAgKiByZXR1cm46IA0KKyAgKiAg
ICAwIG9uIHN1Y2Nlc3MNCisgICogICAtRVJSVkFMIG9uIGVycm9yLg0KKyAg
KioqKioqKioqKioqKioqKioqKioqLw0KK2ludCBzZXRfbGFzdF9zZWN0b3Io
IGtkZXZfdCBkZXYsIGNoYXIgKnNlY3QgKSANCit7DQorICAgICAgICBzdHJ1
Y3QgYnVmZmVyX2hlYWQgKmJoOw0KKyAgICAgICAgc3RydWN0IGdlbmRpc2sg
Kmc7DQorICAgICAgICBpbnQgbSwgcmMgPSAwOw0KKyAgICAgICAgdW5zaWdu
ZWQgaW50IGxiYTsNCisgICAgICAgIGludCBvcmlnX2Jsa3NpemUgPSBCTE9D
S19TSVpFOw0KKyAgICAgICAgaW50IGhhcmRibG9ja3NpemU7DQorDQorICAg
ICAgICBpZiggIWRldiApIHJldHVybiAtRUlOVkFMOw0KKw0KKyAgICAgICAg
bSA9IE1BSk9SKGRldik7DQorICAgICAgICBmb3IgKGcgPSBnZW5kaXNrX2hl
YWQ7IGc7IGcgPSBnLT5uZXh0KQ0KKyAgICAgICAgICAgICAgICAgICAgaWYg
KGctPm1ham9yID09IG0pDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KKw0KKyAgICAgICAgaWYoICFnICkgcmV0dXJuIC1FSU5WQUw7
DQorICAgIA0KKyAgICAgICAgbGJhID0gZy0+cGFydFtNSU5PUihkZXYpXS5u
cl9zZWN0cyAtIDE7DQorICAgIA0KKyAgICAgICAgaWYoICFsYmEgKSByZXR1
cm4gLUVJTlZBTDsNCisgICAgDQorICAgICAgICBoYXJkYmxvY2tzaXplID0g
Z2V0X2hhcmRibG9ja3NpemUoZGV2KTsNCisgICAgICAgIGlmKCAhIGhhcmRi
bG9ja3NpemUgKSBoYXJkYmxvY2tzaXplID0gNTEyOw0KKyAgICANCisgICAg
ICAgICAvKiBOZWVkIHRvIGNoYW5nZSB0aGUgYmxvY2sgc2l6ZSB0aGF0IHRo
ZSBibG9jayBsYXllciB1c2VzICovDQorICAgICAgICBpZiAoYmxrc2l6ZV9z
aXplW01BSk9SKGRldildKXsNCisgICAgICAgICAgICAgICAgb3JpZ19ibGtz
aXplID0gYmxrc2l6ZV9zaXplW01BSk9SKGRldildW01JTk9SKGRldildOw0K
KyAgICAgICAgfQ0KKyAgICAgICAgaWYgKG9yaWdfYmxrc2l6ZSAhPSBoYXJk
YmxvY2tzaXplKQ0KKyAgICAgICAgICAgICAgICAgc2V0X2Jsb2Nrc2l6ZShk
ZXYsIGhhcmRibG9ja3NpemUpOw0KKyAgICANCisgICAgICAgIGJoID0gIGdl
dGJsayhkZXYsIGxiYSwgaGFyZGJsb2Nrc2l6ZSk7DQorICAgICAgICBpZiAo
IWJoKSB7DQorICAgICAgICAgICAgICAgICAgICAgICAgIC8qIFdlIGhpdCB0
aGUgZW5kIG9mIHRoZSBkaXNrICovDQorICAgICAgICAgICAgICAgICAgICAg
ICAgIHByaW50ayhLRVJOX1dBUk5JTkcNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJnZXRfbGFzdF9zZWN0b3IgaW9jdGw6IGdldGJsayBy
ZXR1cm5lZCBOVUxMLlxuIik7DQorICAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtMTsNCisgICAgICAgIH0NCisgICAgDQorICAgICAgICBjb3B5
X2Zyb21fdXNlcihiaC0+Yl9kYXRhLCBzZWN0LCAoYmgtPmJfc2l6ZSA+IDUx
MikgPyA1MTIgOiBiaC0+Yl9zaXplKTsNCisgICAgDQorICAgICAgICBtYXJr
X2J1ZmZlcl9kaXJ0eShiaCk7DQorICAgICAgICBsbF9yd19ibG9jayAoV1JJ
VEUsIDEsICZiaCk7DQorICAgICAgICB3YWl0X29uX2J1ZmZlciAoYmgpOw0K
KyAgICAgICAgaWYgKCFidWZmZXJfdXB0b2RhdGUoYmgpKQ0KKyAgICAgICAg
ICByYz0tMTsgDQorICAgIA0KKyAgICAgICAgYnJlbHNlKGJoKTsNCisgICAg
DQorICAgICAgICAvKiBjaGFuZ2UgYmxvY2sgc2l6ZSBiYWNrICovDQorICAg
ICAgICBpZiAob3JpZ19ibGtzaXplICE9IGhhcmRibG9ja3NpemUpDQorICAg
ICAgICAgICAgICAgICBzZXRfYmxvY2tzaXplKGRldiwgb3JpZ19ibGtzaXpl
KTsNCisgICAgICAgDQorICAgICAgIHJldHVybiByYzsNCit9DQpkaWZmIC1y
dVAgbGludXgvZHJpdmVycy9pZGUvaWRlLmMgbGludXgtbWViLWNsZWFuL2Ry
aXZlcnMvaWRlL2lkZS5jDQotLS0gbGludXgvZHJpdmVycy9pZGUvaWRlLmMJ
V2VkIERlYyAgNiAxNDowNjoxOSAyMDAwDQorKysgbGludXgtbWViLWNsZWFu
L2RyaXZlcnMvaWRlL2lkZS5jCUZyaSBKYW4gMTkgMTY6MTg6NTEgMjAwMQ0K
QEAgLTI2NjUsNiArMjY2NSw4IEBADQogCQkJfQ0KIAkJCXJldHVybiAwOw0K
IA0KKwkJY2FzZSBCTEtHRVRMQVNUU0VDVDoNCisJCWNhc2UgQkxLU0VUTEFT
VFNFQ1Q6DQogCQljYXNlIEJMS1JPU0VUOg0KIAkJY2FzZSBCTEtST0dFVDoN
CiAJCWNhc2UgQkxLRkxTQlVGOg0KZGlmZiAtcnVQIGxpbnV4L2RyaXZlcnMv
c2NzaS9zZC5jIGxpbnV4LW1lYi1jbGVhbi9kcml2ZXJzL3Njc2kvc2QuYw0K
LS0tIGxpbnV4L2RyaXZlcnMvc2NzaS9zZC5jCUZyaSBPY3QgMjcgMDE6MzU6
NDggMjAwMA0KKysrIGxpbnV4LW1lYi1jbGVhbi9kcml2ZXJzL3Njc2kvc2Qu
YwlGcmkgSmFuIDE5IDExOjEzOjAzIDIwMDENCkBAIC0yMjUsNiArMjI1LDgg
QEANCiAJCQkJcmV0dXJuIC1FSU5WQUw7DQogCQkJcmV0dXJuIHB1dF91c2Vy
KHNkW1NEX1BBUlRJVElPTihpbm9kZS0+aV9yZGV2KV0ubnJfc2VjdHMsIChs
b25nICopIGFyZyk7DQogDQorCQljYXNlIEJMS0dFVExBU1RTRUNUOg0KKwkJ
Y2FzZSBCTEtTRVRMQVNUU0VDVDoNCiAJCWNhc2UgQkxLUk9TRVQ6DQogCQlj
YXNlIEJMS1JPR0VUOg0KIAkJY2FzZSBCTEtSQVNFVDoNCmRpZmYgLXJ1UCBs
aW51eC9pbmNsdWRlL2xpbnV4L2ZzLmggbGludXgtbWViLWNsZWFuL2luY2x1
ZGUvbGludXgvZnMuaA0KLS0tIGxpbnV4L2luY2x1ZGUvbGludXgvZnMuaAlU
aHUgSmFuICA0IDE2OjUwOjQ3IDIwMDENCisrKyBsaW51eC1tZWItY2xlYW4v
aW5jbHVkZS9saW51eC9mcy5oCUZyaSBKYW4gMTkgMjI6MjM6NDggMjAwMQ0K
QEAgLTE4MCw2ICsxODAsOCBAQA0KIC8qIFRoaXMgd2FzIGhlcmUganVzdCB0
byBzaG93IHRoYXQgdGhlIG51bWJlciBpcyB0YWtlbiAtDQogICAgcHJvYmFi
bHkgYWxsIHRoZXNlIF9JTygweDEyLCopIGlvY3RscyBzaG91bGQgYmUgbW92
ZWQgdG8gYmxrcGcuaC4gKi8NCiAjZW5kaWYNCisjZGVmaW5lIEJMS0dFVExB
U1RTRUNUICBfSU8oMHgxMiwxMDgpIC8qIGdldCBsYXN0IHNlY3RvciBvZiBi
bG9jayBkZXZpY2UgKi8NCisjZGVmaW5lIEJMS1NFVExBU1RTRUNUICBfSU8o
MHgxMiwxMDkpIC8qIGdldCBsYXN0IHNlY3RvciBvZiBibG9jayBkZXZpY2Ug
Ki8NCiANCiANCiAjZGVmaW5lIEJNQVBfSU9DVEwgMQkJLyogb2Jzb2xldGUg
LSBrZXB0IGZvciBjb21wYXRpYmlsaXR5ICovDQo=
---1500554619-978057057-981495250=:26194--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
