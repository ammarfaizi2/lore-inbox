Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbSL3QEL>; Mon, 30 Dec 2002 11:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbSL3QEL>; Mon, 30 Dec 2002 11:04:11 -0500
Received: from verein.lst.de ([212.34.181.86]:57871 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S266976AbSL3QDy>;
	Mon, 30 Dec 2002 11:03:54 -0500
Date: Mon, 30 Dec 2002 17:12:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix i2c module handling
Message-ID: <20021230171209.A18665@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a struct module *owner field to struct i2c_adapter and i2c_algorithm
and do refcouting on them before use instead of the inc_use and dec_use
callbacks.  While at it convert those structures to named initializers.


--- 1.6/drivers/i2c/i2c-adap-ite.c	Sun Dec 29 16:43:46 2002
+++ edited/drivers/i2c/i2c-adap-ite.c	Mon Dec 30 11:32:34 2002
@@ -184,35 +184,6 @@
 	release_region(gpi.iic_base , 2);
 }
 
-
-static int iic_ite_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-
-static int iic_ite_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-
-static void iic_ite_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-
-static void iic_ite_dec_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
@@ -228,14 +199,10 @@
 };
 
 static struct i2c_adapter iic_ite_ops = {
-	"ITE IIC adapter",
-	I2C_HW_I_IIC,
-	NULL,
-	&iic_ite_data,
-	iic_ite_inc_use,
-	iic_ite_dec_use,
-	iic_ite_reg,
-	iic_ite_unreg,
+	.owner		= THIS_MODULE,
+	.name		= "ITE IIC adapter",
+	.id		= I2C_HW_I_IIC,
+	.algo_data	= &iic_ite_data,
 };
 
 /* Called when the module is loaded.  This function starts the
===== drivers/i2c/i2c-algo-bit.c 1.10 vs edited =====
--- 1.10/drivers/i2c/i2c-algo-bit.c	Sun Dec 29 13:28:36 2002
+++ edited/drivers/i2c/i2c-algo-bit.c	Mon Dec 30 12:16:31 2002
@@ -529,14 +529,11 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_bit_algo = {
-	"Bit-shift algorithm",
-	I2C_ALGO_BIT,
-	bit_xfer,
-	NULL,
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	bit_func,			/* functionality	*/
+	.name		= "Bit-shift algorithm",
+	.id		= I2C_ALGO_BIT,
+	.master_xfer	= bit_xfer,
+	.algo_control	= algo_control,
+	.functionality	= bit_func,
 };
 
 /* 
@@ -581,11 +578,7 @@
 		printk("\n");
 	}
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
 	i2c_add_adapter(adap);
-
 	return 0;
 }
 
@@ -599,9 +592,6 @@
 
 	DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: adapter unregistered: %s\n",adap->name));
 
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
===== drivers/i2c/i2c-algo-pcf.c 1.6 vs edited =====
--- 1.6/drivers/i2c/i2c-algo-pcf.c	Sun Dec 29 13:19:38 2002
+++ edited/drivers/i2c/i2c-algo-pcf.c	Mon Dec 30 12:20:20 2002
@@ -474,10 +474,6 @@
 		return i;
 	}
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-
 	i2c_add_adapter(adap);
 
 	/* scan bus */
@@ -509,15 +505,7 @@
 
 int i2c_pcf_del_bus(struct i2c_adapter *adap)
 {
-	int res;
-	if ((res = i2c_del_adapter(adap)) < 0)
-		return res;
-	DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: adapter unregistered: %s\n",adap->name));
-
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-	return 0;
+	return i2c_del_adapter(adap);
 }
 
 EXPORT_SYMBOL(i2c_pcf_add_bus);
===== drivers/i2c/i2c-core.c 1.13 vs edited =====
--- 1.13/drivers/i2c/i2c-core.c	Sun Dec 29 14:43:44 2002
+++ edited/drivers/i2c/i2c-core.c	Mon Dec 30 11:32:34 2002
@@ -446,24 +446,23 @@
 	return 0;
 }
 
-void i2c_inc_use_client(struct i2c_client *client)
+static int i2c_inc_use_client(struct i2c_client *client)
 {
 
-	if (client->driver->inc_use != NULL)
-		client->driver->inc_use(client);
+	if (!try_module_get(client->driver->owner))
+		return -ENODEV;
+	if (!try_module_get(client->adapter->owner)) {
+		module_put(client->driver->owner);
+		return -ENODEV;
+	}
 
-	if (client->adapter->inc_use != NULL)
-		client->adapter->inc_use(client->adapter);
+	return 0;
 }
 
