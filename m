Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbTEORWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbTEORWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:22:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:52654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264130AbTEORWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:22:39 -0400
Date: Thu, 15 May 2003 10:35:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <1053000155.605.1.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.44.0305151034560.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, I've changed "#undef DEBUG" to "#define DEBUG" in
> drivers/base/power.c, but during shutdown, I can see no extra debug
> messages. What am I doing wrong?

Nothing. No one has shutdown methods in their drivers. This patch should 
give you a little more info. For me, it says the i8259 is getting shutdown 
very early in the process, which surely can't be good..


	-pat

===== drivers/base/power.c 1.18 vs edited =====
--- 1.18/drivers/base/power.c	Mon Jan  6 09:56:05 2003
+++ edited/drivers/base/power.c	Thu May 15 10:30:25 2003
@@ -8,7 +8,7 @@
  *
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/device.h>
 #include <linux/module.h>
@@ -88,10 +88,12 @@
 	down_write(&devices_subsys.rwsem);
 	list_for_each(entry,&devices_subsys.kset.list) {
 		struct device * dev = to_dev(entry);
+		pr_debug("shutting down %s: ",dev->name);
 		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("shutting down %s\n",dev->name);
+			pr_debug("Ok\n");
 			dev->driver->shutdown(dev);
-		}
+		} else
+			pr_debug("Ignored.\n");
 	}
 	up_write(&devices_subsys.rwsem);
 }

