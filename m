Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVAJVZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVAJVZQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 16:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVAJVXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:23:19 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:41656 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262541AbVAJVPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:15:48 -0500
Date: Mon, 10 Jan 2005 13:15:42 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] block/pf: replace pf_sleep() with msleep()
Message-ID: <20050110211542.GD9186@us.ibm.com>
References: <20050110164703.GD14307@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110164703.GD14307@nd47.coderock.org>
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

> msleep_interruptible-drivers_block_pf.patch

Please consider replacing with the following patch:

Description: Use msleep() instead of pf_sleep() to guarantee
the task delays as expected. TASK_INTERRUPTIBLE is used in the original code,
however there is no check on the return values / for signals, thus I believe
TASK_UNINTERRUPTIBLE (and hence msleep()) is more appropriate. Remove the
definition of pf_sleep().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/block/paride/pf.c	2004-12-24 13:35:01.000000000 -0800
+++ 2.6.10/drivers/block/paride/pf.c	2005-01-10 12:20:20.000000000 -0800
@@ -526,12 +526,6 @@ static void pf_eject(struct pf_unit *pf)
 
 #define PF_RESET_TMO   30	/* in tenths of a second */
 
-static void pf_sleep(int cs)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(cs);
-}
-
 /* the ATAPI standard actually specifies the contents of all 7 registers
    after a reset, but the specification is ambiguous concerning the last
    two bytes, and different drives interpret the standard differently.
@@ -546,11 +540,11 @@ static int pf_reset(struct pf_unit *pf)
 	write_reg(pf, 6, 0xa0+0x10*pf->drive);
 	write_reg(pf, 7, 8);
 
-	pf_sleep(20 * HZ / 1000);
+	msleep(20);
 
 	k = 0;
 	while ((k++ < PF_RESET_TMO) && (status_reg(pf) & STAT_BUSY))
-		pf_sleep(HZ / 10);
+		msleep(100);
 
 	flg = 1;
 	for (i = 0; i < 5; i++)
