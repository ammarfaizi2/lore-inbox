Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbTBUXe6>; Fri, 21 Feb 2003 18:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267803AbTBUXe6>; Fri, 21 Feb 2003 18:34:58 -0500
Received: from fmr05.intel.com ([134.134.136.6]:46569 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267662AbTBUXer>; Fri, 21 Feb 2003 18:34:47 -0500
Subject: Re: [PATCH][2.5] Sysfs enabling watchdog infrastructure
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1045869699.1037.6.camel@vmhack>
References: <1045869699.1037.6.camel@vmhack>
Content-Type: multipart/mixed; boundary="=-OCqRYTyLLIheoRtk3c+Q"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 15:31:44 -0800
Message-Id: <1045870305.1014.11.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OCqRYTyLLIheoRtk3c+Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following is a patch against the 2.5.60 kernel that ports the
softdog driver to register as a watchdog_driver and allow the watchdog
infrastructure to take care of details like sysfs and presenting a miscdevice
for the watchdog minor.

There are enough changes to make the patch difficult to read so I am
also attaching softdog.c to make it easier to see what the file is doing.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1040  -> 1.1041 
#	drivers/char/watchdog/softdog.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/21	rusty@penguin.co.intel.com	1.1041
# * ported driver to new sysfs based watchdog infrastructure
# * change from using old MODULE_PARM macro to the new module_param
#   function call
# --------------------------------------------
#
diff -Nru a/drivers/char/watchdog/softdog.c b/drivers/char/watchdog/softdog.c
--- a/drivers/char/watchdog/softdog.c	Fri Feb 21 14:48:49 2003
+++ b/drivers/char/watchdog/softdog.c	Fri Feb 21 14:48:49 2003
@@ -1,5 +1,5 @@
 /*
- *	SoftDog	0.06:	A Software Watchdog Device
+ *	SoftDog	0.07:	A Software Watchdog Device
  *
  *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
  *				http://www.redhat.com
@@ -34,52 +34,41 @@
  *
  *  20020530 Joel Becker <joel.becker@oracle.com>
  *  	Added Matt Domsch's nowayout module option.
+ * 
+ *  20030221 Rusty Lynch <rusty@linux.co.intel.com>
+ *      Moved implementation to use the new watchdog infrastructure.  This
+ *      adds the softdog to the sysfs topography and moves the common 
+ *      miscdevice functions to the infrastructure as well.
+ *       
  */
  
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/types.h>
-#include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
 
 #define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
-
-static int expect_close = 0;
 static int soft_margin = TIMER_MARGIN;	/* in seconds */
-#ifdef ONLY_TESTING
-static int soft_noboot = 1;
-#else
-static int soft_noboot = 0;
-#endif  /* ONLY_TESTING */
+module_param(soft_margin,int,0);
+MODULE_PARM_DESC(soft_margin, "Watchdog timer margin (timeout) in seconds");
 
-MODULE_PARM(soft_margin,"i");
-MODULE_PARM(soft_noboot,"i");
-MODULE_LICENSE("GPL");
+static int soft_noboot = 0;
+module_param(soft_noboot,int,0);
+MODULE_PARM_DESC(soft_noboot, "Disable machine restarts on watchdog timeout");
 
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
 static int nowayout = 1;
 #else
 static int nowayout = 0;
 #endif
-
-MODULE_PARM(nowayout,"i");
+module_param(nowayout,int,0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /*
- *	Our timer
- */
- 
-static void watchdog_fire(unsigned long);
-
-static struct timer_list watchdog_ticktock =
-		TIMER_INITIALIZER(watchdog_fire, 0, 0);
-static unsigned long timer_alive;
-
-
-/*
  *	If the timer expires..
  */
  
@@ -96,137 +85,154 @@
 }
 
 /*
- *	Allow only one person to hold it open
+ *	Software timer
  */
  
-static int softdog_open(struct inode *inode, struct file *file)
+static struct timer_list watchdog_ticktock =
+		TIMER_INITIALIZER(watchdog_fire, 0, 0);
+
+
+/* 
+ *       Watchdog ops callback functions
+ */
+
+static int softdog_start(struct watchdog_driver *d)
 {
-	if(test_and_set_bit(0, &timer_alive))
-		return -EBUSY;
-	if (nowayout) {
-		MOD_INC_USE_COUNT;
-	}
-	/*
-	 *	Activate timer
-	 */
 	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
 	return 0;
 }
 
-static int softdog_release(struct inode *inode, struct file *file)
+static int softdog_stop(struct watchdog_driver *d)
 {
-	/*
-	 *	Shut off the timer.
-	 * 	Lock it in if it's a module and we set nowayout
-	 */
-	if (expect_close) {
-		del_timer(&watchdog_ticktock);
-	} else {
-		printk(KERN_CRIT "SOFTDOG: WDT device closed unexpectedly.  WDT will not stop!\n");
+	if (nowayout) {
+		printk(KERN_CRIT "SOFTDOG: WDT device closed unexpectedly.  "
+		       "WDT will not stop!\n");
+		return -1;
 	}
-	clear_bit(0, &timer_alive);
+
+	del_timer(&watchdog_ticktock);
 	return 0;
 }
 
-static ssize_t softdog_write(struct file *file, const char *data, size_t len, loff_t *ppos)
+static int softdog_keepalive(struct watchdog_driver *d) 
 {
-	/*  Can't seek (pwrite) on this device  */
-	if (ppos != &file->f_pos)
-		return -ESPIPE;
+	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+	return 0;
+}
 
-	/*
-	 *	Refresh the timer.
-	 */
-	if(len) {
-		if (!nowayout) {
-			size_t i;
+static int softdog_get_timeout(struct watchdog_driver *d, int *timeout)
+{
+	*timeout = soft_margin;
+	return 0;
+}
 
-			/* In case it was set long ago */
-			expect_close = 0;
+static int softdog_set_timeout(struct watchdog_driver *d, int timeout)
+{
+	if (timeout < 1)
+		return -1;
 
-			for (i = 0; i != len; i++) {
-				char c;
+	soft_margin = timeout;
+	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
+	return 0;
+}
 
-				if (get_user(c, data + i))
-					return -EFAULT;
-				if (c == 'V')
-					expect_close = 1;
-			}
-		}
-		mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
-		return 1;
-	}
+static int softdog_get_options(struct watchdog_driver *d, int *options)
+{
+	*options =  WDIOF_SETTIMEOUT;
 	return 0;
 }
 
-static int softdog_ioctl(struct inode *inode, struct file *file,
-	unsigned int cmd, unsigned long arg)
+static int softdog_get_nowayout(struct watchdog_driver *d, int *n)
 {
-	int new_margin;
-	static struct watchdog_info ident = {
-		.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
-		.identity = "Software Watchdog",
-	};
-	switch (cmd) {
-		default:
-			return -ENOTTY;
-		case WDIOC_GETSUPPORT:
-			if(copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
-				return -EFAULT;
-			return 0;
-		case WDIOC_GETSTATUS:
-		case WDIOC_GETBOOTSTATUS:
-			return put_user(0,(int *)arg);
-		case WDIOC_KEEPALIVE:
-			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
-			return 0;
-		case WDIOC_SETTIMEOUT:
-			if (get_user(new_margin, (int *)arg))
-				return -EFAULT;
-			if (new_margin < 1)
-				return -EINVAL;
-			soft_margin = new_margin;
-			mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
-			/* Fall */
-		case WDIOC_GETTIMEOUT:
-			return put_user(soft_margin, (int *)arg);
-	}
+	*n = nowayout;
+	return 0;
 }
 
-static struct file_operations softdog_fops = {
-	.owner		= THIS_MODULE,
-	.write		= softdog_write,
-	.ioctl		= softdog_ioctl,
-	.open		= softdog_open,
-	.release	= softdog_release,
+static int softdog_set_nowayout(struct watchdog_driver *d, int n)
+{
+	if (n)
+		nowayout = 1;
+	else 
+		nowayout = 0;
+	return 0;
+}
+
+/*
+ *      Structures required to register as a watchdog driver
+ */
+
+static struct watchdog_ops softdog_ops = {
+	.start                 = softdog_start,
+	.stop                  = softdog_stop,
+	.keepalive             = softdog_keepalive,
+	.get_timeout           = softdog_get_timeout,
+	.set_timeout           = softdog_set_timeout,
+	.get_nowayout          = softdog_get_nowayout,
+	.set_nowayout          = softdog_set_nowayout,
+	.get_options           = softdog_get_options,
+	/* get_bootstatus not implemented */
+	/* get_status not implemented */
+	/* get/set_temppanic not implemented */
+	/* get_firmware_version not implemented */
 };
 
-static struct miscdevice softdog_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &softdog_fops,
+static struct watchdog_driver softdog_driver = {
+	.ops = &softdog_ops,
+	.driver = {
+		.name		= "softdog",
+		.bus		= &system_bus_type,
+		.devclass       = &watchdog_devclass,
+	}
 };
 
-static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.06, soft_margin: %d sec, nowayout: %d\n";
+/* 
+ *      enable testing the of driver to not cause a machine restart 
+ */
+
+static ssize_t soft_noboot_show(struct device_driver * d, char * buf)
+{
+	return sprintf(buf, "%i\n",soft_noboot);
+}
+static ssize_t soft_noboot_store(struct device_driver *d,const char * buf, 
+				 size_t count)
+{
+	int tmp;
+
+	if (sscanf(buf,"%i",&tmp) != 1)
+		return -EINVAL;
+
+	if (tmp)
+		soft_noboot = 1;
+	else
+		soft_noboot = 0;
+	return count;
+}
+DRIVER_ATTR(soft_noboot,0644,soft_noboot_show,soft_noboot_store);
+
+static char banner[] __initdata = KERN_INFO "Software Watchdog Timer: 0.07, soft_margin: %d sec, nowayout: %d\n";
 
 static int __init watchdog_init(void)
 {
 	int ret;
 
-	ret = misc_register(&softdog_miscdev);
-
+	ret = watchdog_driver_register(&softdog_driver);
 	if (ret)
 		return ret;
 
+	driver_create_file(&softdog_driver.driver, &driver_attr_soft_noboot);
 	printk(banner, soft_margin, nowayout);
-
 	return 0;
 }
 
 static void __exit watchdog_exit(void)
-{
-	misc_deregister(&softdog_miscdev);
+{     
+	driver_remove_file(&softdog_driver.driver, &driver_attr_soft_noboot);
+	watchdog_driver_unregister(&softdog_driver);
+
+	/* ensure somebody didn't leave the watchdog ticking */
+	del_timer(&watchdog_ticktock);
 }
 
 module_init(watchdog_init);
 module_exit(watchdog_exit);
+MODULE_LICENSE("GPL");

--=-OCqRYTyLLIheoRtk3c+Q
Content-Disposition: attachment; filename=softdog.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; name=softdog.c; charset=UTF-8

/*
 *	SoftDog	0.07:	A Software Watchdog Device
 *
 *	(c) Copyright 1996 Alan Cox <alan@redhat.com>, All Rights Reserved.
 *				http://www.redhat.com
 *
 *	This program is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU General Public License
 *	as published by the Free Software Foundation; either version
 *	2 of the License, or (at your option) any later version.
 *=09
 *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide=20
 *	warranty for any of this software. This material is provided=20
 *	"AS-IS" and at no charge.=09
 *
 *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
 *
 *	Software only watchdog driver. Unlike its big brother the WDT501P
 *	driver this won't always recover a failed machine.
 *
 *  03/96: Angelo Haritsis <ah@doc.ic.ac.uk> :
 *	Modularised.
 *	Added soft_margin; use upon insmod to change the timer delay.
 *	NB: uses same minor as wdt (WATCHDOG_MINOR); we could use separate
 *	    minors.
 *
 *  19980911 Alan Cox
 *	Made SMP safe for 2.3.x
 *
 *  20011127 Joel Becker (jlbec@evilplan.org>
 *	Added soft_noboot; Allows testing the softdog trigger without=20
 *	requiring a recompile.
 *	Added WDIOC_GETTIMEOUT and WDIOC_SETTIMOUT.
 *
 *  20020530 Joel Becker <joel.becker@oracle.com>
 *  	Added Matt Domsch's nowayout module option.
 *=20
 *  20030221 Rusty Lynch <rusty@linux.co.intel.com>
 *      Moved implementation to use the new watchdog infrastructure.  This
 *      adds the softdog to the sysfs topography and moves the common=20
 *      miscdevice functions to the infrastructure as well.
 *      =20
 */
=20
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/config.h>
#include <linux/types.h>
#include <linux/watchdog.h>
#include <linux/reboot.h>
#include <linux/init.h>
#include <asm/uaccess.h>

#define TIMER_MARGIN	60		/* (secs) Default is 1 minute */
static int soft_margin =3D TIMER_MARGIN;	/* in seconds */
module_param(soft_margin,int,0);
MODULE_PARM_DESC(soft_margin, "Watchdog timer margin (timeout) in seconds")=
;

static int soft_noboot =3D 0;
module_param(soft_noboot,int,0);
MODULE_PARM_DESC(soft_noboot, "Disable machine restarts on watchdog timeout=
");

#ifdef CONFIG_WATCHDOG_NOWAYOUT
static int nowayout =3D 1;
#else
static int nowayout =3D 0;
#endif
module_param(nowayout,int,0);
MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (defaul=
t=3DCONFIG_WATCHDOG_NOWAYOUT)");

/*
 *	If the timer expires..
 */
=20
static void watchdog_fire(unsigned long data)
{
	if (soft_noboot)
		printk(KERN_CRIT "SOFTDOG: Triggered - Reboot ignored.\n");
	else
	{
		printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n");
		machine_restart(NULL);
		printk("SOFTDOG: Reboot didn't ?????\n");
	}
}

/*
 *	Software timer
 */
=20
static struct timer_list watchdog_ticktock =3D
		TIMER_INITIALIZER(watchdog_fire, 0, 0);


/*=20
 *       Watchdog ops callback functions
 */

static int softdog_start(struct watchdog_driver *d)
{
	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
	return 0;
}

static int softdog_stop(struct watchdog_driver *d)
{
	if (nowayout) {
		printk(KERN_CRIT "SOFTDOG: WDT device closed unexpectedly.  "
		       "WDT will not stop!\n");
		return -1;
	}

	del_timer(&watchdog_ticktock);
	return 0;
}

static int softdog_keepalive(struct watchdog_driver *d)=20
{
	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
	return 0;
}

static int softdog_get_timeout(struct watchdog_driver *d, int *timeout)
{
	*timeout =3D soft_margin;
	return 0;
}

static int softdog_set_timeout(struct watchdog_driver *d, int timeout)
{
	if (timeout < 1)
		return -1;

	soft_margin =3D timeout;
	mod_timer(&watchdog_ticktock, jiffies+(soft_margin*HZ));
	return 0;
}

static int softdog_get_options(struct watchdog_driver *d, int *options)
{
	*options =3D  WDIOF_SETTIMEOUT;
	return 0;
}

static int softdog_get_nowayout(struct watchdog_driver *d, int *n)
{
	*n =3D nowayout;
	return 0;
}

static int softdog_set_nowayout(struct watchdog_driver *d, int n)
{
	if (n)
		nowayout =3D 1;
	else=20
		nowayout =3D 0;
	return 0;
}

/*
 *      Structures required to register as a watchdog driver
 */

static struct watchdog_ops softdog_ops =3D {
	.start                 =3D softdog_start,
	.stop                  =3D softdog_stop,
	.keepalive             =3D softdog_keepalive,
	.get_timeout           =3D softdog_get_timeout,
	.set_timeout           =3D softdog_set_timeout,
	.get_nowayout          =3D softdog_get_nowayout,
	.set_nowayout          =3D softdog_set_nowayout,
	.get_options           =3D softdog_get_options,
	/* get_bootstatus not implemented */
	/* get_status not implemented */
	/* get/set_temppanic not implemented */
	/* get_firmware_version not implemented */
};

static struct watchdog_driver softdog_driver =3D {
	.ops =3D &softdog_ops,
	.driver =3D {
		.name		=3D "softdog",
		.bus		=3D &system_bus_type,
		.devclass       =3D &watchdog_devclass,
	}
};

/*=20
 *      enable testing the of driver to not cause a machine restart=20
 */

static ssize_t soft_noboot_show(struct device_driver * d, char * buf)
{
	return sprintf(buf, "%i\n",soft_noboot);
}
static ssize_t soft_noboot_store(struct device_driver *d,const char * buf,=20
				 size_t count)
{
	int tmp;

	if (sscanf(buf,"%i",&tmp) !=3D 1)
		return -EINVAL;

	if (tmp)
		soft_noboot =3D 1;
	else
		soft_noboot =3D 0;
	return count;
}
DRIVER_ATTR(soft_noboot,0644,soft_noboot_show,soft_noboot_store);

static char banner[] __initdata =3D KERN_INFO "Software Watchdog Timer: 0.0=
7, soft_margin: %d sec, nowayout: %d\n";

static int __init watchdog_init(void)
{
	int ret;

	ret =3D watchdog_driver_register(&softdog_driver);
	if (ret)
		return ret;

	driver_create_file(&softdog_driver.driver, &driver_attr_soft_noboot);
	printk(banner, soft_margin, nowayout);
	return 0;
}

static void __exit watchdog_exit(void)
{    =20
	driver_remove_file(&softdog_driver.driver, &driver_attr_soft_noboot);
	watchdog_driver_unregister(&softdog_driver);

	/* ensure somebody didn't leave the watchdog ticking */
	del_timer(&watchdog_ticktock);
}

module_init(watchdog_init);
module_exit(watchdog_exit);
MODULE_LICENSE("GPL");

--=-OCqRYTyLLIheoRtk3c+Q--

