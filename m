Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRA2TBT>; Mon, 29 Jan 2001 14:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbRA2TBJ>; Mon, 29 Jan 2001 14:01:09 -0500
Received: from [195.71.115.196] ([195.71.115.196]:17818 "HELO
	demdwug7.mediaways.net") by vger.kernel.org with SMTP
	id <S129399AbRA2TAw>; Mon, 29 Jan 2001 14:00:52 -0500
Date: Mon, 29 Jan 2001 20:02:02 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>,
        Robert Siemer <siemer@panorama.hadiko.de>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI IRQ routing problem in 2.4.0 (updated patch)
In-Reply-To: <Pine.LNX.4.10.10101290928060.9131-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101291859220.29065-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Linus Torvalds wrote:

> 	reg = pirq;
> 	if (reg < 5)
> 		reg += 0x40;

or adding the 0x41..0x44 cases to the switch statement in my patch?

> > BTW: I was wondering, why we did not update the PCI_INTERRUPT_LINE in
> 
> I would prefer _not_ to see this.
> 
> Why? Because it's (a) real information what the PCI config space was, and
> it might help debug things in the future. And (b) I've seen to many broken
> BIOSes that do not re-initialize hardware fully over a soft boot, that I
> worry that you'll get different behaviour after doing a "shutdown -r" with
> this.

Ok, good reason, I believe - so I've dropped this again.

Below is the updated patch. It should handle both (0x01/0x41
like) mappings. I can (and did) only test the 0x01 case.
USBIRQ routing (0x62) supported, IDE/ACPI/DAQ untouched.

Martin

-----

--- linux-2.4.0/arch/i386/kernel/pci-irq.c.orig	Mon Jan  8 14:45:35 2001
+++ linux-2.4.0/arch/i386/kernel/pci-irq.c	Mon Jan 29 19:56:44 2001
@@ -234,22 +234,107 @@
 	return 1;
 }
 
+/*
+ *	PIRQ routing for SiS 85C503 router used in several SiS chipsets
+ *	According to the SiS 5595 datasheet (preliminary V1.0, 12/24/1997)
+ *	the related registers work as follows:
+ *	
+ *	general: one byte per re-routable IRQ,
+ *		 bit 7      IRQ mapping enabled (0) or disabled (1)
+ *		 bits [6:4] reserved
+ *		 bits [3:0] IRQ to map to
+ *		     allowed: 3-7, 9-12, 14-15
+ *		     reserved: 0, 1, 2, 8, 13
+ *
+ *	individual registers in device config space:
+ *
+ *	0x41/0x42/0x43/0x44:	PCI INT A/B/C/D - bits as in general case
+ *
+ *	0x61:			IDEIRQ: bits as in general case - but:
+ *				bits [6:5] must be written 01
+ *				bit 4 channel-select primary (0), secondary (1)
+ *
+ *	0x62:			USBIRQ: bits as in general case - but:
+ *				bit 4 OHCI function disabled (0), enabled (1)
+ *	
+ *	0x6a:			ACPI/SCI IRQ - bits as in general case
+ *
+ *	0x7e:			Data Acq. Module IRQ - bits as in general case
+ *
+ *	Apparently there are systems implementing PCI routing table using both
+ *	link values 0x01-0x04 and 0x41-0x44 for PCI INTA..D, but register offsets
+ *	like 0x62 as link values for USBIRQ e.g. So there is no simple
+ *	"register = offset + pirq" relation.
+ *	Currently we support PCI INTA..D and USBIRQ and try our best to handle
+ *	both link mappings.
+ *	IDE/ACPI/DAQ mapping is currently unsupported (left untouched as set by BIOS).
+ */
+
 static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
 	u8 x;
-	int reg = 0x41 + (pirq - 'A') ;
+	int reg = pirq;
 
-	pci_read_config_byte(router, reg, &x);
+	switch(pirq) {
+		case 0x01:
+		case 0x02:
+		case 0x03:
+		case 0x04:
+			reg += 0x40;
+		case 0x41:
+		case 0x42:
+		case 0x43:
+		case 0x44:
+		case 0x62:
+			pci_read_config_byte(router, reg, &x);
+			if (reg != 0x62)
+				break;
+			if (!(x & 0x40))
+				return 0;
+			break;
+		case 0x61:
+		case 0x6a:
+		case 0x7e:
+			printk("SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented\n");
+			return 0;
+		default:			
+			printk("SiS router pirq escape (%d)\n", pirq);
+			return 0;
+	}
 	return (x & 0x80) ? 0 : (x & 0x0f);
 }
 
 static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
 	u8 x;
-	int reg = 0x41 + (pirq - 'A') ;
+	int reg = pirq;
 
-	pci_read_config_byte(router, reg, &x);
-	x = (pirq & 0x20) ? 0 : (irq & 0x0f);
+	switch(pirq) {
+		case 0x01:
+		case 0x02:
+		case 0x03:
+		case 0x04:
+			reg += 0x40;
+		case 0x41:
+		case 0x42:
+		case 0x43:
+		case 0x44:
+		case 0x62:
+			x = (irq&0x0f) ? (irq&0x0f) : 0x80;
+			if (reg != 0x62)
+				break;
+			/* always mark OHCI enabled, as nothing else knows about this */
+			x |= 0x40;
+			break;
+		case 0x61:
+		case 0x6a:
+		case 0x7e:
+			printk("advanced SiS pirq mapping not yet implemented\n");
+			return 0;
+		default:			
+			printk("SiS router pirq escape (%d)\n", pirq);
+			return 0;
+	}
 	pci_write_config_byte(router, reg, x);
 
 	return 1;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
