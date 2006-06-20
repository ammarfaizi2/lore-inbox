Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWFTT51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWFTT51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWFTT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:57:27 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:26064 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750848AbWFTT50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:57:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hGIYH08QGjpVFLQmyc/Br5l9aUJISGKSDYynAFVavIfaftJErNE+2PsVc3Ws2CaIJqAgpU3eNmw8y5paGChmkEWlLjGXC0QPtGq9wX6mS4Ztt1JOmAqk0FOAggDpEYImUi2Un/EWHGHAR/5ugzV6Da1JDV2z/mMvavoapMfIJqs=
Message-ID: <44985321.3020609@gmail.com>
Date: Tue, 20 Jun 2006 13:57:21 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 20/20 RFC] chardev: GPIO for SCx200 & PC-8736x: add
 sysfs-GPIO interface
References: <448DB57F.2050006@gmail.com>	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>	<44944D14.2000308@gmail.com> <20060619222223.8f5133a9.akpm@osdl.org>
In-Reply-To: <20060619222223.8f5133a9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 17 Jun 2006 12:42:28 -0600
> Jim Cromie <jim.cromie@gmail.com> wrote:
>
>   
>> Ok, 
>>
>> heres the brand-spanking-new proto-sysfs-gpio interface,
>> preceded by some pseudo/proto-Documentation.
>>
>>     
>
> Well I stuck it in -mm anyway.  Let's see what happens.
>   
Im clearly benefiting from the new streamlined inclusion process :-)
> We don't have a Signed-off-by: for this patch.
>   

Heres a better version
- with signoff
- the pc8736x_gpio driver now creates the port_[0-3]_<suffix>  sysfs-files.
    the setter is stubbed, the getter works for the port Values *only*
    the other port-wide attrs must be assembled by looping over the 
bit-configs
- it applies on what I sent,
- if its too late, or kicks out any rejects against your version, Ill 
repost a fresh one against 17-mm1
- its still pretty rough - so // marks *some* of the rough spots.
    theres some dissonance wrt port-wide access and common-write, which 
is for bits originally/still.
- its too big (but then so was the other one ;-) Ill chop it up into 
smaller chunks soon.

- sorry about the leading-spaces crap in some of the earlier patches,
    I now know that cut/paste mangles the tabs.

- Ill send a proper doc patch soon, post -mm1
    Hopefully, the prose youve got now will draw comments, and I can fix 
b4 sending.

> Fixup patches agains next -mm would be suitable.  Please keep them
> super-short: basically one-patch-per-review-comment.  That way I can easily
> instertion-sort the patches into place and we retain a nice patch series.
>
>   
OK.  Just so Im clear, Ill patch against the tail of the set (ie -mm1), 
and you'll push them forward into the
series as close as possible to where the blunder was made ?  (and less 
close for conflicts )
>> Ive
>>     
>
> Apostrophe aversion?
>   

Its PFL.  Its also IMO a trend in the language.  "Its" (the contraction) 
has dropped the '
IIUC, its (with the apostrophe) now only for possession, forex: Its 
bigger than the sum of it's parts.
Im just taking that to excess, everywhere its applicable ;-)

---

Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

$ diffstat diff.sys-gpio-rollup-2.2
 drivers/char/nsc_gpio.c     |  265 ++++++++++++++++++++++++++++++++++++--------
 drivers/char/pc8736x_gpio.c |  153 +++++++++++++++++++++----
 drivers/char/scx200_gpio.c  |   47 +++++++
 include/linux/nsc_gpio.h    |  116 ++++++++++++++++++-
 include/linux/scx200_gpio.h |   50 +++++++-
 5 files changed, 550 insertions(+), 81 deletions(-)


diff -ruNp -X dontdiff -X exclude-diffs az-1/drivers/char/nsc_gpio.c az-2/drivers/char/nsc_gpio.c
--- az-1/drivers/char/nsc_gpio.c	2006-06-18 13:14:52.000000000 -0600
+++ az-2/drivers/char/nsc_gpio.c	2006-06-20 12:36:40.000000000 -0600
@@ -13,6 +13,8 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
@@ -39,12 +41,68 @@ void nsc_gpio_dump(struct nsc_gpio_ops *
 		 amp->gpio_get(index), amp->gpio_current(index));
 }
 
