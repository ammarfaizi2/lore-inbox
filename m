Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVALUkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVALUkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVALUiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:38:22 -0500
Received: from verein.lst.de ([213.95.11.210]:42446 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261430AbVALUcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:32:04 -0500
Date: Wed, 12 Jan 2005 21:31:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@osdl.org, akpm@osdl.org
Cc: adaplas@pol.net, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] kill symbol_get & friends
Message-ID: <20050112203136.GA3150@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty introduced symbol_get as a replacement for inter_module_get, but
it doesn't really solved the underlying problem.

Which is that just about every subsystem assumes that the implicit
reference a module get's as soon as it's exported symbols are used
can't go away unexpectly, e.g. any

	foo_register()

will always be followed by an

	foo_unregister()

before the module goes away, and thus foo_register can just allocate
data structures which will be freed by foo_unregister.

Now with symbol_get we do

	int (*bar_foo)(struct bar_foo *) = symbol_get(fump_bar_foo);
	if (bar_foo)
		bar_foo(...);
	symbol_put(bar_foo);

for the register call, but the module exporting fump_bar_foo can
go away before we do the same game for the unregister function.

I think we should simply disallow these weak references in any form, as
the obvious way to use them is incorrect and Linux has done very well
so far in trading a little bit of memory (requiring the module to be
a hard depency) for such complexity.  And usually the requirement can
be turned off hard anyway (e.g. CONFIG_I2C for the one and only current
user of symbol_get).

And as mentioned we only have one single users of this mechanism in the
tree which doesn't speak for it's general usefullness (well, and another
one of the previous version, inter_module_*)


--- 1.66/drivers/video/Kconfig	2004-10-28 09:39:53 +02:00
+++ edited/drivers/video/Kconfig	2005-01-12 21:09:13 +01:00
@@ -798,8 +798,6 @@
 config FB_SAVAGE
 	tristate "S3 Savage support"
 	depends on FB && PCI && EXPERIMENTAL
-	select I2C_ALGOBIT if FB_SAVAGE_I2C
-	select I2C if FB_SAVAGE_I2C
 	select FB_MODE_HELPERS
 	help
 	  This driver supports notebooks and computers with S3 Savage PCI/AGP
@@ -811,9 +809,10 @@
 	  will be called savagefb.
 
 config FB_SAVAGE_I2C
-       tristate "Enable DDC2 Support"
-       depends on FB_SAVAGE
-       help
+	tristate "Enable DDC2 Support"
+	select I2C_ALGOBIT if FB_SAVAGE_I2C
+	select I2C if FB_SAVAGE_I2C
+	help
 	  This enables I2C support for S3 Savage Chipsets.  This is used
 	  only for getting EDID information from the attached display
 	  allowing for robust video mode handling and switching.
--- 1.4/drivers/video/savage/savagefb-i2c.c	2005-01-05 03:48:33 +01:00
+++ edited/drivers/video/savage/savagefb-i2c.c	2005-01-12 21:08:33 +01:00
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/fb.h>
+#include <linux/i2c.h>
 
 #include <asm/io.h>
 #include "savagefb.h"
