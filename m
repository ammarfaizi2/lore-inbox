Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbRAYVGS>; Thu, 25 Jan 2001 16:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135236AbRAYVGI>; Thu, 25 Jan 2001 16:06:08 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4622 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S130836AbRAYVFx>;
	Thu, 25 Jan 2001 16:05:53 -0500
Message-ID: <3A709504.5599E0F7@mandrakesoft.com>
Date: Thu, 25 Jan 2001 16:05:08 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Micah Gorrell <angelcode@myrealbox.com>
CC: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org,
        saw@saw.sw.com.sg, Alan@redhat.com
Subject: [PATCH] Re: eepro100 problems in 2.4.0
In-Reply-To: <006601c08711$4bdfb600$9b2f4189@angelw2k>
Content-Type: multipart/mixed;
 boundary="------------58ED4393A098BEE4E2400C2B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------58ED4393A098BEE4E2400C2B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Micah Gorrell wrote:
> Because of the problems we where having we are no longer using the machine
> with 3 nics.  We are now using a machine with just one and it is going live
> next week.  We do need kernel 2.4 because of the process limits in 2.2.
> Does the 'Enable Power Management (EXPERIMENTAL)' option fix the no
> resources problems?

Does the attached patch, against 2.4.1-pre10, help matters any?

pci_enable_device() must to be called before any accesses to the
pci_dev->irq and pci_dev->resource[] members.  Plug-n-play may fill in
those values.  I didn't see your original report, but "no resources"
sounds to me like pci_enable_device() needs to be called earlier in the
speedo_init_one function.  The attached patch does just that.

	Jeff


> -----Original Message-----
> From: "Tom Sightler" <ttsig@tuxyturvy.com>
> To: "Micah Gorrell" <angelcode@myrealbox.com>;
> <linux-kernel@vger.kernel.org>
> Date: Thursday, January 25, 2001 1:48 PM
> Subject: Re: eepro100 problems in 2.4.0
[...]
> >I had a similar problem with a server that had dual embedded eepro100
> >adapters however selecting the 'Enable Power Management (EXPERIMENTAL)'
> >option for the eepro100 seemed to make the problem go away.  I don't really
> >know why but it might be worth trying if it wasn't already selected.


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------58ED4393A098BEE4E2400C2B
Content-Type: text/plain; charset=us-ascii;
 name="eepro100.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eepro100.patch"

Index: drivers/net/eepro100.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/eepro100.c,v
retrieving revision 1.1.1.9.42.2
diff -u -r1.1.1.9.42.2 eepro100.c
--- drivers/net/eepro100.c	2001/01/24 15:56:16	1.1.1.9.42.2
+++ drivers/net/eepro100.c	2001/01/25 21:00:48
@@ -560,6 +560,9 @@
 	if (speedo_debug > 0  &&  did_version++ == 0)
 		printk(version);
 
+	if (pci_enable_device(pdev))
+		return -EIO;
+
 	if (!request_region(pci_resource_start(pdev, 1),
 			pci_resource_len(pdev, 1), "eepro100")) {
 		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
@@ -597,9 +600,6 @@
 		pci_read_config_word(pdev, pm + PCI_PM_CTRL, &pwr_command);
 		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
 	}
-
-	if (pci_enable_device(pdev))
-		goto err_out_free_mmio_region;
 
 	pci_set_master(pdev);
 

--------------58ED4393A098BEE4E2400C2B--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
