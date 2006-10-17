Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWJQVNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWJQVNG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWJQVNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:13:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6917 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750884AbWJQVNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:13:04 -0400
Date: Tue, 17 Oct 2006 23:13:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Prakash Punnoor <prakash@punnoor.de>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>, perex@suse.cz,
       alsa-devel@alsa-project.org, hnguyen@de.ibm.com
Subject: [RFC: 2.6.19 patch] snd-hda-intel: default MSI to off
Message-ID: <20061017211301.GE3502@stusta.de>
References: <200610050938.10997.prakash@punnoor.de> <5aa69f860610051030l7323ec2el545873570052f077@mail.gmail.com> <200610052309.01155.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610052309.01155.prakash@punnoor.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 11:08:57PM +0200, Prakash Punnoor wrote:
> Am Donnerstag 05 Oktober 2006 19:30 schrieb Fatih A????c??:
> > 2006/10/5, Prakash Punnoor <prakash@punnoor.de>:
> > > Hi,
> > >
> > > subjects say it all. Without irqpoll my nic doesn't work anymore. I added
> > > Ingo
> > > to cc, as my IRQs look different, so it may be a prob of APIC routing or
> > > the
> > > like.
> 
> > > Can you try booting with pci=nomsi ? I have a similar problem with my
> 
> I used snd-hda-intel.disable_msi=1 and this actually helped! Now the nforce 
> nic works w/o problems. So it was the audio driver causing havoc on the nic. 
>...

Unless someone finds and fixes what causes such problems, I'd therefore 
suggest the patch below to let MSI support to be turned off by default.

cu
Adrian


<--  snip  -->


As reported in http://lkml.org/lkml/2006/10/7/164, MSI support in 
snd-hda-intel seems to break some previously working setups.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/sound/alsa/ALSA-Configuration.txt |    2 +-
 sound/pci/hda/hda_intel.c                       |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6/Documentation/sound/alsa/ALSA-Configuration.txt.old	2006-10-17 18:11:48.000000000 +0200
+++ linux-2.6/Documentation/sound/alsa/ALSA-Configuration.txt	2006-10-17 18:12:54.000000000 +0200
@@ -753,7 +753,7 @@
     position_fix - Fix DMA pointer (0 = auto, 1 = none, 2 = POSBUF, 3 = FIFO size)
     single_cmd  - Use single immediate commands to communicate with
 		codecs (for debugging only)
-    disable_msi - Disable Message Signaled Interrupt (MSI)
+    enable_msi - Enable Message Signaled Interrupt (MSI)
 
     This module supports one card and autoprobe.
 
--- linux-2.6/sound/pci/hda/hda_intel.c.old	2006-10-17 18:10:05.000000000 +0200
+++ linux-2.6/sound/pci/hda/hda_intel.c	2006-10-17 18:10:56.000000000 +0200
@@ -55,7 +55,7 @@
 static int position_fix;
 static int probe_mask = -1;
 static int single_cmd;
-static int disable_msi;
+static int enable_msi;
 
 module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for Intel HD audio interface.");
@@ -69,8 +69,8 @@
 MODULE_PARM_DESC(probe_mask, "Bitmask to probe codecs (default = -1).");
 module_param(single_cmd, bool, 0444);
 MODULE_PARM_DESC(single_cmd, "Use single command to communicate with codecs (for debugging only).");
-module_param(disable_msi, int, 0);
-MODULE_PARM_DESC(disable_msi, "Disable Message Signaled Interrupt (MSI)");
+module_param(enable_msi, int, 0);
+MODULE_PARM_DESC(enable_msi, "Enable Message Signaled Interrupt (MSI)");
 
 
 /* just for backward compatibility */
@@ -1381,7 +1381,7 @@
 	azx_free_cmd_io(chip);
 	if (chip->irq >= 0)
 		free_irq(chip->irq, chip);
-	if (!disable_msi)
+	if (enable_msi)
 		pci_disable_msi(chip->pci);
 	pci_disable_device(pci);
 	pci_save_state(pci);
@@ -1395,7 +1395,7 @@
 
 	pci_restore_state(pci);
 	pci_enable_device(pci);
-	if (!disable_msi)
+	if (enable_msi)
 		pci_enable_msi(pci);
 	/* FIXME: need proper error handling */
 	request_irq(pci->irq, azx_interrupt, IRQF_DISABLED|IRQF_SHARED,
@@ -1437,7 +1437,7 @@
 
 	if (chip->irq >= 0) {
 		free_irq(chip->irq, (void*)chip);
-		if (!disable_msi)
+		if (enable_msi)
 			pci_disable_msi(chip->pci);
 	}
 	if (chip->remap_addr)
@@ -1523,7 +1523,7 @@
 		goto errout;
 	}
 
-	if (!disable_msi)
+	if (enable_msi)
 		pci_enable_msi(pci);
 
 	if (request_irq(pci->irq, azx_interrupt, IRQF_DISABLED|IRQF_SHARED,

