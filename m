Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTLYXoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTLYXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 18:44:06 -0500
Received: from zork.zork.net ([64.81.246.102]:23780 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264386AbTLYXn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 18:43:59 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,SILLY] /proc/updike -- uptime histogram
References: <6uad5h0x50.fsf@zork.zork.net>
Reply-To: Sean Neakums <sneakums@zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 25 Dec 2003 23:43:57 +0000
In-Reply-To: <6uad5h0x50.fsf@zork.zork.net> (Sean Neakums's message of "Thu,
 25 Dec 2003 14:50:35 +0000")
Message-ID: <6ufzf8zcn6.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> writes:

> If you don't find the notion of represting uptime with an ASCII
> phallus amusing on any level at all, then this patch is not for you.

Also applies to this message.



Below is a /proc/updike patch for legacy Linux 2.4:

(Boy, 2.5's kconfig sure is nice.)


diff -urN --exclude '*~' linux-2.4.23/Documentation/Configure.help edited/Documentation/Configure.help
--- linux-2.4.23/Documentation/Configure.help	2003-12-25 18:24:46.000000000 +0000
+++ edited/Documentation/Configure.help	2003-12-25 18:28:16.000000000 +0000
@@ -16703,6 +16703,12 @@
   This option will enlarge your kernel by about 67 KB. Several
   programs depend on this, so everyone should say Y here.
 
+visual uptime reporting support
+CONFIG_PROC_UPDIKE
+  A dynamic commentary on the nature of uptime contests, drawing on               
+  principles of the visual display of quantitative information                    
+  espoused by Ed Tufte.                                                           
+
 Support for PReP Residual Data
 CONFIG_PREP_RESIDUAL
   Some PReP systems have residual data passed to the kernel by the
diff -urN --exclude '*~' linux-2.4.23/fs/Config.in edited/fs/Config.in
--- linux-2.4.23/fs/Config.in	2003-12-25 18:24:57.000000000 +0000
+++ edited/fs/Config.in	2003-12-25 18:26:22.000000000 +0000
@@ -71,6 +71,7 @@
 tristate 'OS/2 HPFS file system support' CONFIG_HPFS_FS
 
 bool '/proc file system support' CONFIG_PROC_FS
+dep_bool 'visual uptime reporting support' CONFIG_PROC_UPDIKE $CONFIG_PROC_FS
 
 # For some reason devfs corrupts memory badly on x86-64. Disable it 
 # for now.
diff -urN --exclude '*~' linux-2.4.23/fs/proc/proc_misc.c edited/fs/proc/proc_misc.c
--- linux-2.4.23/fs/proc/proc_misc.c	2003-11-28 18:26:21.000000000 +0000
+++ edited/fs/proc/proc_misc.c	2003-12-25 18:14:43.000000000 +0000
@@ -152,6 +152,28 @@
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
@@ -596,6 +618,9 @@
 	} *p, simple_ones[] = {
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
+#ifdef CONFIG_PROC_UPDIKE
+		{"updike",	updike_read_proc},
+#endif
 		{"meminfo",	meminfo_read_proc},
 		{"version",	version_read_proc},
 #ifdef CONFIG_PROC_HARDWARE

