Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWFQSmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWFQSmc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWFQSmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:42:32 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:11387 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWFQSmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:42:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=s5V7Hg2D6Uun7HvYsPqnPY0FgY6PW30vtm0YUDb7mdjr5rqTckL7UQwsFYuI0cvr2qY4hEbfdEIuUDEB6ZuDWfB2aMeYiRzjukOO8p06KV0+cZ9lipE7iuvCmP4F0c1l9spub/j5THwoltcoqsmfxxt7D6SM/B1XOxwv036SuNs=
Message-ID: <44944D14.2000308@gmail.com>
Date: Sat, 17 Jun 2006 12:42:28 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 20/20 RFC] chardev: GPIO for SCx200 & PC-8736x: add sysfs-GPIO
 interface
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, 

heres the brand-spanking-new proto-sysfs-gpio interface,
preceded by some pseudo/proto-Documentation.



[jimc@harpo gpio-scx]$ more gpio-design-sysfs

Sysfs GPIO representation of Hardware (v0.3)
(v0.1 went to lm-sensors ML)
(v0.2 reviewed privately by a microcontroller jockey)

We need a standard rep for GPIO in sysfs, so heres a strawman.
Strike a match, lets have a campfire!

Essentially, this seeks to describe the directory of
'device-attribute-files' that are populated by a driver

forex:

soekris:/sys/bus/platform/devices/pc8736x_gpio.0# ls
bit_0.0_debounced       bit_1.2_totem           bit_2.5_pullup_enabled
bit_0.0_locked          bit_1.3_debounced       bit_2.5_totem
bit_0.0_output_enabled  bit_1.3_locked          bit_2.6_debounced
bit_0.0_pullup_enabled  bit_1.3_output_enabled  bit_2.6_locked
bit_0.0_totem           bit_1.3_pullup_enabled  bit_2.6_output_enabled
bit_0.1_debounced       bit_1.3_totem           bit_2.6_pullup_enabled
bit_0.1_locked          bit_1.4_debounced       bit_2.6_totem
bit_0.1_output_enabled  bit_1.4_locked          bit_2.7_debounced
bit_0.1_pullup_enabled  bit_1.4_output_enabled  bit_2.7_locked
bit_0.1_totem           bit_1.4_pullup_enabled  bit_2.7_output_enabled
bit_0.2_debounced       bit_1.4_totem           bit_2.7_pullup_enabled
bit_0.2_locked          bit_1.5_debounced       bit_2.7_totem
...

(Ive now seen *1.5* GPIO architectures, so please test this writeup
mentally against your GPIO experience).


Basic device-file Naming Convention.

