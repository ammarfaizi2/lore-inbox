Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTDUUpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTDUUpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:45:08 -0400
Received: from verein.lst.de ([212.34.181.86]:1809 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262174AbTDUUpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:45:02 -0400
Date: Mon, 21 Apr 2003 22:57:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
Message-ID: <20030421225704.A30489@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com> <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de> <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com> <20030421210020.A29421@lst.de> <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com> <20030421215637.A30019@lst.de> <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>; from proski@gnu.org on Mon, Apr 21, 2003 at 04:35:21PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 04:35:21PM -0400, Pavel Roskin wrote:
> > Oh, I see now.  There's a longstanding bug in the handling of
> > TTY_DRIVER_NO_DEVFS that got exposed by this.
> >
> > Please try this patch additionally:
> 
> Applied.  Now I can log in by ssh and there are no problems with
> pseudoterminals.  However, all local terminals are gone:

The devfs <-> tty interaction are going to drive me nuts.

TTY_DRIVER_NO_DEVFS actually means don't call tty_register_device
in tty_register_driver, not don't register with devfs.

Updated patch (replaces the last one):


--- 1.78/drivers/char/tty_io.c	Sat Apr 19 19:24:04 2003
+++ edited/drivers/char/tty_io.c	Mon Apr 21 21:28:01 2003
@@ -2173,9 +2173,9 @@
 	
 	list_add(&driver->tty_drivers, &tty_drivers);
 	
-	if ( !(driver->flags & TTY_DRIVER_NO_DEVFS) ) {
-		for(i = 0; i < driver->num; i++)
-		    tty_register_device(driver, driver->minor_start + i);
+	if (!(driver->flags & TTY_DRIVER_NO_DEVFS)) {
+		for (i = 0; i < driver->num; i++)
+			tty_register_device(driver, driver->minor_start + i);
 	}
 	proc_tty_register_driver(driver);
 	return error;
@@ -2215,7 +2215,8 @@
 			driver->termios_locked[i] = NULL;
 			kfree(tp);
 		}
-		tty_unregister_device(driver, driver->minor_start + i);
+		if (!(driver->flags & TTY_DRIVER_NO_DEVFS))
+			tty_unregister_device(driver, driver->minor_start + i);
 	}
 	proc_tty_unregister_driver(driver);
 	return 0;
