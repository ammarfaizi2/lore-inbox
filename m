Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUCBLZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUCBLZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:25:13 -0500
Received: from gprs40-147.eurotel.cz ([160.218.40.147]:1692 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261601AbUCBLZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:25:09 -0500
Date: Tue, 2 Mar 2004 12:25:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: kgdb: fix kgdbeth compilation and make it init late enough
Message-ID: <20040302112500.GA485@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

CONFIG_NO_KGDB_CPUS can not be found anywhere in the patches => its
probably not needd any more. init_kgdboe can't be module_initcall; in
such cases it initializes after tg3 network card (and that's bad).

Okay to commit?
								Pavel

--- clean-mm/drivers/net/kgdb_eth.c	2004-03-01 22:03:55.000000000 +0100
+++ linux-mm/drivers/net/kgdb_eth.c	2004-03-01 23:00:07.000000000 +0100
@@ -157,15 +157,6 @@
 
 static int init_kgdboe(void)
 {
-#ifdef CONFIG_SMP
-	if (num_online_cpus() > CONFIG_NO_KGDB_CPUS) {
-		printk
-		    ("kgdb: too manu cpus. Cannot enable debugger with more than %d cpus\n",
-		     CONFIG_NO_KGDB_CPUS);
-		return -1;
-	}
-#endif
-
 	if (!np.remote_ip || netpoll_setup(&np))
 		return 1;
 
@@ -176,4 +167,4 @@
 	return 0;
 }
 
-module_init(init_kgdboe);
+late_initcall(init_kgdboe);		/* This needs to be done after netcard is initialized */ 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
