Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbTCLUwv>; Wed, 12 Mar 2003 15:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbTCLUwP>; Wed, 12 Mar 2003 15:52:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6925 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262013AbTCLUv0>; Wed, 12 Mar 2003 15:51:26 -0500
Date: Wed, 12 Mar 2003 21:02:09 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] 5/6 (6): Introduce CONFIG_PCMCIA_PROBE
Message-ID: <20030312210209.H27656@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030312205659.C27656@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030312205659.C27656@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 12, 2003 at 08:56:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcmcia-6.diff

  Remove the dependence of the PCMCIA layer on CONFIG_ISA - introduce
  CONFIG_PCMCIA_PROBE to determine whether we need the resource
  handling code.  This prevents oopsen on SA11x0 and similar platforms
  which use statically mapped, non-windowed sockets.

diff -ur orig/drivers/pcmcia/Kconfig linux/drivers/pcmcia/Kconfig
--- orig/drivers/pcmcia/Kconfig	Tue Feb 11 16:10:23 2003
+++ linux/drivers/pcmcia/Kconfig	Mon Feb 10 23:30:30 2003
@@ -86,6 +86,10 @@
 config PCMCIA_SA1111
 	tristate "SA1111 support"
 	depends on PCMCIA_SA1100 && SA1111
+
+config PCMCIA_PROBE
+	bool
+	default y if ISA && !ARCH_SA1100 && !ARCH_CLPS711X
 
 endmenu
 
diff -ur orig/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- orig/drivers/pcmcia/cs.c	Sun Mar  2 17:05:18 2003
+++ linux/drivers/pcmcia/cs.c	Sun Mar  2 17:45:53 2003
@@ -1621,7 +1621,7 @@
 	free_irq(req->AssignedIRQ, req->Instance);
     }
 
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
     if (req->AssignedIRQ != s->cap.pci_irq)
 	undo_irq(req->Attributes, req->AssignedIRQ);
 #endif
@@ -1883,7 +1883,7 @@
     if (!s->cap.irq_mask) {
 	irq = s->cap.pci_irq;
 	ret = (irq) ? 0 : CS_IN_USE;
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
     } else if (s->irq.AssignedIRQ != 0) {
 	/* If the interrupt is already assigned, it must match */
 	irq = s->irq.AssignedIRQ;
diff -ur orig/drivers/pcmcia/rsrc_mgr.c linux/drivers/pcmcia/rsrc_mgr.c
--- orig/drivers/pcmcia/rsrc_mgr.c	Sun Mar  2 17:34:55 2003
+++ linux/drivers/pcmcia/rsrc_mgr.c	Sat Mar  1 19:09:21 2003
@@ -62,7 +62,7 @@
 #define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
 
 INT_MODULE_PARM(probe_mem,	1);		/* memory probe? */
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
 INT_MODULE_PARM(probe_io,	1);		/* IO port probe? */
 INT_MODULE_PARM(mem_limit,	0x10000);
 #endif
@@ -87,7 +87,7 @@
 
 static DECLARE_MUTEX(rsrc_sem);
 
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
 
 typedef struct irq_info_t {
     u_int			Attributes;
@@ -273,7 +273,7 @@
     
 ======================================================================*/
 
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
 static void do_io_probe(ioaddr_t base, ioaddr_t num)
 {
     
@@ -378,7 +378,7 @@
     return (num - bad);
 }
 
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
 
 static u_long inv_probe(int (*is_valid)(u_long),
 			int (*do_cksum)(u_long),
@@ -442,7 +442,7 @@
     up(&rsrc_sem);
 }
 
-#else /* CONFIG_ISA */
+#else /* CONFIG_PCMCIA_PROBE */
 
 void validate_mem(int (*is_valid)(u_long), int (*do_cksum)(u_long),
 		  int force_low, socket_info_t *s)
@@ -459,7 +459,7 @@
     }
 }
 
-#endif /* CONFIG_ISA */
+#endif /* CONFIG_PCMCIA_PROBE */
 
 /*======================================================================
 
@@ -545,7 +545,7 @@
     
 ======================================================================*/
 
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
 
 static void fake_irq(int i, void *d, struct pt_regs *r) { }
 static inline int check_irq(int irq)
@@ -634,7 +634,7 @@
 
 /*====================================================================*/
 
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
 
 void undo_irq(u_int Attributes, int irq)
 {
@@ -725,7 +725,7 @@
 	    ret = CS_IN_USE;
 	    break;
 	}
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
 	if (probe_io)
 	    do_io_probe(base, num);
 #endif
@@ -747,7 +747,7 @@
 static int adjust_irq(adjust_t *adj)
 {
     int ret = CS_SUCCESS;
-#ifdef CONFIG_ISA
+#ifdef CONFIG_PCMCIA_PROBE
     int irq;
     irq_info_t *info;
     

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

