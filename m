Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSGNP65>; Sun, 14 Jul 2002 11:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316909AbSGNP64>; Sun, 14 Jul 2002 11:58:56 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:19993 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316906AbSGNP6v>; Sun, 14 Jul 2002 11:58:51 -0400
Date: Sun, 14 Jul 2002 18:01:42 +0200
From: Kurt Garloff <garloff@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] CONFIG_BLK_STAT
Message-ID: <20020714160142.GB26336@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: multipart/mixed; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

looking at the gendisk stuff, I noticed that we need quite some space to
collect statistics on a per partition basis.
On a 32bit arch, we have sizeof(struct hd_struct) =3D 68, if I don't mispar=
se.=20
Which makes 17408 bytes kmalloced per disk major number. Which is not quite
large and also unfortunately just above a power of two where our slab
allocator will not be so efficient.
The latter can be fixed, the number field is not used anymore in the kernel
anywhere, as far as I could find. So I removed it, and we're back at 16384
bytes (on 32 bit archs), which is much nicer already.

For some cases, this still maybe much too much kernel memory just for
collecting statistics that may be interesting for a kernel hacker that does
some tuning on elevator ... but not for the normal user. After a couple of
hours uptime some of the 32bit counters overflow on a moderately loaded
machine (my desktop) anyway :-(
Think of having 8 SCSI majors and a few IDE ones to get a feeling for the
amount of wasted memory.
Or think even more than 128 SCSI disks (I'm working on that ... and we will
allocate stuff all dynamically there)

So I made them a config option. CONFIG_BLK_STAT
We did not have the per part statisics in /proc/partitions until recently,
anyway, so I doubt many people depend on them. And the memory footprint of
the hd_struct per major is back to 3072 bytes then (32bit arch again).

Patch is against 2.4.19rc1 and I'd like to see it in 2.4.19.

Comments?
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations    <K.Garloff@TUE.NL>     [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nopart-stat-2419rc1.diff"
Content-Transfer-Encoding: quoted-printable

diff -uNr linux-2.4.18.S18.scsiswitch/Documentation/Configure.help linux-2.=
4.18.nohdstat/Documentation/Configure.help
--- linux-2.4.18.S18.scsiswitch/Documentation/Configure.help	Wed Jun 12 11:=
37:14 2002
+++ linux-2.4.18.nohdstat/Documentation/Configure.help	Sun Jul 14 17:26:34 =
2002
@@ -579,6 +579,18 @@
=20
   If unsure, say N.
=20
+Per partition statistics in /proc/partitions
+CONFIG_BLK_STAT
+  If you say yes here, your kernel will keep statistical information
+  for every partition. The information includes things as numbers of
+  read and write accesses, thenumber of merged requests etc.
+ =20
+  This is interesting, if you want to do performance tuning, by
+  tweaking the elevator, e.g.=20
+ =20
+  If not, N is the better choice, as it saves some bytes of kernel=20
+  memory, especially if you have a lot of disks.
+
 ATA/IDE/MFM/RLL support
 CONFIG_IDE
   If you say Y here, your kernel will be able to manage low cost mass
diff -uNr linux-2.4.18.S18.scsiswitch/drivers/block/Config.in linux-2.4.18.=
nohdstat/drivers/block/Config.in
--- linux-2.4.18.S18.scsiswitch/drivers/block/Config.in	Wed Jun 12 11:37:13=
 2002
+++ linux-2.4.18.nohdstat/drivers/block/Config.in	Sun Jul 14 09:38:29 2002
@@ -50,4 +50,5 @@
 fi
 dep_bool '  Initial RAM disk (initrd) support' CONFIG_BLK_DEV_INITRD $CONF=
IG_BLK_DEV_RAM
=20
+bool 'Collect IO statistics per partition' CONFIG_BLK_STAT
 endmenu
diff -uNr linux-2.4.18.S18.scsiswitch/drivers/block/genhd.c linux-2.4.18.no=
hdstat/drivers/block/genhd.c
--- linux-2.4.18.S18.scsiswitch/drivers/block/genhd.c	Wed Jun 12 11:37:02 2=
002
+++ linux-2.4.18.nohdstat/drivers/block/genhd.c	Sun Jul 14 17:20:21 2002
@@ -161,10 +161,11 @@
 get_partition_list(char *page, char **start, off_t offset, int count)
 {
 	struct gendisk *gp;
-	struct hd_struct *hd;
 	char buf[64];
 	int len, n;
=20
+# ifdef CONFIG_BLK_STAT
+	struct hd_struct *hd;
 	len =3D sprintf(page, "major minor  #blocks  name     "
 			"rio rmerge rsect ruse wio wmerge "
 			"wsect wuse running use aveq\n\n");
@@ -200,6 +201,26 @@
 				goto out;
 		}
 	}
+# else	/* CONFIG_BLK_STAT */
+	len =3D sprintf(page, "major minor  #blocks  name\n\n");
+	=09
+	read_lock(&gendisk_lock);
+	for (gp =3D gendisk_head; gp; gp =3D gp->next) {
+		for (n =3D 0; n < (gp->nr_real << gp->minor_shift); n++) {
+			if (gp->part[n].nr_sects =3D=3D 0)
+				continue;
+
+			len +=3D sprintf(page + len,
+					"%4d  %4d %10d %s\n",
+					gp->major, n, gp->sizes[n],
+					disk_name(gp, n, buf));
+			if (len < offset)
+				offset -=3D len, len =3D 0;
+			else if (len >=3D offset + count)
+				goto out;
+		}
+	}
+# endif	/* CONFIG_BLK_STAT */
=20
 out:
 	read_unlock(&gendisk_lock);
diff -uNr linux-2.4.18.S18.scsiswitch/drivers/block/ll_rw_blk.c linux-2.4.1=
8.nohdstat/drivers/block/ll_rw_blk.c
--- linux-2.4.18.S18.scsiswitch/drivers/block/ll_rw_blk.c	Wed Jun 12 11:37:=
11 2002
+++ linux-2.4.18.nohdstat/drivers/block/ll_rw_blk.c	Sun Jul 14 17:35:35 2002
@@ -658,6 +658,7 @@
 		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
 }
