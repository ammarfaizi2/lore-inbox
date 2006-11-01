Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946213AbWKAAJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946213AbWKAAJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946215AbWKAAJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:09:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946213AbWKAAJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:09:51 -0500
Date: Tue, 31 Oct 2006 16:09:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, mingo@elte.hu,
       rusty@rustcorp.com.au, tglx@linutronix.de
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
Message-Id: <20061031160918.d997d79a.akpm@osdl.org>
In-Reply-To: <1162338491.11965.101.camel@localhost.localdomain>
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
	<1162338491.11965.101.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 23:48:11 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Maw, 2006-10-31 am 15:09 -0800, ysgrifennodd akpm@osdl.org:
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Apparently FUTEX_FD is unfixably racy and nothing uses it (or if it does, it
> > shouldn't).
> > 
> > Add a warning printk, give any remaining users six months to migrate off it.
> 
> Andrew - please use time based rate limits for this sort of thing, that
> way you actually get to see who is actually using it. Probably doesn't
> matter for the FUTEX_FD case as nobody does, but in general the 'ten
> times during boot' approach is not as good as ratelimit(): Perhaps
> net_ratelimit() ought to become more general ?

I don't think either works very well, really.  How frequently do we
rate-limit it?  If it's faster than once-per-hour then we'll irritate
people.

Maybe that's the answer.  Once-per-hour.

umm, I think we'd need something like this:



From: Andrew Morton <akpm@osdl.org>

printk_ratelimit() has global state which makes it not useful for callers
which wish to perform ratelimiting at a particular frequency.

Add a printk_timed_ratelimit() which utilises caller-provided state storage to
permit more flexibility.

This function can in fact be used for things other than printk ratelimiting
and is perhaps poorly named.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/kernel.h |    2 ++
 kernel/printk.c        |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff -puN kernel/printk.c~printk-timed-ratelimit kernel/printk.c
--- a/kernel/printk.c~printk-timed-ratelimit
+++ a/kernel/printk.c
@@ -31,6 +31,7 @@
 #include <linux/security.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 
@@ -1101,3 +1102,23 @@ int printk_ratelimit(void)
 				printk_ratelimit_burst);
 }
 EXPORT_SYMBOL(printk_ratelimit);
+
+/**
+ * printk_timed_ratelimit - caller-controlled printk ratelimiting
+ * @caller_jiffies: pointer to caller's state
+ * @interval_msecs: minimum interval between prints
+ *
+ * printk_timed_ratelimit() returns true if more than @interval_msecs
+ * milliseconds have elapsed since the last time printk_timed_ratelimit()
+ * returned true.
+ */
+bool printk_timed_ratelimit(unsigned long *caller_jiffies,
+			unsigned int interval_msecs)
+{
+	if (*caller_jiffies == 0 || time_after(jiffies, *caller_jiffies)) {
+		*caller_jiffies = jiffies + msecs_to_jiffies(interval_msecs);
+		return true;
+	}
+	return false;
+}
+EXPORT_SYMBOL(printk_timed_ratelimit);	
diff -puN include/linux/kernel.h~printk-timed-ratelimit include/linux/kernel.h
--- a/include/linux/kernel.h~printk-timed-ratelimit
+++ a/include/linux/kernel.h
@@ -171,6 +171,8 @@ __attribute_const__ roundup_pow_of_two(u
 
 extern int printk_ratelimit(void);
 extern int __printk_ratelimit(int ratelimit_jiffies, int ratelimit_burst);
+extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
+				unsigned int interval_msec);
 
 static inline void console_silent(void)
 {
_