I havent seen this stated anywhere at an 'all-of-sysfs-level' and I
think its true/valid (and so test this here - CMIIW).  If Im correct,
please suggest the optimal Doc/* file to contain this info.

All device-attr-files are named as <prefix>_<id>_<suffix>

in LM-sensors:
- prefix        sensor-type: in(volts), temp, fan, etc. (no trailing '_')
- id            usually single integer
- suffix        the sensor attribute in question.





GPIO-sysfs Prefix Names.

Basically, GPIO hardware design appears to have 2 top-level factors;
pin features, and pin-to-port grouping.  These are mapped onto
filename prefixes & suffixes.

All GPIOs (Ive seen) are organized as 1+ ports of 8-32 bits.  The
bits' attributes are addressable individually, but are also accessible
as a group via the port_* files.  If you change a bit-attribute, that
change will also exhibit in the port attr too.

IOW, we have bit_*, port_*.  They are interconnected at the hardware
level, and (I think) there is no need for inter-locks between the
sysfs handlers for bit_ and port_ (except for shadow regs, but I
digress)

In fact, it might be nice to have the option of not creating the bit_*
sysfs-device-files.  For apps where user-code is doing its own
bit-masking, the kernel could avoid some unused overheads.  OTOH, this
might be silly, premature, overoptimization.  This would be controlled
- assuming its worthwhile - by a modparam; 'nobits' or 'portsonly'


GPIO Architectures

GPIO pins have lots of hardware / architectural / naming-convention
variations, which makes this harder.  My simplifying assumption is
that drivers should reflect the hardware capabilities directly (or
very nearly so), and push the abstraction to user-space (at least in
part).  Obviously this needs

Drivers should create sysfs 'files' only for attributes that are
pertinent for the hardware being driven.  Ths way, the absense or
presense of files communicates functionality, as does their
readonlyness.  (these 'behaviors' may be different than lm-sensors)

Forex:
if a pin is input  only, it shouldnt have an _output_enabled attr.
if a pin is output only, it shouldnt have an _output_enabled attr.

This way, `ls` tells you that a particular port/bit cannot possibly
drive a value out of the chip.

- one of several different values (otherwize why show it ?
  After all, you dont to be told that PI=3.14159...)
- changed.  if a pin cannot be output, theres nothing to enable, and
  showing the attribute is confusing.

OTOH, a readonly _output_enabled would also convey info.


yield the same, but not as
visibly (ls vs ls -l)

So, Im somewhat ambivalent here, looking for input....


User-Space

Following LM-sensors approach, a user-side library would add the
niceties:

- provide any equivalences needed by users
  ie bit_x_tristate = ! bit_x_output_enabled.

- sub-port allocation and management.
  support for 3+3+2 bit sub-ports on an 8 bit port would be nice

I suspect that a sophisticated programmer would be able to add a
sub-port allocation facility w/in the driver.  I cannot,



GPIO Pin Features

As outlined above, pin features are represented as _<suffixes>

1st: there are several alternative naming schemes:

- name-as-verb          _output_enable          (conveys an 'action')
- name-as-state         _output_enabled         (conveys a 'current state')
- feature-name          _output                 (a knob to turn)
- feature+state         _output+(currval)       (currval in name is bad idea)

1,2 are quite close.  Ive done 2.

FWIW, heres the pin attributes of my GPIOs, as expressed in the syslog
by the legacy drivers: (these are

[15510.384000]  pc8736x_gpio.0: io16: 0x0004 TS OD PUE  EDGE LO         io:0/1
[15510.564000]  pc8736x_gpio.0: io17: 0x0004 TS OD PUE  EDGE LO         io:1/1
[15510.744000]  pc8736x_gpio.0: io18: 0x0004 TS OD PUE  EDGE LO         io:1/1
[15510.928000]  pc8736x_gpio.0: io19: 0x0004 TS OD PUE  EDGE LO         io:1/1


# whether output-drive is on/off
_output_enable          # 1 or 0,
_tristate               # ! _output_enable, logically linked.

Now, theres no need to have both of these; if there were, they would
have to be intrinsically linked (logically opposite values).

IOW, drivers should name the file as one of possible states of the
feature, which ever best describes it, and not expose it 2x.

To the extent that we need support for '_tristate' version of a
'_output_enabled' sysfs-file, user-space (libraries) should provide
that support.

# output circuit configuration
_opendrain              # only 1 transistor, can sink current from pin
_totem                  # has 2nd transistor, can drive pin hi.
_pushpull               # alias for _totempole

Ive chosen _totem as the attribute name

_pullup_enabled         # pin tied to power via resistor.
_pullup_off             # duh
_pullup_no              # how many aliases ?

_debounce               # present if supported, 0 if off, 1 if on.

It kinda works, but the pullup is a bit ugly, and all the aliases
suggest some semantic difficulty/mismatch/incompleteness, but adding
them all definitely creates clutter and has reached diminished
incremental value.


If hardware doesnt support a feature, like _opendrain, it:

 - sets _pushpull to 1, readonly ?
 - sets _opendrain to 0, readonly ?
    OR never creates _opendrain ?

Doing either of these works to communicate the feature-set to
user-space, but not creating _opendrain when pin doesnt do it means
that the file's presense communicates this; IOW, user issues 'ls', not
'ls -l' to find out.

(continuing strawman)

_value          # read the pin
(no-suffix)     # alias for _value

_current        # the value 'driven' by the pin (last written)

And here we can see some potential (user) difficulties;
under some conditions,
- read-value = current-value

but not on these:
- pin is input-only/tristate - (current is irrelevant, except as 'state')
- pin is over-driven by attached circuit
-- pin cannot sink/supply sufficient current

Detecting these situations is both hardware and circuit dependent, and
properly belongs in user-space.  It sounds a lot like what lm-sensors
does already.

For the 2 drivers Ive 'experienced', pin control was via device-file,
with this command-set.  Presumably the correspondence with the sysfs
strawman above is obvious.

case 'O':        output enabled
case 'o':        output disabled
case 'T':        output is push pull
case 't':        output is open drain
case 'P':        pull up enabled
case 'p':        pull up disabled




Port Organization.

My *vast* experience (with 1.5 GPIO architectures) suggests that all
chips organize their GPIOs into one or more ports.  Each port supports
reading and writing all bits simultaneously.

Some hardware also supports reading/writing pin-properties like
output-enable in a single-word (todo-research).  Drivers for these
hardwares could/should create attributes for each pin-property that is
accessible as a bit-vector.

Further, port (and pin) capabilities generally vary by port; hardware
will typically put a full set of features on 1 port, and less on
others, expecting a designer to allocate functions to pins
accordingly.  Forex, on the pc8736x chip, port 0 can issue interrupts,
so those pins should have extra properties.

These capabilities must be cleanly representable in any worthwhile
sysfs/GPIO model (and we continue to test this strawman)..


Port-names and Pin-names

# prefixes (note the trailing _)
port_[0..P]_
bit_[P]_[0..bits-per-word]_

Getting past the port/bit names, these files are populated by the
driver according to the device.  For the 2 drivers Ive touched, heres
the table:

driver:         ports   bits-per-port
scx200_gpio     1       32
pc8736x_gpio    4       8




Strawman tie-together:

bit_0_0_output_enable   # shows current output-drive of port 0 bit 0
bit_0_0_value
bit_0_0                 # 2 reads of same bit

# lessee what happens :->
port_0_value_bin        # 1-4 bytes typically returned (depending on device)
port_0_value_hex        # converted to human readable, always printable
port_0_value            #

port_1_output_enable    # read/write vector of enable bits to port
port_1_<suffix_set>     #


The driver should know which properties are readable/writable in a
bit-vector basis, and expose those sysfs-attributes only.  Thus the
presense of the port_N_value* attrs implies that all the bits in that
port are readable at once.

If the driver doesnt expose forex: port_1_output_enable, user-space is
free to loop over each bit, in essence 'emulating' the port-wide
operation.


RESTATING - whats above kinda hangs together.

NEXT - muddles

pin_XY_output_state     # one-of( 'output_enable', 'tristate')

This might be convenient for some situations, but probably is needless
complication / obfuscation.


pin_XY_state_bin                # binary state reader

This is intended an 'escape-valve' for things that are turn out to be
cumbersome with the above.  This is probably tantamount to an IOCTL,
so might be a hugely bad idea.


pin_XY_interrupt_enable        #
pin_XY_interrupt_trigger_edge
pin_XY_interrupt_trigger_level
pin_XY_interrupt_trigger_edge_rising
pin_XY_interrupt_trigger_edge_falling
pin_XY_interrupt_trigger_level_hi
pin_XY_interrupt_trigger_level_lo

Well - thats a big one - Do we expose any of this ?
- the ability to enable / disable / control hardware interrupt
- or is that insane meddling in such affairs ?

We cant afterall allow mapping of the actual interrupt handler, that
does sound insane (unless hugely carefull)

With the new genirq architecture, things are apparently more
orthogonal, which suggests there might be something to control by
means of attributes such as above.

Further, any of the above attributes could readily be RO; they would
convey info thats at least useful, even if 'control' is too exposing.

Forex, somewhere during boot, the APIC is setup to handle interrupts;
at this point its probably known what the configured state of all
interrrupts is, and this info could be exposed here.  Whether that has
sufficient value is unclear, and certainly not for v.submit-1


when a pin is level-triggered (presumably this can be
determined early in the boot process, as soon as APIC etc would be


setup), the _edge_* attributes vanish, and the _level_{hi,lo} attrs
are set 1/0, and RO.


OK - IM DONE.

Please be liberal with feedback -
- this is wrong
- poorly explained -
- correct ... - boil this down - reduce to a guiding statement
- strip out conjectures





diff -ruNp -X dontdiff -X exclude-diffs am-19/drivers/char/nsc_gpio.c am-20/drivers/char/nsc_gpio.c
--- am-19/drivers/char/nsc_gpio.c	2006-06-14 21:38:14.000000000 -0600
+++ am-20/drivers/char/nsc_gpio.c	2006-06-14 22:31:07.000000000 -0600
@@ -13,6 +13,8 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
@@ -39,63 +41,96 @@ void nsc_gpio_dump(struct nsc_gpio_ops *
 		 amp->gpio_get(index), amp->gpio_current(index));
 }
 
+/* the pin-mode-change 'commands' of the legacy device-file-interface,
+   now refactored for reuse in a sysfs-interface.  Includes some
+   updates which arent exposed via sysfs attributes.
+*/
+static int common_write(struct nsc_gpio_ops *amp, char c, unsigned m)
+{
+       struct device *dev = amp->dev;
+       int err = 0;
+       switch (c) {
+       case '0':
+               amp->gpio_set(m, 0);
+               break;
+       case '1':
+               amp->gpio_set(m, 1);
+               break;
+       case 'O':
+               dev_dbg(dev, "GPIO%d output enabled\n", m);
+               amp->gpio_config(m, ~1, 1);
+               break;
+       case 'o':
+               dev_dbg(dev, "GPIO%d output disabled\n", m);
+               amp->gpio_config(m, ~1, 0);
+               break;
+       case 'T':
+               dev_dbg(dev, "GPIO%d output is push pull\n", m);
+               amp->gpio_config(m, ~2, 2);
+               break;
+       case 't':
+               dev_dbg(dev, "GPIO%d output is open drain\n", m);
+               amp->gpio_config(m, ~2, 0);
+               break;
+       case 'P':
+               dev_dbg(dev, "GPIO%d pull up enabled\n", m);
+               amp->gpio_config(m, ~4, 4);
+               break;
+       case 'p':
+               dev_dbg(dev, "GPIO%d pull up disabled\n", m);
+               amp->gpio_config(m, ~4, 0);
+               break;
+       case 'L':
+               dev_dbg(dev, "GPIO%d lock pin\n", m);
+               amp->gpio_config(m, ~8, 8);
+               break;
+       case 'l':
+               dev_warn(dev, "GPIO%d cant unlock locked? pin\n", m);
+               amp->gpio_config(m, ~8, 0);
+               break;
+
+       case 'D':
+               dev_dbg(dev, "GPIO%d turn on debounce\n", m);
+               amp->gpio_config(m, ~PF_DEBOUNCE, PF_DEBOUNCE);
+               break;
+       case 'd':
+               dev_warn(dev, "GPIO%d cant unlock locked? pin\n", m);
+               amp->gpio_config(m, ~PF_DEBOUNCE, 0);
+               break;
+
+       case 'v':
+               /* View Current pin settings */
+               amp->gpio_dump(amp, m);
+               break;
+       case 'c':
+               /* view pin's current values: driven and read */
+               dev_info(dev, "io%02d: driven %d, input %d\n",
+                        m, amp->gpio_current(m), amp->gpio_get(m));
+               break;
+       case '\n':
+               /* end of settings string, do nothing */
+               break;
+       default:
+               dev_err(dev, "GPIO-%2d bad setting: chr<0x%2x>\n", m,
+                       (int)c);
+               err++;
+       }
+       return err;
+}
+
 ssize_t nsc_gpio_write(struct file *file, const char __user *data,
 		       size_t len, loff_t *ppos)
 {
+	int i, err = 0;
 	unsigned m = iminor(file->f_dentry->d_inode);
 	struct nsc_gpio_ops *amp = file->private_data;
-	struct device *dev = amp->dev;
-	size_t i;
-	int err = 0;
 
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
-
-		case 'v':
-			/* View Current pin settings */
-			amp->gpio_dump(amp, m);
-			break;
-		case '\n':
-			/* end of settings string, do nothing */
-			break;
-		default:
-			dev_err(dev, "GPIO-%2d bad setting: chr<0x%2x>\n", m,
-			       (int)c);
-			err++;
-		}
+
+		err += common_write(amp, c, m);
 	}
 	if (err)
 		return -EINVAL;	/* full string handled, report error */
