Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbSKFTe7>; Wed, 6 Nov 2002 14:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265954AbSKFTe6>; Wed, 6 Nov 2002 14:34:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6417 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265947AbSKFTev>; Wed, 6 Nov 2002 14:34:51 -0500
Date: Wed, 6 Nov 2002 19:41:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: CFT/RFC: New cardbus resource allocation
Message-ID: <20021106194126.B7495@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is an experimental patch adjusts the way we allocate
resouces for PCMCIA cards in cardbus devices.

When a PCMCIA driver wishes to claim resources for a card, the original
code used to use an in-kernel structured list to find a free area of
memory, mostly ignoring the Linux resource subsystem (although it did
make use of the resource subsystem, it's racy.)

The following patch changes this.  We instead use the PCI resource
code to allocate a resource of the requested size, alignment, and
offset from the parent bus of the cardbus bridge.

Why do we need the size, alignment and offset?

Some PCMCIA devices have specific requirements for IO addresses; some
cards only decode 10 bits, and expect these 10 bits to be one of a
selection of addresses.  This means that the top 6 bits are ignored,
and can be any value.  However, the lower 10 bits must be one of a
fixed set of values, eg 0x3f8, 0x3e8, 0x2f8, 0x2e8.

Hence, 0x3f8, 0x7f8, 0xbf8 etc are all possible values, which obviously
gives you an alignment of (1 << 10) and an offset of 0x3f8.

(Appologies in advance if I've messed this patch up - it got dug it
out of a pile of other patches in this area.)

diff -ur orig/drivers/pci/pci.c linux/drivers/pci/pci.c
--- orig/drivers/pci/pci.c	Tue Nov  5 12:51:22 2002
+++ linux/drivers/pci/pci.c	Tue Nov  5 12:55:26 2002
@@ -659,6 +659,7 @@
 EXPORT_SYMBOL(pci_clear_mwi);
 EXPORT_SYMBOL(pci_set_dma_mask);
 EXPORT_SYMBOL(pci_dac_set_dma_mask);
+EXPORT_SYMBOL(pci_alloc_parent_resource);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
 
diff -ur orig/drivers/pci/setup-res.c linux/drivers/pci/setup-res.c
--- orig/drivers/pci/setup-res.c	Thu Oct  3 12:43:08 2002
+++ linux/drivers/pci/setup-res.c	Wed Oct 30 19:40:33 2002
@@ -57,6 +57,47 @@
 }
 
 /*
+ * Given the PCI bus a device resides on, the size, minimum address,
+ * alignment and type, try to find an acceptable resource allocation
+ * for a specific device resource.
+ */
+int
+pci_alloc_parent_resource(struct pci_dev *dev, struct resource *res,
+			  unsigned long size, unsigned long align,
+			  unsigned long min,
+			  void (*alignf)(void *, struct resource *,
+					 unsigned long, unsigned long),
+			  void *alignf_data)
+{
+	struct pci_bus *bus = dev->bus;
+	int i;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		struct resource *r = bus->resource[i];
+		if (!r)
+			continue;
+
+		/* type_mask must match */
+		if ((res->flags ^ r->flags) & (IORESOURCE_IO | IORESOURCE_MEM))
+			continue;
+
+		/* We cannot allocate a non-prefetching resource
+		   from a prefetching area */
+		if ((r->flags & IORESOURCE_PREFETCH) &&
+		    !(res->flags & IORESOURCE_PREFETCH))
+			continue;
+
+		/* Ok, try it out.. */
+		if (allocate_resource(r, res, size, min, -1, align,
+				      alignf, alignf_data) < 0)
+			continue;
+
+		return 0;
+	}
+	return -ENOMEM;
+}
+
+/*
  * Given the PCI bus a device resides on, try to
  * find an acceptable resource allocation for a
  * specific device resource..
@@ -72,8 +113,13 @@
 	unsigned long align;
 	int i;
 
+	/* The bridge resources are special, as their
+	   size != alignment. Sizing routines return
+	   required alignment in the "start" field. */
+	align = (resno < PCI_BRIDGE_RESOURCES) ? size : res->start;
+
 	type_mask |= IORESOURCE_IO | IORESOURCE_MEM;
