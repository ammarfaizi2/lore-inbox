Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVAJVa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVAJVa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVAJVWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:22:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15013 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262579AbVAJVOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:14:19 -0500
Date: Mon, 10 Jan 2005 13:14:12 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [KJ] [announce] 2.6.10-bk13-kj
Message-ID: <20050110211412.GC9186@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> msleep_interruptible-drivers_block_pcd.patch

Please consider replacing with the following patch:

Description: Use msleep()/ssleep() instead of schedule_timeout() to guarantee
the task delays as expected. TASK_INTERRUPTIBLE is used in the original code,
however there is no check on the return values / for signals, thus I believe
TASK_UNINTERRUPTIBLE (and hence msleep()) is more appropriate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/block/paride/pcd.c	2004-12-24 13:35:39.000000000 -0800
+++ 2.6.10/drivers/block/paride/pcd.c	2005-01-10 12:20:29.000000000 -0800
@@ -534,12 +534,6 @@ static int pcd_tray_move(struct cdrom_de
 			 position ? "eject" : "close tray");
 }
 
-static void pcd_sleep(int cs)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(cs);
-}
-
 static int pcd_reset(struct pcd_unit *cd)
 {
 	int i, k, flg;
@@ -549,11 +543,11 @@ static int pcd_reset(struct pcd_unit *cd
 	write_reg(cd, 6, 0xa0 + 0x10 * cd->drive);
 	write_reg(cd, 7, 8);
 
-	pcd_sleep(20 * HZ / 1000);	/* delay a bit */
+	msleep(20);			/* delay a bit */
 
 	k = 0;
 	while ((k++ < PCD_RESET_TMO) && (status_reg(cd) & IDE_BUSY))
-		pcd_sleep(HZ / 10);
+		msleep(100);
 
 	flg = 1;
 	for (i = 0; i < 5; i++)
@@ -592,7 +586,7 @@ static int pcd_ready_wait(struct pcd_uni
 		if (!(((p & 0xffff) == 0x0402) || ((p & 0xff) == 6)))
 			return p;
 		k++;
-		pcd_sleep(HZ);
+		ssleep(1);
 	}
 	return 0x000020;	/* timeout */
 }
