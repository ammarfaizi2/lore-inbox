Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129660AbQKEBwx>; Sat, 4 Nov 2000 20:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKEBwn>; Sat, 4 Nov 2000 20:52:43 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:35779 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129577AbQKEBw3>; Sat, 4 Nov 2000 20:52:29 -0500
Message-ID: <3A04BD5A.37E7A3AB@uow.edu.au>
Date: Sun, 05 Nov 2000 12:52:26 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com> <3A03DABD.AF4B9AD5@mandrakesoft.com> <20001104111909.A11500@gruyere.muc.suse.de> <3A042D04.5B3A7946@mandrakesoft.com> <20001104175659.A15475@gruyere.muc.suse.de> <3A044256.D8CD063C@mandrakesoft.com>,
			<3A044256.D8CD063C@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Nov 04, 2000 at 12:07:34PM -0500 <20001105013809.B21900@gruyere.muc.suse.de> <3A04B7D7.6B47B503@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Perhaps the best thing to do here is to create a system-wide
> semaphore for module unloading. So we do a down()/up()
> in sys_delete_module() and do this in dev_open:

Yep.  I think this is right.  Jeff, this supersedes the
patch you sent to devem yesterday.


--- linux-2.4.0-test10/include/linux/netdevice.h	Sat Nov  4 16:22:49 2000
+++ linux-akpm/include/linux/netdevice.h	Sun Nov  5 12:40:00 2000
@@ -146,6 +146,11 @@
 struct neigh_parms;
 struct sk_buff;
 
+/* Centralised module refcounting for netdevices */
+struct module;
+#define SET_NETDEVICE_OWNER(dev)	\
+	do { dev->owner = THIS_MODULE; } while (0)
+
 struct netif_rx_stats
 {
 	unsigned total;
@@ -382,6 +387,9 @@
 						     unsigned char *haddr);
 	int			(*neigh_setup)(struct net_device *dev, struct neigh_parms *);
 	int			(*accept_fastpath)(struct net_device *, struct dst_entry*);
+
+	/* open/release and usage marking */
+	struct module *owner;
 
 	/* bridge stuff */
 	struct net_bridge_port	*br_port;
--- linux-2.4.0-test10/include/linux/module.h	Sat Nov  4 16:22:49 2000
+++ linux-akpm/include/linux/module.h	Sun Nov  5 12:37:54 2000
@@ -146,10 +146,16 @@
 #ifdef CONFIG_MODULES
 extern unsigned long get_module_symbol(char *, char *);
 extern void put_module_symbol(unsigned long);
+struct semaphore;
+extern struct semaphore mod_unload_sem;
+#define DOWN_MOD_UNLOAD_SEM() down(&mod_unload_sem)
+#define UP_MOD_UNLOAD_SEM() up(&mod_unload_sem)
 #else
 static inline unsigned long get_module_symbol(char *unused1, char *unused2) { return 0; };
 static inline void put_module_symbol(unsigned long unused) { };
-#endif
+#define DOWN_MOD_UNLOAD_SEM() do { } while (0)
+#define UP_MOD_UNLOAD_SEM() do { } while (0)
+#endif 
 
 extern int try_inc_mod_count(struct module *mod);
 
--- linux-2.4.0-test10/net/core/dev.c	Sat Nov  4 16:22:50 2000
+++ linux-akpm/net/core/dev.c	Sun Nov  5 12:39:23 2000
@@ -93,6 +93,7 @@
 #include <net/profile.h>
 #include <linux/init.h>
 #include <linux/kmod.h>
+#include <linux/module.h>
 #if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
@@ -666,9 +667,20 @@
 	/*
 	 *	Call device private open method
 	 */
-	 
-	if (dev->open) 
-  		ret = dev->open(dev);
+	DOWN_MOD_UNLOAD_SEM();			/* Synchronise with sys_delete_module */
+	if (dev->owner == 0) {
+		if (dev->open)
+	  		ret = dev->open(dev);
+	} else {
+		if (try_inc_mod_count(dev->owner)) {
+			if (dev->open) {
+		  		if ((ret = dev->open(dev)) != 0)
+					__MOD_DEC_USE_COUNT(dev->owner);
+			}
+		} else
+			ret = -ENODEV;
+	}
+	UP_MOD_UNLOAD_SEM();
 
 	/*
 	 *	If it went open OK then:
@@ -783,6 +795,13 @@
 	 *	Tell people we are down
 	 */
 	notifier_call_chain(&netdev_chain, NETDEV_DOWN, dev);
+
+	/*
+	 * Drop the module refcount
+	 */
+	if (dev->owner) {
+		__MOD_DEC_USE_COUNT(dev->owner);
+	}
 
 	return(0);
 }
--- linux-2.4.0-test10/kernel/module.c	Sat Nov  4 16:22:49 2000
+++ linux-akpm/kernel/module.c	Sun Nov  5 12:36:03 2000
@@ -44,6 +44,7 @@
 static struct module *find_module(const char *name);
 static void free_module(struct module *, int tag_freed);
 
+DECLARE_MUTEX(mod_unload_sem);
 
 /*
  * Called at boot time
@@ -369,6 +370,7 @@
 		return -EPERM;
 
 	lock_kernel();
+	down(&mod_unload_sem);
 	if (name_user) {
 		if ((error = get_mod_name(name_user, &name)) < 0)
 			goto out;
@@ -431,6 +433,7 @@
 		mod->flags &= ~MOD_JUST_FREED;
 	error = 0;
 out:
+	up(&mod_unload_sem);
 	unlock_kernel();
 	return error;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
