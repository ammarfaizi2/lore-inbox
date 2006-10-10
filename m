Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWJJRSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWJJRSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWJJRRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:17:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:34443 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964876AbWJJRRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:17:25 -0400
Date: Tue, 10 Oct 2006 10:15:52 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, htejun@gmail.com,
       Jeff Garzik <jeff@garzik.org>, Daniel Drake <dsd@gentoo.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/19] ahci: do not fail softreset if PHY reports no device
Message-ID: <20061010171552.GS6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ahci-do-not-fail-softreset-if-phy-reports-no-device.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Tejun Heo <htejun@gmail.com>

All softreset methods are responsible for detecting device presence
and succeed softreset in such cases.  AHCI didn't use to check for
device presence before proceeding with softreset and this caused
unnecessary reset retrials during probing.  This patch adds presence
detection to AHCI softreset.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
Cc: Daniel Drake <dsd@gentoo.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/scsi/ahci.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.17.13.orig/drivers/scsi/ahci.c
+++ linux-2.6.17.13/drivers/scsi/ahci.c
@@ -548,6 +548,12 @@ static int ahci_softreset(struct ata_por
 
 	DPRINTK("ENTER\n");
 
+	if (!sata_dev_present(ap)) {
+		DPRINTK("PHY reports no device\n");
+		*class = ATA_DEV_NONE;
+		return 0;
+	}
+
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_stop_engine(ap);
 	if (rc) {

--
