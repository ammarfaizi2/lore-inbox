Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTIWRx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTIWRx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:53:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49541
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262196AbTIWRxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:53:25 -0400
Date: Tue, 23 Sep 2003 19:53:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Tom Zanussi <zanussi@comcast.net>
Cc: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
       Jan Evert van Grootheest <j.grootheest@euronext.nl>,
       Willy Tarreau <willy@w.ods.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923175320.GD1269@velociraptor.random>
References: <Pine.LNX.4.44.0309231748310.27885-100000@gatemaster.ivimey.org> <3F708576.4080203@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F708576.4080203@comcast.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 12:40:06PM -0500, Tom Zanussi wrote:
> It may be a little over the top for 2.4, but I posted a patch for a 
> dynamically resizable printk a while back:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105828314919697&w=2
> 
> I depends on relayfs, which I also posted at the same time.

I don't think we can merge this in 2.4 but it looks good for 2.6.
However note you can't close the overflow issue, you must still have an
high limit, but you can make lots more reliable that way, it's similar
to netlink anyways, that uses dynamic skb to avoid wasting ram. But it's too
invasive for 2.4, just to make a comparison look what my patch looks
like (it will get a bit more complicated because of the request not to
waste the 64k, you know we throw some hundred megs in the per-cpu
freelists so nobody could notice the 64k lost in the 16-way..):

diff -urNp --exclude CVS --exclude BitKeeper x-ref/kernel/printk.c x/kernel/printk.c
--- x-ref/kernel/printk.c	2003-08-26 00:13:17.000000000 +0200
+++ x/kernel/printk.c	2003-09-01 21:38:16.000000000 +0200
@@ -30,13 +30,13 @@
 #include <asm/uaccess.h>
 
 #if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
-#define LOG_BUF_LEN	(65536)
+#define __LOG_BUF_LEN	(65536)
 #elif defined(CONFIG_ARCH_S390)
-#define LOG_BUF_LEN	(131072)
+#define __LOG_BUF_LEN	(131072)
 #elif defined(CONFIG_SMP)
-#define LOG_BUF_LEN	(32768)
+#define __LOG_BUF_LEN	(32768)
 #else	
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
+#define __LOG_BUF_LEN	(16384)			/* This must be a power of two */
 #endif
 
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
@@ -78,7 +78,9 @@ struct console *console_drivers;
  */
 static spinlock_t logbuf_lock = SPIN_LOCK_UNLOCKED;
 
-static char log_buf[LOG_BUF_LEN];
+static char __log_buf[__LOG_BUF_LEN];
+static char * log_buf = __log_buf;
+static int LOG_BUF_LEN = __LOG_BUF_LEN;
 #define LOG_BUF(idx) (log_buf[(idx) & LOG_BUF_MASK])
 
 /*
@@ -151,6 +153,39 @@ static int __init console_setup(char *st
 
 __setup("console=", console_setup);
 
+static int __init log_buf_len_setup(char *str)
+{
+	unsigned long size = simple_strtoul(str, &str, 0);
+
+	if (size & (size-1))
+		printk("log_buf_len: invalid size - needs a power of two\n");
+
+	spin_lock_irq(&logbuf_lock);
+	if (size > LOG_BUF_LEN) {
+		unsigned long start, end, dest_idx, offset;
+
+		LOG_BUF_LEN = size;
+		log_buf = alloc_exact(LOG_BUF_LEN);
+
+		offset = start = min(con_start, log_start);
+		end = log_end;
+		dest_idx = 0;
+		while (start != end) {
+			log_buf[dest_idx] = __log_buf[start & (__LOG_BUF_LEN - 1)];
+			start++;
+			dest_idx++;
+		}
+		log_start -= offset;
+		con_start -= offset;
+		log_end -= offset;
+	}
+	spin_unlock_irq(&logbuf_lock);
+
+	return 1;
+}
+
+__setup("log_buf_len=", log_buf_len_setup);
+
 /*
  * Commands to do_syslog:
  *

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
	    svn://svn.kernel.org/linux-2.[46]/trunk
