Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbTHOQv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbTHOQM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:12:27 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267952AbTHOQJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:03 -0400
Date: Fri, 15 Aug 2003 12:26:50 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: tim@cyberelk.net
Cc: grant@torque.net, linux-kernel@vger.kernel.org
Subject: [PATCH] pd.c: blk_init_queue() changes
Message-ID: <20030815152650.GR1685@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jx/LfW4V5TfZLeq7"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jx/LfW4V5TfZLeq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The following patch against 2.6-bk changes pd.c to the new
blk_init_queue()/blk_cleanup_queue() interface, and makes the error
handling on pd_init() cleaner.

Without these changes, pd.c is unable to compile.

--=20
Eduardo


diff -Nru a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
--- a/drivers/block/paride/pd.c	Fri Aug 15 12:15:46 2003
+++ b/drivers/block/paride/pd.c	Fri Aug 15 12:15:46 2003
@@ -654,7 +654,7 @@
 	return pd_identify(disk);
 }
=20
-static struct request_queue pd_queue;
+static struct request_queue *pd_queue;
=20
 static int pd_detect(void)
 {
@@ -704,7 +704,7 @@
 			set_capacity(p, disk->capacity);
 			disk->gd =3D p;
 			p->private_data =3D disk;
-			p->queue =3D &pd_queue;
+			p->queue =3D pd_queue;
 			add_disk(p);
 		}
 	}
@@ -782,7 +782,7 @@
 	spin_lock_irqsave(&pd_lock, saved_flags);
 	end_request(pd_req, success);
 	pd_busy =3D 0;
-	do_pd_request(&pd_queue);
+	do_pd_request(pd_queue);
 	spin_unlock_irqrestore(&pd_lock, saved_flags);
 }
=20
@@ -888,22 +888,37 @@
=20
 static int __init pd_init(void)
 {
+	int ret =3D -EINVAL;
 	if (disable)
-		return -1;
-	if (register_blkdev(major, name))
-		return -1;
+		goto err;
=20
-	blk_init_queue(&pd_queue, do_pd_request, &pd_lock);
-	blk_queue_max_sectors(&pd_queue, cluster);
+	ret =3D register_blkdev(major, name);
+	if (ret < 0)
+		goto err;
+	=09
+
+	pd_queue =3D blk_init_queue(do_pd_request, &pd_lock);
+	if (!pd_queue) {
+		ret =3D -ENOMEM;
+		goto err_unregister;
+	}
+	blk_queue_max_sectors(pd_queue, cluster);
=20
 	printk("%s: %s version %s, major %d, cluster %d, nice %d\n",
 	       name, name, PD_VERSION, major, cluster, nice);
 	pd_init_units();
 	if (!pd_detect()) {
-		unregister_blkdev(major, name);
-		return -1;
+		ret =3D -ENODEV;
+		goto err_freequeue;
 	}
 	return 0;
+
+err_freequeue:
+	blk_cleanup_queue(pd_queue);
+err_unregister:
+	unregister_blkdev(major, name);
+err:
+	return ret;
 }
=20
 static void __exit pd_exit(void)
@@ -920,7 +935,7 @@
 			pi_release(disk->pi);
 		}
 	}
-	blk_cleanup_queue(&pd_queue);
+	blk_cleanup_queue(pd_queue);
 }
=20
 MODULE_LICENSE("GPL");

--jx/LfW4V5TfZLeq7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/PPu5caRJ66w1lWgRApaLAJ9AxACS717wXSNnvsbeArn9F6cMVgCgqhtI
5svYozHoik+cpofD7vWjf2g=
=Ictw
-----END PGP SIGNATURE-----

--jx/LfW4V5TfZLeq7--
