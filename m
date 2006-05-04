Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWEDWH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWEDWH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWEDWH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 18:07:27 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:29884 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1030282AbWEDWH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 18:07:26 -0400
Message-ID: <445A7B30.1030104@keyaccess.nl>
Date: Fri, 05 May 2006 00:07:44 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       ALSA devel <alsa-devel@alsa-project.org>
Subject: Driver model ISA bus
Content-Type: multipart/mixed;
 boundary="------------000605090306080905080909"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000605090306080905080909
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg.

During the recent "isa drivers using platform devices" discussion it was 
pointed out that (ALSA) ISA drivers ran into the problem of not having 
the option to fail driver load (device registration rather) upon not 
finding their hardware due to a probe() error not being passed up 
through the driver model. In the course of that, I suggested a seperate 
ISA bus might be best; Russel King agreed and suggested this bus could 
use the .match() method for the actual device discovery.

The attached does this. For this old non (generically) discoverable ISA 
hardware only the driver itself can do discovery so as a difference with 
the platform_bus, this isa_bus also distributes match() up to the driver.

As another difference: these devices only exist in the driver model due 
to the driver creating them because it might want to drive them, meaning 
that all device creation has been made internal as well.

The usage model this provides is nice, and has been acked from the ALSA 
side by Takashi Iwai and Jaroslav Kysela. The ALSA driver module_init's 
now (for oldisa-only drivers) become:

static int __init alsa_card_foo_init(void)
{
	return isa_register_driver(&snd_foo_isa_driver, SNDRV_CARDS);
}

static void __exit alsa_card_foo_exit(void)
{
	isa_unregister_driver(&snd_foo_isa_driver);
}

Quite like the other bus models therefore. This removes a lot of 
duplicated init code from the ALSA ISA drivers.

The passed in isa_driver struct is the regular driver struct embedding a 
struct device_driver, the normal probe/remove/shutdown/suspend/resume 
callbacks, and as indicated that .match callback.

The "SNDRV_CARDS" you see being passed in is a "unsigned int ndev" 
parameter, indicating how many devices to create and call our methods with.

The platform_driver callbacks are called with a platform_device param; 
the isa_driver callbacks are being called with a "struct device *dev, 
unsigned int id" pair directly -- with the device creation completely 
internal to the bus it's much cleaner to not leak isa_dev's by passing 
them in at all. The id is the only thing we ever want other then the 
struct device * anyways, and it makes for nicer code in the callbacks as 
well.

With this additional .match() callback ISA drivers have all options. If 
ALSA would want to keep the old non-load behaviour, it could stick all 
of the old .probe in .match, which would only keep them registered after 
everything was found to be present and accounted for. If it wanted the 
behaviour of always loading as it inadvertently did for a bit after the 
changeover to platform devices, it could just not provide a .match() and 
do everything in .probe() as before.

If it, as Takashi Iwai already suggested earlier as a way of following 
the model from saner buses more closely, wants to load when a later bind 
could conceivably succeed, it could use .match() for the prerequisites 
(such as checking the user wants the card enabled and that port/irq/dma 
values have been passed in) and .probe() for everything else. This is 
the nicest model.

To the code...

This exports only two functions; isa_{,un}register_driver().

isa_register_driver() register's the struct device_driver, and then 
loops over the passed in ndev creating devices and registering them. 
This causes the bus match method to be called for them, which is:

int isa_bus_match(struct device *dev, struct device_driver *driver)
{
         struct isa_driver *isa_driver = to_isa_driver(driver);

         if (dev->platform_data == isa_driver) {
                 if (!isa_driver->match ||
                         isa_driver->match(dev, to_isa_dev(dev)->id))
                         return 1;
                 dev->platform_data = NULL;
         }
         return 0;
}

The first thing this does is check if this device is in fact one of this 
driver's devices by seeing if the device's platform_data pointer is set 
to this driver. Platform devices compare strings, but we don't need to 
do that with everything being internal, so isa_register_driver() abuses 
dev->platform_data as a isa_driver pointer which we can then check here. 
I believe platform_data is available for this, but if rather not, moving 
the isa_driver pointer to the private struct isa_dev is ofcourse fine as 
well.

