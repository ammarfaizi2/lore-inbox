Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423045AbWJYHn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423045AbWJYHn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 03:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423087AbWJYHn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 03:43:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34269 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423045AbWJYHn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 03:43:56 -0400
Subject: [PATCH v2] Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Richard Hughes <hughsient@gmail.com>
Cc: Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>
In-Reply-To: <1161710328.17816.10.camel@hughsie-laptop>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Oct 2006 08:42:38 +0100
Message-Id: <1161762158.27622.72.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 8bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-24 at 18:18 +0100, Richard Hughes wrote:
>  We would need buy-in from ACPI, APM and PMU maintainers to avoid just
> creating *another* standard that HAL has to read.

That's the whole point in what I'm doing, yes. And that's why the owners
of that code are Cc'd.

> > > How are battery change notifications delivered to userspace? I know acpi
> > > is using the input layer for buttons in the future (very sane IMO), so
> > > using sysfs events for each property changing would probably be nice.
> > 
> > For selected properties, yes. I wouldn't want it happening every time
> > the current draw changes by a millivolt but for 'battery removed' or 'ac
> > power applied' events it makes some sense.
> 
> Maybe still send events for large changes, like > whole % changes in
> value. Then HAL hasn't got to poll at all.

Yes, perhaps. I'm still reluctant to make the kernel poll when the
hardware isn't sensible enough to provide interrupts -- I think we
should leave that to be implemented later, if at all. Let's get the
basic reporting implemented first.

> > For sane hardware where we get an interrupt on such changes, that's fine
> > -- but I'm wary of having to implement that by making the kernel poll
> > for them; especially if/when there's nothing in userspace which cares. 
> 
> HAL and gnome-power-manager? There should only be a few changing values
> on charging and discharging, and one every percentage point change isn't
> a lot.

My point is that if HAL isn't running, we shouldn't bother to poll. If
HAL _is_ running, then _it_ could poll, if the hardware isn't capable of
generating events. But let's leave that on the TODO list for now.

> > > > +#define BAT_INFO_CURRENT	(6) /* mA */
> > > Can't this also be expressed in mW according to the ACPI spec?
> > 
> > No, it can't. The Watt is not a unit of current.
> 
> Ahh, current as in electron flow, rather than current power use,
> apologies.

Indeed. That's one of the measurements I get from the OLPC battery
controller.

> > I intended the ACPI 'present rate' to map to the 'charge_rate' property,
> > which is why we have the 'charge_unit' property. I don't like that much,
> > but it seems necessary unless we're going to do something like separate
> > 'charge_rate_mA' and 'charge_rate_mW' properties.
> 
> Not sure how to best do this for the kernel - maybe just expose the
> value and the format separately. In HAL we normalise the rate to mWh
> anyway using the rate in mAh and reported voltage.

In that case, perhaps we should do the same in the kernel. But I think I
prefer to expose the 'raw' data.
 
> > Yes, feasibly. I don't quite know what the 'destroy' bit in the OLPC
> > embedded controller is supposed to mean, and 'FIRE' seemed as good as
> > anything else.
> 
> Then maybe just set present to false as a destroyed battery isn't much
> use anyway...

Hm, I've now seen it say 'destroy', after leaving it on battery
overnight till it shut down. When I applied power again, the battery
voltage claimed to be about 2½ volts and the 'destroy' flag was set. It
did seem to charge it up again though -- and it definitely wasn't on
fire :)

Updated patch in git://git.infradead.org/battery-2.6.git and below. I've
redone it to be more like hwmon, as suggested. Individual battery
'drivers' are now responsible for creating their own sysfs files
directly, instead of it being done by the core. I've added a list of
strings to battery.h which are the _only_ names I want to see in sysfs,
with specified units. Obviously we can continue to extend those -- and
one of the things I plan is to remove 'charge_units' and provide both
'design_charge' and 'design_energy' (also {energy,charge}_last,
_*_thresh etc.) to cover the mWh vs. mAh cases.

