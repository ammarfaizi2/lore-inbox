Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTANVPt>; Tue, 14 Jan 2003 16:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTANVPt>; Tue, 14 Jan 2003 16:15:49 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:25093 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S265277AbTANVPq>;
	Tue, 14 Jan 2003 16:15:46 -0500
To: Valdis.Kletnieks@vt.edu
Cc: linus@transmeta.com, Massimo Dal Zotto <dz@debian.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Re: Linux 2.5.57, i8k driver versions..
References: <200301140619.h0E6JSqZ024785@turing-police.cc.vt.edu>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <200301140619.h0E6JSqZ024785@turing-police.cc.vt.edu>
Date: 14 Jan 2003 16:24:27 -0500
Message-ID: <m3wul71l2s.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Valdis" == Valdis Kletnieks <Valdis.Kletnieks@vt.edu> writes:

Valdis> The Linux 2.5.57 tarball has the 1.7 version of the i8k
Valdis> driver, but the version in
Valdis> http://people.debian.org/~dz/i8k/i8kutils-1.17.tar.bz2 is
Valdis> version 1.13.  A quick diff doesn't show anything that would
Valdis> prevent a drop-in of the 1.13 version.  What's the protocol to
Valdis> get this synced to the latest-and-greatest?

The following compiles, but has not yet been run-tested.

In addition to the diff from the 1.7 i8kutils release to the 1.17
release, I made the new globals static as per Rusty's namespace
pollution patch yesterday, and removed the reference to an include no
longer in 2.5.

It is also available from:

        bk://cloos.bkbits.net/i8k-1.17

ChangeSet@1.1025, 2003-01-14 13:23:37-05:00, cloos@lugabout.jhcloos.org
  Upgrade i8k.c to version from i8kutils-1.17

 drivers/char/i8k.c |  105 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 104 insertions(+), 1 deletion(-)


diff -Nru a/drivers/char/i8k.c b/drivers/char/i8k.c
--- a/drivers/char/i8k.c	Tue Jan 14 16:19:19 2003
+++ b/drivers/char/i8k.c	Tue Jan 14 16:19:19 2003
@@ -22,12 +22,14 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/apm_bios.h>
+#include <linux/kbd_kern.h>
+#include <linux/timer.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
 #include <linux/i8k.h>
 
-#define I8K_VERSION		"1.7 21/11/2001"
+#define I8K_VERSION		"1.13 14/05/2002"
 
 #define I8K_SMM_FN_STATUS	0x0025
 #define I8K_SMM_POWER_STATUS	0x0069
@@ -55,6 +57,19 @@
 
 #define DELL_SIGNATURE		"Dell Computer"
 
+/* Interval between polling of keys, in jiffies. */
+#define I8K_POLL_INTERVAL	(HZ/20)
+#define I8K_REPEAT_DELAY	250	/* 250 ms */
+#define I8K_REPEAT_RATE		10
+
+/*
+ * (To be escaped) Scancodes for the keys.  These were chosen to match other
+ * "Internet" keyboards.
+ */
+#define I8K_KEYS_UP_SCANCODE	0x30
+#define I8K_KEYS_DOWN_SCANCODE	0x2e
+#define I8K_KEYS_MUTE_SCANCODE	0x20
+
 static char *supported_models[] = {
     "Inspiron",
     "Latitude",
@@ -67,19 +82,34 @@
 static char serial_number[16] = "?";
 
 static int force = 0;
+static int restricted = 0;
+static int handle_buttons = 0;
+static int repeat_delay = I8K_REPEAT_DELAY;
+static int repeat_rate = I8K_REPEAT_RATE;
 static int power_status = 0;
 
+static struct timer_list  i8k_keys_timer;
+
 MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
 MODULE_DESCRIPTION("Driver for accessing SMM BIOS on Dell laptops");
 MODULE_LICENSE("GPL");
 MODULE_PARM(force, "i");
+MODULE_PARM(restricted, "i");
+MODULE_PARM(handle_buttons, "i");
+MODULE_PARM(repeat_delay, "i");
+MODULE_PARM(repeat_rate, "i");
 MODULE_PARM(power_status, "i");
 MODULE_PARM_DESC(force, "Force loading without checking for supported models");
+MODULE_PARM_DESC(restricted, "Allow fan control if SYS_ADMIN capability set");
+MODULE_PARM_DESC(handle_buttons, "Generate keyboard events for i8k buttons");
+MODULE_PARM_DESC(repeat_delay, "I8k buttons repeat delay (ms)");
+MODULE_PARM_DESC(repeat_rate, "I8k buttons repeat rate");
 MODULE_PARM_DESC(power_status, "Report power status in /proc/i8k");
 
 static ssize_t i8k_read(struct file *, char *, size_t, loff_t *);
 static int i8k_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long);
