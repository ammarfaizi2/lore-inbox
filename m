Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbTCLUu3>; Wed, 12 Mar 2003 15:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262000AbTCLUu3>; Wed, 12 Mar 2003 15:50:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3853 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261945AbTCLUsf>; Wed, 12 Mar 2003 15:48:35 -0500
Date: Wed, 12 Mar 2003 20:59:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] 2/6 (3): Remove bus_* abstractions
Message-ID: <20030312205918.E27656@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030312205659.C27656@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030312205659.C27656@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 12, 2003 at 08:56:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcmcia-3.diff

  Remove the bus_* abstractions; they are unused.

diff -ur orig/drivers/pcmcia/cistpl.c linux/drivers/pcmcia/cistpl.c
--- orig/drivers/pcmcia/cistpl.c	Wed Feb 26 01:04:40 2003
+++ linux/drivers/pcmcia/cistpl.c	Sat Mar  1 19:07:24 2003
@@ -49,7 +49,6 @@
 #include <asm/byteorder.h>
 
 #include <pcmcia/cs_types.h>
-#include <pcmcia/bus_ops.h>
 #include <pcmcia/ss.h>
 #include <pcmcia/cs.h>
 #include <pcmcia/bulkmem.h>
@@ -103,9 +102,8 @@
     s->ss_entry->set_mem_map(s->sock, mem);
     if (s->cap.features & SS_CAP_STATIC_MAP) {
 	if (s->cis_virt)
-	    bus_iounmap(s->cap.bus, s->cis_virt);
-	s->cis_virt = bus_ioremap(s->cap.bus, mem->sys_start,
-				  s->cap.map_size);
+	    iounmap(s->cis_virt);
+	s->cis_virt = ioremap(mem->sys_start, s->cap.map_size);
     }
 }
 
@@ -130,13 +128,13 @@
 	mem->card_start = 0; mem->flags = MAP_ACTIVE;
 	set_cis_map(s, mem);
 	sys = s->cis_virt;
-	bus_writeb(s->cap.bus, flags, sys+CISREG_ICTRL0);
-	bus_writeb(s->cap.bus, addr & 0xff, sys+CISREG_IADDR0);
-	bus_writeb(s->cap.bus, (addr>>8) & 0xff, sys+CISREG_IADDR1);
-	bus_writeb(s->cap.bus, (addr>>16) & 0xff, sys+CISREG_IADDR2);
-	bus_writeb(s->cap.bus, (addr>>24) & 0xff, sys+CISREG_IADDR3);
+	writeb(flags, sys+CISREG_ICTRL0);
+	writeb(addr & 0xff, sys+CISREG_IADDR0);
+	writeb((addr>>8) & 0xff, sys+CISREG_IADDR1);
+	writeb((addr>>16) & 0xff, sys+CISREG_IADDR2);
+	writeb((addr>>24) & 0xff, sys+CISREG_IADDR3);
 	for ( ; len > 0; len--, buf++)
