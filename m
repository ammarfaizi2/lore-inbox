Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262024AbTCZTiP>; Wed, 26 Mar 2003 14:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbTCZTiO>; Wed, 26 Mar 2003 14:38:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26123 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262024AbTCZTg6>; Wed, 26 Mar 2003 14:36:58 -0500
Date: Wed, 26 Mar 2003 19:48:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PULL] (7/9) PCMCIA changes
Message-ID: <20030326194807.I8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030326193427.B8871@flint.arm.linux.org.uk> <20030326193511.C8871@flint.arm.linux.org.uk> <20030326193537.D8871@flint.arm.linux.org.uk> <20030326193601.E8871@flint.arm.linux.org.uk> <20030326193625.F8871@flint.arm.linux.org.uk> <20030326194726.G8871@flint.arm.linux.org.uk> <20030326194747.H8871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326194747.H8871@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 26, 2003 at 07:47:47PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889.359.6 -> 1.889.359.7
#	drivers/pcmcia/cs_internal.h	1.7     -> 1.8    
#	drivers/pcmcia/cistpl.c	1.9     -> 1.10   
#	drivers/pcmcia/rsrc_mgr.c	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/23	rmk@flint.arm.linux.org.uk	1.889.359.7
# [PCMCIA] pcmcia-8/9: Clean up CIS setup.
# 
# - Re-order functions in cistpl.c.
# - Combine setup_cis_mem and set_cis_map into one function.
# - Move cis_readable(), checksum() and checksum_match() into rsrc_mgr.c
# - Only pass the socket structure to validate_mem()
# - Remove socket_info_t *vs variable, and the race condition along
#   with it.
# - Pass the socket_info_t through validate_mem(), do_mem_probe() and
#   inv_probe() to these functions.
# - Call cis_readable() and checksum_match() directly from
#   do_mem_probe().
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
--- a/drivers/pcmcia/cistpl.c	Wed Mar 26 19:21:56 2003
+++ b/drivers/pcmcia/cistpl.c	Wed Mar 26 19:21:56 2003
@@ -84,6 +84,52 @@
 
 INT_MODULE_PARM(cis_width,	0);		/* 16-bit CIS? */
 