Then, if the the driver did not provide a .match, it matches. If it did, 
the driver match() method is called to determine a match.

If it did _not_ match, dev->platform_data is reset to indicate this to 
isa_register_driver which can then unregister the device again.

If during all this, there's any error, or no devices matched at all 
everything is backed out again and the error, or -ENODEV, is returned.

isa_unregister_driver() just unregisters the matched devices and the 
driver itself.

More global points/questions...

- I'm introducing include/linux/isa.h. It was available but is ofcourse 
a somewhat generic name. Moving more isa stuff over to it in time is 
ofcourse fine, so can I have it please? :)

- I'm using device_initcall() and added the isa.o (dependent on 
CONFIG_ISA) after the base driver model things in the Makefile. Will 
this do, or I really need to stick it in drivers/base/init.c, inside 
#ifdef CONFIG_ISA? It's working fine.

Lastly -- I also looked, a bit, into integrating with PnP. "Old ISA" 
could be another pnp_protocol, but this does not seem to be a good 
match, largely due to the same reason platform_devices weren't -- the 
devices do not have a life of their own outside the driver, meaning the 
pnp_protocol {get,set}_resources callbacks would need to callback into 
driver -- which again means you first need to _have_ that driver. Even 
if there's clean way around that, you only end up inventing fake but 
valid-form PnP IDs and generally catering to the PnP layer without any 
practical advantages over this very simple isa_bus. The thing I also 
suggested earlier about the user echoing values into /sys to set up the 
hardware from userspace first is... well, cute, but a horrible idea from 
a user standpoint.

Comments ofcourse appreciated. Hope it's okay. As said, the usage model 
is nice at least.

Rene.


--------------000605090306080905080909
Content-Type: text/plain;
 name="isa_bus-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isa_bus-3.diff"