+static void i8k_keys_set_timer(void);
 
 static struct file_operations i8k_fops = {
     .read	= i8k_read,
@@ -370,6 +400,9 @@
 	break;
 
     case I8K_SET_FAN:
+	if (restricted && !capable(CAP_SYS_ADMIN)) {
+	    return -EPERM;
+	}
 	if (copy_from_user(&val, (int *)arg, sizeof(int))) {
 	    return -EFAULT;
 	}
@@ -483,6 +516,61 @@
     return len;
 }
 
+/*
+ * i8k_keys stuff. Thanks to David Bustos <bustos@caltech.edu>
+ */
+
+static unsigned char i8k_keys_make_scancode(int x) {
+    switch (x) {
+    case I8K_FN_UP:	return I8K_KEYS_UP_SCANCODE;
+    case I8K_FN_DOWN:	return I8K_KEYS_DOWN_SCANCODE;
+    case I8K_FN_MUTE:	return I8K_KEYS_MUTE_SCANCODE;
+    }
+
+    return 0;
+}
+
+static void i8k_keys_poll(unsigned long data) {
+    static int last = 0;
+    static int repeat = 0;
+
+    int  curr;
+
+    curr = i8k_get_fn_status();
+    if (curr >= 0) {
+	if (curr != last) {
+	    repeat = jiffies + (HZ * repeat_delay / 1000);
+
+	    if (last != 0) {
+		handle_scancode(0xe0, 0);
+		handle_scancode(i8k_keys_make_scancode(last), 0);
+	    }
+
+	    if (curr != 0) {
+		handle_scancode(0xe0, 1);
+		handle_scancode(i8k_keys_make_scancode(curr), 1);
+	    }
+	} else {
+	    /* Generate keyboard repeat events with current scancode -- dz */
+	    if ((curr) && (repeat_rate > 0) && (jiffies >= repeat)) {
+		repeat = jiffies + (HZ / repeat_rate);
+		handle_scancode(0xe0, 1);
+		handle_scancode(i8k_keys_make_scancode(curr), 1);
+	    }
+	}
+
+	last = curr;
+    }
+
+    /* Reset the timer. */
+    i8k_keys_set_timer();
+}
+
+static void i8k_keys_set_timer() {
+    i8k_keys_timer.expires = jiffies + I8K_POLL_INTERVAL;
+    add_timer(&i8k_keys_timer);
+}
+
 static char* __init string_trim(char *s, int size)
 {
     int len;
@@ -757,6 +845,16 @@
 	   "Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
 	   I8K_VERSION);
 
+    /* Register the i8k_keys timer. */
+    if (handle_buttons) {
+	printk(KERN_INFO
+	       "i8k: enabling buttons events, delay=%d, rate=%d\n",
+	       repeat_delay, repeat_rate);
+	init_timer(&i8k_keys_timer);
+	i8k_keys_timer.function = i8k_keys_poll;
+	i8k_keys_set_timer();
+    }
+
     return 0;
 }
 
@@ -770,6 +868,11 @@
 {
     /* Remove the proc entry */
     remove_proc_entry("i8k", NULL);
+
+    /* Unregister the i8k_keys timer. */
+    while (handle_buttons && !del_timer(&i8k_keys_timer)) {
+	schedule_timeout(I8K_POLL_INTERVAL);
+    }
 
     printk(KERN_INFO "i8k: module unloaded\n");
 }

