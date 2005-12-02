Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVLBX7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVLBX7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 18:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVLBX7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 18:59:53 -0500
Received: from ozlabs.org ([203.10.76.45]:56216 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751054AbVLBX7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 18:59:52 -0500
Subject: Re: Two module-init-
From: Rusty Russell <rusty@rustcorp.com.au>
To: Scott James Remnant <scott@ubuntu.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz,
       vojtech@suse.cz
In-Reply-To: <1133514074.20712.0.camel@localhost.localdomain>
References: <1133359773.2779.13.camel@localhost.localdomain>
	 <1133482376.4094.11.camel@localhost.localdomain>
	 <1133514074.20712.0.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 10:59:48 +1100
Message-Id: <1133567988.21941.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 09:01 +0000, Scott James Remnant wrote:
> On Fri, 2005-12-02 at 11:12 +1100, Rusty Russell wrote:
> 
> > On Wed, 2005-11-30 at 14:09 +0000, Scott James Remnant wrote:
> > > Hi Rusty,
> > > 
> > > Attached are two patches to module-init-tools from Ubuntu.
> > > 
> > > The first (input_table_size) is a catch-up with 2.6.15, it's adding an
> > > extra field to the input_device_id struct; m-u-t needs updating to be
> > > able to read the modules correctly.
> > 
> > Unfortunately, it's not that simple.  Your patch will break previous
> > kernels, which have a smaller structure.  I've had the discussion years
> > ago with the input people on using module aliases, and it's not entirely
> > trivial.  I will prepare another patch, however.
> > 
> Are the modules.*map files intended to be deprecated entirely in favour
> of aliases?  The problem this patch fixed was that the parser couldn't
> read the tables, so produced invalid output for the modules (ie. an
> empty modules.inputmap).

Yes, but now it will produce a bad modules.inputmap for previous
kernels.

Here's the patch for modalias support for input classes.  It uses
comma-separated numbers, and doesn't describe all the potential keys (no
module currently cares, and that would make the strings huge).  The
changes to input.h are to move the definitions needed by file2alias
outside __KERNEL__.  I chose not to move those definitions to
mod_devicetable.h, because there are so many that it might break compile
of something else in the kernel.

The rest is fairly straightforward.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (authored)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.15-rc4/drivers/input/input.c working-2.6.15-rc4-input-modalias/drivers/input/input.c
--- linux-2.6.15-rc4/drivers/input/input.c	2005-12-02 11:00:18.000000000 +1100
+++ working-2.6.15-rc4-input-modalias/drivers/input/input.c	2005-12-02 17:25:03.000000000 +1100
@@ -529,10 +529,49 @@ INPUT_DEV_STRING_ATTR_SHOW(name);
 INPUT_DEV_STRING_ATTR_SHOW(phys);
 INPUT_DEV_STRING_ATTR_SHOW(uniq);
 
+static int print_modalias_bits(char *buf, char prefix, unsigned long *arr,
+			       unsigned int min, unsigned int max)
+{
+	int len, i;
+
+	len = sprintf(buf, "%c", prefix);
+	for (i = min; i < max; i++)
+		if (arr[LONG(i)] & BIT(i))
+			len += sprintf(buf+len, "%X,", i);
+	return len;
+}
+	
+static ssize_t input_dev_show_modalias(struct class_device *dev, char *buf)
+{
+	struct input_dev *id = to_input_dev(dev);
+	ssize_t len = 0;
+
+	len += sprintf(buf+len, "input:b%04Xv%04Xp%04Xe%04X-",
+		       id->id.bustype,
+		       id->id.vendor,
+		       id->id.product,
+		       id->id.version);
+
+	len += print_modalias_bits(buf+len, 'e', id->evbit, 0, EV_MAX);
+	len += print_modalias_bits(buf+len, 'k', id->keybit,
+				   KEY_MIN_INTERESTING, KEY_MAX);
+	len += print_modalias_bits(buf+len, 'r', id->relbit, 0, REL_MAX);
+	len += print_modalias_bits(buf+len, 'a', id->absbit, 0, ABS_MAX);
+	len += print_modalias_bits(buf+len, 'm', id->mscbit, 0, MSC_MAX);
+	len += print_modalias_bits(buf+len, 'l', id->ledbit, 0, LED_MAX);
+	len += print_modalias_bits(buf+len, 's', id->sndbit, 0, SND_MAX);
+	len += print_modalias_bits(buf+len, 'f', id->ffbit, 0, FF_MAX);
+	len += print_modalias_bits(buf+len, 'w', id->swbit, 0, SW_MAX);
+	len += sprintf(buf+len, "\n");
+	return len;
+}
+static CLASS_DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
+
 static struct attribute *input_dev_attrs[] = {
 	&class_device_attr_name.attr,
 	&class_device_attr_phys.attr,
 	&class_device_attr_uniq.attr,
+	&class_device_attr_modalias.attr,
 	NULL
 };
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.15-rc4/include/linux/input.h working-2.6.15-rc4-input-modalias/include/linux/input.h
--- linux-2.6.15-rc4/include/linux/input.h	2005-12-02 11:01:11.000000000 +1100
+++ working-2.6.15-rc4-input-modalias/include/linux/input.h	2005-12-02 15:51:15.000000000 +1100
@@ -18,6 +18,7 @@
 #include <sys/ioctl.h>
 #include <asm/types.h>
 #endif
