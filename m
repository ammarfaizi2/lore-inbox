Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268836AbUIQOgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbUIQOgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 10:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUIQOgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 10:36:11 -0400
Received: from mail.convergence.de ([212.227.36.84]:38303 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S268799AbUIQO11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 10:27:27 -0400
Message-ID: <414AF41A.6060009@linuxtv.org>
Date: Fri, 17 Sep 2004 16:26:34 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6][3/14] dvb-bt8xx and skystar2 driver update
References: <414AF2CA.3000502@linuxtv.org> <414AF31B.1090103@linuxtv.org> <414AF399.3030708@linuxtv.org>
In-Reply-To: <414AF399.3030708@linuxtv.org>
Content-Type: multipart/mixed;
 boundary="------------050407020108020404090302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050407020108020404090302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050407020108020404090302
Content-Type: text/plain;
 name="03-DVB-skystar2-dvb-bt8xx-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-DVB-skystar2-dvb-bt8xx-update.diff"

- [DVB] convert drivers from dvb-i2c to kernel-i2c
- [DVB] convert MODULE_PARM() to module_param()
- [DVB] convert dvb_delay() to mdelay()
- [DVB] dvb-bt8xx: convert home-brewn bttv i2c access to a real bttv sub-driver

Signed-off-by: Michael Hunold <hunold@linuxtv.org>

diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/b2c2/skystar2.c linux-2.6.8.1-patched/drivers/media/dvb/b2c2/skystar2.c
--- xx-linux-2.6.8.1/drivers/media/dvb/b2c2/skystar2.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/b2c2/skystar2.c	2004-08-23 16:49:55.000000000 +0200
@@ -30,14 +30,16 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
+
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/version.h>
 
 #include <asm/io.h>
 
-#include "dvb_i2c.h"
 #include "dvb_frontend.h"
 
 #include <linux/dvb/frontend.h>
@@ -49,12 +51,17 @@
 #include "demux.h"
 #include "dvb_net.h"
 
-#include "dvb_functions.h"
 
-static int debug = 0;
+static int debug;
+static int enable_hw_filters = 2;
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Set debugging level (0 = default, 1 = most messages, 2 = all messages).");
+module_param(enable_hw_filters, int, 0444);
+MODULE_PARM_DESC(enable_hw_filters, "enable hardware filters: supported values: 0 (none), 1, 2");
+
 #define dprintk(x...)	do { if (debug>=1) printk(x); } while (0)
 #define ddprintk(x...)	do { if (debug>=2) printk(x); } while (0)
-static int enable_hw_filters = 2;
 
 #define SIZE_OF_BUF_DMA1	0x3ac00
 #define SIZE_OF_BUF_DMA2	0x758
@@ -89,7 +96,7 @@
 	struct dmxdev dmxdev;
 	struct dmx_frontend hw_frontend;
 	struct dmx_frontend mem_frontend;
-	struct dvb_i2c_bus *i2c_bus;
+	struct i2c_adapter i2c_adap;	
 	struct dvb_net dvbnet;
 
 	struct semaphore i2c_sem;
@@ -277,9 +284,9 @@
 	return buf - start;
 }
 
-static int master_xfer(struct dvb_i2c_bus *i2c, const struct i2c_msg *msgs, int num)
+static int master_xfer(struct i2c_adapter* adapter, struct i2c_msg msgs[], int num)
 {
-	struct adapter *tmp = i2c->data;
+	struct adapter *tmp = i2c_get_adapdata(adapter);
 	int i, ret = 0;
 
 	if (down_interruptible(&tmp->i2c_sem))
@@ -291,10 +298,10 @@
 		ddprintk("message %d: flags=0x%x, addr=0x%x, buf=0x%x, len=%d \n", i,
 			 msgs[i].flags, msgs[i].addr, msgs[i].buf[0], msgs[i].len);
 	
-		/* allow only the mt312 and stv0299 frontends to access the bus */
-		if ((msgs[i].addr != 0x0e) && (msgs[i].addr != 0x68) && (msgs[i].addr != 0x61)) {
+		/* allow only the mt312, mt352 and stv0299 frontends to access the bus */
+		if ((msgs[i].addr != 0x0e) && (msgs[i].addr != 0x68) &&
+		    (msgs[i].addr != 0x61) && (msgs[i].addr != 0x0f)) {
 		up(&tmp->i2c_sem);
-
 		return -EREMOTEIO;
 	}
 	}
@@ -2122,7 +2128,7 @@
 			udelay(12500);
 			set_tuner_tone(adapter, 0);
 		}
