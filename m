Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752002AbWJJDB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbWJJDB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbWJJDB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:01:27 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:32484 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1752002AbWJJDB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:01:27 -0400
Date: Tue, 10 Oct 2006 12:01:45 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       "Digi International, Inc" <Eng.Linux@digi.com>
Subject: Re: [PATCH] epca: privent from panic on tty_register_driver() failure
Message-ID: <20061010030144.GA5685@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, "Digi International, Inc" <Eng.Linux@digi.com>
References: <20061009090603.GA6278@localhost> <20061009084545.c64daf6c.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009084545.c64daf6c.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 08:45:45AM -0700, Randy Dunlap wrote:

> >  
> >  	pc_driver = alloc_tty_driver(MAX_ALLOC);
> >  	if (!pc_driver)
> > -		return -ENOMEM;
> > +		goto out1;
> >  
> >  	pc_info = alloc_tty_driver(MAX_ALLOC);
> > -	if (!pc_info) {
> > -		put_tty_driver(pc_driver);
> > -		return -ENOMEM;
> > -	}
> > +	if (!pc_info)
> > +		goto out2;
> 
> and then out2: uses pc_info, if it's NULL.  Is that OK?

I made mistake. I swapped the order of these two put_tty_driver() in
error handling wrongly.

This is fixed version.

Subject: epca: privent from panic on tty_register_driver() failure

This patch make epca fail on initialization failure instead of panic.

Cc: "Digi International, Inc" <Eng.Linux@digi.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/char/epca.c |   32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

Index: work-fault-inject/drivers/char/epca.c
===================================================================
--- work-fault-inject.orig/drivers/char/epca.c	2006-10-09 22:16:24.000000000 +0900
+++ work-fault-inject/drivers/char/epca.c	2006-10-10 00:47:50.000000000 +0900
@@ -1157,6 +1157,7 @@ static int __init pc_init(void)
 	int crd;
 	struct board_info *bd;
 	unsigned char board_id = 0;
+	int err = -ENOMEM;
 
 	int pci_boards_found, pci_count;
 
@@ -1164,13 +1165,11 @@ static int __init pc_init(void)
 
 	pc_driver = alloc_tty_driver(MAX_ALLOC);
 	if (!pc_driver)
-		return -ENOMEM;
+		goto out1;
 
 	pc_info = alloc_tty_driver(MAX_ALLOC);
-	if (!pc_info) {
-		put_tty_driver(pc_driver);
-		return -ENOMEM;
-	}
+	if (!pc_info)
+		goto out2;
 
 	/* -----------------------------------------------------------------------
 		If epca_setup has not been ran by LILO set num_cards to defaults; copy
@@ -1370,11 +1369,17 @@ static int __init pc_init(void)
 
 	} /* End for each card */
 
-	if (tty_register_driver(pc_driver))
-		panic("Couldn't register Digi PC/ driver");
+	err = tty_register_driver(pc_driver);
+	if (err) {
+		printk(KERN_ERR "Couldn't register Digi PC/ driver");
+		goto out3;
+	}
 
-	if (tty_register_driver(pc_info))
-		panic("Couldn't register Digi PC/ info ");
+	err = tty_register_driver(pc_info);
+	if (err) {
+		printk(KERN_ERR "Couldn't register Digi PC/ info ");
+		goto out4;
+	}
 
 	/* -------------------------------------------------------------------
 	   Start up the poller to check for events on all enabled boards
@@ -1385,6 +1390,15 @@ static int __init pc_init(void)
 	mod_timer(&epca_timer, jiffies + HZ/25);
 	return 0;
 
+out4:
+	tty_unregister_driver(pc_driver);
+out3:
+	put_tty_driver(pc_info);
+out2:
+	put_tty_driver(pc_driver);
+out1:
+	return err;
+
 } /* End pc_init */
 
 /* ------------------ Begin post_fep_init  ---------------------- */
