Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWIJWsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWIJWsg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWIJWsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:48:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48580 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964782AbWIJWsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:48:36 -0400
Date: Mon, 11 Sep 2006 00:48:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tejun Heo <htejun@gmail.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
Message-ID: <20060910224815.GC1691@elf.ucw.cz>
References: <20060908110346.GC920@elf.ucw.cz> <45015767.1090002@gmail.com> <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4501655F.5000103@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(cc-ed to the list)

> >>>Do you have SATA powersave patches somewhere handy? I found out that
> >>>SATA eats way too much power.
> >>Hello, Pavel.
> >>
> >>Do you mean link powersaving?  Or disk spindown?
> >
> >Link powersaving... disk spindown should be handled by laptop_mode +
> >hdparm -y, right?
> 
> Yes for disk spindown.  Link powersaving is in the following git tree 
> but it's ~2 months old.
> 
> http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=powersave
> git://htj.dyndns.org/libata-tj.git powersave

Thanks... I got it to work (on 2 the old tree, I was not able to
forward-port it), but power savings were not too big (~0.1W, maybe).

I'm getting huge (~1W) savings by powering down SATA controller, as in
ahci_pci_device_suspend(). It would be great to be able to power SATA
controller down, then power it back up when it is needed... I tried
following hack, but could not get it to work. Any ideas?

								Pavel

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 3e98334..b6e9f55 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -222,7 +222,7 @@ static void ahci_thaw(struct ata_port *a
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
-static int ahci_pci_device_resume(struct pci_dev *pdev);
+ int ahci_pci_device_resume(struct pci_dev *pdev);
 static int ahci_port_standby(void __iomem *port_mmio, u32 cap);
 static int ahci_port_spinup(void __iomem *port_mmio, u32 cap);
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t state);
@@ -1082,6 +1082,9 @@ static unsigned int ahci_fill_sg(struct 
 	return n_sg;
 }
 
+int suspended;
+struct pci_dev *mydev;
+
 int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
@@ -1089,6 +1092,11 @@ int ahci_pci_device_suspend(struct pci_d
 	u32 tmp;
 	int i;
 
+	if (suspended)
+		return;
+	suspended = 1;
+	mydev = pdev;
+
 	/* First suspend all ports */
 	for (i = 0; i < host_set->n_ports; i++) {
 		struct ata_port *ap;
@@ -1121,6 +1129,10 @@ int ahci_pci_device_resume(struct pci_de
 	struct ata_port *ap;
 	u32 i, tmp, irq_stat;
 
+	if (!suspended)
+		return;
+	suspended = 0;
+
 	tmp = readl(mmio + HOST_CTL);
 	if (!(tmp & HOST_AHCI_EN)) {
 		tmp |= HOST_AHCI_EN;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index e92c31d..89fb997 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2822,6 +2822,14 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 	struct Scsi_Host *shost = scsidev->host;
 	int rc = 0;
 
+	extern int suspended;
+	extern int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t state);
+	extern int ahci_pci_device_resume(struct pci_dev *pdev);
+	extern struct pci_dev *mydev;
+
+	if (suspended)
+		ahci_pci_device_resume(mydev);
+
 	ap = ata_shost_to_port(shost);
 
 	spin_unlock(shost->host_lock);




-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