I haven't (yet) changed from a single 'status' file to multiple
'is_flag_0' 'is_flag_1' 'is_flag_2' files. I really don't like that idea
much -- it doesn't seem any more sensible than exposing each bit of the
voltage value through a separate file. These flags are _read_ together,
and _used_ together. I'd rather show it as a hex value 'flags' than
split it up. But I still think that the current 'present,charging,low'
is best.

commit 0aa9acc1c47dbb3c285d61bb55a1a363433c129f
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Tue Oct 24 16:14:59 2006 +0100

    [BATTERY] Update OLPC battery driver
    
    - Use platform_device
    - Implement all available status fields
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>

commit 0513b2f5473f1e8bb8880c9dee8e1d63af86336e
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Tue Oct 24 09:56:46 2006 +0100

    [BATTERY] Switch to using device_attribute, from the hardware driver
    
    ... instead of the core battery class. Various other cleanups.
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>

commit 74e2a48a77347d348e9ed21576863d0d9b51c690
Author: Greg KH <greg@kroah.com>
Date:   Tue Oct 24 09:39:31 2006 +0100

    [BATTERY] Convert to struct device instead of class_device
    
    From: Greg KH <greg@kroah.com>
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>

commit 42fe507a262b2a2879ca62740c5312778ae78627
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Mon Oct 23 18:14:54 2006 +0100

    [BATTERY] Add support for OLPC battery
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>

commit 6cbec3b84e3ce737b4217788841ea10a28a5e340
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Mon Oct 23 18:14:14 2006 +0100

    [BATTERY] Add initial implementation of battery class
    
    I really don't like the sysfs interaction, and I don't much like the
    internal interaction with the battery drivers either. In fact, there
    isn't much I _do_ like, but it's good enough as a straw man.
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index f394634..1dc5dbe 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -34,6 +34,8 @@ source "drivers/ieee1394/Kconfig"
 
 source "drivers/message/i2o/Kconfig"
 
+source "drivers/battery/Kconfig"
+
 source "drivers/macintosh/Kconfig"
 
 source "drivers/net/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 4ac14da..cd091c9 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_PARPORT)		+= parport/
 obj-y				+= base/ block/ misc/ mfd/ net/ media/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
+obj-$(CONFIG_BATTERY_CLASS)	+= battery/
 obj-$(CONFIG_PPC_PMAC)		+= macintosh/
 obj-$(CONFIG_IDE)		+= ide/
 obj-$(CONFIG_FC4)		+= fc4/
