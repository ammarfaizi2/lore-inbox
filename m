Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRJQAhI>; Tue, 16 Oct 2001 20:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRJQAg7>; Tue, 16 Oct 2001 20:36:59 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:3085 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S273255AbRJQAgn>;
	Tue, 16 Oct 2001 20:36:43 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15308.53916.81722.466476@cargo.ozlabs.ibm.com>
Date: Wed, 17 Oct 2001 10:36:44 +1000 (EST)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make pcmcia use correct parent resources
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below changes the pcmcia code so that it uses the correct
parent resource when doing check_resource/request_region.  At present
the code assumes ioport_resource or iomem_resource, which is not
correct in general, or on powermacs in particular.  With this patch
the code will use the pci_dev * for the pcmcia controller to find the
correct parent resource to allocate from (if the controller is not a
pci device then the code will use ioport/iomem_resource as before).

I put a similar patch up some time ago and there was some discussion
but no conclusion was reached.  This patch is almost identical except
that I have changed the request_io/mem_resource functions that I add
to take a pci_dev * instead of the socket_info_t * that I had before.

Comments, anyone?  Linus, would you be willing to apply this to your
tree?

Thanks,
Paul.

diff -urN linux-2.4.13-pre2/drivers/pcmcia/cistpl.c pmac/drivers/pcmcia/cistpl.c
--- linux-2.4.13-pre2/drivers/pcmcia/cistpl.c	Thu Feb 22 14:25:19 2001
+++ pmac/drivers/pcmcia/cistpl.c	Sat Sep  8 16:25:06 2001
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
diff -urN linux-2.4.13-pre2/drivers/pcmcia/cs.c pmac/drivers/pcmcia/cs.c
--- linux-2.4.13-pre2/drivers/pcmcia/cs.c	Sat Oct 13 15:17:35 2001
+++ pmac/drivers/pcmcia/cs.c	Sat Oct 13 19:46:57 2001
@@ -802,7 +802,7 @@
 	    return 1;
     for (i = 0; i < MAX_IO_WIN; i++) {
 	if (s->io[i].NumPorts == 0) {
-	    if (find_io_region(base, num, align, name) == 0) {
+	    if (find_io_region(base, num, align, name, s) == 0) {
 		s->io[i].Attributes = attr;
 		s->io[i].BasePort = *base;
 		s->io[i].NumPorts = s->io[i].InUse = num;
@@ -814,7 +814,7 @@
 	/* Try to extend top of window */
 	try = s->io[i].BasePort + s->io[i].NumPorts;
 	if ((*base == 0) || (*base == try))
-	    if (find_io_region(&try, num, 0, name) == 0) {
+	    if (find_io_region(&try, num, 0, name, s) == 0) {
 		*base = try;
 		s->io[i].NumPorts += num;
 		s->io[i].InUse += num;
@@ -823,7 +823,7 @@
 	/* Try to extend bottom of window */
 	try = s->io[i].BasePort - num;
 	if ((*base == 0) || (*base == try))
-	    if (find_io_region(&try, num, 0, name) == 0) {
+	    if (find_io_region(&try, num, 0, name, s) == 0) {
 		s->io[i].BasePort = *base = try;
 		s->io[i].NumPorts += num;
 		s->io[i].InUse += num;
@@ -1967,7 +1967,7 @@
 	find_mem_region(&win->base, win->size, align,
 			(req->Attributes & WIN_MAP_BELOW_1MB) ||
 			!(s->cap.features & SS_CAP_PAGE_REGS),
-			(*handle)->dev_info))
+			(*handle)->dev_info, s))
 	return CS_IN_USE;
     (*handle)->state |= CLIENT_WIN_REQ(w);
 
diff -urN linux-2.4.13-pre2/drivers/pcmcia/cs_internal.h pmac/drivers/pcmcia/cs_internal.h
--- linux-2.4.13-pre2/drivers/pcmcia/cs_internal.h	Fri Jan  5 09:51:32 2001
+++ pmac/drivers/pcmcia/cs_internal.h	Sat Sep  8 16:25:06 2001
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
diff -urN linux-2.4.13-pre2/drivers/pcmcia/rsrc_mgr.c pmac/drivers/pcmcia/rsrc_mgr.c
--- linux-2.4.13-pre2/drivers/pcmcia/rsrc_mgr.c	Sat Jul 21 09:51:56 2001
+++ pmac/drivers/pcmcia/rsrc_mgr.c	Sat Sep  8 16:25:06 2001
@@ -44,6 +44,7 @@
 #include <linux/ioport.h>
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
+#include <linux/pci.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 
@@ -104,8 +105,78 @@
 
 ======================================================================*/
 
-#define check_io_resource(b,n)	check_resource(&ioport_resource, (b), (n))
-#define check_mem_resource(b,n)	check_resource(&iomem_resource, (b), (n))
+static struct resource *resource_parent(unsigned long b, unsigned long n,
+					int flags, struct pci_dev *dev)
+{
+	struct resource res;
+
+	if (dev == NULL) {
+		if (flags & IORESOURCE_MEM)
+			return &iomem_resource;
+		return &ioport_resource;
+	}
+	res.start = b;
+	res.end = b + n - 1;
+	res.flags = flags;
+	return pci_find_parent_resource(dev, &res);
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
 
@@ -195,7 +266,7 @@
     }   
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
-	if (check_io_resource(i, 8))
+	if (check_io_resource(i, 8, NULL))
 	    continue;
 	hole = inb(i);
 	for (j = 1; j < 8; j++)
@@ -208,7 +279,7 @@
 
     bad = any = 0;
     for (i = base; i < base+num; i += 8) {
-	if (check_io_resource(i, 8))
+	if (check_io_resource(i, 8, NULL))
 	    continue;
 	for (j = 0; j < 8; j++)
 	    if (inb(i+j) != most) break;
@@ -248,7 +319,8 @@
 ======================================================================*/
 
 static int do_mem_probe(u_long base, u_long num,
-			int (*is_valid)(u_long), int (*do_cksum)(u_long))
+			int (*is_valid)(u_long), int (*do_cksum)(u_long),
+			socket_info_t *s)
 {
     u_long i, j, bad, fail, step;
 
@@ -259,13 +331,14 @@
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
@@ -284,7 +357,7 @@
 
 static u_long inv_probe(int (*is_valid)(u_long),
 			int (*do_cksum)(u_long),
-			resource_map_t *m)
+			resource_map_t *m, socket_info_t *s)
 {
     u_long ok;
     if (m == &mem_db)
@@ -297,11 +370,11 @@
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
@@ -322,7 +395,7 @@
 	/* Only probe < 1 MB */
 	if (m->base >= 0x100000) continue;
 	if ((m->base | m->num) & 0xffff) {
-	    ok += do_mem_probe(m->base, m->num, is_valid, do_cksum);
+	    ok += do_mem_probe(m->base, m->num, is_valid, do_cksum, s);
 	    continue;
 	}
 	/* Special probe for 64K-aligned block */
@@ -332,7 +405,7 @@
 		if (ok >= mem_limit)
 		    sub_interval(&mem_db, b, 0x10000);
 		else
-		    ok += do_mem_probe(b, 0x10000, is_valid, do_cksum);
+		    ok += do_mem_probe(b, 0x10000, is_valid, do_cksum, s);
 	    }
 	}
     }
@@ -341,7 +414,7 @@
 #else /* CONFIG_ISA */
 
 void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
-		  int force_low)
+		  int force_low, socket_info_t *s)
 {
     resource_map_t *m;
     static int done = 0;
@@ -349,7 +422,7 @@
     if (!probe_mem || done++)
 	return;
     for (m = mem_db.next; m != &mem_db; m = m->next)
-	if (do_mem_probe(m->base, m->num, is_valid, do_cksum))
+	if (do_mem_probe(m->base, m->num, is_valid, do_cksum, s))
 	    return;
 }
 
@@ -369,7 +442,7 @@
 ======================================================================*/
 
 int find_io_region(ioaddr_t *base, ioaddr_t num, ioaddr_t align,
-		   char *name)
+		   char *name, socket_info_t *s)
 {
     ioaddr_t try;
     resource_map_t *m;
@@ -379,9 +452,8 @@
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
@@ -391,7 +463,7 @@
 }
 
 int find_mem_region(u_long *base, u_long num, u_long align,
-		    int force_low, char *name)
+		    int force_low, char *name, socket_info_t *s)
 {
     u_long try;
     resource_map_t *m;
@@ -404,8 +476,7 @@
 	    for (try = (try >= m->base) ? try : try+align;
 		 (try >= m->base) && (try+num <= m->base+m->num);
 		 try += align) {
-		if (check_mem_resource(try, num) == 0) {
-		    request_mem_region(try, num, name);
+		if (request_mem_resource(try, num, name, s->cap.cb_dev) == 0) {
 		    *base = try;
 		    return 0;
 		}