-		dvb_delay(20);
+		msleep(20);
 	}
 
 	return 0;
@@ -2228,6 +2235,44 @@
 	return 0;
 }
 
+
+int client_register(struct i2c_client *client)
+{
+	struct adapter *adapter = (struct adapter*)i2c_get_adapdata(client->adapter);
+
+	dprintk("client_register\n");
+
+	if (client->driver->command)
+		return client->driver->command(client, FE_REGISTER, adapter->dvb_adapter);
+	return 0;
+}
+
+int client_unregister(struct i2c_client *client)
+{
+	struct adapter *adapter = (struct adapter*)i2c_get_adapdata(client->adapter);
+
+	dprintk("client_unregister\n");
+
+	if (client->driver->command)
+		return client->driver->command(client, FE_UNREGISTER, adapter->dvb_adapter);
+	return 0;
+}
+
+u32 flexcop_i2c_func(struct i2c_adapter *adapter)
+{
+	printk("flexcop_i2c_func\n");
+
+	return I2C_FUNC_I2C;
+}
+
+static struct i2c_algorithm    flexcop_algo = {
+	.name		= "flexcop i2c algorithm",
+	.id		= I2C_ALGO_BIT,
+	.master_xfer	= master_xfer,
+	.functionality	= flexcop_i2c_func,
+};
+
+
 static int skystar2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct adapter *adapter;
@@ -2258,10 +2303,27 @@
 
 	init_MUTEX(&adapter->i2c_sem);
 
-	adapter->i2c_bus = dvb_register_i2c_bus(master_xfer, adapter, adapter->dvb_adapter, 0);
 
-	if (!adapter->i2c_bus)
+	memset(&adapter->i2c_adap, 0, sizeof(struct i2c_adapter));
+	strcpy(adapter->i2c_adap.name, "Technisat SkyStar2 driver");
+
+	i2c_set_adapdata(&adapter->i2c_adap, adapter);
+
+#ifdef I2C_ADAP_CLASS_TV_DIGITAL
+	adapter->i2c_adap.class 	    = I2C_ADAP_CLASS_TV_DIGITAL;
+#else
+	adapter->i2c_adap.class 	    = I2C_CLASS_TV_DIGITAL;
+#endif
+	adapter->i2c_adap.algo              = &flexcop_algo;
+	adapter->i2c_adap.algo_data         = NULL;
+	adapter->i2c_adap.id                = I2C_ALGO_BIT;
+	adapter->i2c_adap.client_register   = client_register;
+	adapter->i2c_adap.client_unregister = client_unregister;
+
+	if (i2c_add_adapter(&adapter->i2c_adap) < 0) {
+		dvb_unregister_adapter (adapter->dvb_adapter);
 		return -ENOMEM;
+	}
 
 	dvb_add_frontend_ioctls(adapter->dvb_adapter, flexcop_diseqc_ioctl, NULL, adapter);
 
@@ -2327,8 +2389,7 @@
 		if (adapter->dvb_adapter != NULL) {
 			dvb_remove_frontend_ioctls(adapter->dvb_adapter, flexcop_diseqc_ioctl, NULL);
 
-			if (adapter->i2c_bus != NULL)
-				dvb_unregister_i2c_bus(master_xfer, adapter->i2c_bus->adapter, adapter->i2c_bus->id);
+			i2c_del_adapter(&adapter->i2c_adap);
 
 			dvb_unregister_adapter(adapter->dvb_adapter);
 		}
@@ -2364,10 +2425,5 @@
 module_init(skystar2_init);
 module_exit(skystar2_cleanup);
 
-MODULE_PARM(debug, "i");
-MODULE_PARM_DESC(debug, "enable verbose debug messages: supported values: 1 and 2");
-MODULE_PARM(enable_hw_filters, "i");
-MODULE_PARM_DESC(enable_hw_filters, "enable hardware filters: supported values: 0 (none), 1, 2");
-
 MODULE_DESCRIPTION("Technisat SkyStar2 DVB PCI Driver");
 MODULE_LICENSE("GPL");
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/bt878.c linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/bt878.c
--- xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/bt878.c	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/bt878.c	2004-08-18 19:52:17.000000000 +0200
@@ -27,8 +27,8 @@
  * 
  */
 
