Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVDBLv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVDBLv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 06:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVDBLv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 06:51:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:20956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261379AbVDBLvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 06:51:54 -0500
Date: Sat, 2 Apr 2005 03:51:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@engr.sgi.com>
Cc: blosure@sgi.com, mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: new SGI TIOCX driver in *-mm driver model locking broken
Message-Id: <20050402035131.53c9e4c5.akpm@osdl.org>
In-Reply-To: <20050402034313.4aa994f5.pj@engr.sgi.com>
References: <20050402034313.4aa994f5.pj@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@engr.sgi.com> wrote:
>
> If I try to compile 2.6.12-rc1-mm4 for SN2 with the config option
> 
>    CONFIG_SGI_TIOCX=y
> 
>  the build fails with a bunch of errors on line 527 of tiocx.c, starting
>  with:

Pat did a patch, but nobody's tested it yet.

diff -puN arch/ia64/sn/kernel/tiocx.c~bk-driver-core-sn2-build-fix arch/ia64/sn/kernel/tiocx.c
--- 25/arch/ia64/sn/kernel/tiocx.c~bk-driver-core-sn2-build-fix	2005-04-01 21:41:07.000000000 -0800
+++ 25-akpm/arch/ia64/sn/kernel/tiocx.c	2005-04-01 21:41:07.000000000 -0800
@@ -514,25 +514,22 @@ static int __init tiocx_init(void)
 	return 0;
 }
 
-static void __exit tiocx_exit(void)
+static int cx_remove_device(struct device * dev, void * data)
 {
-	struct device *dev;
-	struct device *tdev;
+	struct cx_dev *cx_dev = to_cx_dev(dev);
+	device_remove_file(dev, &dev_attr_cxdev_control);
+	cx_device_unregister(cx_dev);
+	return 0;
+}
 
+static void __exit tiocx_exit(void)
+{
 	DBG("tiocx_exit\n");
 
 	/*
 	 * Unregister devices.
 	 */
-	list_for_each_entry_safe(dev, tdev, &tiocx_bus_type.devices.list,
-				 bus_list) {
-		if (dev) {
-			struct cx_dev *cx_dev = to_cx_dev(dev);
-			device_remove_file(dev, &dev_attr_cxdev_control);
-			cx_device_unregister(cx_dev);
-		}
-	}
-
+	bus_for_each_dev(&tiocx_bus_type, NULL, NULL, cx_remove_device);
 	bus_unregister(&tiocx_bus_type);
 }
 
_

