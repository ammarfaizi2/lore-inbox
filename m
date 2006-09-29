Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbWI2IfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWI2IfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161410AbWI2IfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:35:21 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:49507 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161142AbWI2IfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:35:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=2st3WhrB+/wg2YJjHXyLXMKMvcQdsx7KdtPP2pk3fejmlWjIULd2frK40klSesC34JzoA9HKSSOodoyscYbSHEpVp+k//DHgOUB73vGzpZkmWyuxzTau9N1tvzkW7RCF9tyVdKbY5PBNx6v0zE5VuDLiDq6cVlf9vVDMUuDts6M=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-pcmcia@lists.infradead.org
Subject: [patch 2.6.18-git] omap_cf works again (sync with linux-omap tree)
Date: Fri, 29 Sep 2006 01:35:15 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609290135.16152.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This syncs the omap_cf driver with the one from the linux-omap tree.
Changes include fixing build warnings (section mismatch, unused
return value) and coping with various pcmcia core changes related
to managing i/o memory and irq resources.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: osk/drivers/pcmcia/omap_cf.c
===================================================================
--- osk.orig/drivers/pcmcia/omap_cf.c	2006-09-29 00:43:51.000000000 -0700
+++ osk/drivers/pcmcia/omap_cf.c	2006-09-29 01:03:20.000000000 -0700
@@ -67,6 +67,7 @@ struct omap_cf_socket {
 	struct platform_device	*pdev;
 	unsigned long		phys_cf;
 	u_int			irq;
+	struct resource		iomem;
 };
 
 #define	POLL_INTERVAL		(2 * HZ)
@@ -112,16 +113,14 @@ static int omap_cf_get_status(struct pcm
 	if (!sp)
 		return -EINVAL;
 
-	/* FIXME power management should probably be board-specific:
-	 *  - 3VCARD vs XVCARD (OSK only handles 3VCARD)
-	 *  - POWERON (switched on/off by set_socket)
-	 */
+	/* NOTE CF is always 3VCARD */
 	if (omap_cf_present()) {
 		struct omap_cf_socket	*cf;
 
 		*sp = SS_READY | SS_DETECT | SS_POWERON | SS_3VCARD;
 		cf = container_of(s, struct omap_cf_socket, socket);
-		s->irq.AssignedIRQ = cf->irq;
+		s->irq.AssignedIRQ = 0;
+		s->pci_irq = cf->irq;
 	} else
 		*sp = 0;
 	return 0;
@@ -132,7 +131,7 @@ omap_cf_set_socket(struct pcmcia_socket 
 {
 	u16		control;
 
-	/* FIXME some non-OSK boards will support power switching */
+	/* REVISIT some non-OSK boards may support power switching */
 	switch (s->Vcc) {
 	case 0:
 	case 33:
@@ -204,7 +203,7 @@ static struct pccard_operations omap_cf_
  * "what chipselect is used".  Boards could want more.
  */
 
-static int __init omap_cf_probe(struct device *dev)
+static int __devinit omap_cf_probe(struct device *dev)
 {
 	unsigned		seg;
 	struct omap_cf_socket	*cf;
@@ -253,6 +252,9 @@ static int __init omap_cf_probe(struct d
 	default:
 		goto  fail1;
 	}
+	cf->iomem.start = cf->phys_cf;
+	cf->iomem.end = cf->iomem.end + SZ_8K - 1;
+	cf->iomem.flags = IORESOURCE_MEM;
 
 	/* pcmcia layer only remaps "real" memory */
 	cf->socket.io_offset = (unsigned long)
@@ -296,6 +298,7 @@ static int __init omap_cf_probe(struct d
 	cf->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP
 				| SS_CAP_MEM_ALIGN;
 	cf->socket.map_size = SZ_2K;
+	cf->socket.io[0].res = &cf->iomem;
 
 	status = pcmcia_register_socket(&cf->socket);
 	if (status < 0)
@@ -334,15 +337,15 @@ static struct device_driver omap_cf_driv
 	.bus		= &platform_bus_type,
 	.probe		= omap_cf_probe,
 	.remove		= __devexit_p(omap_cf_remove),
-	.suspend 	= pcmcia_socket_dev_suspend,
-	.resume 	= pcmcia_socket_dev_resume,
+	.suspend	= pcmcia_socket_dev_suspend,
+	.resume		= pcmcia_socket_dev_resume,
 };
 
 static int __init omap_cf_init(void)
 {
 	if (cpu_is_omap16xx())
-		driver_register(&omap_cf_driver);
-	return 0;
+		return driver_register(&omap_cf_driver);
+	return -ENODEV;
 }
 
 static void __exit omap_cf_exit(void)
