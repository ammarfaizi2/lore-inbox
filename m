Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283007AbRLCIvp>; Mon, 3 Dec 2001 03:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284371AbRLCItl>; Mon, 3 Dec 2001 03:49:41 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:24594 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284752AbRLCEbt>;
	Sun, 2 Dec 2001 23:31:49 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15370.65477.649725.353028@argo.ozlabs.ibm.com>
Date: Mon, 3 Dec 2001 15:29:57 +1100 (EST)
To: Alan Ford <alan@whirlnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-pre2 & PCMCIA Errors
In-Reply-To: <20011202203207.A1014@whirlnet.co.uk>
In-Reply-To: <20011202203207.A1014@whirlnet.co.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Ford writes:

> Just tried 2.4.17-pre2 (was previously on 2.4.16-pre1) and when pcmcia-cs is
> started on bootup, the following happens:
> 
> cs: IO port probe 0x0c00-0x0cff: clean.
> cs: IO port probe 0x0100-0x04ff: excluding 0x4d0-0x4d7
> cs: IO port probe 0x0a00-0x0aff: clean.
> cs: memory probe 0xa0000000-0xa0ffffff:<1>Unable to handle kernel NULL pointer
> dereference at virtual address 00000004

Please try this patch and let me know whether it fixes the problem.

Paul.

diff -urN linux-2.4.17-pre2/drivers/pcmcia/rsrc_mgr.c pmac/drivers/pcmcia/rsrc_mgr.c
--- linux-2.4.17-pre2/drivers/pcmcia/rsrc_mgr.c	Sat Dec  1 15:49:24 2001
+++ pmac/drivers/pcmcia/rsrc_mgr.c	Mon Dec  3 14:28:16 2001
@@ -107,17 +107,19 @@
 static struct resource *resource_parent(unsigned long b, unsigned long n,
 					int flags, struct pci_dev *dev)
 {
-	struct resource res;
+	struct resource res, *pr;
 
-	if (dev == NULL) {
-		if (flags & IORESOURCE_MEM)
-			return &iomem_resource;
-		return &ioport_resource;
+	if (dev != NULL) {
+		res.start = b;
+		res.end = b + n - 1;
+		res.flags = flags;
+		pr = pci_find_parent_resource(dev, &res);
+		if (pr)
+			return pr;
 	}
-	res.start = b;
-	res.end = b + n - 1;
-	res.flags = flags;
-	return pci_find_parent_resource(dev, &res);
+	if (flags & IORESOURCE_MEM)
+		return &iomem_resource;
+	return &ioport_resource;
 }
 
 static inline int check_io_resource(unsigned long b, unsigned long n,