-#include <linux/version.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <asm/io.h>
@@ -46,20 +46,19 @@
 #include "bt878.h"
 #include "dst-bt878.h"
 
-#include "dvb_functions.h"
 
 /**************************************/
 /* Miscellaneous utility  definitions */
 /**************************************/
 
-unsigned int bt878_verbose = 1;
-unsigned int bt878_debug = 0;
-MODULE_PARM(bt878_verbose, "i");
+static unsigned int bt878_verbose = 1;
+static unsigned int bt878_debug;
+
+module_param_named(verbose, bt878_verbose, int, 0444);
 MODULE_PARM_DESC(bt878_verbose,
 		 "verbose startup messages, default is 1 (yes)");
-MODULE_PARM(bt878_debug, "i");
-MODULE_PARM_DESC(bt878_debug, "debug messages, default is 0 (no)");
-MODULE_LICENSE("GPL");
+module_param_named(debug, bt878_debug, int, 0644);
+MODULE_PARM_DESC(bt878_debug, "Turn on/off debugging (default:off).");
 
 int bt878_num;
 struct bt878 bt878[BT878_MAX];
@@ -339,10 +338,6 @@
 	return IRQ_HANDLED;
 }
 
-extern int bttv_gpio_enable(unsigned int card, unsigned long mask, unsigned long data);
-extern int bttv_read_gpio(unsigned int card, unsigned long *data);
-extern int bttv_write_gpio(unsigned int card, unsigned long mask, unsigned long data);
-
 int
 bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp)
 {
@@ -386,20 +381,20 @@
 
 EXPORT_SYMBOL(bt878_device_control);
 
-struct bt878 *bt878_find_by_dvb_adap(struct dvb_adapter *adap)
+struct bt878 *bt878_find_by_i2c_adap(struct i2c_adapter *adapter)
 {
 	unsigned int card_nr;
 	
-	printk("bt878 find by dvb adap: checking \"%s\"\n",adap->name);
+	printk("bt878 find by dvb adap: checking \"%s\"\n",adapter->name);
 	for (card_nr = 0; card_nr < bt878_num; card_nr++) {
-		if (bt878[card_nr].adap_ptr == adap)
+		if (bt878[card_nr].adapter == adapter)
 			return &bt878[card_nr];
 	}
-	printk("bt878 find by dvb adap: NOT found \"%s\"\n",adap->name);
+	printk("bt878 find by dvb adap: NOT found \"%s\"\n",adapter->name);
 	return NULL;
 }
 
-EXPORT_SYMBOL(bt878_find_by_dvb_adap);
+EXPORT_SYMBOL(bt878_find_by_i2c_adap);
 
 /***********************/
 /* PCI device handling */
@@ -607,6 +602,9 @@
 module_init(bt878_init_module);
 module_exit(bt878_cleanup_module);
 
+
+MODULE_LICENSE("GPL");
+
 /*
  * Local variables:
  * c-basic-offset: 8
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/bt878.h linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/bt878.h
--- xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/bt878.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/bt878.h	2004-08-18 16:44:48.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/sched.h>
 #include <linux/spinlock.h>
 #include "bt848.h"
+#include "bttv.h"
 
 #define BT878_VERSION_CODE 0x000000
 
@@ -94,7 +95,7 @@
 	struct semaphore  gpio_lock;
 	unsigned int nr;
 	unsigned int bttv_nr;
-	struct dvb_adapter *adap_ptr;
+	struct i2c_adapter *adapter;
 	struct pci_dev *dev;
 	unsigned int id;
 	unsigned int TS_Size;
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/dvb-bt8xx.c linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.c
--- xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-08-23 09:34:58.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2004-08-18 19:52:17.000000000 +0200
@@ -21,7 +21,9 @@
 
 #include <asm/bitops.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/init.h>
+#include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
@@ -33,33 +35,32 @@
 
 #include "dvb-bt8xx.h"
 
-#include "dvb_functions.h"
-
 #include "bt878.h"
 
-/* ID THAT MUST GO INTO i2c ids */
-#ifndef  I2C_DRIVERID_DVB_BT878A
-# define I2C_DRIVERID_DVB_BT878A I2C_DRIVERID_EXP0+10
-#endif
-
-
-#define dprintk if (debug) printk
+static int debug;
 
-extern int bttv_get_cardinfo(unsigned int card, int *type, int *cardid);
-extern struct pci_dev* bttv_get_pcidev(unsigned int card);
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off debugging (default:off).");
 
-static LIST_HEAD(card_list);
-static int debug = 0;
+#define dprintk( args... ) \
+	do { \
+		if (debug) printk(KERN_DEBUG args); \
+	} while (0)
 
 static void dvb_bt8xx_task(unsigned long data)
 {
 	struct dvb_bt8xx_card *card = (struct dvb_bt8xx_card *)data;
 
-	//printk("%d ", finished_block);
+	//printk("%d ", card->bt->finished_block);
 
 	while (card->bt->last_block != card->bt->finished_block) {
-		(card->bt->TS_Size ? dvb_dmx_swfilter_204 : dvb_dmx_swfilter)(&card->demux, &card->bt->buf_cpu[card->bt->last_block * card->bt->block_bytes], card->bt->block_bytes);
-		card->bt->last_block = (card->bt->last_block + 1) % card->bt->block_count;
+		(card->bt->TS_Size ? dvb_dmx_swfilter_204 : dvb_dmx_swfilter)
+			(&card->demux,
+			 &card->bt->buf_cpu[card->bt->last_block *
+					    card->bt->block_bytes],
+			 card->bt->block_bytes);
+		card->bt->last_block = (card->bt->last_block + 1) %
+					card->bt->block_count;
 	}
 }
 
@@ -103,23 +104,6 @@
 	return 0;
 }
 
