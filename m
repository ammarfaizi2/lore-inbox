Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWGRRo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWGRRo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 13:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWGRRo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 13:44:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:20495 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932327AbWGRRo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 13:44:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=OTeVRcqyla02sDgiGIc2Hck3TbHtw+Xh8+2W3sJkfAyfaVMTiIozZV0rZoHEO3+OI2h3UXiiasy2gNFfdHxAEwHDQy4PujSHEKicUVuktgttWv5fzyoCQdK8W6HrmetbyOuNbPaxbtiyJO0FnKsN5TFo35K+ShQ2mwUtcNryAcA=
Message-ID: <44BD1E1F.6040509@gmail.com>
Date: Tue, 18 Jul 2006 11:45:03 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, Chris Boot <bootc@bootc.net>
CC: Greg KH <greg@kroah.com>
Subject: [RFC-patch]  add GPIO-Sysfs interface to scx200_gpio, pc8736x_gpio
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


heres a rough, RFC, proto-patch  which adds a GPIO-sysfs interface
into scx200_gpio, and pc8736x_gpio.

Im going on vacation, and thought I might solicit an inbox full of 
bright ideas
to bring me back to (a much sharper) focus upon my return.

heres a bit of testing which raises a few questions:
$> cat remod
#!/bin/bash
loudly() {
    echo
    echo running: $*
    eval $*
}
rmmod pc8736x_gpio
modprobe pc8736x_gpio
cd ~/pinlab
check123
#loudly cat /dev/led
#loudly cat /dev/gpio-17
loudly cat /sys/devices/platform/scx200_gpio.0/bit_0.20_value
loudly cat /sys/devices/platform/pc8736x_gpio.0/bit_2.1_value
loudly scansimple -d /dev/led
loudly scansimple -d /dev/gpio-17
loudly scansimple -d /sys/devices/platform/scx200_gpio.0/bit_0.20_value
loudly scansimple -d /sys/devices/platform/pc8736x_gpio.0/bit_2.1_value


soekris:~/pinlab# remod
[ 5729.928000] lockd: cannot monitor 192.168.42.1
[ 5729.932000] lockd: failed to monitor 192.168.42.1
[ 5729.940000] lockd: cannot monitor 192.168.42.1
[ 5729.944000] lockd: failed to monitor 192.168.42.1
[ 5730.468000] platform pc8736x_gpio.0: NatSemi pc8736x GPIO Driver 
Initializing
[ 5730.508000] platform pc8736x_gpio.0: GPIO ioport 6600 reserved
[ 5730.512000] platform pc8736x_gpio.0: pc8736x_sysfs_init creating 
pin-attr nodes
[ 5730.532000] platform pc8736x_gpio.0: creating gpio port-attrs
/dev/gpio-[0..31]: 11111111-10001011-01111001-10111000
/dev/scxio-[0..31]: 11100000-00001110-01000000-00000000

running: cat /sys/devices/platform/scx200_gpio.0/bit_0.20_value
[ 5732.836000] platform scx200_gpio.0: nsc_gpio_sysfs_get(V) = 0
0

running: cat /sys/devices/platform/pc8736x_gpio.0/bit_2.1_value
[ 5732.864000] platform pc8736x_gpio.0: nsc_gpio_sysfs_get(V) = 1
1

running: scansimple -d /dev/led
opened /dev/led, for 1 loops, 1000000 samples
read 1000000 samples in 4.5966 sec, rate: 217552.5750 samples/sec

running: scansimple -d /dev/gpio-17
opened /dev/gpio-17, for 1 loops, 1000000 samples
read 1000000 samples in 6.5261 sec, rate: 153230.0295 samples/sec

running: scansimple -d /sys/devices/platform/scx200_gpio.0/bit_0.20_value
opened /sys/devi[ 5744.104000] platform scx200_gpio.0: 
nsc_gpio_sysfs_get(V) = 0
ces/platform/scx200_gpio.0/bit_0.20_value, for 1 loops, 1000000 samples
read 1000000 samples in 3.8179 sec, rate: 261926.3556 samples/sec

running: scansimple -d /sys/devices/platform/pc8736x_gpio.0/bit_2.1_value
opened /sys/devi[ 5747.956000] platform pc8736x_gpio.0: 
nsc_gpio_sysfs_get(V) = 1
ces/platform/pc8736x_gpio.0/bit_2.1_value, for 1 loops, 1000000 samples
read 1000000 samples in 3.5392 sec, rate: 282549.9708 samples/sec


Q1- do the device-file read rates look reasonable ? 

    217k reads/sec, to the led ( a device-file to scx200-gpio )
    153k reads/sec to pc8736x_gpio

# cat /proc/cpuinfo
processor       : 0
vendor_id       : Geode by NSC
cpu family      : 5
model           : 9
model name      : Unknown
stepping        : 1
cpu MHz         : 266.648

Roughly, I think this looks ok, 
the scx is on-chip gpio, on pci interface, other is isa bus.
However, I dont have experience to compare it against.


Q2 - my sysfs interface looks broken ?

