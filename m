Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSL2UKB>; Sun, 29 Dec 2002 15:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSL2UKB>; Sun, 29 Dec 2002 15:10:01 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:15037 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261624AbSL2UKA>;
	Sun, 29 Dec 2002 15:10:00 -0500
Date: Sun, 29 Dec 2002 21:18:21 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200212292018.VAA25446@harpo.it.uu.se>
To: rusty@rustcorp.com.au
Subject: Re: two 2.5 modules bugs
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2002 21:37:22 +1100, Rusty Russell wrote:
>> 1. With kernel 2.5.53 and module-init-tools-0.9.6, "modprobe tulip"
>>    fails and goes into an infinite CPU-consuming loop. The problem
>>    appears to be related to the dependency from tulip to crc32. If I
>>    manually modprobe crc32 before modprobe tulip, it works. If crc32
>>    isn't loaded, modprobe tulip first loads crc32 and then loops.
>> 
>>    module-init-tools-0.9.5 did not have this problem.
>
>This should be fixed in 0.9.6: a double free caused all kinds of wierd
>behavior.  Please tell me if this fixes it.

module-init-tools-0.9.7 fixed the problem.

>Ew.  I horribly misinterpreted "1-16s" to mean "a string 1-16 chars
>long".  The obvious fix (untested) is:
>
>diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.53/kernel/module.c working-2.5.53-sparam/kernel/module.c
>--- linux-2.5.53/kernel/module.c	2002-12-26 15:41:06.000000000 +1100
>+++ working-2.5.53-sparam/kernel/module.c	2002-12-28 21:32:34.000000000 +1100
>@@ -604,7 +604,8 @@ extern int set_obsolete(const char *val,
> 		return param_array(kp->name, val, min, max, obsparm->addr,
> 				   sizeof(long), param_set_long);
> 	case 's':
>-		return param_string(kp->name, val, min, max, obsparm->addr);
>+		return param_array(kp->name, val, min, max, obsparm->addr,
>+				   sizeof(char *), param_set_charp);
> 	}
> 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
> 	return -EINVAL;

Tested. This patch makes the parport_pc module work again. Thanks.

/Mikael
