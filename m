Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSGLWPP>; Fri, 12 Jul 2002 18:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSGLWPO>; Fri, 12 Jul 2002 18:15:14 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:35592 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318031AbSGLWPL>;
	Fri, 12 Jul 2002 18:15:11 -0400
Date: Fri, 12 Jul 2002 15:17:44 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020712221744.GG11007@kroah.com>
References: <20020711230222.GA5143@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020711230222.GA5143@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 14 Jun 2002 18:30:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones found a bug in this patch that causes the driver to try to
bind to multiple busses :(

This patch seems to fix this problem.

thanks,

greg k-h


diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Fri Jul 12 14:57:41 2002
+++ b/drivers/char/agp/agpgart_be.c	Fri Jul 12 14:57:41 2002
@@ -47,7 +47,7 @@
 EXPORT_SYMBOL(agp_backend_acquire);
 EXPORT_SYMBOL(agp_backend_release);
 
-struct agp_bridge_data agp_bridge;
+struct agp_bridge_data agp_bridge = { type: NOT_SUPPORTED };
 static int agp_try_unsupported __initdata = 0;
 
 int agp_backend_acquire(void)
@@ -1593,6 +1593,11 @@
 static int agp_probe (struct pci_dev *dev, const struct pci_device_id *ent)
 {
 	int ret_val;
+
+	if (agp_bridge.type != NOT_SUPPORTED) {
+		printk (KERN_DEBUG "Oops, don't init a 2nd agpgard device.\n");
+		return -ENODEV;
+	}
 
 	ret_val = agp_backend_initialize(dev);
 	if (ret_val) {