+void release_cis_mem(socket_info_t *s)
+{
+    if (s->cis_mem.sys_start != 0) {
+	s->cis_mem.flags &= ~MAP_ACTIVE;
+	s->ss_entry->set_mem_map(s->sock, &s->cis_mem);
+	if (!(s->cap.features & SS_CAP_STATIC_MAP))
+	    release_mem_region(s->cis_mem.sys_start, s->cap.map_size);
+	iounmap(s->cis_virt);
+	s->cis_mem.sys_start = 0;
+	s->cis_virt = NULL;
+    }
+}
+
+/*
+ * Map the card memory at "card_offset" into virtual space.
+ * If flags & MAP_ATTRIB, map the attribute space, otherwise
+ * map the memory space.
+ */
+static unsigned char *
+set_cis_map(socket_info_t *s, unsigned int card_offset, unsigned int flags)
+{
+    pccard_mem_map *mem = &s->cis_mem;
+    if (!(s->cap.features & SS_CAP_STATIC_MAP) &&
+	mem->sys_start == 0) {
+	int low = !(s->cap.features & SS_CAP_PAGE_REGS);
+	validate_mem(s);
+	mem->sys_start = 0;
+	if (find_mem_region(&mem->sys_start, s->cap.map_size,
+			    s->cap.map_size, low, "card services", s)) {
+	    printk(KERN_NOTICE "cs: unable to map card memory!\n");
+	    return NULL;
+	}
+	mem->sys_stop = mem->sys_start+s->cap.map_size-1;
+	s->cis_virt = ioremap(mem->sys_start, s->cap.map_size);
+    }
+    mem->card_start = card_offset;
+    mem->flags = flags;
+    s->ss_entry->set_mem_map(s->sock, mem);
+    if (s->cap.features & SS_CAP_STATIC_MAP) {
+	if (s->cis_virt)
+	    iounmap(s->cis_virt);
+	s->cis_virt = ioremap(mem->sys_start, s->cap.map_size);
+    }
+    return s->cis_virt;
+}
+
 /*======================================================================
 
     Low-level functions to read and write CIS memory.  I think the
@@ -95,39 +141,28 @@
 #define IS_ATTR		1
 #define IS_INDIRECT	8
 
-static int setup_cis_mem(socket_info_t *s);
-
-static void set_cis_map(socket_info_t *s, pccard_mem_map *mem)
-{
-    s->ss_entry->set_mem_map(s->sock, mem);
-    if (s->cap.features & SS_CAP_STATIC_MAP) {
-	if (s->cis_virt)
-	    iounmap(s->cis_virt);
-	s->cis_virt = ioremap(mem->sys_start, s->cap.map_size);
-    }
-}
-
 int read_cis_mem(socket_info_t *s, int attr, u_int addr,
 		 u_int len, void *ptr)
 {
-    pccard_mem_map *mem = &s->cis_mem;
-    u_char *sys, *buf = ptr;
+    u_char *sys, *end, *buf = ptr;
     
     DEBUG(3, "cs: read_cis_mem(%d, %#x, %u)\n", attr, addr, len);
-    if (setup_cis_mem(s) != 0) {
-	memset(ptr, 0xff, len);
-	return -1;
-    }
-    mem->flags = MAP_ACTIVE | ((cis_width) ? MAP_16BIT : 0);
 
     if (attr & IS_INDIRECT) {
 	/* Indirect accesses use a bunch of special registers at fixed
 	   locations in common memory */
 	u_char flags = ICTRL0_COMMON|ICTRL0_AUTOINC|ICTRL0_BYTEGRAN;
-	if (attr & IS_ATTR) { addr *= 2; flags = ICTRL0_AUTOINC; }
-	mem->card_start = 0; mem->flags = MAP_ACTIVE;
-	set_cis_map(s, mem);
-	sys = s->cis_virt;
+	if (attr & IS_ATTR) {
+	    addr *= 2;
+	    flags = ICTRL0_AUTOINC;
+	}
+
+	sys = set_cis_map(s, 0, MAP_ACTIVE | ((cis_width) ? MAP_16BIT : 0));
+	if (!sys) {
+	    memset(ptr, 0xff, len);
+	    return -1;
+	}
+
 	writeb(flags, sys+CISREG_ICTRL0);
 	writeb(addr & 0xff, sys+CISREG_IADDR0);
 	writeb((addr>>8) & 0xff, sys+CISREG_IADDR1);
@@ -136,18 +171,30 @@
 	for ( ; len > 0; len--, buf++)
 	    *buf = readb(sys+CISREG_IDATA0);
     } else {
-	u_int inc = 1;
-	if (attr) { mem->flags |= MAP_ATTRIB; inc++; addr *= 2; }
-	sys += (addr & (s->cap.map_size-1));
-	mem->card_start = addr & ~(s->cap.map_size-1);
+	u_int inc = 1, card_offset, flags;
+
+	flags = MAP_ACTIVE | ((cis_width) ? MAP_16BIT : 0);
+	if (attr) {
+	    flags |= MAP_ATTRIB;
+	    inc++;
+	    addr *= 2;
+	}
+
+	card_offset = addr & ~(s->cap.map_size-1);
 	while (len) {
-	    set_cis_map(s, mem);
-	    sys = s->cis_virt + (addr & (s->cap.map_size-1));
+	    sys = set_cis_map(s, card_offset, flags);
+	    if (!sys) {
+		memset(ptr, 0xff, len);
+		return -1;
+	    }
+	    end = sys + s->cap.map_size;
+	    sys = sys + (addr & (s->cap.map_size-1));
 	    for ( ; len > 0; len--, buf++, sys += inc) {
-		if (sys == s->cis_virt+s->cap.map_size) break;
+		if (sys == end)
+		    break;
 		*buf = readb(sys);
 	    }
-	    mem->card_start += s->cap.map_size;
+	    card_offset += s->cap.map_size;
 	    addr = 0;
 	}
     }
