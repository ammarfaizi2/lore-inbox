Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWHHXB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWHHXB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 19:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWHHXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 19:01:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:60090 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965066AbWHHXB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 19:01:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=r0GIpXf7bpmOdVJ4xA1QTryBt+8n1q2ej/8qErQYb/A2M6/2Y54XDB0wNquHaoqXqMerMR5SOWez0aUjocsQ8kVsPo+QYumnJoQu1QG0Am79VnhGG5x/I0y6NNm1o0cBjANAY4xEda9bIywRVyecsj24g29bS3EuiLnl2SPD6xU=
Message-ID: <44D917D6.1050503@gmail.com>
Date: Tue, 08 Aug 2006 17:01:42 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Chris Boot <bootc@bootc.net>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Robert Schwebel <r.schwebel@pengutronix.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [RFC - patch] add a gpio-sysfs interface - was: Proposal: common
 kernel-wide GPIO interface
References: <44CA7738.4050102@bootc.net> <20060730130811.GI10495@pengutronix.de> <44CFC6CC.8020106@gmail.com> <20060802175834.GA13641@csclub.uwaterloo.ca> <44D10FA1.2010206@gmail.com>
In-Reply-To: <44D10FA1.2010206@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie wrote:
>
> nsc_gpio, pc8736x_gpio , scx200_gpio went thru mm into mainline-rc - 
> they support the legacy gpio-bit
> access via char-device-file.  They expose port-wide read/write inside 
> the kernel, 

correction - in-vtable portwide-accessors are in a to-be-applied patch 
from Chris Boot to me.
Its in-my-queue for post 18, since we're now rc. 


Im attaching a newer version of a patch sent earlier this thread.

It adds a sysfs-gpio interface, for both bits & ports.
- same feature-set for both.
- tried port-synthesis -
    for pin-features that are implemented as per-bit only,
    do set of queries/updates, and bundle them for presentation.
    (having explored this, Im hedging ..)

the set of pin_* and port_*  attributes are supported by 8 sysfs-callbacks,
split on following axes:    bit/port, value/config, read/write (always, 
diff fn-sigs).
*_value callbacks are simple/fast
    both my gpio chips are port-based, bit-wide methods add masking
*_conf callbacks handle many attributes
_bit_conf - natural match - fetches bit, returns bit
_port_conf - synthesize port from bits

The 8 callbacks are mapped into place by 2 macros in nsc_gpio.h,
one each for bits/ports.  BUG:  the mapping is inelegant.  see code for 
more comments.


WRT port-synthesis from bit-wide properties

- different chips expose different properties as bit-vectors
    pc87366 gives data-in, data-out-rd/wr only,
    sc-1100  also shows interrupt-enable, gpio-event-status as bit-vectors

- port-synthesis lets us hide the difference, if done correctly.
     BUG : Due to the macro design (built for static decl & initialization),
    its cumbersome to do the mapping.

- alternative (and simpler) approach is to :
    selectively create attr-files, thus exposing only the features desired
    let user-space figure it out

this is all restated in patch comments.


Patch does nothing wrt reservations or class_dev design,
Chris, Im hoping you're focussing here, it would be really cool if my 
callbacks
were to just drop right into gpio class impl ;-)



The following cut-pastes demonstrate some level of working-ness,
1 - pin reads via char-device-files
2 - same pins, read as sys-attr files,  bit/port (values)
3 - demonstrates bitpos=1 exposing bit-in-port (values)
4 - config-features work - bit-read/write works, effect visible in 
port-reads
5 - port-wide synthesis mostly works - isnt working yet
6 - currently nsc_gpio.c defines  DEBUG 1, giving output cut-pasted below


pc8736x-gpio port reads:

running: cat /sys/devices/platform/pc8736x_gpio.0/port_0_value 
/sys/devices/platform/pc8736x_gpio.0/port_1_value 
/sys/devices/platform/pc8736x_gpio.0/port_2_value 
/sys/devices/platform/pc8736x_gpio.0/port_3_value
0xff
0xd1
0x9e
0x1d
...

and bit-reads: (bitpos=1 exposes more info)

running: cat /sys/devices/platform/pc8736x_gpio.0/bit_1.0_value 
/sys/devices/platform/pc8736x_gpio.0/bit_1.1_value 
/sys/devices/platform/pc8736x_gpio.0/bit_1.2_value 
/sys/devices/platform/pc8736x_gpio.0/bit_1.3_value 
/sys/devices/platform/pc8736x_gpio.0/bit_1.4_value 
/sys/devices/platform/pc8736x_gpio.0/bit_1.5_value 
/sys/devices/platform/pc8736x_gpio.0/bit_1.6_value 
/sys/devices/platform/pc8736x_gpio.0/bit_1.7_value
0x1
0x0
0x0
0x0
0x10
0x0
0x40
0x80

test port-synthesis - cmd-letter is borrowed from set understood by 
char-dev-write-handler

running: cat /sys/devices/platform/pc8736x_gpio.0/port_0_output_enabled
[ 2039.060925] platform pc8736x_gpio.0: get-portconf bit:0.0 cfg:44 
cmd'O' res:0
[ 2039.068312] platform pc8736x_gpio.0: get-portconf bit:0.1 cfg:44 
cmd'O' res:0
[ 2039.075703] platform pc8736x_gpio.0: get-portconf bit:0.2 cfg:44 
cmd'O' res:0
[ 2039.083053] platform pc8736x_gpio.0: get-portconf bit:0.3 cfg:44 
cmd'O' res:0
[ 2039.090434] platform pc8736x_gpio.0: get-portconf bit:0.4 cfg:44 
cmd'O' res:0
[ 2039.097789] platform pc8736x_gpio.0: get-portconf bit:0.5 cfg:44 
cmd'O' res:0
[ 2039.105140] platform pc8736x_gpio.0: get-portconf bit:0.6 cfg:44 
cmd'O' res:0
[ 2039.112487] platform pc8736x_gpio.0: get-portconf bit:0.7 cfg:44 
cmd'O' res:0
[ 2039.119875] platform pc8736x_gpio.0: get-portconf() idx=0 cmd='O' ret:0
0x0

running: cat /sys/devices/platform/pc8736x_gpio.0/port_0_pullup_enabled
[ 2039.185437] platform pc8736x_gpio.0: get-portconf bit:0.0 cfg:44 
cmd'P' res:0
[ 2039.192829] platform pc8736x_gpio.0: get-portconf bit:0.1 cfg:44 
cmd'P' res:0
[ 2039.200181] platform pc8736x_gpio.0: get-portconf bit:0.2 cfg:44 
cmd'P' res:0
[ 2039.207531] platform pc8736x_gpio.0: get-portconf bit:0.3 cfg:44 
cmd'P' res:0
[ 2039.214887] platform pc8736x_gpio.0: get-portconf bit:0.4 cfg:44 
cmd'P' res:0
[ 2039.222244] platform pc8736x_gpio.0: get-portconf bit:0.5 cfg:44 
cmd'P' res:0
[ 2039.229633] platform pc8736x_gpio.0: get-portconf bit:0.6 cfg:44 
cmd'P' res:0
[ 2039.236995] platform pc8736x_gpio.0: get-portconf bit:0.7 cfg:44 
cmd'P' res:0
[ 2039.244300] platform pc8736x_gpio.0: get-portconf() idx=0 cmd='P' ret:0
0x0

soekris:/sys/devices/platform# echo 1 > 
pc8736x_gpio.0/bit_0.1_pullup_enabled
[ 2760.304169] platform pc8736x_gpio.0: GPIO1 pullup enabled=1
[ 2760.310014] platform pc8736x_gpio.0: set-bitconf() idx:1 cmd:'P' buf:'1
[ 2760.310059] ' set:1
soekris:/sys/devices/platform#
soekris:/sys/devices/platform# cat pc8736x_gpio.0/port_0_pullup_enabled
[ 2780.140281] platform pc8736x_gpio.0: get-portconf bit:0.0 cfg:44 
cmd'P' res:0
[ 2780.147761] platform pc8736x_gpio.0: get-portconf bit:0.1 cfg:46 
cmd'P' res:2
[ 2780.155139] platform pc8736x_gpio.0: get-portconf bit:0.2 cfg:44 
cmd'P' res:0
[ 2780.162585] platform pc8736x_gpio.0: get-portconf bit:0.3 cfg:44 
cmd'P' res:0
[ 2780.169960] platform pc8736x_gpio.0: get-portconf bit:0.4 cfg:44 
cmd'P' res:0
[ 2780.177379] platform pc8736x_gpio.0: get-portconf bit:0.5 cfg:44 
cmd'P' res:0
[ 2780.184749] platform pc8736x_gpio.0: get-portconf bit:0.6 cfg:44 
cmd'P' res:0
[ 2780.192158] platform pc8736x_gpio.0: get-portconf bit:0.7 cfg:44 
cmd'P' res:0
[ 2780.199484] platform pc8736x_gpio.0: get-portconf() idx=0 cmd='P' ret:2
0x2




