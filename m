Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWAEA7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWAEA7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWAEAuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750973AbWAEAty convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:54 -0500
Cc: rusty@rustcorp.com.au
Subject: [PATCH] Input: add modalias support
In-Reply-To: <11364221702087@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:30 -0800
Message-Id: <11364221703787@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Input: add modalias support

Here's the patch for modalias support for input classes.  It uses
comma-separated numbers, and doesn't describe all the potential keys (no
module currently cares, and that would make the strings huge).  The
changes to input.h are to move the definitions needed by file2alias
outside __KERNEL__.  I chose not to move those definitions to
mod_devicetable.h, because there are so many that it might break compile
of something else in the kernel.

The rest is fairly straightforward.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
CC: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 1d8f430c15b3a345db990e285742c67c2f52f9a6
tree 7bf8ae0929ebf581c4de68e7f4be9f6ea672d453
parent 263756ec228f1cdd49fc50b1f87001a4cebdfe12
author Rusty Russell <rusty@rustcorp.com.au> Wed, 07 Dec 2005 21:40:34 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:09 -0800

 drivers/input/input.c    |   39 +++++++++++++++++++++++
 include/linux/input.h    |   79 ++++++++++++++++++++++++----------------------
 scripts/mod/file2alias.c |   62 ++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 39 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 2d37b39..ef5824c 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -528,10 +528,49 @@ INPUT_DEV_STRING_ATTR_SHOW(name);
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
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 3c58233..bef0855 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
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
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index e3d144a..e0eedff 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
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

