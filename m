Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSHMOxl>; Tue, 13 Aug 2002 10:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHMOxl>; Tue, 13 Aug 2002 10:53:41 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52962 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315442AbSHMOxk>;
	Tue, 13 Aug 2002 10:53:40 -0400
Date: Tue, 13 Aug 2002 07:55:14 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, colpatch@us.ibm.com
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
Message-ID: <1849271812.1029225314@[10.10.2.3]>
In-Reply-To: <1029239133.20980.10.camel@irongate.swansea.linux.org.uk>
References: <1029239133.20980.10.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This stil has the same problems as it did last time you posted it. The
> pointless NULL check and the increased complexity over duplicating about
> 60 lines of code and having pci_conf1 ops cleanly as we do in 2.4.
> 
> The !value check is extremely bad because it turns a critical debuggable
> software error into a silent unnoticed mistake.
> 
> Fixing the code instead of just resending it might improve the changes
> of it being merged no end.

BTW, it wasn't just resent, it had all the NUMA-Q stuff stripped out
of it, and was just the core code cleanup. He's replacing 
pci_conf1_read_config_byte and pci_conf2_read_config_byte
with pci_conf_read_config_byte. The indirection level has now switched
from pci_root_ops to pci_config_(read|write). These were set up before,
but never seemed to be actually used.

I'm perfectly prepared to accept that the patch doesn't work, or is 
bad, but not for the reasons you gave. To make the thing easier to 
read, what he's effectively doing is this

-static int pci_conf1_read_config_byte(struct pci_dev *dev, int where, u8 *value)
-{
-	int result; 
-	u32 data;
-
-	if (!value) 
-		return -EINVAL;
-
-	result = pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
-		PCI_FUNC(dev->devfn), where, 1, &data);
-
-	*value = (u8)data;
-
-	return result;
-}
-
-static int pci_conf2_read_config_byte(struct pci_dev *dev, int where, u8 *value)
- {
- 	int result; 
- 	u32 data;
-	result = pci_conf2_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
- 		PCI_FUNC(dev->devfn), where, 1, &data);
- 	*value = (u8)data;
- 	return result;
- }
-static int pci_conf2_read_config_byte(struct pci_dev *dev, int where, u8 *value)
+
+static int pci_config_read_byte(struct pci_dev *dev, int where, u8 *value)
+ {
+ 	int result; 
+ 	u32 data;
+
+	if (!value) 
+		return -EINVAL;
+
+	result = pci_config_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
+		PCI_FUNC(dev->devfn), where, 1, &data);
+	*value = (u8)data;
+	return result;
+}

