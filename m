Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266078AbUGAQts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266078AbUGAQts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266079AbUGAQts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:49:48 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:19820 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266078AbUGAQtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:49:45 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH/2.4.26] Avoid kernel data corruption through /dev/kmem
Date: Thu, 1 Jul 2004 16:05:29 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_poB5AYL3pY4S0Nw"
Message-Id: <200407011605.29386.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_poB5AYL3pY4S0Nw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm sending this fix for /dev/kmem; I already sent a cleanup about this, but 
since you said "cleanups go in 2.6", then I'm sending only the bugfix.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_poB5AYL3pY4S0Nw
Content-Type: text/x-diff;
  charset="us-ascii";
  name="fix-mem-return.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix-mem-return.patch"


We need to check if do_write_mem == -EFAULT.
In fact, without that check, we could execute this:

do_write_mem returns -EFAULT;
wrote = -EFAULT;

buf += wrote; //i.e. buf -= EFAULT (14);

... read other data from buf, and write it to kernel memory
(actually on special circumstances, i.e. p < high_memory && 
 p + count > high_memory).

Luckily not at all exploitable (not even in the OpenBSD idea) since
to write on /dev/kmem you must already be root.

---

 linux-2.4.26-paolo/drivers/char/mem.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff -puN drivers/char/mem.c~fix-mem-return drivers/char/mem.c
--- linux-2.4.26/drivers/char/mem.c~fix-mem-return	2004-07-01 15:14:00.275806312 +0200
+++ linux-2.4.26-paolo/drivers/char/mem.c	2004-07-01 15:28:24.604408392 +0200
@@ -287,11 +287,13 @@ static ssize_t write_kmem(struct file * 
 	char * kbuf; /* k-addr because vwrite() takes vmlist_lock rwlock */
 
 	if (p < (unsigned long) high_memory) {
-		wrote = count;
+		ssize_t towrite = count;
 		if (count > (unsigned long) high_memory - p)
-			wrote = (unsigned long) high_memory - p;
+			towrite = (unsigned long) high_memory - p;
 
-		wrote = do_write_mem(file, (void*)p, p, buf, wrote, ppos);
+		wrote = do_write_mem(file, (void*)p, p, buf, towrite, ppos);
+		if (wrote != towrite)
+			return wrote;
 
 		p += wrote;
 		buf += wrote;
_

--Boundary-00=_poB5AYL3pY4S0Nw--

