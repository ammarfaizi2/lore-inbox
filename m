Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSL1Kd4>; Sat, 28 Dec 2002 05:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbSL1Kd4>; Sat, 28 Dec 2002 05:33:56 -0500
Received: from dp.samba.org ([66.70.73.150]:29842 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266203AbSL1Kdy>;
	Sat, 28 Dec 2002 05:33:54 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: two 2.5 modules bugs 
In-reply-to: Your message of "Fri, 27 Dec 2002 17:16:35 BST."
             <200212271616.RAA03356@harpo.it.uu.se> 
Date: Sat, 28 Dec 2002 21:37:22 +1100
Message-Id: <20021228104213.7DA7B2C07C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200212271616.RAA03356@harpo.it.uu.se> you write:
> 1. With kernel 2.5.53 and module-init-tools-0.9.6, "modprobe tulip"
>    fails and goes into an infinite CPU-consuming loop. The problem
>    appears to be related to the dependency from tulip to crc32. If I
>    manually modprobe crc32 before modprobe tulip, it works. If crc32
>    isn't loaded, modprobe tulip first loads crc32 and then loops.
> 
>    module-init-tools-0.9.5 did not have this problem.

This should be fixed in 0.9.6: a double free caused all kinds of wierd
behavior.  Please tell me if this fixes it.

> 2. The implementation of old-style MODULE_PARMs with type "1-16s"
>    is broken. Instead of splicing the parameter at the commas and
>    storing pointers to the substrings in consecutive array elements,
>    the whole string is stored in the array instead.
> 
>    Consider parport_pc.c, which contains (simplified):
> 
>    static const char *irq[16];
>    MODULE_PARM(irq, "1-16s");
> 
>    "modprobe parport_pc irq=007" should store a pointer to "007" in
>    irq[0], but instead (unsigned int)irq[0] == 0x00373030, the ASCII
>    representation of "007" in little-endian. (Kernel 2.5.53 on x86,
>    with module-init-tools-0.9.[56].)

Ew.  I horribly misinterpreted "1-16s" to mean "a string 1-16 chars
long".  The obvious fix (untested) is:

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.53/kernel/module.c working-2.5.53-sparam/kernel/module.c
--- linux-2.5.53/kernel/module.c	2002-12-26 15:41:06.000000000 +1100
+++ working-2.5.53-sparam/kernel/module.c	2002-12-28 21:32:34.000000000 +1100
@@ -604,7 +604,8 @@ extern int set_obsolete(const char *val,
 		return param_array(kp->name, val, min, max, obsparm->addr,
 				   sizeof(long), param_set_long);
 	case 's':
-		return param_string(kp->name, val, min, max, obsparm->addr);
+		return param_array(kp->name, val, min, max, obsparm->addr,
+				   sizeof(char *), param_set_charp);
 	}
 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
 	return -EINVAL;

I'll test this tomorrow...

Thanks for the bug report!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
