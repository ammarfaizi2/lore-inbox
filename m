Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUJWSDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUJWSDe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 14:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUJWSDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 14:03:34 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:526 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261264AbUJWSAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 14:00:52 -0400
Date: Sat, 23 Oct 2004 20:02:15 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <sensors@stimpy.netroedge.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: More on SMBus multiplexing
Message-Id: <20041023200215.38e375a1.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The more I think of Mark Hoffman's proposal to handle SMBus
multiplexing, the more I think he pointed us to the right direction.
However, I now wonder if things aren't even more simple than we first
thought.

The main idea is to remove the physical adapter from the i2c adapters
list, and add virtual busses instead. We already have the possibility to
do that right now. The second thing Mark proposed was to lock the
physical SMBus. While it may sound safer, I don't think it is really
necessary. The sole fact of removing it from the main list will
disconnect all chip clients, and clients loaded later won't see the
physical bus anymore. The only way to attach a client to the SMBus would
be to do it manually. Certainly it could hurt if someone would do that
(because it would interfer with the virtual busses) but it happens that
nobody does this (the whole thing is based on the idea that the core
will automatically connect all clients from the client lists with all
adapters from the adapters list).

What are we trying to protect us from with this "exclusive client" idea
exactly? It will always be possible to run raw commands on the physical
bus anyway, just call adapter.algo->smbus_xfer. There is no way we can
protect us against that. So I think we are trying to protect us from an
event that will never happen and that the protection can be circumvented
by someone with enough motivation anyway. Much work for nothing, IMHO.