-	    *buf = bus_readb(s->cap.bus, sys+CISREG_IDATA0);
+	    *buf = readb(sys+CISREG_IDATA0);
     } else {
 	u_int inc = 1;
 	if (attr) { mem->flags |= MAP_ATTRIB; inc++; addr *= 2; }
@@ -147,7 +145,7 @@
 	    sys = s->cis_virt + (addr & (s->cap.map_size-1));
 	    for ( ; len > 0; len--, buf++, sys += inc) {
 		if (sys == s->cis_virt+s->cap.map_size) break;
-		*buf = bus_readb(s->cap.bus, sys);
+		*buf = readb(sys);
 	    }
 	    mem->card_start += s->cap.map_size;
 	    addr = 0;
@@ -177,13 +175,13 @@
 	mem->card_start = 0; mem->flags = MAP_ACTIVE;
 	set_cis_map(s, mem);
 	sys = s->cis_virt;
-	bus_writeb(s->cap.bus, flags, sys+CISREG_ICTRL0);
-	bus_writeb(s->cap.bus, addr & 0xff, sys+CISREG_IADDR0);
-	bus_writeb(s->cap.bus, (addr>>8) & 0xff, sys+CISREG_IADDR1);
-	bus_writeb(s->cap.bus, (addr>>16) & 0xff, sys+CISREG_IADDR2);
-	bus_writeb(s->cap.bus, (addr>>24) & 0xff, sys+CISREG_IADDR3);
+	writeb(flags, sys+CISREG_ICTRL0);
+	writeb(addr & 0xff, sys+CISREG_IADDR0);
+	writeb((addr>>8) & 0xff, sys+CISREG_IADDR1);
+	writeb((addr>>16) & 0xff, sys+CISREG_IADDR2);
+	writeb((addr>>24) & 0xff, sys+CISREG_IADDR3);
 	for ( ; len > 0; len--, buf++)
-	    bus_writeb(s->cap.bus, *buf, sys+CISREG_IDATA0);
+	    writeb(*buf, sys+CISREG_IDATA0);
     } else {
 	int inc = 1;
 	if (attr & IS_ATTR) { mem->flags |= MAP_ATTRIB; inc++; addr *= 2; }
@@ -193,7 +191,7 @@
 	    sys = s->cis_virt + (addr & (s->cap.map_size-1));
 	    for ( ; len > 0; len--, buf++, sys += inc) {
 		if (sys == s->cis_virt+s->cap.map_size) break;
-		bus_writeb(s->cap.bus, *buf, sys);
+		writeb(*buf, sys);
 	    }
 	    mem->card_start += s->cap.map_size;
 	    addr = 0;
@@ -218,18 +216,19 @@
     int ret;
     vs->cis_mem.sys_start = base;
     vs->cis_mem.sys_stop = base+vs->cap.map_size-1;
-    vs->cis_virt = bus_ioremap(vs->cap.bus, base, vs->cap.map_size);
+    vs->cis_virt = ioremap(base, vs->cap.map_size);
     ret = pcmcia_validate_cis(vs->clients, &info1);
     /* invalidate mapping and CIS cache */
-    bus_iounmap(vs->cap.bus, vs->cis_virt); vs->cis_used = 0;
+    iounmap(vs->cis_virt);
+    vs->cis_used = 0;
     if ((ret != 0) || (info1.Chains == 0))
 	return 0;
     vs->cis_mem.sys_start = base+vs->cap.map_size;
     vs->cis_mem.sys_stop = base+2*vs->cap.map_size-1;
-    vs->cis_virt = bus_ioremap(vs->cap.bus, base+vs->cap.map_size,
-			       vs->cap.map_size);
+    vs->cis_virt = ioremap(base+vs->cap.map_size, vs->cap.map_size);
     ret = pcmcia_validate_cis(vs->clients, &info2);
-    bus_iounmap(vs->cap.bus, vs->cis_virt); vs->cis_used = 0;
+    iounmap(vs->cis_virt);
+    vs->cis_used = 0;
     return ((ret == 0) && (info1.Chains == info2.Chains));
 }
 
@@ -239,17 +238,17 @@
     int i, a, b, d;
     vs->cis_mem.sys_start = base;
     vs->cis_mem.sys_stop = base+vs->cap.map_size-1;
-    vs->cis_virt = bus_ioremap(vs->cap.bus, base, vs->cap.map_size);
+    vs->cis_virt = ioremap(base, vs->cap.map_size);
     vs->cis_mem.card_start = 0;
     vs->cis_mem.flags = MAP_ACTIVE;
     vs->ss_entry->set_mem_map(vs->sock, &vs->cis_mem);
     /* Don't bother checking every word... */
     a = 0; b = -1;
     for (i = 0; i < vs->cap.map_size; i += 44) {
-	d = bus_readl(vs->cap.bus, vs->cis_virt+i);
+	d = readl(vs->cis_virt+i);
 	a += d; b &= d;
     }
-    bus_iounmap(vs->cap.bus, vs->cis_virt);
+    iounmap(vs->cis_virt);
     return (b == -1) ? -1 : (a>>1);
 }
 
@@ -274,8 +273,7 @@
 	    return -1;
 	}
 	s->cis_mem.sys_stop = s->cis_mem.sys_start+s->cap.map_size-1;
-	s->cis_virt = bus_ioremap(s->cap.bus, s->cis_mem.sys_start,
-				  s->cap.map_size);
+	s->cis_virt = ioremap(s->cis_mem.sys_start, s->cap.map_size);
     }
     return 0;
 }
