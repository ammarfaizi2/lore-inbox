Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbTEWJb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTEWJbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:31:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5860 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263979AbTEWJby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:31:54 -0400
Date: Fri, 23 May 2003 02:43:08 -0700 (PDT)
Message-Id: <20030523.024308.94566989.davem@redhat.com>
To: lists@mdiehl.de
Cc: akpm@digeo.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       jt@hpl.hp.com, shemminger@osdl.org
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305230934490.14825-100000@notebook.home.mdiehl.de>
References: <20030522.235905.42785280.davem@redhat.com>
	<Pine.LNX.4.44.0305230934490.14825-100000@notebook.home.mdiehl.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Martin Diehl <lists@mdiehl.de>
   Date: Fri, 23 May 2003 11:38:38 +0200 (CEST)

   On Thu, 22 May 2003, David S. Miller wrote:
   
   >    Asking just because there was another user hitting this deadlock:
   > 
   > It's fixed in current 2.5.x sources, wake up :-)
   
   Oops, sorry for the noise, I hadn't noticed this yet.
   
   But nope, unfortunately it's still hanging! I've just tested with 
   2.5.69-bk15. Running into the same deadlock due to sleeping with rtnl 
   hold. This time however it seems it's triggered from sysfs side!

Stephen, you need to do the device class stuff outside of the RTNL
lock please.

At least I didn't add this bug :-)

This should fix it.

--- net/core/dev.c.~1~	Fri May 23 02:42:37 2003
+++ net/core/dev.c	Fri May 23 02:43:20 2003
@@ -2754,6 +2754,8 @@
 
 		dev->next = NULL;
 
+		netdev_unregister_sysfs(dev);
+
 		netdev_wait_allrefs(dev);
 
 		BUG_ON(atomic_read(&dev->refcnt));
@@ -2841,8 +2843,6 @@
 	BUG_TRAP(!dev->master);
 
 	free_divert_blk(dev);
-
-	netdev_unregister_sysfs(dev);
 
 	spin_lock(&unregister_todo_lock);
 	dev->next = unregister_todo;
