Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbTGDGhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 02:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbTGDGhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 02:37:55 -0400
Received: from pop.gmx.net ([213.165.64.20]:51623 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265784AbTGDGhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 02:37:54 -0400
Date: Fri, 4 Jul 2003 09:52:17 +0300
From: Dan Aloni <da-x@gmx.net>
To: Greg KH <greg@kroah.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI and sysfs fixes for 2.5.73
Message-ID: <20030704065217.GA22032@callisto.yi.org>
References: <20030704020634.GA4316@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704020634.GA4316@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 07:06:34PM -0700, Greg KH wrote:
> Hi,
> 
> Here's some PCI and sysfs fixes that are against the latest 2.5.74 bk
> tree.  They include Matthew Wilcox's set of pci cleanups, and sysfs
> fixes for binary files.  That led into my sysfs attribute file change,
> which required John Stultz's timer build fix.  I've also added the
> sysfs/kobject/class rename patches based on previously posted patches.

That's good, but I see that you didn't add the call to class_device_rename()
in net/core/dev.c, and that's kinda misses the point ;)

--- linux/net/core/dev.c	2003-06-29 22:16:29.000000000 +0300
+++ linux/net/core/dev.c	2003-06-30 20:57:55.000000000 +0300
@@ -2346,10 +2346,14 @@
 				return -EEXIST;
 			memcpy(dev->name, ifr->ifr_newname, IFNAMSIZ);
 			dev->name[IFNAMSIZ - 1] = 0;
-			strlcpy(dev->class_dev.class_id, dev->name, BUS_ID_SIZE);
+
+			err = class_device_rename(&dev->class_dev, dev->name);
+			if (err) 
+				printk(KERN_DEBUG "SIOCSIFNAME: error renaming class_device (%d)\n", err);
+
 			notifier_call_chain(&netdev_chain,
 					    NETDEV_CHANGENAME, dev);
-			return 0;
+			return err;
 
 		/*
 		 *	Unknown or private ioctl

-- 
Dan Aloni
da-x@gmx.net
