Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUAOAnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266312AbUAOAm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:42:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51598 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265200AbUAOAmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:42:10 -0500
Message-ID: <4005E1D4.6040807@pobox.com>
Date: Wed, 14 Jan 2004 19:41:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: andersen@codepoet.org, Greg Stark <gsstark@mit.edu>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, mplayer@jburgess.uklinux.net
Subject: Re: Serial ATA (SATA) for Linux status report
References: <20031203204445.GA26987@gtf.org> <87hdyyxjgl.fsf@stark.xeocode.com> <20040114225653.GA32704@codepoet.org> <4005D141.7050408@superbug.demon.co.uk>
In-Reply-To: <4005D141.7050408@superbug.demon.co.uk>
Content-Type: multipart/mixed;
 boundary="------------080701060506030409060206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701060506030409060206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


I'm pretty sure the "excessive interrupts" issue was successfully 
tracked down by Jon Burgess (thanks!).  He found this post describing an 
ICH5 hardware issue,
http://www.mail-archive.com/freebsd-stable@freebsd.org/msg58421.html

and he also submitted the attached patch.

I've been meaning to rewrite his patch to isolate it more to ata_piix, 
but in the meantime maybe folks could test this?

	Jeff




--------------080701060506030409060206
Content-Type: text/plain;
 name="libata-spurious2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-spurious2.diff"

--- libata-core.c-orig	2003-12-07 01:54:19.000000000 +0000
+++ libata-core.c	2003-12-07 16:25:11.961806872 +0000
@@ -2386,6 +2386,37 @@
 }
 
 /**
+ *	ata_chk_spurious_int - Check for spurious interrupts
+ *	@ap: port to which command is being issued
+ *
+ *	Examines the DMA status registers and clears
+ *      unexpected interrupts
+ *
+ *	LOCKING:
+ */
+static inline void ata_chk_spurious_int(struct ata_port *ap) {
+	int host_stat;
+	
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	
+	if ((host_stat & (ATA_DMA_INTR | ATA_DMA_ERR | ATA_DMA_ACTIVE)) == ATA_DMA_INTR) {
+		if (ap->flags & ATA_FLAG_MMIO) {
+			void *mmio = (void *) ap->ioaddr.bmdma_addr;
+			writeb(host_stat & ~ATA_DMA_ERR, mmio + ATA_DMA_STATUS);
+		} else
+			outb(host_stat & ~ATA_DMA_ERR, ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		
+		DPRINTK("ata%u: Caught spurious interrupt, status 0x%X\n", ap->id, host_stat);
+		udelay(1);
+	}
+}
+
+
+/**
  *	ata_interrupt -
  *	@irq:
  *	@dev_instance:
@@ -2417,6 +2448,7 @@
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && ((qc->flags & ATA_QCFLAG_POLL) == 0))
 				handled += ata_host_intr(ap, qc);
+			ata_chk_spurious_int(ap);
 		}
 	}
 

--------------080701060506030409060206--

