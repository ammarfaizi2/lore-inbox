Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292359AbSBUM6I>; Thu, 21 Feb 2002 07:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292361AbSBUM6D>; Thu, 21 Feb 2002 07:58:03 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:28934 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S292359AbSBUM5s>;
	Thu, 21 Feb 2002 07:57:48 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: jgarzik@mandrakesoft.com
Cc: zwane@linux.realnet.co.sz, roy@karlsbakk.net, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C74E698.D3A0BFEB@mandrakesoft.com> (message from Jeff Garzik on
	Thu, 21 Feb 2002 07:22:48 -0500)
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz> <3C74C8C7.25D7BCD@mandrakesoft.com> <20020221111910.57235F5B@acolyte.hack.org> <20020221115916.9FD5AF5B@acolyte.hack.org> <3C74E698.D3A0BFEB@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="++----------20020221135634-115899597----------++"
Content-Transfer-Encoding: 7bit
X-Mailer: Emacs 20.5.1 with etach 1.1.6
Message-Id: <20020221125743.10F0BF5B@acolyte.hack.org>
Date: Thu, 21 Feb 2002 13:57:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--++----------20020221135634-115899597----------++
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> MODULE_PARM_DESC would be nice

Done.  

> > static void scx200_watchdog_update_margin(void)
> > {
> >         printk(KERN_INFO "%s: timer margin %d seconds\n", name, margin);
> >         wdto_restart = 32768 / 1024 * margin;
> >         scx200_watchdog_ping();
> > }
> 
> if you can turn multiplication and division of powers-of-2 into left and
> right shifts, other simplications sometimes follow.  Certainly you want
> to avoid division especially and multiplication also if possible.

Since this is only called on initialization I'm not overly concerned
with performance here, I prefer code clarity.  This ought to be
optimized by gcc anyways.

> now, a policy question -- do you want to fail or simply put to sleep
> multiple openers?  if you want to fail, this should be ok I think.  if
> you want to sleep, you can look at sound/oss/* in 2.5.x or
> drivers/sound/* in 2.4.x for some examples of semaphore use on
> open(2).

I'm not even sure if single-open sematics are neccesary at all, but I
copied most of the interface from wdt285.c so I copied this too.  The
watchdog API seems to be a rather ad hoc thing.  For example I just
noticed that the WDIOC_SETTIMEOUT call probably takes a parameter
which seems to be minutes, not seconds.  "Someone (tm)" ought to write
a more formal API specification.

> I wonder why 'name' is not simply a macro defining a string constant? 
> Oh yeah, it matters very little.  You might want to make 'name' const,
> though.

Because "%s: " is less text than "scx200_watchdog" and I'm not sure if
gcc is able to merge duplicate strings.  Not much of a difference.

> > static struct notifier_block scx200_watchdog_notifier =
> > {
> >         scx200_watchdog_notify_sys,
> >         NULL,
> >         0
> > };
> 
> use name:value style of struct initialization, and omit any struct
> members which are 0/NULL (that's implicit).

Done.  I also changed the notifier codes that cause the watchdog to
shut down to something that seems more useful.

> > static int __init scx200_watchdog_init(void)
> > {
> >         int r;
> 
> Here's a big one, I still don't like this lack of probing in the
> driver.  Sure we have "probed elsewhere", but IMO each driver like this
> one needs to check -something- to ensure that SC1200 hardware is
> present.  Otherwise, a random user from a distro-that-builds-all-drivers
> might "modprobe sc1200_watchdog" and things go boom.

You're right, I just assumed that nobody would load this driver unless
they are on a SCx200 system.  Done.  I'll update all the other drivers
too.

  /Christer (off to lunch)

-- 
Blatant plug: I'm a freelance consultant looking for interesting work.
--++----------20020221135634-115899597----------++
Content-Type: application/octet-stream; name="d.diff"
Content-Transfer-Encoding: 7bit

diff -urw nano/drivers/char/scx200_watchdog.c.orig nano/drivers/char/scx200_watchdog.c
--- nano/drivers/char/scx200_watchdog.c.orig	Thu Feb 21 13:49:53 2002
+++ nano/drivers/char/scx200_watchdog.c	Thu Feb 21 13:55:30 2002
@@ -38,13 +38,15 @@
 #define CONFIG_WATCHDOG_NOWAYOUT 0
 #endif
 
-static char name[] = "scx200_watchdog";
+static const char name[] = "scx200_watchdog";
 
 static int margin = 60;		/* in seconds */
 MODULE_PARM(margin, "i");
+MODULE_PARM_DESC(margin, "Watchdog margin in seconds");
 
 static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
 MODULE_PARM(nowayout, "i");
+MODULE_PARM_DESC(nowayout, "If true the watchdog can't be disabled\n");
 
 static u16 wdto_restart;
 static struct semaphore open_sem;
@@ -57,6 +59,8 @@
 #define WDSTS 0x04		/* Status Register */
 #define    WDOVF (1<<0)		/* Overflow */
 
+#define W_SCALE (32768/1024)	/* This depends on the value of W_ENABLE */
+
 static void scx200_watchdog_ping(void)
 {
 	outw(wdto_restart, scx200_config_block + WDTO);
@@ -65,7 +69,7 @@
 static void scx200_watchdog_update_margin(void)
 {
 	printk(KERN_INFO "%s: timer margin %d seconds\n", name, margin);
-	wdto_restart = 32768 / 1024 * margin;
+	wdto_restart = margin * W_SCALE;
 	scx200_watchdog_ping();	
 }
 
@@ -117,7 +121,7 @@
 static int scx200_watchdog_notify_sys(struct notifier_block *this, 
 				      unsigned long code, void *unused)
 {
-        if (code == SYS_DOWN || code == SYS_HALT)
+        if (code == SYS_HALT || code == SYS_POWER_OFF)
 		scx200_watchdog_disable();
 
         return NOTIFY_DONE;
@@ -125,9 +129,7 @@
 
 static struct notifier_block scx200_watchdog_notifier =
 {
-        scx200_watchdog_notify_sys,
-        NULL,
-        0
+        notifier_call: scx200_watchdog_notify_sys
 };
 
 static ssize_t scx200_watchdog_write(struct file *file, const char *data, 
@@ -182,13 +184,12 @@
 	case WDIOC_SETTIMEOUT:
 		if (get_user(new_margin, (int *)arg))
 			return -EFAULT;
-		margin = new_margin;
+		margin = new_margin * 60; /* convert minutes to seconds */
 		scx200_watchdog_update_margin();
 		return 0;
-
 #ifdef WDIOC_GETTIMEOUT		
 	case WDIOC_GETTIMEOUT:
-		return put_user(margin, (int *)arg);
+		return put_user((margin + 59) / 60, (int *)arg);
 #endif
 	}
 }
@@ -210,6 +211,11 @@
 static int __init scx200_watchdog_init(void)
 {
 	int r;
+
+	if (scx200_f0_pdev == NULL) {
+		printk(KERN_ERR "%s: Not a SCx200 CPU\n", name);
+		return -ENODEV;
+	}
 
 	scx200_watchdog_update_margin();
         sema_init(&open_sem, 1);
--++----------20020221135634-115899597----------++--