@@ -160,21 +207,23 @@
 void write_cis_mem(socket_info_t *s, int attr, u_int addr,
 		   u_int len, void *ptr)
 {
-    pccard_mem_map *mem = &s->cis_mem;
-    u_char *sys, *buf = ptr;
+    u_char *sys, *end, *buf = ptr;
     
     DEBUG(3, "cs: write_cis_mem(%d, %#x, %u)\n", attr, addr, len);
-    if (setup_cis_mem(s) != 0) return;
-    mem->flags = MAP_ACTIVE | ((cis_width) ? MAP_16BIT : 0);
 
     if (attr & IS_INDIRECT) {
 	/* Indirect accesses use a bunch of special registers at fixed
 	   locations in common memory */
 	u_char flags = ICTRL0_COMMON|ICTRL0_AUTOINC|ICTRL0_BYTEGRAN;
-	if (attr & IS_ATTR) { addr *= 2; flags = ICTRL0_AUTOINC; }
-	mem->card_start = 0; mem->flags = MAP_ACTIVE;
-	set_cis_map(s, mem);
-	sys = s->cis_virt;
+	if (attr & IS_ATTR) {
+	    addr *= 2;
+	    flags = ICTRL0_AUTOINC;
+	}
+
+	sys = set_cis_map(s, 0, MAP_ACTIVE | ((cis_width) ? MAP_16BIT : 0));
+	if (!sys)
+		return; /* FIXME: Error */
+
 	writeb(flags, sys+CISREG_ICTRL0);
 	writeb(addr & 0xff, sys+CISREG_IADDR0);
 	writeb((addr>>8) & 0xff, sys+CISREG_IADDR1);
@@ -183,111 +232,31 @@
 	for ( ; len > 0; len--, buf++)
 	    writeb(*buf, sys+CISREG_IDATA0);
     } else {
-	int inc = 1;
-	if (attr & IS_ATTR) { mem->flags |= MAP_ATTRIB; inc++; addr *= 2; }
-	mem->card_start = addr & ~(s->cap.map_size-1);
+	u_int inc = 1, card_offset, flags;
+
+	flags = MAP_ACTIVE | ((cis_width) ? MAP_16BIT : 0);
+	if (attr & IS_ATTR) {
+	    flags |= MAP_ATTRIB;
+	    inc++;
+	    addr *= 2;
+	}
+
+	card_offset = addr & ~(s->cap.map_size-1);
 	while (len) {
-	    set_cis_map(s, mem);
-	    sys = s->cis_virt + (addr & (s->cap.map_size-1));
+	    sys = set_cis_map(s, card_offset, flags);
+	    if (!sys)
+		return; /* FIXME: error */
+
+	    end = sys + s->cap.map_size;
+	    sys = sys + (addr & (s->cap.map_size-1));
 	    for ( ; len > 0; len--, buf++, sys += inc) {
-		if (sys == s->cis_virt+s->cap.map_size) break;
+		if (sys == end)
+		    break;
 		writeb(*buf, sys);
 	    }
-	    mem->card_start += s->cap.map_size;
+	    card_offset += s->cap.map_size;
 	    addr = 0;
 	}
-    }
-}
-
-/*======================================================================
-
-    This is tricky... when we set up CIS memory, we try to validate
-    the memory window space allocations.
-    
-======================================================================*/
-
-/* Scratch pointer to the socket we use for validation */
-static socket_info_t *vs = NULL;
-
-/* Validation function for cards with a valid CIS */
-static int cis_readable(u_long base)
-{
-    cisinfo_t info1, info2;
-    int ret;
-    vs->cis_mem.sys_start = base;
-    vs->cis_mem.sys_stop = base+vs->cap.map_size-1;
-    vs->cis_virt = ioremap(base, vs->cap.map_size);
-    ret = pcmcia_validate_cis(vs->clients, &info1);
-    /* invalidate mapping and CIS cache */
-    iounmap(vs->cis_virt);
-    vs->cis_used = 0;
-    if ((ret != 0) || (info1.Chains == 0))
-	return 0;
-    vs->cis_mem.sys_start = base+vs->cap.map_size;
-    vs->cis_mem.sys_stop = base+2*vs->cap.map_size-1;
-    vs->cis_virt = ioremap(base+vs->cap.map_size, vs->cap.map_size);
-    ret = pcmcia_validate_cis(vs->clients, &info2);
-    iounmap(vs->cis_virt);
-    vs->cis_used = 0;
-    return ((ret == 0) && (info1.Chains == info2.Chains));
-}
-
-/* Validation function for simple memory cards */
-static int checksum(u_long base)
-{
-    int i, a, b, d;
-    vs->cis_mem.sys_start = base;
-    vs->cis_mem.sys_stop = base+vs->cap.map_size-1;
-    vs->cis_virt = ioremap(base, vs->cap.map_size);
-    vs->cis_mem.card_start = 0;
-    vs->cis_mem.flags = MAP_ACTIVE;
-    vs->ss_entry->set_mem_map(vs->sock, &vs->cis_mem);
-    /* Don't bother checking every word... */
-    a = 0; b = -1;
-    for (i = 0; i < vs->cap.map_size; i += 44) {
-	d = readl(vs->cis_virt+i);
-	a += d; b &= d;
-    }
-    iounmap(vs->cis_virt);
-    return (b == -1) ? -1 : (a>>1);
-}
-
-static int checksum_match(u_long base)
-{
-    int a = checksum(base), b = checksum(base+vs->cap.map_size);
-    return ((a == b) && (a >= 0));
-}
-
-static int setup_cis_mem(socket_info_t *s)
-{
-    if (!(s->cap.features & SS_CAP_STATIC_MAP) &&
-	(s->cis_mem.sys_start == 0)) {
-	int low = !(s->cap.features & SS_CAP_PAGE_REGS);
-	vs = s;
-	validate_mem(cis_readable, checksum_match, low, s);
-	s->cis_mem.sys_start = 0;
-	vs = NULL;
-	if (find_mem_region(&s->cis_mem.sys_start, s->cap.map_size,
-			    s->cap.map_size, low, "card services", s)) {
-	    printk(KERN_NOTICE "cs: unable to map card memory!\n");
-	    return -1;
-	}
-	s->cis_mem.sys_stop = s->cis_mem.sys_start+s->cap.map_size-1;
-	s->cis_virt = ioremap(s->cis_mem.sys_start, s->cap.map_size);
-    }
-    return 0;
-}
-
-void release_cis_mem(socket_info_t *s)
-{
-    if (s->cis_mem.sys_start != 0) {
-	s->cis_mem.flags &= ~MAP_ACTIVE;
-	s->ss_entry->set_mem_map(s->sock, &s->cis_mem);
-	if (!(s->cap.features & SS_CAP_STATIC_MAP))
-	    release_mem_region(s->cis_mem.sys_start, s->cap.map_size);
-	iounmap(s->cis_virt);
-	s->cis_mem.sys_start = 0;
-	s->cis_virt = NULL;
     }
 }
 
