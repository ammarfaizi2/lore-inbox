Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSHFXDH>; Tue, 6 Aug 2002 19:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSHFXDH>; Tue, 6 Aug 2002 19:03:07 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:31971 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316342AbSHFXDD>;
	Tue, 6 Aug 2002 19:03:03 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15696.21984.645493.409103@argo.ozlabs.ibm.com>
Date: Wed, 7 Aug 2002 09:04:00 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch is a forward-port from 2.4.  It changes the pcmcia resource
allocation code so that it allocates IO and memory resources from the
correct resource parent.  The details were discussed on lkml last year
in the 2.4 context.  I need this on powerbooks because they have
multiple PCI host bridges.  Please apply this to your tree.

Paul.

diff -urN linux-2.5/drivers/pcmcia/cistpl.c pmac-2.5/drivers/pcmcia/cistpl.c
--- linux-2.5/drivers/pcmcia/cistpl.c	Tue Feb  5 18:55:14 2002
+++ pmac-2.5/drivers/pcmcia/cistpl.c	Sun Jul 21 14:01:56 2002
@@ -264,11 +264,11 @@
 	(s->cis_mem.sys_start == 0)) {
 	int low = !(s->cap.features & SS_CAP_PAGE_REGS);
 	vs = s;
-	validate_mem(cis_readable, checksum_match, low);
+	validate_mem(cis_readable, checksum_match, low, s);
 	s->cis_mem.sys_start = 0;
 	vs = NULL;
 	if (find_mem_region(&s->cis_mem.sys_start, s->cap.map_size,
-			    s->cap.map_size, low, "card services")) {
+			    s->cap.map_size, low, "card services", s)) {
 	    printk(KERN_NOTICE "cs: unable to map card memory!\n");
 	    return CS_OUT_OF_RESOURCE;
 	}
