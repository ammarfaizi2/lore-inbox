Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965665AbWKDU3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965665AbWKDU3v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965670AbWKDU3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:29:37 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:54976 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965665AbWKDU32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:29:28 -0500
Message-id: <24630301851426730718@wsc.cz>
Subject: [PATCH 8/8] Char: istallion, correct fail paths
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 21:29:39 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, correct fail paths

Check more retvals and react somehow.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit e0b3045495be40ba0bdfb170732b8bcd5f4dc816
tree 574fc371fd14b172ec00289b6e423537b80193e1
parent 0e8470b600af83b7421c85d85c1b7c9b63ad21aa
author Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 21:25:03 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 21:25:03 +0059

 Makefile                 |    2 -
 drivers/char/istallion.c |  142 ++++++++++++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 62 deletions(-)

diff --git a/Makefile b/Makefile
index 9d418e2..08906f4 100644
--- a/Makefile
+++ b/Makefile
@@ -313,7 +313,7 @@ LINUXINCLUDE    := -Iinclude \
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+                   -fno-strict-aliasing -fno-common -W -Wno-unused
 AFLAGS          := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 0502e5d..b567519 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -776,11 +776,6 @@ static void __exit istallion_module_exit
 	}
 
 	i = tty_unregister_driver(stli_serial);
-	if (i) {
-		printk("STALLION: failed to un-register tty driver, "
-			"errno=%d\n", -i);
-		return;
-	}
 	put_tty_driver(stli_serial);
 	for (j = 0; j < 4; j++)
 		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, j));