@@ -287,7 +285,7 @@
 	s->ss_entry->set_mem_map(s->sock, &s->cis_mem);
 	if (!(s->cap.features & SS_CAP_STATIC_MAP))
 	    release_mem_region(s->cis_mem.sys_start, s->cap.map_size);
-	bus_iounmap(s->cap.bus, s->cis_virt);
+	iounmap(s->cis_virt);
 	s->cis_mem.sys_start = 0;
 	s->cis_virt = NULL;
     }
diff -ur orig/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- orig/drivers/pcmcia/cs.c	Wed Feb 26 01:04:40 2003
+++ linux/drivers/pcmcia/cs.c	Sat Mar  1 19:20:22 2003
@@ -59,7 +59,6 @@
 #include <pcmcia/bulkmem.h>
 #include <pcmcia/cistpl.h>
 #include <pcmcia/cisreg.h>
-#include <pcmcia/bus_ops.h>
 #include "cs_internal.h"
 
 #ifdef CONFIG_PCI
@@ -1469,7 +1468,6 @@
     client->event_handler = req->event_handler;
     client->event_callback_args = req->event_callback_args;
     client->event_callback_args.client_handle = client;
-    client->event_callback_args.bus = s->cap.bus;
 
     if (s->state & SOCKET_CARDBUS)
 	client->state |= CLIENT_CARDBUS;
@@ -1618,7 +1616,7 @@
     }
     
     if (req->Attributes & IRQ_HANDLE_PRESENT) {
-	bus_free_irq(s->cap.bus, req->AssignedIRQ, req->Instance);
+	free_irq(req->AssignedIRQ, req->Instance);
     }
 
 #ifdef CONFIG_ISA
