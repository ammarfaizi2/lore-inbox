Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbTLKXvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbTLKXvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:51:37 -0500
Received: from palrel13.hp.com ([156.153.255.238]:18570 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264420AbTLKXvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:51:35 -0500
Date: Thu, 11 Dec 2003 15:51:31 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] IrDA kernel log buster
Message-ID: <20031211235131.GA1677@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Marcelo,

	I just ran 2.4.23, and after a few min the disk reached 100%
capacity. A quick check lead to to oversized kernel log, and to the
following changeset :

http://linux.bkbits.net:8080/linux-2.4/cset@1.1136.23.2?nav=index.html|ChangeSet@-12w

	Patch to fix this problem is attached below, I've just
backported the proper fixes from 2.5.X into 2.4.X.
	Probably this person did too much Python, but in C you need
braces around multiple statements part of the same branch, so the
second printf was always executed even when logging was disabled. I
also don't understand why this person didn't decided to backport the
2.5.X fix.
	I'm also bit surprised that this kind of patch went into the
kernel behind my back, because I though that freeze meant not
accepting untested patch from random hacker.

	Have fun...

	Jean

-------------------------------------------------

diff -u -p linux/net/irda/irnet/irnet.j1.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.j1.h	Thu Dec 11 15:31:32 2003
+++ linux/net/irda/irnet/irnet.h	Thu Dec 11 15:34:08 2003
@@ -322,29 +322,29 @@
  * compiler will optimise away the if() in all cases.
  */
 /* All error messages (will show up in the normal logs) */
-#define DERROR(dbg, args...) \
+#define DERROR(dbg, format, args...) \
 	{if(DEBUG_##dbg) \
-		printk(KERN_INFO "irnet: %s(): ", __FUNCTION__); printk(args);}
+		printk(KERN_INFO "irnet: %s(): " format, __FUNCTION__ , ##args);}
 
 /* Normal debug message (will show up in /var/log/debug) */
-#define DEBUG(dbg, args...) \
+#define DEBUG(dbg, format, args...) \
 	{if(DEBUG_##dbg) \
-		printk(KERN_DEBUG "irnet: %s(): ", __FUNCTION__); printk(args);}
+		printk(KERN_DEBUG "irnet: %s(): " format, __FUNCTION__ , ##args);}
 
 /* Entering a function (trace) */
-#define DENTER(dbg, args...) \
+#define DENTER(dbg, format, args...) \
 	{if(DEBUG_##dbg) \
-	printk(KERN_DEBUG "irnet: ->%s", __FUNCTION__); printk(args);}
+		printk(KERN_DEBUG "irnet: -> %s" format, __FUNCTION__ , ##args);}
 
 /* Entering and exiting a function in one go (trace) */
-#define DPASS(dbg, args...) \
+#define DPASS(dbg, format, args...) \
 	{if(DEBUG_##dbg) \
-		printk(KERN_DEBUG "irnet: <>%s", __FUNCTION__); printk(args);}
+		printk(KERN_DEBUG "irnet: <>%s" format, __FUNCTION__ , ##args);}
 
 /* Exiting a function (trace) */
-#define DEXIT(dbg, args...) \
+#define DEXIT(dbg, format, args...) \
 	{if(DEBUG_##dbg) \
-		printk(KERN_DEBUG "irnet: <-%s()", __FUNCTION__); printk(args);}
+		printk(KERN_DEBUG "irnet: <-%s()" format, __FUNCTION__ , ##args);}
 
 /* Exit a function with debug */
 #define DRETURN(ret, dbg, args...) \
