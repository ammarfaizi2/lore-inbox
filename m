Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTGRPnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271868AbTGRPlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:41:53 -0400
Received: from mailc.telia.com ([194.22.190.4]:46077 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S271860AbTGRPkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:40:15 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz>
	<20030717130906.0717b30d.akpm@osdl.org> <m2d6g8cg06.fsf@telia.com>
	<20030718032433.4b6b9281.akpm@osdl.org>
	<20030718152205.GA407@elf.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 18 Jul 2003 17:55:01 +0200
In-Reply-To: <20030718152205.GA407@elf.ucw.cz>
Message-ID: <m2el0nvnhm.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> > However I'm trying to remember why the code exists at all.  Why doesn't
> > swsusp just allocate lots of pages then free them again?
> 
> Because that either
> 
> a) does not free enough pages or
> 
> b) triggers OOM killer.
> 
> It was actually your idea, IIRC ;-).
> 
> Ahha, you seem to be addressing that in your code. Peter, perhaps you
> want to test that one?

I tried the patch below, but it didn't work. Nothing (or very little)
was swapped out to disk. I also tried using GFP_KERNEL, but that
seemed to cause a deadlock. (Maybe it would have gone OOM if I had
waited long enough). I think the problem is that pdflush and friends
are already frozen when this code runs.

--- linux/kernel/suspend.c.old	Fri Jul 18 15:46:48 2003
+++ linux/kernel/suspend.c	Fri Jul 18 15:45:51 2003
@@ -621,10 +621,32 @@
  */
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
+	LIST_HEAD(list);
+	struct page *page, *tmp;
+	int sleep_count = 0;
+	int i = 0;
+
+	while (sleep_count < 10) {
+		page = alloc_page(GFP_ATOMIC);
+		if (page) {
+			list_add(&page->list, &list);
+			sleep_count = 0;
+		} else {
+			blk_congestion_wait(WRITE, HZ/20);
+			sleep_count++;
+		}
+		i++;
+		if (!(i%1000))
+			printk(".");
+	}
 	printk("|\n");
+
+	i = 0;
+	list_for_each_entry_safe(page, tmp, &list, list) {
+		__free_page(page);
+		i++;
+	}
+	printk("%d pages freed\n", i);
 }
 
 /* Make disk drivers accept operations, again */

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
