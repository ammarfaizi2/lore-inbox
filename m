Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSKJJmc>; Sun, 10 Nov 2002 04:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264787AbSKJJmb>; Sun, 10 Nov 2002 04:42:31 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:37038 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S264786AbSKJJma>; Sun, 10 Nov 2002 04:42:30 -0500
Date: Sun, 10 Nov 2002 10:49:13 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] use 64 bit jiffies 4/4
In-Reply-To: <Pine.LNX.4.33.0211101014120.12784-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0211101036590.12784-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 4/4: use unsigned long for cpu statistics

This is more like a band-aid.
It used to be enough when we had HZ=100 on 32 bit platforms, and only
Alphas had the cpu statistics wrapping after 48.5 days.
Fixing 64 bit platforms is easily done with this patch, fixing 32 bit
would need annoying locking.

Well, it's only statistics after all, and there weren't many complaints
about Alpha, so maybe we just don't fix it at all...


--- linux-2.5.46-bk4-j64b/include/linux/kernel_stat.h	Mon Nov  4 23:30:51 2002
+++ linux-2.5.46-bk4-j64/include/linux/kernel_stat.h	Sun Nov 10 09:40:24 2002
@@ -14,11 +14,11 @@
  */
 
 struct cpu_usage_stat {
-	unsigned int user;
-	unsigned int nice;
-	unsigned int system;
-	unsigned int idle;
-	unsigned int iowait;
+	unsigned long user;
+	unsigned long nice;
+	unsigned long system;
+	unsigned long idle;
+	unsigned long iowait;
 };
 
 struct kernel_stat {

--- linux-2.5.46-bk4-j64b/fs/proc/proc_misc.c	Sun Nov 10 09:31:37 2002
+++ linux-2.5.46-bk4-j64/fs/proc/proc_misc.c	Sun Nov 10 09:40:24 2002
@@ -346,7 +346,8 @@ static int kstat_read_proc(char *page, c
 	int i, len;
 	extern unsigned long total_forks;
 	u64 jif = get_jiffies_64();
-	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
+	unsigned int sum = 0;
+	unsigned long user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
 	int major, disk;
 
 	for (i = 0 ; i < NR_CPUS; i++) {
@@ -364,7 +365,7 @@ static int kstat_read_proc(char *page, c
 #endif
 	}
 
-	len = sprintf(page, "cpu  %u %u %u %u %u\n",
+	len = sprintf(page, "cpu  %lu %lu %lu %lu %lu\n",
 		jiffies_to_clock_t(user),
 		jiffies_to_clock_t(nice),
 		jiffies_to_clock_t(system),
@@ -372,7 +373,7 @@ static int kstat_read_proc(char *page, c
 		jiffies_to_clock_t(iowait));
 	for (i = 0 ; i < NR_CPUS; i++){
 		if (!cpu_online(i)) continue;
-		len += sprintf(page + len, "cpu%d %u %u %u %u %u\n",
+		len += sprintf(page + len, "cpu%d %lu %lu %lu %lu %lu\n",
 			i,
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
 			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),

