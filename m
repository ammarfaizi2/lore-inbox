Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVCMWoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVCMWoD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 17:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVCMWoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 17:44:03 -0500
Received: from roath.org ([212.227.22.120]:39557 "EHLO mail.roath.org")
	by vger.kernel.org with ESMTP id S261487AbVCMWny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 17:43:54 -0500
Date: Sun, 13 Mar 2005 23:43:51 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: Fix compiler warning in drivers/scsi/dpt_i2o.c
Message-ID: <20050313224351.GA1731@roath.org>
Reply-To: sroas@roath.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: sroas@roath.org (Stefan Roas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there!

The attachted patch fixes a compiler warning in drivers/scsi/dpt_i2o.c.

If you reply to this post, please CC me as I'm not suscribed to the
list.

Best Regards

--=20
Stefan Roas
sroas@roath.org

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-dpt_i2o
Content-Transfer-Encoding: quoted-printable

diff -rNu a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
--- a/drivers/scsi/dpt_i2o.c	2005-03-02 14:01:26.910737000 +0100
+++ b/drivers/scsi/dpt_i2o.c	2005-03-04 11:28:57.339003000 +0100
@@ -2027,8 +2027,8 @@
 		}
 		reply =3D (ulong)bus_to_virt(m);
=20
-		if (readl(reply) & MSG_FAIL) {
-			u32 old_m =3D readl(reply+28);=20
+		if (readl((void *)reply) & MSG_FAIL) {
+			u32 old_m =3D readl((void *)reply+28);=20
 			ulong msg;
 			u32 old_context;
 			PDEBUG("%s: Failed message\n",pHba->name);
@@ -2039,34 +2039,34 @@
 			}
 			// Transaction context is 0 in failed reply frame
 			msg =3D (ulong)(pHba->msg_addr_virt + old_m);
-			old_context =3D readl(msg+12);
+			old_context =3D readl((void *)msg+12);
 			writel(old_context, reply+12);
 			adpt_send_nop(pHba, old_m);
 		}=20
-		context =3D readl(reply+8);
+		context =3D readl((void *)reply+8);
 		if(context & 0x40000000){ // IOCTL
-			ulong p =3D (ulong)(readl(reply+12));
+			ulong p =3D (ulong)(readl((void *)reply+12));
 			if( p !=3D 0) {
 				memcpy((void*)p, (void*)reply, REPLY_FRAME_SIZE * 4);
 			}
 			// All IOCTLs will also be post wait
 		}
 		if(context & 0x80000000){ // Post wait message
-			status =3D readl(reply+16);
+			status =3D readl((void *)reply+16);
 			if(status  >> 24){
 				status &=3D  0xffff; /* Get detail status */
 			} else {
 				status =3D I2O_POST_WAIT_OK;
 			}
 			if(!(context & 0x40000000)) {
-				cmd =3D (struct scsi_cmnd*) readl(reply+12);=20
+				cmd =3D (struct scsi_cmnd*) readl((void *)reply+12);=20
 				if(cmd !=3D NULL) {
 					printk(KERN_WARNING"%s: Apparent SCSI cmd in Post Wait Context - cmd=
=3D%p context=3D%x\n", pHba->name, cmd, context);
 				}
 			}
 			adpt_i2o_post_wait_complete(context, status);
 		} else { // SCSI message
-			cmd =3D (struct scsi_cmnd*) readl(reply+12);=20
+			cmd =3D (struct scsi_cmnd*) readl((void *)reply+12);=20
 			if(cmd !=3D NULL){
 				if(cmd->serial_number !=3D 0) { // If not timedout
 					adpt_i2o_to_scsi(reply, cmd);
@@ -2236,16 +2236,16 @@
 	adpt_hba* pHba;
 	u32 hba_status;
 	u32 dev_status;
-	u32 reply_flags =3D readl(reply) & 0xff00; // Leave it shifted up 8 bits=
=20
+	u32 reply_flags =3D readl((void *)reply) & 0xff00; // Leave it shifted up=
 8 bits=20
 	// I know this would look cleaner if I just read bytes
 	// but the model I have been using for all the rest of the
 	// io is in 4 byte words - so I keep that model
-	u16 detailed_status =3D readl(reply+16) &0xffff;
+	u16 detailed_status =3D readl((void *)reply+16) &0xffff;
 	dev_status =3D (detailed_status & 0xff);
 	hba_status =3D detailed_status >> 8;
=20
 	// calculate resid for sg=20
-	cmd->resid =3D cmd->request_bufflen - readl(reply+5);
+	cmd->resid =3D cmd->request_bufflen - readl((void *)reply+5);
=20
 	pHba =3D (adpt_hba*) cmd->device->host->hostdata[0];
=20
@@ -2256,7 +2256,7 @@
 		case I2O_SCSI_DSC_SUCCESS:
 			cmd->result =3D (DID_OK << 16);
 			// handle underflow
-			if(readl(reply+5) < cmd->underflow ) {
+			if(readl((void *)reply+5) < cmd->underflow ) {
 				cmd->result =3D (DID_ERROR <<16);
 				printk(KERN_WARNING"%s: SCSI CMD underflow\n",pHba->name);
 			}

--G4iJoqBmSsgzjUCe--

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCNMInwvfNuQ9pAq8RAmJGAJ9uvJFMtET5j8CSH7X091JBu8tVDwCdF/A6
U7MUMU9fyy/QQa89zavqLsQ=
=ltRR
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
