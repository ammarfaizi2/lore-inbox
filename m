Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbRDTXRv>; Fri, 20 Apr 2001 19:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131976AbRDTXRl>; Fri, 20 Apr 2001 19:17:41 -0400
Received: from diup-184-214.inter.net.il ([213.8.184.214]:4100 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S129166AbRDTXRe>;
	Fri, 20 Apr 2001 19:17:34 -0400
Date: Sat, 21 Apr 2001 02:17:18 +0300 (IDT)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Jens Axboe <axboe@image.dk>
Subject: cdrom driver dependency problem (and a workaround patch)
Message-ID: <Pine.LNX.4.32.0104210107160.1148-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Between 2.4.3-ac9 and 2.4.3-ac10 the CDROM Uniform Driver was modified.
The modification added a dependency of the *register_cdrom() functions
on the cdrom_init() function. Theoretically, cdrom_init() should have
been called before any call to register_cdrom(). But practically, when
the CDROM driver is compiled into the kernel and not as a module, it
doesn't happen, and in 2.4.3-ac10 you get an Oops in cdrom_get_entry(),
where the NULL cdrom_numbers gets dereferenced.

One reason for this misdependency is that the IDE is initialized before
the cdrom driver, register_cdrom() gets called from inside the IDE
initialization functions. (ide_init() -> ide_init_builtin_drivers() ->
ide_cdrom_init() -> ide_cdrom_setup() -> ide_cdrom_register() ->
register_cdrom())

In order to get my kernel to boot, I've made the following temporary
workaround patch. I'd be glad to hear about other ways of solving this.


--- linux-2.4.3-ac10/drivers/cdrom/cdrom.c	Fri Apr 20 23:38:37 2001
+++ linux-2.4.3-ac10/drivers/cdrom/cdrom.c	Sat Apr 21 01:59:35 2001
@@ -277,6 +277,7 @@
 static int autoclose=1;
 static int autoeject;
 static int lockdoor = 1;
+static int initialized;
 /* will we ever get to use this... sigh. */
 static int check_media_type;
 static unsigned long *cdrom_numbers;
@@ -332,6 +333,9 @@
 #ifdef CONFIG_SYSCTL
 static void cdrom_sysctl_register(void);
 #endif /* CONFIG_SYSCTL */
+
+static int check_cdrom_init(void);
+
 static struct cdrom_device_info *topCdromPtr;
 static devfs_handle_t devfs_handle;

@@ -350,6 +354,8 @@
 {
 	int i, nr, foo;

+	printk("Holly damn. cdrom_numbers=0x%p\n",cdrom_numbers);
+
 	nr = 0;
 	foo = -1;
 	for (i = 0; i < CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8); i++) {
@@ -368,7 +374,7 @@

 static void cdrom_clear_entry(struct cdrom_device_info *cdi)
 {
-	int bit_nr = cdi->nr & ~(sizeof(unsigned long) * 8);
+	int bit_nr = cdi->nr % (sizeof(unsigned long) * 8);
 	int cd_index = cdi->nr / (sizeof(unsigned long) * 8);

 	clear_bit(bit_nr, &cdrom_numbers[cd_index]);
@@ -388,10 +394,14 @@
 	int major = MAJOR(cdi->dev);
         struct cdrom_device_ops *cdo = cdi->ops;
         int *change_capability = (int *)&cdo->capability; /* hack */
+	int rc;
 	char vname[16];

 	cdinfo(CD_OPEN, "entering register_cdrom\n");

+	if ((rc = check_cdrom_init()) != 0)
+	    return rc;
+
 	if (major < 0 || major >= MAX_BLKDEV)
 		return -1;
 	if (cdo->open == NULL || cdo->release == NULL)
@@ -2706,11 +2716,29 @@

 #endif /* CONFIG_SYSCTL */

-static int __init cdrom_init(void)
+static int check_cdrom_init(void)
 {
-	int n_entries = CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8);
+	if (!initialized)
+	{
+		int n_entries;
+
+		initialized = 1;
+    		n_entries = CDROM_MAX_CDROMS / (sizeof(unsigned long) * 8);

-	cdrom_numbers = kmalloc(n_entries * sizeof(unsigned long), GFP_KERNEL);
+		cdrom_numbers = kmalloc(n_entries * sizeof(unsigned long), GFP_KERNEL);
+
+		if (cdrom_numbers == NULL)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static int __init cdrom_init(void)
+{
+        int rc;
+
+	if ((rc = check_cdrom_init()) != 0)
+	    return rc;

 #ifdef CONFIG_SYSCTL
 	cdrom_sysctl_register();

--
Dan Aloni
dax@karrde.org