diff -urN linux-2.5/drivers/pcmcia/cs.c pmac-2.5/drivers/pcmcia/cs.c
--- linux-2.5/drivers/pcmcia/cs.c	Tue Feb  5 18:55:14 2002
+++ pmac-2.5/drivers/pcmcia/cs.c	Sat Jul 20 20:41:46 2002
@@ -809,7 +809,7 @@
 	    return 1;
     for (i = 0; i < MAX_IO_WIN; i++) {
 	if (s->io[i].NumPorts == 0) {
-	    if (find_io_region(base, num, align, name) == 0) {
+	    if (find_io_region(base, num, align, name, s) == 0) {
 		s->io[i].Attributes = attr;
 		s->io[i].BasePort = *base;
 		s->io[i].NumPorts = s->io[i].InUse = num;
@@ -821,7 +821,7 @@
 	/* Try to extend top of window */
 	try = s->io[i].BasePort + s->io[i].NumPorts;
 	if ((*base == 0) || (*base == try))
-	    if (find_io_region(&try, num, 0, name) == 0) {
+	    if (find_io_region(&try, num, 0, name, s) == 0) {
 		*base = try;
 		s->io[i].NumPorts += num;
 		s->io[i].InUse += num;
@@ -830,7 +830,7 @@
 	/* Try to extend bottom of window */
 	try = s->io[i].BasePort - num;
 	if ((*base == 0) || (*base == try))
-	    if (find_io_region(&try, num, 0, name) == 0) {
+	    if (find_io_region(&try, num, 0, name, s) == 0) {
 		s->io[i].BasePort = *base = try;
 		s->io[i].NumPorts += num;
 		s->io[i].InUse += num;
@@ -1974,7 +1974,7 @@
 	find_mem_region(&win->base, win->size, align,
 			(req->Attributes & WIN_MAP_BELOW_1MB) ||
 			!(s->cap.features & SS_CAP_PAGE_REGS),
-			(*handle)->dev_info))
+			(*handle)->dev_info, s))
 	return CS_IN_USE;
     (*handle)->state |= CLIENT_WIN_REQ(w);
 
diff -urN linux-2.5/drivers/pcmcia/cs_internal.h pmac-2.5/drivers/pcmcia/cs_internal.h
--- linux-2.5/drivers/pcmcia/cs_internal.h	Wed Feb  6 04:40:18 2002
+++ pmac-2.5/drivers/pcmcia/cs_internal.h	Sat Jul 20 20:38:06 2002
@@ -238,11 +238,11 @@
 
 /* In rsrc_mgr */
 void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
-		  int force_low);
+		  int force_low, socket_info_t *s);
 int find_io_region(ioaddr_t *base, ioaddr_t num, ioaddr_t align,
-		   char *name);
+		   char *name, socket_info_t *s);
 int find_mem_region(u_long *base, u_long num, u_long align,
-		    int force_low, char *name);
+		    int force_low, char *name, socket_info_t *s);
 int try_irq(u_int Attributes, int irq, int specific);
 void undo_irq(u_int Attributes, int irq);
 int adjust_resource_info(client_handle_t handle, adjust_t *adj);
diff -urN linux-2.5/drivers/pcmcia/rsrc_mgr.c pmac-2.5/drivers/pcmcia/rsrc_mgr.c
--- linux-2.5/drivers/pcmcia/rsrc_mgr.c	Tue Feb  5 18:55:14 2002
+++ pmac-2.5/drivers/pcmcia/rsrc_mgr.c	Sun Jul 21 14:02:02 2002
@@ -44,6 +44,7 @@
 #include <linux/ioport.h>
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
+#include <linux/pci.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 
@@ -103,8 +104,82 @@
 
 ======================================================================*/
 
-#define check_io_resource(b,n)	check_resource(&ioport_resource, (b), (n))
-#define check_mem_resource(b,n)	check_resource(&iomem_resource, (b), (n))
+static struct resource *resource_parent(unsigned long b, unsigned long n,
+					int flags, struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI
+	struct resource res, *pr;
+
+	if (dev != NULL) {
+		res.start = b;
+		res.end = b + n - 1;
+		res.flags = flags;
+		pr = pci_find_parent_resource(dev, &res);
+		if (pr)
+			return pr;
+	}
+#endif /* CONFIG_PCI */
+	if (flags & IORESOURCE_MEM)
+		return &iomem_resource;
+	return &ioport_resource;
+}
+
+static inline int check_io_resource(unsigned long b, unsigned long n,
+				    struct pci_dev *dev)
+{
+	return check_resource(resource_parent(b, n, IORESOURCE_IO, dev), b, n);
+}
+
+static inline int check_mem_resource(unsigned long b, unsigned long n,
+				     struct pci_dev *dev)
+{
+	return check_resource(resource_parent(b, n, IORESOURCE_MEM, dev), b, n);
+}
+
+static struct resource *make_resource(unsigned long b, unsigned long n,
+				      int flags, char *name)
+{
+	struct resource *res = kmalloc(sizeof(*res), GFP_KERNEL);
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
+static int request_io_resource(unsigned long b, unsigned long n,
+			       char *name, struct pci_dev *dev)
+{
+	struct resource *res = make_resource(b, n, IORESOURCE_IO, name);
+	struct resource *pr = resource_parent(b, n, IORESOURCE_IO, dev);
+	int err = -ENOMEM;
+
+	if (res) {
+		err = request_resource(pr, res);
+		if (err)
+			kfree(res);
+	}
+	return err;
+}
+
+static int request_mem_resource(unsigned long b, unsigned long n,
+				char *name, struct pci_dev *dev)
+{
+	struct resource *res = make_resource(b, n, IORESOURCE_MEM, name);
+	struct resource *pr = resource_parent(b, n, IORESOURCE_MEM, dev);
+	int err = -ENOMEM;
+
+	if (res) {
+		err = request_resource(pr, res);
+		if (err)
+			kfree(res);
+	}
+	return err;
+}
 
 /*======================================================================
 
@@ -194,7 +269,7 @@
     }   
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
-	if (check_io_resource(i, 8))
+	if (check_io_resource(i, 8, NULL))
 	    continue;
 	hole = inb(i);
 	for (j = 1; j < 8; j++)
@@ -207,7 +282,7 @@
 
     bad = any = 0;
     for (i = base; i < base+num; i += 8) {
-	if (check_io_resource(i, 8))
+	if (check_io_resource(i, 8, NULL))
 	    continue;
 	for (j = 0; j < 8; j++)
 	    if (inb(i+j) != most) break;
@@ -247,7 +322,8 @@
 ======================================================================*/
 
 static int do_mem_probe(u_long base, u_long num,
-			int (*is_valid)(u_long), int (*do_cksum)(u_long))
+			int (*is_valid)(u_long), int (*do_cksum)(u_long),
+			socket_info_t *s)
 {
     u_long i, j, bad, fail, step;
 
@@ -258,13 +334,14 @@
     for (i = j = base; i < base+num; i = j + step) {
 	if (!fail) {	
 	    for (j = i; j < base+num; j += step)
-		if ((check_mem_resource(j, step) == 0) && is_valid(j))
+		if ((check_mem_resource(j, step, s->cap.cb_dev) == 0) &&
+		    is_valid(j))
 		    break;
 	    fail = ((i == base) && (j == base+num));
 	}
 	if (fail) {
 	    for (j = i; j < base+num; j += 2*step)
-		if ((check_mem_resource(j, 2*step) == 0) &&
+		if ((check_mem_resource(j, 2*step, s->cap.cb_dev) == 0) &&
 		    do_cksum(j) && do_cksum(j+step))
 		    break;
 	}
@@ -283,12 +360,12 @@
 
 static u_long inv_probe(int (*is_valid)(u_long),
 			int (*do_cksum)(u_long),
-			resource_map_t *m)
+			resource_map_t *m, socket_info_t *s)
 {
     u_long ok;
     if (m == &mem_db)
 	return 0;
-    ok = inv_probe(is_valid, do_cksum, m->next);
+    ok = inv_probe(is_valid, do_cksum, m->next, s);
     if (ok) {
 	if (m->base >= 0x100000)
 	    sub_interval(&mem_db, m->base, m->num);
@@ -296,11 +373,11 @@
     }
     if (m->base < 0x100000)
 	return 0;
-    return do_mem_probe(m->base, m->num, is_valid, do_cksum);
+    return do_mem_probe(m->base, m->num, is_valid, do_cksum, s);
 }
 
 void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
-		  int force_low)
+		  int force_low, socket_info_t *s)
 {
     resource_map_t *m, *n;
     static u_char order[] = { 0xd0, 0xe0, 0xc0, 0xf0 };
@@ -310,7 +387,7 @@
     if (!probe_mem) return;
     /* We do up to four passes through the list */
     if (!force_low) {
-	if (hi++ || (inv_probe(is_valid, do_cksum, mem_db.next) > 0))
+	if (hi++ || (inv_probe(is_valid, do_cksum, mem_db.next, s) > 0))
 	    return;
 	printk(KERN_NOTICE "cs: warning: no high memory space "
 	       "available!\n");
@@ -321,7 +398,7 @@
 	/* Only probe < 1 MB */
 	if (m->base >= 0x100000) continue;
 	if ((m->base | m->num) & 0xffff) {
-	    ok += do_mem_probe(m->base, m->num, is_valid, do_cksum);
+	    ok += do_mem_probe(m->base, m->num, is_valid, do_cksum, s);
 	    continue;
 	}
 	/* Special probe for 64K-aligned block */
@@ -331,7 +408,7 @@
 		if (ok >= mem_limit)
 		    sub_interval(&mem_db, b, 0x10000);
 		else
-		    ok += do_mem_probe(b, 0x10000, is_valid, do_cksum);
+		    ok += do_mem_probe(b, 0x10000, is_valid, do_cksum, s);
 	    }
 	}
     }
