Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261329AbRELW2f>; Sat, 12 May 2001 18:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbRELW2Z>; Sat, 12 May 2001 18:28:25 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.14]:17552 "EHLO
	a1a90191.sympatico.bconnected.net") by vger.kernel.org with ESMTP
	id <S261327AbRELW2O>; Sat, 12 May 2001 18:28:14 -0400
Date: Sat, 12 May 2001 15:27:53 -0700
From: Shane Wegner <shane@cm.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: ENOIOCTLCMD?
Message-ID: <20010512152753.A21262@cm.nu>
In-Reply-To: <p05100302b7226d91e632@[207.213.214.37]> <E14yXNZ-000447-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14yXNZ-000447-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, May 12, 2001 at 12:16:09PM +0100
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2001 at 12:16:09PM +0100, Alan Cox wrote:
> > Can somebody explain the use of ENOIOCTLCMD? There are order of 170 
> > uses in the kernel, but I don't see any guidelines for that use (nor 
> > what prevents it from being seen by user programs).
> 
> It should never be seen by apps. If it can be then it is wrong code.
> Basically you use it in things like
> 
> 
> 
> 	int err = dev->ioctlfunc(dev, op, arg);
> 	if( err != -ENOIOCTLCMD)
> 		return err;
> 
> 	/* Driver specific code does not support this ioctl */

I noticed this return coming out of the watchdog driver a
while ago when I was playing with it.  I have taken a quick
look and it seems a few drivers do return this directly to
userspace.  I'm not sure if this is complete but ...

diff -ur linux-2.4.4-ac8/drivers/block/swim3.c linux/drivers/block/swim3.c
--- linux-2.4.4-ac8/drivers/block/swim3.c	Sat May 12 14:59:44 2001
+++ linux/drivers/block/swim3.c	Sat May 12 15:22:30 2001
@@ -848,7 +848,7 @@
 				   sizeof(struct floppy_struct));
 		return err;
 	}
-	return -ENOIOCTLCMD;
+	return -ENOTTY;
 }
 
 static int floppy_open(struct inode *inode, struct file *filp)
diff -ur linux-2.4.4-ac8/drivers/block/swim_iop.c linux/drivers/block/swim_iop.c
--- linux-2.4.4-ac8/drivers/block/swim_iop.c	Wed Feb 16 10:56:45 2000
+++ linux/drivers/block/swim_iop.c	Sat May 12 15:23:12 2001
@@ -363,7 +363,7 @@
 				   sizeof(struct floppy_struct));
 		return err;
 	}
-	return -ENOIOCTLCMD;
+	return -ENOTTY;
 }
 
 static int floppy_open(struct inode *inode, struct file *filp)
diff -ur linux-2.4.4-ac8/drivers/char/acquirewdt.c linux/drivers/char/acquirewdt.c
--- linux-2.4.4-ac8/drivers/char/acquirewdt.c	Fri Feb  9 11:30:22 2001
+++ linux/drivers/char/acquirewdt.c	Sat May 12 15:14:49 2001
@@ -110,7 +110,7 @@
 	  break;
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 	return 0;
 }
diff -ur linux-2.4.4-ac8/drivers/char/advantechwdt.c linux/drivers/char/advantechwdt.c
--- linux-2.4.4-ac8/drivers/char/advantechwdt.c	Tue Mar  6 19:44:34 2001
+++ linux/drivers/char/advantechwdt.c	Sat May 12 15:15:58 2001
@@ -120,7 +120,7 @@
 	  break;
 
 	default:
-	  return -ENOIOCTLCMD;
+	  return -ENOTTY;
 	}
 	return 0;
 }
