Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRJ1UcL>; Sun, 28 Oct 2001 15:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278661AbRJ1Ubw>; Sun, 28 Oct 2001 15:31:52 -0500
Received: from open.your.mind.be ([195.162.205.66]:61176 "HELO
	portablue.intern.mind.be") by vger.kernel.org with SMTP
	id <S278660AbRJ1Ubm>; Sun, 28 Oct 2001 15:31:42 -0500
Date: Sun, 28 Oct 2001 21:31:54 +0100
To: linux-kernel@vger.kernel.org
Subject: USB OHCI IRQ on Digital PWS500
Message-ID: <20011028213154.B11920@mind.be>
Mail-Followup-To: p2@mind.be, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-message-flag: Get yourself a real email client. http://www.mutt.org/
From: p2@mind.be (Peter De Schrijver)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The IRQ for the 82c693 USB function is not assigned correctly to an interrupt.
This is because it's the only PCI device which has it's IRQ line connected to
the 8259 interrupt controllers iso to the PYXIS. The following patch solves
this problem. 

Comments welcome,

Peter.

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=t

--- orig/linux/arch/alpha/kernel/sys_miata.c	Sat Oct 13 00:35:53 2001
+++ linux/arch/alpha/kernel/sys_miata.c	Sun Oct 28 21:02:13 2001
@@ -176,6 +176,19 @@
 		{   -1,    -1,    -1,    -1,    -1},  /* IdSel 31,  PCI-PCI */
         };
 	const long min_idsel = 3, max_idsel = 20, irqs_per_slot = 5;
+	
+	/* the USB function of the 82c693 has it's interrupt connected to 
+           the 2nd 8259 controller. So we have to check for it first. */
+
+	if((slot == 7) && (PCI_FUNC(dev->devfn) == 3)) {
+		u8 irq=0;
+
+		if(pci_read_config_byte(pci_find_slot(dev->bus->number, dev->devfn & ~(7)), 0x40,&irq)!=PCIBIOS_SUCCESSFUL)
+			return -1;
+		else	
+			return irq;
+	}
+
 	return COMMON_TABLE_LOOKUP;
 }


--vtzGhvizbBRQ85DL--
