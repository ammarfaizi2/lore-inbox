Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVAKCqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVAKCqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbVAKCls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:41:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:39355 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262632AbVAJVUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:20:47 -0500
Date: Mon, 10 Jan 2005 13:20:38 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] block/pg: replace pg_sleep() with msleep()
Message-ID: <20050110212038.GG9186@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, slightly inaccurate description...

On Mon, Jan 10, 2005 at 05:47:03PM +0100, Domen Puncer wrote:
> Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/
> 
> Quick patch summary: about 30 new, 30 merged, 30 dropped.
> Seems like most external trees are merged in -linus, so i'll start
> (re)sending old patches.

<snip>

> msleep_interruptible-drivers_block_pg.patch

Please consider replacing with the following patch:

Description: Use msleep()/ssleep() instead of pg_sleep() to guarantee
the task delays as expected. TASK_INTERRUPTIBLE is used in the original code,
however there is no check on the return values / for signals, thus I believe
TASK_UNINTERRUPTIBLE (and hence msleep()) is more appropriate. Change pg_sleep()
to use TASK_UNINTERRUPTIBLE as well.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/block/paride/pg.c	2004-12-24 13:35:25.000000000 -0800
+++ 2.6.10/drivers/block/paride/pg.c	2005-01-10 12:21:34.000000000 -0800
@@ -295,7 +295,7 @@ static inline u8 DRIVE(struct pg *dev)
 
 static void pg_sleep(int cs)
 {
-	current->state = TASK_INTERRUPTIBLE;
+	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(cs);
 }
 
@@ -409,7 +409,7 @@ static int pg_reset(struct pg *dev)
 	write_reg(dev, 6, DRIVE(dev));
 	write_reg(dev, 7, 8);
 
-	pg_sleep(20 * HZ / 1000);
+	msleep(20);
 
 	k = 0;
 	while ((k++ < PG_RESET_TMO) && (status_reg(dev) & STAT_BUSY))