If we forget about that bus locking and exclusive client access, I don't
think that anything is missing from the i2c core. All we need is
i2c_{add,del}_adapter, and possibly a way to find an adapter from its id
(I didn't find something like i2c_find_adapter, did I miss it?). I'm not
even sure that this is needed though. A possible approach is to have the
main smbus driver export its i2c_adapter structure, so that the virtual
smbus driver can access it. This also automagically creates a dependancy
between both modules, and ensures that loading the vitual bus driver
will load the main bus driver first.

Note that this approach (as Mark's original one, but contrary to my
original one) would require a couple changes to sensors-detect. It
should really only be a matter of adding the correct entries in the pci
devices list though. However, this could be made unnecessary by
requesting the second module after loading the first one, using
request_module(). I tried, it works, I just don't know if we want to do
it or not. The drawback is that it makes a few board-specific changes to
the main module.

As a side note, the concept of "exclusive access" for a multiplexer
client also raises issues in the case one SMBus would host more that one
multiplexer chip directly at its "root" level. I see no reason why this
would be technically impossible, yet Mark's original model wouldn't
support it. I guess it would be possible to emulate it as if the second
multiplexer was located behind the first one, but this would certainly
make things more complex.

Of course, as with Mark's approach, we have the benefit of having two
separated module, no code duplication and little to very little change
to the original driver, depending on whether we implement the autoload
mechanism or not, for a maximum maintainabilty (so that's better than
my proposal for the amd756-s4882 driver in 2.4/CVS, even after taking
Mark's comment into account).

I was about to commit my i2c-amd756-s4882 module to the lm_sensors CVS
repository, but now I think that I'll try that new approach instead of
my brutal code inclusion, which works but isn't really clean, to say the
least.

As a kind of proof of concept, I did a fake i2c-i801-vaio module to
virtualize the SMBus on my laptop (although it doesn't have a mux chip).
It works just OK as far as I can tell. Of course the code is stupidly
useless (the virtual adapter doesn't do anything more than dumbly
redirect the calls to the physical bus), and lacks the mux client
registration part, since there is no such chip. I think that the idea is
clear though, and at least now we have code to comment on ;)

Thanks.

Index: kernel/busses/Module.mk
===================================================================
RCS file: /home/cvs/lm_sensors2/kernel/busses/Module.mk,v
retrieving revision 1.48
diff -u -r1.48 Module.mk
--- kernel/busses/Module.mk	16 Apr 2004 20:56:53 -0000	1.48
+++ kernel/busses/Module.mk	23 Oct 2004 18:24:17 -0000
@@ -48,6 +48,7 @@
 endif
 ifneq ($(shell if grep -q '^CONFIG_I2C_I801=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-i801.o
+KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-i801-vaio.o
 endif
 ifneq ($(shell if grep -q '^CONFIG_I2C_I810=y' $(LINUX)/.config; then echo 1; fi),1)
 KERNELBUSSESTARGETS += $(MODULE_DIR)/i2c-i810.o
Index: kernel/busses/i2c-i801-vaio.c
===================================================================
RCS file: kernel/busses/i2c-i801-vaio.c
diff -N kernel/busses/i2c-i801-vaio.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ kernel/busses/i2c-i801-vaio.c	23 Oct 2004 18:24:17 -0000
@@ -0,0 +1,93 @@
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include "version.h"
+
+extern struct i2c_adapter i801_adapter;
+
+static s32 i801_vaio_access(struct i2c_adapter * adap, u16 addr,
+		       unsigned short flags, char read_write, u8 command,
+		       int size, union i2c_smbus_data * data)
+{
+	return i801_adapter.algo->smbus_xfer(adap, addr, flags,
+		read_write, command, size, data);
+}
+
+static struct i2c_algorithm smbus_algorithm = {
+	.name		= "Non-I2C SMBus adapter",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= i801_vaio_access,
+};
+
+struct i2c_adapter i801_vaio_adapter = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
+	.algo		= &smbus_algorithm,
+	.name		= "unset",
+};
+
+static int __init i2c_i801_vaio_init(void)
+{
+	int err;
+
+	printk(KERN_INFO "i2c-i801-vaio version %s (%s)\n", LM_VERSION,
+	       LM_DATE);
+
+	if (pci_find_subsys(PCI_VENDOR_ID_INTEL,
+			    PCI_DEVICE_ID_INTEL_82801CA_3,
+			    PCI_VENDOR_ID_SONY, 0x80e7, NULL) == NULL) {
+		return -ENODEV;
+	}
+
+	err = i2c_del_adapter(&i801_adapter);
+	if (err) {
+		printk(KERN_ERR "i2c-i801-vaio: Failed to delete physical "
+		       "adapter\n");
+		return err;
+	}
+
+	/* Attach mux chip to main adapter here */
+
+	smbus_algorithm.functionality = i801_adapter.algo->functionality;
+	snprintf(i801_vaio_adapter.name, 32, "SMBus I801 virtual adapter");
+
+	err = i2c_add_adapter(&i801_vaio_adapter);
+	if (err) {
+		printk(KERN_ERR "i2c-i801-vaio: Failed to add virtual "
+		       "adapter\n");
+		i2c_add_adapter(&i801_adapter);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit i2c_i801_vaio_exit(void)
+{
+	int err;
+	
+	err = i2c_del_adapter(&i801_vaio_adapter);
+	if (err) {
+		printk(KERN_ERR "i2c-i801-vaio: Failed to delete virtual "
+		       "adapter\n");
+		return;
+	}
+
+	/* Detach mux chip from main adapter here */
+
+	i2c_add_adapter(&i801_adapter);
+	if (err) {
+		printk(KERN_ERR "i2c-i801-vaio: Failed to add physical "
+		       "adapter back\n");
+		return;
+	}
+}
+
+MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org");
+MODULE_DESCRIPTION("I801 SMBus multiplexing");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_i801_vaio_init);
+module_exit(i2c_i801_vaio_exit);
Index: kernel/busses/i2c-i801.c
===================================================================
RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-i801.c,v
retrieving revision 1.36
diff -u -r1.36 i2c-i801.c
--- kernel/busses/i2c-i801.c	22 May 2004 04:02:19 -0000	1.36
+++ kernel/busses/i2c-i801.c	23 Oct 2004 18:24:18 -0000
@@ -49,6 +49,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/kmod.h>
 #include <asm/io.h>
 #include "version.h"
 #include "sensors_compat.h"
@@ -548,7 +549,7 @@
 	.functionality	= i801_func,
 };
 
-static struct i2c_adapter i801_adapter = {
+struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
 	.algo		= &smbus_algorithm,
@@ -558,6 +559,12 @@
 static struct pci_device_id i801_ids[] __devinitdata = {
 	{
 		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801CA_3,
+		.subvendor =	PCI_VENDOR_ID_SONY,
+		.subdevice =	0x80e7,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
 		.device =	PCI_DEVICE_ID_INTEL_82801AA_3,
 		.subvendor =	PCI_ANY_ID,
 		.subdevice =	PCI_ANY_ID,
@@ -609,6 +616,7 @@
 
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int err;
 
 	if (i801_setup(dev)) {
 		dev_warn(dev,
@@ -618,7 +626,14 @@
 
 	snprintf(i801_adapter.name, 32,
 		"SMBus I801 adapter at %04x", i801_smba);
-	return i2c_add_adapter(&i801_adapter);
+	if ((err = i2c_add_adapter(&i801_adapter)))
+		return err;
+
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_SONY
+	 && dev->subsystem_device == 0x80e7)
+	 	request_module("i2c-i801-vaio");
+
+	return 0;
 }
 
 static void __devexit i801_remove(struct pci_dev *dev)
@@ -651,5 +666,7 @@
 MODULE_DESCRIPTION("I801 SMBus driver");
 MODULE_LICENSE("GPL");
 
+EXPORT_SYMBOL(i801_adapter);
+
 module_init(i2c_i801_init);
 module_exit(i2c_i801_exit);



-- 
Jean Delvare
http://khali.linux-fr.org/