@@ -141,10 +142,9 @@
 static int savage_setup_i2c_bus(struct savagefb_i2c_chan *chan,
 				const char *name)
 {
-	int (*add_bus)(struct i2c_adapter *) = symbol_get(i2c_bit_add_bus);
 	int rc = 0;
 
-	if (add_bus && chan->par) {
+	if (chan->par) {
 		strcpy(chan->adapter.name, name);
 		chan->adapter.owner		= THIS_MODULE;
 		chan->adapter.id		= I2C_ALGO_SAVAGE;
@@ -162,7 +162,7 @@
 		chan->algo.setscl(chan, 1);
 		udelay(20);
 
-		rc = add_bus(&chan->adapter);
+		rc = i2c_bit_add_bus(&chan->adapter);
 
 		if (rc == 0)
 			dev_dbg(&chan->par->pcidev->dev,
@@ -170,8 +170,6 @@
 		else
 			dev_warn(&chan->par->pcidev->dev,
 				 "Failed to register I2C bus %s.\n", name);
-
-		symbol_put(i2c_bit_add_bus);
 	} else
 		chan->par = NULL;
 
@@ -212,14 +210,9 @@
 void savagefb_delete_i2c_busses(struct fb_info *info)
 {
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
-	int (*del_bus)(struct i2c_adapter *) =
-		symbol_get(i2c_bit_del_bus);
-
-	if (del_bus && par->chan.par) {
-		del_bus(&par->chan.adapter);
-		symbol_put(i2c_bit_del_bus);
-	}
 
+	if (par->chan.par)
+		i2c_bit_del_bus(&par->chan.adapter);
 	par->chan.par = NULL;
 }
 EXPORT_SYMBOL(savagefb_delete_i2c_busses);
@@ -227,8 +220,6 @@
 static u8 *savage_do_probe_i2c_edid(struct savagefb_i2c_chan *chan)
 {
 	u8 start = 0x0;
-	int (*transfer)(struct i2c_adapter *, struct i2c_msg *, int) =
-		symbol_get(i2c_transfer);
 	struct i2c_msg msgs[] = {
 		{
 			.addr	= SAVAGE_DDC,
@@ -242,21 +233,19 @@
 	};
 	u8 *buf = NULL;
 
-	if (transfer && chan->par) {
+	if (chan->par) {
 		buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
 
 		if (buf) {
 			msgs[1].buf = buf;
 
-			if (transfer(&chan->adapter, msgs, 2) != 2) {
+			if (i2c_transfer(&chan->adapter, msgs, 2) != 2) {
 				dev_dbg(&chan->par->pcidev->dev,
 					"Unable to read EDID block.\n");
 				kfree(buf);
 				buf = NULL;
 			}
 		}
-
-		symbol_put(i2c_transfer);
 	}
 
 	return buf;
--- 1.92/include/linux/module.h	2005-01-10 20:28:15 +01:00
+++ edited/include/linux/module.h	2005-01-12 21:07:45 +01:00
@@ -169,11 +169,6 @@
 
 #ifdef CONFIG_MODULES
 
-/* Get/put a kernel symbol (calls must be symmetric) */
-void *__symbol_get(const char *symbol);
-void *__symbol_get_gpl(const char *symbol);
-#define symbol_get(x) ((typeof(&x))(__symbol_get(MODULE_SYMBOL_PREFIX #x)))
-
 #ifndef __GENKSYMS__
 #ifdef CONFIG_MODVERSIONS
 /* Mark the CRC weak since genksyms apparently decides not to
@@ -350,9 +345,6 @@
 
 #ifdef CONFIG_MODULE_UNLOAD
 unsigned int module_refcount(struct module *mod);
-void __symbol_put(const char *symbol);
-#define symbol_put(x) __symbol_put(MODULE_SYMBOL_PREFIX #x)
-void symbol_put_addr(void *addr);
 
 /* Sometimes we know we already have a refcount, and it's easier not
    to handle the error case (which only happens with rmmod --wait). */
@@ -403,9 +395,6 @@
 static inline void __module_get(struct module *module)
 {
 }
-#define symbol_put(x) do { } while(0)
-#define symbol_put_addr(p) do { } while(0)
-
 #endif /* CONFIG_MODULE_UNLOAD */
 
 /* This is a #define so the string doesn't get put in every .o file */
@@ -466,11 +455,6 @@
 	return NULL;
 }
 
-/* Get/put a kernel symbol (calls should be symmetric) */
-#define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
-#define symbol_put(x) do { } while(0)
-#define symbol_put_addr(x) do { } while(0)
-
 static inline void __module_get(struct module *module)
 {
 }
@@ -545,8 +529,6 @@
 
 #endif /* CONFIG_MODULES */
 
-#define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
-
 /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
 
 struct obsolete_modparm {
@@ -567,7 +549,6 @@
 
 #define __MODULE_STRING(x) __stringify(x)
 
-/* Use symbol_get and symbol_put instead.  You'll thank me. */
 #define HAVE_INTER_MODULE
 extern void __deprecated inter_module_register(const char *,
 		struct module *, const void *);
===== kernel/module.c 1.132 vs edited =====
--- 1.132/kernel/module.c	2005-01-12 01:42:57 +01:00
+++ edited/kernel/module.c	2005-01-12 21:09:51 +01:00
@@ -624,33 +624,6 @@
 		seq_printf(m, "-");
 }
 
-void __symbol_put(const char *symbol)
-{
-	struct module *owner;
-	unsigned long flags;
-	const unsigned long *crc;
-
-	spin_lock_irqsave(&modlist_lock, flags);
-	if (!__find_symbol(symbol, &owner, &crc, 1))
-		BUG();
-	module_put(owner);
-	spin_unlock_irqrestore(&modlist_lock, flags);
-}
-EXPORT_SYMBOL(__symbol_put);
-
-void symbol_put_addr(void *addr)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&modlist_lock, flags);
-	if (!kernel_text_address((unsigned long)addr))
-		BUG();
-
-	module_put(module_text_address((unsigned long)addr));
-	spin_unlock_irqrestore(&modlist_lock, flags);
-}
-EXPORT_SYMBOL_GPL(symbol_put_addr);
-
 static ssize_t show_refcnt(struct module_attribute *mattr,
 			   struct module *mod, char *buffer)
 {
@@ -1098,22 +1071,6 @@
 	/* Finally, free the core (containing the module structure) */
 	module_free(mod, mod->module_core);
 }
-
-void *__symbol_get(const char *symbol)
-{
-	struct module *owner;
-	unsigned long value, flags;
-	const unsigned long *crc;
-
-	spin_lock_irqsave(&modlist_lock, flags);
-	value = __find_symbol(symbol, &owner, &crc, 1);
-	if (value && !strong_try_module_get(owner))
-		value = 0;
-	spin_unlock_irqrestore(&modlist_lock, flags);
-
-	return (void *)value;
-}
-EXPORT_SYMBOL_GPL(__symbol_get);
 
 /* Change all symbols so that sh_value encodes the pointer directly. */
 static int simplify_symbols(Elf_Shdr *sechdrs,
