Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267477AbTAGVte>; Tue, 7 Jan 2003 16:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTAGVte>; Tue, 7 Jan 2003 16:49:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:29352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267477AbTAGVtb>;
	Tue, 7 Jan 2003 16:49:31 -0500
Date: Tue, 7 Jan 2003 15:12:22 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: net devices: Get network devices to show up in sysfs.
In-Reply-To: <20030107214315.GA23011@gtf.org>
Message-ID: <Pine.LNX.4.33.0301071506250.1020-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Jan 2003, Jeff Garzik wrote:

> On Mon, Jan 06, 2003 at 07:50:37PM +0000, Linux Kernel Mailing List wrote:
> > ChangeSet 1.838.151.11, 2003/01/06 13:50:37-06:00, mochel@osdl.org
> > 
> > 	net devices: Get network devices to show up in sysfs.
> > 	
> > 	- declare net_subsys, and register during net_dev_init().
> > 	- Add kobject to struct net_device.
> > 	- initialize name and register in register_netdevice().
> > 	- remove in unregister_netdevice().
> > 	
> > diff -Nru a/include/linux/netdevice.h b/include/linux/netdevice.h
> > --- a/include/linux/netdevice.h	Tue Jan  7 13:06:05 2003
> > +++ b/include/linux/netdevice.h	Tue Jan  7 13:06:05 2003
> > @@ -28,6 +28,7 @@
> >  #include <linux/if.h>
> >  #include <linux/if_ether.h>
> >  #include <linux/if_packet.h>
> > +#include <linux/kobject.h>
> >  
> >  #include <asm/atomic.h>
> >  #include <asm/cache.h>
> > @@ -438,6 +439,9 @@
> >  	/* this will get initialized at each interface type init routine */
> >  	struct divert_blk	*divert;
> >  #endif /* CONFIG_NET_DIVERT */
> > +
> > +	/* generic object representation */
> > +	struct kobject kobj;
> >  };
> 
> Just curious, is this needed purely for reference counting, or mainly to
> hook into sysfs?  If the former, net devices already have reference
> counting, so I want to make sure kobjects do not run afoul of that.

The latter. If desired, the reference counting can be converted to use 
kobject refcounting. I can look into this, if you like. 

> > +	snprintf(dev->kobj.name,KOBJ_NAME_LEN,dev->name);
> > +	kobj_set_kset_s(dev,net_subsys);
> > +	ret = kobject_register(&dev->kobj);
> 
> If the return code matters, shouldn't you be checking for its success?

Bah. How about the attached patch instead? 


	-pat

===== net/core/dev.c 1.51 vs edited =====
--- 1.51/net/core/dev.c	Mon Jan  6 13:50:36 2003
+++ edited/net/core/dev.c	Tue Jan  7 15:10:55 2003
@@ -2520,6 +2520,11 @@
 		if (d == dev || !strcmp(d->name, dev->name))
 			goto out_err;
 	}
+	snprintf(dev->kobj.name,KOBJ_NAME_LEN,dev->name);
+	kobj_set_kset_s(dev,net_subsys);
+	if ((ret = kobject_register(&dev->kobj)))
+		goto out_err;
+	
 	/*
 	 *	nil rebuild_header routine,
 	 *	that should be never called and used as just bug trap.
@@ -2547,10 +2552,7 @@
 	notifier_call_chain(&netdev_chain, NETDEV_REGISTER, dev);
 
 	net_run_sbin_hotplug(dev, "register");
-
-	snprintf(dev->kobj.name,KOBJ_NAME_LEN,dev->name);
-	kobj_set_kset_s(dev,net_subsys);
-	ret = kobject_register(&dev->kobj);
+	ret = 0;
 
 out:
 	return ret;

