Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVAJUPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVAJUPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVAJUME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:12:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20705 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262469AbVAJUID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:08:03 -0500
Date: Mon, 10 Jan 2005 12:08:00 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] drivers/dmapool: use TASK_UNINTERRUPTIBLE instead of TASK_INTERRUPTIBLE
Message-ID: <20050110200800.GA9186@us.ibm.com>
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

> msleep_interruptible-drivers_base_dmapool.patch

Please replace with the following patch. msleep_interruptible() is not
appropriate for this delay, as the waitqueue events will be missed.
TASK_UNINTERRUPTIBLE should be used instead of TASK_INTERRUPTIBLE, though, as
signals are not checked for.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/base/dmapool.c	2004-12-24 13:35:28.000000000 -0800
+++ 2.6.10/drivers/base/dmapool.c	2005-01-10 12:05:08.000000000 -0800
@@ -293,7 +293,7 @@ restart:
 		if (mem_flags & __GFP_WAIT) {
 			DECLARE_WAITQUEUE (wait, current);
 
-			current->state = TASK_INTERRUPTIBLE;
+			set_current_state(TASK_UNINTERRUPTIBLE);
 			add_wait_queue (&pool->waitq, &wait);
 			spin_unlock_irqrestore (&pool->lock, flags);
 
