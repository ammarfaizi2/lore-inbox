Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbQKQUBB>; Fri, 17 Nov 2000 15:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130502AbQKQUAw>; Fri, 17 Nov 2000 15:00:52 -0500
Received: from 62-6-231-5.btconnect.com ([62.6.231.5]:49792 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S130442AbQKQUAb>;
	Fri, 17 Nov 2000 15:00:31 -0500
Date: Fri, 17 Nov 2000 19:20:04 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Cezary Kaliszyk <kaliszyk@pagi.pl>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: BUG with no HOTPLUG set.
In-Reply-To: <Pine.Lnx.4.21.0011171951530.1303-100000@orka.wrzos>
Message-ID: <Pine.LNX.4.21.0011171918300.1390-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Cezary Kaliszyk wrote:

> When I try to compile 2.4.0test11pre6 without HOTPLUG make says:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
> -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -mpreferred-stack-boundary=2 -march=i686    -c -o dev.o dev.c
> dev.c: In function `run_sbin_hotplug':
> dev.c:2736: `hotplug_path' undeclared (first use in this function)
> dev.c:2736: (Each undeclared identifier is reported only once
> dev.c:2736: for each function it appears in.)
> make[3]: *** [dev.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4/net/core'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4/net/core'
> make[1]: *** [_subdir_core] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4/net'
> make: *** [_dir_net] Error 2
> 
> It looks like /net/core/dev.c should add functions like run_sbin_hotplug
> only if CONFIG_HOTPLUG is set.

no, not just there but also in init/main.c the patch below has been posted
here ages ago and a similar one even earlier (so I was told, I didn't
check).

Regards,
Tigran

diff -urN -X dontdiff linux/init/main.c work/init/main.c
--- linux/init/main.c	Fri Nov 17 10:29:34 2000
+++ work/init/main.c	Fri Nov 17 11:27:27 2000
@@ -712,11 +712,13 @@
 	init_pcmcia_ds();		/* Do this last */
 #endif
 
+#ifdef CONFIG_HOTPLUG
 	/* do this after other 'do this last' stuff, because we want
 	 * to minimize spurious executions of /sbin/hotplug
 	 * during boot-up
 	 */
 	net_notifier_init();
+#endif
 
 	/* Mount the root filesystem.. */
 	mount_root();
diff -urN -X dontdiff linux/net/core/dev.c work/net/core/dev.c
--- linux/net/core/dev.c	Fri Nov 17 10:29:34 2000
+++ work/net/core/dev.c	Fri Nov 17 11:27:15 2000
@@ -2704,6 +2704,7 @@
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG
 
 /* Notify userspace when a netdevice event occurs,
  * by running '/sbin/hotplug net' with certain
@@ -2765,3 +2766,4 @@
 		printk (KERN_WARNING "unable to register netdev notifier\n"
 			KERN_WARNING "/sbin/hotplug will not be run.\n");
 }
+#endif

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