TIA for any comments, feedback.


diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc3-mm2-sk/Documentation/gpio-model.txt roll3-m2/Documentation/gpio-model.txt
--- ../linux-2.6.18-rc3-mm2-sk/Documentation/gpio-model.txt	1969-12-31 17:00:00.000000000 -0700
+++ roll3-m2/Documentation/gpio-model.txt	2006-08-08 16:47:12.000000000 -0600
@@ -0,0 +1,130 @@
+
+Sysfs GPIO Model
+
+GPIO Hardware Design Overview
+
+GPIO (General Purpose IO) Hardware provides digital IO on pins
+(physical connections to external circuitry).  The pins can be read
+and written, and are configurable for adaptability to a variety of
+external circuit designs.  The typical GPIO feature set looks like
+this:
+
+   input:
+	- input (read pin value)
+	- input (read pin driven-value)
+	- input debounce (hw noise conditioning)
+
+   output:
+	- data-out
+	- output-enable !tristate
+
+   config: (used less frequently)
+   	- pullup-resistor
+	- output-enable
+	- open collector (can only pull to zero)
+	- open emmitor (can only pull to high)
+	- interrupt generation & control
+
+
+Hardware Ports Organization
+
+Many GPIO hardware units organize GPIO bits (aka pins) into ports (aka
+banks) with an implementation-dependent width.  The pin values are
+written and read on a port-wide basis, ensuring that all pins in a
+port change *simultaneously*, ie not as result of separate bus cycles.
+This is essential for some applications.  Port-wide access is
+typically just for data.
+
+Config features control the GPIO's electrical properties, and are
+rarely used (data-access dominates).  These features are usually
+implemented per-bit, but with some variations.
+
+
+GPIO-Sysfs Features
+
+All GPIO device-attr-files have 3-part names:
+
+  <prefix>_<id>_<suffix>.
+
+   prefix	'bit_'	or 'port_'
+   id		 1.3	or  2	respectively
+   suffix	feature-name	(value, totem, etc)
+
+for example:
+
+soekris:/sys/devices/platform# ls pc8736x_gpio.0/bit_0.1_*
+pc8736x_gpio.0/bit_0.1_current         pc8736x_gpio.0/bit_0.1_pullup_enabled
+pc8736x_gpio.0/bit_0.1_debounced       pc8736x_gpio.0/bit_0.1_status
+pc8736x_gpio.0/bit_0.1_locked          pc8736x_gpio.0/bit_0.1_totem
+pc8736x_gpio.0/bit_0.1_output_enabled  pc8736x_gpio.0/bit_0.1_value
+
+
+Suffixes:
+
+The Suffix displays the feature-name.  They are named for one of the
+states, rather than the property-name, since a state-name=X is
+self-explanatory.
+
+And, matching my hardware:
+   _output_enabled  vs  _tristate
+   _totem	    vs  _pushpull
+
+The <suffix> should be user replaceable later, with a means to add
+logical inversion selectively.
+
+
+Bit vs Port features.
+
+Depending upon hardware, each GPIO feature is controllable via either
+a bit-wide or port-wide interface.  The model allows driver to
+abstract this, and to synthesize port-wide features where needed.
+
+- driver can choose to expose features only as naturally supported.
+  User space can deal then recognize when port-wide control of
+  output-enable, interrupts, etc are supported by the hardware.
+
+- driver can synthesize port-features by banging the per-bit access.
+  This was done ad-hoc, got reasonable results.
+
+
+Port, Bit Reservation (a few thoughts)
+
+Assuming port-wide GPIOs (seeing a bias?), each hardware port is
+trivially reserved by masking in bits as they're taken.  
+
+simplifing constraints:
+ - user-ports are always subset of single hw-port
+ - no hw-port spanning
+ - contiguous bit-blocks only (0x5,0x9 disallowed)
+
+
+Various Hardware Notes
+
+General rules
+
+- GPIOs generally power-up into safe states (tristate/input-only),
+  interrupts are off, etc.
+
+- GPIOs can have diminishing feature set across provided resources.  A
+  designer rarely needs homogeneous features, often needs very few
+  pins which must generate interrupts.
+
+- when a pin doesnt support feature, it provides a 'ghost-bit', which
+  reads as disabled, and ignores writes/ enablements.  This is not
+  universal however..
+
+PC87366
+
+- has 4 8-bit ports, with diminishing feature set.
+- pins in all 4 share common *basic-config* register defn
+- ports 2,3 lack interrupts
+--  *and* they lack register too.
+--  they should have given it a ghost register.
+
+SC-1100
+
+This GPIO-port also supports Interrupt-Enable & Status.
+
+Sadly, it doesnt expose port-wide output-enable, which means
+bus-logic (switching all N-lines to hiZ) is prohibitively slow.
+
diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc3-mm2-sk/drivers/char/nsc_gpio.c roll3-m2/drivers/char/nsc_gpio.c
--- ../linux-2.6.18-rc3-mm2-sk/drivers/char/nsc_gpio.c	2006-07-30 11:29:18.000000000 -0600
+++ roll3-m2/drivers/char/nsc_gpio.c	2006-08-08 16:54:01.000000000 -0600
@@ -7,36 +7,112 @@
    Copyright (c) 2005      Jim Cromie <jim.cromie@gmail.com>
 */
 
+#define DRVNAME "nsc_gpio"
+
+#include <linux/device.h>
 #include <linux/config.h>
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <linux/nsc_gpio.h>
 
-#define NAME "nsc_gpio"
+static int noports = 0;
+module_param(noports, int, 0);
+MODULE_PARM_DESC(noports, "sysgpio 0:both 1:no-status 2:no-sysfs-flags");
+
+static int bitpos = 0;
+module_param(bitpos, int, 0);
+MODULE_PARM_DESC(bitpos, "1 to expose bit position in values");
 
