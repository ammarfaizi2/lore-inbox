Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTDUToh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbTDUToh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 15:44:37 -0400
Received: from verein.lst.de ([212.34.181.86]:51472 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261570AbTDUTog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 15:44:36 -0400
Date: Mon, 21 Apr 2003 21:56:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
Message-ID: <20030421215637.A30019@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com> <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de> <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com> <20030421210020.A29421@lst.de> <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>; from proski@gnu.org on Mon, Apr 21, 2003 at 03:44:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 03:44:07PM -0400, Pavel Roskin wrote:
> Following is happening.  The system boots, /dev/pts is a directory (I can
> see it by logging on the serial console).  devpts is mounted on /dev/pts.
> 
> I log in by ssh.  It works.  /dev/pts/0 appears.  I log out.  /dev/pts
> directory disappears!
> 
> I log in by ssh again.  I get this message on the console:
> 
> devfs_remove: no entry for pts!
> 
> ssh hangs.  I can recreate /dev/pts by mkdir, umount it and mount it
> again.  Then ssh works again, but again only once.  /dev/pts disappears on
> logout.

Oh, I see now.  There's a longstanding bug in the handling of
TTY_DRIVER_NO_DEVFS that got exposed by this.

Please try this patch additionally:


--- 1.78/drivers/char/tty_io.c	Sat Apr 19 19:24:04 2003
+++ edited/drivers/char/tty_io.c	Mon Apr 21 20:33:35 2003
@@ -2139,12 +2139,14 @@
  */
 void tty_register_device(struct tty_driver *driver, unsigned minor)
 {
-	tty_register_devfs(driver, minor);
+	if (!(driver->flags & TTY_DRIVER_NO_DEVFS))
+		tty_register_devfs(driver, minor);
 }
 
 void tty_unregister_device(struct tty_driver *driver, unsigned minor)
 {
-	tty_unregister_devfs(driver, minor);
+	if (!(driver->flags & TTY_DRIVER_NO_DEVFS))
+		tty_unregister_devfs(driver, minor);
 }
 
 EXPORT_SYMBOL(tty_register_device);
@@ -2173,10 +2175,8 @@
 	
 	list_add(&driver->tty_drivers, &tty_drivers);
 	
-	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
-		for(i = 0; i < driver->num; i++)
-		    tty_register_device(driver, driver->minor_start + i);
-	}
+	for (i = 0; i < driver->num; i++)
+		tty_register_device(driver, driver->minor_start + i);
 	proc_tty_register_driver(driver);
 	return error;
 }