diff --git a/drivers/battery/Kconfig b/drivers/battery/Kconfig
new file mode 100644
index 0000000..9c2389a
--- /dev/null
+++ b/drivers/battery/Kconfig
@@ -0,0 +1,22 @@
+
+menu "Battery support"
+
+config BATTERY_CLASS
+       tristate "Battery support"
+       help
+         Say Y to enable battery class support. This allows a battery
+	 information to be presented in a uniform manner for all types
+	 of batteries.
+
+	 Battery information from APM and ACPI is not yet available by
+	 this method, but should soon be. If you use APM or ACPI, say
+	 'N', although saying 'Y' would be harmless.
+
+config OLPC_BATTERY
+       tristate "One Laptop Per Child battery"
+       depends on BATTERY_CLASS && X86_32
+       help
+         Say Y to enable support for the battery on the $100 laptop.
+
+
+endmenu
diff --git a/drivers/battery/Makefile b/drivers/battery/Makefile
new file mode 100644
index 0000000..eeb5333
--- /dev/null
+++ b/drivers/battery/Makefile
@@ -0,0 +1,4 @@
+# Battery code
+obj-$(CONFIG_BATTERY_CLASS)		+= battery-class.o
+
+obj-$(CONFIG_OLPC_BATTERY)		+= olpc-battery.o
diff --git a/drivers/battery/battery-class.c b/drivers/battery/battery-class.c
new file mode 100644
index 0000000..60325c4
--- /dev/null
+++ b/drivers/battery/battery-class.c
@@ -0,0 +1,177 @@
+/*
+ * Battery class core
+ *
+ *	© 2006 David Woodhouse <dwmw2@infradead.org>
+ *
+ * Based on LED Class support, by John Lenz and Richard Purdie:
+ *
+ *	© 2005 John Lenz <lenz@cs.wisc.edu>
+ *	© 2005-2006 Richard Purdie <rpurdie@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/battery.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/idr.h>
+
+static struct class *battery_class;
+
+static DEFINE_IDR(battery_idr);
+static DEFINE_SPINLOCK(idr_lock);
+
+ssize_t battery_attribute_show_status(char *buf, unsigned long status)
+{
+        ssize_t ret = 0;
+
+	if (status & BAT_STAT_PRESENT)
+		sprintf(buf, "present");
+	else
+		sprintf(buf, "absent");
+
+	if (status & BAT_STAT_LOW)
+		strcat(buf, ",low");
+
+	if (status & BAT_STAT_FULL)
+		strcat(buf, ",full");
+
+	if (status & BAT_STAT_CHARGING)
+		strcat(buf, ",charging");
+
+	if (status & BAT_STAT_DISCHARGING)
+		strcat(buf, ",discharging");
+
+	if (status & BAT_STAT_OVERTEMP)
+		strcat(buf, ",overtemp");
+
+	if (status & BAT_STAT_CRITICAL)
+		strcat(buf, ",critical");
+
+	if (status & BAT_STAT_CHARGE_DONE)
+		strcat(buf, ",charge-done");
+
+	strcat(buf, "\n");
+        ret = strlen(buf) + 1;
+        return ret;
+}
+EXPORT_SYMBOL_GPL(battery_attribute_show_status);
+
+ssize_t battery_attribute_show_ac_status(char *buf, unsigned long status)
+{
+	return 1 + sprintf(buf, "o%s-line\n", status?"n":"ff");
+}  
+EXPORT_SYMBOL_GPL(battery_attribute_show_ac_status);
+
+static ssize_t battery_attribute_show_name(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct battery_dev *battery_dev = dev_get_drvdata(dev);
+	return 1 + sprintf(buf, "%s\n", battery_dev->name);
+}
+
+static const char *dev_types[] = { "battery", "ac" };
+
+static ssize_t battery_attribute_show_type(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct battery_dev *battery_dev = dev_get_drvdata(dev);
+
+	return 1 + sprintf(buf, "%s\n", dev_types[battery_dev->type]);
+}
+
+static DEVICE_ATTR(name, 0444, battery_attribute_show_name, NULL);
+static DEVICE_ATTR(type, 0444, battery_attribute_show_type, NULL);
+
+/**
+ * battery_dev_register - register a new object of battery_dev class.
+ * @dev: The device to register.
+ * @battery_dev: the battery_dev structure for this device.
+ */
+int battery_device_register(struct device *parent, struct battery_dev *battery_dev)
+{
+	int err;
+
+	if (battery_dev->type < PWRDEV_TYPE_BATTERY ||
+	    battery_dev->type > PWRDEV_TYPE_AC)
+		return -EINVAL;
+
+	do {
+		if (unlikely(!idr_pre_get(&battery_idr, GFP_KERNEL)))
+			return -ENOMEM;
+		
+		spin_lock(&idr_lock);
+		err = idr_get_new(&battery_idr, NULL, &battery_dev->id);
+		spin_unlock(&idr_lock);
+	} while(err == -EAGAIN);
+
+	if (unlikely(err))
+		return err;
+
+        battery_dev->dev = device_create(battery_class, parent, 0,
+					 "%d", battery_dev->id);
+
+        if (unlikely(IS_ERR(battery_dev->dev))) {
+		spin_lock(&idr_lock);
+		idr_remove(&battery_idr, battery_dev->id);
+		spin_unlock(&idr_lock);
+                return PTR_ERR(battery_dev->dev);
+	}
+
+        dev_set_drvdata(battery_dev->dev, battery_dev);
+
+        /* register the attributes */
+        device_create_file(battery_dev->dev, &dev_attr_type);
+        device_create_file(battery_dev->dev, &dev_attr_name);
+
+        dev_info(battery_dev->dev, "Registered power source\n");
+
+        return 0;
+}
+EXPORT_SYMBOL_GPL(battery_device_register);
+
+/**
+ * battery_dev_unregister - unregisters a object of battery_properties class.
+ * @battery_dev: the battery device to unreigister
+ *
+ * Unregisters a previously registered via battery_dev_register object.
+ */
+void battery_device_unregister(struct battery_dev *battery_dev)
+{
+        device_remove_file(battery_dev->dev, &dev_attr_type);
+        device_remove_file(battery_dev->dev, &dev_attr_name);
+
+        device_unregister(battery_dev->dev);
+
+	spin_lock(&idr_lock);
+	idr_remove(&battery_idr, battery_dev->id);
+	spin_unlock(&idr_lock);
+}
+EXPORT_SYMBOL_GPL(battery_device_unregister);
+
+static int __init battery_init(void)
+{
+        battery_class = class_create(THIS_MODULE, "battery");
+        if (IS_ERR(battery_class))
+                return PTR_ERR(battery_class);
+        return 0;
+}
+
+static void __exit battery_exit(void)
+{
+        class_destroy(battery_class);
+}
+
+subsys_initcall(battery_init);
+module_exit(battery_exit);
+
+MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Battery class interface");
diff --git a/drivers/battery/olpc-battery.c b/drivers/battery/olpc-battery.c
new file mode 100644
index 0000000..2057b7c
--- /dev/null
+++ b/drivers/battery/olpc-battery.c
@@ -0,0 +1,335 @@
+/*
+ * Battery driver for One Laptop Per Child ($100 laptop) board.
+ *
+ *	© 2006 David Woodhouse <dwmw2@infradead.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/battery.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <asm/io.h>
+
+#define wBAT_VOLTAGE		0xf900 /* *9.76/32,    mV */
+#define wBAT_CURRENT		0xf902 /* *15.625/120, mA */
+#define wBAT_TEMP		0xf906 /* *256/1000,   °C */
+#define wAMB_TEMP		0xf908 /* *256/1000,   °C */
+#define SOC			0xf910 /*      percentage */
+#define sMBAT_STATUS		0xfaa4
+#define		sBAT_PRESENT		1
+#define		sBAT_FULL		2
+#define		sBAT_DESTROY		4
+#define		sBAT_LOW			32
+#define		sBAT_DISCHG		64
+#define sMCHARGE_STATUS		0xfaa5
+#define		sBAT_CHARGE		1
+#define		sBAT_OVERTEMP		4
+#define		sBAT_NiMH		8
+#define sPOWER_FLAG		0xfa40
+#define		ADAPTER_IN		1
+
+/*********************************************************************
+ *		EC locking and access
+ *********************************************************************/
+
+static int lock_ec(void)
+{
+	unsigned long timeo = jiffies + HZ/20;
+
+	while (1) {
+                unsigned char lock = inb(0x6c) & 0x80;
+                if (!lock)
+                        return 0;
+		if (time_after(jiffies, timeo)) {
+			printk(KERN_ERR "Failed to lock EC for battery access\n");
+			return 1;
+		}
+                yield();
+	}
+}
+
+static void unlock_ec(void)
+{
+	outb(0xff, 0x6c);
+}
+
+static unsigned char read_ec_byte(unsigned short adr)
+{
+	outb(adr >> 8, 0x381);
+	outb(adr, 0x382);
+	return inb(0x383);
+}
+
+unsigned short read_ec_word(unsigned short adr)
+{
+	return (read_ec_byte(adr) << 8) | read_ec_byte(adr+1);
+}
+
+/*********************************************************************
+ *		Status flags
+ *********************************************************************/
+static ssize_t olpc_ac_status_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	unsigned long status;
+
+	if (lock_ec())
+		return -EIO;
+
+	if (!(read_ec_byte(sMBAT_STATUS) & sBAT_PRESENT)) {
+		unlock_ec();
+		return -ENODEV;
+	}
+
+	status = read_ec_byte(sPOWER_FLAG) & ADAPTER_IN;
+
+	unlock_ec();
+
+	return battery_attribute_show_ac_status(buf, status);
+}
+
+static struct device_attribute dev_attr_ac_status = 
+	__ATTR(status, 0444, olpc_ac_status_show, NULL);
+
+static ssize_t olpc_bat_status_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	unsigned long status = 0;
+	unsigned short tmp;
+
+	if (lock_ec())
+		return -EIO;
+
+	tmp = read_ec_byte(sMBAT_STATUS);
+		
+	if (tmp & sBAT_PRESENT)
+		status |= BAT_STAT_PRESENT;
+	if (tmp & sBAT_FULL)
+		status |= BAT_STAT_FULL;
+	if (tmp & sBAT_DESTROY)
+		status |= BAT_STAT_CRITICAL;
+	if (tmp & sBAT_LOW)
+		status |= BAT_STAT_LOW;
+	if (tmp & sBAT_DISCHG)
+		status |= BAT_STAT_DISCHARGING;
+
+	tmp = read_ec_byte(sMCHARGE_STATUS);
+	if (tmp & sBAT_CHARGE)
+		status |= BAT_STAT_CHARGING;
+	if (tmp & sBAT_OVERTEMP)
+		status |= BAT_STAT_OVERTEMP;
+
+	unlock_ec();
+	return battery_attribute_show_status(buf, status);
+}
+static struct device_attribute dev_attr_bat_status = 
+	__ATTR(status, 0444, olpc_bat_status_show, NULL);
+
+/*********************************************************************
+ *		Integer attributes
+ *********************************************************************/
+
+struct olpc_bat_attr_int {
+	struct device_attribute dev_attr;
+	unsigned short adr;
+	int mul, div;
+};
+
+#define ATTR_INT(_name, _adr, _mul, _div) {			\
+	.dev_attr.attr.name = _name,				\
+	.dev_attr.attr.mode = 0444,				\
+	.dev_attr.show = olpc_bat_attr_int_show,		\
+	.adr = _adr,						\
+	.mul = _mul,						\
+	.div = _div,						\
+}
+
+static int olpc_bat_attr_int_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct olpc_bat_attr_int *battr = (void *)attr;
+	long value;
+
+	if (lock_ec())
+		return -EIO;
+
+	if (!(read_ec_byte(sMBAT_STATUS) & sBAT_PRESENT)) {
+		unlock_ec();
+		return -ENODEV;
+	}
+
+	if (battr->adr == SOC) {
+		value = read_ec_byte(battr->adr);
+	} else {
+		value = (signed short)read_ec_word(battr->adr);
+
+		value *= battr->mul;
+		value /= battr->div;
+	}
+	unlock_ec();
+
+	return 1 + sprintf(buf, "%ld\n", value);
+}
+
+static struct olpc_bat_attr_int attrs_int[] = {
+	ATTR_INT(BAT_INFO_VOLTAGE, wBAT_VOLTAGE, 9760,  32000),
+	ATTR_INT(BAT_INFO_CURRENT, wBAT_CURRENT, 15625, 120000),
+	ATTR_INT(BAT_INFO_TEMP1,   wBAT_TEMP,    1000,  256),
+	ATTR_INT(BAT_INFO_TEMP2,   wAMB_TEMP,    1000,  256),
+	ATTR_INT(BAT_INFO_CHARGE_PCT, SOC,       1,     1)
+};
+
+
+/*********************************************************************
+ *		String attributes
+ *********************************************************************/
+
+struct olpc_bat_attr_str {
+	struct device_attribute dev_attr;
+	char *str;
+};
+
+#define ATTR_STR(_name, _str) {					\
+	.dev_attr.attr.name = _name,				\
+	.dev_attr.attr.mode = 0444,				\
+	.dev_attr.show = olpc_bat_attr_str_show,		\
+	.str = (char *)_str,					\
+}
+
+static int olpc_bat_attr_str_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct olpc_bat_attr_str *sattr = (void *)attr;
+	unsigned short tmp;
+	int ret = 0;
+
+	/* Static strings are simple */
+	if ((unsigned long)sattr->str > PAGE_SIZE) {
+		return 1 + sprintf(buf, "%s\n", sattr->str);
+	}
+
+	if (lock_ec())
+		ret = -EIO;
+	
+	if (!(read_ec_byte(sMBAT_STATUS) & sBAT_PRESENT))
+		ret = -ENODEV;
+	else switch((unsigned long)sattr->str) {
+	case 1:
+		tmp = read_ec_byte(sMCHARGE_STATUS);
+		if (tmp & sBAT_NiMH)
+			ret = 1 + sprintf(buf, "NiMH\n");
+		else
+			ret = 1 + sprintf(buf, "unknown\n");
+		break;
+	default:
+		printk(KERN_ERR "Unknown string type %p\n", sattr->str);
+	}
+
+	unlock_ec();
+	return ret;
+}
+
+static struct olpc_bat_attr_str attrs_str[] = {
+	ATTR_STR(BAT_INFO_TEMP1_NAME, "battery"),
+	ATTR_STR(BAT_INFO_TEMP2_NAME, "ambient"),
+	ATTR_STR(BAT_INFO_TECHNOLOGY, 1),
+};
+
+/*********************************************************************
+ *		Initialisation
+ *********************************************************************/
+
+static struct battery_dev olpc_bat = {
+	.name = "OLPC battery",
+	.type = PWRDEV_TYPE_BATTERY,
+};
+
+static struct battery_dev olpc_ac = {
+	.name = "OLPC AC",
+	.type = PWRDEV_TYPE_AC,
+};
+static struct platform_device *bat_plat_dev;
+
+int __init olpc_bat_init(void)
+{
+	int ret = -ENODEV;
+	unsigned short tmp;
+	int i;
+
+	if (!request_region(0x380, 4, "battery"))
+		return -EIO;
+
+	if (lock_ec())
+		goto out_rel;
+
+	tmp = read_ec_word(0xfe92);
+	unlock_ec();
+
+	if (tmp != 0x380) {
+		/* Doesn't look like OLPC EC, but unlock anyway */
+		return -ENODEV;
+	}
+
+	bat_plat_dev = platform_device_register_simple("olpc-battery", 0, NULL, 0);
+	if (IS_ERR(bat_plat_dev))
+		goto out_rel;
+
+	ret = battery_device_register(&bat_plat_dev->dev, &olpc_bat);
+	if (ret)
+		goto out_plat;
+
+	ret = battery_device_register(&bat_plat_dev->dev, &olpc_ac);
+	if (ret) {
+		battery_device_unregister(&olpc_bat);
+	out_plat:
+		platform_device_unregister(bat_plat_dev);
+	out_rel:
+		release_region(0x380, 4);
+		return ret;
+	}
+	for (i=0; i < ARRAY_SIZE(attrs_int); i++)
+		device_create_file(olpc_bat.dev, &attrs_int[i].dev_attr);
+	for (i=0; i < ARRAY_SIZE(attrs_str); i++)
+		device_create_file(olpc_bat.dev, &attrs_str[i].dev_attr);
+
+	device_create_file(olpc_bat.dev, &dev_attr_bat_status);
+	device_create_file(olpc_ac.dev, &dev_attr_ac_status);
+	
+	return ret;
+}
+
+void __exit olpc_bat_exit(void)
+{
+	int i;
+
+	device_remove_file(olpc_bat.dev, &dev_attr_bat_status);
+	device_remove_file(olpc_ac.dev, &dev_attr_ac_status);
+
+	for (i=0; i < ARRAY_SIZE(attrs_int); i++)
+		device_remove_file(olpc_bat.dev, &attrs_int[i].dev_attr);
+	for (i=0; i < ARRAY_SIZE(attrs_str); i++)
+		device_remove_file(olpc_bat.dev, &attrs_str[i].dev_attr);
+	battery_device_unregister(&olpc_ac);
+	battery_device_unregister(&olpc_bat);
+	platform_device_unregister(bat_plat_dev);
+	release_region(0x380, 4);
+}
+
+
+module_init(olpc_bat_init);
+module_exit(olpc_bat_exit);
+
+MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Battery class interface");
diff --git a/include/linux/battery.h b/include/linux/battery.h
new file mode 100644
index 0000000..6148d5f
--- /dev/null
+++ b/include/linux/battery.h
@@ -0,0 +1,93 @@
+/*
+ * Driver model for batteries
+ *
+ *	© 2006 David Woodhouse <dwmw2@infradead.org>
+ *
+ * Based on LED Class support, by John Lenz and Richard Purdie:
+ *
+ *	© 2005 John Lenz <lenz@cs.wisc.edu>
+ *	© 2005-2006 Richard Purdie <rpurdie@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef __LINUX_BATTERY_H__
+#define __LINUX_BATTERY_H__
+
+struct device;
+struct class_device;
+
+/*
+ * Battery Core
+ */
+#define PWRDEV_TYPE_BATTERY	0
+#define PWRDEV_TYPE_AC		1
+
+#define BAT_STAT_PRESENT	(1<<0)
+#define BAT_STAT_LOW		(1<<1)
+#define BAT_STAT_FULL		(1<<2)
+#define BAT_STAT_CHARGING	(1<<3)
+#define BAT_STAT_DISCHARGING	(1<<4)
+#define BAT_STAT_OVERTEMP	(1<<5)
+#define BAT_STAT_CRITICAL	(1<<6)
+#define BAT_STAT_FIRE		(1<<7)
+#define BAT_STAT_CHARGE_DONE	(1<<8)
+
+/* Thou shalt not export any attributes in sysfs except these, and
+   with these units: */
+#define BAT_INFO_STATUS		"status"		/* For AC: "on-line" or "off-line" */
+							/* For battery: ... */
+
+#define BAT_INFO_TEMP1		"temp1"			/* °C/1000 */
+#define BAT_INFO_TEMP1_NAME	"temp1_name"		/* string */
+
+#define BAT_INFO_TEMP2		"temp2"			/* °C/1000 */
+#define BAT_INFO_TEMP2_NAME	"temp2_name"		/* string */
+
+#define BAT_INFO_VOLTAGE	"voltage"		/* mV */
+#define BAT_INFO_VOLTAGE_DESIGN	"design_voltage"	/* mV */
+
+#define BAT_INFO_CURRENT	"current"		/* mA */
+#define BAT_INFO_AVG_CURRENT	"current_avg"		/* mA */
+
+#define BAT_INFO_CHARGE_RATE	"charge_rate"		/* CHARGE_UNITS */
+#define BAT_INFO_CHARGE		"charge"		/* CHARGE_UNITS*h */
+#define BAT_INFO_CHARGE_MAX	"design_charge"		/* CHARGE_UNITS*h */
+#define BAT_INFO_CHARGE_LAST	"charge_last"		/* CHARGE_UNITS*h */
+#define BAT_INFO_CHARGE_LOW	"charge_low_thresh"	/* CHARGE_UNITS*h */
+#define BAT_INFO_CHARGE_WARN	"charge_warn_thresh"	/* CHARGE_UNITS*h */
+#define BAT_INFO_CHARGE_UNITS	"charge_units"		/* string */
+
+#define BAT_INFO_CHARGE_PCT	"charge_percentage"	/* integer */
+
+#define BAT_INFO_TIME_REMAINING	"time_remaining"	/* seconds */
+
+#define BAT_INFO_MANUFACTURER	"manufacturer"		/* string */
+#define BAT_INFO_TECHNOLOGY	"technology"		/* string */
+#define BAT_INFO_MODEL		"model"			/* string */
+#define BAT_INFO_SERIAL		"serial"		/* string */
+#define BAT_INFO_OEM_INFO	"oem_info"		/* string */
+
+#define BAT_INFO_CHARGE_COUNT	"charge_count"		/* integer */
+#define BAT_INFO_MFR_DATE	"manufacture_date"	/* YYYY[-MM[-DD]] */
+#define BAT_INFO_FIRST_USE	"first_use"		/* YYYY[-MM[-DD]] */
+
+struct battery_dev {
+
+	int			id;
+	int			type;
+	const char		*name;
+
+	struct device		*dev;
+};
+
+int battery_device_register(struct device *parent,
+			    struct battery_dev *battery_cdev);
+void battery_device_unregister(struct battery_dev *battery_cdev);
+
+
+ssize_t battery_attribute_show_status(char *buf, unsigned long status);
+ssize_t battery_attribute_show_ac_status(char *buf, unsigned long status);
+#endif /* __LINUX_BATTERY_H__ */


-- 
dwmw2

