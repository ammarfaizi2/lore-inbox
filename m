Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132710AbRDUPtr>; Sat, 21 Apr 2001 11:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132717AbRDUPtb>; Sat, 21 Apr 2001 11:49:31 -0400
Received: from www.wen-online.de ([212.223.88.39]:10502 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132710AbRDUPtJ>;
	Sat, 21 Apr 2001 11:49:09 -0400
Date: Sat, 21 Apr 2001 17:48:52 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: try_to_swap_out() deactivating pages w. count > 2
Message-ID: <Pine.LNX.4.33.0104211741020.346-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A printk added to 2.4.4-pre5 try_to_swap_out()...

drop_pte:
		mm->rss--;
{
	int age = page->age;
	int count = page_count(page);
	int cache = PageSwapCache(page);
	printk("[pid-%d] page:%p deact:%d cache:%d age:%d count:%d\n",
			current->pid, page, !age, cache, age, count-1);
}

make -j30 bzImage

29:17: klogd 1.3-3, log source = /proc/kmsg started.
29:27: SysRq: Log level set to 0
30:04: [pid-4] page:c10e225c deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10e33e0 deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10e3394 deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10e1cb8 deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10e1c20 deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10eb894 deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10eb7b0 deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10f0bb4 deact:0 cache:0 age:4 count:3
30:04: [pid-4] page:c10f1320 deact:0 cache:1 age:2 count:1
30:04: [pid-4] page:c10f136c deact:0 cache:1 age:2 count:1
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:29 count:164 [164? 1]
30:04: [pid-4] page:c10599a8 deact:0 cache:0 age:26 count:164
30:04: [pid-4] page:c105995c deact:0 cache:0 age:37 count:164
30:04: [pid-4] page:c10598c4 deact:0 cache:0 age:34 count:164
30:04: [pid-4] page:c1059878 deact:0 cache:0 age:34 count:164
30:04: [pid-4] page:c105982c deact:0 cache:0 age:34 count:164
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:32 count:163
30:04: [pid-4] page:c10599a8 deact:0 cache:0 age:26 count:163
30:04: [pid-4] page:c10debbc deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10deb70 deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10deb24 deact:1 cache:0 age:0 count:2
30:04: [pid-4] page:c10e1aa4 deact:1 cache:0 age:0 count:2

(snip 1000+ lines)

grep c10599f4 log
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:29 count:164
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:32 count:163
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:32 count:162
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:32 count:161
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:32 count:160
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:32 count:159
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:32 count:158
30:04: [pid-4] page:c10599f4 deact:0 cache:0 age:32 count:157
30:05: [pid-4] page:c10599f4 deact:0 cache:0 age:16 count:155
30:05: [pid-4] page:c10599f4 deact:0 cache:0 age:22 count:156
30:05: [pid-4] page:c10599f4 deact:0 cache:0 age:22 count:155
30:05: [pid-4] page:c10599f4 deact:0 cache:0 age:50 count:157
30:05: [pid-4] page:c10599f4 deact:0 cache:0 age:16 count:157
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:59
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:58
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:57
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:56
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:55
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:54
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:53
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:52
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:51
41:41: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:50
41:59: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:49
41:59: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:48
41:59: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:47
41:59: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:46
41:59: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:45
41:59: [pid-4] page:c10599f4 deact:1 cache:0 age:0 count:44

(klogd only logged 1196 pages during the whole build)

grep deact:0 log|wc -l                 = 961
grep count:[12] log|wc -l              = 875

grep deact:1 log|wc -l                 = 235
grep deact:1 log|grep count:[12]|wc -l = 103

1.  what kind of page has 164 references?
2.  why deactivate pages (lots) with count > 2?  PINGpong.

	-Mike

