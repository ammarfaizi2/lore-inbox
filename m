Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTLAVG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTLAVFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:05:14 -0500
Received: from admingilde.org ([213.95.21.5]:55942 "EHLO admingilde.org")
	by vger.kernel.org with ESMTP id S264095AbTLAVCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:02:22 -0500
Date: Mon, 1 Dec 2003 22:02:12 +0100
From: Martin Waitz <tali@admingilde.org>
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] fix use-after-free in sbp2.c
Message-ID: <20031201210212.GA2184@admingilde.org>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

when using some checking code (CONFIG_DEBUG_{SLAB,SPINLOCK_SLEEP},
sbp2 fails to log in into my external hd enclosure.

that is because sbp2_agent_reset sends a packet and waits
for its delivery.
however, the function used to create the packet activates
auto-destruct of the packet via hpsb_set_packet_complete_task.
thus, the semaphore used for synchronization is destroyed
while the sending task is waiting.

the following patch (against -test11) fixes sbp2 for me



Index: work/drivers/ieee1394/sbp2.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work.orig/drivers/ieee1394/sbp2.c	2003-11-28 23:49:11.000000000 +0100
+++ work/drivers/ieee1394/sbp2.c	2003-12-01 02:27:40.000000000 +0100
@@ -385,14 +387,18 @@
         if (!packet)
                 return NULL;
=20
-	hpsb_set_packet_complete_task(packet, (void (*)(void*))sbp2_free_packet,
-				      packet);
-
 	hpsb_node_fill_packet(ne, packet);
=20
 	return packet;
 }
=20
+static void
+sbp2util_autoclean_packet(struct hpsb_packet *packet)
+{
+	hpsb_set_packet_complete_task(packet, (void (*)(void*))sbp2_free_packet,
+				      packet);
+}
+
=20
 /*
  * This function is called to create a pool of command orbs used for
@@ -1763,6 +1769,7 @@
 	if (wait) {
 		down(&packet->state_change);
 		down(&packet->state_change);
+		sbp2_free_packet(packet);=20
 	}
=20
 	/*
@@ -2063,6 +2070,7 @@
 				SBP2_ERR("sbp2util_allocate_write_packet failed");
 				return(-ENOMEM);
 			}
+			sbp2util_autoclean_packet(packet);
 	=09
 			packet->data[0] =3D ORB_SET_NODE_ID(hi->host->node_id);
 			packet->data[1] =3D command->command_orb_dma;
@@ -2113,6 +2121,7 @@
 				SBP2_ERR("sbp2util_allocate_write_packet failed");
 				return(-ENOMEM);
 			}
+			sbp2util_autoclean_packet(packet);
=20
 			SBP2_ORB_DEBUG("ring doorbell, command orb %p", command_orb);


the following small part is needed to make sbp2 compile with
debug enabled

Index: work/drivers/ieee1394/sbp2.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work.orig/drivers/ieee1394/sbp2.c	2003-11-28 23:49:11.000000000 +0100
+++ work/drivers/ieee1394/sbp2.c	2003-12-01 02:27:40.000000000 +0100
@@ -603,7 +609,7 @@
 	struct unit_directory *ud;
 	struct sbp2scsi_host_info *hi;
=20
-	SBP2_DEBUG(__FUNCTION__);
+	SBP2_DEBUG("%s()", __FUNCTION__);
=20
 	ud =3D container_of(dev, struct unit_directory, device);
=20
@@ -628,7 +634,7 @@
 	struct unit_directory *ud;
 	struct scsi_id_instance_data *scsi_id;
=20
-	SBP2_DEBUG(__FUNCTION__);
+	SBP2_DEBUG("%s()", __FUNCTION__);
=20
 	ud =3D container_of(dev, struct unit_directory, device);
 	scsi_group =3D ud->device.driver_data;
=20

--=20
CU,		  / Friedrich-Alexander University Erlangen, Germany
Martin Waitz	//  Department of Computer Science 3       _________
______________/// - - - - - - - - - - - - - - - - - - - - ///
dies ist eine manuell generierte mail, sie beinhaltet    //
tippfehler und ist auch ohne grossbuchstaben gueltig.   /

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/y6xUj/Eaxd/oD7IRAly3AJ9Ff8OLB7dGnmPDaAUmY1dgqtwuUgCeJdij
uAebBDR5Px2n2yhFS7zxfAo=
=FmeC
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