+/* the pin-mode-change 'commands' of the legacy device-file-interface,
+   refactored for reuse in a sysfs-interface.  Includes some updates
+   which arent exposed via sysfs attributes.
+*/
+static int common_write(struct nsc_gpio_ops *amp, unsigned m, char c)
+{
+	struct device *dev = amp->dev;
+	int err = 0;
+
+	switch (c) {
+	case 0:
+	case '0':
+		amp->gpio_set(m, 0);
+		break;
+	case 1:
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
+	case 'v':
+		/* View Current pin settings */
+		amp->gpio_dump(amp, m);
+		break;
+	case '\n':
+		/* end of settings string, do nothing */
+		break;
+	default:
+		dev_err(dev, "io%2d bad setting: chr<0x%2x>\n",
+			m, (int)c);
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
 	size_t i;
 	int err = 0;
 
@@ -52,51 +110,8 @@ ssize_t nsc_gpio_write(struct file *file
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
-			dev_dbg(dev, "GPIO%d output is push pull\n",
-			       m);
-			amp->gpio_config(m, ~2, 2);
-			break;
-		case 't':
-			dev_dbg(dev, "GPIO%d output is open drain\n",
-			       m);
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
+		err += common_write(amp, m, c);
 	}
 	if (err)
 		return -EINVAL;	/* full string handled, report error */
@@ -123,6 +138,164 @@ EXPORT_SYMBOL(nsc_gpio_write);
 EXPORT_SYMBOL(nsc_gpio_read);
 EXPORT_SYMBOL(nsc_gpio_dump);
 
+
+/* now sysfs versions.  We use 2D addressing, using struct
+   sensor_device_attribute_2's .index and .nr members, which specifies
+   the bit's index and attribute respectively.
+*/
+ssize_t nsc_gpio_sysfs_set(struct device *dev,
+			   struct device_attribute *devattr, const char *buf,
+			   size_t count)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	int val, err = 0;
+
+	val = simple_strtol(buf, NULL, 10);
+	switch (val) {
+	case 0:
+	case 1:
+		err = common_write(amp, val, idx);
+		break;
+	default:
+		dev_err(dev, "illegal val %d %c\n", val, func);
+	}
+
+	if (err)
+		return -EINVAL;	// full string handled, report error
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
+	config = amp->gpio_config(idx, ~0, 0);
+
+	dev_dbg(dev, "nsc_gpio_sysfs_get(), bitconf=%02x, cmd='%c'\n",
+		config, func);
+
+	switch ((char)func) {
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
+        default:
+                dev_err(dev, "unknown cmd '%c' %d\n", func, func);
+        }
+	dev_dbg(dev, "bit[%d].cmd('%c')\n", idx, func);
+
+        return sprintf(buf, "%u\n", !!res);
+}
+
+EXPORT_SYMBOL(nsc_gpio_sysfs_get);
+EXPORT_SYMBOL(nsc_gpio_sysfs_set);
+
+
+/* The port-wide sysfs callbacks are more complicated; for all but
+   '_value' attribute, they must assemble the return value by looping
+   over all bits, and collecting the attr-val from each.
+
+   ATM, cheat, and just implement _value getter.
+   The setter is stubbed out
+*/
+
+ssize_t nsc_gpio_port_sysfs_set(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	int err = 0, val;
+
+	val = simple_strtol(buf, NULL, 20);
+	dev_warn(dev, "TODO: set port%d func:%c val:0x%x\n", idx, func, val);
+
+	// err = common_write(amp, val, idx);
+	if (err)
+		return -EINVAL;
+	
+	return strlen(buf);
+}
+
+ssize_t nsc_gpio_port_sysfs_get(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+	int idx = attr->index;
+	int func = attr->nr;
+	unsigned res = -1;
+	u32 config;
+	struct nsc_gpio_ops *amp = dev->driver_data;
+
+	if (!amp) {
+		dev_err(dev, "nsc_gpio_port_sysfs_get(), no amp\n");
+		return 0;
+	}
+
+	// config = amp[1]->gpio_config(idx, ~0, 0);
+
+	dev_info(dev, "nsc_gpio_port_sysfs_get: cmd='%c' access %p\n",
+		 func, amp[1]);
+
+	switch ((char)func) {
+	case 'V':
+		/* read port */
+		res = amp[1].gpio_get(idx);
+		dev_info(dev, "nsc_gpio_port_sysfs_get: %x\n", res);
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
+        default:
+                dev_err(dev, "unknown cmd '%c' %d\n", func, func);
+        }
+	dev_info(dev, "port[%d].cmd('%c') = %x\n", idx, func, res);
+
+        return sprintf(buf, "%x\n", res);
+}
+
+EXPORT_SYMBOL(nsc_gpio_port_sysfs_get);
+EXPORT_SYMBOL(nsc_gpio_port_sysfs_set);
+
 static int __init nsc_gpio_init(void)
 {
 	printk(KERN_DEBUG NAME " initializing\n");
diff -ruNp -X dontdiff -X exclude-diffs az-1/drivers/char/pc8736x_gpio.c az-2/drivers/char/pc8736x_gpio.c
--- az-1/drivers/char/pc8736x_gpio.c	2006-06-18 13:14:52.000000000 -0600
+++ az-2/drivers/char/pc8736x_gpio.c	2006-06-18 21:04:23.000000000 -0600
@@ -17,6 +17,8 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/mutex.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
@@ -144,16 +146,52 @@ static u32 pc8736x_gpio_configure(unsign
 					 SIO_GPIO_PIN_CONFIG);
 }
 
-static int pc8736x_gpio_get(unsigned minor)
+/* port access */
+static unsigned pc8736x_gpio_port_get(unsigned port)
 {
-	int port, bit, val;
+	unsigned res =  inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
+	dev_dbg(&pdev->dev, "pc8736x_gpio_port_get(%d) => %x\n", port, res);
+	return res;
+}
 
-	port = minor >> 3;
-	bit = minor & 7;
-	val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
+static void pc8736x_gpio_port_set(unsigned port, unsigned val)
+{
+	pc8736x_gpio_shadow[port] = val;
+	outb_p(val, pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+}
+
+static unsigned pc8736x_gpio_port_current(unsigned port)
+{
+	return inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+}
+
+static void pc8736x_gpio_port_set_high(unsigned port)
+{
+	pc8736x_gpio_port_set(port, 0xFF);
+}
+
+static void pc8736x_gpio_port_set_low(unsigned port)
+{
+	pc8736x_gpio_port_set(port, 0);
+}
+
+static void pc8736x_gpio_port_change(unsigned index)
+{
+	pc8736x_gpio_port_set(index, !pc8736x_gpio_port_current(index));
+}
+
+
+/* bit access, uses port accessors */
+
+static unsigned pc8736x_gpio_get(unsigned minor)
+{
+	int port = minor >> 3;
+	int bit = minor & 7;
+	unsigned val;
+
+	val = pc8736x_gpio_port_get(port);
 	val >>= bit;
 	val &= 1;
-
 	dev_dbg(&pdev->dev, "_gpio_get(%d from %x bit %d) == val %d\n",
 		minor, pc8736x_gpio_base + port_offset[port] + PORT_IN, bit,
 		val);
@@ -161,14 +199,15 @@ static int pc8736x_gpio_get(unsigned min
 	return val;
 }
 
-static void pc8736x_gpio_set(unsigned minor, int val)
+static void pc8736x_gpio_set(unsigned minor, unsigned val)
 {
 	int port, bit, curval;
 
 	minor &= 0x1f;
 	port = minor >> 3;
 	bit = minor & 7;
-	curval = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+
+	curval = pc8736x_gpio_port_current(port);
 
 	dev_dbg(&pdev->dev, "addr:%x cur:%x bit-pos:%d cur-bit:%x + new:%d -> bit-new:%d\n",
 		pc8736x_gpio_base + port_offset[port] + PORT_OUT,
@@ -179,7 +218,9 @@ static void pc8736x_gpio_set(unsigned mi
 	dev_dbg(&pdev->dev, "gpio_set(minor:%d port:%d bit:%d)"
 		" %2x -> %2x\n", minor, port, bit, curval, val);
 
-	outb_p(val, pc8736x_gpio_base + port_offset[port] + PORT_OUT);
+	pc8736x_gpio_port_set(port, val);
+
+	curval = pc8736x_gpio_port_current(port);
 
 	curval = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_OUT);
 	val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
@@ -198,7 +239,7 @@ static void pc8736x_gpio_set_low(unsigne
 	pc8736x_gpio_set(index, 0);
 }
 
-static int pc8736x_gpio_current(unsigned minor)
+static unsigned pc8736x_gpio_current(unsigned minor)
 {
 	int port, bit;
 	minor &= 0x1f;
@@ -214,16 +255,29 @@ static void pc8736x_gpio_change(unsigned
 
 extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned iminor);
 
-static struct nsc_gpio_ops pc8736x_access = {
-	.owner		= THIS_MODULE,
-	.gpio_config	= pc8736x_gpio_configure,
-	.gpio_dump	= nsc_gpio_dump,
-	.gpio_get	= pc8736x_gpio_get,
-	.gpio_set	= pc8736x_gpio_set,
-	.gpio_set_high	= pc8736x_gpio_set_high,
-	.gpio_set_low	= pc8736x_gpio_set_low,
-	.gpio_change	= pc8736x_gpio_change,
-	.gpio_current	= pc8736x_gpio_current
+static struct nsc_gpio_ops pc8736x_access[] = {
+	{ /* bit operations */
+		.owner		= THIS_MODULE,
+		.gpio_config	= pc8736x_gpio_configure,
+		.gpio_dump	= nsc_gpio_dump,
+		.gpio_get	= pc8736x_gpio_get,
+		.gpio_set	= pc8736x_gpio_set,
+		.gpio_set_high	= pc8736x_gpio_set_high,
+		.gpio_set_low	= pc8736x_gpio_set_low,
+		.gpio_change	= pc8736x_gpio_change,
+		.gpio_current	= pc8736x_gpio_current
+	},
+	{ /* port operations */
+		.owner		= THIS_MODULE,
+		.gpio_config	= pc8736x_gpio_configure,
+		.gpio_dump	= nsc_gpio_dump,
+		.gpio_get	= pc8736x_gpio_port_get,
+		.gpio_set	= pc8736x_gpio_port_set,
+		.gpio_set_high	= pc8736x_gpio_port_set_high,
+		.gpio_set_low	= pc8736x_gpio_port_set_low,
+		.gpio_change	= pc8736x_gpio_port_change,
+		.gpio_current	= pc8736x_gpio_port_current
+	}
 };
 
 static int pc8736x_gpio_open(struct inode *inode, struct file *file)
@@ -245,6 +299,58 @@ static struct file_operations pc8736x_gp
 	.read	= nsc_gpio_read,
 };
 
+/* insert some sysfs decls and inits */
+
+static struct gpio_pin_attributes port0[] = {
+	PIN_ATTRS(0,0), PIN_ATTRS(0,1), PIN_ATTRS(0,2), PIN_ATTRS(0,3),
+	PIN_ATTRS(0,4), PIN_ATTRS(0,5), PIN_ATTRS(0,6), PIN_ATTRS(0,7),
+};
+static struct gpio_pin_attributes port1[] = {
+	PIN_ATTRS(1,0), PIN_ATTRS(1,1), PIN_ATTRS(1,2), PIN_ATTRS(1,3),
+	PIN_ATTRS(1,4), PIN_ATTRS(1,5), PIN_ATTRS(1,6), PIN_ATTRS(1,7),
+};
+static struct gpio_pin_attributes port2[] = {
+	PIN_ATTRS(2,0), PIN_ATTRS(2,1), PIN_ATTRS(2,2), PIN_ATTRS(2,3),
+	PIN_ATTRS(2,4), PIN_ATTRS(2,5), PIN_ATTRS(2,6), PIN_ATTRS(2,7),
+};
+static struct gpio_pin_attributes port3[] = {
+	PIN_ATTRS(3,0), PIN_ATTRS(3,1), PIN_ATTRS(3,2), PIN_ATTRS(3,3),
+	PIN_ATTRS(3,4), PIN_ATTRS(3,5), PIN_ATTRS(3,6), PIN_ATTRS(3,7),
+};
+
+static struct gpio_pin_attributes ports[] = {
+	PORT_ATTRS(0), PORT_ATTRS(1), PORT_ATTRS(2), PORT_ATTRS(3),
+};
+
+static void __init nsc_gpio_sysfs_port_init(struct device* dev,
+					    struct gpio_pin_attributes pp[],
+					    int numdevs)
+{
+	int i;
+	for (i = 0; i < numdevs; i++) {
+		device_create_file(dev, &pp[i].value.dev_attr);
+		device_create_file(dev, &pp[i].output_enabled.dev_attr);
+		device_create_file(dev, &pp[i].totem_pole.dev_attr);
+		device_create_file(dev, &pp[i].locked.dev_attr);
+		device_create_file(dev, &pp[i].pullup_enabled.dev_attr);
+		device_create_file(dev, &pp[i].debounced.dev_attr);
+	}
+}
+
+static void __init pc8736x_sysfs_init(struct device* dev)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(ports); i++) {
+		nsc_gpio_sysfs_port_init(dev, &ports[i], 1);
+	}
+	nsc_gpio_sysfs_port_init(dev, port0, 8);
+	nsc_gpio_sysfs_port_init(dev, port1, 8);
+	nsc_gpio_sysfs_port_init(dev, port2, 8);
+	nsc_gpio_sysfs_port_init(dev, port3, 8);
+
+	dev_info(dev, "created sysfs nodes\n");
+}
+
 static void __init pc8736x_init_shadow(void)
 {
 	int port;
@@ -277,7 +383,11 @@ static int __init pc8736x_gpio_init(void
                 platform_device_put(pdev);
 		return -ENODEV;
 	}
-	pc8736x_access.dev = &pdev->dev;
+	pc8736x_access[0].dev = &pdev->dev;
+	pc8736x_access[1].dev = &pdev->dev;
+	pdev->dev.driver_data = &pc8736x_access;
+
+        dev_info(&pdev->dev, "access %p\n", &pc8736x_access);
 
 	/* Verify that chip and it's GPIO unit are both enabled.
 	   My BIOS does this, so I take minimum action here
@@ -312,6 +422,7 @@ static int __init pc8736x_gpio_init(void
 	}
 
 	pc8736x_init_shadow();
+	pc8736x_sysfs_init(&pdev->dev);
 	return 0;
 }
 
diff -ruNp -X dontdiff -X exclude-diffs az-1/drivers/char/scx200_gpio.c az-2/drivers/char/scx200_gpio.c
--- az-1/drivers/char/scx200_gpio.c	2006-06-18 13:14:52.000000000 -0600
+++ az-2/drivers/char/scx200_gpio.c	2006-06-18 16:43:43.000000000 -0600
@@ -12,16 +12,18 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#include <linux/scx200_gpio.h>
+
 #include <linux/types.h>
 #include <linux/cdev.h>
 
-#include <linux/scx200_gpio.h>
-#include <linux/nsc_gpio.h>
-
 #define NAME "scx200_gpio"
 #define DEVNAME NAME
 
@@ -74,6 +76,43 @@ static struct file_operations scx200_gpi
 struct cdev *scx200_devices;
 int num_devs = 32;
 
+
+/* insert sysfs decl and init-func here */
+
+static struct gpio_pin_attributes port0[] = {
+	PIN_ATTRS(0,0), PIN_ATTRS(0,1), PIN_ATTRS(0,2), PIN_ATTRS(0,3),
+	PIN_ATTRS(0,4), PIN_ATTRS(0,5), PIN_ATTRS(0,6), PIN_ATTRS(0,7),
+	PIN_ATTRS(0,8), PIN_ATTRS(0,9), PIN_ATTRS(0,10), PIN_ATTRS(0,11),
+	PIN_ATTRS(0,12), PIN_ATTRS(0,13), PIN_ATTRS(0,14), PIN_ATTRS(0,15),
+
+	PIN_ATTRS(0,16), PIN_ATTRS(0,17), PIN_ATTRS(0,18), PIN_ATTRS(0,19),
+	PIN_ATTRS(0,20), PIN_ATTRS(0,21), PIN_ATTRS(0,22), PIN_ATTRS(0,23),
+	PIN_ATTRS(0,24), PIN_ATTRS(0,25), PIN_ATTRS(0,26), PIN_ATTRS(0,27),
+	PIN_ATTRS(0,28), PIN_ATTRS(0,29), PIN_ATTRS(0,30), PIN_ATTRS(0,31),
+};
+
+static void __init nsc_gpio_sysfs_port_init(struct device* dev,
+					    struct gpio_pin_attributes pp[],
+					    int numdevs)
+{
+	int i;
+	dev_info(dev, "creating sysfs nodes\n");
+	for (i = 0; i < numdevs; i++) {
+		device_create_file(dev, &pp[i].output_enabled.dev_attr);
+		device_create_file(dev, &pp[i].totem_pole.dev_attr);
+		device_create_file(dev, &pp[i].locked.dev_attr);
+		device_create_file(dev, &pp[i].pullup_enabled.dev_attr);
+		device_create_file(dev, &pp[i].debounced.dev_attr);
+	}
+	
+}
+
+static void __init gpio_sysfs_init(struct device* dev)
+{
+	nsc_gpio_sysfs_port_init(dev, port0, 32);
+}
+
+
 static int __init scx200_gpio_init(void)
 {
 	int rc, i;
@@ -95,6 +134,7 @@ static int __init scx200_gpio_init(void)
 
 	/* nsc_gpio uses dev_dbg(), so needs this */
 	scx200_access.dev = &pdev->dev;
+	scx200_access.dev->driver_data = &scx200_access;
 
 	if (major)
 		rc = register_chrdev_region(dev, num_devs, "scx200_gpio");
@@ -121,6 +161,7 @@ static int __init scx200_gpio_init(void)
 			dev_err(&pdev->dev, "Error %d on minor %d", rc, i);
 	}
 
+	gpio_sysfs_init(&pdev->dev);
 	return 0; /* succeed */
 
 undo_chrdev_region:
diff -ruNp -X dontdiff -X exclude-diffs az-1/include/linux/nsc_gpio.h az-2/include/linux/nsc_gpio.h
--- az-1/include/linux/nsc_gpio.h	2006-06-18 13:14:52.000000000 -0600
+++ az-2/include/linux/nsc_gpio.h	2006-06-18 20:19:29.000000000 -0600
@@ -1,6 +1,4 @@
 /**
-   nsc_gpio.c
-
    National Semiconductor GPIO common access methods.
 
    struct nsc_gpio_ops abstracts the low-level access
@@ -19,16 +17,27 @@
    NSC sold the GEODE line to AMD, and the PC-8736x line to Winbond.
 */
 
+/* pin-feature to config-bit mapping is common to both chips
+   some ports' pins dont support upper nibble ops.
+*/
+#define PF_OUTPUT_ENA		1
+#define PF_TOTEM		2
+#define PF_PULLUP		4
+#define PF_LOCKED		8
+#define PF_INTRUPT_ENA		16
+#define PF_INTRUPT_TGR		32
+#define PF_DEBOUNCE		64
+
 struct nsc_gpio_ops {
 	struct module*	owner;
 	u32	(*gpio_config)	(unsigned iminor, u32 mask, u32 bits);
 	void	(*gpio_dump)	(struct nsc_gpio_ops *amp, unsigned iminor);
-	int	(*gpio_get)	(unsigned iminor);
-	void	(*gpio_set)	(unsigned iminor, int state);
+	u32	(*gpio_get)	(unsigned iminor);
+	void	(*gpio_set)	(unsigned iminor, unsigned state);
 	void	(*gpio_set_high)(unsigned iminor);
 	void	(*gpio_set_low)	(unsigned iminor);
 	void	(*gpio_change)	(unsigned iminor);
-	int	(*gpio_current)	(unsigned iminor);
+	u32	(*gpio_current)	(unsigned iminor);
 	struct device*	dev;	/* for dev_dbg() support, set in init  */
 };
 
@@ -40,3 +49,100 @@ extern ssize_t nsc_gpio_read(struct file
 
 extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index);
 
+
+/* The original scx200_gpio driver exposed pins to the user as
+   char-device-files.  We preserve this legacy command alphabet, and
+   map them onto struct sensor_device_attribute_2's .nr member.
+   This gives us 2D addressing, and puts all the bit-banging into a
+   single pair of callbacks.
+*/
+
+
+/* Sysfs Interface: 2D callbacks: 
+	.index	= bit_num,
+	.nr	= attr_slct
+*/
+extern ssize_t nsc_gpio_sysfs_get(struct device *dev,
+				  struct device_attribute *devattr,
+				  char *buf);
+
+extern ssize_t nsc_gpio_sysfs_set(struct device *dev,
+				  struct device_attribute *devattr,
+				  const char *buf, size_t count);
+
+/* GPIO pins have 5 attributes we care about: group them */
+struct gpio_pin_attributes {
+	struct sensor_device_attribute_2
+		value,
+		output_enabled,
+		totem_pole,
+		pullup_enabled,
+		debounced,
+		locked;
+};
+
+#define GPIO_ATTR(_grp, _idx, _pre, _post, _mode, _show, _store, _nr)	\
+	{	.dev_attr = __ATTR(_pre## _grp._idx ##_post,		\
+				   _mode, _show, _store),		\
+		.index = _idx, .nr = _nr }
+
+#define GPIO_PIN(GN, IN, FnSym, AttrNm)	\
+	GPIO_ATTR(GN, IN, bit_, AttrNm,	\
+		  S_IWUSR | S_IRUGO,	\
+		  nsc_gpio_sysfs_get, nsc_gpio_sysfs_set, FnSym )
+
+/* command alphabet - initializer components */
+#define PIN_VALUE(P,N)		GPIO_PIN(P, N, 'V', _value)
+#define PIN_OE(P,N)		GPIO_PIN(P, N, 'O', _output_enabled)
+#define PIN_PP(P,N)		GPIO_PIN(P, N, 'T', _totem)
+#define PIN_PUE(P,N)		GPIO_PIN(P, N, 'P', _pullup_enabled)
+#define PIN_LOCKED(P,N)		GPIO_PIN(P, N, 'L', _locked)
+#define PIN_DEBOUNCE(P,N)	GPIO_PIN(P, N, 'D', _debounced)
+
+/* initializer for ports; ie pin arrays */
+#define PIN_ATTRS(Port, Idx) {			\
+	.value		= PIN_VALUE(Port, Idx),	\
+	.output_enabled	= PIN_OE(Port, Idx),	\
+	.totem_pole	= PIN_PP(Port, Idx),	\
+	.pullup_enabled	= PIN_PUE(Port, Idx),	\
+	.locked		= PIN_LOCKED(Port, Idx), \
+	.debounced	= PIN_DEBOUNCE(Port, Idx), }
+
+
+/* whole-port interface */
+extern ssize_t nsc_gpio_port_sysfs_get(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf);
+
+extern ssize_t nsc_gpio_port_sysfs_set(struct device *dev,
+				       struct device_attribute *devattr,
+				       const char *buf, size_t count);
+
+#define GPIO_PORT_ATTR(_grp,  _pre, _post, _mode, _show, _store, _nr)	\
+	{	.dev_attr = __ATTR(_pre## _grp ##_post,			\
+				   _mode, _show, _store),		\
+		.index = _grp, .nr = _nr }
+
+#define GPIO_PORT(GN, FnSym, AttrNm)			\
+	GPIO_PORT_ATTR(GN, port_, AttrNm,		\
+		       S_IWUSR | S_IRUGO,		\
+		       nsc_gpio_port_sysfs_get, 	\
+		       nsc_gpio_port_sysfs_set, FnSym )
+
+/* command alphabet - initializer components */
+#define PORT_VALUE(P)		GPIO_PORT(P, 'V', _value)
+#define PORT_OE(P)		GPIO_PORT(P, 'O', _output_enabled)
+#define PORT_PP(P)		GPIO_PORT(P, 'T', _totem)
+#define PORT_PUE(P)		GPIO_PORT(P, 'P', _pullup_enabled)
+#define PORT_LOCKED(P)		GPIO_PORT(P, 'L', _locked)
+#define PORT_DEBOUNCE(P)	GPIO_PORT(P, 'D', _debounced)
+
+/* initializer for ports; ie pin arrays */
+#define PORT_ATTRS(Port) {			\
+	.value		= PORT_VALUE(Port),	\
+	.output_enabled	= PORT_OE(Port),	\
+	.totem_pole	= PORT_PP(Port),	\
+	.pullup_enabled	= PORT_PUE(Port),	\
+	.locked		= PORT_LOCKED(Port),	\
+	.debounced	= PORT_DEBOUNCE(Port), }
+
diff -ruNp -X dontdiff -X exclude-diffs az-1/include/linux/scx200_gpio.h az-2/include/linux/scx200_gpio.h
--- az-1/include/linux/scx200_gpio.h	2006-06-18 13:14:51.000000000 -0600
+++ az-2/include/linux/scx200_gpio.h	2006-06-18 16:49:23.000000000 -0600
@@ -17,23 +17,33 @@ extern long scx200_gpio_shadow[2];
 
 /* returns the value of the GPIO pin */
 
-static inline int scx200_gpio_get(unsigned index) {
+static inline int scx200_gpio_port_get(unsigned index) {
 	__SCx200_GPIO_BANK;
 	__SCx200_GPIO_IOADDR + 0x04;
 	__SCx200_GPIO_INDEX;
-		
-	return (inl(ioaddr) & (1<<index)) ? 1 : 0;
+
+	return inl(ioaddr);
+}
+
+static inline int scx200_gpio_get(unsigned index)
+{
+	return (scx200_gpio_port_get(index) & (1<<index)) ? 1 : 0;
 }
 
 /* return the value driven on the GPIO signal (the value that will be
    driven if the GPIO is configured as an output, it might not be the
    state of the GPIO right now if the GPIO is configured as an input) */
 
-static inline int scx200_gpio_current(unsigned index) {
+static inline int scx200_gpio_port_current(unsigned index) {
         __SCx200_GPIO_BANK;
 	__SCx200_GPIO_INDEX;
 		
-	return (scx200_gpio_shadow[bank] & (1<<index)) ? 1 : 0;
+	return scx200_gpio_shadow[bank];
+}
+
+static inline int scx200_gpio_current(unsigned index)
+{
+	return (scx200_gpio_port_current(index) & (1<<index)) ? 1 : 0;
 }
 
 /* drive the GPIO signal high */
@@ -60,7 +70,7 @@ static inline void scx200_gpio_set_low(u
 
 /* drive the GPIO signal to state */
 
-static inline void scx200_gpio_set(unsigned index, int state) {
+static inline void scx200_gpio_set(unsigned index, u32 state) {
 	__SCx200_GPIO_BANK;
 	__SCx200_GPIO_IOADDR;
 	__SCx200_GPIO_SHADOW;
@@ -82,6 +92,34 @@ static inline void scx200_gpio_change(un
 	__SCx200_GPIO_OUT;
 }
 
+static inline void scx200_gpio_port_set(unsigned bank, u32 vals) {
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	*shadow = vals;
+	__SCx200_GPIO_OUT;
+}
+
+static inline void scx200_gpio_port_set_high(unsigned bank) {
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	*shadow = 0xFFFFFFFF;
+	__SCx200_GPIO_OUT;
+}
+
+static inline void scx200_gpio_port_set_low(unsigned bank) {
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	*shadow = 0;
+	__SCx200_GPIO_OUT;
+}
+
+static inline void scx200_gpio_port_change(unsigned bank) {
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	*shadow = ~(*shadow);
+	__SCx200_GPIO_OUT;
+}
+
 #undef __SCx200_GPIO_BANK
 #undef __SCx200_GPIO_IOADDR
 #undef __SCx200_GPIO_SHADOW




