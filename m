Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWJLXos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWJLXos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 19:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWJLXos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 19:44:48 -0400
Received: from twin.jikos.cz ([213.151.79.26]:32730 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751325AbWJLXos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 19:44:48 -0400
Date: Fri, 13 Oct 2006 01:44:24 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Phil Blundell <philb@gnu.org>, Tim Waugh <tim@cyberelk.net>,
       Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: [PATCH] fix parport_serial_pci_resume() ignoring return value from
 pci_enable_device()
Message-ID: <Pine.LNX.4.64.0610130139510.29022@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix parport_serial_pci_resume() ignoring return value from 
pci_enable_device(). 

(I guess that the parport_serial_pci_remove() is the right way(tm) to 
remove the device from the system in non-destructive way even in case 
pci_enable_device() failed. Tim?)

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- 

 drivers/parport/parport_serial.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index 78c0a26..ea76b5e 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -392,6 +392,7 @@ static int parport_serial_pci_suspend(st
 static int parport_serial_pci_resume(struct pci_dev *dev)
 {
 	struct parport_serial_private *priv = pci_get_drvdata(dev);
+	int err;
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
@@ -399,7 +400,14 @@ static int parport_serial_pci_resume(str
 	/*
 	 * The device may have been disabled.  Re-enable it.
 	 */
-	pci_enable_device(dev);
+	err = pci_enable_device(dev);
+	if (err) {
+		printk(KERN_ERR "parport: Cannot enable PCI device %s during resume\n", 
+				pci_name(dev));
+		parport_serial_pci_remove(dev);
+		return err;
+	}
+
 
 	if (priv->serial)
 		pciserial_resume_ports(priv->serial);

-- 
Jiri Kosina