@@ -122,6 +157,85 @@ EXPORT_SYMBOL(nsc_gpio_write);
 EXPORT_SYMBOL(nsc_gpio_read);
 EXPORT_SYMBOL(nsc_gpio_dump);
 
+
+/* now sysfs versions.  We use 2D addressing, using struct
+   sensor_device_attribute_2's .index and .nr members, with which we
+
+   Slightly complicating things, these declarations must be made in
+   the client modules of this one, ie scx200 & pc8736x _gpio.  They
+   also must set device.driver_data to amp, as thats needed by
+   sysfs_set_value()
+*/
+
+ssize_t nsc_gpio_sysfs_set(struct device *dev,
+			   struct device_attribute *devattr, const char *buf,
+			   size_t count)
+{
+        struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
+        int idx = attr->index;
+        int func = attr->nr;
+	struct nsc_gpio_ops *amp = dev->driver_data;
+	int err, xor;
+
+	/* invert cmd if setting low */
+	xor = simple_strtol(buf, NULL, 10) ? 0 : 'T'^'t';
+
+	dev_info(dev, "set func:%d  Func:%d, flp%d\n", func, func^xor, xor);
+
+	err = common_write(amp, func^xor, idx);
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
+        int idx = attr->index;
+        int func = attr->nr;
+        unsigned res = -1;
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
 static int __init nsc_gpio_init(void)
 {
 	printk(KERN_DEBUG NAME " initializing\n");
diff -ruNp -X dontdiff -X exclude-diffs am-19/drivers/char/pc8736x_gpio.c am-20/drivers/char/pc8736x_gpio.c
--- am-19/drivers/char/pc8736x_gpio.c	2006-06-14 21:37:51.000000000 -0600
+++ am-20/drivers/char/pc8736x_gpio.c	2006-06-14 21:39:03.000000000 -0600
@@ -17,6 +17,8 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/mutex.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/nsc_gpio.h>
 #include <linux/platform_device.h>
 #include <asm/uaccess.h>
@@ -251,6 +253,52 @@ static struct file_operations pc8736x_gp
 	.read	= nsc_gpio_read,
 };
 
+/* insert some sysfs decls and inits */
+
+static struct gpio_pin_attributes port0[] = {
+	GPIO_ATTRS(0,0), GPIO_ATTRS(0,1), GPIO_ATTRS(0,2), GPIO_ATTRS(0,3),
+	GPIO_ATTRS(0,4), GPIO_ATTRS(0,5), GPIO_ATTRS(0,6), GPIO_ATTRS(0,7),
+};
+
+static struct gpio_pin_attributes port1[] = {
+	GPIO_ATTRS(1,0), GPIO_ATTRS(1,1), GPIO_ATTRS(1,2), GPIO_ATTRS(1,3),
+	GPIO_ATTRS(1,4), GPIO_ATTRS(1,5), GPIO_ATTRS(1,6), GPIO_ATTRS(1,7),
+};
+
+static struct gpio_pin_attributes port2[] = {
+	GPIO_ATTRS(2,0), GPIO_ATTRS(2,1), GPIO_ATTRS(2,2), GPIO_ATTRS(2,3),
+	GPIO_ATTRS(2,4), GPIO_ATTRS(2,5), GPIO_ATTRS(2,6), GPIO_ATTRS(2,7),
+};
+
+static struct gpio_pin_attributes port3[] = {
+	GPIO_ATTRS(3,0), GPIO_ATTRS(3,1), GPIO_ATTRS(3,2), GPIO_ATTRS(3,3),
+	GPIO_ATTRS(3,4), GPIO_ATTRS(3,5), GPIO_ATTRS(3,6), GPIO_ATTRS(3,7),
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
+static void __init pc8736x_sysfs_init(struct device* dev)
+{
+	nsc_gpio_sysfs_port_init(dev, port0, 8);
+	nsc_gpio_sysfs_port_init(dev, port1, 8);
+	nsc_gpio_sysfs_port_init(dev, port2, 8);
+	nsc_gpio_sysfs_port_init(dev, port3, 8);
+}
+
 static void __init pc8736x_init_shadow(void)
 {
 	int port;
@@ -320,6 +368,12 @@ static int __init pc8736x_gpio_init(void
 		dev_dbg(&pdev->dev, ": got dynamic major %d\n", major);
 	}
 
+	pc8736x_sysfs_init(&pdev->dev);
+
+	/* provide info wheresysfs callbacks can get them */
+	pc8736x_access.dev->driver_data = &pc8736x_access;
+
+;
 	return 0;
 }
 
diff -ruNp -X dontdiff -X exclude-diffs am-19/drivers/char/scx200_gpio.c am-20/drivers/char/scx200_gpio.c
--- am-19/drivers/char/scx200_gpio.c	2006-06-14 21:37:10.000000000 -0600
+++ am-20/drivers/char/scx200_gpio.c	2006-06-14 22:10:28.000000000 -0600
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
diff -ruNp -X dontdiff -X exclude-diffs am-19/include/linux/nsc_gpio.h am-20/include/linux/nsc_gpio.h
--- am-19/include/linux/nsc_gpio.h	2006-06-14 21:37:10.000000000 -0600
+++ am-20/include/linux/nsc_gpio.h	2006-06-14 21:39:03.000000000 -0600
@@ -1,6 +1,4 @@
 /**
-   nsc_gpio.c
-
    National Semiconductor GPIO common access methods.
 
    struct nsc_gpio_ops abstracts the low-level access
@@ -19,6 +17,17 @@
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
@@ -40,3 +49,58 @@ extern ssize_t nsc_gpio_read(struct file
 
 extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index);
 
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
+		output_enabled,
+		totem_pole,
+		pullup_enabled,
+		debounced,
+		locked;
+};
+
+#define GPIO_PIN(_grp, _idx, _pre, _post, _mode, _show, _store, _nr)	\
+	{	.dev_attr = __ATTR(_pre## _grp._idx ##_post,		\
+				   _mode, _show, _store),		\
+		.index = _idx, .nr = _nr }
+
+#define GPIO_ATTR(GN, IN, FnSym, AttrNm)	\
+	GPIO_PIN(GN, IN, bit_, AttrNm,		\
+		 S_IWUSR | S_IRUGO,		\
+		 nsc_gpio_sysfs_get, nsc_gpio_sysfs_set, FnSym )
+
+/* command alphabet - initializer components */
+#define PIN_OE(P,N)		GPIO_ATTR(P, N, 'O', _output_enabled)
+#define PIN_PP(P,N)		GPIO_ATTR(P, N, 'T', _totem)
+#define PIN_PUE(P,N)		GPIO_ATTR(P, N, 'P', _pullup_enabled)
+#define PIN_LOCKED(P,N)		GPIO_ATTR(P, N, 'L', _locked)
+#define PIN_DEBOUNCE(P,N)	GPIO_ATTR(P, N, 'D', _debounced)
+
+/* initializer for ports; ie pin arrays */
+#define GPIO_ATTRS(Port, Idx) {			\
+	.output_enabled	= PIN_OE(Port, Idx),	\
+	.totem_pole	= PIN_PP(Port, Idx),	\
+	.pullup_enabled	= PIN_PUE(Port, Idx),	\
+	.locked		= PIN_LOCKED(Port, Idx), \
+	.debounced	= PIN_DEBOUNCE(Port, Idx) }
+
+/* The original scx200_gpio driver exposed pins to the user as
+   char-device-files.  We preserve this legacy command alphabet, and
+   map them onto struct sensor_device_attribute_2's .nr member.
+   This gives us 2D addressing, and puts all the bit-banging into a
+   single pair of callbacks.
+*/
+


