Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUCXVPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUCXVPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:15:48 -0500
Received: from atlas.pnl.gov ([130.20.248.194]:12236 "EHLO atlas.pnl.gov")
	by vger.kernel.org with ESMTP id S261952AbUCXVNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:13:54 -0500
Date: Wed, 24 Mar 2004 13:14:48 -0800
From: Evan Felix <evan.felix@pnl.gov>
Subject: Re: Raid Array with 3.5Tb
In-reply-to: <16391.51319.698137.120756@notabene.cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Message-id: <1080162888.1936.15.camel@e-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5
Content-type: multipart/mixed; boundary="=-iBY+4KedhWG30LGeGEw/"
References: <1074196167.1382.8.camel@e-linux>
 <16391.51319.698137.120756@notabene.cse.unsw.edu.au>
X-OriginalArrivalTime: 24 Mar 2004 21:13:52.0593 (UTC)
 FILETIME=[E89B6410:01C411E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iBY+4KedhWG30LGeGEw/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Remember the 3.5Tb Array i've been trying to build, i finally got around
to getting some source code changes that seem to work much better. 
Attached you will find a patch that fixes the raid5 code to a point
where it seems to re-sync and recover without complaining about maps not
being correct.  The patch below is build against a 2.6.3, but will patch
2.6.4 sources as well.  At this point i'd like to hear comments,
thoughts on the changes i've made.  Some notes:

1. raid0 seems to work fine at 3.5T
2. I have not looked at the raid6 code, but it does not work at 3.5Tb
3. Formatting the array with ext3 takes a very long time, not sure why
yet.

Here is the patch:
diff -urN -X /home/efelix/.cvsignore kernel-source-2.6.3/drivers/md/md.c
kernel-source-2.6.3evan1/drivers/md/md.c
--- kernel-source-2.6.3/drivers/md/md.c	2004-02-19 08:54:51.000000000
+0000
+++ kernel-source-2.6.3evan1/drivers/md/md.c	2004-03-17
21:52:25.000000000 +0000
@@ -3138,13 +3138,14 @@
 static void md_do_sync(mddev_t *mddev)
 {
 	mddev_t *mddev2;
-	unsigned int max_sectors, currspeed = 0,
-		j, window;
+	unsigned int currspeed = 0,
+		 window;
+	sector_t max_sectors,j;
 	unsigned long mark[SYNC_MARKS];
-	unsigned long mark_cnt[SYNC_MARKS];
+	sector_t mark_cnt[SYNC_MARKS];
 	int last_mark,m;
 	struct list_head *tmp;
-	unsigned long last_check;
+	sector_t last_check;
 
 	/* just incase thread restarts... */
 	if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
@@ -3282,7 +3283,7 @@
 		 */
 		cond_resched();
 
-		currspeed =
(j-mddev->resync_mark_cnt)/2/((jiffies-mddev->resync_mark)/HZ +1) +1;
+		currspeed = ((unsigned
long)(j-mddev->resync_mark_cnt))/2/((jiffies-mddev->resync_mark)/HZ +1)
+1;
 
 		if (currspeed > sysctl_speed_limit_min) {
 			if ((currspeed > sysctl_speed_limit_max) ||
diff -urN -X /home/efelix/.cvsignore
kernel-source-2.6.3/drivers/md/raid5.c
kernel-source-2.6.3evan1/drivers/md/raid5.c
--- kernel-source-2.6.3/drivers/md/raid5.c	2004-02-19 08:54:52.000000000
+0000
+++ kernel-source-2.6.3evan1/drivers/md/raid5.c	2004-03-17
20:46:52.000000000 +0000
@@ -181,7 +181,7 @@
 
 static void raid5_build_block (struct stripe_head *sh, int i);
 
-static inline void init_stripe(struct stripe_head *sh, unsigned long
sector, int pd_idx)
+static inline void init_stripe(struct stripe_head *sh, sector_t sector,
int pd_idx)
 {
 	raid5_conf_t *conf = sh->raid_conf;
 	int disks = conf->raid_disks, i;
@@ -218,7 +218,7 @@
 	insert_hash(conf, sh);
 }
 
-static struct stripe_head *__find_stripe(raid5_conf_t *conf, unsigned
long sector)
+static struct stripe_head *__find_stripe(raid5_conf_t *conf, sector_t
sector)
 {
 	struct stripe_head *sh;
 
@@ -231,7 +231,7 @@
 	return NULL;
 }
 
-static struct stripe_head *get_active_stripe(raid5_conf_t *conf,
unsigned long sector, 
+static struct stripe_head *get_active_stripe(raid5_conf_t *conf,
sector_t sector, 
 					     int pd_idx, int noblock) 
 {
 	struct stripe_head *sh;
@@ -495,7 +495,7 @@
  * Input: a 'big' sector number,
  * Output: index of the data and parity disk, and the sector # in them.
  */
-static unsigned long raid5_compute_sector(sector_t r_sector, unsigned
int raid_disks,
+static sector_t raid5_compute_sector(sector_t r_sector, unsigned int
raid_disks,
 			unsigned int data_disks, unsigned int * dd_idx,
 			unsigned int * pd_idx, raid5_conf_t *conf)
 {
@@ -556,7 +556,7 @@
 	/*
 	 * Finally, compute the new sector number
 	 */
-	new_sector = stripe * sectors_per_chunk + chunk_offset;
+	new_sector = (sector_t)stripe * sectors_per_chunk + chunk_offset;
 	return new_sector;
 }
 
@@ -567,7 +567,7 @@
 	int raid_disks = conf->raid_disks, data_disks = raid_disks - 1;
 	sector_t new_sector = sh->sector, check;
 	int sectors_per_chunk = conf->chunk_size >> 9;
-	long stripe;
+	sector_t stripe;
 	int chunk_offset;
 	int chunk_number, dummy1, dummy2, dd_idx = i;
 	sector_t r_sector;
@@ -1388,7 +1389,7 @@
 	unsigned long stripe;
 	int chunk_offset;
 	int dd_idx, pd_idx;
-	unsigned long first_sector;
+	sector_t first_sector;
 	int raid_disks = conf->raid_disks;
 	int data_disks = raid_disks-1;
 
@@ -1401,7 +1402,7 @@
 	stripe = x;
 	BUG_ON(x != stripe);
 
-	first_sector =
raid5_compute_sector(stripe*data_disks*sectors_per_chunk
+	first_sector =
raid5_compute_sector((sector_t)stripe*data_disks*sectors_per_chunk
 		+ chunk_offset, raid_disks, data_disks, &dd_idx, &pd_idx, conf);
 	sh = get_active_stripe(conf, sector_nr, pd_idx, 1);
 	if (sh == NULL) {
diff -urN -X /home/efelix/.cvsignore
kernel-source-2.6.3/include/linux/raid/md_k.h
kernel-source-2.6.3evan1/include/linux/raid/md_k.h
--- kernel-source-2.6.3/include/linux/raid/md_k.h	2004-02-19
08:55:57.000000000 +0000
+++ kernel-source-2.6.3evan1/include/linux/raid/md_k.h	2004-03-10
21:14:39.000000000 +0000
@@ -211,9 +211,9 @@
 
 	struct mdk_thread_s		*thread;	/* management thread */
 	struct mdk_thread_s		*sync_thread;	/* doing resync or reconstruct */
-	unsigned long			curr_resync;	/* blocks scheduled */
+	sector_t			curr_resync;	/* blocks scheduled */
 	unsigned long			resync_mark;	/* a recent timestamp */
-	unsigned long			resync_mark_cnt;/* blocks written at resync_mark */
+	sector_t			resync_mark_cnt;/* blocks written at resync_mark */
 
 	/* recovery/resync flags 
 	 * NEEDED:   we might need to start a resync/recover
-------------------

Evan

On Fri, 2004-01-16 at 03:18, Neil Brown wrote:
> On Thursday January 15, evan.felix@pnl.gov wrote:
> > I've been attempting to create a large raid 5 device using the linux
> > 2.6.1 kernel, with the Large Block Device configured on.  I have in
> the
> > system 16 250G disks.  I built an array with mdadm -C -n 15 -x 1
> > /dev/md2 /dev/sd[a-p]
> > 
> > The resync/recovery seemed to be going fine, but at some point i
> started
> > seeing:
> > 
> > kernel: compute_blocknr: map not correct
> > kernel: compute_blocknr: map not correct
> ...
> > 
> > Has anyone else made an array this large? and does anybody have any
> > pointers on where i can start looking at code to fix this?
> 
> I would look in  drivers/md/raid5.c and compute_blocknr() in that
> file.
> 
> I would change "chunk_number" to a sector_t and change:
>         chunk_number = stripe * data_disks + i;
> to read
>         chunk_number = (sector_t)stripe * data_disks + i;
> 
> Possibly "stripe" and "chunk_number" should both be "sector_t", but
> I'm not at all sure.
> 
> Please let me know if it helps.
> 
> NeilBrown
-- 
-------------------------
Evan Felix
Administrator of Supercomputer #5 in Top 500, Nov 2003
Environmental Molecular Sciences Laboratory
Pacific Northwest National Laboratory
Operated for the U.S. DOE by Battelle

--=-iBY+4KedhWG30LGeGEw/
Content-Disposition: attachment; filename=bigraid5.patch
Content-Type: text/x-patch; name=bigraid5.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIC1YIC9ob21lL2VmZWxpeC8uY3ZzaWdub3JlIGtlcm5lbC1zb3VyY2UtMi42LjMv
ZHJpdmVycy9tZC9tZC5jIGtlcm5lbC1zb3VyY2UtMi42LjNldmFuMS9kcml2ZXJzL21kL21kLmMN
Ci0tLSBrZXJuZWwtc291cmNlLTIuNi4zL2RyaXZlcnMvbWQvbWQuYwkyMDA0LTAyLTE5IDA4OjU0
OjUxLjAwMDAwMDAwMCArMDAwMA0KKysrIGtlcm5lbC1zb3VyY2UtMi42LjNldmFuMS9kcml2ZXJz
L21kL21kLmMJMjAwNC0wMy0xNyAyMTo1MjoyNS4wMDAwMDAwMDAgKzAwMDANCkBAIC0zMTM4LDEz
ICszMTM4LDE0IEBADQogc3RhdGljIHZvaWQgbWRfZG9fc3luYyhtZGRldl90ICptZGRldikNCiB7
DQogCW1kZGV2X3QgKm1kZGV2MjsNCi0JdW5zaWduZWQgaW50IG1heF9zZWN0b3JzLCBjdXJyc3Bl
ZWQgPSAwLA0KLQkJaiwgd2luZG93Ow0KKwl1bnNpZ25lZCBpbnQgY3VycnNwZWVkID0gMCwNCisJ
CSB3aW5kb3c7DQorCXNlY3Rvcl90IG1heF9zZWN0b3JzLGo7DQogCXVuc2lnbmVkIGxvbmcgbWFy
a1tTWU5DX01BUktTXTsNCi0JdW5zaWduZWQgbG9uZyBtYXJrX2NudFtTWU5DX01BUktTXTsNCisJ
c2VjdG9yX3QgbWFya19jbnRbU1lOQ19NQVJLU107DQogCWludCBsYXN0X21hcmssbTsNCiAJc3Ry
dWN0IGxpc3RfaGVhZCAqdG1wOw0KLQl1bnNpZ25lZCBsb25nIGxhc3RfY2hlY2s7DQorCXNlY3Rv
cl90IGxhc3RfY2hlY2s7DQogDQogCS8qIGp1c3QgaW5jYXNlIHRocmVhZCByZXN0YXJ0cy4uLiAq
Lw0KIAlpZiAodGVzdF9iaXQoTURfUkVDT1ZFUllfRE9ORSwgJm1kZGV2LT5yZWNvdmVyeSkpDQpA
QCAtMzI4Miw3ICszMjgzLDcgQEANCiAJCSAqLw0KIAkJY29uZF9yZXNjaGVkKCk7DQogDQotCQlj
dXJyc3BlZWQgPSAoai1tZGRldi0+cmVzeW5jX21hcmtfY250KS8yLygoamlmZmllcy1tZGRldi0+
cmVzeW5jX21hcmspL0haICsxKSArMTsNCisJCWN1cnJzcGVlZCA9ICgodW5zaWduZWQgbG9uZyko
ai1tZGRldi0+cmVzeW5jX21hcmtfY250KSkvMi8oKGppZmZpZXMtbWRkZXYtPnJlc3luY19tYXJr
KS9IWiArMSkgKzE7DQogDQogCQlpZiAoY3VycnNwZWVkID4gc3lzY3RsX3NwZWVkX2xpbWl0X21p
bikgew0KIAkJCWlmICgoY3VycnNwZWVkID4gc3lzY3RsX3NwZWVkX2xpbWl0X21heCkgfHwNCmRp
ZmYgLXVyTiAtWCAvaG9tZS9lZmVsaXgvLmN2c2lnbm9yZSBrZXJuZWwtc291cmNlLTIuNi4zL2Ry
aXZlcnMvbWQvcmFpZDUuYyBrZXJuZWwtc291cmNlLTIuNi4zZXZhbjEvZHJpdmVycy9tZC9yYWlk
NS5jDQotLS0ga2VybmVsLXNvdXJjZS0yLjYuMy9kcml2ZXJzL21kL3JhaWQ1LmMJMjAwNC0wMi0x
OSAwODo1NDo1Mi4wMDAwMDAwMDAgKzAwMDANCisrKyBrZXJuZWwtc291cmNlLTIuNi4zZXZhbjEv
ZHJpdmVycy9tZC9yYWlkNS5jCTIwMDQtMDMtMTcgMjA6NDY6NTIuMDAwMDAwMDAwICswMDAwDQpA
QCAtMTgxLDcgKzE4MSw3IEBADQogDQogc3RhdGljIHZvaWQgcmFpZDVfYnVpbGRfYmxvY2sgKHN0
cnVjdCBzdHJpcGVfaGVhZCAqc2gsIGludCBpKTsNCiANCi1zdGF0aWMgaW5saW5lIHZvaWQgaW5p
dF9zdHJpcGUoc3RydWN0IHN0cmlwZV9oZWFkICpzaCwgdW5zaWduZWQgbG9uZyBzZWN0b3IsIGlu
dCBwZF9pZHgpDQorc3RhdGljIGlubGluZSB2b2lkIGluaXRfc3RyaXBlKHN0cnVjdCBzdHJpcGVf
aGVhZCAqc2gsIHNlY3Rvcl90IHNlY3RvciwgaW50IHBkX2lkeCkNCiB7DQogCXJhaWQ1X2NvbmZf
dCAqY29uZiA9IHNoLT5yYWlkX2NvbmY7DQogCWludCBkaXNrcyA9IGNvbmYtPnJhaWRfZGlza3Ms
IGk7DQpAQCAtMjE4LDcgKzIxOCw3IEBADQogCWluc2VydF9oYXNoKGNvbmYsIHNoKTsNCiB9DQog
DQotc3RhdGljIHN0cnVjdCBzdHJpcGVfaGVhZCAqX19maW5kX3N0cmlwZShyYWlkNV9jb25mX3Qg
KmNvbmYsIHVuc2lnbmVkIGxvbmcgc2VjdG9yKQ0KK3N0YXRpYyBzdHJ1Y3Qgc3RyaXBlX2hlYWQg
Kl9fZmluZF9zdHJpcGUocmFpZDVfY29uZl90ICpjb25mLCBzZWN0b3JfdCBzZWN0b3IpDQogew0K
IAlzdHJ1Y3Qgc3RyaXBlX2hlYWQgKnNoOw0KIA0KQEAgLTIzMSw3ICsyMzEsNyBAQA0KIAlyZXR1
cm4gTlVMTDsNCiB9DQogDQotc3RhdGljIHN0cnVjdCBzdHJpcGVfaGVhZCAqZ2V0X2FjdGl2ZV9z
dHJpcGUocmFpZDVfY29uZl90ICpjb25mLCB1bnNpZ25lZCBsb25nIHNlY3RvciwgDQorc3RhdGlj
IHN0cnVjdCBzdHJpcGVfaGVhZCAqZ2V0X2FjdGl2ZV9zdHJpcGUocmFpZDVfY29uZl90ICpjb25m
LCBzZWN0b3JfdCBzZWN0b3IsIA0KIAkJCQkJICAgICBpbnQgcGRfaWR4LCBpbnQgbm9ibG9jaykg
DQogew0KIAlzdHJ1Y3Qgc3RyaXBlX2hlYWQgKnNoOw0KQEAgLTQ5NSw3ICs0OTUsNyBAQA0KICAq
IElucHV0OiBhICdiaWcnIHNlY3RvciBudW1iZXIsDQogICogT3V0cHV0OiBpbmRleCBvZiB0aGUg
ZGF0YSBhbmQgcGFyaXR5IGRpc2ssIGFuZCB0aGUgc2VjdG9yICMgaW4gdGhlbS4NCiAgKi8NCi1z
dGF0aWMgdW5zaWduZWQgbG9uZyByYWlkNV9jb21wdXRlX3NlY3RvcihzZWN0b3JfdCByX3NlY3Rv
ciwgdW5zaWduZWQgaW50IHJhaWRfZGlza3MsDQorc3RhdGljIHNlY3Rvcl90IHJhaWQ1X2NvbXB1
dGVfc2VjdG9yKHNlY3Rvcl90IHJfc2VjdG9yLCB1bnNpZ25lZCBpbnQgcmFpZF9kaXNrcywNCiAJ
CQl1bnNpZ25lZCBpbnQgZGF0YV9kaXNrcywgdW5zaWduZWQgaW50ICogZGRfaWR4LA0KIAkJCXVu
c2lnbmVkIGludCAqIHBkX2lkeCwgcmFpZDVfY29uZl90ICpjb25mKQ0KIHsNCkBAIC01NTYsNyAr
NTU2LDcgQEANCiAJLyoNCiAJICogRmluYWxseSwgY29tcHV0ZSB0aGUgbmV3IHNlY3RvciBudW1i
ZXINCiAJICovDQotCW5ld19zZWN0b3IgPSBzdHJpcGUgKiBzZWN0b3JzX3Blcl9jaHVuayArIGNo
dW5rX29mZnNldDsNCisJbmV3X3NlY3RvciA9IChzZWN0b3JfdClzdHJpcGUgKiBzZWN0b3JzX3Bl
cl9jaHVuayArIGNodW5rX29mZnNldDsNCiAJcmV0dXJuIG5ld19zZWN0b3I7DQogfQ0KIA0KQEAg
LTU2Nyw3ICs1NjcsNyBAQA0KIAlpbnQgcmFpZF9kaXNrcyA9IGNvbmYtPnJhaWRfZGlza3MsIGRh
dGFfZGlza3MgPSByYWlkX2Rpc2tzIC0gMTsNCiAJc2VjdG9yX3QgbmV3X3NlY3RvciA9IHNoLT5z
ZWN0b3IsIGNoZWNrOw0KIAlpbnQgc2VjdG9yc19wZXJfY2h1bmsgPSBjb25mLT5jaHVua19zaXpl
ID4+IDk7DQotCWxvbmcgc3RyaXBlOw0KKwlzZWN0b3JfdCBzdHJpcGU7DQogCWludCBjaHVua19v
ZmZzZXQ7DQogCWludCBjaHVua19udW1iZXIsIGR1bW15MSwgZHVtbXkyLCBkZF9pZHggPSBpOw0K
IAlzZWN0b3JfdCByX3NlY3RvcjsNCkBAIC0xMzg4LDcgKzEzODksNyBAQA0KIAl1bnNpZ25lZCBs
b25nIHN0cmlwZTsNCiAJaW50IGNodW5rX29mZnNldDsNCiAJaW50IGRkX2lkeCwgcGRfaWR4Ow0K
LQl1bnNpZ25lZCBsb25nIGZpcnN0X3NlY3RvcjsNCisJc2VjdG9yX3QgZmlyc3Rfc2VjdG9yOw0K
IAlpbnQgcmFpZF9kaXNrcyA9IGNvbmYtPnJhaWRfZGlza3M7DQogCWludCBkYXRhX2Rpc2tzID0g
cmFpZF9kaXNrcy0xOw0KIA0KQEAgLTE0MDEsNyArMTQwMiw3IEBADQogCXN0cmlwZSA9IHg7DQog
CUJVR19PTih4ICE9IHN0cmlwZSk7DQogDQotCWZpcnN0X3NlY3RvciA9IHJhaWQ1X2NvbXB1dGVf
c2VjdG9yKHN0cmlwZSpkYXRhX2Rpc2tzKnNlY3RvcnNfcGVyX2NodW5rDQorCWZpcnN0X3NlY3Rv
ciA9IHJhaWQ1X2NvbXB1dGVfc2VjdG9yKChzZWN0b3JfdClzdHJpcGUqZGF0YV9kaXNrcypzZWN0
b3JzX3Blcl9jaHVuaw0KIAkJKyBjaHVua19vZmZzZXQsIHJhaWRfZGlza3MsIGRhdGFfZGlza3Ms
ICZkZF9pZHgsICZwZF9pZHgsIGNvbmYpOw0KIAlzaCA9IGdldF9hY3RpdmVfc3RyaXBlKGNvbmYs
IHNlY3Rvcl9uciwgcGRfaWR4LCAxKTsNCiAJaWYgKHNoID09IE5VTEwpIHsNCmRpZmYgLXVyTiAt
WCAvaG9tZS9lZmVsaXgvLmN2c2lnbm9yZSBrZXJuZWwtc291cmNlLTIuNi4zL2luY2x1ZGUvbGlu
dXgvcmFpZC9tZF9rLmgga2VybmVsLXNvdXJjZS0yLjYuM2V2YW4xL2luY2x1ZGUvbGludXgvcmFp
ZC9tZF9rLmgNCi0tLSBrZXJuZWwtc291cmNlLTIuNi4zL2luY2x1ZGUvbGludXgvcmFpZC9tZF9r
LmgJMjAwNC0wMi0xOSAwODo1NTo1Ny4wMDAwMDAwMDAgKzAwMDANCisrKyBrZXJuZWwtc291cmNl
LTIuNi4zZXZhbjEvaW5jbHVkZS9saW51eC9yYWlkL21kX2suaAkyMDA0LTAzLTEwIDIxOjE0OjM5
LjAwMDAwMDAwMCArMDAwMA0KQEAgLTIxMSw5ICsyMTEsOSBAQA0KIA0KIAlzdHJ1Y3QgbWRrX3Ro
cmVhZF9zCQkqdGhyZWFkOwkvKiBtYW5hZ2VtZW50IHRocmVhZCAqLw0KIAlzdHJ1Y3QgbWRrX3Ro
cmVhZF9zCQkqc3luY190aHJlYWQ7CS8qIGRvaW5nIHJlc3luYyBvciByZWNvbnN0cnVjdCAqLw0K
LQl1bnNpZ25lZCBsb25nCQkJY3Vycl9yZXN5bmM7CS8qIGJsb2NrcyBzY2hlZHVsZWQgKi8NCisJ
c2VjdG9yX3QJCQljdXJyX3Jlc3luYzsJLyogYmxvY2tzIHNjaGVkdWxlZCAqLw0KIAl1bnNpZ25l
ZCBsb25nCQkJcmVzeW5jX21hcms7CS8qIGEgcmVjZW50IHRpbWVzdGFtcCAqLw0KLQl1bnNpZ25l
ZCBsb25nCQkJcmVzeW5jX21hcmtfY250Oy8qIGJsb2NrcyB3cml0dGVuIGF0IHJlc3luY19tYXJr
ICovDQorCXNlY3Rvcl90CQkJcmVzeW5jX21hcmtfY250Oy8qIGJsb2NrcyB3cml0dGVuIGF0IHJl
c3luY19tYXJrICovDQogDQogCS8qIHJlY292ZXJ5L3Jlc3luYyBmbGFncyANCiAJICogTkVFREVE
OiAgIHdlIG1pZ2h0IG5lZWQgdG8gc3RhcnQgYSByZXN5bmMvcmVjb3Zlcg0K

--=-iBY+4KedhWG30LGeGEw/--