-void i2c_dec_use_client(struct i2c_client *client)
+static void i2c_dec_use_client(struct i2c_client *client)
 {
-	
-	if (client->driver->dec_use != NULL)
-		client->driver->dec_use(client);
-
-	if (client->adapter->dec_use != NULL)
-		client->adapter->dec_use(client->adapter);
+	module_put(client->driver->owner);
+	module_put(client->adapter->owner);
 }
 
 struct i2c_client *i2c_get_client(int driver_id, int adapter_id, 
@@ -535,20 +534,22 @@
 
 int i2c_use_client(struct i2c_client *client)
 {
-	if(client->flags & I2C_CLIENT_ALLOW_USE) {
-		if (client->flags & I2C_CLIENT_ALLOW_MULTIPLE_USE) 
+	if (!i2c_inc_use_client(client))
+		return -ENODEV;
+
+	if (client->flags & I2C_CLIENT_ALLOW_USE) {
+		if (client->flags & I2C_CLIENT_ALLOW_MULTIPLE_USE)
+			client->usage_count++;
+		else if (client->usage_count > 0) 
+			goto busy;
+		else 
 			client->usage_count++;
-		else {
-			if(client->usage_count > 0) 
-				return -EBUSY;
-			 else 
-				client->usage_count++;
-		}
 	}
 
-	i2c_inc_use_client(client);
-
 	return 0;
+ busy:
+	i2c_dec_use_client(client);
+	return -EBUSY;
 }
 
 int i2c_release_client(struct i2c_client *client)
@@ -1420,8 +1421,6 @@
 EXPORT_SYMBOL(i2c_del_driver);
 EXPORT_SYMBOL(i2c_attach_client);
 EXPORT_SYMBOL(i2c_detach_client);
-EXPORT_SYMBOL(i2c_inc_use_client);
-EXPORT_SYMBOL(i2c_dec_use_client);
 EXPORT_SYMBOL(i2c_get_client);
 EXPORT_SYMBOL(i2c_use_client);
 EXPORT_SYMBOL(i2c_release_client);
===== drivers/i2c/i2c-dev.c 1.19 vs edited =====
--- 1.19/drivers/i2c/i2c-dev.c	Sun Dec 29 13:20:26 2002
+++ edited/drivers/i2c/i2c-dev.c	Mon Dec 30 11:32:34 2002
@@ -364,8 +364,10 @@
 	client->adapter = i2cdev_adaps[minor];
 	file->private_data = client;
 
-	if (i2cdev_adaps[minor]->inc_use)
-		i2cdev_adaps[minor]->inc_use(i2cdev_adaps[minor]);
+	if (!try_module_get(i2cdev_adaps[minor]->owner)) {
+		kfree(client);
+		return -ENODEV;
+	}
 
 #ifdef DEBUG
 	printk(KERN_DEBUG "i2c-dev.o: opened i2c-%d\n",minor);
@@ -381,10 +383,7 @@
 #ifdef DEBUG
 	printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
 #endif
-	lock_kernel();
-	if (i2cdev_adaps[minor]->dec_use)
-		i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
-	unlock_kernel();
+	module_put(i2cdev_adaps[minor]->owner);
 	return 0;
 }
 
===== drivers/i2c/i2c-elektor.c 1.12 vs edited =====
--- 1.12/drivers/i2c/i2c-elektor.c	Sun Dec 29 19:32:18 2002
+++ edited/drivers/i2c/i2c-elektor.c	Mon Dec 30 12:20:38 2002
@@ -142,7 +142,7 @@
 static int pcf_isa_init(void)
 {
 	if (!mmapped) {
-		if (!request_region(base, 2, "i2c (isa bus adapter)"))
+		if (!request_region(base, 2, "i2c (isa bus adapter)")) {
 			printk(KERN_ERR
 			       "i2c-elektor.o: requested I/O region (0x%X:2) "
 			       "is in use.\n", base);
@@ -159,32 +159,6 @@
 	return 0;
 }
 
-static int pcf_isa_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-
-static int pcf_isa_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void pcf_isa_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void pcf_isa_dec_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
@@ -201,13 +175,10 @@
 };
 
 static struct i2c_adapter pcf_isa_ops = {
+	.owner		   = THIS_MODULE,
 	.name		   = "PCF8584 ISA adapter",
 	.id		   = I2C_HW_P_ELEK,
 	.algo_data	   = &pcf_isa_data,
-	.inc_use	   = pcf_isa_inc_use,
-	.dec_use	   = pcf_isa_dec_use,
-	.client_register   = pcf_isa_reg,
-	.client_unregister = pcf_isa_unreg,
 };
 
 static int __init i2c_pcfisa_init(void) 
===== drivers/i2c/i2c-elv.c 1.8 vs edited =====
--- 1.8/drivers/i2c/i2c-elv.c	Sun Dec 29 19:33:51 2002
+++ edited/drivers/i2c/i2c-elv.c	Mon Dec 30 11:32:34 2002
@@ -115,30 +115,6 @@
 	return -ENODEV;
 }
 
-static int bit_elv_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int bit_elv_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void bit_elv_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void bit_elv_dec_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
@@ -153,14 +129,10 @@
 };
 
 static struct i2c_adapter bit_elv_ops = {
-	"ELV Parallel port adaptor",
-	I2C_HW_B_ELV,
-	NULL,
-	&bit_elv_data,
-	bit_elv_inc_use,
-	bit_elv_dec_use,
-	bit_elv_reg,
-	bit_elv_unreg,	
+	.owner		= THIS_MODULE,
+	.name		= "ELV Parallel port adaptor",
+	.id		= I2C_HW_B_ELV,
+	.algo_data	= &bit_elv_data,
 };
 
 static int __init i2c_bitelv_init(void)
