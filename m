Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRA0QbF>; Sat, 27 Jan 2001 11:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129399AbRA0Qaz>; Sat, 27 Jan 2001 11:30:55 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22798 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129292AbRA0Qau>;
	Sat, 27 Jan 2001 11:30:50 -0500
Message-ID: <3A72F7B0.9F6AA989@mandrakesoft.com>
Date: Sat, 27 Jan 2001 11:30:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
CC: linux-kernel@vger.kernel.org, Scott Robinson <scott@tranzoa.com>
Subject: Re: eepro100 problems in 2.4.0
In-Reply-To: <006601c08711$4bdfb600$9b2f4189@angelw2k> <3A709504.5599E0F7@mandrakesoft.com> <3A70985F.E5A0AB7F@mandrakesoft.com> <20010126085037.B467@saw.sw.com.sg>
Content-Type: multipart/mixed;
 boundary="------------D52E08EA32A9D859913BF258"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D52E08EA32A9D859913BF258
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrey Savochkin wrote:
> 
> Hi,
> 
> On Thu, Jan 25, 2001 at 04:19:27PM -0500, Jeff Garzik wrote:
> > Oops, sorry guys.  Thanks to DaveM for correcting me -- my patch has
> > nothing to do with the "card reports no resources" problem.  My
> > apologies.
> 
> No problems.
> 
> However, there is a real problem with eepro100 when the system resumes
> operations after a sleep.
> May be, you could guess what's wrong in this case?

The regions shouldn't be disabled, the attached patch (against
2.4.1-pre10) adds a call to pci_enable_device to enable things in
eepro100_resume().

It also includes the patch I posted previously; the patch itself is
correct -- the pci_enable_device call should be moved up -- however it
was my description of the patch ("fixes 'card has no resources'") which
was completely incorrect.

Scott, does the attached patch help you out?

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------D52E08EA32A9D859913BF258
Content-Type: text/plain; charset=us-ascii;
 name="eepro100.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eepro100.patch"

Index: linux_2_4/drivers/net/eepro100.c
diff -u linux_2_4/drivers/net/eepro100.c:1.1.1.9 linux_2_4/drivers/net/eepro100.c:1.1.1.9.42.4
--- linux_2_4/drivers/net/eepro100.c:1.1.1.9	Sat Nov 25 15:53:20 2000
+++ linux_2_4/drivers/net/eepro100.c	Sat Jan 27 08:27:00 2001
@@ -560,6 +560,9 @@
 	if (speedo_debug > 0  &&  did_version++ == 0)
 		printk(version);
 
+	if (pci_enable_device(pdev))
+		return -EIO;
+
 	if (!request_region(pci_resource_start(pdev, 1),
 			pci_resource_len(pdev, 1), "eepro100")) {
 		printk (KERN_ERR "eepro100: cannot reserve I/O ports\n");
@@ -598,9 +601,6 @@
 		acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
 	}
 
-	if (pci_enable_device(pdev))
-		goto err_out_free_mmio_region;
-
 	pci_set_master(pdev);
 
 	if (speedo_found1(pdev, ioaddr, cards_found, acpi_idle_state) == 0)
@@ -2146,6 +2146,13 @@
 	struct net_device *dev = pdev->driver_data;
 	struct speedo_private *sp = (struct speedo_private *)dev->priv;
 	long ioaddr = dev->base_addr;
+
+	/* Make sure power state is D0, a.k.a. alive, and also
+	 * make sure PIO and MMIO are active.  Apparently some
+	 * cases exist where PCI_COMMAND_{IO,MEM} is not set when
+	 * we return from resume. -jgarzik
+	 */
+	pci_enable_device(pdev);
 
 	/* I'm absolutely uncertain if this part of code may work.
 	   The problems are:

--------------D52E08EA32A9D859913BF258--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
