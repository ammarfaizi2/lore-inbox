Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUBLDQU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 22:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUBLDQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 22:16:20 -0500
Received: from dp.samba.org ([66.70.73.150]:60310 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264477AbUBLDQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 22:16:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Shut up about the damn modules already...
Date: Thu, 12 Feb 2004 14:13:32 +1100
Message-Id: <20040212031631.69CAD2C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply before 2.6.3.

In almost all distributions, the kernel asks for modules which don't
exist, such as "net-pf-10" or whatever.  Changing "modprobe -q" to
"succeed" in this case is hacky and breaks some setups, and also we
want to know if it failed for the fallback code for old aliases in
fs/char_dev.c, for example.

Just remove the debugging message which fill people's logs: the
correct way of debugging module problems is something like this:

echo '#! /bin/sh' > /tmp/modprobe
echo 'echo "$@" >> /tmp/modprobe.log' >> /tmp/modprobe
echo 'exec /sbin/modprobe "$@"' >> /tmp/modprobe
chmod a+x /tmp/modprobe
echo /tmp/modprobe > /proc/sys/kernel/modprobe

Thanks!
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.3-rc2-bk1/kernel/kmod.c tmp/kernel/kmod.c
--- linux-2.6.3-rc2-bk1/kernel/kmod.c	2004-01-10 13:59:39.000000000 +1100
+++ tmp/kernel/kmod.c	2004-02-12 14:07:33.000000000 +1100
@@ -105,16 +105,6 @@ int request_module(const char *fmt, ...)
 	}
 
 	ret = call_usermodehelper(modprobe_path, argv, envp, 1);
-	if (ret != 0) {
-		static unsigned long last;
-		unsigned long now = jiffies;
-		if (now - last > HZ) {
-			last = now;
-			printk(KERN_DEBUG
-			       "request_module: failed %s -- %s. error = %d\n",
-			       modprobe_path, module_name, ret);
-		}
-	}
 	atomic_dec(&kmod_concurrent);
 	return ret;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
