Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTFHCOu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 22:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTFHCOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 22:14:49 -0400
Received: from [211.167.76.68] ([211.167.76.68]:45530 "HELO soulinfo")
	by vger.kernel.org with SMTP id S264374AbTFHCOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 22:14:44 -0400
Date: Sun, 8 Jun 2003 10:27:08 +0800
From: hugang <hugang@soulinfo.com>
To: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: software suspend in 2.5.70-mm3.
Message-Id: <20030608102708.129e1ea9.hugang@soulinfo.com>
In-Reply-To: <20030603185551.GA3274@zaurus.ucw.cz>
References: <20030603211156.726366e7.hugang@soulinfo.com>
	<1054646566.9234.20.camel@dhcp22.swansea.linux.org.uk>
	<20030603223511.155ea2cc.hugang@soulinfo.com>
	<20030603185551.GA3274@zaurus.ucw.cz>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Pavel Machek <pavel@ucw.cz>
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003 20:55:51 +0200
Pavel Machek <pavel@ucw.cz> wrote:

>  Locating Ben's patch and forward-porting 
>  it would be way better...

I was tried  Ben's patch, It's cool, Very stable in my laptop.

Here is two patch.
  * suspend.c can swap more pages into swap space.
  * vmscan.c  can make swap out faster.

--- linux-2.5.70/kernel/suspend.c.old	Sun Jun  8 11:09:41 2003
+++ linux-2.5.70/kernel/suspend.c	Sun Jun  8 10:54:55 2003
@@ -621,9 +621,17 @@
  */
 static void free_some_memory(void)
 {
+	unsigned int count = 10;
+
 	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
+	while (count) {
+		unsigned int ret = shrink_all_memory(4 * 1024 * 1024 / PAGE_SIZE);
+		if (ret == 0) {
+			count--;
+			continue;
+		}
 		printk(".");
+	}
 	printk("|\n");
 }
--- linux-2.5.70/mm/vmscan.c.old	Sun Jun  8 11:08:27 2003
+++ linux-2.5.70/mm/vmscan.c	Sun Jun  8 11:02:27 2003
@@ -882,7 +882,8 @@
  * dead and from now on, only perform a short scan.  Basically we're polling
  * the zone for when the problem goes away.
  */
-static int balance_pgdat(pg_data_t *pgdat, int nr_pages, struct page_state *ps)
+static int balance_pgdat(pg_data_t *pgdat, int nr_pages,
+		struct page_state *ps, unsigned int time)
 {
 	int to_free = nr_pages;
 	int priority;
@@ -930,7 +931,7 @@
 		}
 		if (all_zones_ok)
 			break;
-		blk_congestion_wait(WRITE, HZ/10);
+		blk_congestion_wait(WRITE, HZ/time);
 	}
 	return nr_pages - to_free;
 }
@@ -984,7 +985,7 @@
 		schedule();
 		finish_wait(&pgdat->kswapd_wait, &wait);
 		get_page_state(&ps);
-		balance_pgdat(pgdat, 0, &ps);
+		balance_pgdat(pgdat, 0, &ps, 10);
 	}
 }
 
@@ -1020,7 +1021,7 @@
 		struct page_state ps;
 
 		get_page_state(&ps);
-		freed = balance_pgdat(pgdat, nr_to_free, &ps);
+		freed = balance_pgdat(pgdat, nr_to_free, &ps, 200);
 		ret += freed;
 		nr_to_free -= freed;
 		if (nr_to_free <= 0)

-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
http://soulinfo.com/~hugang/HuGang.asc
ICQ#         : 205800361
Registered Linux User : 204016
