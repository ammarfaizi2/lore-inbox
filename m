Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWF2SdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWF2SdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWF2SdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:33:02 -0400
Received: from outbound-mail-28.bluehost.com ([67.138.240.198]:464 "HELO
	outbound-mail-28.bluehost.com") by vger.kernel.org with SMTP
	id S1751253AbWF2SdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:33:01 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Robert Nagy" <robert.nagy@gmail.com>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Date: Thu, 29 Jun 2006 11:32:51 -0700
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <39f633820606290818g1978866ap@mail.gmail.com>
In-Reply-To: <39f633820606290818g1978866ap@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TzBpEd1LMDbxL6s"
Message-Id: <200606291132.51866.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 71.198.43.183 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_TzBpEd1LMDbxL6s
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, June 29, 2006 8:18 am, Robert Nagy wrote:
> Hi,
>
> Distribution: Debian testing/unstable
> Hardware Environment: SGI Altix 350, 2xItanium 2, EFI (read dmesg)
> http://bsd.hu/~robert/altix.dmesg
> http://bsd.hu/~robert/altix.kconf
>
> Problem Description: I've installed an Intel(r) RAID Controller
> SRCU42X (PCI-X) controller to this machine.
> http://www.intel.com/design/servers/raid/srcu42x/index.htm
> I've never used such a controller so if someone has any idea about
> this please tell me. The dmesg will show everyhing, but:
>
> megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
> megaraid: 2.20.4.8 (Release Date: Mon Apr 11 12:27:22 EST 2006)
> megaraid: probe new device 0x1000:0x0407:0x8086:0x0532: bus 2:slot
> 0:func 0 megaraid: out of memory, megaraid_alloc_cmd_packets 965
> megaraid: maibox adapter did not initialize

IIRC some Altix boxes don't support 32 bit DMA for PCI-X devices.  Based 
on the initialization code I looked at (just a quick scan), it looks 
like the command packet initialization is done before the switch to a 64 
bit DMA mask, which might cause the failure you see here.  You can try 
this patch out (totally untested).  It's not fully correct, it should 
probably try 64 bit first then fall back to 32 bit if that fails then 
give up, and the other 64 bit DMA mask call should probably be removed.

Anyway, good luck.  If this one doesn't work you'll have to talk with one 
of the SGI guys and get some more debug info about the allocation 
failure for the command packets.

Jesse

--Boundary-00=_TzBpEd1LMDbxL6s
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="megaraid-dma-mask-hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="megaraid-dma-mask-hack.patch"

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index b7caf60..032a3d7 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -457,7 +457,7 @@ megaraid_probe_one(struct pci_dev *pdev,
 
 	// Setup the default DMA mask. This would be changed later on
 	// depending on hardware capabilities
-	if (pci_set_dma_mask(adapter->pdev, DMA_32BIT_MASK) != 0) {
+	if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) != 0) {
 
 		con_log(CL_ANN, (KERN_WARNING
 			"megaraid: pci_set_dma_mask failed:%d\n", __LINE__));

--Boundary-00=_TzBpEd1LMDbxL6s--
