Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWCOQR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWCOQR5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWCOQR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:17:57 -0500
Received: from mivlgu.ru ([81.18.140.87]:52449 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1751023AbWCOQR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:17:56 -0500
Date: Wed, 15 Mar 2006 19:17:36 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Geoff Rivell <grivell@comcast.net>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AHCI SATA vendor update from VIA
Message-Id: <20060315191736.231a2894.vsu@altlinux.ru>
In-Reply-To: <439CF812.8010107@pobox.com>
References: <439CF812.8010107@pobox.com>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__15_Mar_2006_19_17_36_+0300_H9QNEzWKW1A8n0ku"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__15_Mar_2006_19_17_36_+0300_H9QNEzWKW1A8n0ku
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 11 Dec 2005 23:09:54 -0500 Jeff Garzik wrote:

> I received this ahci.c patch from VIA, and pass it on for review, 
> comment, and testing.
> 
> This patch won't go in as-is, because it does too much special casing. 
> But until we get around to that, people with VIA controllers probably 
> want this...
> 
> 	Jeff

What is needed to get the VT8251 support into the kernel tree?

I have looked at the patch, and it basically does three things:

1) Apparently the VT8251 hardware does not like the standard reset
   sequence performed by __sata_phy_reset() - the phy seems to become
   ready, but the ATA_BUSY bit never goes off.  So the patch authors
   just duplicated ahci_phy_reset(), inserted the whole code of
   __sata_phy_reset() in there, and added this part before the
   ata_busy_sleep() call:

+	/*Fix the VIA busy bug by a software reset*/
+	for (i = 0; i < 100; i++) {
+		tmp_status = ap->ops->check_status(ap);
+		if ((tmp_status & ATA_BUSY) == 0) break;
+		msleep(10);
+	}
+
+	if ((tmp_status & ATA_BUSY)) {
+		DPRINTK("Busy after CommReset, do softreset...\n"); 
+		/*set the PxCMD.CLO bit to clear BUSY and DRQ, to make the reset command sent out*/
+		tmp = readl(port_mmio + PORT_CMD);
+		tmp |= PORT_CMD_CLO;
+		writel(tmp, port_mmio + PORT_CMD);
+		readl(port_mmio + PORT_CMD); /* flush */
+
+		if (via_ahci_softreset(ap)) {
+			printk(KERN_WARNING "softreset failed\n");
+			return;
+		}
+	}

   Now, if this is really a chip bug, we don't have any choice except
   adding this workaround, but obviously not in this way.  What do you
   think about splitting __sata_phy_reset() in two parts -
   __sata_phy_reset_start() (everything up to the point where
   ata_busy_sleep() is called) and __sata_phy_reset_end()
   (ata_busy_sleep() and the rest), so that the low-level driver could
   insert its own code between these parts?  Or should a hook for this
   be added to ->ops instead?

2) via_ahci_qc_issue really just filters out the SETFEATURES_XFER
   command; only VIA can tell why this is needed, and is there a better
   way to do this.  However, at least some duplicated code could be
   removed easily:

static int via_ahci_qc_issue(struct ata_queued_cmd *qc)
{
	if (qc && qc->tf.command == ATA_CMD_SET_FEATURES &&
	    qc->tf.feature == SETFEATURES_XFER) {
		/* skip set xfer mode process */
		ata_qc_complete(qc);
		return 0;
	}
	return ahci_qc_issue(qc);
}

   Would this be acceptable?

3) What via_ahci_port_stop() does, I just don't understand - it is
   basically a copy of ahci_port_stop() at that time, but with clearing
   of the PORT_CMD bits removed - so nothing is stopped actually.
   Again, only VIA can tell why is this needed, but this part of the
   patch looks like a bug.

Geoff Rivell (CC'ed) tried to update the patch for 2.6.15:

http://grivell.home.comcast.net/via_ahci.patch

However, that patch does some things in a different order from the VIA
code - it calls via_ahci_softreset() before __sata_phy_reset(), which
does not seem safe to me.  Geoff, does this really work?

--Signature=_Wed__15_Mar_2006_19_17_36_+0300_H9QNEzWKW1A8n0ku
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEGD4jW82GfkQfsqIRAo3PAJ0euP/7MgHDbBRQcAYR+Pm9kuLyCACfYV3e
ImpJLywsjZRq+Nl645oO/lE=
=CL7c
-----END PGP SIGNATURE-----

--Signature=_Wed__15_Mar_2006_19_17_36_+0300_H9QNEzWKW1A8n0ku--
