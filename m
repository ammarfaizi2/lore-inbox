Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVC1Q6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVC1Q6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVC1Q6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:58:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36107 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261952AbVC1Q6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:58:41 -0500
Date: Mon, 28 Mar 2005 17:58:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Eran Mann <emann@mrv.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] paport related OOPS since 2.6.11-bk7
Message-ID: <20050328175837.A2222@flint.arm.linux.org.uk>
Mail-Followup-To: Eran Mann <emann@mrv.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <424834B7.5080805@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <424834B7.5080805@mrv.com>; from emann@mrv.com on Mon, Mar 28, 2005 at 06:45:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 06:45:43PM +0200, Eran Mann wrote:
> The OOPS below gets generated consistently when FC3 kudzu is run during 
> boot (tested between 2.6.11-bk7 and 2.6.11.6-bk1). It seems to be caused 
> by the hotplug-parport changeset:
> http://linux.bkbits.net:8080/linux-2.5/cset@4230791b6YtcIhZDSvvWbzSdUpg2zg?nav=index.html|ChangeSet@-4w
> (reverting this changeset eliminates the oops).

Please try this instead.

It appears that the parport driver claims on-board superio devices
without actually doing anything.  When the driver is removed, we
try to dereference non-existent driver data to unregister the ports.
Since we didn't register anything, it's safe to ignore these devices
in the remove function.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/parport/parport_pc.c linux/drivers/parport/parport_pc.c
--- orig/drivers/parport/parport_pc.c	Sat Mar 19 11:22:08 2005
+++ linux/drivers/parport/parport_pc.c	Mon Mar 28 17:55:51 2005
@@ -2976,10 +2976,12 @@ static void __devexit parport_pc_pci_rem
 
 	pci_set_drvdata(dev, NULL);
 
-	for (i = data->num - 1; i >= 0; i--)
-		parport_pc_unregister_port(data->ports[i]);
+	if (data) {
+		for (i = data->num - 1; i >= 0; i--)
+			parport_pc_unregister_port(data->ports[i]);
 
-	kfree(data);
+		kfree(data);
+	}
 }
 
 static struct pci_driver parport_pc_pci_driver = {

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
