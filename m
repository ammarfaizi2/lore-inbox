Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310361AbSCBMEM>; Sat, 2 Mar 2002 07:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310364AbSCBMED>; Sat, 2 Mar 2002 07:04:03 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:63750 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S310360AbSCBMD4>; Sat, 2 Mar 2002 07:03:56 -0500
Date: Sat, 2 Mar 2002 13:03:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kristopher Kersey <augustus@linuxhardware.org>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Kernel Panics on IDE Initialization
Message-ID: <20020302130353.A24918@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0203011521450.23902-100000@penguin.linuxhardware.org> <E16gu5L-000501-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16gu5L-000501-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 01, 2002 at 08:56:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2002 at 08:56:59PM +0000, Alan Cox wrote:
> > I have word that it's the HighPoint controller's fault.  I will verify
> > this myself and let you know.
> 
> Ok

I have many reports the HPT RAID controllers cause kernels (RH 7.3
install) to crash, unfortunately because the VIA IDE spits an unrelated
warning message on many of the affected mainboards just before the HPT
code crashes ...

Well, this patch fixes two possible array overflows in the HPT code.
There is quite likely a lot more of stuff to fix.

-- 
Vojtech Pavlik
SuSE Labs

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hpt366fixes.diff"

--- hpt366.c	Thu Jan 31 16:45:20 2002
+++ hpt366.c.new	Sat Mar  2 13:00:16 2002
@@ -375,7 +375,8 @@
 		class_rev &= 0xff;
 
 		p += sprintf(p, "\nController: %d\n", i);
-		p += sprintf(p, "Chipset: HPT%s\n", chipset_nums[class_rev]);
+		p += sprintf(p, "Chipset: HPT%s\n",
+			class_rev < sizeof(chipset_nums) / sizeof(char *) ? chipset_nums[class_rev] : "???");
 		p += sprintf(p, "--------------- Primary Channel "
 				"--------------- Secondary Channel "
 				"--------------\n");
@@ -1120,12 +1121,11 @@
 	if (test != 0x08)
 		pci_write_config_byte(dev, PCI_MAX_LAT, 0x08);
 
-	if (pci_rev_check_hpt3xx(dev)) {
+	if (pci_rev_check_hpt3xx(dev))
 		init_hpt370(dev);
+
+	if (n_hpt_devs < HPT366_MAX_DEVS)
 		hpt_devs[n_hpt_devs++] = dev;
-	} else {
-		hpt_devs[n_hpt_devs++] = dev;
-	}
 	
 #if defined(DISPLAY_HPT366_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!hpt366_proc) {

--HcAYCG3uE/tztfnV--
