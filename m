Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135994AbREBHE2>; Wed, 2 May 2001 03:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135980AbREBHER>; Wed, 2 May 2001 03:04:17 -0400
Received: from qn-212-127-137-79.quicknet.nl ([212.127.137.79]:4 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id <S135994AbREBHEF>;
	Wed, 2 May 2001 03:04:05 -0400
Date: Wed, 2 May 2001 09:03:59 +0200
From: "Carlo E. Prelz" <fluido@fluido.as>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi module
Message-ID: <20010502090359.A484@qn-212-127-137-79.fluido.as>
In-Reply-To: <20010502083018.A5717@qn-212-127-137-79.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010502083018.A5717@qn-212-127-137-79.fluido.as>; from fluido@fluido.as on Wed, May 02, 2001 at 08:30:18AM +0200
X-operating-system: Linux qn-212-127-137-79 2.4.4-ac3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: 2.4.4, 2.4.4-ac1 and -ac3: oops loading future domain scsi module
	Date: Wed, May 02, 2001 at 08:30:18AM +0200

Quoting Carlo E. Prelz (fluido@fluido.as):

> Here I am with another, fresh oops that I encountered while exploring
> new kernels. This time, the oops is generated when trying to load the
> module for a very old (1993) Future Domain SCSI card. 2.4.3-ac7 was my
> previous kernel and worked perfectly. 

I made some more research. Eventually, it seems the problem is in this
patch that was included in 2.4.4:

@@ -969,6 +971,7 @@
        return 0;
    shpnt->irq = interrupt_level;
    shpnt->io_port = port_base;
+   scsi_set_pci_device(shpnt->pci_dev, pdev);
    shpnt->n_io_port = 0x10;
    print_banner( shpnt );

Well, but my card is ISA! It should not set any PCI device. 

I applied the following patch, and the problem disappeared:

--- fdomain.c~	Wed May  2 07:08:27 2001
+++ fdomain.c	Wed May  2 08:58:03 2001
@@ -971,6 +971,7 @@
    	return 0;
    shpnt->irq = interrupt_level;
    shpnt->io_port = port_base;
+	 if(pdev!=NULL)
    scsi_set_pci_device(shpnt->pci_dev, pdev);
    shpnt->n_io_port = 0x10;
    print_banner( shpnt );

I hope this is the right way...

Ciao
Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
