Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbTCZTgU>; Wed, 26 Mar 2003 14:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262005AbTCZTgU>; Wed, 26 Mar 2003 14:36:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24331 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262003AbTCZTgQ>; Wed, 26 Mar 2003 14:36:16 -0500
Date: Wed, 26 Mar 2003 19:47:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PULL] (5/9) PCMCIA changes
Message-ID: <20030326194726.G8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030326193427.B8871@flint.arm.linux.org.uk> <20030326193511.C8871@flint.arm.linux.org.uk> <20030326193537.D8871@flint.arm.linux.org.uk> <20030326193601.E8871@flint.arm.linux.org.uk> <20030326193625.F8871@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326193625.F8871@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 26, 2003 at 07:36:25PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.889.359.4 -> 1.889.359.5
#	 drivers/pcmcia/cs.c	1.18    -> 1.19   
#	drivers/pcmcia/rsrc_mgr.c	1.10    -> 1.11   
#	drivers/pcmcia/Kconfig	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/18	rmk@flint.arm.linux.org.uk	1.889.359.5
# [PCMCIA] pcmcia-6: s/CONFIG_ISA/CONFIG_PCMCIA_PROBE/
# 
# Remove the dependence of the PCMCIA layer on CONFIG_ISA - introduce
# CONFIG_PCMCIA_PROBE to determine whether we need the resource
# handling code.  This prevents oopsen on SA11x0 and similar platforms
# which use statically mapped, non-windowed sockets.
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
--- a/drivers/pcmcia/Kconfig	Wed Mar 26 19:21:02 2003
+++ b/drivers/pcmcia/Kconfig	Wed Mar 26 19:21:02 2003
@@ -87,5 +87,9 @@
 	tristate "SA1111 support"
 	depends on PCMCIA_SA1100 && SA1111
 
+config PCMCIA_PROBE
+	bool
+	default y if ISA && !ARCH_SA1100 && !ARCH_CLPS711X
+
 endmenu
 
diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Wed Mar 26 19:21:02 2003
+++ b/drivers/pcmcia/cs.c	Wed Mar 26 19:21:02 2003
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
diff -Nru a/drivers/pcmcia/rsrc_mgr.c b/drivers/pcmcia/rsrc_mgr.c
--- a/drivers/pcmcia/rsrc_mgr.c	Wed Mar 26 19:21:02 2003
+++ b/drivers/pcmcia/rsrc_mgr.c	Wed Mar 26 19:21:02 2003
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