-	for (i = 0 ; i < PCI_BUS_NUM_RESOURCES; i++) {
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
 		struct resource *r = bus->resource[i];
 		if (!r)
 			continue;
@@ -87,11 +133,6 @@
 		if ((r->flags & IORESOURCE_PREFETCH) &&
 		    !(res->flags & IORESOURCE_PREFETCH))
 			continue;
-
-		/* The bridge resources are special, as their
-		   size != alignment. Sizing routines return
-		   required alignment in the "start" field. */
-		align = (resno < PCI_BRIDGE_RESOURCES) ? size : res->start;
 
 		/* Ok, try it out.. */
 		if (allocate_resource(r, res, size, min, -1, align,
diff -ur orig/drivers/pcmcia/cardbus.c linux/drivers/pcmcia/cardbus.c
--- orig/drivers/pcmcia/cardbus.c	Sat Jul  6 17:36:12 2002
+++ linux/drivers/pcmcia/cardbus.c	Wed Nov  6 15:16:15 2002
@@ -418,3 +418,105 @@
 	/* Turn off bridge windows */
 	cb_release_cis_mem(s);
 }
+
+
+
+static struct resource *
+make_resource(unsigned long b, unsigned long n, int flags, char *name)
+{
+	struct resource *res = kmalloc(sizeof(struct resource), GFP_KERNEL);
+
+	if (res) {
+		memset(res, 0, sizeof(*res));
+		res->name = name;
+		res->start = b;
+		res->end = b + n - 1;
+		res->flags = flags | IORESOURCE_BUSY;
+	}
+	return res;
+}
+
+struct cardbus_alignment {
+	unsigned long mask;
+	unsigned long offset;
+};
+
+/*
+ * Some PCMCIA cards have only a limited number of address lines, and
+ * require a certain bit pattern on the high lines.  This gives us the
+ * following requirement for an address:
+ *
+ *     (base & ~((1 << bits) - 1)) + offset
+ *
+ * The initial alignment is taken care of in the generic resource
+ * allocation code, so we just need to ensure the correct offset.
+ *
+ * Also, if the PCMCIA card requests a resource with a specific offset
+ * less than our normal minimum, we assume that this is because it knows
+ * it must have that address.
+ */
+static void cardbus_adjust(void *data, struct resource *res,
+			   unsigned long size, unsigned long align)
+{
+	struct cardbus_alignment *ca = data;
+	unsigned long start;
+	
+	start = (res->start & ~ca->mask) + ca->offset;
+	if (start < res->start)
+		start = ((res->start + ca->mask) & ~ca->mask) + ca->offset;
+
+	res->start = start;
+}
+
+int cb_alloc_io(ioaddr_t *base, ioaddr_t num, ioaddr_t align, char *name,
+		socket_info_t *s)
+{
+	struct resource *res = make_resource(0, num, IORESOURCE_IO, name);
+	struct cardbus_alignment ca;
+	unsigned long min;
+	int ret;
+
+	ca.mask = align - 1;
+	ca.offset = *base & ca.mask;
+
+	if (*base && *base < PCIBIOS_MIN_IO) {
+		min = *base;
+	} else {
+		min = PCIBIOS_MIN_IO;
+	}
+
+	ret = pci_alloc_parent_resource(s->cap.cb_dev, res, num, 1,
+					min, cardbus_adjust, &ca);
+	if (ret == 0) {
+		*base = res->start;
+	} else {
+		kfree(res);
+	}
+	return ret;
+}
+
+int cb_alloc_mem(unsigned long *base, unsigned long num, unsigned long align,
+		 char *name, socket_info_t *s)
+{
+	struct resource *res = make_resource(0, num, IORESOURCE_MEM, name);
+	struct cardbus_alignment ca;
+	unsigned long min;
+	int ret;
+
+	ca.mask = align - 1;
+	ca.offset = *base & ca.mask;
+
+	if (*base && *base < PCIBIOS_MIN_MEM)
+		min = *base;
+	else
+		min = PCIBIOS_MIN_MEM;
+
+	ret = pci_alloc_parent_resource(s->cap.cb_dev, res, num, 1,
+					min, cardbus_adjust, &ca);
+	if (ret == 0) {
+		*base = RESOURCE_TO_BUS(res->start);
+	} else {
+		kfree(res);
+	}
+	return ret;
+}
diff -ur orig/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- orig/drivers/pcmcia/cs.c	Sat Oct 12 10:00:50 2002
+++ linux/drivers/pcmcia/cs.c	Thu Oct 24 23:06:28 2002
@@ -483,6 +483,7 @@
     cb_release_cis_mem(s);
     cb_free(s);
 #endif
+    release_cis_mem(s);
     s->functions = 0;
     if (s->config) {
 	kfree(s->config);
diff -ur orig/drivers/pcmcia/rsrc_mgr.c linux/drivers/pcmcia/rsrc_mgr.c
--- orig/drivers/pcmcia/rsrc_mgr.c	Sat Nov  2 18:57:58 2002
+++ linux/drivers/pcmcia/rsrc_mgr.c	Wed Nov  6 15:02:10 2002
@@ -55,6 +55,11 @@
 #include <pcmcia/cistpl.h>
 #include "cs_internal.h"
 
+int cb_alloc_io(ioaddr_t *base, ioaddr_t num, ioaddr_t align, char *name,
+		socket_info_t *s);
+int cb_alloc_mem(unsigned long *base, unsigned long num, unsigned long align,
+		 char *name, socket_info_t *s);
+
 /*====================================================================*/
 
 /* Parameters that can be set with 'insmod' */
@@ -104,34 +109,12 @@
 
 ======================================================================*/
 
-static struct resource *resource_parent(unsigned long b, unsigned long n,
-					int flags, struct pci_dev *dev)
-{
-#ifdef CONFIG_PCI
-	struct resource res, *pr;
-
-	if (dev != NULL) {
-		res.start = b;
-		res.end = b + n - 1;
-		res.flags = flags;
-		pr = pci_find_parent_resource(dev, &res);
-		if (pr)
-			return pr;
-	}
-#endif /* CONFIG_PCI */
-	if (flags & IORESOURCE_MEM)
-		return &iomem_resource;
-	return &ioport_resource;
-}
-
 /* FIXME: Fundamentally racy. */
-static inline int check_io_resource(unsigned long b, unsigned long n,
-				    struct pci_dev *dev)
+static inline int check_io_resource(unsigned long b, unsigned long n)
 {
 	struct resource *region;
 
-	region = __request_region(resource_parent(b, n, IORESOURCE_IO, dev),
-				  b, n, "check_io_resource");
+	region = __request_region(&ioport_resource, b, n, "check_io_resource");
 	if (!region)
 		return -EBUSY;
 
@@ -141,13 +124,12 @@
 }
 
 /* FIXME: Fundamentally racy. */
-static inline int check_mem_resource(unsigned long b, unsigned long n,
-				     struct pci_dev *dev)
+static inline int check_mem_resource(unsigned long b, unsigned long n)
 {
 	struct resource *region;
 
-	region = __request_region(resource_parent(b, n, IORESOURCE_MEM, dev),
-				  b, n, "check_mem_resource");
+	region = __request_region(&iomem_resource, BUS_TO_RESOURCE(b), n,
+				  "check_mem_resource");
 	if (!region)
 		return -EBUSY;
 
@@ -156,49 +138,15 @@
 	return 0;
 }
 
-static struct resource *make_resource(unsigned long b, unsigned long n,
-				      int flags, char *name)
+static int
+request_mem_resource(unsigned long b, unsigned long n, char *name)
 {
-	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
-
-	if (res) {
-		memset(res, 0, sizeof(*res));
-		res->name = name;
-		res->start = b;
-		res->end = b + n - 1;
-		res->flags = flags | IORESOURCE_BUSY;
-	}
-	return res;
+	return request_mem_region(BUS_TO_RESOURCE(b), n, name) != 0;
 }
 
-static int request_io_resource(unsigned long b, unsigned long n,
-			       char *name, struct pci_dev *dev)
+void release_mem_resource(unsigned long b, unsigned long n)
 {
-	struct resource *res = make_resource(b, n, IORESOURCE_IO, name);
-	struct resource *pr = resource_parent(b, n, IORESOURCE_IO, dev);
-	int err = -ENOMEM;
-
-	if (res) {
-		err = request_resource(pr, res);
-		if (err)
-			kfree(res);
-	}
-	return err;
-}
-
-static int request_mem_resource(unsigned long b, unsigned long n,
-				char *name, struct pci_dev *dev)
-{
-	struct resource *res = make_resource(b, n, IORESOURCE_MEM, name);
-	struct resource *pr = resource_parent(b, n, IORESOURCE_MEM, dev);
-	int err = -ENOMEM;
-
-	if (res) {
-		err = request_resource(pr, res);
-		if (err)
-			kfree(res);
-	}
-	return err;
+	release_mem_region(BUS_TO_RESOURCE(b), n);
 }
 
 /*======================================================================
@@ -289,7 +237,7 @@
     }   
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
-	if (check_io_resource(i, 8, NULL))
+	if (check_io_resource(i, 8))
 	    continue;
 	hole = inb(i);
 	for (j = 1; j < 8; j++)
@@ -302,7 +250,7 @@
 
     bad = any = 0;
     for (i = base; i < base+num; i += 8) {
-	if (check_io_resource(i, 8, NULL))
+	if (check_io_resource(i, 8))
 	    continue;
 	for (j = 0; j < 8; j++)
 	    if (inb(i+j) != most) break;
@@ -354,14 +302,14 @@
     for (i = j = base; i < base+num; i = j + step) {
 	if (!fail) {	
 	    for (j = i; j < base+num; j += step)
-		if ((check_mem_resource(j, step, s->cap.cb_dev) == 0) &&
+		if ((check_mem_resource(j, step) == 0) &&
 		    is_valid(j))
 		    break;
 	    fail = ((i == base) && (j == base+num));
 	}
 	if (fail) {
 	    for (j = i; j < base+num; j += 2*step)
-		if ((check_mem_resource(j, 2*step, s->cap.cb_dev) == 0) &&
+		if ((check_mem_resource(j, 2*step) == 0) &&
 		    do_cksum(j) && do_cksum(j+step))
 		    break;
 	}
@@ -403,6 +351,9 @@
     static u_char order[] = { 0xd0, 0xe0, 0xc0, 0xf0 };
     static int hi = 0, lo = 0;
     u_long b, i, ok = 0;
+
+    if (s->cap.cb_dev)
+	return;
     
     if (!probe_mem) return;
     /* We do up to four passes through the list */
@@ -469,13 +420,21 @@
 {
     ioaddr_t try;
     resource_map_t *m;
-    
+
+#ifdef CONFIG_CARDBUS
+    if (s->cap.cb_dev) {
+    	if (align == 0)
+    	    align++;
+    	return cb_alloc_io(base, num, align, name, s);
+    }
+#endif
+
     for (m = io_db.next; m != &io_db; m = m->next) {
 	try = (m->base & ~(align-1)) + *base;
 	for (try = (try >= m->base) ? try : try+align;
 	     (try >= m->base) && (try+num <= m->base+m->num);
 	     try += align) {
-	    if (request_io_resource(try, num, name, s->cap.cb_dev) == 0) {
+	    if (request_region(try, num, name) == 0) {
 		*base = try;
 		return 0;
 	    }
@@ -491,6 +450,14 @@
     u_long try;
     resource_map_t *m;
 
+#ifdef CONFIG_CARDBUS
+    if (s->cap.cb_dev) {
+    	if (align == 0)
+    	    align++;
+	return cb_alloc_mem(base, num, align, name, s);
+    }
+#endif
+
     while (1) {
 	for (m = mem_db.next; m != &mem_db; m = m->next) {
 	    /* first pass >1MB, second pass <1MB */
@@ -499,7 +466,7 @@
 	    for (try = (try >= m->base) ? try : try+align;
 		 (try >= m->base) && (try+num <= m->base+m->num);
 		 try += align) {
-		if (request_mem_resource(try, num, name, s->cap.cb_dev) == 0) {
+		if (request_mem_resource(try, num, name) == 0) {
 		    *base = try;
 		    return 0;
 		}

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

