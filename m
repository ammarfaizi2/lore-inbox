Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbTIQSZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 14:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTIQSZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 14:25:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:19397 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262607AbTIQSY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 14:24:59 -0400
Date: Wed, 17 Sep 2003 11:24:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: netpoll/netconsole minor tweaks
Message-ID: <20030917112447.A24623@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Here's a couple small tweaks.  The first is to netpoll_setup.  The settle
time was too short for my e100, and the system would hang.  The second
is to netconsole so that it registers a console with CON_PRINTBUFFER.
This helps debugging early bootup issues where you want to capture data
from before netconsole is initialized.  Perhaps it should be a param
to netconsole?

thanks,
-chris

--- 2.6.0-test5-mm2/net/core/netpoll.c.wait_fix	2003-09-15 15:46:28.000000000 -0700
+++ 2.6.0-test5-mm2/net/core/netpoll.c	2003-09-15 16:14:20.000000000 -0700
@@ -526,7 +526,7 @@ int netpoll_setup(struct netpoll *np)
 		rtnl_shunlock();
 
 		/* Give driver a chance to settle */
-		jiff = jiffies + 2*HZ;
+		jiff = jiffies + 4*HZ;
 		while (time_before(jiffies, jiff))
 			;
 	}

--- 2.6.0-test5-mm2/drivers/net/netconsole.c.print_buf	2003-09-15 16:21:31.000000000 -0700
+++ 2.6.0-test5-mm2/drivers/net/netconsole.c	2003-09-17 11:09:59.000000000 -0700
@@ -95,7 +95,7 @@
 }
 
 static struct console netconsole = {
-	.flags = CON_ENABLED,
+	.flags = CON_ENABLED | CON_PRINTBUFFER,
 	.write = write_msg
 };
