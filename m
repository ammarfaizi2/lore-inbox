Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUKPIoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUKPIoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 03:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUKPIoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 03:44:00 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:37381 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261938AbUKPInt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 03:43:49 -0500
Date: Tue, 16 Nov 2004 08:43:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
Message-ID: <20041116084341.GA24484@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org
References: <200410311003.i9VA3UMN009557@anakin.of.borg> <20041101142245.GA28253@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101142245.GA28253@infradead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 02:22:45PM +0000, Christoph Hellwig wrote:
> On Sun, Oct 31, 2004 at 11:03:30AM +0100, Geert Uytterhoeven wrote:
> > HP300 LANCE updates from Kars de Jong:
> >   - Updated HP LANCE driver to use the new DIO semantics
> >   - If only HP LANCE or MVME147 LANCE is selected, enable compile-time
> >     choice of LANCE register access. If both are defined, go through the
> >     function pointer
> >   - Added support for CONFIG_NET_POLL_CONTROLLER
> >   - Fixed problem with disabling board interrupts in hplance_close() which
> >     caused the driver to lock up
> 
> There's tons of leaks in the hplcance probing code, and it doesn't release
> he memory region on removal either.
> 
> Untested patch to fix those issues below:

ping.

--- 1.12/drivers/net/hplance.c	2004-10-06 22:44:40 +02:00
+++ edited/drivers/net/hplance.c	2004-11-01 10:20:17 +01:00
@@ -71,30 +71,42 @@
 	.remove    = __devexit_p(hplance_remove_one),
 };
 
+/* XXX(hch): should probably move to a better place */
+#define dio_resource_start(d) \
+	((d)->resource.start)
+#define dio_resource_len(d) \
+	((d)->resource.end - (d)->resource.start)
+
 /* Find all the HP Lance boards and initialise them... */
 static int __devinit hplance_init_one(struct dio_dev *d,
 				const struct dio_device_id *ent)
 {
 	struct net_device *dev;
-	int err;
+	int err = -ENOMEM;
 
 	dev = alloc_etherdev(sizeof(struct hplance_private));
 	if (!dev)
-		return -ENOMEM;
+		goto out;
 
-	if (!request_mem_region(d->resource.start, d->resource.end-d->resource.start, d->name))
-		return -EBUSY;
+	err = -EBUSY;
+	if (!request_mem_region(dio_resource_start(d),
+				dio_resource_len(d), d->name))
+		goto out_free_netdev;
 
-	SET_MODULE_OWNER(dev);
-        
 	hplance_init(dev, d);
 	err = register_netdev(dev);
-	if (err) {
-		free_netdev(dev);
-		return err;
-	}
+	if (err)
+		goto out_free_netdev;
+
 	dio_set_drvdata(d, dev);
 	return 0;
+
+ out_release_mem_region:
+	release_mem_region(dio_resource_start(d), dio_resource_len(d));
+ out_free_netdev:
+	free_netdev(dev);
+ out:
+	return err;
 }
 
 static void __devexit hplance_remove_one(struct dio_dev *d)
@@ -102,6 +114,7 @@
 	struct net_device *dev = dio_get_drvdata(d);
 
 	unregister_netdev(dev);
+	release_mem_region(dio_resource_start(d), dio_resource_len(d));
 	free_netdev(dev);
 }
 
