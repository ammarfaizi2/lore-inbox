Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268206AbTBNXiJ>; Fri, 14 Feb 2003 18:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268364AbTBNXiJ>; Fri, 14 Feb 2003 18:38:09 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20608 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S268206AbTBNXhK>;
	Fri, 14 Feb 2003 18:37:10 -0500
Date: Fri, 14 Feb 2003 15:46:58 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60 3/9 ] Update the PC parallel port driver for new module API.
Message-ID: <20030214234658.GD13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below updates the PC parallel port driver to use the new module
interfaces.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/include/linux/parport_pc.h b/include/linux/parport_pc.h
--- a/include/linux/parport_pc.h	Fri Feb 14 09:50:44 2003
+++ b/include/linux/parport_pc.h	Fri Feb 14 09:50:44 2003
@@ -215,7 +215,7 @@
 
 extern void parport_pc_restore_state(struct parport *p, struct parport_state *s);
 
-extern void parport_pc_inc_use_count(void);
+extern int parport_pc_inc_use_count(void);
 
 extern void parport_pc_dec_use_count(void);
diff -Nru a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	Fri Feb 14 09:50:44 2003
+++ b/drivers/parport/parport_pc.c	Fri Feb 14 09:50:44 2003
@@ -1233,18 +1233,14 @@
  */
 
 
-void parport_pc_inc_use_count(void)
+int parport_pc_inc_use_count(void)
 {
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
+	return try_module_get(THIS_MODULE);
 }
 
 void parport_pc_dec_use_count(void)
 {
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
+	module_put(THIS_MODULE);
 }
 
 struct parport_operations parport_pc_ops = 
@@ -2212,16 +2208,32 @@
 	struct parport tmp;
 	struct parport *p = &tmp;
 	int probedirq = PARPORT_IRQ_NONE;
-	if (check_region(base, 3)) return NULL;
+	struct resource *base_res;
+	struct resource	*ECR_res = NULL;
+	struct resource	*EPP_res = NULL;
+	char *fake_name = "parport probe";
+
+	/*
+	 * Chicken and Egg problem.  request_region() wants the name of
+	 * the owner, but this instance will not know that name until
+	 * after the parport_register_port() call.  Give request_region()
+	 * a fake name until after parport_register_port(), then use
+	 * rename_region() to set correct name.
+	 */
+	base_res = request_region(base, 3, fake_name);
+	if (base_res == NULL)
+		return NULL;
 	priv = kmalloc (sizeof (struct parport_pc_private), GFP_KERNEL);
 	if (!priv) {
 		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
+		release_region(base, 3);
 		return NULL;
 	}
 	ops = kmalloc (sizeof (struct parport_operations), GFP_KERNEL);
 	if (!ops) {
 		printk (KERN_DEBUG "parport (0x%lx): no memory for ops!\n",
 			base);
+		release_region(base, 3);
 		kfree (priv);
 		return NULL;
 	}
@@ -2242,32 +2254,39 @@
 	p->private_data = priv;
 	p->physport = p;
 
-	if (base_hi && !check_region(base_hi,3))
-		parport_ECR_present(p);
+	if (base_hi) {
+		ECR_res = request_region(base_hi, 3, fake_name);
+		if (ECR_res)
+			parport_ECR_present(p);
+	}
 
 	if (base != 0x3bc) {
-		if (!check_region(base+0x3, 5)) {
+		EPP_res = request_region(base+0x3, 5, fake_name);
+		if (EPP_res)
 			if (!parport_EPP_supported(p))
 				parport_ECPEPP_supported(p);
-		}
 	}
-	if (!parport_SPP_supported (p)) {
+	if (!parport_SPP_supported (p))
 		/* No port. */
-		kfree (priv);
-		kfree (ops);
-		return NULL;
-	}
+		goto errout;
 	if (priv->ecr)
 		parport_ECPPS2_supported(p);
 	else
 		parport_PS2_supported (p);
 
 	if (!(p = parport_register_port(base, PARPORT_IRQ_NONE,
-					PARPORT_DMA_NONE, ops))) {
-		kfree (priv);
-		kfree (ops);
-		return NULL;
-	}
+					PARPORT_DMA_NONE, ops)))
+		goto errout;
+
+	/*
+	 * Now the real name is known... Replace the fake name
+	 * in the resources with the correct one.
+	 */
+	rename_region(base_res, p->name);
+	if (ECR_res)
+		rename_region(ECR_res, p->name);
+	if (EPP_res)
+		rename_region(EPP_res, p->name);
 
 	p->base_hi = base_hi;
 	p->modes = tmp.modes;
@@ -2343,11 +2362,11 @@
 		printk(KERN_INFO "%s: irq %d detected\n", p->name, probedirq);
 	parport_proc_register(p);
 
-	request_region (p->base, 3, p->name);
-	if (p->size > 3)
-		request_region (p->base + 3, p->size - 3, p->name);
-	if (p->modes & PARPORT_MODE_ECP)
-		request_region (p->base_hi, 3, p->name);
+	/* If No ECP release the ports grabbed above. */
+	if (ECR_res && (p->modes & PARPORT_MODE_ECP) == 0) {
+		release_region(base_hi, 3);
+		ECR_res = NULL;
+	}
 
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq (p->irq, parport_pc_interrupt,
@@ -2401,6 +2420,17 @@
 	parport_announce_port (p);
 
 	return p;
+
+errout:
+	release_region(p->base, 3);
+	if (ECR_res)
+		release_region(base_hi, 3);
+	if (EPP_res)
+		release_region(base+0x3, 5);
+
+	kfree (priv);
+	kfree (ops);
+	return NULL;
 }
 
 void parport_pc_unregister_port (struct parport *p)
@@ -2437,9 +2467,11 @@
 					 int autodma)
 {
 	short inta_addr[6] = { 0x2A0, 0x2C0, 0x220, 0x240, 0x1E0 };
+	struct resource *base_res;
 	u32 ite8872set;
 	u32 ite8872_lpt, ite8872_lpthi;
 	u8 ite8872_irq, type;
+	char *fake_name = "parport probe";
 	int irq;
 	int i;
 
@@ -2447,7 +2479,8 @@
 	
 	// make sure which one chip
 	for(i = 0; i < 5; i++) {
-		if (check_region (inta_addr[i], 0x8) >= 0) {
+		base_res = request_region(inta_addr[i], 0x8, fake_name);
+		if (base_res) {
 			int test;
 			pci_write_config_dword (pdev, 0x60,
 						0xe7000000 | inta_addr[i]);
@@ -2455,6 +2488,7 @@
 						0x00000000 | inta_addr[i]);
 			test = inb (inta_addr[i]);
 			if (test != 0xff) break;
+			release_region(inta_addr[i], 0x8);
 		}
 	}
 	if(i >= 5) {
@@ -2515,6 +2549,10 @@
 	if (autoirq != PARPORT_IRQ_AUTO)
 		irq = PARPORT_IRQ_NONE;
 
+	/*
+	 * Release the resource so that parport_pc_probe_port can get it.
+	 */
+	release_resource(base_res);
 	if (parport_pc_probe_port (ite8872_lpt, ite8872_lpthi,
 				   irq, PARPORT_DMA_NONE, NULL)) {
 		printk (KERN_INFO