- its too fast
    250k reads/sec to sysfs-interface to pc8736x_gpio.
    277k to scx200_gpio

- its evidently not re-reading the pin, this appears just once, not 
repeatedly.
    [ 3534.552000] platform scx200_gpio.0: nsc_gpio_sysfs_get(V) = 1


Q3 - why does cat /dev/led read forever ?
    A- no EOF, and cat re-reads til EOF.
    also - no newline, read() length always 1 (later-Q)


Q4 - I added an lseek call to scansimple.

    it slows down the read-rate. (about 1/2 speed)
    it *doesnt* seem to re-trigger the underlying accessor.

running: scansimple -b -d /sys/devices/platform/scx200_gpio.0/bit_0.20_value
opened /sys/devi[ 6117.828000] platform scx200_gpio.0: 
nsc_gpio_sysfs_get(V) = 0
ces/platform/scx200_gpio.0/bit_0.20_value, for 1 loops, 1000000 samples
read 1000000 samples in 7.2937 sec, rate: 137104.5667 samples/sec

running: scansimple -b -d /sys/devices/platform/pc8736x_gpio.0/bit_2.1_value
opened /sys/devi[ 6125.160000] platform pc8736x_gpio.0: 
nsc_gpio_sysfs_get(V) = 1
ces/platform/pc8736x_gpio.0/bit_2.1_value, for 1 loops, 1000000 samples
read 1000000 samples in 7.1696 sec, rate: 139476.9601 samples/sec

Q5 - should I be looking for pollable sysfs ?
    If so, can someone recommend a best-practice, nearest-fit module I 
can review ?

Q6 - my sysfs callbacks are appending newline.
    - cargo cult (just copying from somewhere)
    - is it proper ?  (looking for commonality)

Q7 - WRT gpio_ops, Ive s/u8/u32/ most params & returntypes, assuming that
    - is cost-less - (all stack args are full word, never byte)
    - casting up from u8 to u32 is fine. (no baroque type games)

Q8 - its tempting to add a 'command' attr,
    - which responds to writes identically to the device-file interface
    - reads return the string produced by gpio_dump.
    - defensible as a compatibility-hack (or not?)


tia
- jimc

ps - theres (no doubt) plenty thats not working..


diff -ruNp -X dontdiff -X exclude-diffs ag-0/drivers/char/nsc_gpio.c ag-1/drivers/char/nsc_gpio.c
--- ag-0/drivers/char/nsc_gpio.c	2006-07-15 01:08:50.000000000 -0600
+++ ag-1/drivers/char/nsc_gpio.c	2006-07-18 09:11:12.000000000 -0600
@@ -13,10 +13,12 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/io.h>
 #include <asm/uaccess.h>
-#include <asm/io.h>
 
 #define NAME "nsc_gpio"
 
@@ -39,62 +41,79 @@ void nsc_gpio_dump(struct nsc_gpio_ops *
 		 amp->gpio_get(index), amp->gpio_current(index));
 }
 
