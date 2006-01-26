Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWAZWqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWAZWqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWAZWql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:46:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56838 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964955AbWAZWqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:46:40 -0500
Date: Thu, 26 Jan 2006 23:46:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@vger.kernel.org
Subject: [2/10] remove ISA legacy functions: drivers/net/arcnet/
Message-ID: <20060126224638.GF3668@stusta.de>
References: <20060126223126.GD3668@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126223126.GD3668@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

sanitized probing code, made sure we claim regions before poking into
them (original tried that to some extent, but hadn't got it right),
switched to ioremap() use in probing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/arcnet/arc-rimi.c |   68 +++++++++++++++------
 drivers/net/arcnet/com90xx.c  |  132 +++++++++++++++++++++++++++++------------
 2 files changed, 143 insertions(+), 57 deletions(-)

6a0100f551bbd751fba9d68575dcb15e5554e130
diff --git a/drivers/net/arcnet/arc-rimi.c b/drivers/net/arcnet/arc-rimi.c
--- a/drivers/net/arcnet/arc-rimi.c
+++ b/drivers/net/arcnet/arc-rimi.c
@@ -97,25 +97,44 @@ static int __init arcrimi_probe(struct n
 		       "must specify the shmem and irq!\n");
 		return -ENODEV;
 	}
+	if (dev->dev_addr[0] == 0) {
+		BUGMSG(D_NORMAL, "You need to specify your card's station "
+		       "ID!\n");
+		return -ENODEV;
+	}
 	/*
-	 * Grab the memory region at mem_start for BUFFER_SIZE bytes.
+	 * Grab the memory region at mem_start for MIRROR_SIZE bytes.
 	 * Later in arcrimi_found() the real size will be determined
 	 * and this reserve will be released and the correct size
 	 * will be taken.
 	 */
-	if (!request_mem_region(dev->mem_start, BUFFER_SIZE, "arcnet (90xx)")) {
+	if (!request_mem_region(dev->mem_start, MIRROR_SIZE, "arcnet (90xx)")) {
 		BUGMSG(D_NORMAL, "Card memory already allocated\n");
 		return -ENODEV;
 	}
-	if (dev->dev_addr[0] == 0) {
-		release_mem_region(dev->mem_start, BUFFER_SIZE);
-		BUGMSG(D_NORMAL, "You need to specify your card's station "
-		       "ID!\n");
-		return -ENODEV;
-	}
 	return arcrimi_found(dev);
 }
 
+static int check_mirror(unsigned long addr, size_t size)
+{
+	void __iomem *p;
+	int res = -1;
+
+	if (!request_mem_region(addr, size, "arcnet (90xx)"))
+		return -1;
+
+	p = ioremap(addr, size);
+	if (p) {
+		if (readb(p) == TESTvalue)
+			res = 1;
+		else
+			res = 0;
+		iounmap(p);
+	}
+
+	release_mem_region(addr, size);
+	return res;
+}
 
 /*
  * Set up the struct net_device associated with this card.  Called after
@@ -125,19 +144,28 @@ static int __init arcrimi_found(struct n
 {
 	struct arcnet_local *lp;
 	unsigned long first_mirror, last_mirror, shmem;
+	void __iomem *p;
 	int mirror_size;
 	int err;
 
+	p = ioremap(dev->mem_start, MIRROR_SIZE);
+	if (!p) {
+		release_mem_region(dev->mem_start, MIRROR_SIZE);
+		BUGMSG(D_NORMAL, "Can't ioremap\n");
+		return -ENODEV;
+	}
+
 	/* reserve the irq */
 	if (request_irq(dev->irq, &arcnet_interrupt, 0, "arcnet (RIM I)", dev)) {
-		release_mem_region(dev->mem_start, BUFFER_SIZE);
+		iounmap(p);
+		release_mem_region(dev->mem_start, MIRROR_SIZE);
 		BUGMSG(D_NORMAL, "Can't get IRQ %d!\n", dev->irq);
 		return -ENODEV;
 	}
 
 	shmem = dev->mem_start;
-	isa_writeb(TESTvalue, shmem);
-	isa_writeb(dev->dev_addr[0], shmem + 1);	/* actually the node ID */
+	writeb(TESTvalue, p);
+	writeb(dev->dev_addr[0], p + 1);	/* actually the node ID */
 
 	/* find the real shared memory start/end points, including mirrors */
 
