Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBIIKN>; Fri, 9 Feb 2001 03:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129059AbRBIIKD>; Fri, 9 Feb 2001 03:10:03 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:35602 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129030AbRBIIJw>;
	Fri, 9 Feb 2001 03:09:52 -0500
Date: Fri, 9 Feb 2001 09:09:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        "A.Sajjad Zaidi" <sajjad@vgkk.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
Message-ID: <20010209090935.A1691@suse.cz>
In-Reply-To: <E14QarA-0001DC-00@the-village.bc.nu> <Pine.LNX.4.10.10102071253121.5890-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10102071253121.5890-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Feb 07, 2001 at 12:53:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 07, 2001 at 12:53:36PM -0800, Andre Hedrick wrote:
> On Wed, 7 Feb 2001, Alan Cox wrote:
> 
> > > Iff CONFIG_BLK_DEV_IDECS is set then yes, doing schedule is better.
> > > But I do not see any benefit in doing
> > > 
> > > unsigned long timeout = jiffies + ((HZ + 19)/20) + 1;
> > > while (0 < (signed long)(timeout - jiffies));
> > 
> > On that bit we agree.
> 
> What do you want fixed?
> Send a patch and lets try it....

How about this?

-- 
Vojtech Pavlik
SuSE Labs

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pdcpatch

--- pdc202xx.c.old	Fri Jul 28 21:08:30 2000
+++ pdc202xx.c	Fri Feb  9 09:08:55 2001
@@ -747,14 +747,11 @@
 {
 	unsigned long high_16	= pci_resource_start(HWIF(drive)->pci_dev, 4);
 	byte udma_speed_flag	= inb(high_16 + 0x001f);
-	int i			= 0;
 
 	OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
-	ide_delay_50ms();
-	ide_delay_50ms();
+	mdelay(100)
 	OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
-	for (i = 0; i < 40; i++)
-		ide_delay_50ms();
+	mdelay(2000);		/* 2 seconds ?! */
 }
 
 unsigned int __init pci_init_pdc202xx (struct pci_dev *dev, const char *name)
@@ -767,7 +764,6 @@
 	if ((dev->device == PCI_DEVICE_ID_PROMISE_20262) ||
 	    (dev->device == PCI_DEVICE_ID_PROMISE_20265) ||
 	    (dev->device == PCI_DEVICE_ID_PROMISE_20267)) {
-		int i = 0;
 		/*
 		 * software reset -  this is required because the bios
 		 * will set UDMA timing on if the hdd supports it. The
@@ -779,11 +775,9 @@
 		 */
 
 		OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
-		ide_delay_50ms();
-		ide_delay_50ms();
+		mdelay(100);
 		OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
-		for (i=0; i<40; i++)
-			ide_delay_50ms();
+		mdelay(2000);	/* 2 seconds ?! */
 	}
 
 	if (dev->resource[PCI_ROM_RESOURCE].start) {

--X1bOJ3K7DJ5YkBrT--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