===== drivers/i2c/i2c-frodo.c 1.4 vs edited =====
--- 1.4/drivers/i2c/i2c-frodo.c	Sun Dec 29 19:32:18 2002
+++ edited/drivers/i2c/i2c-frodo.c	Mon Dec 30 11:32:34 2002
@@ -61,44 +61,21 @@
 	.timeout	= 100
 };
 
-static int frodo_client_register (struct i2c_client *client)
-{
-	return (0);
-}
-
-static int frodo_client_unregister (struct i2c_client *client)
-{
-	return (0);
-}
-
-static void frodo_inc_use (struct i2c_adapter *adapter)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void frodo_dec_use (struct i2c_adapter *adapter)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static struct i2c_adapter frodo_ops = {
+	.owner			= THIS_MODULE,
 	.name			= "Frodo adapter driver",
 	.id			= I2C_HW_B_FRODO,
 	.algo_data		= &bit_frodo_data,
-	.inc_use		= frodo_inc_use,
-	.dec_use		= frodo_dec_use,
-	.client_register	= frodo_client_register,
-	.client_unregister	= frodo_client_unregister
 };
 
 static int __init i2c_frodo_init (void)
 {
-	return (i2c_bit_add_bus (&frodo_ops));
+	return i2c_bit_add_bus(&frodo_ops);
 }
 
 static void __exit i2c_frodo_exit (void)
 {
-	i2c_bit_del_bus (&frodo_ops);
+	i2c_bit_del_bus(&frodo_ops);
 }
 
 MODULE_AUTHOR ("Abraham van der Merwe <abraham@2d3d.co.za>");
===== drivers/i2c/i2c-philips-par.c 1.7 vs edited =====
--- 1.7/drivers/i2c/i2c-philips-par.c	Sun Dec 29 19:32:18 2002
+++ edited/drivers/i2c/i2c-philips-par.c	Mon Dec 30 11:32:34 2002
@@ -129,26 +129,6 @@
 			             PARPORT_STATUS_BUSY) ? 0 : 1;
 }
 
-static int bit_lp_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int bit_lp_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void bit_lp_inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void bit_lp_dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
@@ -173,15 +153,9 @@
 }; 
 
 static struct i2c_adapter bit_lp_ops = {
-	"Philips Parallel port adapter",
-	I2C_HW_B_LP,
-	NULL,
-	NULL,
-	bit_lp_inc_use,
-	bit_lp_dec_use,
-	bit_lp_reg,
-
-	bit_lp_unreg,
+	.owner		= THIS_MODULE,
+	.name		= "Philips Parallel port adapter",
+	.id		= I2C_HW_B_LP,
 };
 
 static void i2c_parport_attach (struct parport *port)
===== drivers/i2c/i2c-proc.c 1.10 vs edited =====
--- 1.10/drivers/i2c/i2c-proc.c	Sun Dec 29 19:32:18 2002
+++ edited/drivers/i2c/i2c-proc.c	Mon Dec 30 12:24:24 2002
@@ -210,49 +210,6 @@
 	}
 }
 