@@ -146,17 +174,18 @@ static int __init arcrimi_found(struct n
 	 * 2k (or there are no mirrors at all) but on some, it's 4k.
 	 */
 	mirror_size = MIRROR_SIZE;
-	if (isa_readb(shmem) == TESTvalue
-	    && isa_readb(shmem - mirror_size) != TESTvalue
-	    && isa_readb(shmem - 2 * mirror_size) == TESTvalue)
-		mirror_size *= 2;
+	if (readb(p) == TESTvalue
+	    && check_mirror(shmem - MIRROR_SIZE, MIRROR_SIZE) == 0
+	    && check_mirror(shmem - 2 * MIRROR_SIZE, MIRROR_SIZE) == 1)
+		mirror_size = 2 * MIRROR_SIZE;
 
-	first_mirror = last_mirror = shmem;
-	while (isa_readb(first_mirror) == TESTvalue)
+	first_mirror = shmem - mirror_size;
+	while (check_mirror(first_mirror, mirror_size) == 1)
 		first_mirror -= mirror_size;
 	first_mirror += mirror_size;
 
-	while (isa_readb(last_mirror) == TESTvalue)
+	last_mirror = shmem + mirror_size;
+	while (check_mirror(last_mirror, mirror_size) == 1)
 		last_mirror += mirror_size;
 	last_mirror -= mirror_size;
 
@@ -181,7 +210,8 @@ static int __init arcrimi_found(struct n
 	 * with the correct size.  There is a VERY slim chance this could
 	 * fail.
 	 */
-	release_mem_region(shmem, BUFFER_SIZE);
+	iounmap(p);
+	release_mem_region(shmem, MIRROR_SIZE);
 	if (!request_mem_region(dev->mem_start,
 				dev->mem_end - dev->mem_start + 1,
 				"arcnet (90xx)")) {
diff --git a/drivers/net/arcnet/com90xx.c b/drivers/net/arcnet/com90xx.c
--- a/drivers/net/arcnet/com90xx.c
+++ b/drivers/net/arcnet/com90xx.c
@@ -53,7 +53,7 @@
 
 
 /* Internal function declarations */
-static int com90xx_found(int ioaddr, int airq, u_long shmem);
+static int com90xx_found(int ioaddr, int airq, u_long shmem, void __iomem *);
 static void com90xx_command(struct net_device *dev, int command);
 static int com90xx_status(struct net_device *dev);
 static void com90xx_setmask(struct net_device *dev, int mask);
@@ -116,14 +116,26 @@ static void __init com90xx_probe(void)
 	unsigned long airqmask;
 	int ports[(0x3f0 - 0x200) / 16 + 1] =
 	{0};
-	u_long shmems[(0xFF800 - 0xA0000) / 2048 + 1] =
-	{0};
+	unsigned long *shmems;
+	void __iomem **iomem;
 	int numports, numshmems, *port;
 	u_long *p;
+	int index;
 
 	if (!io && !irq && !shmem && !*device && com90xx_skip_probe)
 		return;
 
+	shmems = kzalloc(((0x10000-0xa0000) / 0x800) * sizeof(unsigned long),
+			 GFP_KERNEL);
+	if (!shmems)
+		return;
+	iomem = kzalloc(((0x10000-0xa0000) / 0x800) * sizeof(void __iomem *),
+			 GFP_KERNEL);
+	if (!iomem) {
+		kfree(shmems);
+		return;
+	}
+
 	BUGLVL(D_NORMAL) printk(VERSION);
 
 	/* set up the arrays where we'll store the possible probe addresses */
@@ -179,6 +191,8 @@ static void __init com90xx_probe(void)
 
 	if (!numports) {
 		BUGMSG2(D_NORMAL, "S1: No ARCnet cards found.\n");
+		kfree(shmems);
+		kfree(iomem);
 		return;
 	}
 	/* Stage 2: we have now reset any possible ARCnet cards, so we can't
@@ -202,8 +216,8 @@ static void __init com90xx_probe(void)
 	 * 0xD1 byte in the right place, or are read-only.
 	 */
 	numprint = -1;
-	for (p = &shmems[0]; p < shmems + numshmems; p++) {
-		u_long ptr = *p;
+	for (index = 0, p = &shmems[0]; index < numshmems; p++, index++) {
+		void __iomem *base;
 
 		numprint++;
 		numprint %= 8;
@@ -213,38 +227,49 @@ static void __init com90xx_probe(void)
 		}
 		BUGMSG2(D_INIT, "%lXh ", *p);
 
-		if (!request_mem_region(*p, BUFFER_SIZE, "arcnet (90xx)")) {
+		if (!request_mem_region(*p, MIRROR_SIZE, "arcnet (90xx)")) {
 			BUGMSG2(D_INIT_REASONS, "(request_mem_region)\n");
 			BUGMSG2(D_INIT_REASONS, "Stage 3: ");
 			BUGLVL(D_INIT_REASONS) numprint = 0;
-			*p-- = shmems[--numshmems];
-			continue;
+			goto out;
+		}
+		base = ioremap(*p, MIRROR_SIZE);
+		if (!base) {
+			BUGMSG2(D_INIT_REASONS, "(ioremap)\n");
+			BUGMSG2(D_INIT_REASONS, "Stage 3: ");
+			BUGLVL(D_INIT_REASONS) numprint = 0;
+			goto out1;
 		}
-		if (isa_readb(ptr) != TESTvalue) {
+		if (readb(base) != TESTvalue) {
 			BUGMSG2(D_INIT_REASONS, "(%02Xh != %02Xh)\n",
-				isa_readb(ptr), TESTvalue);
+				readb(base), TESTvalue);
 			BUGMSG2(D_INIT_REASONS, "S3: ");
 			BUGLVL(D_INIT_REASONS) numprint = 0;
-			release_mem_region(*p, BUFFER_SIZE);
-			*p-- = shmems[--numshmems];
-			continue;
+			goto out2;
 		}
 		/* By writing 0x42 to the TESTvalue location, we also make
 		 * sure no "mirror" shmem areas show up - if they occur
 		 * in another pass through this loop, they will be discarded
 		 * because *cptr != TESTvalue.
 		 */
-		isa_writeb(0x42, ptr);
-		if (isa_readb(ptr) != 0x42) {
+		writeb(0x42, base);
+		if (readb(base) != 0x42) {
 			BUGMSG2(D_INIT_REASONS, "(read only)\n");
 			BUGMSG2(D_INIT_REASONS, "S3: ");
-			release_mem_region(*p, BUFFER_SIZE);
-			*p-- = shmems[--numshmems];
-			continue;
+			goto out2;
 		}
 		BUGMSG2(D_INIT_REASONS, "\n");
 		BUGMSG2(D_INIT_REASONS, "S3: ");
 		BUGLVL(D_INIT_REASONS) numprint = 0;
+		iomem[index] = base;
+		continue;
+	out2:
+		iounmap(base);
+	out1:
+		release_mem_region(*p, MIRROR_SIZE);
+	out:
+		*p-- = shmems[--numshmems];
+		index--;
 	}
 	BUGMSG2(D_INIT, "\n");
 
@@ -252,6 +277,8 @@ static void __init com90xx_probe(void)
 		BUGMSG2(D_NORMAL, "S3: No ARCnet cards found.\n");
 		for (port = &ports[0]; port < ports + numports; port++)
 			release_region(*port, ARCNET_TOTAL_SIZE);
+		kfree(shmems);
+		kfree(iomem);
 		return;
 	}
 	/* Stage 4: something of a dummy, to report the shmems that are
@@ -351,30 +378,32 @@ static void __init com90xx_probe(void)
 			mdelay(RESETtime);
 		} else {
 			/* just one shmem and port, assume they match */
-			isa_writeb(TESTvalue, shmems[0]);
+			writeb(TESTvalue, iomem[0]);
 		}
 #else
 		inb(_RESET);
 		mdelay(RESETtime);
 #endif
 
-		for (p = &shmems[0]; p < shmems + numshmems; p++) {
-			u_long ptr = *p;
+		for (index = 0; index < numshmems; index++) {
+			u_long ptr = shmems[index];
+			void __iomem *base = iomem[index];
 
-			if (isa_readb(ptr) == TESTvalue) {	/* found one */
+			if (readb(base) == TESTvalue) {	/* found one */
 				BUGMSG2(D_INIT, "%lXh)\n", *p);
 				openparen = 0;
 
 				/* register the card */
-				if (com90xx_found(*port, airq, *p) == 0)
+				if (com90xx_found(*port, airq, ptr, base) == 0)
 					found = 1;
 				numprint = -1;
 
 				/* remove shmem from the list */
-				*p = shmems[--numshmems];
+				shmems[index] = shmems[--numshmems];
+				iomem[index] = iomem[numshmems];
 				break;	/* go to the next I/O port */
 			} else {
-				BUGMSG2(D_INIT_REASONS, "%Xh-", isa_readb(ptr));
+				BUGMSG2(D_INIT_REASONS, "%Xh-", readb(base));
 			}
 		}
 
@@ -391,17 +420,40 @@ static void __init com90xx_probe(void)
 	BUGLVL(D_INIT_REASONS) printk("\n");
 
 	/* Now put back TESTvalue on all leftover shmems. */
-	for (p = &shmems[0]; p < shmems + numshmems; p++) {
-		isa_writeb(TESTvalue, *p);
-		release_mem_region(*p, BUFFER_SIZE);
+	for (index = 0; index < numshmems; index++) {
+		writeb(TESTvalue, iomem[index]);
+		iounmap(iomem[index]);
+		release_mem_region(shmems[index], MIRROR_SIZE);
 	}
+	kfree(shmems);
+	kfree(iomem);
 }
 
+static int check_mirror(unsigned long addr, size_t size)
+{
+	void __iomem *p;
+	int res = -1;
+
+	if (!request_mem_region(addr, size, "arcnet (90xx)"))
+		return -1;
+
+	p = ioremap(addr, size);
+	if (p) {
+		if (readb(p) == TESTvalue)
+			res = 1;
+		else
+			res = 0;
+		iounmap(p);
+	}
+
+	release_mem_region(addr, size);
+	return res;
+}
 
 /* Set up the struct net_device associated with this card.  Called after
  * probing succeeds.
  */
-static int __init com90xx_found(int ioaddr, int airq, u_long shmem)
+static int __init com90xx_found(int ioaddr, int airq, u_long shmem, void __iomem *p)
 {
 	struct net_device *dev = NULL;
 	struct arcnet_local *lp;
@@ -412,7 +464,8 @@ static int __init com90xx_found(int ioad
 	dev = alloc_arcdev(device);
 	if (!dev) {
 		BUGMSG2(D_NORMAL, "com90xx: Can't allocate device!\n");
-		release_mem_region(shmem, BUFFER_SIZE);
+		iounmap(p);
+		release_mem_region(shmem, MIRROR_SIZE);
 		return -ENOMEM;
 	}
 	lp = dev->priv;
@@ -423,24 +476,27 @@ static int __init com90xx_found(int ioad
 	 * 2k (or there are no mirrors at all) but on some, it's 4k.
 	 */
 	mirror_size = MIRROR_SIZE;
-	if (isa_readb(shmem) == TESTvalue
-	    && isa_readb(shmem - mirror_size) != TESTvalue
-	    && isa_readb(shmem - 2 * mirror_size) == TESTvalue)
-		mirror_size *= 2;
+	if (readb(p) == TESTvalue &&
+	    check_mirror(shmem - MIRROR_SIZE, MIRROR_SIZE) == 0 &&
+	    check_mirror(shmem - 2 * MIRROR_SIZE, MIRROR_SIZE) == 1)
+		mirror_size = 2 * MIRROR_SIZE;
 
-	first_mirror = last_mirror = shmem;
-	while (isa_readb(first_mirror) == TESTvalue)
+	first_mirror = shmem - mirror_size;
+	while (check_mirror(first_mirror, mirror_size) == 1)
 		first_mirror -= mirror_size;
 	first_mirror += mirror_size;
 
-	while (isa_readb(last_mirror) == TESTvalue)
+	last_mirror = shmem + mirror_size;
+	while (check_mirror(last_mirror, mirror_size) == 1)
 		last_mirror += mirror_size;
 	last_mirror -= mirror_size;
 
 	dev->mem_start = first_mirror;
 	dev->mem_end = last_mirror + MIRROR_SIZE - 1;
 
-	release_mem_region(shmem, BUFFER_SIZE);
+	iounmap(p);
+	release_mem_region(shmem, MIRROR_SIZE);
+
 	if (!request_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1, "arcnet (90xx)"))
 		goto err_free_dev;
 

