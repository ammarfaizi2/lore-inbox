Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932438AbWFEHGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWFEHGp (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWFEHGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:06:45 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:47017 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932438AbWFEHGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:06:44 -0400
Date: Mon, 5 Jun 2006 00:06:41 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Johannes Goecke <goecke@upb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
        Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>
Subject: [RFC PATCH] MSI-K8T-Neo2-Fir run only where needed
Message-ID: <20060605070641.GA24295@tuatara.stupidest.org>
References: <200604201600.k3KG0wwa002872@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604201600.k3KG0wwa002872@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 04:00:58PM +0000, the git-commits list sent
me:

> Subject: Re: [PATCH] MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard

> commit 7daa0c4f51897d5d956a62a2bac438e3b58d85dc
> [PATCH] MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard

> On the MSI-K8T-NEO2 FIR ( Athlon-64, Socket 939 with VIA-K8T800- Chipset
> and onboard Sound,...  ) the BIOS lets you choose "DISABLED" or "AUTO" for
> the On-Board Sound Device.

[...]

> But how to ensure that the code is executed ONLY on excactly this kind of
> boards (not any other with similar Chipset)?

The patch doesn't as-is, which means it runs on a lot of hardware
where it shoudln't.

I'm a confused lost as to why this was acked/merged when:

> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, k8t_sound_hostbridge);

clearly it will run for a wide-variety of hardware.  I think the quirk
should probably also check DMI tables or similar to detect the
board/BIOS version that it's intended for.  Certainly that would make
this safer.

I don't have access to this hardware so how about something like this
for now?

---

Be more selective when running the MSI-K8T-Neo2Fir soundcard PCI quirk
so as not to run this on hardware where it's probably not needed.


Signed-off-by: Chris Wedgwood <cw@f00f.org>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d378478..daa17fa 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -878,27 +878,30 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_I
  * when a PCI-Soundcard is added. The BIOS only gives Options
  * "Disabled" and "AUTO". This Quirk Sets the corresponding
  * Register-Value to enable the Soundcard.
+ *
+ * FIXME: Presently this quirk will run on anything that has an 8237
+ * which isn't correct, we need to check DMI tables or something in
+ * order to make sure it only runs on the MSI-K8T-Neo2Fir.  Because it
+ * runs everywhere at present we suppress the printk output in most
+ * irrelevant cases.
  */
 static void __init k8t_sound_hostbridge(struct pci_dev *dev)
 {
 	unsigned char val;
 
-	printk(KERN_INFO "PCI: Quirk-MSI-K8T Soundcard On\n");
 	pci_read_config_byte(dev, 0x50, &val);
 	if (val == 0x88 || val == 0xc8) {
+		/* Assume it's probably a MSI-K8T-Neo2Fir */
+		printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, attempting to turn soundcard ON\n");
 		pci_write_config_byte(dev, 0x50, val & (~0x40));
 
 		/* Verify the Change for Status output */
 		pci_read_config_byte(dev, 0x50, &val);
 		if (val & 0x40)
-			printk(KERN_INFO "PCI: MSI-K8T soundcard still off\n");
+			printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, soundcard still off\n");
 		else
-			printk(KERN_INFO "PCI: MSI-K8T soundcard on\n");
-	} else {
-		printk(KERN_INFO "PCI: Unexpected Value in PCI-Register: "
-					"no Change!\n");
+			printk(KERN_INFO "PCI: MSI-K8T-Neo2Fir, soundcard on\n");
 	}
-
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, k8t_sound_hostbridge);
 
