Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVAKAxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVAKAxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVAJVcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:32:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64759 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262617AbVAJVSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:18:52 -0500
Date: Mon, 10 Jan 2005 13:18:49 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] block/pt: replace pt_sleep() with msleep()/ssleep()
Message-ID: <20050110211849.GF9186@us.ibm.com>
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

> msleep_interruptible-drivers_block_pt.patch

Please consider replacing with the following patch:

Description: Use msleep()/ssleep() instead of pt_sleep() to guarantee
the task delays as expected. TASK_INTERRUPTIBLE is used in the original code,
however there is no check on the return values / for signals, thus I believe
TASK_UNINTERRUPTIBLE (and hence msleep()) is more appropriate. Remove definition
of pt_sleep(). Change the units of the pause variable in pt_poll_dsc() to msecs,
thus allowing the use of msleep(). Appropriately modify the three callers of
pt_poll_dsc().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-v/drivers/block/paride/pt.c	2004-12-24 13:34:27.000000000 -0800
+++ 2.6.10/drivers/block/paride/pt.c	2005-01-10 12:23:43.000000000 -0800
@@ -401,12 +401,6 @@ static int pt_atapi(struct pt_unit *tape
 	return r;
 }
 
-static void pt_sleep(int cs)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(cs);
-}
-
 static int pt_poll_dsc(struct pt_unit *tape, int pause, int tmo, char *msg)
 {
 	struct pi_adapter *pi = tape->pi;
@@ -416,7 +410,7 @@ static int pt_poll_dsc(struct pt_unit *t
 	e = 0;
 	s = 0;
 	while (k < tmo) {
-		pt_sleep(pause);
+		msleep(pause);
 		k++;
 		pi_connect(pi);
 		write_reg(pi, 6, DRIVE(tape));
@@ -445,7 +439,7 @@ static void pt_media_access_cmd(struct p
 		return;
 	}
 	pi_disconnect(tape->pi);
-	pt_poll_dsc(tape, HZ, tmo, fun);
+	pt_poll_dsc(tape, 1000, tmo, fun);
 }
 
 static void pt_rewind(struct pt_unit *tape)
@@ -474,11 +468,11 @@ static int pt_reset(struct pt_unit *tape
 	write_reg(pi, 6, DRIVE(tape));
 	write_reg(pi, 7, 8);
 
-	pt_sleep(20 * HZ / 1000);
+	msleep(20);
 
 	k = 0;
 	while ((k++ < PT_RESET_TMO) && (status_reg(pi) & STAT_BUSY))
-		pt_sleep(HZ / 10);
+		msleep(100);
 
 	flg = 1;
 	for (i = 0; i < 5; i++)
@@ -512,7 +506,7 @@ static int pt_ready_wait(struct pt_unit 
 		if (!(((p & 0xffff) == 0x0402) || ((p & 0xff) == 6)))
 			return p;
 		k++;
-		pt_sleep(HZ);
+		ssleep(1);
 	}
 	return 0x000020;	/* timeout */
 }
@@ -785,7 +779,7 @@ static ssize_t pt_read(struct file *filp
 
 	while (count > 0) {
 
-		if (!pt_poll_dsc(tape, HZ / 100, PT_TMO, "read"))
+		if (!pt_poll_dsc(tape, 10, PT_TMO, "read"))
 			return -EIO;
 
 		n = count;
@@ -886,7 +880,7 @@ static ssize_t pt_write(struct file *fil
 
 	while (count > 0) {
 
-		if (!pt_poll_dsc(tape, HZ / 100, PT_TMO, "write"))
+		if (!pt_poll_dsc(tape, 10, PT_TMO, "write"))
 			return -EIO;
 
 		n = count;