-void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index)
+static char statbuf[256];
+static ssize_t nsc_gpio_status(struct nsc_gpio_ops *amp, unsigned index)
 {
 	/* retrieve current config w/o changing it */
 	u32 config = amp->gpio_config(index, ~0, 0);
+ 
+	return sprintf (
+		statbuf, "i/o%02u:%d/%d  0x%04x %s %s %s %s %s %s %s",
+		index,
+		!!(amp->gpio_get(index)),	/* boolean display */
+		amp->gpio_current(index),	/* someday show [01z] */
+		config,
+		(config & 1) ? "OE" : "TS",      /* output-enabled/tristate */
+		(config & 2) ? "PP" : "OD",      /* push pull / open drain */
+		(config & 4) ? "PUE" : "PUD",    /* pull up enabled/disabled */
+		(config & 8) ? "LOCKED" : "",    /* locked / unlocked */
+		(config & 16) ? "LEVEL" : "EDGE",/* level/edge input */
+		(config & 32) ? "HI" : "LO",     /* trigger on rise/fall edge */
+		(config & 64) ? "DEBOUNCE" : "" /* debounce */
+		);
+}
+
+void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index)
+{
+	nsc_gpio_status(amp,index);
+	dev_info(amp->dev, "%s\n", statbuf);
+}
+
+/* the pin-mode-change 'commands' of the legacy device-file-interface,
+   are reused in the sysfs-interface.
+*/
+static int command_write(struct nsc_gpio_ops *amp, char c, unsigned m)
+{
+	struct device *dev = amp->dev;
+	int err = 0;
 
-	/* user requested via 'v' command, so its INFO */
-	dev_info(amp->dev, "io%02u: 0x%04x %s %s %s %s %s %s %s\tio:%d/%d\n",
-		 index, config,
-		 (config & 1) ? "OE" : "TS",      /* output-enabled/tristate */
-		 (config & 2) ? "PP" : "OD",      /* push pull / open drain */
-		 (config & 4) ? "PUE" : "PUD",    /* pull up enabled/disabled */
-		 (config & 8) ? "LOCKED" : "",    /* locked / unlocked */
-		 (config & 16) ? "LEVEL" : "EDGE",/* level/edge input */
-		 (config & 32) ? "HI" : "LO",     /* trigger on rise/fall edge */
-		 (config & 64) ? "DEBOUNCE" : "", /* debounce */
+	switch (c) {
 
-		 amp->gpio_get(index), amp->gpio_current(index));
+	/* cases are a mix of old command letters, and new PF_CMD_*
+	   symbols, for Off & On actions respectively.
+	*/
+	case '0':
+		amp->gpio_set(m, 0);
+		break;
+	case '1':
+		amp->gpio_set(m, 1);
+		break;
+	case PF_CMD_OUT_ENA:
+		dev_dbg(dev, "GPIO%d output enabled\n", m);
+		amp->gpio_config(m, ~1, 1);
+		break;
+	case 'o':
+		dev_dbg(dev, "GPIO%d output disabled\n", m);
+		amp->gpio_config(m, ~1, 0);
+		break;
+	case PF_CMD_TOTEM:
+		dev_dbg(dev, "GPIO%d output is push pull\n", m);
+		amp->gpio_config(m, ~2, 2);
+		break;
+	case 't':
+		dev_dbg(dev, "GPIO%d output is open drain\n", m);
+		amp->gpio_config(m, ~2, 0);
+		break;
+	case PF_CMD_PULLUP:
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
 }
 
 ssize_t nsc_gpio_write(struct file *file, const char __user *data,
@@ -44,57 +120,14 @@ ssize_t nsc_gpio_write(struct file *file
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
+		err += command_write(amp, c, m);
 	}
 	if (err)
 		return -EINVAL;	/* full string handled, report error */
@@ -121,15 +154,414 @@ EXPORT_SYMBOL(nsc_gpio_write);
 EXPORT_SYMBOL(nsc_gpio_read);
 EXPORT_SYMBOL(nsc_gpio_dump);
 
+#define BITVAL(a) "%u\n", !!(a)		/* force int to boolean */
+#define PORTVAL(a) "0x%x\n", (a)	/* expose bitval pos in port */
+
+/* 8 sysfs-callbacks, partitioned on 3 axes:
+   get/set:	as reqd by 2 different callback fn-signatures
+   value/:	for port-wide
+    /feature:	mostly use-once, slower, synthesized port-access
+   bit/port:	for values, separate for simplicity, speed
+
+   This is arguably over-optimization, may clash with client-module
+   feature to bit/port mappings.
+*/
+ssize_t nsc_gpio_sysfs_get_bitval(struct device *dev,
+				  struct device_attribute *devattr, char *buf)
+{ 
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	struct gpio_dev_attr *attr = to_gpio_dev_attr(devattr);
+	int idx = attr->bitnum;
+	int func = attr->fn_slct;
+	unsigned res = -1;
+
+	BUG_ON(!amp);
+
+	switch (func) {
+	case PF_CMD_VALUE:
+		res = amp->gpio_get(idx);
+		break;
+	case PF_CMD_CURR:
+		res = amp->gpio_current(idx);
+		break;
+	}
+	return bitpos ? 
+		sprintf(buf, PORTVAL(res)) :
+		sprintf(buf, BITVAL(res));
+}
+ssize_t nsc_gpio_sysfs_get_portval(struct device *dev,
+				   struct device_attribute *devattr, char *buf)
+{ 
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	struct gpio_dev_attr *attr = to_gpio_dev_attr(devattr);
+	int idx = attr->portnum;
+	int func = attr->fn_slct;
+	unsigned res = -1;
+
+	BUG_ON(!amp);
+	switch (func) {
+	case PF_CMD_VALUE:
+		res = amp->gpio_get_port(idx);
+		break;
+	case PF_CMD_CURR:
+		res = amp->gpio_current_port(idx);
+		break;
+	}
+	return sprintf(buf, PORTVAL(res));
+}
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_get_bitval);
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_get_portval);
+
+ssize_t nsc_gpio_sysfs_set_bitval(struct device *dev,
+				  struct device_attribute *devattr,
+				  const char *buf, size_t count)
+{ 
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	struct gpio_dev_attr *attr = to_gpio_dev_attr(devattr);
+	int idx = attr->bitnum;
+	long setting = simple_strtol(buf, NULL, 10);
+
+	/* CURR is VALUE for writes */
+	BUG_ON(!amp);
+	amp->gpio_set(idx, setting);
+	return count;
+}
+ssize_t nsc_gpio_sysfs_set_portval(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
+{ 
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	struct gpio_dev_attr *attr = to_gpio_dev_attr(devattr);
+	int idx = attr->portnum;
+	long setting = simple_strtol(buf, NULL, 10);
+
+	BUG_ON(!amp);
+	amp->gpio_setclr_port(idx, setting, ~setting);
+	return count;
+}
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_set_bitval);
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_set_portval);
+
+ssize_t nsc_gpio_sysfs_get_bitconf(struct device *dev,
+				   struct device_attribute *devattr,
+				   char *buf)
+{ 
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	struct gpio_dev_attr *attr = to_gpio_dev_attr(devattr);
+	int idx = attr->bitnum;
+	int func = attr->fn_slct;
+	u32 config, res = 0;
+
+	BUG_ON(!amp);
+	config = amp->gpio_config(idx, ~0, 0);
+
+	switch (func) {
+
+	case PF_CMD_CURR:
+		res = amp->gpio_current(idx);
+		return sprintf(buf, BITVAL(res));
+
+	case PF_CMD_STATUS:
+		nsc_gpio_status(amp, idx);
+		return sprintf(buf, "%s\n", statbuf);
+
+	case PF_CMD_OUT_ENA:
+		res = config & PF_MASK_OUT_ENA;
+		break;
+	case PF_CMD_TOTEM:
+		res = config & PF_MASK_TOTEM;
+		break;
+	case PF_CMD_PULLUP:
+		res = config & PF_MASK_PULLUP;
+		break;
+	case PF_CMD_LOCKED:
+		res = config & PF_MASK_LOCKED;
+		break;
+	case PF_CMD_DEBOUNCE:
+		res = config & PF_MASK_DEBOUNCE;
+		break;
+	case PF_CMD_INT_ENA:
+		res = config & PF_MASK_INT_ENA;
+		break;
+	case PF_CMD_INT_TRIG:
+		res = config & PF_MASK_INT_TRIG;
+		break;
+
+	default:
+		dev_err(dev, "unknown cmd '%c'\n", func);
+	}
+	dev_dbg(dev, "get-bitconf() idx:%d cmd:'%c' conf%02x res:%02x\n",
+		idx, func, config, res); 
+
+	return sprintf(buf, BITVAL(res));
+}
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_get_bitconf);
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_set_bitconf);
+
+
+#define replace(Mask,Val)	~Mask, Val ? Mask : 0
+
+ssize_t nsc_gpio_sysfs_set_bitconf(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
+{
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	struct gpio_dev_attr *attr = to_gpio_dev_attr(devattr);
+	int idx = attr->bitnum;
+	int func = attr->fn_slct;
+	long setting = simple_strtol(buf, NULL, 10);
+
+	BUG_ON(!amp);
+
+	switch (func) {
+
+	case PF_CMD_STATUS:
+	{
+		/* device-file write interface. Kludge, but small */
+		int i, err = 0;
+		dev_warn(dev, "try to set status to: %s\n", buf);
+		for (i = 0; buf[i]; i++)
+			err += command_write(amp, buf[i], idx);
+		if (err)
+			dev_warn(dev, "%d errs on cmd %s\n", err, buf);
+		break;
+	}
+	case PF_CMD_OUT_ENA:
+		dev_info(dev, "GPIO%d output enabled=%ld\n", idx, setting);
+		amp->gpio_config(idx, replace(1, setting));
+		// ~1, setting ? 1 : 0);
+		break;
+	case PF_CMD_PULLUP:
+		dev_info(dev, "GPIO%d pullup enabled=%ld\n", idx, setting);
+		amp->gpio_config(idx, ~2, setting ? 2 : 0);
+		break;
+	case PF_CMD_TOTEM:
+		dev_info(dev, "GPIO%d totem-pole enabled=%ld\n", idx, setting);
+		amp->gpio_config(idx, ~4, setting ? 4 : 0);
+		break;
+	case 'L':
+		dev_info(dev, "GPIO%d pin locked=%ld\n", idx, setting);
+		amp->gpio_config(idx, ~8, setting ? 8 : 0);
+		break;
+	case 'D':
+		dev_info(dev, "GPIO%d debounced=%ld\n", idx, setting);
+		amp->gpio_config(idx, ~PF_MASK_DEBOUNCE,
+				 setting ? PF_MASK_DEBOUNCE : 0);
+		break;
+	default:
+		dev_err(dev, "sysfs unknown cmd '%c'\n", func);
+	}
+	dev_info(dev, "set-bitconf() idx:%d cmd:'%c' buf:'%s' set:%lx\n",
+		 idx, func, buf, setting);
+
+	return strlen(buf);
+}
+
+#if 10
+ssize_t nsc_gpio_sysfs_get_portconf(struct device *dev,
+				    struct device_attribute *devattr,
+				    char *buf)
+{ 
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	struct gpio_dev_attr *attr = to_gpio_dev_attr(devattr);
+	int idx = attr->portnum;
+	int func = attr->fn_slct;
+	u32 config, res = 0, ret = 0;
+	char *s = buf;
+	int bit, width = amp->port_size;
+
+	BUG_ON(!amp);
+	BUG_ON(!width);
+
+	for (bit = 0; bit < width; bit++) {
+		
+		config = amp->gpio_config(bit + idx * width, ~0, 0);
+
+		switch ((char)func) {
+		case PF_CMD_CURR:
+			res = amp->gpio_current(bit);
+			sprintf(s, BITVAL(res));
+		case PF_CMD_STATUS:
+			nsc_gpio_status(amp, bit);
+			sprintf(s, "%s\n", statbuf);
+		case PF_CMD_OUT_ENA:
+			res = config & PF_MASK_OUT_ENA;
+			break;
+		case PF_CMD_PULLUP:
+			res = config & PF_MASK_PULLUP;
+			break;
+		case PF_CMD_TOTEM:
+			res = config & PF_MASK_TOTEM;
+			break;
+		case PF_CMD_LOCKED:
+			res = config & PF_MASK_LOCKED;
+			break;
+		case PF_CMD_DEBOUNCE:
+			res = config & PF_MASK_DEBOUNCE;
+			break;
+		case PF_CMD_INT_ENA:
+			res = config & PF_MASK_INT_ENA;
+			break;
+		case PF_CMD_INT_TRIG:
+			res = config & PF_MASK_INT_TRIG;
+			break;
+			
+		default:
+			dev_err(dev, "unknown cmd '%c'\n", func);
+			res = 0;
+		}
+		res = res ? 1<<bit : 0;
+		ret |= res;
+
+		dev_dbg(dev, "get-portconf bit:%d.%d cfg:%x cmd'%c' res:%x\n",
+			idx, bit, config, func, res);
+	}
+	dev_dbg(dev, "get-portconf(%d) idx=%d cmd='%c' ret:%x\n",
+		width, idx, func, ret);
+
+	return sprintf(buf, PORTVAL(ret));
+}
+
+ssize_t nsc_gpio_sysfs_set_portconf(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
+{
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	struct gpio_dev_attr *attr = to_gpio_dev_attr(devattr);
+	int idx = attr->bitnum;
+	int func = attr->fn_slct;
+	int bit, width = amp->port_size;
+	long setting = simple_strtol(buf, NULL, 10);
+
+	BUG_ON(!amp);
+
+	for (bit = 0; bit < width; bit++) {
+
+		switch (func) {
+
+		case PF_CMD_STATUS:
+		{
+			/* device-file write interface */
+			int i, err = 0;
+			dev_warn(dev, "try to set status to: %s\n", buf);
+			for (i = 0; buf[i]; i++)
+				err += command_write(amp, buf[i], idx);
+			if (err)
+				dev_warn(dev, "%d errs on cmd %s\n", err, buf);
+			break;
+		}
+		case PF_CMD_OUT_ENA:
+			amp->gpio_config(idx, ~PF_MASK_OUT_ENA,
+					 setting ? PF_MASK_OUT_ENA : 0);
+			break;
+		case PF_CMD_TOTEM:
+			amp->gpio_config(idx, ~PF_MASK_TOTEM,
+					 setting ? PF_MASK_TOTEM : 0);
+			break;
+		case PF_CMD_PULLUP:
+			amp->gpio_config(idx, ~PF_MASK_PULLUP,
+					 setting ? PF_MASK_PULLUP : 0);
+			break;
+		case PF_CMD_LOCKED:
+			amp->gpio_config(idx, ~PF_CMD_LOCKED, 
+					 setting ? PF_MASK_LOCKED : 0);
+			break;
+		case PF_CMD_DEBOUNCE:
+			amp->gpio_config(idx, ~PF_MASK_DEBOUNCE,
+					 setting ? PF_MASK_DEBOUNCE : 0);
+			break;
+		default:
+			dev_err(dev, "sysfs unknown cmd '%c'\n", func);
+		}
+	}
+	dev_info(dev, "set-portconf() idx:%d cmd:'%c' buf:'%s' set:%lx\n",
+		 idx, func, buf, setting);
+
+	return strlen(buf);
+}
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_get_portconf);
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_set_portconf);
+#endif
+
+
+
+static u8 legacy = 1, feature_attrs = 1;
+static int dev_attr_create_errs;
+static void create_devattr_file(struct device* dev,
+				struct device_attribute *dev_attr)
+{
+	int err;
+
+	if (dev_attr->show || dev_attr->store) {
+
+		err = device_create_file(dev, dev_attr);
+		if (err)
+			dev_attr_create_errs++;
+	}
+	else 
+		dev_dbg(dev, "skipping %s\n", dev_attr->attr.name);
+}
+
+/* next 2 functions (and previous kludge) could be replaced by pair of
+   calls to sysfs_create/remove_group, except that collecting
+   attributes into a group would be manual.
+*/
+
+void nsc_gpio_sysfs_bits_init(struct device* dev,
+			      struct gpio_attributes pp[], int numdevs)
+{
+	int i;
+
+	for (i = 0; i < numdevs; i++) {
+
+		create_devattr_file(dev, &pp[i].value.dev_attr);
+		create_devattr_file(dev, &pp[i].curr.dev_attr);
+
+		/* provide legacy device-file emulation here */
+		if (legacy)
+			create_devattr_file(dev, &pp[i].status.dev_attr);
+
+		/* create separate attr-file per feature */
+		if (feature_attrs) {
+			create_devattr_file(dev, &pp[i].oe.dev_attr);
+			create_devattr_file(dev, &pp[i].pue.dev_attr);
+			create_devattr_file(dev, &pp[i].totem.dev_attr);
+			create_devattr_file(dev, &pp[i].locked.dev_attr);
+			create_devattr_file(dev, &pp[i].bounce.dev_attr);
+			create_devattr_file(dev, &pp[i].int_en.dev_attr);
+			create_devattr_file(dev, &pp[i].int_lvl.dev_attr);
+		}
+	}
+}
+
+void nsc_gpio_sysfs_bits_fini(struct device* dev,
+			      struct gpio_attributes pp[], int numdevs)
+{
+	int i;
+	for (i = 0; i < numdevs; i++) {
+		device_remove_file(dev, &pp[i].value.dev_attr);
+		device_remove_file(dev, &pp[i].curr.dev_attr);
+		/* always remove, whether there or not */
+		device_remove_file(dev, &pp[i].status.dev_attr);
+		device_remove_file(dev, &pp[i].oe.dev_attr);
+		device_remove_file(dev, &pp[i].pue.dev_attr);
+		device_remove_file(dev, &pp[i].totem.dev_attr);
+		device_remove_file(dev, &pp[i].locked.dev_attr);
+		device_remove_file(dev, &pp[i].bounce.dev_attr);
+	}
+}
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_bits_init);
+EXPORT_SYMBOL_GPL(nsc_gpio_sysfs_bits_fini);
+
 static int __init nsc_gpio_init(void)
 {
-	printk(KERN_DEBUG NAME " initializing\n");
+	printk(KERN_DEBUG DRVNAME " initializing\n");
 	return 0;
 }
 
 static void __exit nsc_gpio_cleanup(void)
 {
-	printk(KERN_DEBUG NAME " cleanup\n");
+	printk(KERN_DEBUG DRVNAME " cleanup\n");
 }
 
 module_init(nsc_gpio_init);
diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc3-mm2-sk/drivers/char/pc8736x_gpio.c roll3-m2/drivers/char/pc8736x_gpio.c
--- ../linux-2.6.18-rc3-mm2-sk/drivers/char/pc8736x_gpio.c	2006-08-06 10:18:40.000000000 -0600
+++ roll3-m2/drivers/char/pc8736x_gpio.c	2006-08-08 14:01:00.000000000 -0600
@@ -1,5 +1,4 @@
-/* linux/drivers/char/pc8736x_gpio.c
-
+/* 
    National Semiconductor PC8736x GPIO driver.  Allows a user space
    process to play with the GPIO pins.
 
@@ -9,6 +8,8 @@
    Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>,
 */
 
+#define DRVNAME "pc8736x_gpio"
+
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/errno.h>
@@ -22,11 +23,13 @@
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
 
-#define DEVNAME "pc8736x_gpio"
-
-MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
-MODULE_DESCRIPTION("NatSemi/Winbond PC-8736x GPIO Pin Driver");
-MODULE_LICENSE("GPL");
+static int nobits = 0;
+module_param(nobits, int, 0);
+MODULE_PARM_DESC(nobits, "nobits=1 to suppress sysfs bits interface");
+
+static int noports = 0;
+module_param(noports, int, 0);
+MODULE_PARM_DESC(noports, "noports=1 to supress sysfs ports interface");
 
 static int major;		/* default to dynamic major */
 module_param(major, int, 0);
