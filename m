Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285361AbRLGBPu>; Thu, 6 Dec 2001 20:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285362AbRLGBPj>; Thu, 6 Dec 2001 20:15:39 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:60932 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285361AbRLGBPa>;
	Thu, 6 Dec 2001 20:15:30 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15376.5884.936760.549470@argo.ozlabs.ibm.com>
Date: Fri, 7 Dec 2001 12:10:20 +1100 (EST)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix pcmcia errors
In-Reply-To: <Pine.LNX.4.21.0112061238210.20750-100000@freak.distro.conectiva>
In-Reply-To: <15374.54521.402903.123657@argo.ozlabs.ibm.com>
	<Pine.LNX.4.21.0112061238210.20750-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

> As David commented, you're using PCI code unconditionally.
> 
> Could you please fix that ? 

Sure, here is a new patch against 2.4.17-pre5.  I tried compiling this
up on an intel box with CONFIG_PCI = n and CONFIG_PCMCIA = y and it
compiled OK.  The only change from my last patch is the addition of
#ifdef CONFIG_PCI around the bit that does the
pci_find_parent_resource call.

Thanks,
Paul.

diff -urN linux-2.4.17-pre5/drivers/pcmcia/rsrc_mgr.c pmac/drivers/pcmcia/rsrc_mgr.c
--- linux-2.4.17-pre5/drivers/pcmcia/rsrc_mgr.c	Fri Dec  7 07:55:31 2001
+++ pmac/drivers/pcmcia/rsrc_mgr.c	Fri Dec  7 08:55:24 2001
@@ -107,17 +107,21 @@
 static struct resource *resource_parent(unsigned long b, unsigned long n,
 					int flags, struct pci_dev *dev)
 {
-	struct resource res;
+#ifdef CONFIG_PCI
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
+#endif /* CONFIG_PCI */
+	if (flags & IORESOURCE_MEM)
+		return &iomem_resource;
+	return &ioport_resource;
 }
 
 static inline int check_io_resource(unsigned long b, unsigned long n,
