Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266480AbRGHIet>; Sun, 8 Jul 2001 04:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266797AbRGHIek>; Sun, 8 Jul 2001 04:34:40 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:28687 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266480AbRGHIeW>;
	Sun, 8 Jul 2001 04:34:22 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15176.6825.508736.915376@tango.paulus.ozlabs.org>
Date: Sun, 8 Jul 2001 18:32:41 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, <dhinds@zen.stanford.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Memory region check in drivers/pcmcia/rsrc_mgr.c
In-Reply-To: <Pine.LNX.4.33.0107071103070.31249-100000@penguin.transmeta.com>
In-Reply-To: <15174.62880.772230.734585@tango.paulus.ozlabs.org>
	<Pine.LNX.4.33.0107071103070.31249-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> HOWEVER, you can change the resource checking to use the proper "parent
> resource" instead of using the root resource. I absolutely agree that
> using the root resource is wrong per se - it depends (incorrectly) on the
> fact that on all laptops the PCMCIA controller tends to be on the root
> bus.

I was able to do this more easily than I had expected, and there is a
(lightly-tested) patch below for comment and testing.  The main thing
is that the routines in rsrc_mgr.c now basically need to get a handle
for the parent resource for the pcmcia socket controller that we are
concerned with at the moment.  To get this I use the s->cap.cb_dev
field, which AFAICS gets set to the pci_dev for the controller for PCI
controllers and should be NULL for ISA controllers.  If there is a
better way to get hold of the pci_dev let me know.

I have added a socket_info_t *s argument to validate_mem,
find_io_region and find_mem_region, so that we can get at
s->cap.cb_dev.  The callers of these routines all have the
socket_info_t pointer readily to hand.  We could pass in &s->cap or
s->cap.cb_dev instead, but passing s seems to be the easiest and most
generally useful option.

If s or s->cap.cb_dev is NULL the routines fall back to the old
behaviour, i.e. using ioport_resource or iomem_resource.  Of course it
is possible that the ISA memory and I/O space could be a sub-node in
the ioport/mem_resource trees, and that we should be using those nodes
for ISA pcmcia controllers rather than ioport/mem_resource.  If that
is so then we need to define new isa_ioport_resource and
isa_iomem_resource variables and set them in the architecture-specific
PCI code.

I also fixed the problem that Jeff Garzik pointed out, which is that
the existing code in find_io_region does a check_io_resource followed
by a request_region, without checking the return from request_region,
which is potentially racy (anyone for an SMP laptop? :).  (And
find_mem_region does the analogous thing.)  I replaced the pair of
calls with a single call to a new function, request_io_resource, which
attempts to allocate the region in the socket controller's parent
resource.  Similarly there is a new request_mem_resource function
used in find_mem_region.

> Note that the CardBus side gets this all right - I assume that a 32-bit
> CardBus card with a PCI driver should work on your powerbook even without
> this patch, no?

I assume so, but I don't have any cardbus devices to test it with.

Regards,
Paul.

