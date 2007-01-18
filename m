Return-Path: <linux-kernel-owner+w=401wt.eu-S1751901AbXARLMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbXARLMs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 06:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXARLMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 06:12:47 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:48896 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbXARLMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 06:12:47 -0500
Date: Thu, 18 Jan 2007 14:19:02 +0300
From: Alexey Dobriyan <adobriyan@openvz.org>
To: akpm@osdl.org
Cc: dev@sw.ru, linux-kernel@vger.kernel.org, devel@openvz.org
Subject: [PATCH 2/2] Extract and use wake_up_klogd()
Message-ID: <20070118111902.GB6040@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Korotaev <dev@sw.ru>

Remove hack with printing space to wake up klogd.
Use explicit wake_up_klogd().

See earlier discussion
http://groups.google.com/group/fa.linux.kernel/browse_frm/thread/75f496668409f58d/1a8f28983a51e1ff?lnk=st&q=wake_up_klogd+group%3Afa.linux.kernel&rnum=2#1a8f28983a51e1ff

Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 include/linux/kernel.h |    1 +
 kernel/printk.c        |   10 ++++++++--
 lib/bust_spinlocks.c   |   10 +---------
 3 files changed, 10 insertions(+), 11 deletions(-)

--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -176,6 +176,7 @@ static inline void console_verbose(void)
 }
 
 extern void bust_spinlocks(int yes);
+extern void wake_up_klogd(void);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
 extern int panic_on_oops;
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -783,6 +783,12 @@ int is_console_locked(void)
 	return console_locked;
 }
 
+void wake_up_klogd(void)
+{
+	if (!oops_in_progress && waitqueue_active(&log_wait))
+		wake_up_interruptible(&log_wait);
+}
+
 /**
  * release_console_sem - unlock the console system
  *
@@ -825,8 +831,8 @@ void release_console_sem(void)
 	console_locked = 0;
 	up(&console_sem);
 	spin_unlock_irqrestore(&logbuf_lock, flags);
-	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
-		wake_up_interruptible(&log_wait);
+	if (wake_klogd)
+		wake_up_klogd();
 }
 EXPORT_SYMBOL(release_console_sem);
 
--- a/lib/bust_spinlocks.c
+++ b/lib/bust_spinlocks.c
@@ -19,19 +19,11 @@ void __attribute__((weak)) bust_spinlock
 	if (yes) {
 		oops_in_progress = 1;
 	} else {
-		int loglevel_save = console_loglevel;
 #ifdef CONFIG_VT
 		unblank_screen();
 #endif
 		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk() will give klogd
-		 * and the blanked console a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;		/* NMI oopser may have shut the console up */
-		printk(" ");
-		console_loglevel = loglevel_save;
+		wake_up_klogd();
 	}
 }
 