diff -Nru a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
--- a/drivers/pcmcia/cs_internal.h	Wed Mar 26 19:21:56 2003
+++ b/drivers/pcmcia/cs_internal.h	Wed Mar 26 19:21:56 2003
@@ -233,8 +233,7 @@
 int copy_memory(memory_handle_t handle, copy_op_t *req);
 
 /* In rsrc_mgr */
-void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
-		  int force_low, socket_info_t *s);
+void validate_mem(socket_info_t *s);
 int find_io_region(ioaddr_t *base, ioaddr_t num, ioaddr_t align,
 		   char *name, socket_info_t *s);
 int find_mem_region(u_long *base, u_long num, u_long align,
diff -Nru a/drivers/pcmcia/rsrc_mgr.c b/drivers/pcmcia/rsrc_mgr.c
--- a/drivers/pcmcia/rsrc_mgr.c	Wed Mar 26 19:21:56 2003
+++ b/drivers/pcmcia/rsrc_mgr.c	Wed Mar 26 19:21:56 2003
@@ -337,15 +337,69 @@
 
 /*======================================================================
 
+    This is tricky... when we set up CIS memory, we try to validate
+    the memory window space allocations.
+    
+======================================================================*/
+
+/* Validation function for cards with a valid CIS */
+static int cis_readable(socket_info_t *s, u_long base)
+{
+    cisinfo_t info1, info2;
+    int ret;
+    s->cis_mem.sys_start = base;
+    s->cis_mem.sys_stop = base+s->cap.map_size-1;
+    s->cis_virt = ioremap(base, s->cap.map_size);
+    ret = pcmcia_validate_cis(s->clients, &info1);
+    /* invalidate mapping and CIS cache */
+    iounmap(s->cis_virt);
+    s->cis_used = 0;
+    if ((ret != 0) || (info1.Chains == 0))
+	return 0;
+    s->cis_mem.sys_start = base+s->cap.map_size;
+    s->cis_mem.sys_stop = base+2*s->cap.map_size-1;
+    s->cis_virt = ioremap(base+s->cap.map_size, s->cap.map_size);
+    ret = pcmcia_validate_cis(s->clients, &info2);
+    iounmap(s->cis_virt);
+    s->cis_used = 0;
+    return ((ret == 0) && (info1.Chains == info2.Chains));
+}
+
+/* Validation function for simple memory cards */
+static int checksum(socket_info_t *s, u_long base)
+{
+    int i, a, b, d;
+    s->cis_mem.sys_start = base;
+    s->cis_mem.sys_stop = base+s->cap.map_size-1;
+    s->cis_virt = ioremap(base, s->cap.map_size);
+    s->cis_mem.card_start = 0;
+    s->cis_mem.flags = MAP_ACTIVE;
+    s->ss_entry->set_mem_map(s->sock, &s->cis_mem);
+    /* Don't bother checking every word... */
+    a = 0; b = -1;
+    for (i = 0; i < s->cap.map_size; i += 44) {
+	d = readl(s->cis_virt+i);
+	a += d; b &= d;
+    }
+    iounmap(s->cis_virt);
+    return (b == -1) ? -1 : (a>>1);
+}
+
+static int checksum_match(socket_info_t *s, u_long base)
+{
+    int a = checksum(s, base), b = checksum(s, base+s->cap.map_size);
+    return ((a == b) && (a >= 0));
+}
+
+/*======================================================================
+
     The memory probe.  If the memory list includes a 64K-aligned block
     below 1MB, we probe in 64K chunks, and as soon as we accumulate at
     least mem_limit free space, we quit.
     
 ======================================================================*/
 
-static int do_mem_probe(u_long base, u_long num,
-			int (*is_valid)(u_long), int (*do_cksum)(u_long),
-			socket_info_t *s)
+static int do_mem_probe(u_long base, u_long num, socket_info_t *s)
 {
     u_long i, j, bad, fail, step;
 
@@ -353,18 +407,21 @@
 	   base, base+num-1);
     bad = fail = 0;
     step = (num < 0x20000) ? 0x2000 : ((num>>4) & ~0x1fff);
+    /* cis_readable wants to map 2x map_size */
+    if (step < 2 * s->cap.map_size)
+	step = 2 * s->cap.map_size;
     for (i = j = base; i < base+num; i = j + step) {
 	if (!fail) {	
 	    for (j = i; j < base+num; j += step)
 		if ((check_mem_resource(j, step, s->cap.cb_dev) == 0) &&
-		    is_valid(j))
+		    cis_readable(s, j))
 		    break;
 	    fail = ((i == base) && (j == base+num));
 	}
 	if (fail) {
 	    for (j = i; j < base+num; j += 2*step)
 		if ((check_mem_resource(j, 2*step, s->cap.cb_dev) == 0) &&
-		    do_cksum(j) && do_cksum(j+step))
+		    checksum_match(s, j) && checksum_match(s, j + step))
 		    break;
 	}
 	if (i != j) {
@@ -380,14 +437,12 @@
 
 #ifdef CONFIG_PCMCIA_PROBE
 
-static u_long inv_probe(int (*is_valid)(u_long),
-			int (*do_cksum)(u_long),
-			resource_map_t *m, socket_info_t *s)
+static u_long inv_probe(resource_map_t *m, socket_info_t *s)
 {
     u_long ok;
     if (m == &mem_db)
 	return 0;
-    ok = inv_probe(is_valid, do_cksum, m->next, s);
+    ok = inv_probe(m->next, s);
     if (ok) {
 	if (m->base >= 0x100000)
 	    sub_interval(&mem_db, m->base, m->num);
@@ -395,16 +450,16 @@
     }
     if (m->base < 0x100000)
 	return 0;
-    return do_mem_probe(m->base, m->num, is_valid, do_cksum, s);
+    return do_mem_probe(m->base, m->num, s);
 }
 
-void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
-		  int force_low, socket_info_t *s)
+void validate_mem(socket_info_t *s)
 {
     resource_map_t *m, *n;
     static u_char order[] = { 0xd0, 0xe0, 0xc0, 0xf0 };
     static int hi = 0, lo = 0;
     u_long b, i, ok = 0;
+    int force_low = !(s->cap.features & SS_CAP_PAGE_REGS);
 
     if (!probe_mem)
 	return;
@@ -412,7 +467,7 @@
     down(&rsrc_sem);
     /* We do up to four passes through the list */
     if (!force_low) {
-	if (hi++ || (inv_probe(is_valid, do_cksum, mem_db.next, s) > 0))
+	if (hi++ || (inv_probe(mem_db.next, s) > 0))
 	    goto out;
 	printk(KERN_NOTICE "cs: warning: no high memory space "
 	       "available!\n");
@@ -424,7 +479,7 @@
 	/* Only probe < 1 MB */
 	if (m->base >= 0x100000) continue;
 	if ((m->base | m->num) & 0xffff) {
-	    ok += do_mem_probe(m->base, m->num, is_valid, do_cksum, s);
+	    ok += do_mem_probe(m->base, m->num, s);
 	    continue;
 	}
 	/* Special probe for 64K-aligned block */
@@ -434,7 +489,7 @@
 		if (ok >= mem_limit)
 		    sub_interval(&mem_db, b, 0x10000);
 		else
-		    ok += do_mem_probe(b, 0x10000, is_valid, do_cksum, s);
+		    ok += do_mem_probe(b, 0x10000, s);
 	    }
 	}
     }
@@ -444,8 +499,7 @@
 
 #else /* CONFIG_PCMCIA_PROBE */
 
-void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
-		  int force_low, socket_info_t *s)
+void validate_mem(socket_info_t *s)
 {
     resource_map_t *m;
     static int done = 0;
@@ -453,7 +507,7 @@
     if (probe_mem && done++ == 0) {
 	down(&rsrc_sem);
 	for (m = mem_db.next; m != &mem_db; m = m->next)
-	    if (do_mem_probe(m->base, m->num, is_valid, do_cksum, s))
+	    if (do_mem_probe(m->base, m->num, s))
 		break;
 	up(&rsrc_sem);
     }

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