-/* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o 
-   impossible if some process still uses it or some file in it */
-void i2c_fill_inode(struct inode *inode, int fill)
-{
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-}
-
-/* Monitor access for /proc/sys/dev/sensors/ directories; make unloading
-   the corresponding module impossible if some process still uses it or
-   some file in it */
-void i2c_dir_fill_inode(struct inode *inode, int fill)
-{
-	int i;
-	struct i2c_client *client;
-
-#ifdef DEBUG
-	if (!inode) {
-		printk(KERN_ERR "i2c-proc.o: Warning: inode NULL in fill_inode()\n");
-		return;
-	}
-#endif				/* def DEBUG */
-
-	for (i = 0; i < SENSORS_ENTRY_MAX; i++)
-		if (i2c_clients[i]
-		    && (i2c_inodes[i] == inode->i_ino)) break;
-#ifdef DEBUG
-	if (i == SENSORS_ENTRY_MAX) {
-		printk
-		    (KERN_ERR "i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
-		     inode->i_ino);
-		return;
-	}
-#endif				/* def DEBUG */
-	client = i2c_clients[i];
-	if (fill)
-		client->driver->inc_use(client);
-	else
-		client->driver->dec_use(client);
-}
-
 int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
 		       void *buffer, size_t * lenp)
 {
===== drivers/i2c/i2c-rpx.c 1.3 vs edited =====
--- 1.3/drivers/i2c/i2c-rpx.c	Sun Dec 29 13:27:25 2002
+++ edited/drivers/i2c/i2c-rpx.c	Mon Dec 30 11:32:34 2002
@@ -66,44 +66,15 @@
 	return 0;
 }
 
-static int rpx_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int rpx_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void rpx_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void rpx_dec_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
 static struct i2c_algo_8xx_data rpx_data = {
 	.setisr = rpx_install_isr
 };
 
-
 static struct i2c_adapter rpx_ops = {
-	"m8xx",
-	I2C_HW_MPC8XX_EPON,
-	NULL,
-	&rpx_data,
-	rpx_inc_use,
-	rpx_dec_use,
-	rpx_reg,
-	rpx_unreg,
+	.owner		= THIS_MODULE,
+	.name		= "m8xx",
+	.id		= I2C_HW_MPC8XX_EPON,
+	.algo_data	= &rpx_data,
 };
 
 int __init i2c_rpx_init(void)
===== drivers/i2c/i2c-velleman.c 1.6 vs edited =====
--- 1.6/drivers/i2c/i2c-velleman.c	Sun Dec 29 14:46:32 2002
+++ edited/drivers/i2c/i2c-velleman.c	Mon Dec 30 12:19:28 2002
@@ -89,43 +89,15 @@
 
 static int bit_velle_init(void)
 {
-	if (check_region(base,(base == 0x3bc)? 3 : 8) < 0 ) {
-		DEBE(printk(KERN_DEBUG "i2c-velleman.o: Port %#x already in use.\n",
-		     base));
+	if (!request_region(base, (base == 0x3bc) ? 3 : 8, 
+			"i2c (Vellemann adapter)"))
 		return -ENODEV;
-	} else {
-		request_region(base, (base == 0x3bc)? 3 : 8, 
-			"i2c (Vellemann adapter)");
-		bit_velle_setsda((void*)base,1);
-		bit_velle_setscl((void*)base,1);
-	}
-	return 0;
-}
-
-static int bit_velle_reg(struct i2c_client *client)
-{
-	return 0;
-}
 
-static int bit_velle_unreg(struct i2c_client *client)
-{
+	bit_velle_setsda((void*)base,1);
+	bit_velle_setscl((void*)base,1);
 	return 0;
 }
 
-static void bit_velle_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void bit_velle_dec_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
@@ -141,14 +113,10 @@
 };
 
 static struct i2c_adapter bit_velle_ops = {
-	"Velleman K8000",
-	I2C_HW_B_VELLE,
-	NULL,
-	&bit_velle_data,
-	bit_velle_inc_use,
-	bit_velle_dec_use,
-	bit_velle_reg,
-	bit_velle_unreg,
+	.owner		= THIS_MODULE,
+	.name		= "Velleman K8000",
+	.id		= I2C_HW_B_VELLE,
+	.algo_data	= &bit_velle_data,
 };
 
 static int __init i2c_bitvelle_init(void)
===== drivers/i2c/scx200_acb.c 1.2 vs edited =====
--- 1.2/drivers/i2c/scx200_acb.c	Mon Nov 18 02:09:32 2002
+++ edited/drivers/i2c/scx200_acb.c	Mon Dec 30 11:32:34 2002
@@ -397,26 +397,6 @@
 	       I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-static int scx200_acb_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int scx200_acb_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void scx200_acb_inc_use(struct i2c_adapter *adapter)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void scx200_acb_dec_use(struct i2c_adapter *adapter)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 /* For now, we only handle combined mode (smbus) */
 static struct i2c_algorithm scx200_acb_algorithm = {
 	.name		= "NatSemi SCx200 ACCESS.bus",
@@ -479,12 +459,9 @@
 	adapter = &iface->adapter;
 	adapter->data = iface;
 	sprintf(adapter->name, "SCx200 ACB%d", index);
+	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_ALGO_SMBUS;
 	adapter->algo = &scx200_acb_algorithm;
-	adapter->inc_use = scx200_acb_inc_use;
-	adapter->dec_use = scx200_acb_dec_use;
-	adapter->client_register = scx200_acb_reg;
-	adapter->client_unregister = scx200_acb_unreg;
 
 	init_MUTEX(&iface->sem);
 
===== drivers/i2c/scx200_i2c.c 1.1 vs edited =====
--- 1.1/drivers/i2c/scx200_i2c.c	Sat Oct  5 13:35:20 2002
+++ edited/drivers/i2c/scx200_i2c.c	Mon Dec 30 11:32:34 2002
@@ -66,26 +66,6 @@
 	return scx200_gpio_get(sda);
 }
 