-static int master_xfer (struct dvb_i2c_bus *i2c, const struct i2c_msg msgs[], int num)
-{
-	struct dvb_bt8xx_card *card = i2c->data;
-	int retval;
-
-	if (down_interruptible (&card->bt->gpio_lock))
-		return -ERESTARTSYS;
-
-	retval = i2c_transfer(card->i2c_adapter,
-			      (struct i2c_msg*) msgs,
-			      num);
-
-	up(&card->bt->gpio_lock);
-
-	return retval;
-}
-
 static int is_pci_slot_eq(struct pci_dev* adev, struct pci_dev* bdev)
 {
 	if ((adev->subsystem_vendor == bdev->subsystem_vendor) &&
@@ -142,168 +126,18 @@
 	return NULL;
 }
 
-static int __init dvb_bt8xx_card_match(unsigned int bttv_nr, char *card_name, u32 gpio_mode, u32 op_sync_orin, u32 irq_err_ignore)
-{
-	struct dvb_bt8xx_card *card;
-	struct pci_dev* bttv_pci_dev;
-
-	dprintk("dvb_bt8xx: identified card%d as %s\n", bttv_nr, card_name);
-			
-	if (!(card = kmalloc(sizeof(struct dvb_bt8xx_card), GFP_KERNEL)))
-		return -ENOMEM;
-
-	memset(card, 0, sizeof(*card));
-	card->bttv_nr = bttv_nr;
-	strncpy(card->card_name, card_name, sizeof(card_name) - 1);
-	
-	if (!(bttv_pci_dev = bttv_get_pcidev(bttv_nr))) {
-		printk("dvb_bt8xx: no pci device for card %d\n", card->bttv_nr);
-		kfree(card);
-		return -EFAULT;
-	}
-
-	if (!(card->bt = dvb_bt8xx_878_match(card->bttv_nr, bttv_pci_dev))) {
-		printk("dvb_bt8xx: unable to determine DMA core of card %d\n", card->bttv_nr);
-	
-		kfree(card);
-		return -EFAULT;
-		
-	}
-	init_MUTEX(&card->bt->gpio_lock);
-	card->bt->bttv_nr = bttv_nr;
-	card->gpio_mode = gpio_mode;
-	card->op_sync_orin = op_sync_orin;
-	card->irq_err_ignore = irq_err_ignore;
-	list_add_tail(&card->list, &card_list);
-
-	return 0;
-}
-
-static struct dvb_bt8xx_card *dvb_bt8xx_find_by_i2c_adap(struct i2c_adapter *adap)
-{
-	struct dvb_bt8xx_card *card;
-	struct list_head *item;
-	
-	printk("find by i2c adap: checking \"%s\"\n",adap->name);
-	list_for_each(item, &card_list) {
-		card = list_entry(item, struct dvb_bt8xx_card, list);
-		if (card->i2c_adapter == adap)
-			return card;
-	}
-	return NULL;
-}
-
-static struct dvb_bt8xx_card *dvb_bt8xx_find_by_pci(struct i2c_adapter *adap)
-{
-	struct dvb_bt8xx_card *card;
-	struct list_head *item;
-	struct device  *dev;
-	struct pci_dev *pci;
-	
-	printk("find by pci: checking \"%s\"\n",adap->name);
-	dev = adap->dev.parent;
-	if (NULL == dev) {
-		/* shoudn't happen with 2.6.0-test7 + newer */
-		printk("attach: Huh? i2c adapter not in sysfs tree?\n");
-		return NULL;
-	}
-	pci = to_pci_dev(dev);
-	list_for_each(item, &card_list) {
-		card = list_entry(item, struct dvb_bt8xx_card, list);
-		if (is_pci_slot_eq(pci, card->bt->dev)) {
-			return card;
-		}
-	}
-	return NULL;
-}
-
-static int dvb_bt8xx_attach(struct i2c_adapter *adap)
-{
-	struct dvb_bt8xx_card *card;
-	
-	printk("attach: checking \"%s\"\n",adap->name);
-
-	/* looking for bt878 cards ... */
-	if (adap->id != (I2C_ALGO_BIT | I2C_HW_B_BT848))
-		return 0;
-	card = dvb_bt8xx_find_by_pci(adap);
-	if (!card)
-		return 0;
-	card->i2c_adapter = adap;
-	printk("attach: \"%s\", to card %d\n",
-	       adap->name, card->bttv_nr);
-	try_module_get(adap->owner);
-
-	return 0;
-}
-
-static void dvb_bt8xx_i2c_adap_free(struct i2c_adapter *adap)
-{
-	module_put(adap->owner);
-}
-
-static int dvb_bt8xx_detach(struct i2c_adapter *adap)
-{
-	struct dvb_bt8xx_card *card;
-
-	card = dvb_bt8xx_find_by_i2c_adap(adap);
-	if (!card)
-		return 0;
-
-	/* This should not happen. We have locked the module! */
-	printk("detach: \"%s\", for card %d removed\n",
-	       adap->name, card->bttv_nr);
-	return 0;
-}
-
-static struct i2c_driver dvb_bt8xx_driver = {
-	.owner           = THIS_MODULE,
-	.name            = "dvb_bt8xx",
-        .id              = I2C_DRIVERID_DVB_BT878A,
-	.flags           = I2C_DF_NOTIFY,
-        .attach_adapter  = dvb_bt8xx_attach,
-        .detach_adapter  = dvb_bt8xx_detach,
-};
-
-static void __init dvb_bt8xx_get_adaps(void)
-{
-	i2c_add_driver(&dvb_bt8xx_driver);
-}
-
-static void __exit dvb_bt8xx_exit_adaps(void)
-{
-	i2c_del_driver(&dvb_bt8xx_driver);
-}
-
 static int __init dvb_bt8xx_load_card( struct dvb_bt8xx_card *card)
 {
 	int result;
 
-	if (!card->i2c_adapter) {
-		printk("dvb_bt8xx: unable to determine i2c adaptor of card %d, deleting\n", card->bttv_nr);
-
-		return -EFAULT;
-	
-	}
-
-	if ((result = dvb_register_adapter(&card->dvb_adapter, card->card_name, THIS_MODULE)) < 0) {
-	
+	if ((result = dvb_register_adapter(&card->dvb_adapter, card->card_name,
+					   THIS_MODULE)) < 0) {
 		printk("dvb_bt8xx: dvb_register_adapter failed (errno = %d)\n", result);
-		
-		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
 		return result;
 		
 	}
-	card->bt->adap_ptr = card->dvb_adapter;
 
-	if (!(dvb_register_i2c_bus(master_xfer, card, card->dvb_adapter, 0))) {
-		printk("dvb_bt8xx: dvb_register_i2c_bus of card%d failed\n", card->bttv_nr);
-
-		dvb_unregister_adapter(card->dvb_adapter);
-		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
-
-		return -EFAULT;
-	}
+	card->bt->adapter = card->i2c_adapter;
 
 	memset(&card->demux, 0, sizeof(struct dvb_demux));
 
@@ -319,10 +153,7 @@
 	if ((result = dvb_dmx_init(&card->demux)) < 0) {
 		printk("dvb_bt8xx: dvb_dmx_init failed (errno = %d)\n", result);
 
-		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
 		dvb_unregister_adapter(card->dvb_adapter);
-		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
-		
 		return result;
 	}
 
@@ -334,10 +165,7 @@
 		printk("dvb_bt8xx: dvb_dmxdev_init failed (errno = %d)\n", result);
 
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
 		dvb_unregister_adapter(card->dvb_adapter);
-		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
-		
 		return result;
 	}
 
@@ -348,10 +176,7 @@
 
 		dvb_dmxdev_release(&card->dmxdev);
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
 		dvb_unregister_adapter(card->dvb_adapter);
-		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
-		
 		return result;
 	}
 	
@@ -363,10 +188,7 @@
 		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
 		dvb_dmxdev_release(&card->dmxdev);
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
 		dvb_unregister_adapter(card->dvb_adapter);
-		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
-		
 		return result;
 	}
 
