Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284938AbRLFCST>; Wed, 5 Dec 2001 21:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284940AbRLFCSB>; Wed, 5 Dec 2001 21:18:01 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:20487 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284939AbRLFCRr>;
	Wed, 5 Dec 2001 21:17:47 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15374.54521.402903.123657@argo.ozlabs.ibm.com>
Date: Thu, 6 Dec 2001 13:16:25 +1100 (EST)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix pcmcia errors
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

The PCMCIA patch that I sent you and which you included in 2.4.17-pre2
turns out to have a case where it can get a NULL pointer dereference.
The patch below fixes that.  I posted this patch on the list earlier
and the person who was having the problem (Alan Ford) reported that it
fixes the problem for him, so please include this patch in your next
release.

Thanks,
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