-static int scx200_i2c_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int scx200_i2c_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void scx200_i2c_inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void scx200_i2c_dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
@@ -101,13 +81,10 @@
 };
 
 static struct i2c_adapter scx200_i2c_ops = {
+	.owner		   = THIS_MODULE,
 	.name              = "NatSemi SCx200 I2C",
 	.id		   = I2C_HW_B_VELLE,
 	.algo_data	   = &scx200_i2c_data,
-	.inc_use	   = scx200_i2c_inc_use,
-	.dec_use	   = scx200_i2c_dec_use,
-	.client_register   = scx200_i2c_reg,
-	.client_unregister = scx200_i2c_unreg,
 };
 
 int scx200_i2c_init(void)
===== drivers/i2c/busses/i2c-amd756.c 1.2 vs edited =====
--- 1.2/drivers/i2c/busses/i2c-amd756.c	Sun Dec 29 15:11:50 2002
+++ edited/drivers/i2c/busses/i2c-amd756.c	Mon Dec 30 11:32:34 2002
@@ -296,17 +296,6 @@
 	return 0;
 }
 
-static void amd756_inc(struct i2c_adapter *adapter)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void amd756_dec(struct i2c_adapter *adapter)
-{
-
-	MOD_DEC_USE_COUNT;
-}
-
 static u32 amd756_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -322,11 +311,10 @@
 };
 
 static struct i2c_adapter amd756_adapter = {
+	.owner		= THIS_MODULE,
 	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
 	.algo		= &smbus_algorithm,
-	.inc_use	= amd756_inc,
-	.dec_use	= amd756_dec,
 };
 
 enum chiptype { AMD756, AMD766, AMD768, NFORCE };
===== drivers/i2c/busses/i2c-amd8111.c 1.1 vs edited =====
--- 1.1/drivers/i2c/busses/i2c-amd8111.c	Sun Dec  1 19:42:06 2002
+++ edited/drivers/i2c/busses/i2c-amd8111.c	Mon Dec 30 11:32:34 2002
@@ -320,16 +320,6 @@
 	return 0;
 }
 
-void amd8111_inc(struct i2c_adapter *adapter)
-{
-	MOD_INC_USE_COUNT;
-}
-
-void amd8111_dec(struct i2c_adapter *adapter)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 u32 amd8111_func(struct i2c_adapter *adapter)
 {
 	return	I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
@@ -368,12 +358,11 @@
 		return -1;
 	}
 
