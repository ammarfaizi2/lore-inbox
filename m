Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTLYOuj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 09:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTLYOuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 09:50:39 -0500
Received: from zork.zork.net ([64.81.246.102]:11972 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264305AbTLYOug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 09:50:36 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH,SILLY] /proc/updike -- uptime histogram
Reply-To: Sean Neakums <sneakums@zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 25 Dec 2003 14:50:35 +0000
Message-ID: <6uad5h0x50.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you don't find the notion of represting uptime with an ASCII
phallus amusing on any level at all, then this patch is not for you.
Please, just skip to the next message.



Of course this is better done in userspace, but /proc/updike is funnier.

alias updike='/usr/bin/uptime | perl -ne "/(\d+) d/;print 8,q(=)x\$1,\"D\n\""'

I believe the above was found in someone's signature on Slashdot
(figures, mutter the people who really shouldn't have bothered to read
this far).



diff -urN --exclude '*~' S0/fs/Kconfig hack-S0/fs/Kconfig
--- S0/fs/Kconfig	2003-10-17 23:57:54.000000000 +0100
+++ hack-S0/fs/Kconfig	2003-12-23 22:36:11.000000000 +0000
@@ -760,6 +760,14 @@
 	  This option will enlarge your kernel by about 67 KB. Several
 	  programs depend on this, so everyone should say Y here.
 
+config PROC_UPDIKE
+	bool "visual uptime reporting support"
+	depends on PROC_FS
+	help
+	  A dynamic commentary on the nature of uptime contests, drawing on
+	  principles of the visual display of quantitative information
+	  espoused by Ed Tufte.
+
 config PROC_KCORE
 	bool
 	default y if !ARM
diff -urN --exclude '*~' S0/fs/proc/proc_misc.c hack-S0/fs/proc/proc_misc.c
--- S0/fs/proc/proc_misc.c	2003-10-01 18:50:21.000000000 +0100
+++ hack-S0/fs/proc/proc_misc.c	2003-12-23 21:54:17.000000000 +0000
@@ -153,6 +153,28 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#ifdef CONFIG_PROC_UPDIKE
+static int updike_read_proc(char *page, char**start, off_t off,
+				int count, int *eof, void *data)
+{
+	struct timespec uptime;
+	int days;
+	int i = 0;
+
+	do_posix_clock_monotonic_gettime(&uptime);
+	days = uptime.tv_sec / (3600 * 24);
+	page[0] = '8';
+	while ((i < days) && (i <= PAGE_SIZE - 4)) {
+		page[++i] = '=';
+	}
+	page[i + 1] = 'D';
+	page[i + 2] = '\n';
+	page[i + 3] = '\0';
+
+	return proc_calc_metrics(page, start, off, count, eof, i + 3);
+}
+#endif
+
 static int meminfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -647,6 +669,9 @@
 	} *p, simple_ones[] = {
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
+#ifdef CONFIG_PROC_UPDIKE
+		{"updike",	updike_read_proc},
+#endif
 		{"meminfo",	meminfo_read_proc},
 		{"version",	version_read_proc},
 #ifdef CONFIG_PROC_HARDWARE

