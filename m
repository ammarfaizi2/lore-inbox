Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVAJUQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVAJUQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVAJUPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:15:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26860 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262455AbVAJUNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:13:13 -0500
Date: Mon, 10 Jan 2005 12:13:07 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [KJ] [announce] 2.6.10-bk13-kj
Message-ID: <20050110201307.GB9186@us.ibm.com>
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

> msleep_interruptible-drivers_block_cciss.patch

Please consider replacing with the following patch:

Description: Use msleep() instead of schedule_timeout() to guarantee the task
delays as expected. TASK_INTERRUPTIBLE is used currently, however signals /
early returns from schedule_timeout() are not checked for. Thus msleep() is more
appropriate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/block/cciss.c	2004-12-24 13:35:39.000000000 -0800
+++ 2.6.10/drivers/block/cciss.c	2005-01-10 12:10:50.000000000 -0800
@@ -2430,8 +2430,7 @@ static int cciss_pci_init(ctlr_info_t *c
 		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
 		if (scratchpad == CCISS_FIRMWARE_READY)
 			break;
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ / 10); /* wait 100ms */
+		msleep(100);			/* wait 100ms */
 	}
 	if (scratchpad != CCISS_FIRMWARE_READY) {
 		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