diff -urN linux/drivers/pcmcia/cistpl.c pmac/drivers/pcmcia/cistpl.c
--- linux/drivers/pcmcia/cistpl.c	Thu Feb 22 14:25:19 2001
+++ pmac/drivers/pcmcia/cistpl.c	Sun Jul  8 17:57:37 2001
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
diff -urN linux/drivers/pcmcia/cs.c pmac/drivers/pcmcia/cs.c
--- linux/drivers/pcmcia/cs.c	Wed Jul  4 14:33:24 2001
+++ pmac/drivers/pcmcia/cs.c	Sun Jul  8 17:57:36 2001
@@ -797,7 +797,7 @@
 	    return 1;
     for (i = 0; i < MAX_IO_WIN; i++) {
 	if (s->io[i].NumPorts == 0) {
-	    if (find_io_region(base, num, align, name) == 0) {
+	    if (find_io_region(base, num, align, name, s) == 0) {
 		s->io[i].Attributes = attr;
 		s->io[i].BasePort = *base;
 		s->io[i].NumPorts = s->io[i].InUse = num;
@@ -809,7 +809,7 @@
 	/* Try to extend top of window */
 	try = s->io[i].BasePort + s->io[i].NumPorts;
 	if ((*base == 0) || (*base == try))
-	    if (find_io_region(&try, num, 0, name) == 0) {
+	    if (find_io_region(&try, num, 0, name, s) == 0) {
 		*base = try;
 		s->io[i].NumPorts += num;
 		s->io[i].InUse += num;
@@ -818,7 +818,7 @@
 	/* Try to extend bottom of window */
 	try = s->io[i].BasePort - num;
 	if ((*base == 0) || (*base == try))
-	    if (find_io_region(&try, num, 0, name) == 0) {
+	    if (find_io_region(&try, num, 0, name, s) == 0) {
 		s->io[i].BasePort = *base = try;
 		s->io[i].NumPorts += num;
 		s->io[i].InUse += num;
@@ -1960,7 +1960,7 @@
 	find_mem_region(&win->base, win->size, align,
 			(req->Attributes & WIN_MAP_BELOW_1MB) ||
 			!(s->cap.features & SS_CAP_PAGE_REGS),
-			(*handle)->dev_info))
+			(*handle)->dev_info, s))
 	return CS_IN_USE;
     (*handle)->state |= CLIENT_WIN_REQ(w);
 
diff -urN linux/drivers/pcmcia/cs_internal.h pmac/drivers/pcmcia/cs_internal.h
--- linux/drivers/pcmcia/cs_internal.h	Fri Jan  5 09:51:32 2001
+++ pmac/drivers/pcmcia/cs_internal.h	Sun Jul  8 17:55:00 2001
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
diff -urN linux/drivers/pcmcia/rsrc_mgr.c pmac/drivers/pcmcia/rsrc_mgr.c
--- linux/drivers/pcmcia/rsrc_mgr.c	Sat Mar 31 03:06:19 2001
+++ pmac/drivers/pcmcia/rsrc_mgr.c	Sun Jul  8 17:56:30 2001
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
+					int flags, socket_info_t *s)
+{
+	struct resource res;
+
+	if (s == NULL || s->cap.cb_dev == NULL) {
+		if (flags & IORESOURCE_MEM)
+			return &iomem_resource;
+		return &ioport_resource;
+	}
+	res.start = b;
+	res.end = b + n - 1;
+	res.flags = flags;
+	return pci_find_parent_resource(s->cap.cb_dev, &res);
+}
+
+static inline int check_io_resource(unsigned long b, unsigned long n,
+				    socket_info_t *s)
+{
+	return check_resource(resource_parent(b, n, IORESOURCE_IO, s), b, n);
+}
+
+static inline int check_mem_resource(unsigned long b, unsigned long n,
+				     socket_info_t *s)
+{
+	return check_resource(resource_parent(b, n, IORESOURCE_MEM, s), b, n);
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
+			       char *name, socket_info_t *s)
+{
+	struct resource *res = make_resource(b, n, IORESOURCE_IO, name);
+	struct resource *pr = resource_parent(b, n, IORESOURCE_IO, s);
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
+				char *name, socket_info_t *s)
+{
+	struct resource *res = make_resource(b, n, IORESOURCE_MEM, name);
+	struct resource *pr = resource_parent(b, n, IORESOURCE_MEM, s);
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
 
@@ -191,7 +262,7 @@
     b = kmalloc(256, GFP_KERNEL);
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
-	if (check_io_resource(i, 8))
+	if (check_io_resource(i, 8, NULL))
 	    continue;
 	hole = inb(i);
 	for (j = 1; j < 8; j++)
@@ -204,7 +275,7 @@
 
     bad = any = 0;
     for (i = base; i < base+num; i += 8) {
-	if (check_io_resource(i, 8))
+	if (check_io_resource(i, 8, NULL))
 	    continue;
 	for (j = 0; j < 8; j++)
 	    if (inb(i+j) != most) break;
@@ -244,7 +315,8 @@
 ======================================================================*/
 
 static int do_mem_probe(u_long base, u_long num,
-			int (*is_valid)(u_long), int (*do_cksum)(u_long))
+			int (*is_valid)(u_long), int (*do_cksum)(u_long),
+			socket_info_t *s)
 {
     u_long i, j, bad, fail, step;
 
@@ -255,13 +327,13 @@
     for (i = j = base; i < base+num; i = j + step) {
 	if (!fail) {	
 	    for (j = i; j < base+num; j += step)
-		if ((check_mem_resource(j, step) == 0) && is_valid(j))
+		if ((check_mem_resource(j, step, s) == 0) && is_valid(j))
 		    break;
 	    fail = ((i == base) && (j == base+num));
 	}
 	if (fail) {
 	    for (j = i; j < base+num; j += 2*step)
-		if ((check_mem_resource(j, 2*step) == 0) &&
+		if ((check_mem_resource(j, 2*step, s) == 0) &&
 		    do_cksum(j) && do_cksum(j+step))
 		    break;
 	}
@@ -280,7 +352,7 @@
 
 static u_long inv_probe(int (*is_valid)(u_long),
 			int (*do_cksum)(u_long),
-			resource_map_t *m)
+			resource_map_t *m, socket_info_t *s)
 {
     u_long ok;
     if (m == &mem_db)
@@ -293,11 +365,11 @@
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
@@ -318,7 +390,7 @@
 	/* Only probe < 1 MB */
 	if (m->base >= 0x100000) continue;
 	if ((m->base | m->num) & 0xffff) {
-	    ok += do_mem_probe(m->base, m->num, is_valid, do_cksum);
+	    ok += do_mem_probe(m->base, m->num, is_valid, do_cksum, s);
 	    continue;
 	}
 	/* Special probe for 64K-aligned block */
@@ -328,7 +400,7 @@
 		if (ok >= mem_limit)
 		    sub_interval(&mem_db, b, 0x10000);
 		else
-		    ok += do_mem_probe(b, 0x10000, is_valid, do_cksum);
+		    ok += do_mem_probe(b, 0x10000, is_valid, do_cksum, s);
 	    }
 	}
     }
@@ -337,7 +409,7 @@
 #else /* CONFIG_ISA */
 
 void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
-		  int force_low)
+		  int force_low, socket_info_t *s)
 {
     resource_map_t *m;
     static int done = 0;
@@ -345,7 +417,7 @@
     if (!probe_mem || done++)
 	return;
     for (m = mem_db.next; m != &mem_db; m = m->next)
-	if (do_mem_probe(m->base, m->num, is_valid, do_cksum))
+	if (do_mem_probe(m->base, m->num, is_valid, do_cksum, s))
 	    return;
 }
 
@@ -365,7 +437,7 @@
 ======================================================================*/
 
 int find_io_region(ioaddr_t *base, ioaddr_t num, ioaddr_t align,
-		   char *name)
+		   char *name, socket_info_t *s)
 {
     ioaddr_t try;
     resource_map_t *m;
@@ -375,9 +447,8 @@
 	for (try = (try >= m->base) ? try : try+align;
 	     (try >= m->base) && (try+num <= m->base+m->num);
 	     try += align) {
-	    if (check_io_resource(try, num) == 0) {
+	    if (request_io_resource(try, num, name, s) == 0) {
 		*base = try;
-		request_region(try, num, name);
 		return 0;
 	    }
 	    if (!align) break;
@@ -387,7 +458,7 @@
 }
 
 int find_mem_region(u_long *base, u_long num, u_long align,
-		    int force_low, char *name)
+		    int force_low, char *name, socket_info_t *s)
 {
     u_long try;
     resource_map_t *m;
@@ -400,8 +471,7 @@
 	    for (try = (try >= m->base) ? try : try+align;
 		 (try >= m->base) && (try+num <= m->base+m->num);
 		 try += align) {
-		if (check_mem_resource(try, num) == 0) {
-		    request_mem_region(try, num, name);
+		if (request_mem_resource(try, num, name, s) == 0) {
 		    *base = try;
 		    return 0;
 		}
