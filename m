Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317795AbSGZPqc>; Fri, 26 Jul 2002 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317797AbSGZPp4>; Fri, 26 Jul 2002 11:45:56 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:49762 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S317789AbSGZPpe>; Fri, 26 Jul 2002 11:45:34 -0400
Date: Fri, 26 Jul 2002 17:48:41 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] sd_many done right (4/5)
Message-ID: <20020726154841.GG19721@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W2ydbIOJmkm74tJ2"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W2ydbIOJmkm74tJ2
Content-Type: multipart/mixed; boundary="HcccYpVZDxQ8hzPO"
Content-Disposition: inline


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here comes patch 4/5 from a series of patches to support more than 128 (and
optionally more than 256) SCSI disks with Linux 2.4 by changing the sd driv=
er
to dynamically allocate memory and register block majors as disks get
attached.

The patches are all available at
http://www.suse.de/~garloff/linux/scsi-many/

When implementing sd_many, I came across prohibitive memory usang by
hd_structs which are allocated per partition. (For all partitions, not
only the existing ones.) The structure is 68 bytes (on 32bit archs) due=20
to all the counters there for statistics, i.e. 17k per major (thus con-
suming a 32k slab.)
One int was unused and could bye eliminated yielding a more sane size of 64
bytes. As these counters have only been introduced on 2.4.19pre, overflow
easily and are of limited use for non-kernel hackers anyway, patch 4 does
make them a config option CONFIG_BLK_STAT. You want to set it to no, in case
you want to attach many SCSI disks.

Patch is against 2.4.19rc1. Patch is independent of the others.
It could be applied right now!

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--HcccYpVZDxQ8hzPO
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

--HcccYpVZDxQ8hzPO--

--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9QW9YxmLh6hyYd04RArALAKDBnVJDnp3fV7b/HtTufQPlHaYZXwCg1XQ+
xVjdzkK7OvQhKFdp554G8iU=
=c8C8
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