@@ -377,10 +199,7 @@
 		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
 		dvb_dmxdev_release(&card->dmxdev);
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
 		dvb_unregister_adapter(card->dvb_adapter);
-		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
-		
 		return result;
 	}
 
@@ -393,67 +212,52 @@
 	return 0;
 }
 
-static int __init dvb_bt8xx_load_all(void)
+static int dvb_bt8xx_probe(struct device *dev)
 {
+	struct bttv_sub_device *sub = to_bttv_sub_dev(dev);
 	struct dvb_bt8xx_card *card;
-	struct list_head *entry, *entry_safe;
-
-	list_for_each_safe(entry, entry_safe, &card_list) {
-		card = list_entry(entry, struct dvb_bt8xx_card, list);
-		if (dvb_bt8xx_load_card(card) < 0) {
-			list_del(&card->list);
-			kfree(card);
-			continue;
-		}
-	}
-	return 0;
-
-}
+	struct pci_dev* bttv_pci_dev;
+	int ret;
 
-#define BT878_NEBULA	0x68
-#define BT878_TWINHAN_DST 0x71
+	if (!(card = kmalloc(sizeof(struct dvb_bt8xx_card), GFP_KERNEL)))
+		return -ENOMEM;
 
-static int __init dvb_bt8xx_init(void)
-{
-	unsigned int card_nr = 0;
-	int card_id;
-	int card_type;
-
-	dprintk("dvb_bt8xx: enumerating available bttv cards...\n");
-	
-	while (bttv_get_cardinfo(card_nr, &card_type, &card_id) == 0) {
-		switch(card_id) {
-			case 0x001C11BD:
-				dvb_bt8xx_card_match(card_nr, "Pinnacle PCTV DVB-S",
-					       0x0400C060, 0, 0);
+	memset(card, 0, sizeof(*card));
+	card->bttv_nr = sub->core->nr;
+	strncpy(card->card_name, sub->core->name, sizeof(sub->core->name));
+	card->i2c_adapter = &sub->core->i2c_adap;
+
+	switch(sub->core->type)
+	{
+	case BTTV_PINNACLESAT:
+		card->gpio_mode = 0x0400C060;
+		card->op_sync_orin = 0;
+		card->irq_err_ignore = 0;
 				/* 26, 15, 14, 6, 5 
-				 * A_G2X  DA_DPM DA_SBR DA_IOM_DA 
+		 * A_PWRDN  DA_DPM DA_SBR DA_IOM_DA 
 				 * DA_APP(parallel) */
 				break;
-			case 0x01010071:
-nebula:
-				dvb_bt8xx_card_match(card_nr, "Nebula DigiTV DVB-T",
-					     (1 << 26) | (1 << 14) | (1 << 5),
-					     0, 0);
+
+	case BTTV_NEBULA_DIGITV:
+	case BTTV_AVDVBT_761:
+		card->gpio_mode = (1 << 26) | (1 << 14) | (1 << 5);
+		card->op_sync_orin = 0;
+		card->irq_err_ignore = 0;
 				/* A_PWRDN DA_SBR DA_APP (high speed serial) */
 				break;
-			case 0x07611461:
-				dvb_bt8xx_card_match(card_nr, "Avermedia DVB-T",
-					     (1 << 26) | (1 << 14) | (1 << 5),
-					     0, 0);
-				/* A_PWRDN DA_SBR DA_APP (high speed serial) */
+
+	case BTTV_AVDVBT_771: //case 0x07711461:
+		card->gpio_mode = 0x0400402B;
+		card->op_sync_orin = BT878_RISC_SYNC_MASK;
+		card->irq_err_ignore = 0;
+		/* A_PWRDN DA_SBR  DA_APP[0] PKTP=10 RISC_ENABLE FIFO_ENABLE*/
 				break;
-			case 0x0:
-				if (card_type == BT878_NEBULA ||
-					card_type == BT878_TWINHAN_DST)
-					goto dst;
-				goto unknown_card;
-			case 0x2611BD:
-			case 0x11822:
-dst:
-				dvb_bt8xx_card_match(card_nr, "DST DVB-S", 0x2204f2c,
-						BT878_RISC_SYNC_MASK,
-						BT878_APABORT | BT878_ARIPERR | BT878_APPERR | BT878_AFBUS);
+
+	case BTTV_TWINHAN_DST:
+		card->gpio_mode = 0x2204f2c;
+		card->op_sync_orin = BT878_RISC_SYNC_MASK;
+		card->irq_err_ignore = BT878_APABORT | BT878_ARIPERR |
+				       BT878_APPERR | BT878_AFBUS;
 				/* 25,21,14,11,10,9,8,3,2 then
 				 * 0x33 = 5,4,1,0
 				 * A_SEL=SML, DA_MLB, DA_SBR, 
@@ -466,42 +270,45 @@
 				 * ACAP_EN = 1,
 				 * RISC+FIFO ENABLE */
 				break;
+
 			default:
-unknown_card:
-				printk("%s: unknown card_id found %0X\n",
-					__FUNCTION__, card_id);
-				if (card_type == BT878_NEBULA) {
-					printk("%s: bttv type set to nebula\n",
-						__FUNCTION__);
-					goto nebula;
-				}
-				if (card_type == BT878_TWINHAN_DST) {
-					printk("%s: bttv type set to Twinhan DST\n",
-						__FUNCTION__);
-					goto dst;
-				}
-				printk("%s: unknown card_type found %0X, NOT LOADED\n",
-					__FUNCTION__, card_type);
-				printk("%s: unknown card_nr found %0X\n",
-					__FUNCTION__, card_nr);
+		printk(KERN_WARNING "dvb_bt8xx: Unknown bttv card type: %d.\n",
+				sub->core->type);
+		kfree(card);
+		return -ENODEV;
 		}
-		card_nr++;
+
+	dprintk("dvb_bt8xx: identified card%d as %s\n", card->bttv_nr, card->card_name);
+			
+	if (!(bttv_pci_dev = bttv_get_pcidev(card->bttv_nr))) {
+		printk("dvb_bt8xx: no pci device for card %d\n", card->bttv_nr);
+		kfree(card);
+		return -EFAULT;
 	}
-	dvb_bt8xx_get_adaps();
-	dvb_bt8xx_load_all();
 
-	return 0;
+	if (!(card->bt = dvb_bt8xx_878_match(card->bttv_nr, bttv_pci_dev))) {
+		printk("dvb_bt8xx: unable to determine DMA core of card %d\n", card->bttv_nr);
+	
+		kfree(card);
+		return -EFAULT;
 
 }
 
-static void __exit dvb_bt8xx_exit(void)
-{
-	struct dvb_bt8xx_card *card;
-	struct list_head *entry, *entry_safe;
+	init_MUTEX(&card->bt->gpio_lock);
+	card->bt->bttv_nr = sub->core->nr;
 
-	dvb_bt8xx_exit_adaps();
-	list_for_each_safe(entry, entry_safe, &card_list) {
-		card = list_entry(entry, struct dvb_bt8xx_card, list);
+	if ( (ret = dvb_bt8xx_load_card(card)) ) {
+		kfree(card);
+		return ret;
+	}
+
+	dev_set_drvdata(dev, card);
+	return 0;
+}
+
+static int dvb_bt8xx_remove(struct device *dev)
+{
+	struct dvb_bt8xx_card *card = dev_get_drvdata(dev);
 		
 		dprintk("dvb_bt8xx: unloading card%d\n", card->bttv_nr);
 
@@ -512,14 +319,54 @@
 		card->demux.dmx.remove_frontend(&card->demux.dmx, &card->fe_hw);
 		dvb_dmxdev_release(&card->dmxdev);
 		dvb_dmx_release(&card->demux);
-		dvb_unregister_i2c_bus(master_xfer, card->dvb_adapter, 0);
-		dvb_bt8xx_i2c_adap_free(card->i2c_adapter);
 		dvb_unregister_adapter(card->dvb_adapter);
 		
 		list_del(&card->list);
 		kfree(card);
+
+	return 0;
 	}
 
+static void dvb_bt8xx_i2c_info(struct bttv_sub_device *sub,
+			       struct i2c_client *client, int attach)
+{
+	struct dvb_bt8xx_card *card = dev_get_drvdata(&sub->dev);
+
+	if (attach) {
+		printk("xxx attach\n");
+		if (client->driver->command)
+			client->driver->command(client, FE_REGISTER,
+						card->dvb_adapter);
+	} else {
+		printk("xxx detach\n");
+		if (client->driver->command)
+			client->driver->command(client, FE_UNREGISTER,
+						card->dvb_adapter);
+	}
+}
+
+static struct bttv_sub_driver driver = {
+	.drv = {
+		.name		= "dvb-bt8xx",
+		.probe		= dvb_bt8xx_probe,
+		.remove		= dvb_bt8xx_remove,
+		/* FIXME:
+		 * .shutdown	= dvb_bt8xx_shutdown,
+		 * .suspend	= dvb_bt8xx_suspend,
+		 * .resume	= dvb_bt8xx_resume,
+		 */
+	},
+	.i2c_info = dvb_bt8xx_i2c_info,
+};
+
+static int __init dvb_bt8xx_init(void)
+{
+	return bttv_sub_register(&driver, "dvb");
+}
+
+static void __exit dvb_bt8xx_exit(void)
+{
+	bttv_sub_unregister(&driver);
 }
 
 module_init(dvb_bt8xx_init);
@@ -527,4 +375,4 @@
 MODULE_DESCRIPTION("Bt8xx based DVB adapter driver");
 MODULE_AUTHOR("Florian Schirmer <jolt@tuxbox.org>");
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug, "i");
+
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/dvb-bt8xx.h linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.h
--- xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2004-08-18 16:44:48.000000000 +0200
@@ -25,9 +25,9 @@
 #include <linux/i2c.h>
 #include "dvbdev.h"
 #include "dvb_net.h"
+#include "bttv.h"
 
 struct dvb_bt8xx_card {
-
 	struct list_head list;
 	u8 active;
 	char card_name[32];
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/Kconfig linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/Kconfig
--- xx-linux-2.6.8.1/drivers/media/dvb/bt8xx/Kconfig	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/bt8xx/Kconfig	2004-05-28 13:08:43.000000000 +0200
@@ -1,13 +1,16 @@
 config DVB_BT8XX
-	tristate "Nebula/Pinnacle PCTV PCI cards"
+	tristate "Nebula/Pinnacle PCTV/Twinhan PCI cards"
 	depends on DVB_CORE && PCI && VIDEO_BT848
 	help
 	  Support for PCI cards based on the Bt8xx PCI bridge. Examples are
-	  the Nebula cards, the Pinnacle PCTV cards, and Twinhan DST cards.
+	  the Nebula cards, the Pinnacle PCTV cards and Twinhan DST cards.
 
           Since these cards have no MPEG decoder onboard, they transmit
 	  only compressed MPEG data over the PCI bus, so you need
 	  an external software decoder to watch TV on your computer.
 
+	  If you have a Twinhan card, don't forget to select
+	  "Twinhan DST based DVB-S/-T frontend".
+
 	  Say Y if you own such a device and want to use it.
 
diff -uraNwB xx-linux-2.6.8.1/drivers/media/dvb/frontends/dst-bt878.h linux-2.6.8.1-patched/drivers/media/dvb/frontends/dst-bt878.h
--- xx-linux-2.6.8.1/drivers/media/dvb/frontends/dst-bt878.h	2004-07-19 19:40:04.000000000 +0200
+++ linux-2.6.8.1-patched/drivers/media/dvb/frontends/dst-bt878.h	2004-08-18 16:45:40.000000000 +0200
@@ -32,7 +32,6 @@
 
 struct bt878 ;
 
-int
-bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp);
+int bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp);
 
-struct bt878 *bt878_find_by_dvb_adap(struct dvb_adapter *adap);
+struct bt878 *bt878_find_by_i2c_adap(struct i2c_adapter *adap);

--------------050407020108020404090302--