+	smbus->adapter.owner = THIS_MODULE;
 	sprintf(smbus->adapter.name, "SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
-	smbus->adapter.inc_use = amd8111_inc;
-	smbus->adapter.dec_use = amd8111_dec;
 
 	if (i2c_add_adapter(&smbus->adapter)) {
 		printk(KERN_WARNING "i2c-amd8111.c: Failed to register adapter.\n");
===== drivers/i2c/chips/adm1021.c 1.2 vs edited =====
--- 1.2/drivers/i2c/chips/adm1021.c	Sun Dec 29 15:13:58 2002
+++ edited/drivers/i2c/chips/adm1021.c	Mon Dec 30 11:32:34 2002
@@ -114,8 +114,6 @@
 static int adm1021_detach_client(struct i2c_client *client);
 static int adm1021_command(struct i2c_client *client, unsigned int cmd,
 			   void *arg);
-static void adm1021_inc_use(struct i2c_client *client);
-static void adm1021_dec_use(struct i2c_client *client);
 static int adm1021_read_value(struct i2c_client *client, u8 reg);
 static int adm1021_write_value(struct i2c_client *client, u8 reg,
 			       u16 value);
@@ -136,14 +134,13 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
-	/* name */ "ADM1021, MAX1617 sensor driver",
-	/* id */ I2C_DRIVERID_ADM1021,
-	/* flags */ I2C_DF_NOTIFY,
-	/* attach_adapter */ &adm1021_attach_adapter,
-	/* detach_client */ &adm1021_detach_client,
-	/* command */ &adm1021_command,
-	/* inc_use */ &adm1021_inc_use,
-	/* dec_use */ &adm1021_dec_use
+	.owner		= THIS_MODULE,
+	.name		= "ADM1021, MAX1617 sensor driver",
+	.id		= I2C_DRIVERID_ADM1021,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= adm1021_attach_adapter,
+	.detach_client	= adm1021_detach_client,
+	.command	= adm1021_command,
 };
 
 /* These files are created for each detected adm1021. This is just a template;
@@ -375,16 +372,6 @@
 	return 0;
 }
 
-void adm1021_inc_use(struct i2c_client *client)
-{
-	MOD_INC_USE_COUNT;
-}
-
-void adm1021_dec_use(struct i2c_client *client)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 /* All registers are byte-sized */
 int adm1021_read_value(struct i2c_client *client, u8 reg)
 {
@@ -478,8 +465,9 @@
 void adm1021_remote_temp(struct i2c_client *client, int operation,
 			 int ctl_name, int *nrels_mag, long *results)
 {
-int prec=0;
 	struct adm1021_data *data = client->data;
+	int prec = 0;
+
 	if (operation == SENSORS_PROC_REAL_INFO)
 		if (data->type == adm1023) { *nrels_mag = 3; }
                  else { *nrels_mag = 0; }
===== drivers/i2c/chips/lm75.c 1.2 vs edited =====
--- 1.2/drivers/i2c/chips/lm75.c	Sun Dec 29 15:14:30 2002
+++ edited/drivers/i2c/chips/lm75.c	Mon Dec 30 12:16:10 2002
@@ -72,8 +72,6 @@
 static int lm75_detach_client(struct i2c_client *client);
 static int lm75_command(struct i2c_client *client, unsigned int cmd,
 			void *arg);
-static void lm75_inc_use(struct i2c_client *client);
-static void lm75_dec_use(struct i2c_client *client);
 static u16 swap_bytes(u16 val);
 static int lm75_read_value(struct i2c_client *client, u8 reg);
 static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
@@ -84,14 +82,12 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver lm75_driver = {
-	/* name */ "LM75 sensor chip driver",
-	/* id */ I2C_DRIVERID_LM75,
-	/* flags */ I2C_DF_NOTIFY,
-	/* attach_adapter */ &lm75_attach_adapter,
-	/* detach_client */ &lm75_detach_client,
-	/* command */ &lm75_command,
-	/* inc_use */ &lm75_inc_use,
-	/* dec_use */ &lm75_dec_use
+	.name		= "LM75 sensor chip driver",
+	.id		= I2C_DRIVERID_LM75,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= lm75_attach_adapter,
+	.detach_client	= lm75_detach_client,
+	.command	= lm75_command,
 };
 
 /* These files are created for each detected LM75. This is just a template;
@@ -221,40 +217,17 @@
 
 int lm75_detach_client(struct i2c_client *client)
 {
-	int err;
-
-#ifdef MODULE
-	if (MOD_IN_USE)
-		return -EBUSY;
-#endif
-
-	i2c_deregister_entry(((struct lm75_data *) (client->data))->
-				 sysctl_id);
-
-	if ((err = i2c_detach_client(client))) {
-		printk
-		    ("lm75.o: Client deregistration failed, client not detached.\n");
-		return err;
-	}
+	struct lm75_data *data = client->data;
 
+	i2c_deregister_entry(data->sysctl_id);
+	i2c_detach_client(client);
 	kfree(client);
-
 	return 0;
 }
 
 int lm75_command(struct i2c_client *client, unsigned int cmd, void *arg)
 {
 	return 0;
-}
-
-void lm75_inc_use(struct i2c_client *client)
-{
-	MOD_INC_USE_COUNT;
-}
-
-void lm75_dec_use(struct i2c_client *client)
-{
-	MOD_DEC_USE_COUNT;
 }
 
 u16 swap_bytes(u16 val)
===== drivers/media/video/adv7175.c 1.7 vs edited =====
--- 1.7/drivers/media/video/adv7175.c	Fri Nov 29 11:30:43 2002
+++ edited/drivers/media/video/adv7175.c	Mon Dec 30 11:32:34 2002
@@ -396,39 +396,26 @@
 	return 0;
 }
 
-static void adv717x_inc_use(struct i2c_client *client)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void adv717x_dec_use(struct i2c_client *client)
-{
-	MOD_DEC_USE_COUNT;
-}
-
-
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver i2c_driver_adv7175 = {
+	.owner		= THIS_MODULE,
 	.name		= "adv7175",		/* name */
 	.id		= I2C_DRIVERID_ADV717x,	/* ID */
 	.flags		= I2C_DF_NOTIFY, //I2C_ADV7175, I2C_ADV7175 + 3,
 	.attach_adapter	= adv717x_probe,
 	.detach_client	= adv717x_detach,
 	.command	= adv717x_command,
-	.inc_use	= &adv717x_inc_use,
-	.dec_use	= &adv717x_dec_use
 };
 
 static struct i2c_driver i2c_driver_adv7176 = {
+	.owner		= THIS_MODULE,
 	.name		= "adv7176",		/* name */
 	.id		= I2C_DRIVERID_ADV717x,	/* ID */
 	.flags		= I2C_DF_NOTIFY, //I2C_ADV7176, I2C_ADV7176 + 3,
 	.attach_adapter	= adv717x_probe,
 	.detach_client	= adv717x_detach,
 	.command	= adv717x_command,
-	.inc_use	= &adv717x_inc_use,
-	.dec_use	= &adv717x_dec_use
 };
 
 static struct i2c_client client_template = {
===== drivers/media/video/bttv-if.c 1.6 vs edited =====
--- 1.6/drivers/media/video/bttv-if.c	Fri Nov 29 11:30:38 2002
+++ edited/drivers/media/video/bttv-if.c	Mon Dec 30 11:32:34 2002
@@ -194,16 +194,6 @@
 	return state;
 }
 
-static void bttv_inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void bttv_dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static int attach_inform(struct i2c_client *client)
 {
         struct bttv *btv = (struct bttv*)client->adapter->data;
@@ -272,10 +262,9 @@
 };
 
 static struct i2c_adapter bttv_i2c_adap_template = {
+	.owner		   = THIS_MODULE,
 	.name              = "bt848",
 	.id                = I2C_HW_B_BT848,
-	.inc_use           = bttv_inc_use,
-	.dec_use           = bttv_dec_use,
 	.client_register   = attach_inform,
 	.client_unregister = detach_inform,
 };
===== drivers/media/video/tvmixer.c 1.9 vs edited =====
--- 1.9/drivers/media/video/tvmixer.c	Sat Nov 30 12:27:46 2002
+++ edited/drivers/media/video/tvmixer.c	Mon Dec 30 11:32:34 2002
@@ -195,8 +195,9 @@
 
 	/* lock bttv in memory while the mixer is in use  */
 	file->private_data = mix;
-	if (client->adapter->inc_use)
-		client->adapter->inc_use(client->adapter);
+
+	if (!try_module_get(client->adapter->owner))
+		return -ENODEV;
         return 0;
 }
 
@@ -210,8 +211,7 @@
 		return -ENODEV;
 	}
 
