Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbSL3GFn>; Mon, 30 Dec 2002 01:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266721AbSL3GFn>; Mon, 30 Dec 2002 01:05:43 -0500
Received: from dp.samba.org ([66.70.73.150]:32441 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266718AbSL3GFm>;
	Mon, 30 Dec 2002 01:05:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: two 2.5 modules bugs 
In-reply-to: Your message of "Sun, 29 Dec 2002 21:18:21 BST."
             <200212292018.VAA25446@harpo.it.uu.se> 
Date: Mon, 30 Dec 2002 17:13:07 +1100
Message-Id: <20021230061405.9D0742C252@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200212292018.VAA25446@harpo.it.uu.se> you write:
> >long".  The obvious fix (untested) is:
> >
> Tested. This patch makes the parport_pc module work again. Thanks.

Linus, please apply.  Mikael, thanks for the excellent bug report!

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Fix MODULE_PARM for arrays of s.
Author: Rusty Russell
Status: Tested on 2.5.53 (by Mikael Pettersson)

D: I interpreted "1-10s" to mean a string of 1-10 chars.  It actually
D: means 1-10 comma-separated strings.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .748-linux-2.5-bk/kernel/module.c .748-linux-2.5-bk.updated/kernel/module.c
--- .748-linux-2.5-bk/kernel/module.c	2002-12-30 15:30:15.000000000 +1100
+++ .748-linux-2.5-bk.updated/kernel/module.c	2002-12-30 17:11:37.000000000 +1100
@@ -569,20 +569,6 @@ static int param_set_byte(const char *va
 	return 0;
 }
 
-static int param_string(const char *name, const char *val,
-			unsigned int min, unsigned int max,
-			char *dest)
-{
-	if (strlen(val) < min || strlen(val) > max) {
-		printk(KERN_ERR
-		       "Parameter %s length must be %u-%u characters\n",
-		       name, min, max);
-		return -EINVAL;
-	}
-	strcpy(dest, val);
-	return 0;
-}
-
 extern int set_obsolete(const char *val, struct kernel_param *kp)
 {
 	unsigned int min, max;
@@ -618,7 +604,8 @@ extern int set_obsolete(const char *val,
 		return param_array(kp->name, val, min, max, obsparm->addr,
 				   sizeof(long), param_set_long);
 	case 's':
-		return param_string(kp->name, val, min, max, obsparm->addr);
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   sizeof(char *), param_set_charp);
 	}
 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
 	return -EINVAL;
