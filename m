Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbTLRVol (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265357AbTLRVol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:44:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265356AbTLRVog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:44:36 -0500
Date: Thu, 18 Dec 2003 16:44:26 -0500
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: Kernel 2.6.0 small fixes
Message-ID: <20031218214426.GA16223@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Term ends and Linus releases 2.6.0 specially for me 8)

I gave it a brief spin and hit a few problems. Looking over the code I notice
the local crash/root elevation fixes from 2.4 fs/exec.c aren't in 2.6 or are
done differently. Have I missed the alternate fix

The fixes follow

Capability elevation bug in 2.6.0 IDE. Long fixed in 2.4.x, trivial to cure

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0/drivers/ide/ide.c linux-2.6.0-ac1/drivers/ide/ide.c
--- linux-2.6.0/drivers/ide/ide.c	2003-12-18 02:58:38.000000000 +0000
+++ linux-2.6.0-ac1/drivers/ide/ide.c	2003-12-18 21:11:54.000000000 +0000
@@ -1632,12 +1632,12 @@
 #endif /* CONFIG_IDE_TASK_IOCTL */
 
 		case HDIO_DRIVE_CMD:
-			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			if (!capable(CAP_SYS_RAWIO))
 				return -EACCES;
 			return ide_cmd_ioctl(drive, cmd, arg);
 
 		case HDIO_DRIVE_TASK:
-			if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+			if (!capable(CAP_SYS_RAWIO))
 				return -EACCES;
 			return ide_task_ioctl(drive, cmd, arg);
 


IDE core code had the mmio==2 (ioremap) mode supported but two small changes had
been missed for ide-dma.c. Without this fix mmio IDE controllers bomb if you have
plenty of memory as it uses request_mem_region on an ioremap return.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0/drivers/ide/ide-dma.c linux-2.6.0-ac1/drivers/ide/ide-dma.c
--- linux-2.6.0/drivers/ide/ide-dma.c	2003-12-18 02:58:49.000000000 +0000
+++ linux-2.6.0-ac1/drivers/ide/ide-dma.c	2003-12-18 21:29:22.000000000 +0000
@@ -925,11 +925,13 @@
  */
 int ide_release_dma (ide_hwif_t *hwif)
 {
+	if (hwif->mmio == 2)
+		return 1;
 	if (hwif->chipset == ide_etrax100)
 		return 1;
 
 	ide_release_dma_engine(hwif);
-	if (hwif->mmio)
+	if (hwif->mmio == 1)
 		return ide_release_mmio_dma(hwif);
 	return ide_release_iomio_dma(hwif);
 }
@@ -986,6 +988,21 @@
 	return 1;
 }
 
+int ide_mapped_mmio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+{
+	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
+
+	hwif->dma_base = base;
+	if (hwif->cds->extra && hwif->channel == 0)
+		hwif->dma_extra = hwif->cds->extra;
+	
+	if(hwif->mate)
+		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
+	else
+		hwif->dma_master = base;
+	return 0;
+}
+
 int ide_iomio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
@@ -1020,7 +1037,9 @@
  */
 int ide_dma_iobase (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
-	if (hwif->mmio)
+	if (hwif->mmio == 2)
+		return ide_mapped_mmio_dma(hwif, base,ports);
+	if (hwif->mmio == 1)
 		return ide_mmio_dma(hwif, base, ports);
 	return ide_iomio_dma(hwif, base, ports);
 }

Just a warning fix and behaviour tidy. Changing the kiss.mintime variable isn't
going to work as its exposed to user space

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0/drivers/net/hamradio/scc.c linux-2.6.0-ac1/drivers/net/hamradio/scc.c
--- linux-2.6.0/drivers/net/hamradio/scc.c	2003-12-18 02:59:27.000000000 +0000
+++ linux-2.6.0-ac1/drivers/net/hamradio/scc.c	2003-12-18 20:47:11.000000000 +0000
@@ -1196,11 +1196,7 @@
  	if (scc->stat.tx_state == TXS_TIMEOUT)		/* we had a timeout? */
  	{
  		scc->stat.tx_state = TXS_WAIT;
-
- 		if (scc->kiss.mintime != TIMER_OFF)	/* try it again */
- 			scc_start_tx_timer(scc, t_dwait, scc->kiss.mintime*100);
- 		else
- 			scc_start_tx_timer(scc, t_dwait, 0);
+		scc_start_tx_timer(scc, t_dwait, scc->kiss.mintime*100);
  		return;
  	}
  	
@@ -1274,8 +1270,7 @@
 	del_timer(&scc->tx_wdog);
 
 	scc_key_trx(scc, TX_OFF);
-
-	if (scc->kiss.mintime != TIMER_OFF)
+	if(scc->kiss.mintime)
 		scc_start_tx_timer(scc, t_dwait, scc->kiss.mintime*100);
 	scc->stat.tx_state = TXS_WAIT;
 }


Type errors, just fixes a warning


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0/drivers/net/wan/cycx_drv.c linux-2.6.0-ac1/drivers/net/wan/cycx_drv.c
--- linux-2.6.0/drivers/net/wan/cycx_drv.c	2003-12-18 02:58:57.000000000 +0000
+++ linux-2.6.0-ac1/drivers/net/wan/cycx_drv.c	2003-12-18 20:42:35.000000000 +0000
@@ -425,7 +425,7 @@
 	if (cksum != cfm->checksum) {
 		printk(KERN_ERR "%s:%s: firmware corrupted!\n",
 				modname, __FUNCTION__);
-		printk(KERN_ERR " cdsize = 0x%lx (expected 0x%lx)\n",
+		printk(KERN_ERR " cdsize = 0x%x (expected 0x%x)\n",
 				len - sizeof(struct cycx_firmware) - 1,
 				cfm->info.codesize);
 		printk(KERN_ERR " chksum = 0x%x (expected 0x%x)\n",



VIA audio had a fix from 2.4 missing so any user could spam the system log. Also
include a fix for a bug which is pending 2.4 fixing too and causes a bogus
warning to be displayed on close of audio file handle.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0/sound/oss/via82cxxx_audio.c linux-2.6.0-ac1/sound/oss/via82cxxx_audio.c
--- linux-2.6.0/sound/oss/via82cxxx_audio.c	2003-12-18 02:58:38.000000000 +0000
+++ linux-2.6.0-ac1/sound/oss/via82cxxx_audio.c	2003-12-18 20:50:35.000000000 +0000
@@ -15,7 +15,7 @@
  */
 
 
-#define VIA_VERSION	"1.9.1-ac3-2.5"
+#define VIA_VERSION	"1.9.1-ac4-2.5"
 
 
 #include <linux/config.h>
@@ -1237,7 +1237,6 @@
 		}
 	/* unknown */
 	default:
-		printk (KERN_WARNING PFX "unknown number of channels\n");
 		val = -EINVAL;
 		break;
 	}
@@ -3367,7 +3366,7 @@
 
 	if (file->f_mode & FMODE_WRITE) {
 		rc = via_dsp_drain_playback (card, &card->ch_out, nonblock);
-		if (rc && rc != ERESTARTSYS)	/* Nobody needs to know about ^C */
+		if (rc && rc != -ERESTARTSYS)	/* Nobody needs to know about ^C */
 			printk (KERN_DEBUG "via_audio: ignoring drain playback error %d\n", rc);
 
 		via_chan_free (card, &card->ch_out);