-	if (client->adapter->dec_use)
-		client->adapter->dec_use(client->adapter);
+	module_put(client->adapter->owner);
 	return 0;
 }
 
===== drivers/media/video/saa7134/saa7134-i2c.c 1.2 vs edited =====
--- 1.2/drivers/media/video/saa7134/saa7134-i2c.c	Thu Dec  5 21:56:40 2002
+++ edited/drivers/media/video/saa7134/saa7134-i2c.c	Mon Dec 30 11:32:34 2002
@@ -318,16 +318,6 @@
 	return I2C_FUNC_SMBUS_EMUL;
 }
 
-static void inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static int attach_inform(struct i2c_client *client)
 {
         struct saa7134_dev *dev = client->adapter->algo_data;
@@ -346,11 +336,10 @@
 };
 
 static struct i2c_adapter saa7134_adap_template = {
+	.owner         = THIS_MODULE,
 	.name	       = "saa7134",
 	.id            = I2C_ALGO_SAA7134,
 	.algo          = &saa7134_algo,
-	.inc_use       = inc_use,
-	.dec_use       = dec_use,
 	.client_register = attach_inform,
 };
 
--- 1.5/drivers/video/matrox/i2c-matroxfb.c	Thu Oct 31 15:05:53 2002
+++ edited/drivers/video/matrox/i2c-matroxfb.c	Mon Dec 30 11:32:35 2002
@@ -87,19 +87,10 @@
 	return (matroxfb_read_gpio(b->minfo) & b->mask.clock) ? 1 : 0;
 }
 
-static void matroxfb_dh_inc_use(struct i2c_adapter* dummy) {
-	MOD_INC_USE_COUNT;
-}
-
-static void matroxfb_dh_dec_use(struct i2c_adapter* dummy) {
-	MOD_DEC_USE_COUNT;
-}
-
 static struct i2c_adapter matrox_i2c_adapter_template =
 {
+	.owner =	THIS_MODULE,
 	.id =		I2C_HW_B_G400,
-	.inc_use =	matroxfb_dh_inc_use,
-	.dec_use =	matroxfb_dh_dec_use,
 };
 
 static struct i2c_algo_bit_data matrox_i2c_algo_template =