=20
+#ifdef CONFIG_BLK_STAT
 /* Return up to two hd_structs on which to do IO accounting for a given
  * request.  On a partitioned device, we want to account both against
  * the partition and against the whole disk.  */
@@ -770,6 +771,7 @@
 	if (hd2)=09
 		account_io_end(hd2, req);
 }
+#endif	/* CONFIG_BLK_STAT */
=20
 /*
  * add-request adds a request to the linked list.
@@ -828,8 +830,9 @@
 			  int max_segments)
 {
 	struct request *next;
+#ifdef CONFIG_BLK_STAT
 	struct hd_struct *hd1, *hd2;
- =20
+#endif
 	next =3D blkdev_next_request(req);
 	if (req->sector + req->nr_sectors !=3D next->sector)
 		return;
@@ -856,11 +859,13 @@
 	/* One last thing: we have removed a request, so we now have one
 	   less expected IO to complete for accounting purposes. */
=20
+#ifdef CONFIG_BLK_STAT
 	locate_hd_struct(req, &hd1, &hd2);
 	if (hd1)
 		down_ios(hd1);
 	if (hd2)=09
 		down_ios(hd2);
+#endif
 	blkdev_release_request(next);
 }
=20
@@ -966,7 +971,9 @@
 			req->nr_sectors =3D req->hard_nr_sectors +=3D count;
 			blk_started_io(count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
+#ifdef CONFIG_BLK_STAT		=09
 			req_new_io(req, 1, count);
+#endif
 			attempt_back_merge(q, req, max_sectors, max_segments);
 			goto out;
=20
@@ -989,7 +996,9 @@
 			req->nr_sectors =3D req->hard_nr_sectors +=3D count;
 			blk_started_io(count);
 			drive_stat_acct(req->rq_dev, req->cmd, count, 0);
+#ifdef CONFIG_BLK_STAT		=09
 			req_new_io(req, 1, count);
+#endif
 			attempt_front_merge(q, head, req, max_sectors, max_segments);
 			goto out;
=20
@@ -1052,7 +1061,9 @@
 	req->bhtail =3D bh;
 	req->rq_dev =3D bh->b_rdev;
 	req->start_time =3D jiffies;
+#ifdef CONFIG_BLK_STAT
 	req_new_io(req, 0, count);
+#endif
 	blk_started_io(count);
 	add_request(q, req, insert_here);
 out:
@@ -1404,8 +1415,9 @@
 {
 	if (req->waiting !=3D NULL)
 		complete(req->waiting);
+#ifdef CONFIG_BLK_STAT
 	req_finished_io(req);
-
+#endif
 	blkdev_release_request(req);
 }
=20
@@ -1545,7 +1557,9 @@
 EXPORT_SYMBOL(blk_queue_make_request);
 EXPORT_SYMBOL(generic_make_request);
 EXPORT_SYMBOL(blkdev_release_request);
+#ifdef CONFIG_BLK_STAT
 EXPORT_SYMBOL(req_finished_io);
+#endif
 EXPORT_SYMBOL(generic_unplug_device);
 EXPORT_SYMBOL(blk_queue_bounce_limit);
 EXPORT_SYMBOL(blk_max_low_pfn);
diff -uNr linux-2.4.18.S18.scsiswitch/drivers/scsi/scsi_lib.c linux-2.4.18.=
nohdstat/drivers/scsi/scsi_lib.c
--- linux-2.4.18.S18.scsiswitch/drivers/scsi/scsi_lib.c	Wed Jun 12 11:37:07=
 2002
+++ linux-2.4.18.nohdstat/drivers/scsi/scsi_lib.c	Sun Jul 14 17:34:01 2002
@@ -426,7 +426,9 @@
 	if (req->waiting !=3D NULL) {
 		complete(req->waiting);
 	}
+#ifdef CONFIG_BLK_STAT=09
 	req_finished_io(req);
+#endif
 	add_blkdev_randomness(MAJOR(req->rq_dev));
=20
         SDpnt =3D SCpnt->device;
diff -uNr linux-2.4.18.S18.scsiswitch/include/linux/genhd.h linux-2.4.18.no=
hdstat/include/linux/genhd.h
--- linux-2.4.18.S18.scsiswitch/include/linux/genhd.h	Sat Jul 13 19:20:13 2=
002
+++ linux-2.4.18.nohdstat/include/linux/genhd.h	Sun Jul 14 17:21:24 2002
@@ -62,8 +62,8 @@
 	unsigned long start_sect;
 	unsigned long nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
-	int number;                     /* stupid old code wastes space  */
=20
+#ifdef CONFIG_BLK_STAT
 	/* Performance stats: */
 	unsigned int ios_in_flight;
 	unsigned int io_ticks;
@@ -79,6 +79,7 @@
 	unsigned int wr_merges;
 	unsigned int wr_ticks;
 	unsigned int wr_sectors;=09
+#endif
 };
=20
 #define GENHD_FL_REMOVABLE  1

--tjCHc7DPkfUGtrlw--

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9MaBkxmLh6hyYd04RAvIsAJ0ZgYdEJzetuy9OVRWJY7Pw4YL6ewCgoW9Y
fgGKU4o3j7e5VqlN/q7+Nro=
=8mjL
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
