Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbSL3Lb4>; Mon, 30 Dec 2002 06:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbSL3Lb4>; Mon, 30 Dec 2002 06:31:56 -0500
Received: from dp.samba.org ([66.70.73.150]:32996 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266907AbSL3Lbz>;
	Mon, 30 Dec 2002 06:31:55 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: two 2.5 modules bugs 
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-reply-to: Your message of "Mon, 30 Dec 2002 17:13:07 +1100."
Date: Mon, 30 Dec 2002 22:39:14 +1100
Message-Id: <20021230114018.7FE4A2C063@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <200212292018.VAA25446@harpo.it.uu.se> you write:
> > >long".  The obvious fix (untested) is:
> > >
> > Tested. This patch makes the parport_pc module work again. Thanks.
> 
> Linus, please apply.  Mikael, thanks for the excellent bug report!
> 
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 
> Name: Fix MODULE_PARM for arrays of s.

And this as well.  We restore the ","s after parsing: if expect to
keep pointers to this stuff, we must not do that.

Linus, please apply.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5399-linux-2.5-bk/kernel/params.c .5399-linux-2.5-bk.updated/kernel/params.c
--- .5399-linux-2.5-bk/kernel/params.c	2002-12-26 15:41:06.000000000 +1100
+++ .5399-linux-2.5-bk.updated/kernel/params.c	2002-12-30 20:30:38.000000000 +1100
@@ -233,6 +233,7 @@ int param_array(const char *name,
 	int ret;
 	unsigned int count = 0;
 	struct kernel_param kp;
+	char save;
 
 	/* Get the name right for errors. */
 	kp.name = name;
@@ -247,7 +248,6 @@ int param_array(const char *name,
 	/* We expect a comma-separated list of values. */
 	do {
 		int len;
-		char save;
 
 		if (count > max) {
 			printk(KERN_ERR "%s: can only take %i arguments\n",
@@ -256,18 +256,17 @@ int param_array(const char *name,
 		}
 		len = strcspn(val, ",");
 
-		/* Temporarily nul-terminate and parse */
+		/* nul-terminate and parse */
 		save = val[len];
 		((char *)val)[len] = '\0';
 		ret = set(val, &kp);
-		((char *)val)[len] = save;
 
 		if (ret != 0)
 			return ret;
 		kp.arg += elemsize;
 		val += len+1;
 		count++;
-	} while (val[-1] == ',');
+	} while (save == ',');
 
 	if (count < min) {
 		printk(KERN_ERR "%s: needs at least %i arguments\n",