@@ -3278,17 +3273,18 @@ static int stli_initecp(struct stlibrd *
 	cdkecpsig_t __iomem *sigsp;
 	unsigned int status, nxtid;
 	char *name;
-	int panelnr, nrports;
+	int retval, panelnr, nrports;
 
-	if (!request_region(brdp->iobase, brdp->iosize, "istallion"))
-		return -EIO;
-	
-	if ((brdp->iobase == 0) || (brdp->memaddr == 0))
-	{
-		release_region(brdp->iobase, brdp->iosize);
-		return -ENODEV;
+	if ((brdp->iobase == 0) || (brdp->memaddr == 0)) {
+		retval = -ENODEV;
+		goto err;
 	}
 
+	if (!request_region(brdp->iobase, brdp->iosize, "istallion")) {
+		retval = -EIO;
+		goto err;
+	}
+	
 	brdp->iosize = ECP_IOSIZE;
 
 /*
@@ -3350,8 +3346,8 @@ static int stli_initecp(struct stlibrd *
 		break;
 
 	default:
-		release_region(brdp->iobase, brdp->iosize);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto err_reg;
 	}
 
 /*
@@ -3363,10 +3359,9 @@ static int stli_initecp(struct stlibrd *
 	EBRDINIT(brdp);
 
 	brdp->membase = ioremap(brdp->memaddr, brdp->memsize);
-	if (brdp->membase == NULL)
-	{
-		release_region(brdp->iobase, brdp->iosize);
-		return -ENOMEM;
+	if (brdp->membase == NULL) {
+		retval = -ENOMEM;
+		goto err_reg;
 	}
 
 /*
@@ -3379,12 +3374,9 @@ static int stli_initecp(struct stlibrd *
 	memcpy_fromio(&sig, sigsp, sizeof(cdkecpsig_t));
 	EBRDDISABLE(brdp);
 
-	if (sig.magic != cpu_to_le32(ECP_MAGIC))
-	{
-		release_region(brdp->iobase, brdp->iosize);
-		iounmap(brdp->membase);
-		brdp->membase = NULL;
-		return -ENODEV;
+	if (sig.magic != cpu_to_le32(ECP_MAGIC)) {
+		retval = -ENODEV;
+		goto err_unmap;
 	}
 
 /*
@@ -3409,6 +3401,13 @@ static int stli_initecp(struct stlibrd *
 
 	brdp->state |= BST_FOUND;
 	return 0;
+err_unmap:
+	iounmap(brdp->membase);
+	brdp->membase = NULL;
+err_reg:
+	release_region(brdp->iobase, brdp->iosize);
+err:
+	return retval;
 }
 
 /*****************************************************************************/
@@ -3423,18 +3422,22 @@ static int stli_initonb(struct stlibrd *
 	cdkonbsig_t sig;
 	cdkonbsig_t __iomem *sigsp;
 	char *name;
-	int i;
+	int i, retval;
 
 /*
  *	Do a basic sanity check on the IO and memory addresses.
  */
-	if (brdp->iobase == 0 || brdp->memaddr == 0)
-		return -ENODEV;
+	if (brdp->iobase == 0 || brdp->memaddr == 0) {
+		retval = -ENODEV;
+		goto err;
+	}
 
 	brdp->iosize = ONB_IOSIZE;
 	
-	if (!request_region(brdp->iobase, brdp->iosize, "istallion"))
-		return -EIO;
+	if (!request_region(brdp->iobase, brdp->iosize, "istallion")) {
+		retval = -EIO;
+		goto err;
+	}
 
 /*
  *	Based on the specific board type setup the common vars to access
@@ -3500,8 +3503,8 @@ static int stli_initonb(struct stlibrd *
 		break;
 
 	default:
-		release_region(brdp->iobase, brdp->iosize);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto err_reg;
 	}
 
 /*
@@ -3513,10 +3516,9 @@ static int stli_initonb(struct stlibrd *
 	EBRDINIT(brdp);
 
 	brdp->membase = ioremap(brdp->memaddr, brdp->memsize);
-	if (brdp->membase == NULL)
-	{
-		release_region(brdp->iobase, brdp->iosize);
-		return -ENOMEM;
+	if (brdp->membase == NULL) {
+		retval = -ENOMEM;
+		goto err_reg;
 	}
 
 /*
@@ -3532,12 +3534,9 @@ static int stli_initonb(struct stlibrd *
 	if (sig.magic0 != cpu_to_le16(ONB_MAGIC0) ||
 	    sig.magic1 != cpu_to_le16(ONB_MAGIC1) ||
 	    sig.magic2 != cpu_to_le16(ONB_MAGIC2) ||
-	    sig.magic3 != cpu_to_le16(ONB_MAGIC3))
-	{
-		release_region(brdp->iobase, brdp->iosize);
-		iounmap(brdp->membase);
-		brdp->membase = NULL;
-		return -ENODEV;
+	    sig.magic3 != cpu_to_le16(ONB_MAGIC3)) {
+		retval = -ENODEV;
+		goto err_unmap;
 	}
 
 /*
@@ -3559,6 +3558,13 @@ static int stli_initonb(struct stlibrd *
 
 	brdp->state |= BST_FOUND;
 	return 0;
+err_unmap:
+	iounmap(brdp->membase);
+	brdp->membase = NULL;
+err_reg:
+	release_region(brdp->iobase, brdp->iosize);
+err:
+	return retval;
 }
 
 /*****************************************************************************/
@@ -3679,33 +3685,30 @@ stli_donestartup:
 
 static int __devinit stli_brdinit(struct stlibrd *brdp)
 {
+	int retval;
+
 	switch (brdp->brdtype) {
 	case BRD_ECP:
 	case BRD_ECPE:
 	case BRD_ECPMC:
 	case BRD_ECPPCI:
-		stli_initecp(brdp);
+		retval = stli_initecp(brdp);
 		break;
 	case BRD_ONBOARD:
 	case BRD_ONBOARDE:
 	case BRD_ONBOARD2:
 	case BRD_BRUMBY4:
 	case BRD_STALLION:
-		stli_initonb(brdp);
+		retval = stli_initonb(brdp);
 		break;
 	default:
 		printk(KERN_ERR "STALLION: board=%d is unknown board "
 				"type=%d\n", brdp->brdnr, brdp->brdtype);
-		return -ENODEV;
+		retval = -ENODEV;
 	}
 
-	if ((brdp->state & BST_FOUND) == 0) {
-		printk(KERN_ERR "STALLION: %s board not found, board=%d "
-				"io=%x mem=%x\n",
-			stli_brdnames[brdp->brdtype], brdp->brdnr,
-			brdp->iobase, (int) brdp->memaddr);
-		return -ENODEV;
-	}
+	if (retval)
+		return retval;
 
 	stli_initports(brdp);
 	printk(KERN_INFO "STALLION: %s found, board=%d io=%x mem=%x "
@@ -3842,7 +3845,7 @@ static int stli_findeisabrds(void)
 {
 	struct stlibrd *brdp;
 	unsigned int iobase, eid, i;
-	int brdnr;
+	int brdnr, found = 0;
 
 /*
  *	Firstly check if this is an EISA system.  If this is not an EISA system then
@@ -3880,10 +3883,10 @@ static int stli_findeisabrds(void)
  *		Allocate a board structure and initialize it.
  */
 		if ((brdp = stli_allocbrd()) == NULL)
-			return -ENOMEM;
+			return found ? : -ENOMEM;
 		brdnr = stli_getbrdnr();
 		if (brdnr < 0)
-			return -ENOMEM;
+			return found ? : -ENOMEM;
 		brdp->brdnr = (unsigned int)brdnr;
 		eid = inb(iobase + 0xc82);
 		if (eid == ECP_EISAID)
@@ -3896,11 +3899,16 @@ static int stli_findeisabrds(void)
 		outb(0x1, (iobase + 0xc84));
 		if (stli_eisamemprobe(brdp))
 			outb(0, (iobase + 0xc84));
+		if (stli_brdinit(brdp) < 0) {
+			kfree(brdp);
+			continue;
+		}
+
 		stli_brds[brdp->brdnr] = brdp;
-		stli_brdinit(brdp);
+		found++;
 	}
 
-	return 0;
+	return found;
 }
 #else
 static inline int stli_findeisabrds(void) { return 0; }
@@ -4020,7 +4028,7 @@ static int stli_initbrds(void)
 {
 	struct stlibrd *brdp, *nxtbrdp;
 	struct stlconf conf;
-	unsigned int i, j;
+	unsigned int i, j, found = 0;
 	int retval;
 
 	for (stli_nrbrds = 0; stli_nrbrds < ARRAY_SIZE(stli_brdsp);
@@ -4034,14 +4042,24 @@ static int stli_initbrds(void)
 		brdp->brdtype = conf.brdtype;
 		brdp->iobase = conf.ioaddr1;
 		brdp->memaddr = conf.memaddr;
+		if (stli_brdinit(brdp) < 0) {
+			kfree(brdp);
+			continue;
+		}
 		stli_brds[brdp->brdnr] = brdp;
-		stli_brdinit(brdp);
+		found++;
 	}
 
-	stli_findeisabrds();
+	retval = stli_findeisabrds();
+	if (retval > 0)
+		found += retval;
 
 	retval = pci_register_driver(&stli_pcidriver);
-	/* TODO: check retval and do something */
+	if (retval && found == 0) {
+		printk(KERN_ERR "Neither isa nor eisa cards found nor pci "
+				"driver can be registered!\n");
+		goto err;
+	}
 
 /*
  *	All found boards are initialized. Now for a little optimization, if
@@ -4082,6 +4100,8 @@ static int stli_initbrds(void)
 	}
 
 	return 0;
+err:
+	return retval;
 }
 
 /*****************************************************************************/
