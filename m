Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTDGXNW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTDGXMw (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:12:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4231 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263819AbTDGXFl (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 19:05:41 -0400
Date: Mon, 7 Apr 2003 16:17:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: 76306.1226@compuserve.com
Subject: [PATCH] Wanted: a limit on kernel log buffer size
Message-Id: <20030407161700.30f45c5c.rddunlap@osdl.org>
In-Reply-To: <33271.4.64.238.61.1049686559.squirrel@webmail.osdl.org>
References: <200304062137_MC3-1-3346-A97E@compuserve.com>
	<33182.4.64.238.61.1049683748.squirrel@webmail.osdl.org>
	<33271.4.64.238.61.1049686559.squirrel@webmail.osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003 20:35:59 -0700 (PDT) "Randy.Dunlap" <rddunlap@osdl.org> wrote:

| >>  Some people (who will mercifully go unnamed) just will _not_
| >> read the documentation, and set the kernel log buffer shift
| >> to 31 on a 256MB machine.  This attempt to allocate 2GB of memory for the
| >> buffer results in an unbootable kernel.
| >>
| >>  Suggestions?
| >
| > This is a multi-part answer.  Say, 5 parts.
| >
| > a.  If someone won't read the help text, how can we help them?
| >
| > b.  If we make a 2 GB log buffer size a compile-time error, will
| > they read that?
| >
| > c.  If we make it a compile-time warning, will they read that?
| >
| > d.  What limit(s) do you suggest?  I can try to add some limits.
| >
| > e.  This kind of config limiting should be done in the config system IMO.
| > I've asked Roman for that capability....


Here's a [modified] patch that limits kernel log buffer size to 1 MB max
and 4 KB min.

To me, ideally the config system would allow limits to be specified,
and then advanced users could edit .config to get around those limits.
By putting limits checking in kernel source files, there is no way
around them other than by editing the source files.

I've made this patch because there are some cases where it shouldn't be
possible to shoot oneself in the foot IMO -- at least not using the
config system...it's OK to do that when editing .config.

--
~Randy


patch_name:	logbuf_limits.patch
patch_version:	2003-04-07.15:54:36
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	enforce kernel log buffer limits (min and max);
product:	Linux
product_versions: 2.5.67
changelog:	add min and max kernel log buffer limits checking;
URL:		http://www.osdl.org/archive/rddunlap/patches/logbuf_limits.patch
diffstat:	=
 kernel/printk.c |    6 ++++++
 1 files changed, 6 insertions(+)


diff -Naur ./kernel/printk.c%LBLIM ./kernel/printk.c
--- ./kernel/printk.c%LBLIM	Mon Apr  7 11:12:38 2003
+++ ./kernel/printk.c	Mon Apr  7 14:44:16 2003
@@ -34,6 +34,12 @@
 
 #define LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
+#if (LOG_BUF_LEN > (1024 * 1024))
+#error CONFIG_LOG_BUF_SHIFT is ridiculously large (more than 20 [1 MB]).
+#endif
+#if (LOG_BUF_LEN < (4 * 1024))
+#error CONFIG_LOG_BUF_SHIFT is ridiculously small (less than 12 [4 KB]).
+#endif
 
 /* printk's without a loglevel use this.. */
 #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