Index: local/drivers/base/isa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ local/drivers/base/isa.c	2006-05-02 23:18:34.000000000 +0200
@@ -0,0 +1,180 @@
+/*
+ * ISA bus.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/isa.h>
+
+static struct device isa_bus = {
+	.bus_id		= "isa"
+};
+
+struct isa_dev {
+	struct device dev;
+	struct device *next;
+	unsigned int id;
+};
+
+#define to_isa_dev(x) container_of((x), struct isa_dev, dev)
+
+static int isa_bus_match(struct device *dev, struct device_driver *driver)
+{
+	struct isa_driver *isa_driver = to_isa_driver(driver);
+
+	if (dev->platform_data == isa_driver) {
+		if (!isa_driver->match ||
+			isa_driver->match(dev, to_isa_dev(dev)->id))
+			return 1;
+		dev->platform_data = NULL;
+	}
+	return 0;
+}
+
+static int isa_bus_probe(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->probe)
+		return isa_driver->probe(dev, to_isa_dev(dev)->id);
+
+	return 0;
+}
+
+static int isa_bus_remove(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->remove)
+		return isa_driver->remove(dev, to_isa_dev(dev)->id);
+
+	return 0;
+}
+
+static void isa_bus_shutdown(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->shutdown)
+		isa_driver->shutdown(dev, to_isa_dev(dev)->id);
+}
+
+static int isa_bus_suspend(struct device *dev, pm_message_t state)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->suspend)
+		return isa_driver->suspend(dev, to_isa_dev(dev)->id, state);
+
+	return 0;
+}
+
+static int isa_bus_resume(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->resume)
+		return isa_driver->resume(dev, to_isa_dev(dev)->id);
+
+	return 0;
+}
+
+static struct bus_type isa_bus_type = {
+	.name		= "isa",
+	.match		= isa_bus_match,
+	.probe		= isa_bus_probe,
+	.remove		= isa_bus_remove,
+	.shutdown	= isa_bus_shutdown,
+	.suspend	= isa_bus_suspend,
+	.resume		= isa_bus_resume
+};
+
+static void isa_dev_release(struct device *dev)
+{
+	kfree(to_isa_dev(dev));
+}
+
+void isa_unregister_driver(struct isa_driver *isa_driver)
+{
+	struct device *dev = isa_driver->devices;
+
+	while (dev) {
+		struct device *tmp = to_isa_dev(dev)->next;
+		device_unregister(dev);
+		dev = tmp;
+	}
+	driver_unregister(&isa_driver->driver);
+}
+EXPORT_SYMBOL_GPL(isa_unregister_driver);
+
+int isa_register_driver(struct isa_driver *isa_driver, unsigned int ndev)
+{
+	int error;
+	unsigned int id;
+
+	isa_driver->driver.bus	= &isa_bus_type;
+	isa_driver->devices	= NULL;
+
+	error = driver_register(&isa_driver->driver);
+	if (error)
+		return error;
+
+	for (id = 0; id < ndev; id++) {
+		struct isa_dev *isa_dev;
+
+		isa_dev = kzalloc(sizeof *isa_dev, GFP_KERNEL);
+		if (!isa_dev) {
+			error = -ENOMEM;
+			break;
+		}
+
+		isa_dev->dev.parent	= &isa_bus;
+		isa_dev->dev.bus	= &isa_bus_type;
+
+		snprintf(isa_dev->dev.bus_id, BUS_ID_SIZE, "%s.%u",
+				isa_driver->driver.name, id);
+
+		isa_dev->dev.platform_data	= isa_driver;
+		isa_dev->dev.release		= isa_dev_release;
+		isa_dev->id			= id;
+
+		error = device_register(&isa_dev->dev);
+		if (error) {
+			put_device(&isa_dev->dev);
+			break;
+		}
+
+		if (isa_dev->dev.platform_data) {
+			isa_dev->next = isa_driver->devices;
+			isa_driver->devices = &isa_dev->dev;
+		} else
+			device_unregister(&isa_dev->dev);
+	}
+
+	if (!error && !isa_driver->devices)
+		error = -ENODEV;
+
+	if (error)
+		isa_unregister_driver(isa_driver);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(isa_register_driver);
+
+static int __init isa_bus_init(void)
+{
+	int error;
+
+	error = bus_register(&isa_bus_type);
+	if (!error) {
+		error = device_register(&isa_bus);
+		if (error)
+			bus_unregister(&isa_bus_type);
+	}
+	return error;
+}
+
+device_initcall(isa_bus_init);
Index: local/include/linux/isa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ local/include/linux/isa.h	2006-05-02 23:17:18.000000000 +0200
@@ -0,0 +1,28 @@
+/*
+ * ISA bus.
+ */
+
+#ifndef __LINUX_ISA_H
+#define __LINUX_ISA_H
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+
+struct isa_driver {
+	int (*match)(struct device *, unsigned int);
+	int (*probe)(struct device *, unsigned int);
+	int (*remove)(struct device *, unsigned int);
+	void (*shutdown)(struct device *, unsigned int);
+	int (*suspend)(struct device *, unsigned int, pm_message_t);
+	int (*resume)(struct device *, unsigned int);
+
+	struct device_driver driver;
+	struct device *devices;
+};
+
+#define to_isa_driver(x) container_of((x), struct isa_driver, driver)
+
+int isa_register_driver(struct isa_driver *, unsigned int);
+void isa_unregister_driver(struct isa_driver *);
+
+#endif /* __LINUX_ISA_H */
Index: local/drivers/base/Makefile
===================================================================
--- local.orig/drivers/base/Makefile	2006-05-02 22:44:00.000000000 +0200
+++ local/drivers/base/Makefile	2006-05-02 22:45:32.000000000 +0200
@@ -4,6 +4,7 @@ obj-y			:= core.o sys.o bus.o dd.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
 			   attribute_container.o transport_class.o
+obj-$(CONFIG_ISA)	+= isa.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o

--------------000605090306080905080909--
