Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbRCUPUl>; Wed, 21 Mar 2001 10:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRCUPUc>; Wed, 21 Mar 2001 10:20:32 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:56319 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130770AbRCUPUQ>; Wed, 21 Mar 2001 10:20:16 -0500
Message-ID: <3AB8C6EE.5EF6BA90@uow.edu.au>
Date: Thu, 22 Mar 2001 02:21:18 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH 2.4.3.6: fix netdevice initialization
In-Reply-To: <3AB8BA16.A25C0929@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Attached is a patch against 2.4.3-pre6, which adds alloc_etherdev and
> variants to the driver API.

Looks good.  Few minor things:

In register_netdev():

        if (strchr(dev->name, '%'))
        {
                err = -EBUSY;
                if(dev_alloc_name(dev, dev->name)<0)
                        goto out;
        }

We should propagate dev_alloc_name's return value:

		err = dev_alloc_name()
		if (err < 0)
			goto out;

And register_netdevice's, so

	        err = -EIO;
	        if (register_netdevice(dev))
	                goto out;
	
	        err = 0;

	out:

becomes simply

	err = register_netdevice(dev);
out:


More significantly, the driver probe functions now become:

xxx_probe()
{
	dev = alloc_etherdev(sizeof(xxx_private));
	...
	printk(KERN_INFO "%s: stuff\n", dev->name);
	...
	ret = register_netdev(dev);
	if (ret < 0)
		kfree(ret);
	return ret;
}

yes?

And the printk() will say "eth%d: stuff", so we'll need to
change the messages:

-	printk(KERN_INFO "%s: stuff\n", dev->name);
+	printk(KERN_INFO "xxx: stuff\n");

Correct?

My quibble with this is things like wait_for_completion(),
which are called from both the probe() function and
the mainline driver code.  These also print dev->name,
and there's no obvious fix for that.

For this reason I think I'd prefer it if alloc_etherdev()
was passed some probe-time identifier:

	alloc_etherdev(sizeof(xxx_private), "xxx");

which goes into dev->name, and gets overwritten by
register_netdev().

So, against your current patch:



--- drivers/net/net_init.c.orig	Thu Mar 22 02:11:47 2001
+++ drivers/net/net_init.c	Thu Mar 22 02:17:46 2001
@@ -71,7 +71,7 @@
 
 
 static struct net_device *alloc_netdev(int sizeof_priv, const char *mask,
-				       void (*setup)(struct net_device *))
+			const char *driver_name, void (*setup)(struct net_device *))
 {
 	struct net_device *dev;
 	int alloc_size;
@@ -92,7 +92,8 @@
 		dev->priv = (void *) (((long)(dev + 1) + 31) & ~31);
 
 	setup(dev);
-	strcpy(dev->name, mask);
+	strcpy(dev->ifname, mask);
+	strcpy(dev->name, driver_name);
 
 	return dev;
 }
@@ -216,9 +217,9 @@
  * this private data area.
  */
 
-struct net_device *alloc_etherdev(int sizeof_priv)
+struct net_device *alloc_etherdev(int sizeof_priv, const char *driver_name)
 {
-	return alloc_netdev(sizeof_priv, "eth%d", ether_setup);
+	return alloc_netdev(sizeof_priv, "eth%d", driver_name, ether_setup);
 }
 
 EXPORT_SYMBOL(init_etherdev);
@@ -532,7 +533,7 @@
 
 int register_netdev(struct net_device *dev)
 {
-	int err;
+	int err = 0;
 
 	rtnl_lock();
 
@@ -540,13 +541,14 @@
 	 *	If the name is a format string the caller wants us to
 	 *	do a name allocation
 	 */
-	 
-	if (strchr(dev->name, '%'))
-	{
-		err = -EBUSY;
-		if(dev_alloc_name(dev, dev->name)<0)
-			goto out;
-	}
+
+	/* Insert comment here */
+	if (strchr(dev->ifname, '%'))
+		err = dev_alloc_name(dev, dev->ifname);
+	else if (strchr(dev->name, '%'))
+		err = dev_alloc_name(dev, dev->name);
+	if (err < 0)
+		goto out;
 	
 	/*
 	 *	Back compatibility hook. Kill this one in 2.5