+#include <linux/mod_devicetable.h>
 
 /*
  * The event structure itself
@@ -511,6 +512,8 @@ struct input_absinfo {
 #define KEY_FN_S		0x1e3
 #define KEY_FN_B		0x1e4
 
+/* We avoid low common keys in module aliases so they don't get huge. */
+#define KEY_MIN_INTERESTING	KEY_MUTE
 #define KEY_MAX			0x1ff
 
 /*
@@ -793,6 +796,44 @@ struct ff_effect {
 
 #define FF_MAX		0x7f
 
+struct input_device_id {
+
+	kernel_ulong_t flags;
+
+	struct input_id id;
+
+	kernel_ulong_t evbit[EV_MAX/BITS_PER_LONG+1];
+	kernel_ulong_t keybit[KEY_MAX/BITS_PER_LONG+1];
+	kernel_ulong_t relbit[REL_MAX/BITS_PER_LONG+1];
+	kernel_ulong_t absbit[ABS_MAX/BITS_PER_LONG+1];
+	kernel_ulong_t mscbit[MSC_MAX/BITS_PER_LONG+1];
+	kernel_ulong_t ledbit[LED_MAX/BITS_PER_LONG+1];
+	kernel_ulong_t sndbit[SND_MAX/BITS_PER_LONG+1];
+	kernel_ulong_t ffbit[FF_MAX/BITS_PER_LONG+1];
+	kernel_ulong_t swbit[SW_MAX/BITS_PER_LONG+1];
+
+	kernel_ulong_t driver_info;
+};
+
+/*
+ * Structure for hotplug & device<->driver matching.
+ */
+
+#define INPUT_DEVICE_ID_MATCH_BUS	1
+#define INPUT_DEVICE_ID_MATCH_VENDOR	2
+#define INPUT_DEVICE_ID_MATCH_PRODUCT	4
+#define INPUT_DEVICE_ID_MATCH_VERSION	8
+
+#define INPUT_DEVICE_ID_MATCH_EVBIT	0x010
+#define INPUT_DEVICE_ID_MATCH_KEYBIT	0x020
+#define INPUT_DEVICE_ID_MATCH_RELBIT	0x040
+#define INPUT_DEVICE_ID_MATCH_ABSBIT	0x080
+#define INPUT_DEVICE_ID_MATCH_MSCIT	0x100
+#define INPUT_DEVICE_ID_MATCH_LEDBIT	0x200
+#define INPUT_DEVICE_ID_MATCH_SNDBIT	0x400
+#define INPUT_DEVICE_ID_MATCH_FFBIT	0x800
+#define INPUT_DEVICE_ID_MATCH_SWBIT	0x1000
+
 #ifdef __KERNEL__
 
 /*
@@ -901,49 +942,11 @@ struct input_dev {
 };
 #define to_input_dev(d) container_of(d, struct input_dev, cdev)
 
-/*
- * Structure for hotplug & device<->driver matching.
- */
-
-#define INPUT_DEVICE_ID_MATCH_BUS	1
-#define INPUT_DEVICE_ID_MATCH_VENDOR	2
-#define INPUT_DEVICE_ID_MATCH_PRODUCT	4
-#define INPUT_DEVICE_ID_MATCH_VERSION	8
-
-#define INPUT_DEVICE_ID_MATCH_EVBIT	0x010
-#define INPUT_DEVICE_ID_MATCH_KEYBIT	0x020
-#define INPUT_DEVICE_ID_MATCH_RELBIT	0x040
-#define INPUT_DEVICE_ID_MATCH_ABSBIT	0x080
-#define INPUT_DEVICE_ID_MATCH_MSCIT	0x100
-#define INPUT_DEVICE_ID_MATCH_LEDBIT	0x200
-#define INPUT_DEVICE_ID_MATCH_SNDBIT	0x400
-#define INPUT_DEVICE_ID_MATCH_FFBIT	0x800
-#define INPUT_DEVICE_ID_MATCH_SWBIT	0x1000
-
 #define INPUT_DEVICE_ID_MATCH_DEVICE\
 	(INPUT_DEVICE_ID_MATCH_BUS | INPUT_DEVICE_ID_MATCH_VENDOR | INPUT_DEVICE_ID_MATCH_PRODUCT)
 #define INPUT_DEVICE_ID_MATCH_DEVICE_AND_VERSION\
 	(INPUT_DEVICE_ID_MATCH_DEVICE | INPUT_DEVICE_ID_MATCH_VERSION)
 
