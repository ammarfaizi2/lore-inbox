Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263321AbTIWWW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTIWWW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:22:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:46480
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263321AbTIWWWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:22:24 -0400
Date: Wed, 24 Sep 2003 00:22:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: zanussi@comcast.net, Ruth.Ivimey-Cook@ivimey.org, j.grootheest@euronext.nl,
       willy@w.ods.org, marcelo.tosatti@cyclades.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: log-buf-len dynamic
Message-ID: <20030923222229.GQ1269@velociraptor.random>
References: <Pine.LNX.4.44.0309231748310.27885-100000@gatemaster.ivimey.org> <3F708576.4080203@comcast.net> <20030923175320.GD1269@velociraptor.random> <20030923143754.6b9efbc9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923143754.6b9efbc9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 02:37:54PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > I don't think we can merge this in 2.4 but it looks good for 2.6.
> 
> I think so: doing it via a __setup parameter is much smarter than requiring
> a rebuild.

agreed. That's why I also preferred my simple hack. After I fix the 64k
memory loss, I will see no disavantages in the kernel boot time
parameter compared to the compile time option.

> 
> > +static int __init log_buf_len_setup(char *str)
> > +{
> > +	unsigned long size = simple_strtoul(str, &str, 0);
> > +
> > +	if (size & (size-1))
> > +		printk("log_buf_len: invalid size - needs a power of two\n");
> 
> You need to either panic or return here.

woops sorry, that was the old version ;) it had other bugs too, the new
one is this one (Marcelo please don't merge the old version, I thought
it was just uptodate in 22aa1 but it was not, the new version wasn't in
the ftp site yet infact)

Also I have to fix the request for the 64k memory loss reported by Willy
first.

thanks for the review!

diff -urNp --exclude CVS --exclude BitKeeper ul-ref/kernel/printk.c ul/kernel/printk.c
--- ul-ref/kernel/printk.c	2003-09-06 01:45:25.000000000 +0200
+++ ul/kernel/printk.c	2003-09-06 01:46:09.000000000 +0200
@@ -27,15 +27,16 @@
 #include <linux/interrupt.h>			/* For in_interrupt() */
 #include <linux/config.h>
 #include <linux/delay.h>
+#include <linux/bootmem.h>
 
 #include <asm/uaccess.h>
 
 #if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
-#define LOG_BUF_LEN	(65536)
+#define __LOG_BUF_LEN	(65536)
 #elif defined(CONFIG_ARCH_S390) || defined(CONFIG_PPC64) || defined(CONFIG_PPC)
-#define LOG_BUF_LEN	(131072)
+#define __LOG_BUF_LEN	(131072)
 #else	
-#define LOG_BUF_LEN	(32768)			/* This must be a power of two */
+#define __LOG_BUF_LEN	(32768)			/* This must be a power of two */
 #endif
 
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
@@ -78,7 +79,9 @@ struct console *console_drivers;
  */
 static spinlock_t logbuf_lock = SPIN_LOCK_UNLOCKED;
 
-static char log_buf[LOG_BUF_LEN];
+static char __log_buf[__LOG_BUF_LEN];
+static char * log_buf = __log_buf;
+static int LOG_BUF_LEN = __LOG_BUF_LEN;
 #define LOG_BUF(idx) (log_buf[(idx) & LOG_BUF_MASK])
 
 /*
@@ -165,6 +168,45 @@ static int __init console_setup(char *st
 
 __setup("console=", console_setup);
 
+static int __init log_buf_len_setup(char *str)
+{
+	unsigned long size = memparse(str, &str);
+
+	if (size > LOG_BUF_LEN) {
+		unsigned long start, dest_idx, offset;
+		char * new_log_buf;
+
+		new_log_buf = alloc_bootmem(size);
+		if (!new_log_buf) {
+			printk("log_buf_len: allocation failed\n");
+			goto out;
+		}
+
+		spin_lock_irq(&logbuf_lock);
+		LOG_BUF_LEN = size;
+		log_buf = new_log_buf;
+
+		offset = start = min(con_start, log_start);
+		dest_idx = 0;
+		while (start != log_end) {
+			log_buf[dest_idx] = __log_buf[start & (__LOG_BUF_LEN - 1)];
+			start++;
+			dest_idx++;
+		}
+		log_start -= offset;
+		con_start -= offset;
+		log_end -= offset;
+		spin_unlock_irq(&logbuf_lock);
+
+		printk("log_buf_len: %d\n", LOG_BUF_LEN);
+	}
+ out:
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
