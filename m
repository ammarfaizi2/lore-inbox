Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261468AbTCXHl2>; Mon, 24 Mar 2003 02:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261469AbTCXHl2>; Mon, 24 Mar 2003 02:41:28 -0500
Received: from [212.50.18.217] ([212.50.18.217]:1028 "EHLO
	zzlzl.varnainter.net") by vger.kernel.org with ESMTP
	id <S261468AbTCXHl1>; Mon, 24 Mar 2003 02:41:27 -0500
Date: Mon, 24 Mar 2003 11:55:08 +0200 (EET)
From: Alexander Atanasov <alex@ssi.bg>
To: Dominik Brodowski <linux@brodo.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless
 looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
In-Reply-To: <20030323182554.GA1270@brodo.de>
Message-ID: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

On Sun, 23 Mar 2003, Dominik Brodowski wrote:

> Yes, it also works with 2.5.65-bkX.

	Dominik, can you try this patch on top of 2.5.65-ac3/bk,
i can't reproduce the hang but it seems that drives without driver can get
both in ata_unused and idedefault_driver.drives and lists go nuts.
It kills ata_unused and uses idedefault_driver.drives only,
boots fine here. I'd guess you have ide-cd as module, and the two drives
handled by it couse the trouble - first joins the lists second couses the
loop.

-- 
have fun,
alex

===== drivers/ide/ide.c 1.52 vs edited =====
--- 1.52/drivers/ide/ide.c	Sun Mar 23 02:00:50 2003
+++ edited/drivers/ide/ide.c	Mon Mar 24 08:48:54 2003
@@ -469,7 +469,6 @@
 	return -ENXIO;
 }
 
-static LIST_HEAD(ata_unused);
 static spinlock_t drives_lock = SPIN_LOCK_UNLOCKED;
 static spinlock_t drivers_lock = SPIN_LOCK_UNLOCKED;
 static LIST_HEAD(drivers);
@@ -1440,9 +1439,6 @@
 	spin_unlock(&drivers_lock);
 	if(idedefault_driver.attach(drive) != 0)
 		panic("ide: default attach failed");
-	spin_lock(&drives_lock);
-	list_add_tail(&drive->list, &ata_unused);
-	spin_unlock(&drives_lock);
 	return 1;
 }
 
@@ -2399,7 +2395,7 @@
 
 	spin_lock(&drives_lock);
 	INIT_LIST_HEAD(&list);
-	list_splice_init(&ata_unused, &list);
+	list_splice_init(&idedefault_driver.drives, &list);
 	spin_unlock(&drives_lock);
 
 	while (!list_empty(&list)) {