+/* the pin-mode-change 'commands' of the legacy device-file-interface,
+   now refactored for reuse by a (tbd) sysfs-interface.  Includes some
+   updates which arent (currently;-) exposed via sysfs.
+*/
+static int common_write (struct nsc_gpio_ops *amp, char c, unsigned m)
+{
+	struct device *dev = amp->dev;
+	int err = 0;
+	switch (c) {
+	case '0':
+		amp->gpio_set(m, 0);
+		break;
+	case '1':
+		amp->gpio_set(m, 1);
+		break;
+	case 'O':
+		dev_dbg(dev, "GPIO%d output enabled\n", m);
+		amp->gpio_config(m, ~1, 1);
+		break;
+	case 'o':
+		dev_dbg(dev, "GPIO%d output disabled\n", m);
+		amp->gpio_config(m, ~1, 0);
+		break;
+	case 'T':
+		dev_dbg(dev, "GPIO%d output is push pull\n", m);
+		amp->gpio_config(m, ~2, 2);
+		break;
+	case 't':
+		dev_dbg(dev, "GPIO%d output is open drain\n", m);
+		amp->gpio_config(m, ~2, 0);
+		break;
+	case 'P':
+		dev_dbg(dev, "GPIO%d pull up enabled\n", m);
+		amp->gpio_config(m, ~4, 4);
+		break;
+	case 'p':
+		dev_dbg(dev, "GPIO%d pull up disabled\n", m);
+		amp->gpio_config(m, ~4, 0);
+		break;
+
+	case 'v':
+		/* View Current pin settings */
+		amp->gpio_dump(amp, m);
+		break;
+	case 'c':
+		/* view pin's current values: driven and read */
+		dev_info(dev, "io%02d: driven %d, input %d\n",
+		m, amp->gpio_current(m), amp->gpio_get(m));
+		break;
+	case '\n':
+		/* end of settings string, do nothing */
+		break;
+	default:
+		dev_err(dev, "GPIO-%2d bad setting: chr<0x%2x>\n", m,
+		(int)c);
+		err++;
+	}
+	return err;
+}
+
 ssize_t nsc_gpio_write(struct file *file, const char __user *data,
 		       size_t len, loff_t *ppos)
 {
 	unsigned m = iminor(file->f_dentry->d_inode);
 	struct nsc_gpio_ops *amp = file->private_data;
-	struct device *dev = amp->dev;
-	size_t i;
-	int err = 0;
+	int i, err = 0;
 
 	for (i = 0; i < len; ++i) {
 		char c;
 		if (get_user(c, data + i))
 			return -EFAULT;
-		switch (c) {
-		case '0':
-			amp->gpio_set(m, 0);
-			break;
-		case '1':
-			amp->gpio_set(m, 1);
-			break;
-		case 'O':
-			dev_dbg(dev, "GPIO%d output enabled\n", m);
-			amp->gpio_config(m, ~1, 1);
-			break;
-		case 'o':
-			dev_dbg(dev, "GPIO%d output disabled\n", m);
-			amp->gpio_config(m, ~1, 0);
-			break;
-		case 'T':
-			dev_dbg(dev, "GPIO%d output is push pull\n", m);
-			amp->gpio_config(m, ~2, 2);
-			break;
-		case 't':
-			dev_dbg(dev, "GPIO%d output is open drain\n", m);
-			amp->gpio_config(m, ~2, 0);
-			break;
-		case 'P':
-			dev_dbg(dev, "GPIO%d pull up enabled\n", m);
-			amp->gpio_config(m, ~4, 4);
-			break;
-		case 'p':
-			dev_dbg(dev, "GPIO%d pull up disabled\n", m);
-			amp->gpio_config(m, ~4, 0);
-			break;
-		case 'v':
-			/* View Current pin settings */
-			amp->gpio_dump(amp, m);
-			break;
-		case '\n':
-			/* end of settings string, do nothing */
-			break;
-		default:
-			dev_err(dev, "io%2d bad setting: chr<0x%2x>\n",
-				m, (int)c);
-			err++;
-		}
+
+		err += common_write(amp, c, m);
 	}
 	if (err)
 		return -EINVAL;	/* full string handled, report error */
@@ -102,7 +121,7 @@ ssize_t nsc_gpio_write(struct file *file
 	return len;
 }
 
-ssize_t nsc_gpio_read(struct file *file, char __user * buf,
+ssize_t nsc_gpio_read(struct file *file, char __user *buf,
 		      size_t len, loff_t * ppos)
 {
 	unsigned m = iminor(file->f_dentry->d_inode);
@@ -121,8 +140,121 @@ EXPORT_SYMBOL(nsc_gpio_write);
 EXPORT_SYMBOL(nsc_gpio_read);
 EXPORT_SYMBOL(nsc_gpio_dump);
 
+/* now sysfs versions.  We use separate read and write callbacks,
+   which use 2D addressing, on index & nr, to select the bit-numbers
+   and pin-features
+   Slightly complicating things, these declarations must be made in
+   the client modules of this one, ie scx200 & pc8736x _gpio.  They
+   also must set device.driver_data to amp, as thats needed by
+   sysfs_set_value()
+*/
+ssize_t nsc_gpio_sysfs_set(struct device *dev,
+			   struct device_attribute *devattr, const char *buf,
+			   size_t count)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
+	struct nsc_gpio_ops *amp = dev->driver_data;
+
+	int err = common_write(amp, func, idx);
+	if (err)
+		return -EINVAL;	/* full string handled, report error */
+	
+	return strlen(buf);
+}
+
+ssize_t nsc_gpio_sysfs_get(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
+{ 
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
+	unsigned res = -1;
+	u32 config;
+	struct nsc_gpio_ops *amp = dev->driver_data;
+
+	if (!amp) {
+		dev_err(dev, "nsc_gpio_sysfs_get(), no amp\n");
+		return 0;
+	}
+	/* fetch value - fast path */
+	if (func == 'V') {
+		res = amp->gpio_get(idx);
+		dev_warn(dev, "nsc_gpio_sysfs_get(V) = %d\n", res);
+		return sprintf(buf, "%u\n", !!res);
+	}
+
+	config = amp->gpio_config(idx, ~0, 0);
+
+	dev_dbg(dev, "nsc_gpio_sysfs_get(), bitconf=%02x, cmd='%c'\n",
+		config, func);
+
+	switch ((char)func) {
+	case 'V':
+		dev_warn(dev, "shouldnt get here (V) = %d, %d\n", res, config);
+		break;
+	case 'O':
+		res = config & 1;
+		break;
+	case 'P':
+		res = config & 2;
+		break;
+	case 'T':
+		res = config & 4;
+		break;
+	case 'L':
+		res = config & 8;
+		break;
+	case 'D':
+		res = config & PF_DEBOUNCE;
+		break;
+
+	default:
+		dev_err(dev, "unknown cmd '%c'\n", func);
+	}
+	dev_dbg(dev, "bit[%d].cmd('%c')\n", idx, func);
+
+	return sprintf(buf, "%u\n", !!res);
+}
+
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_get);
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_set);
+
+void nsc_gpio_sysfs_port_init(struct device* dev,
+			      struct gpio_attributes pp[],
+			      int numdevs)
+{
+	int i, err = 0;
+
+	for (i = 0; i < numdevs; i++) {
+
+		err = device_create_file(dev, &pp[i].value.dev_attr);
+		if (err) dev_err(dev, "got err %d\n", err);
+
+		err = device_create_file(dev, &pp[i].output_enabled.dev_attr);
+		if (err) dev_err(dev, "got err %d\n", err);
+
+		err = device_create_file(dev, &pp[i].pullup_enabled.dev_attr);
+		if (err) dev_err(dev, "got err %d\n", err);
+
+		err = device_create_file(dev, &pp[i].totem_pole.dev_attr);
+		if (err) dev_err(dev, "got err %d\n", err);
+
+		err = device_create_file(dev, &pp[i].locked.dev_attr);
+		if (err) dev_err(dev, "got err %d\n", err);
+
+		err = device_create_file(dev, &pp[i].debounced.dev_attr);
+		if (err) dev_err(dev, "got err %d\n", err);
+
+	}
+}
+
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_port_init);
+
 static int __init nsc_gpio_init(void)
 {
+	// struct device *dev;
 	printk(KERN_DEBUG NAME " initializing\n");
 	return 0;
 }
