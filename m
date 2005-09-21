Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVIUIbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVIUIbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVIUIbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:31:03 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:39315 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1750750AbVIUIbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:31:01 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Guus Houtzager <guus@luna.nl>
Date: Wed, 21 Sep 2005 10:30:49 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2l1Skkao82"
Content-Transfer-Encoding: 7bit
Message-ID: <17201.6713.60861.781073@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: OOPS in raid10.c:1448 in vanilla 2.6.13.2
In-Reply-To: message from Guus Houtzager on Tuesday September 20
References: <1127234670.2893.103.camel@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2l1Skkao82
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

On Tuesday September 20, guus@luna.nl wrote:
> Hi,
> 
> On a new server I've been playing with software raid10.
...
> Sep 20 19:25:09 lorentz kernel: ------------[ cut here ]------------
> Sep 20 19:25:09 lorentz kernel: kernel BUG at drivers/md/raid10.c:1448!

This is fixed in 2.6.14-rc1.  I've attached the two patches that
resolves this and a related problem.

However I should point out that what you did was guaranteed to kill
the array (though mdadm-2.1 should have been able to re-assemble it
with --force):

> # mdadm --create /dev/md1 --level=10 --raid-devices=4 /dev/sd[abcd]2

Now the four slots are 
   sda2 sdb2 sdc2 sdd2

sda2 and sdb2 have the same data, as do sdc2 and sdd2

> Sep 20 19:08:23 lorentz kernel: raid10: Disk failure on sdb2, disabling
> device.
> Sep 20 19:08:23 lorentz kernel: ^IOperation continuing on 3 devices

now you have
   sda2 missing sdc2 sdd2

> 
> Then removed sdc from the server. Also took a while, but sdc2 also got
> marked faulty.
now
   sda2 missing missing sdd2
all data is still safe.

> Filesystem on /mnt stays usable during all this (slight hickup when a
> disk is removed, but keeps going)
> Then reinserted sdc. To get it resynced I did:
> # mdadm /dev/md1 -r /dev/sdc2
> # mdadm /dev/md1 -a /dev/sdc2
> And it happily resynced and made sdc2 healthy again.

now
   sda2 sdc2 missing sdd2

note that sdc2 took the first empty slot.

> Then removed sdd and sdd2 got marked faulty.

Now
   sda2 sdc2 missing missing

so you have lost half your data.

>                                              Filesystem kept working.

This is a bit odd - it should have stopped working, but that depends
on how hard you pushed the filesystem.  It would have failed if you
tried to read or write in the area covered by the 2 two devices.


> So at that point I was happy. At that point I just wanted to readd both
> disks and get on with installing the server. So I reinserted both disks
> m, waited several minutes and did:
> # mdadm /dev/md1 -r /dev/sdb2
> # mdadm /dev/md1 -r /dev/sdd2
> # mdadm /dev/md1 -a /dev/sdb2

now you have
  sda2 sdc2 sdb2-not-sync missing

it tried to recover sdb2, but there was no-where to recover from.
This caused the BUG.  The patches cause this situation to simply
abort the recovery rather than BUG.

NeilBrown


--2l1Skkao82
Content-Type: text/plain
Content-Description: patch-1
Content-Disposition: inline;
	filename="442MdR10FixFailed"
Content-Transfer-Encoding: 7bit

Status: ok

Fix raid10 assembly when too many devices are missing.

if you try to assemble an array with too many missing devices,
raid10 will now reject the attempt, instead of allowing it.

Also check when hot-adding a drive and refuse the hot-add if 
the array is beyond hope.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c	2005-09-09 13:44:20.000000000 +1000
+++ ./drivers/md/raid10.c~current~	2005-09-09 13:44:20.000000000 +1000
@@ -906,6 +906,27 @@ static void close_sync(conf_t *conf)
 	conf->r10buf_pool = NULL;
 }
 
+/* check if there are enough drives for
+ * every block to appear on atleast one
+ */
+static int enough(conf_t *conf)
+{
+	int first = 0;
+
+	do {
+		int n = conf->copies;
+		int cnt = 0;
+		while (n--) {
+			if (conf->mirrors[first].rdev)
+				cnt++;
+			first = (first+1) % conf->raid_disks;
+		}
+		if (cnt == 0)
+			return 0;
+	} while (first != 0);
+	return 1;
+}
+
 static int raid10_spare_active(mddev_t *mddev)
 {
 	int i;
@@ -944,6 +965,8 @@ static int raid10_add_disk(mddev_t *mdde
 		 * very different from resync
 		 */
 		return 0;
+	if (!enough(conf))
+		return 0;
 
 	for (mirror=0; mirror < mddev->raid_disks; mirror++)
 		if ( !(p=conf->mirrors+mirror)->rdev) {
@@ -1684,9 +1707,10 @@ static int run(mddev_t *mddev)
 	init_waitqueue_head(&conf->wait_idle);
 	init_waitqueue_head(&conf->wait_resume);
 
-	if (!conf->working_disks) {
-		printk(KERN_ERR "raid10: no operational mirrors for %s\n",
-			mdname(mddev));
+	/* need to check that every block has at least one working mirror */
+	if (!enough(conf)) {
+		printk(KERN_ERR "raid10: not enough operational mirrors for %s\n",
+		       mdname(mddev));
 		goto out_free_conf;
 	}
 

--2l1Skkao82
Content-Type: text/plain
Content-Description: patch-2
Content-Disposition: inline;
	filename="443MdR10RebuildFix"
Content-Transfer-Encoding: 7bit

Status: ok

Fix BUG when raid10 rebuilds without enough drives.

This shouldn't be a BUG.  We should cope.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid10.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff ./drivers/md/raid10.c~current~ ./drivers/md/raid10.c
--- ./drivers/md/raid10.c	2005-09-09 13:44:20.000000000 +1000
+++ ./drivers/md/raid10.c~current~	2005-09-09 13:44:20.000000000 +1000
@@ -1474,7 +1474,13 @@ static sector_t sync_request(mddev_t *md
 					}
 				}
 				if (j == conf->copies) {
-					BUG();
+					/* Cannot recover, so abort the recovery */
+					put_buf(r10_bio);
+					r10_bio = rb2;
+					if (!test_and_set_bit(MD_RECOVERY_ERR, &mddev->recovery))
+						printk(KERN_INFO "raid10: %s: insufficient working devices for recovery.\n",
+						       mdname(mddev));
+					break;
 				}
 			}
 		if (biolist == NULL) {

--2l1Skkao82--