@@ -144,15 +147,29 @@ static u32 pc8736x_gpio_configure(unsign
 					 SIO_GPIO_PIN_CONFIG);
 }
 
-static int pc8736x_gpio_get(unsigned minor)
+/* vtable-API functions.
+   this is a gpio-port device, so bitvals are pulled from ports (in princple)
+*/
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
+static u32 pc8736x_gpio_get(unsigned minor)
 {
-	int port, bit, val;
+	int port, bit;
+	u32 val;
 
 	port = minor >> 3;
 	bit = minor & 7;
 	val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
-	val >>= bit;
-	val &= 1;
+	val &= 1 << bit;
 
 	dev_dbg(&pdev->dev, "_gpio_get(%d from %x bit %d) == val %d\n",
 		minor, pc8736x_gpio_base + port_offset[port] + PORT_IN, bit,
@@ -188,13 +205,21 @@ static void pc8736x_gpio_set(unsigned mi
 	pc8736x_gpio_shadow[port] = val;
 }
 
-static int pc8736x_gpio_current(unsigned minor)
+static u32 pc8736x_gpio_current_port(unsigned minor)
 {
 	int port, bit;
 	minor &= 0x1f;
 	port = minor >> 3;
 	bit = minor & 7;
-	return ((pc8736x_gpio_shadow[port] >> bit) & 0x01);
+	return (u32)((pc8736x_gpio_shadow[port] >> bit) & 0x01);
+}
+static u32 pc8736x_gpio_current(unsigned minor)
+{
+	int port, bit;
+	minor &= 0x1f;
+	port = minor >> 3;
+	bit = minor & 7;
+	return (u32)((pc8736x_gpio_shadow[port] >> bit) & 0x01);
 }
 
 static void pc8736x_gpio_change(unsigned index)
@@ -202,6 +227,26 @@ static void pc8736x_gpio_change(unsigned
 	pc8736x_gpio_set(index, !pc8736x_gpio_current(index));
 }
 
+static void pc8736x_gpio_setclr_port(unsigned port, u32 bits, u32 mask)
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
@@ -209,9 +254,14 @@ static struct nsc_gpio_ops pc8736x_gpio_
 	.gpio_get	= pc8736x_gpio_get,
 	.gpio_set	= pc8736x_gpio_set,
 	.gpio_change	= pc8736x_gpio_change,
-	.gpio_current	= pc8736x_gpio_current
+	.gpio_current	= pc8736x_gpio_current,
+	.port_size	= 8,
+	.gpio_get_port		= pc8736x_gpio_get_port,
+	.gpio_setclr_port	= pc8736x_gpio_setclr_port,
+	.gpio_current_port	= pc8736x_gpio_current_port,
 };
 
+/* char-dev API */
 static int pc8736x_gpio_open(struct inode *inode, struct file *file)
 {
 	unsigned m = iminor(inode);
@@ -231,6 +281,61 @@ static const struct file_operations pc87
 	.read	= nsc_gpio_read,
 };
 
+/* sysfs-gpio API */
+
+static struct gpio_attributes port0[] = {
+	GPIO_ATTRS(0,0), GPIO_ATTRS(0,1), GPIO_ATTRS(0,2),
+	GPIO_ATTRS(0,3), GPIO_ATTRS(0,4), GPIO_ATTRS(0,5),
+	GPIO_ATTRS(0,6), GPIO_ATTRS(0,7)
+};
+
+static struct gpio_attributes port1[] = {
+	GPIO_ATTRS(1,0), GPIO_ATTRS(1,1), GPIO_ATTRS(1,2),
+	GPIO_ATTRS(1,3), GPIO_ATTRS(1,4), GPIO_ATTRS(1,5),
+	GPIO_ATTRS(1,6), GPIO_ATTRS(1,7)
+};
+static struct gpio_attributes port2[] = {
+	GPIO_ATTRS(2,0), GPIO_ATTRS(2,1), GPIO_ATTRS(2,2),
+	GPIO_ATTRS(2,3), GPIO_ATTRS(2,4), GPIO_ATTRS(2,5),
+	GPIO_ATTRS(2,6), GPIO_ATTRS(2,7)
+};
+static struct gpio_attributes port3[] = {
+	GPIO_ATTRS(3,0), GPIO_ATTRS(3,1), GPIO_ATTRS(3,2),
+	GPIO_ATTRS(3,3), GPIO_ATTRS(3,4), GPIO_ATTRS(3,5),
+	GPIO_ATTRS(3,6), GPIO_ATTRS(3,7)
+};
+
+static struct gpio_attributes ports[] = {
+	GPIO_PORT_ATTRS(0), GPIO_PORT_ATTRS(1),
+	GPIO_PORT_ATTRS(2), GPIO_PORT_ATTRS(3),
+};
+
+static void __init pc8736x_sysfs_init(struct device* dev)
+{
+	if (!nobits) {
+		dev_info(dev, "creating gpio-sysfs pin interfaces\n");
+		nsc_gpio_sysfs_bits_init(&pdev->dev, port0, 8);
+		nsc_gpio_sysfs_bits_init(&pdev->dev, port1, 8);
+		nsc_gpio_sysfs_bits_init(&pdev->dev, port2, 8);
+		nsc_gpio_sysfs_bits_init(&pdev->dev, port3, 8);
+	}
+	if (!noports) {
+		dev_info(dev, "creating gpio-sysfs port interfaces\n");
+		nsc_gpio_sysfs_bits_init(&pdev->dev, ports, 4);
+	}
+}
+static void pc8736x_sysfs_fini(struct device* dev)
+{
+	dev_info(dev, "pc8736x_sysfs_fini");
+	nsc_gpio_sysfs_bits_fini(&pdev->dev, port0, 8);
+	nsc_gpio_sysfs_bits_fini(&pdev->dev, port1, 8);
+	nsc_gpio_sysfs_bits_fini(&pdev->dev, port2, 8);
+	nsc_gpio_sysfs_bits_fini(&pdev->dev, port3, 8);
+	
+	nsc_gpio_sysfs_bits_fini(&pdev->dev, ports, 4);
+}
+
+/* device init */
 static void __init pc8736x_init_shadow(void)
 {
 	int port;
@@ -250,7 +355,7 @@ static int __init pc8736x_gpio_init(void
 	int rc;
 	dev_t devid;
 
-	pdev = platform_device_alloc(DEVNAME, 0);
+	pdev = platform_device_alloc(DRVNAME, 0);
 	if (!pdev)
 		return -ENOMEM;
 
@@ -288,7 +393,7 @@ static int __init pc8736x_gpio_init(void
 	pc8736x_gpio_base = (superio_inb(SIO_BASE_HADDR) << 8
 			     | superio_inb(SIO_BASE_LADDR));
 
-	if (!request_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE, DEVNAME)) {
+	if (!request_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE, DRVNAME)) {
 		rc = -ENODEV;
 		dev_err(&pdev->dev, "GPIO ioport %x busy\n",
 			pc8736x_gpio_base);
@@ -298,9 +403,9 @@ static int __init pc8736x_gpio_init(void
 
 	if (major) {
 		devid = MKDEV(major, 0);
-		rc = register_chrdev_region(devid, PC8736X_GPIO_CT, DEVNAME);
+		rc = register_chrdev_region(devid, PC8736X_GPIO_CT, DRVNAME);
 	} else {
-		rc = alloc_chrdev_region(&devid, 0, PC8736X_GPIO_CT, DEVNAME);
+		rc = alloc_chrdev_region(&devid, 0, PC8736X_GPIO_CT, DRVNAME);
 		major = MAJOR(devid);
 	}
 
@@ -319,6 +424,10 @@ static int __init pc8736x_gpio_init(void
 	cdev_init(&pc8736x_gpio_cdev, &pc8736x_gpio_fileops);
 	cdev_add(&pc8736x_gpio_cdev, devid, PC8736X_GPIO_CT);
 
+	/* provide info where sysfs callbacks can get them */
+	pc8736x_gpio_ops.dev->driver_data = &pc8736x_gpio_ops;
+	pc8736x_sysfs_init(&pdev->dev);
+
 	return 0;
 
 undo_request_region:
@@ -335,6 +444,8 @@ static void __exit pc8736x_gpio_cleanup(
 {
 	dev_dbg(&pdev->dev, "cleanup\n");
 
+	pc8736x_sysfs_fini(&pdev->dev);
+
 	cdev_del(&pc8736x_gpio_cdev);
 	unregister_chrdev_region(MKDEV(major,0), PC8736X_GPIO_CT);
 	release_region(pc8736x_gpio_base, PC8736X_GPIO_RANGE);
@@ -345,3 +456,7 @@ static void __exit pc8736x_gpio_cleanup(
 
 module_init(pc8736x_gpio_init);
 module_exit(pc8736x_gpio_cleanup);
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_DESCRIPTION("NatSemi/Winbond PC-8736x GPIO Pin Driver");
+MODULE_LICENSE("GPL");
diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc3-mm2-sk/drivers/char/scx200_gpio.c roll3-m2/drivers/char/scx200_gpio.c
--- ../linux-2.6.18-rc3-mm2-sk/drivers/char/scx200_gpio.c	2006-08-06 10:18:42.000000000 -0600
+++ roll3-m2/drivers/char/scx200_gpio.c	2006-08-08 13:20:42.000000000 -0600
@@ -1,9 +1,11 @@
-/* linux/drivers/char/scx200_gpio.c
-
+/* 
    National Semiconductor SCx200 GPIO driver.  Allows a user space
    process to play with the GPIO pins.
 
-   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com> */
+   Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
+*/
+
+#define DRVNAME "scx200_gpio"
 
 #include <linux/device.h>
 #include <linux/fs.h>
@@ -21,10 +23,6 @@
 #include <linux/scx200_gpio.h>
 #include <linux/nsc_gpio.h>
 
-#define DRVNAME "scx200_gpio"
-
-static struct platform_device *pdev;
-
 MODULE_AUTHOR("Christer Weinigel <wingel@nano-system.com>");
 MODULE_DESCRIPTION("NatSemi/AMD SCx200 GPIO Pin Driver");
 MODULE_LICENSE("GPL");
@@ -33,6 +31,14 @@ static int major = 0;		/* default to dyn
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
@@ -42,10 +48,73 @@ struct nsc_gpio_ops scx200_gpio_ops = {
 	.gpio_get	= scx200_gpio_get,
 	.gpio_set	= scx200_gpio_set,
 	.gpio_change	= scx200_gpio_change,
-	.gpio_current	= scx200_gpio_current
+	.gpio_current	= scx200_gpio_current,
+	.port_size	= 32,
+	.gpio_get_port		= scx200_gpio_get_port,
+	.gpio_setclr_port	= scx200_gpio_setclr_port,
+
+	/* add these back to exploit pxa-2xx, which has separate
+	   set/clear addresses, avoiding read-modify-write cycles on
+	   the pin. (maybe)
+
+	   void	(*gpio_set_lo)		(unsigned iminor, int state);
+	   void	(*gpio_set_hi)		(unsigned iminor, int state);
+	*/
 };
 EXPORT_SYMBOL_GPL(scx200_gpio_ops);
 
+static struct gpio_attributes port0[] = {
+	GPIO_ATTRS(0,0), GPIO_ATTRS(0,1), GPIO_ATTRS(0,2),
+	GPIO_ATTRS(0,3), GPIO_ATTRS(0,4), GPIO_ATTRS(0,5),
+	GPIO_ATTRS(0,6), GPIO_ATTRS(0,7), GPIO_ATTRS(0,8),
+	GPIO_ATTRS(0,9), GPIO_ATTRS(0,10), GPIO_ATTRS(0,11),
+	GPIO_ATTRS(0,12), GPIO_ATTRS(0,13), GPIO_ATTRS(0,14),
+	GPIO_ATTRS(0,15), GPIO_ATTRS(0,16), GPIO_ATTRS(0,17),
+	GPIO_ATTRS(0,18), GPIO_ATTRS(0,19), GPIO_ATTRS(0,20),
+	GPIO_ATTRS(0,21), GPIO_ATTRS(0,22), GPIO_ATTRS(0,23),
+	GPIO_ATTRS(0,24), GPIO_ATTRS(0,25), GPIO_ATTRS(0,26),
+	GPIO_ATTRS(0,27), GPIO_ATTRS(0,28), GPIO_ATTRS(0,29),
+	GPIO_ATTRS(0,30), GPIO_ATTRS(0,31),
+};
+
+static struct gpio_attributes port1[] = {
+	GPIO_ATTRS(1,0), GPIO_ATTRS(1,1), GPIO_ATTRS(1,2),
+	GPIO_ATTRS(1,3), GPIO_ATTRS(1,4), GPIO_ATTRS(1,5),
+	GPIO_ATTRS(1,6), GPIO_ATTRS(1,7), GPIO_ATTRS(1,8),
+	GPIO_ATTRS(1,9), GPIO_ATTRS(1,10), GPIO_ATTRS(1,11),
+	GPIO_ATTRS(1,12), GPIO_ATTRS(1,13), GPIO_ATTRS(1,14),
+	GPIO_ATTRS(1,15), GPIO_ATTRS(1,16), GPIO_ATTRS(1,17),
+	GPIO_ATTRS(1,18), GPIO_ATTRS(1,19), GPIO_ATTRS(1,20),
+	GPIO_ATTRS(1,21), GPIO_ATTRS(1,22), GPIO_ATTRS(1,23),
+	GPIO_ATTRS(1,24), GPIO_ATTRS(1,25), GPIO_ATTRS(1,26),
+	GPIO_ATTRS(1,27), GPIO_ATTRS(1,28), GPIO_ATTRS(1,29),
+	GPIO_ATTRS(1,30), GPIO_ATTRS(1,31),
+};
+static struct gpio_attributes ports[] = {
+	GPIO_PORT_ATTRS(0), GPIO_PORT_ATTRS(1),
+};
+
+static void __init scx200_sysfs_init(struct device* dev)
+{
+	if (!nobits) {
+		nsc_gpio_sysfs_bits_init(dev, port0, ARRAY_SIZE(port0));
+		nsc_gpio_sysfs_bits_init(dev, port1, ARRAY_SIZE(port1));
+	}
+	if (!noports)
+		nsc_gpio_sysfs_bits_init(dev, ports, ARRAY_SIZE(ports));
+}
+static void scx200_sysfs_fini(struct device* dev)
+{
+	dev_info(dev, "scx200_sysfs_fini");
+	if (!nobits) {
+		nsc_gpio_sysfs_bits_fini(dev, port0, ARRAY_SIZE(port0));
+		nsc_gpio_sysfs_bits_fini(dev, port1, ARRAY_SIZE(port1));
+	}
+	if (!noports)
+		nsc_gpio_sysfs_bits_fini(dev, ports, ARRAY_SIZE(ports));
+}
+
+/* file API */
 static int scx200_gpio_open(struct inode *inode, struct file *file)
 {
 	unsigned m = iminor(inode);
@@ -69,7 +138,8 @@ static const struct file_operations scx2
 	.release = scx200_gpio_release,
 };
 
-static struct cdev scx200_gpio_cdev;  /* use 1 cdev for all pins */
+static struct platform_device *pdev;	/* for dev_info(&pdev->dev, */
+static struct cdev scx200_gpio_cdev;	/* use 1 cdev for all pins */
 
 static int __init scx200_gpio_init(void)
 {
@@ -92,6 +162,7 @@ static int __init scx200_gpio_init(void)
 
 	/* nsc_gpio uses dev_dbg(), so needs this */
 	scx200_gpio_ops.dev = &pdev->dev;
+	scx200_gpio_ops.dev->driver_data = &scx200_gpio_ops;
 
 	if (major) {
 		devid = MKDEV(major, 0);
@@ -108,6 +179,8 @@ static int __init scx200_gpio_init(void)
 	cdev_init(&scx200_gpio_cdev, &scx200_gpio_fileops);
 	cdev_add(&scx200_gpio_cdev, devid, MAX_PINS);
 
+	scx200_sysfs_init(&pdev->dev);
+
 	return 0; /* succeed */
 
 undo_platform_device_add:
@@ -120,6 +193,7 @@ undo_malloc:
 
 static void __exit scx200_gpio_cleanup(void)
 {
+	scx200_sysfs_fini(&pdev->dev);
 	cdev_del(&scx200_gpio_cdev);
 	/* cdev_put(&scx200_gpio_cdev); */
 
diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc3-mm2-sk/include/linux/nsc_gpio.h roll3-m2/include/linux/nsc_gpio.h
--- ../linux-2.6.18-rc3-mm2-sk/include/linux/nsc_gpio.h	2006-07-30 11:31:26.000000000 -0600
+++ roll3-m2/include/linux/nsc_gpio.h	2006-08-08 16:55:35.000000000 -0600
@@ -1,19 +1,16 @@
 /**
-   nsc_gpio.c
-
    National Semiconductor GPIO common access methods.
 
-   struct nsc_gpio_ops abstracts the low-level access
-   operations for the GPIO units on 2 NSC chip families; the GEODE
-   integrated CPU, and the PC-8736[03456] integrated PC-peripheral
-   chips.
+   struct nsc_gpio_ops abstracts the low-level access operations for
+   the GPIO units on 2 NSC chip families; the GEODE integrated CPU
+   SC-1100, and the PC-8736[03456] integrated PC-peripheral chips.
 
    The GPIO units on these chips have the same pin architecture, but
    the access methods differ.  Thus, scx200_gpio and pc8736x_gpio
    implement their own versions of these routines; and use the common
    file-operations routines implemented in nsc_gpio module.
 
-   Copyright (c) 2005 Jim Cromie <jim.cromie@gmail.com>
+   Copyright (c) 2005,2006 Jim Cromie <jim.cromie@gmail.com>
 
    NB: this work was tested on the Geode SC-1100 and PC-87366 chips.
    NSC sold the GEODE line to AMD, and the PC-8736x line to Winbond.
@@ -21,15 +18,39 @@
 
 struct nsc_gpio_ops {
 	struct module*	owner;
-	u32	(*gpio_config)	(unsigned iminor, u32 mask, u32 bits);
+	struct device*	dev;	/* for dev_dbg() support, set in init  */
+	u8	port_size;	/* 8 or 32 so far. 32 max */
+
+	/* config ctrl & human desc */
+	u32	(*gpio_config)	(unsigned iminor, u32 bits, u32 clr);
 	void	(*gpio_dump)	(struct nsc_gpio_ops *amp, unsigned iminor);
-	int	(*gpio_get)	(unsigned iminor);
+
+	/* bit-wide value interface */
+	u32	(*gpio_get)	(unsigned iminor);
 	void	(*gpio_set)	(unsigned iminor, int state);
 	void	(*gpio_change)	(unsigned iminor);
-	int	(*gpio_current)	(unsigned iminor);
-	struct device*	dev;	/* for dev_dbg() support, set in init  */
+	u32	(*gpio_current)	(unsigned iminor);
+
+	/* want to restore set-hi()/set-lo() for PXA, which has
+	   separate set and clear registers/insns, allowing PXA to
+	   avoid read-modify-write cycles (IIUC).  Im missing
+	   something though, since RMW cycles dont pertain to single
+	   bits, but rather to ports (where an RMW is needed to
+	   preserve un-changed bits) void (*gpio_set_hi) (unsigned
+	   iminor); void (*gpio_set_lo) (unsigned iminor);
+	*/
+
+	/* port-wide accessors (thanks Chris).  For hardware which can
+	   exploit it, gpio_setclr_port() separates set and clear
+	   params to avoid Read-Modify-Write cycles.
+	*/
+	u32	(*gpio_get_port)	(unsigned portnum);
+	void	(*gpio_set_port)	(unsigned portnum, u32 bits);
+	void	(*gpio_setclr_port)	(unsigned portnum, u32 bits, u32 clr);
+	u32	(*gpio_current_port)	(unsigned iminor);
 };
 
+/* fileops user-API */
 extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
 			      size_t len, loff_t *ppos);
 
@@ -38,3 +59,226 @@ extern ssize_t nsc_gpio_read(struct file
 
 extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index);
 
+
+/* GPIO-sysfs model */
+#include <linux/device.h>
+#include <linux/sysfs.h>
+
+/* basic gpio-sysfs object, with 3-D addressing.  This allows the use
+   of combined-callbacks which decode the 3-D parameters, and perform
+   the selected operation. (We only use 2 axes, but keeping all 3 has
+   almost no cost, and gives more info and flexibility
+*/
+struct gpio_dev_attr {
+        struct device_attribute dev_attr;
+	u8 bitnum;		/* bit index */
+	u8 portnum;		/* port index */
+	u8 fn_slct;		/* feature selector */
+	u8 bit_port_type;	/* GPIO_BIT, GPIO_PORT */
+};
+#define GPIO_BIT_TYPE	0
+#define GPIO_PORT_TYPE	1
+
+#define to_gpio_dev_attr(d) container_of(d, struct gpio_dev_attr, dev_attr)
+
+/* constants for 3 aspects of Pin Features used to initialize the
+   dev_attrs needed for the gpio-object's attr-files
+
+   PF_SFX - pin-feature dev-attr filename suffix.  Might be nice to
+   make these driver-configurable (L8r)
+
+   PF_CMD - commands: constants are borrowed from fileops write
+   handler. The sysfs callbacks see them in the fn_slct field, so the
+   *_config handlers switch(fn_slct) to fetch the right bits.
+
+   PF_MASK - pin-feature mask, ie config bits understood by the 2
+   client drivers of this module (scx200_gpio, pc8736x_gpio).  This is
+   too coupled to the features exposed by nsc_gpio_ops->gpio_config(),
+   but its a simple re-do of the fileops write-handler.
+
+   The cmd-set has expanded to cover all pin-features, not just
+   'config' features, notably 'V' for values and 'C' for
+   current-values.
+*/
+#define PF_SFX_OUT_ENA		_output_enabled
+#define PF_SFX_TOTEM		_totem
+#define PF_SFX_PULLUP		_pullup_enabled
+#define PF_SFX_LOCKED		_locked
+#define PF_SFX_DEBOUNCE		_debounced
+#define PF_SFX_INT_ENA		_int_enabled	/* too exposing !?! */
+#define PF_SFX_INT_TRIG		_int_level_trig
+
+#define PF_CMD_OUT_ENA		'O'	/* 'o' tristate */
+#define PF_CMD_TOTEM		'T'	/* 't' open-drain */
+#define PF_CMD_PULLUP		'P'	/* 'p' disables pullup */
+#define PF_CMD_LOCKED		'L'	/* no unlock */
+/* these are newer than 18-rcX */
+#define PF_CMD_DEBOUNCE		'D'	/* 'd' disables */
+#define PF_CMD_INT_ENA		'I'	/* too exposing !?! */
+#define PF_CMD_INT_TRIG		'E'	/* 'e' level-triggered */
+
+#define PF_MASK_OUT_ENA		1	/* !tristate */
+#define PF_MASK_TOTEM		2	/* !open-drain */
+#define PF_MASK_PULLUP		4	/* !open-drain */
+#define PF_MASK_LOCKED		8	/* no unlock possible */
+#define PF_MASK_INT_ENA		16	/* some pins cant do this */
+#define PF_MASK_INT_TRIG	32	/* level !edge */
+#define PF_MASK_DEBOUNCE	64
+
+/* constants for expanded feature-set */
+#define PF_SFX_VALUE		_value		/* input on pin */
+#define PF_SFX_CURR		_current	/* last written value */
+#define PF_SFX_STATUS		_status		/* _config ?? */
+
+#define PF_CMD_VALUE		'V'	/* values-in often port-wide */
+#define PF_CMD_CURR		'C'	/* current values-out */
+#define PF_CMD_STATUS		'S'	/* possible chardev emulation */
+
+#define PF_MASK_VALUE		0	/* not for gpio_config() */
+#define PF_MASK_CURR		0	/* use <0 if differences needed */
+#define PF_MASK_STATUS		0
+
+
+struct gpio_attributes {
+	struct gpio_dev_attr value;	/* hw often is port-wide here */
+	struct gpio_dev_attr curr;	/* driven value, may be != value */
+
+	/* pin-features, which are mostly use-once, so hw often
+	   provides it per-pin only. */
+	struct gpio_dev_attr oe;	/* output-enable, !tristate */
+	struct gpio_dev_attr totem;	/* !open-drain */
+	struct gpio_dev_attr pue;	/* pullup-enabled */
+	struct gpio_dev_attr bounce;	/* debounce circuit active */
+	struct gpio_dev_attr locked;	/* once locked, no unlock */
+	struct gpio_dev_attr status;	/* device-file compat-hack */
+
+	struct gpio_dev_attr int_en;	/* interrupt enable */
+	struct gpio_dev_attr int_lvl;	/* int on level !edge */
+};
+
+/* GPIO_ATTRS and GPIO_PORT_ATTRS macros let driver declare the
+   interfaces for the underlying hardware:
+
+   static struct gpio_attributes port_0[] = {
+	GPIO_ATTRS(0,0), GPIO_ATTRS(0,1), ... GPIO_ATTRS(0,31) };
+
+   static struct gpio_attributes port_set[] = {
+	GPIO_PORT_ATTRS(0,32), GPIO_PORT_ATTRS(1,32) };
+*/
+
+#define GPIO_PIN(Port, Bit, Suffix, Mode, Show, Store, Cmd) 	\
+	{	.dev_attr = __ATTR( bit_ ## Port.Bit ## Suffix,		\
+				    Mode, Show, Store),			\
+		.bitnum = Bit,						\
+		.portnum = Port,					\
+		.fn_slct = Cmd,						\
+		.bit_port_type = GPIO_BIT_TYPE 	}
+
+#define SYSFS_CB_RD(Access) nsc_gpio_sysfs_get_ ## Access
+#define SYSFS_CB_WR(Access) nsc_gpio_sysfs_set_ ## Access
+#define SYSFS_CB_NULL	    (void*)0
+
+#define GPIO_ATTR(Portnum, Bitnum, Feat, Suffix, Access)	\
+	GPIO_PIN(Portnum, Bitnum, Suffix,			\
+		 S_IWUSR | S_IRUGO,				\
+		 SYSFS_CB_RD(Access), SYSFS_CB_WR(Access), Feat)
+
+/* WARNING: this macro hardwires one of 2 sysfs-callbacks (port-wide
+   vs bit-wide access) to each attr.  This is broken, since each GPIO
+   driver (ie author) must determine whether each feature is exposed
+   per-pin or port-wide.  ATM, they can only copy and modify this
+   macro.  But then, theyre already wed to the nsc_gpio_ops ;-)
+*/
+#define GPIO_ATTRS(Port, Idx) {					\
+	.value	= GPIO_ATTR(Port, Idx, PF_CMD_VALUE,	PF_SFX_VALUE,	bitval), \
+	.curr	= GPIO_ATTR(Port, Idx, PF_CMD_CURR,	PF_SFX_CURR,	bitval), \
+	.oe	= GPIO_ATTR(Port, Idx, PF_CMD_OUT_ENA,	PF_SFX_OUT_ENA,	bitconf), \
+	.pue	= GPIO_ATTR(Port, Idx, PF_CMD_PULLUP,	PF_SFX_PULLUP,	bitconf), \
+	.totem	= GPIO_ATTR(Port, Idx, PF_CMD_TOTEM,	PF_SFX_TOTEM,	bitconf), \
+	.locked	= GPIO_ATTR(Port, Idx, PF_CMD_LOCKED,	PF_SFX_LOCKED,	bitconf), \
+	.bounce	= GPIO_ATTR(Port, Idx, PF_CMD_DEBOUNCE,	PF_SFX_DEBOUNCE,bitconf), \
+	.status	= GPIO_ATTR(Port, Idx, PF_CMD_STATUS,	PF_SFX_STATUS,  bitconf), \
+	.int_en	= GPIO_ATTR(Port, Idx, PF_CMD_INT_ENA,	PF_SFX_INT_ENA, bitconf), \
+	.int_lvl= GPIO_ATTR(Port, Idx, PF_CMD_INT_TRIG,	PF_SFX_INT_TRIG,bitconf) \
+}
+	
+/* port-wide sysfs access */
+
+#define GPIO_PORT(Port, Sfx, Mode, Show, Store, Cmd)		\
+	{	.dev_attr	= __ATTR( port_ ## Port ## Sfx,	\
+					  Mode, Show, Store),	\
+		.portnum	= Port,				\
+		.bitnum		= -1,				\
+		.fn_slct	= Cmd,				\
+		.bit_port_type = GPIO_PORT_TYPE	}
+
+#define GPIO_PORT_ATTR(Portnum, Cmd, Suffix, Access)		\
+	GPIO_PORT( Portnum, Suffix,				\
+		   S_IWUSR | S_IRUGO,				\
+		   SYSFS_CB_RD(Access), SYSFS_CB_WR(Access), Cmd)
+
+/* WARNING: same caveats as above apply, only moreso */
+
+#define GPIO_PORT_ATTRS(Port) {					\
+	.value	= GPIO_PORT_ATTR(Port, PF_CMD_VALUE,	PF_SFX_VALUE,	portval), \
+	.curr	= GPIO_PORT_ATTR(Port, PF_CMD_CURR,	PF_SFX_CURR,	portval), \
+	.oe	= GPIO_PORT_ATTR(Port, PF_CMD_OUT_ENA,	PF_SFX_OUT_ENA, portconf), \
+	.pue	= GPIO_PORT_ATTR(Port, PF_CMD_PULLUP,	PF_SFX_PULLUP,	portconf), \
+	.totem	= GPIO_PORT_ATTR(Port, PF_CMD_TOTEM,	PF_SFX_TOTEM,	portconf), \
+	.locked	= GPIO_PORT_ATTR(Port, PF_CMD_LOCKED,	PF_SFX_LOCKED,  portconf), \
+	.bounce	= GPIO_PORT_ATTR(Port, PF_CMD_DEBOUNCE,	PF_SFX_DEBOUNCE,portconf), \
+	.status	= GPIO_PORT_ATTR(Port, PF_CMD_STATUS,	PF_SFX_STATUS,  portconf), \
+	.int_en	= GPIO_PORT_ATTR(Port, PF_CMD_INT_ENA,	PF_SFX_INT_ENA, portconf), \
+	.int_lvl= GPIO_PORT_ATTR(Port, PF_CMD_INT_TRIG,	PF_SFX_INT_TRIG,portconf) \
+}
+
+/* attr-file callbacks, named per glob-name:
+   nsc_gpio_sysfs_{get,set}_{bit,port}{val,conf}
+
+   -bitval,portval separate for speed, simplicity
+   -bitconf is combo-callback, handling slower, per-pin properties
+   -portconf - synthesize port-wide from bit-wide
+   -get,set as required by fn-prototypes
+*/
+extern ssize_t nsc_gpio_sysfs_get_bitval(struct device *dev,
+					 struct device_attribute *devattr,
+					 char *buf);
+extern ssize_t nsc_gpio_sysfs_set_bitval(struct device *dev,
+					 struct device_attribute *devattr,
+					 const char *buf, size_t count);
+
+extern ssize_t nsc_gpio_sysfs_get_portval(struct device *dev,
+					  struct device_attribute *devattr,
+					  char *buf);
+extern ssize_t nsc_gpio_sysfs_set_portval(struct device *dev,
+					  struct device_attribute *devattr,
+					  const char *buf, size_t count);
+
+
+extern ssize_t nsc_gpio_sysfs_get_bitconf(struct device *dev,
+					  struct device_attribute *devattr,
+					  char *buf);
+extern ssize_t nsc_gpio_sysfs_set_bitconf(struct device *dev,
+					  struct device_attribute *devattr,
+					  const char *buf, size_t count);
+
+extern ssize_t nsc_gpio_sysfs_get_portconf(struct device *dev,
+					   struct device_attribute *devattr,
+					   char *buf);
+extern ssize_t nsc_gpio_sysfs_set_portconf(struct device *dev,
+					   struct device_attribute *devattr,
+					   const char *buf, size_t count);
+
+
+/* device-create-file for all attrs, all bits in port.
+   called by higher level client _inits unless nobits=1.
+   Also called for ports-init !!
+*/
+extern void nsc_gpio_sysfs_bits_init(struct device* dev,
+				     struct gpio_attributes pp[],
+				     int numdevs);
+
+extern void nsc_gpio_sysfs_bits_fini(struct device* dev,
+				     struct gpio_attributes pp[],
+				     int numdevs);
+
diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-rc3-mm2-sk/include/linux/scx200_gpio.h roll3-m2/include/linux/scx200_gpio.h
--- ../linux-2.6.18-rc3-mm2-sk/include/linux/scx200_gpio.h	2006-08-06 10:19:38.000000000 -0600
+++ roll3-m2/include/linux/scx200_gpio.h	2006-08-08 12:51:09.000000000 -0600
@@ -18,7 +18,7 @@ extern struct nsc_gpio_ops scx200_gpio_o
 
 /* returns the value of the GPIO pin */
 
-static inline int scx200_gpio_get(unsigned index) {
+static inline u32 scx200_gpio_get(unsigned index) {
 	__SCx200_GPIO_BANK;
 	__SCx200_GPIO_IOADDR + 0x04;
 	__SCx200_GPIO_INDEX;
@@ -30,7 +30,7 @@ static inline int scx200_gpio_get(unsign
    driven if the GPIO is configured as an output, it might not be the
    state of the GPIO right now if the GPIO is configured as an input) */
 
-static inline int scx200_gpio_current(unsigned index) {
+static inline u32 scx200_gpio_current(unsigned index) {
         __SCx200_GPIO_BANK;
 	__SCx200_GPIO_INDEX;
 		
@@ -83,6 +83,30 @@ static inline void scx200_gpio_change(un
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
+static inline void scx200_gpio_setclr_port(unsigned port, u32 bits, u32 mask)
+{
+	unsigned bank = port & 0x1f;
+	__SCx200_GPIO_IOADDR;
+	__SCx200_GPIO_SHADOW;
+	*shadow = (*shadow & ~mask) | (bits & mask);
+	__SCx200_GPIO_OUT;
+}
+
+static inline void scx200_gpio_set_port(unsigned port, u32 bits)
+{
+	scx200_gpio_setclr_port(port, bits, ~bits);
+}
+
 #undef __SCx200_GPIO_BANK
 #undef __SCx200_GPIO_IOADDR
 #undef __SCx200_GPIO_SHADOW