diff -ruNp -X dontdiff -X exclude-diffs ag-0/drivers/char/pc8736x_gpio.c ag-1/drivers/char/pc8736x_gpio.c
--- ag-0/drivers/char/pc8736x_gpio.c	2006-07-15 01:08:50.000000000 -0600
+++ ag-1/drivers/char/pc8736x_gpio.c	2006-07-18 09:21:19.000000000 -0600
@@ -18,6 +18,8 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/mutex.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
@@ -32,6 +34,14 @@ static int major;		/* default to dynamic
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
+static int nobits = 0;
+module_param(nobits, int, 0);
+MODULE_PARM_DESC(nobits, "nobits=1 to suppress sysfs bits interface");
+
+static int noports = 0;
+module_param(noports, int, 0);
+MODULE_PARM_DESC(noports, "noports=1 to supress sysfs ports interface");
+
 static DEFINE_MUTEX(pc8736x_gpio_config_lock);
 static unsigned pc8736x_gpio_base;
 static u8 pc8736x_gpio_shadow[4];
@@ -144,7 +154,7 @@ static u32 pc8736x_gpio_configure(unsign
 					 SIO_GPIO_PIN_CONFIG);
 }
 
-static int pc8736x_gpio_get(unsigned minor)
+static u32 pc8736x_gpio_get(unsigned minor)
 {
 	int port, bit, val;
 
@@ -188,16 +198,6 @@ static void pc8736x_gpio_set(unsigned mi
 	pc8736x_gpio_shadow[port] = val;
 }
 
-static void pc8736x_gpio_set_high(unsigned index)
-{
-	pc8736x_gpio_set(index, 1);
-}
-
-static void pc8736x_gpio_set_low(unsigned index)
-{
-	pc8736x_gpio_set(index, 0);
-}
-
 static int pc8736x_gpio_current(unsigned minor)
 {
 	int port, bit;
@@ -212,6 +212,37 @@ static void pc8736x_gpio_change(unsigned
 	pc8736x_gpio_set(index, !pc8736x_gpio_current(index));
 }
 
+static u32 pc8736x_gpio_get_port(unsigned port)
+{
+	u8 val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
+
+	dev_dbg(&pdev->dev, "_gpio_get(%d from %x) == val %d\n",
+		port, pc8736x_gpio_base + port_offset[port] + PORT_IN,
+		val);
+
+	return (u32)val;
+}
+
+static void pc8736x_gpio_set_port(unsigned port, u32 bits, u32 mask)
+{
+	u8 val;
+	u8 curval = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+
+	val = (curval & ~mask) | (bits & mask);
+
+	dev_dbg(&pdev->dev, "gpio_set(port:%d addr:%x cur:%x new:%d)\n",
+		port, pc8736x_gpio_base + port_offset[port] + PORT_OUT,
+		curval, val);
+
+	outb_p(val, pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+
+	curval = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+	val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
+
+	dev_dbg(&pdev->dev, "wrote %x, read: %x\n", curval, val);
+	pc8736x_gpio_shadow[port] = val;
+}
+
 static struct nsc_gpio_ops pc8736x_gpio_ops = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= pc8736x_gpio_configure,
@@ -219,7 +250,9 @@ static struct nsc_gpio_ops pc8736x_gpio_
 	.gpio_get	= pc8736x_gpio_get,
 	.gpio_set	= pc8736x_gpio_set,
 	.gpio_change	= pc8736x_gpio_change,
-	.gpio_current	= pc8736x_gpio_current
+	.gpio_current	= pc8736x_gpio_current,
+	.gpio_get_port	= pc8736x_gpio_get_port,
+	.gpio_set_port	= pc8736x_gpio_set_port,
 };
 EXPORT_SYMBOL(pc8736x_gpio_ops);
 
@@ -242,16 +275,52 @@ static const struct file_operations pc87
 	.read	= nsc_gpio_read,
 };
 
+static struct gpio_attributes port0[] = {
+	GPIO_ATTRS(0,0), GPIO_ATTRS(0,1), GPIO_ATTRS(0,2), GPIO_ATTRS(0,3),
+	GPIO_ATTRS(0,4), GPIO_ATTRS(0,5), GPIO_ATTRS(0,6), GPIO_ATTRS(0,7)
+};
+static struct gpio_attributes port1[] = {
+	GPIO_ATTRS(1,0), GPIO_ATTRS(1,1), GPIO_ATTRS(1,2), GPIO_ATTRS(1,3),
+	GPIO_ATTRS(1,4), GPIO_ATTRS(1,5), GPIO_ATTRS(1,6), GPIO_ATTRS(1,7)
+};
+static struct gpio_attributes port2[] = {
+	GPIO_ATTRS(2,0), GPIO_ATTRS(2,1), GPIO_ATTRS(2,2), GPIO_ATTRS(2,3),
+	GPIO_ATTRS(2,4), GPIO_ATTRS(2,5), GPIO_ATTRS(2,6), GPIO_ATTRS(2,7)
+};
+static struct gpio_attributes port3[] = {
+	GPIO_ATTRS(3,0), GPIO_ATTRS(3,1), GPIO_ATTRS(3,2), GPIO_ATTRS(3,3),
+	GPIO_ATTRS(3,4), GPIO_ATTRS(3,5), GPIO_ATTRS(3,6), GPIO_ATTRS(3,7)
+};
+
+static struct gpio_attributes ports[] = {
+	GPIO_PORT_ATTRS(0), GPIO_PORT_ATTRS(1),
+	GPIO_PORT_ATTRS(2), GPIO_PORT_ATTRS(3),
+};
+
+static void __init pc8736x_sysfs_init(struct device* dev)
+{
+	dev_info(dev, "pc8736x_sysfs_init creating pin-attr nodes\n");
+	if (!nobits) {
+		nsc_gpio_sysfs_port_init(&pdev->dev, port0, 8);
+		nsc_gpio_sysfs_port_init(&pdev->dev, port1, 8);
+		nsc_gpio_sysfs_port_init(&pdev->dev, port2, 8);
+		nsc_gpio_sysfs_port_init(&pdev->dev, port3, 8);
+	}
+	if (!noports) {
+		dev_info(dev, "creating gpio port-attrs\n");
+		nsc_gpio_sysfs_port_init(&pdev->dev, ports, 4);
+	}
+}
+
 static void __init pc8736x_init_shadow(void)
 {
 	int port;
-
+	
 	/* read the current values driven on the GPIO signals */
 	for (port = 0; port < 4; ++port)
 		pc8736x_gpio_shadow[port]