@@ -1913,7 +1911,7 @@
     if (ret != 0) return ret;
 
     if (req->Attributes & IRQ_HANDLE_PRESENT) {
-	if (bus_request_irq(s->cap.bus, irq, req->Handler,
+	if (request_irq(irq, req->Handler,
 			    ((req->Attributes & IRQ_TYPE_DYNAMIC_SHARING) || 
 			     (s->functions > 1) ||
 			     (irq == s->cap.pci_irq)) ? SA_SHIRQ : 0,
diff -ur orig/drivers/pcmcia/sa1100_generic.c linux/drivers/pcmcia/sa1100_generic.c
--- orig/drivers/pcmcia/sa1100_generic.c	Thu Mar  2 10:00:13 2006
+++ linux/drivers/pcmcia/sa1100_generic.c	Thu Mar  2 10:00:24 2006
@@ -52,7 +52,6 @@
 #include <pcmcia/cs_types.h>
 #include <pcmcia/cs.h>
 #include <pcmcia/ss.h>
-#include <pcmcia/bus_ops.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
diff -ur orig/drivers/pcmcia/yenta.c linux/drivers/pcmcia/yenta.c
--- orig/drivers/pcmcia/yenta.c	Sun Mar  2 00:20:43 2003
+++ linux/drivers/pcmcia/yenta.c	Sat Mar  1 19:23:15 2003
@@ -514,7 +514,6 @@
 	socket->cap.pci_irq = socket->cb_irq;
 	socket->cap.irq_mask = yenta_probe_irq(socket, isa_irq_mask);
 	socket->cap.cb_dev = socket->dev;
-	socket->cap.bus = NULL;
 
 	printk("Yenta IRQ list %04x, PCI irq%d\n", socket->cap.irq_mask, socket->cb_irq);
 }
diff -ur orig/include/pcmcia/bus_ops.h linux/include/pcmcia/bus_ops.h
--- orig/include/pcmcia/bus_ops.h	Thu Feb 22 11:25:48 2001
+++ linux/include/pcmcia/bus_ops.h	Sat Mar  1 15:46:05 2003
@@ -1,152 +1,2 @@
-/*
- * bus_ops.h 1.10 2000/06/12 21:55:41
- *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
- * The initial developer of the original code is David A. Hinds
- * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
- * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
- *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
- */
-
-#ifndef _LINUX_BUS_OPS_H
-#define _LINUX_BUS_OPS_H
-
-#include <linux/config.h>
-
-#ifdef CONFIG_VIRTUAL_BUS
-
-typedef struct bus_operations {
-    void	*priv;
-    u32		(*b_in)(void *bus, u32 port, s32 sz);
-    void	(*b_ins)(void *bus, u32 port, void *buf,
-			 u32 count, s32 sz);
-    void	(*b_out)(void *bus, u32 val, u32 port, s32 sz);
-    void	(*b_outs)(void *bus, u32 port, void *buf,
-			  u32 count, s32 sz);
-    void	*(*b_ioremap)(void *bus, u_long ofs, u_long sz);
-    void	(*b_iounmap)(void *bus, void *addr);
-    u32		(*b_read)(void *bus, void *addr, s32 sz);
-    void	(*b_write)(void *bus, u32 val, void *addr, s32 sz);
-    void	(*b_copy_from)(void *bus, void *d, void *s, u32 count);
-    void	(*b_copy_to)(void *bus, void *d, void *s, u32 count);
-    int		(*b_request_irq)(void *bus, u_int irq,
-				 void (*handler)(int, void *,
-						 struct pt_regs *),
-				 u_long flags, const char *device,
-				 void *dev_id);
-    void	(*b_free_irq)(void *bus, u_int irq, void *dev_id);
-} bus_operations;
-
-#define bus_inb(b,p)		(b)->b_in((b),(p),0)
-#define bus_inw(b,p)		(b)->b_in((b),(p),1)
-#define bus_inl(b,p)		(b)->b_in((b),(p),2)
-#define bus_inw_ns(b,p)		(b)->b_in((b),(p),-1)
-#define bus_inl_ns(b,p)		(b)->b_in((b),(p),-2)
-
-#define bus_insb(b,p,a,c)	(b)->b_ins((b),(p),(a),(c),0)
-#define bus_insw(b,p,a,c)	(b)->b_ins((b),(p),(a),(c),1)
-#define bus_insl(b,p,a,c)	(b)->b_ins((b),(p),(a),(c),2)
-#define bus_insw_ns(b,p,a,c)	(b)->b_ins((b),(p),(a),(c),-1)
-#define bus_insl_ns(b,p,a,c)	(b)->b_ins((b),(p),(a),(c),-2)
-
-#define bus_outb(b,v,p)		(b)->b_out((b),(v),(p),0)
-#define bus_outw(b,v,p)		(b)->b_out((b),(v),(p),1)
-#define bus_outl(b,v,p)		(b)->b_out((b),(v),(p),2)
-#define bus_outw_ns(b,v,p)	(b)->b_out((b),(v),(p),-1)
-#define bus_outl_ns(b,v,p)	(b)->b_out((b),(v),(p),-2)
-
-#define bus_outsb(b,p,a,c)	(b)->b_outs((b),(p),(a),(c),0)
-#define bus_outsw(b,p,a,c)	(b)->b_outs((b),(p),(a),(c),1)
-#define bus_outsl(b,p,a,c)	(b)->b_outs((b),(p),(a),(c),2)
-#define bus_outsw_ns(b,p,a,c)	(b)->b_outs((b),(p),(a),(c),-1)
-#define bus_outsl_ns(b,p,a,c)	(b)->b_outs((b),(p),(a),(c),-2)
-
-#define bus_readb(b,a)		(b)->b_read((b),(a),0)
-#define bus_readw(b,a)		(b)->b_read((b),(a),1)
-#define bus_readl(b,a)		(b)->b_read((b),(a),2)
-#define bus_readw_ns(b,a)	(b)->b_read((b),(a),-1)
-#define bus_readl_ns(b,a)	(b)->b_read((b),(a),-2)
-
-#define bus_writeb(b,v,a)	(b)->b_write((b),(v),(a),0)
-#define bus_writew(b,v,a)	(b)->b_write((b),(v),(a),1)
-#define bus_writel(b,v,a)	(b)->b_write((b),(v),(a),2)
-#define bus_writew_ns(b,v,a)	(b)->b_write((b),(v),(a),-1)
-#define bus_writel_ns(b,v,a)	(b)->b_write((b),(v),(a),-2)
-
-#define bus_ioremap(b,s,n)	(b)->b_ioremap((b),(s),(n))
-#define bus_iounmap(b,a)	(b)->b_iounmap((b),(a))
-#define bus_memcpy_fromio(b,d,s,n) (b)->b_copy_from((b),(d),(s),(n))
-#define bus_memcpy_toio(b,d,s,n) (b)->b_copy_to((b),(d),(s),(n))
-
-#define bus_request_irq(b,i,h,f,n,d) \
-				(b)->b_request_irq((b),(i),(h),(f),(n),(d))
-#define bus_free_irq(b,i,d)	(b)->b_free_irq((b),(i),(d))
-
-#else
-
-#define bus_inb(b,p)		inb(p)
-#define bus_inw(b,p)		inw(p)
-#define bus_inl(b,p)		inl(p)
-#define bus_inw_ns(b,p)		inw_ns(p)
-#define bus_inl_ns(b,p)		inl_ns(p)
-
-#define bus_insb(b,p,a,c)	insb(p,a,c)
-#define bus_insw(b,p,a,c)	insw(p,a,c)
-#define bus_insl(b,p,a,c)	insl(p,a,c)
-#define bus_insw_ns(b,p,a,c)	insw_ns(p,a,c)
-#define bus_insl_ns(b,p,a,c)	insl_ns(p,a,c)
-
-#define bus_outb(b,v,p)		outb(b,v,p)
-#define bus_outw(b,v,p)		outw(b,v,p)
-#define bus_outl(b,v,p)		outl(b,v,p)
-#define bus_outw_ns(b,v,p)	outw_ns(b,v,p)
-#define bus_outl_ns(b,v,p)	outl_ns(b,v,p)
-
-#define bus_outsb(b,p,a,c)	outsb(p,a,c)
-#define bus_outsw(b,p,a,c)	outsw(p,a,c)
-#define bus_outsl(b,p,a,c)	outsl(p,a,c)
-#define bus_outsw_ns(b,p,a,c)	outsw_ns(p,a,c)
-#define bus_outsl_ns(b,p,a,c)	outsl_ns(p,a,c)
-
-#define bus_readb(b,a)		readb(a)
-#define bus_readw(b,a)		readw(a)
-#define bus_readl(b,a)		readl(a)
-#define bus_readw_ns(b,a)	readw_ns(a)
-#define bus_readl_ns(b,a)	readl_ns(a)
-
-#define bus_writeb(b,v,a)	writeb(v,a)
-#define bus_writew(b,v,a)	writew(v,a)
-#define bus_writel(b,v,a)	writel(v,a)
-#define bus_writew_ns(b,v,a)	writew_ns(v,a)
-#define bus_writel_ns(b,v,a)	writel_ns(v,a)
-
-#define bus_ioremap(b,s,n)	ioremap(s,n)
-#define bus_iounmap(b,a)	iounmap(a)
-#define bus_memcpy_fromio(b,d,s,n) memcpy_fromio(d,s,n)
-#define bus_memcpy_toio(b,d,s,n) memcpy_toio(d,s,n)
-
-#define bus_request_irq(b,i,h,f,n,d) request_irq((i),(h),(f),(n),(d))
-#define bus_free_irq(b,i,d)	free_irq((i),(d))
-
-#endif /* CONFIG_VIRTUAL_BUS */
-
-#endif /* _LINUX_BUS_OPS_H */
+/* now empty */
+#warning please remove the reference to this file
diff -ur orig/include/pcmcia/cs.h linux/include/pcmcia/cs.h
--- orig/include/pcmcia/cs.h	Thu Feb 22 11:25:48 2001
+++ linux/include/pcmcia/cs.h	Sat Mar  1 13:09:31 2003
@@ -98,7 +98,6 @@
     void	*buffer;
     void	*misc;
     void	*client_data;
-    struct bus_operations *bus;
 } event_callback_args_t;
 
 /* for GetConfigurationInfo */
diff -ur orig/include/pcmcia/ss.h linux/include/pcmcia/ss.h
--- orig/include/pcmcia/ss.h	Tue Feb 25 10:57:59 2003
+++ linux/include/pcmcia/ss.h	Sat Mar  1 19:21:55 2003
@@ -58,7 +58,6 @@
     ioaddr_t	io_offset;
     u_char	pci_irq;
     struct pci_dev *cb_dev;
-    struct bus_operations *bus;
 } socket_cap_t;
 
 /* InquireSocket capabilities */


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