diff -ur linux-2.4.4-ac8/drivers/char/i810-tco.c linux/drivers/char/i810-tco.c
--- linux-2.4.4-ac8/drivers/char/i810-tco.c	Fri Dec 29 14:35:47 2000
+++ linux/drivers/char/i810-tco.c	Sat May 12 15:02:47 2001
@@ -213,7 +213,7 @@
 	};
 	switch (cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	case WDIOC_GETSUPPORT:
 		if (copy_to_user
 		    ((struct watchdog_info *) arg, &ident, sizeof (ident)))
diff -ur linux-2.4.4-ac8/drivers/char/machzwd.c linux/drivers/char/machzwd.c
--- linux-2.4.4-ac8/drivers/char/machzwd.c	Thu Apr 12 12:16:35 2001
+++ linux/drivers/char/machzwd.c	Sat May 12 15:09:42 2001
@@ -357,7 +357,7 @@
 			break;
 
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 
 	return 0;
diff -ur linux-2.4.4-ac8/drivers/char/mixcomwd.c linux/drivers/char/mixcomwd.c
--- linux-2.4.4-ac8/drivers/char/mixcomwd.c	Sun Dec  3 17:45:21 2000
+++ linux/drivers/char/mixcomwd.c	Sat May 12 15:15:18 2001
@@ -165,7 +165,7 @@
 			mixcomwd_ping();
 			break;
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 	}
 	return 0;
 }
diff -ur linux-2.4.4-ac8/drivers/char/pc110pad.c linux/drivers/char/pc110pad.c
--- linux-2.4.4-ac8/drivers/char/pc110pad.c	Sun Feb  4 10:05:29 2001
+++ linux/drivers/char/pc110pad.c	Sat May 12 15:13:26 2001
@@ -766,7 +766,7 @@
 		current_params.tap_interval	= new.tap_interval;
 		return 0;
 	}
-	return -ENOIOCTLCMD;
+	return -ENOTTY;
 }
 
 
diff -ur linux-2.4.4-ac8/drivers/char/pcwd.c linux/drivers/char/pcwd.c
--- linux-2.4.4-ac8/drivers/char/pcwd.c	Fri Apr  6 10:42:55 2001
+++ linux/drivers/char/pcwd.c	Sat May 12 15:03:07 2001
@@ -247,7 +247,7 @@
 
 	switch(cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 
 	case WDIOC_GETSUPPORT:
 		i = copy_to_user((void*)arg, &ident, sizeof(ident));
diff -ur linux-2.4.4-ac8/drivers/char/sbc60xxwdt.c linux/drivers/char/sbc60xxwdt.c
--- linux-2.4.4-ac8/drivers/char/sbc60xxwdt.c	Fri Feb  9 11:30:22 2001
+++ linux/drivers/char/sbc60xxwdt.c	Sat May 12 15:10:46 2001
@@ -241,7 +241,7 @@
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
 		case WDIOC_KEEPALIVE:
diff -ur linux-2.4.4-ac8/drivers/char/softdog.c linux/drivers/char/softdog.c
--- linux-2.4.4-ac8/drivers/char/softdog.c	Tue Feb 13 14:13:43 2001
+++ linux/drivers/char/softdog.c	Sat May 12 15:00:53 2001
@@ -132,7 +132,7 @@
 	};
 	switch (cmd) {
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			if(copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident)))
 				return -EFAULT;
diff -ur linux-2.4.4-ac8/drivers/char/wdt.c linux/drivers/char/wdt.c
--- linux-2.4.4-ac8/drivers/char/wdt.c	Fri Feb  9 11:30:22 2001
+++ linux/drivers/char/wdt.c	Sat May 12 15:06:40 2001
@@ -311,7 +311,7 @@
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
 
diff -ur linux-2.4.4-ac8/drivers/char/wdt285.c linux/drivers/char/wdt285.c
--- linux-2.4.4-ac8/drivers/char/wdt285.c	Mon Oct 16 12:58:51 2000
+++ linux/drivers/char/wdt285.c	Sat May 12 15:00:53 2001
@@ -136,7 +136,7 @@
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			i = verify_area(VERIFY_WRITE, (void*) arg, sizeof(struct watchdog_info));
 			if (i)
diff -ur linux-2.4.4-ac8/drivers/char/wdt_pci.c linux/drivers/char/wdt_pci.c
--- linux-2.4.4-ac8/drivers/char/wdt_pci.c	Fri Feb  9 11:30:22 2001
+++ linux/drivers/char/wdt_pci.c	Sat May 12 15:00:53 2001
@@ -327,7 +327,7 @@
 	switch(cmd)
 	{
 		default:
-			return -ENOIOCTLCMD;
+			return -ENOTTY;
 		case WDIOC_GETSUPPORT:
 			return copy_to_user((struct watchdog_info *)arg, &ident, sizeof(ident))?-EFAULT:0;
 


-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