@@ -340,7 +417,7 @@
 #else /* CONFIG_ISA */
 
 void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
-		  int force_low)
+		  int force_low, socket_info_t *s)
 {
     resource_map_t *m;
     static int done = 0;
@@ -348,7 +425,7 @@
     if (!probe_mem || done++)
 	return;
     for (m = mem_db.next; m != &mem_db; m = m->next)
-	if (do_mem_probe(m->base, m->num, is_valid, do_cksum))
+	if (do_mem_probe(m->base, m->num, is_valid, do_cksum, s))
 	    return;
 }
 
@@ -368,7 +445,7 @@
 ======================================================================*/
 
 int find_io_region(ioaddr_t *base, ioaddr_t num, ioaddr_t align,
-		   char *name)
+		   char *name, socket_info_t *s)
 {
     ioaddr_t try;
     resource_map_t *m;
@@ -378,9 +455,8 @@
 	for (try = (try >= m->base) ? try : try+align;
 	     (try >= m->base) && (try+num <= m->base+m->num);
 	     try += align) {
-	    if (check_io_resource(try, num) == 0) {
+	    if (request_io_resource(try, num, name, s->cap.cb_dev) == 0) {
 		*base = try;
-		request_region(try, num, name);
 		return 0;
 	    }
 	    if (!align) break;
@@ -390,7 +466,7 @@
 }
 
 int find_mem_region(u_long *base, u_long num, u_long align,
-		    int force_low, char *name)
+		    int force_low, char *name, socket_info_t *s)
 {
     u_long try;
     resource_map_t *m;
@@ -403,8 +479,7 @@
 	    for (try = (try >= m->base) ? try : try+align;
 		 (try >= m->base) && (try+num <= m->base+m->num);
 		 try += align) {
-		if (check_mem_resource(try, num) == 0) {
-		    request_mem_region(try, num, name);
+		if (request_mem_resource(try, num, name, s->cap.cb_dev) == 0) {
 		    *base = try;
 		    return 0;
 		}