-struct input_device_id {
-
-	unsigned long flags;
-
-	struct input_id id;
-
-	unsigned long evbit[NBITS(EV_MAX)];
-	unsigned long keybit[NBITS(KEY_MAX)];
-	unsigned long relbit[NBITS(REL_MAX)];
-	unsigned long absbit[NBITS(ABS_MAX)];
-	unsigned long mscbit[NBITS(MSC_MAX)];
-	unsigned long ledbit[NBITS(LED_MAX)];
-	unsigned long sndbit[NBITS(SND_MAX)];
-	unsigned long ffbit[NBITS(FF_MAX)];
-	unsigned long swbit[NBITS(SW_MAX)];
-
-	unsigned long driver_info;
-};
-
 struct input_handle;
 
 struct input_handler {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.15-rc4/scripts/mod/file2alias.c working-2.6.15-rc4-input-modalias/scripts/mod/file2alias.c
--- linux-2.6.15-rc4/scripts/mod/file2alias.c	2005-12-02 11:01:24.000000000 +1100
+++ working-2.6.15-rc4-input-modalias/scripts/mod/file2alias.c	2005-12-02 16:30:20.000000000 +1100
@@ -16,8 +16,10 @@
  * use either stdint.h or inttypes.h for the rest. */
 #if KERNEL_ELFCLASS == ELFCLASS32
 typedef Elf32_Addr	kernel_ulong_t;
+#define BITS_PER_LONG 32
 #else
 typedef Elf64_Addr	kernel_ulong_t;
+#define BITS_PER_LONG 64
 #endif
 #ifdef __sun__
 #include <inttypes.h>
@@ -35,6 +37,7 @@ typedef unsigned char	__u8;
  * even potentially has different endianness and word sizes, since 
  * we handle those differences explicitly below */
 #include "../../include/linux/mod_devicetable.h"
+#include "../../include/linux/input.h"
 
 #define ADD(str, sep, cond, field)                              \
 do {                                                            \
@@ -366,6 +369,61 @@ static int do_i2c_entry(const char *file
 	return 1;
 }
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static void do_input(char *alias,
+		     kernel_ulong_t *arr, unsigned int min, unsigned int max)
+{
+	unsigned int i;
+	for (i = min; i < max; i++) {
+		if (arr[i/BITS_PER_LONG] & (1 << (i%BITS_PER_LONG)))
+			sprintf(alias+strlen(alias), "%X,*", i);
+	}
+}
+
+/* input:b0v0p0e0-eXkXrXaXmXlXsXfXwX where X is comma-separated %02X. */
+static int do_input_entry(const char *filename, struct input_device_id *id,
+			  char *alias)
+{
+	sprintf(alias, "input:");
+
+	ADD(alias, "b", id->flags&INPUT_DEVICE_ID_MATCH_BUS, id->id.bustype);
+	ADD(alias, "v", id->flags&INPUT_DEVICE_ID_MATCH_VENDOR, id->id.vendor);
+	ADD(alias, "p", id->flags&INPUT_DEVICE_ID_MATCH_PRODUCT,
+	    id->id.product);
+	ADD(alias, "e", id->flags&INPUT_DEVICE_ID_MATCH_VERSION,
+	    id->id.version);
+
+	sprintf(alias + strlen(alias), "-e*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_EVBIT)
+		do_input(alias, id->evbit, 0, EV_MAX);
+	sprintf(alias + strlen(alias), "k*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_KEYBIT)
+		do_input(alias, id->keybit, KEY_MIN_INTERESTING, KEY_MAX);
+	sprintf(alias + strlen(alias), "r*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_RELBIT)
+		do_input(alias, id->relbit, 0, REL_MAX);
+	sprintf(alias + strlen(alias), "a*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_ABSBIT)
+		do_input(alias, id->absbit, 0, ABS_MAX);
+	sprintf(alias + strlen(alias), "m*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_MSCIT)
+		do_input(alias, id->mscbit, 0, MSC_MAX);
+	sprintf(alias + strlen(alias), "l*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_LEDBIT)
+		do_input(alias, id->ledbit, 0, LED_MAX);
+	sprintf(alias + strlen(alias), "s*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_SNDBIT)
+		do_input(alias, id->sndbit, 0, SND_MAX);
+	sprintf(alias + strlen(alias), "f*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_FFBIT)
+		do_input(alias, id->ffbit, 0, SND_MAX);
+	sprintf(alias + strlen(alias), "w*");
+	if (id->flags&INPUT_DEVICE_ID_MATCH_SWBIT)
+		do_input(alias, id->swbit, 0, SW_MAX);
+	return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -453,7 +511,9 @@ void handle_moddevtable(struct module *m
 	else if (sym_is(symname, "__mod_i2c_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct i2c_device_id),
 			 do_i2c_entry, mod);
-
+	else if (sym_is(symname, "__mod_input_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct input_device_id),
+			 do_input_entry, mod);
 }
 
 /* Now add out buffered information to the generated C source */

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

