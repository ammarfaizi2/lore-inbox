Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVCJRf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVCJRf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVCJRcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:32:22 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:47500 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262899AbVCJR1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:27:10 -0500
Message-ID: <42308351.4090606@am.sony.com>
Date: Thu, 10 Mar 2005 09:26:41 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] printk-times bugfix for loglevel-only printks
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch fixes a bug with the recently added printk-times feature.

In the case where a printk consists of only the log level (followed
subsequently by printks with more text for the same line), the
printk-times code doesn't correctly recognize the end of the
string, and starts emitting chars at the 0 byte at the end of the
string.

The patch below fixes this problem.  It also adjusts the handling
of printed_len in the routine, which was affected by the
printk-times feature.

Please apply. Thanks.
 -- Tim Bird, Senior Software Engineer, Sony Electronics

diffstat:
 printk.c |    5 +++++
 1 files changed, 5 insertions(+)

Signed-off-by: Tim Bird <tim.bird@am.sony.com>
Acked-by: Tony Luck <tony.luck@intel.com>
--------------------------------------
diff -pruN printk-1/kernel/printk.c printk-fix1/kernel/printk.c
--- printk-1/kernel/printk.c	2005-03-09 15:42:04.550944124 -0800
+++ printk-fix1/kernel/printk.c	2005-03-09 15:36:18.928567360 -0800
@@ -579,6 +579,7 @@ asmlinkage int vprintk(const char *fmt,
 				   p[1] <= '7' && p[2] == '>') {
 					loglev_char = p[1];
 					p += 3;
+					printed_len += 3;
 				} else {
 					loglev_char = default_message_loglevel
 						+ '0';
@@ -593,6 +594,7 @@ asmlinkage int vprintk(const char *fmt,

 				for (tp = tbuf; tp < tbuf + tlen; tp++)
 					emit_log_char (*tp);
+				printed_len += tlen - 3;
 			} else {
 				if (p[0] != '<' || p[1] < '0' ||
 				   p[1] > '7' || p[2] != '>') {
@@ -601,8 +603,11 @@ asmlinkage int vprintk(const char *fmt,
 						+ '0');
 					emit_log_char('>');
 				}
+				printed_len += 3;
 			}
 			log_level_unknown = 0;
+			if (!*p)
+				break;
 		}
 		emit_log_char(*p);
 		if (*p == '\n')
