Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130485AbRDSP4i>; Thu, 19 Apr 2001 11:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRDSP43>; Thu, 19 Apr 2001 11:56:29 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42172 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130485AbRDSP4P>;
	Thu, 19 Apr 2001 11:56:15 -0400
Message-ID: <3ADF0A91.F803266F@mandrakesoft.com>
Date: Thu, 19 Apr 2001 11:56:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/sound/nm256_audio.c
In-Reply-To: <20010419173502.A13934@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner wrote:
> 
> Hi,
> 
> This updates the nm256_audio driver to the 2.4 PCI API.
> 
> Patch is against 2.4.3-ac9, verified on Sony VAIO Laptop.

"verified" is the really important part with this driver, since its
really finicky.  I have a patch I would love to bounce to you in
private, that I have been searching for a tester for -months- because I
had no test hardware of my own.

Your patch looks ok to me and I would say apply it.  But I also think it
is incomplete.

* there is no need for a linked list of cards, since
pci_{get,set}_drvdata is used.  This eliminates the list walk in
nm256_remove

* the new PCI API has suspend/resume hooks, and those should be used in
preference to register_pm_...

* there is rarely a need to compare PCI ids manually in a driver.  Do
this implicitly by using the struct pci_device_id::driver_data field. 
In the following code, you could simply pass these two strings as your
driver_data:
> +    if (pcidev->device == PCI_DEVICE_ID_NEOMAGIC_NM256AV_AUDIO)
> +       return nm256_install(pcidev, REV_NM256AV, "256AV");
> +    if (pcidev->device == PCI_DEVICE_ID_NEOMAGIC_NM256ZX_AUDIO)
> +       return nm256_install(pcidev, REV_NM256ZX, "256ZX");

* typically you don't want to -always- printout the module version when
built into the kernel.  that can get ugly, when you have a bunch of
drivers in the kernel.  you should surround the existing version printk
code with ifdef MODULE, and then add some additional code in your
pci_driver::probe routine which looks something like

	#ifndef MODULE
		static int printed_version;
		if (!printed_version++)
			printk(version);
	#endif

and further, declare your version string like the following code, so it
can be dropped from the kernel image...

	static char version[] __devinitdata =
	KERN_INFO "... version ...\n";

Looks good, thanks for the work!  If you spot any other drivers you can
convert, feel free.

	Jeff


-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