===== drivers/video/matrox/matroxfb_maven.c 1.11 vs edited =====
--- 1.11/drivers/video/matrox/matroxfb_maven.c	Wed Aug 14 10:37:20 2002
+++ edited/drivers/video/matrox/matroxfb_maven.c	Mon Dec 30 11:37:03 2002
@@ -945,14 +945,6 @@
 static unsigned short normal_i2c_range[] = { MAVEN_I2CID, MAVEN_I2CID, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
-static void maven_inc_use(struct i2c_client* clnt) {
-	MOD_INC_USE_COUNT;
-}
-
-static void maven_dec_use(struct i2c_client* clnt) {
-	MOD_DEC_USE_COUNT;
-}
-
 static struct i2c_driver maven_driver;
 
 static int maven_detect_client(struct i2c_adapter* adapter, int address, unsigned short flags,
@@ -1016,17 +1008,13 @@
 	return -ENOIOCTLCMD;	/* or -EINVAL, depends on who will call this */
 }
 
-static int maven_driver_registered = 0;
-
 static struct i2c_driver maven_driver={
-	"maven",
-	I2C_DRIVERID_MGATVO,
-	I2C_DF_NOTIFY,
-	maven_attach_adapter,
-	maven_detach_client,
-	maven_command,
-	maven_inc_use,
-	maven_dec_use
+	.owner		= THIS_MODULE,
+	.name		= "maven",
+	.id		= I2C_DRIVERID_MGATVO,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= maven_attach_adapter,
+	.detach_client	= maven_detach_client,
 };
 
 /* ************************** */
@@ -1039,13 +1027,11 @@
 		printk(KERN_ERR "maven: Maven driver failed to register (%d).\n", err);
 		return err;
 	}
-	maven_driver_registered = 1;
 	return 0;
 }
 
 static void matroxfb_maven_exit(void) {
-	if (maven_driver_registered)
-		i2c_del_driver(&maven_driver);
+	i2c_del_driver(&maven_driver);
 }
 
 MODULE_AUTHOR("(c) 1999-2002 Petr Vandrovec <vandrove@vc.cvut.cz>");
===== include/linux/i2c.h 1.7 vs edited =====
--- 1.7/include/linux/i2c.h	Mon Dec  2 18:15:07 2002
+++ edited/include/linux/i2c.h	Mon Dec 30 11:32:35 2002
@@ -132,6 +132,7 @@
  */
 
 struct i2c_driver {
+	struct module *owner;
 	char name[32];
 	int id;
 	unsigned int flags;		/* div., see below		*/
@@ -155,18 +156,6 @@
 	 * with the device.
 	 */
 	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
-	
-	/* These two are mainly used for bookkeeping & dynamic unloading of 
-	 * kernel modules. inc_use tells the driver that a client is being  
-	 * used by another module & that it should increase its ref. counter.
-	 * dec_use is the inverse operation.
-	 * NB: Make sure you have no circular dependencies, or else you get a 
-	 * deadlock when trying to unload the modules.
-	* You should use the i2c_{inc,dec}_use_client functions instead of
-	* calling this function directly.
-	 */
-	void (*inc_use)(struct i2c_client *client);
-	void (*dec_use)(struct i2c_client *client);
 };
 
 /*
@@ -232,16 +221,13 @@
  * with the access algorithms necessary to access it.
  */
 struct i2c_adapter {
+	struct module *owner;
 	char name[32];	/* some useful name to identify the adapter	*/
 	unsigned int id;/* == is algo->id | hwdep.struct->id, 		*/
 			/* for registered values see below		*/
 	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/
 	void *algo_data;
 
-	/* --- These may be NULL, but should increase the module use count */
-	void (*inc_use)(struct i2c_adapter *);
-	void (*dec_use)(struct i2c_adapter *);
-
 	/* --- administration stuff. */
 	int (*client_register)(struct i2c_client *);
 	int (*client_unregister)(struct i2c_client *);
@@ -318,12 +304,6 @@
 
 extern int i2c_attach_client(struct i2c_client *);
 extern int i2c_detach_client(struct i2c_client *);
-
-/* Only call these if you grab a resource that makes unloading the
-   client and the adapter it is on completely impossible. Like when a
-   /proc directory is entered. */
-extern void i2c_inc_use_client(struct i2c_client *);
-extern void i2c_dec_use_client(struct i2c_client *);
 
 /* New function: This is to get an i2c_client-struct for controlling the 
    client either by using i2c_control-function or having the 
