Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKELqh>; Sun, 5 Nov 2000 06:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKELq0>; Sun, 5 Nov 2000 06:46:26 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:1750 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129102AbQKELqR>; Sun, 5 Nov 2000 06:46:17 -0500
Message-ID: <3A054872.8D88EF95@uow.edu.au>
Date: Sun, 05 Nov 2000 22:45:54 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: Your message of "Sun, 05 Nov 2000 14:39:43 +1100."
	             <9277.973395583@ocs3.ocs-net> <9368.973396061@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> Pressed enter too soon.
> 
>         /*
>          *      Call device private open method
>          */
> 
>         ret = -ENODEV;
>         if (dev->open && try_inc_mod_count(dev->owner)) {
>                 if ((ret = dev->open(dev)) && dev->owner)
>                         __MOD_DEC_USE_COUNT(dev->owner);
>         }

y'know, if we keep working this patch for about a year we
might end up getting it right.  Thousand monkeys and all that.

The above assumes that (dev->open == 0) is an error, but
netdevices are in fact allowed to have a NULL open() method.

So hereunder is about the seventieth version of the netdevice
modules safety patch.  Go wild.

Some notes:

- I've created the generic macro SET_OWNER_MODULE and put it
  into modules.h.  It may perhaps be useful for things other
  than netdevices?  The intent here is that 2.4-only drivers
  can use:

	SET_OWNER_MODULE(dev);

  in their init routines.
  
  Drivers which retain 2.2 compatibility should use:

  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
  #define SET_OWNER_MODULE(d)
  #else
  #undef MOD_INC_USE_COUNT
  #undef MOD_DEC_USE_COUNT
  #endif

    xxx_probe()
    {
	...
	SET_MODULE_OWNER(dev);		/* 2.4 */
	...
	MOD_INC_USE_COUNT;		/* 2.2 */
    }

  And everything should work.

- With this patch applied, the module refcounts for netdevices
  will show doubled values in `lsmod', unless those drivers
  have been changed to remove the now unneeded MOD_INC/DEC_USE_COUNT
  macros (perhaps with the above 2.2-compatibility thing).



--- linux-2.4.0-test10/include/linux/netdevice.h	Sat Nov  4 16:22:49 2000
+++ linux-akpm/include/linux/netdevice.h	Sun Nov  5 22:15:48 2000
@@ -383,6 +383,9 @@
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
 
+	/* open/release and usage marking */
+	struct module *owner;
+
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;
 
--- linux-2.4.0-test10/include/linux/module.h	Sat Nov  4 16:22:49 2000
+++ linux-akpm/include/linux/module.h	Sun Nov  5 22:18:16 2000
@@ -313,4 +313,10 @@
 #define EXPORT_NO_SYMBOLS
 #endif /* MODULE */
 
+#ifdef CONFIG_MODULES
+#define SET_OWNER_MODULE(some_struct) do { some_struct->owner = THIS_MODULE; } while (0)
+#else
+#define SET_OWNER_MODULE(some_struct) do { } while (0)
+#endif
+
 #endif /* _LINUX_MODULE_H */
--- linux-2.4.0-test10/net/core/dev.c	Sat Nov  4 16:22:50 2000
+++ linux-akpm/net/core/dev.c	Sun Nov  5 22:31:57 2000
@@ -93,6 +93,7 @@
 #include <net/profile.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
+#include <linux/module.h>
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
@@ -666,9 +667,15 @@
 	/*
 	 *	Call device private open method
 	 */
-	 
-	if (dev->open) 
-  		ret = dev->open(dev);
+	if (try_inc_mod_count(dev->owner)) {
+		if (dev->open) {
+			ret = dev->open(dev);
+			if (ret != 0 && dev->owner)
+				__MOD_DEC_USE_COUNT(dev->owner);
+		}
+	} else {
+		ret = -ENODEV;
+	}
 
 	/*
 	 *	If it went open OK then:
@@ -783,6 +790,12 @@
 	 *	Tell people we are down
 	 */
 	notifier_call_chain(&netdev_chain, NETDEV_DOWN, dev);
+
+	/*
+	 * Drop the module refcount
+	 */
+	if (dev->owner)
+		__MOD_DEC_USE_COUNT(dev->owner);
 
 	return(0);
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