-		    = inb_p(pc8736x_gpio_base + port_offset[port]
-			    + PORT_OUT);
-
+			= inb_p(pc8736x_gpio_base + port_offset[port]
+				+ PORT_OUT);
 }
 
 static struct cdev pc8736x_gpio_cdev;
@@ -330,6 +399,11 @@ static int __init pc8736x_gpio_init(void
 	cdev_init(&pc8736x_gpio_cdev, &pc8736x_gpio_fileops);
 	cdev_add(&pc8736x_gpio_cdev, devid, PC8736X_GPIO_CT);
 
+	pc8736x_sysfs_init(&pdev->dev);
+
+	/* provide info wheresysfs callbacks can get them */
+	pc8736x_gpio_ops.dev->driver_data = &pc8736x_gpio_ops;
+
 	return 0;
 
 undo_request_region:
diff -ruNp -X dontdiff -X exclude-diffs ag-0/drivers/char/scx200_gpio.c ag-1/drivers/char/scx200_gpio.c
--- ag-0/drivers/char/scx200_gpio.c	2006-07-15 01:08:50.000000000 -0600
+++ ag-1/drivers/char/scx200_gpio.c	2006-07-18 09:21:25.000000000 -0600
@@ -33,6 +33,14 @@ static int major = 0;		/* default to dyn
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
+static int nobits = 0;
+module_param(nobits, int, 0);
+MODULE_PARM_DESC(nobits, "nobits=1 to suppress sysfs bits interface");
+
+static int noports = 0;
+module_param(noports, int, 0);
+MODULE_PARM_DESC(noports, "noports=1 to supress sysfs ports interface");
+
 #define MAX_PINS 32		/* 64 later, when known ok */
 
 struct nsc_gpio_ops scx200_gpio_ops = {
@@ -42,9 +50,11 @@ struct nsc_gpio_ops scx200_gpio_ops = {
 	.gpio_get	= scx200_gpio_get,
 	.gpio_set	= scx200_gpio_set,
 	.gpio_change	= scx200_gpio_change,
-	.gpio_current	= scx200_gpio_current
+	.gpio_current	= scx200_gpio_current,
+	.gpio_get_port	= scx200_gpio_get_port,
+	.gpio_set_port	= scx200_gpio_set_port,
 };
-EXPORT_SYMBOL(scx200_gpio_ops);
+EXPORT_SYMBOL_GPL(scx200_gpio_ops);
 
 static int scx200_gpio_open(struct inode *inode, struct file *file)
 {
@@ -69,7 +79,45 @@ static const struct file_operations scx2
 	.release = scx200_gpio_release,
 };
 
-struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
+static struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
+
+/* insert sysfs decl and init-func here */
+static struct gpio_attributes port0[] = {
+	GPIO_ATTRS(0,0), GPIO_ATTRS(0,1), GPIO_ATTRS(0,2), GPIO_ATTRS(0,3),
+	GPIO_ATTRS(0,4), GPIO_ATTRS(0,5), GPIO_ATTRS(0,6), GPIO_ATTRS(0,7),
+	GPIO_ATTRS(0,8), GPIO_ATTRS(0,9), GPIO_ATTRS(0,10), GPIO_ATTRS(0,11),
+	GPIO_ATTRS(0,12), GPIO_ATTRS(0,13), GPIO_ATTRS(0,14), GPIO_ATTRS(0,15),
+
+	GPIO_ATTRS(0,16), GPIO_ATTRS(0,17), GPIO_ATTRS(0,18), GPIO_ATTRS(0,19),
+	GPIO_ATTRS(0,20), GPIO_ATTRS(0,21), GPIO_ATTRS(0,22), GPIO_ATTRS(0,23),
+	GPIO_ATTRS(0,24), GPIO_ATTRS(0,25), GPIO_ATTRS(0,26), GPIO_ATTRS(0,27),
+	GPIO_ATTRS(0,28), GPIO_ATTRS(0,29), GPIO_ATTRS(0,30), GPIO_ATTRS(0,31),
+};
+
+static struct gpio_attributes port1[] = {
+	GPIO_ATTRS(1,0), GPIO_ATTRS(1,1), GPIO_ATTRS(1,2), GPIO_ATTRS(1,3),
+	GPIO_ATTRS(1,4), GPIO_ATTRS(1,5), GPIO_ATTRS(1,6), GPIO_ATTRS(1,7),
+	GPIO_ATTRS(1,8), GPIO_ATTRS(1,9), GPIO_ATTRS(1,10), GPIO_ATTRS(1,11),
+	GPIO_ATTRS(1,12), GPIO_ATTRS(1,13), GPIO_ATTRS(1,14), GPIO_ATTRS(1,15),
+
+	GPIO_ATTRS(1,16), GPIO_ATTRS(1,17), GPIO_ATTRS(1,18), GPIO_ATTRS(1,19),
+	GPIO_ATTRS(1,20), GPIO_ATTRS(1,21), GPIO_ATTRS(1,22), GPIO_ATTRS(1,23),
+	GPIO_ATTRS(1,24), GPIO_ATTRS(1,25), GPIO_ATTRS(1,26), GPIO_ATTRS(1,27),
+	GPIO_ATTRS(1,28), GPIO_ATTRS(1,29), GPIO_ATTRS(1,30), GPIO_ATTRS(1,31),
+};
+static struct gpio_attributes ports[] = {
+	GPIO_PORT_ATTRS(0), GPIO_PORT_ATTRS(1),
+};
+
+static void __init scx200_sysfs_init(struct device* dev)
+{
+	if (!nobits) {
+		nsc_gpio_sysfs_port_init(dev, port0, 32);
+		nsc_gpio_sysfs_port_init(dev, port1, 32);
+	}
+	if (!noports)
+		nsc_gpio_sysfs_port_init(dev, ports, 2);
+}
 
 static int __init scx200_gpio_init(void)
 {
@@ -92,6 +140,7 @@ static int __init scx200_gpio_init(void)
 
 	/* nsc_gpio uses dev_dbg(), so needs this */
 	scx200_gpio_ops.dev = &pdev->dev;
+	scx200_gpio_ops.dev->driver_data = &scx200_gpio_ops;
 
 	if (major) {
 		devid = MKDEV(major, 0);
@@ -108,6 +157,8 @@ static int __init scx200_gpio_init(void)
 	cdev_init(&scx200_gpio_cdev, &scx200_gpio_fileops);
 	cdev_add(&scx200_gpio_cdev, devid, MAX_PINS);
 
+	scx200_sysfs_init(&pdev->dev);
+
 	return 0; /* succeed */
 
 undo_platform_device_add:
diff -ruNp -X dontdiff -X exclude-diffs ag-0/drivers/leds/leds-net48xx.c ag-1/drivers/leds/leds-net48xx.c
--- ag-0/drivers/leds/leds-net48xx.c	2006-07-15 01:08:58.000000000 -0600
+++ ag-1/drivers/leds/leds-net48xx.c	2006-07-17 13:28:49.000000000 -0600
@@ -16,6 +16,7 @@
 #include <linux/leds.h>
 #include <linux/err.h>
 #include <asm/io.h>
+#include <linux/nsc_gpio.h>
 #include <linux/scx200_gpio.h>
 
 #define DRVNAME "net48xx-led"
@@ -26,10 +27,7 @@ static struct platform_device *pdev;
 static void net48xx_error_led_set(struct led_classdev *led_cdev,
 		enum led_brightness value)
 {
-	if (value)
-		scx200_gpio_set_high(NET48XX_ERROR_LED_GPIO);
-	else
-		scx200_gpio_set_low(NET48XX_ERROR_LED_GPIO);
+	scx200_gpio_ops.gpio_set(NET48XX_ERROR_LED_GPIO, value ? 1 : 0);
 }
 
 static struct led_classdev net48xx_error_led = {
@@ -81,7 +79,8 @@ static int __init net48xx_led_init(void)
 {
 	int ret;
 
-	if (!scx200_gpio_present()) {
+	/* small hack, but scx200_gpio doesn't set .dev if the probe fails */
+	if (!scx200_gpio_ops.dev) {
 		ret = -ENODEV;
 		goto out;
 	}
diff -ruNp -X dontdiff -X exclude-diffs ag-0/include/linux/nsc_gpio.h ag-1/include/linux/nsc_gpio.h
--- ag-0/include/linux/nsc_gpio.h	2006-07-15 01:09:44.000000000 -0600
+++ ag-1/include/linux/nsc_gpio.h	2006-07-18 09:17:30.000000000 -0600
@@ -1,6 +1,4 @@
 /**
-   nsc_gpio.c
-
    National Semiconductor GPIO common access methods.
 
    struct nsc_gpio_ops abstracts the low-level access
@@ -19,17 +17,31 @@
    NSC sold the GEODE line to AMD, and the PC-8736x line to Winbond.
 */
 
+/* pin-feature to config-bit mapping is common to both chips
+   some ports' pins dont support upper nibble ops.
+*/
+#define PF_OUTPUT_ENA		1	/* !tristate */
+#define PF_TOTEM		2	/* !open-drain */
+#define PF_PULLUP		4
+#define PF_LOCKED		8
+#define PF_INTERRUPT_ENA	16
+#define PF_INTERRUPT_TGR	32
+#define PF_DEBOUNCE		64
+
 struct nsc_gpio_ops {
 	struct module*	owner;
-	u32	(*gpio_config)	(unsigned iminor, u32 mask, u32 bits);
-	void	(*gpio_dump)	(struct nsc_gpio_ops *amp, unsigned iminor);
-	int	(*gpio_get)	(unsigned iminor);
-	void	(*gpio_set)	(unsigned iminor, int state);
-	void	(*gpio_change)	(unsigned iminor);
-	int	(*gpio_current)	(unsigned iminor);
-	struct device*	dev;	/* for dev_dbg() support, set in init  */
+	u32	(*gpio_config)		(unsigned iminor, u32 mask, u32 bits);
+	void	(*gpio_dump)		(struct nsc_gpio_ops *amp, unsigned iminor);
+	u32	(*gpio_get)		(unsigned iminor);
+	void	(*gpio_set)		(unsigned iminor, int state);
+	void	(*gpio_change)		(unsigned iminor);
+	int	(*gpio_current)		(unsigned iminor);
+	u32	(*gpio_get_port)	(unsigned port);
+	void	(*gpio_set_port)	(unsigned port, u32 bits, u32 mask);
+	struct device*	dev;		/* for dev_dbg() support */
 };
 
+/* fileops routines */
 extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
 			      size_t len, loff_t *ppos);
 
@@ -38,3 +50,95 @@ extern ssize_t nsc_gpio_read(struct file
 
 extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index);
 
+
+/* the 'bits' sysfs interface uses a single/combo callback function
+   which does 2D indexing; on index & nr, selecting bit number and
+   pin-feature/attribute
+*/
+extern ssize_t nsc_gpio_sysfs_get(struct device *dev,
+				  struct device_attribute *devattr,
+				  char *buf);
+
+extern ssize_t nsc_gpio_sysfs_set(struct device *dev,
+				  struct device_attribute *devattr,
+				  const char *buf, size_t count);
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+struct gpio_attributes {
+	struct sensor_device_attribute_2 value;
+	struct sensor_device_attribute_2 curr;
+	struct sensor_device_attribute_2 output_enabled;
+	struct sensor_device_attribute_2 totem_pole;
+	struct sensor_device_attribute_2 pullup_enabled;
+	struct sensor_device_attribute_2 debounced;
+	struct sensor_device_attribute_2 locked;
+};
+
+#define GPIO_PIN(_grp, _idx, _pre, _post, _mode, _show, _store, _nr)	\
+	{	.dev_attr = __ATTR(_pre## _grp._idx ##_post,		\
+				   _mode, _show, _store),		\
+		.index = _idx, .nr = _nr }
+
+#define GPIO_ATTR(Portnum, Bitnum, FnSym, AttrNm)	\
+	GPIO_PIN(Portnum, Bitnum, bit_, AttrNm,		\
+		 S_IWUSR | S_IRUGO,			\
+		 nsc_gpio_sysfs_get, nsc_gpio_sysfs_set, FnSym )
+
+/* The original scx200_gpio driver accessed pins via device-files.
+   and set pin features in response to command-strings written to it.
+*/
+#define PIN_VAL(Port, Bit)	GPIO_ATTR(Port, Bit, 'V', _value)
+#define PIN_CURR(Port, Bit)	GPIO_ATTR(Port, Bit, 'C', _current_output)
+#define PIN_OE(Port, Bit)	GPIO_ATTR(Port, Bit, 'O', _output_enabled)
+#define PIN_PUE(Port, Bit)	GPIO_ATTR(Port, Bit, 'P', _pullup_enabled)
+#define PIN_PP(Port, Bit)	GPIO_ATTR(Port, Bit, 'T', _totem)
+#define PIN_LOCKED(Port, Bit)	GPIO_ATTR(Port, Bit, 'L', _locked)
+#define PIN_DEBOUNCE(Port, Bit)	GPIO_ATTR(Port, Bit, 'D', _debounced)
+
+/* initializer for bits, ie pin arrays */
+#define GPIO_ATTRS(Port, Idx) {			\
+	.value		= PIN_VAL(Port, Idx),	\
+	.curr		= PIN_CURR(Port, Idx),	\
+	.output_enabled	= PIN_OE(Port, Idx),	\
+	.pullup_enabled	= PIN_PUE(Port, Idx),	\
+	.totem_pole	= PIN_PP(Port, Idx),	\
+	.locked		= PIN_LOCKED(Port, Idx), \
+	.debounced	= PIN_DEBOUNCE(Port, Idx) }
+
+extern void nsc_gpio_sysfs_port_init(struct device* dev,
+				     struct gpio_attributes pp[],
+				     int numdevs);
+
+
+
+/* port-wide sysfs access */
+
+#define GPIO_PORT(_grp, _pre, _post, _mode, _show, _store, _nr)	\
+	{	.dev_attr = __ATTR(_pre## _grp ##_post,		\
+				   _mode, _show, _store),	\
+		.index = _grp, .nr = _nr }
+
+#define GPIO_PORT_ATTR(Portnum, FnSym, AttrNm)	\
+	GPIO_PORT(Portnum, port_, AttrNm,	\
+		  S_IWUSR | S_IRUGO,		\
+		  nsc_gpio_sysfs_get, nsc_gpio_sysfs_set, FnSym )
+
+#define PORT_VAL(Port)		GPIO_PORT_ATTR(Port, 'V', _value)
+#define PORT_CURR(Port)		GPIO_PORT_ATTR(Port, 'C', _current_output)
+#define PORT_OE(Port)		GPIO_PORT_ATTR(Port, 'O', _output_enabled)
+#define PORT_PUE(Port)		GPIO_PORT_ATTR(Port, 'P', _pullup_enabled)
+#define PORT_PP(Port)		GPIO_PORT_ATTR(Port, 'T', _totem)
+#define PORT_LOCKED(Port)	GPIO_PORT_ATTR(Port, 'L', _locked)
+#define PORT_DEBOUNCE(Port)	GPIO_PORT_ATTR(Port, 'D', _debounced)
+
+#define GPIO_PORT_ATTRS(Port) {			\
+	.value		= PORT_VAL(Port),	\
+	.curr		= PORT_CURR(Port),	\
+	.output_enabled	= PORT_OE(Port),	\
+	.pullup_enabled	= PORT_PUE(Port),	\
+	.totem_pole	= PORT_PP(Port),	\
+	.locked		= PORT_LOCKED(Port),	\
+	.debounced	= PORT_DEBOUNCE(Port) }
+
diff -ruNp -X dontdiff -X exclude-diffs ag-0/include/linux/scx200_gpio.h ag-1/include/linux/scx200_gpio.h
--- ag-0/include/linux/scx200_gpio.h	2006-07-06 13:20:28.000000000 -0600
+++ ag-1/include/linux/scx200_gpio.h	2006-07-17 23:04:38.000000000 -0600
@@ -4,6 +4,7 @@ u32 scx200_gpio_configure(unsigned index
 
 extern unsigned scx200_gpio_base;
 extern long scx200_gpio_shadow[2];
+extern struct nsc_gpio_ops scx200_gpio_ops;
 
 #define scx200_gpio_present() (scx200_gpio_base!=0)
 
@@ -82,6 +83,26 @@ static inline void scx200_gpio_change(un
 	__SCx200_GPIO_OUT;
 }
 
+/* return the value of a whole port (bank) */
+static inline u32 scx200_gpio_get_port(unsigned port)
+{
+	unsigned bank = port & 0x1f;
+	__SCx200_GPIO_IOADDR + 0x04;
+	
+	return inl(ioaddr);
+}
+
+/* return the value of a whole port (bank) */
+static inline void scx200_gpio_set_port(unsigned port, u32 bits, u32 mask)
+{
+	unsigned bank = port & 0x1f;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	*shadow = (*shadow & ~mask) | (bits & mask);
+	__SCx200_GPIO_OUT;
+}
+
+
 #undef __SCx200_GPIO_BANK
 #undef __SCx200_GPIO_IOADDR
 #undef __SCx200_GPIO_SHADOW


