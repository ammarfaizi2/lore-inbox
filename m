Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbUJ3WW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbUJ3WW5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUJ3WW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:22:56 -0400
Received: from baikonur.stro.at ([213.239.196.228]:63624 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261359AbUJ3WWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:22:36 -0400
Date: Sun, 31 Oct 2004 00:22:28 +0200
From: maximilian attems <janitor@sternwelten.at>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Margit Schubert-While <margitsw@t-online.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
       mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
       prism54-devel@prism54.org, netdev@oss.sgi.com,
       Domen Puncer <domen@coderock.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.4] back port msleep(), msleep_interruptible()
Message-ID: <20041030222228.GB1456@stro.at>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Margit Schubert-While <margitsw@t-online.de>,
	Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
	mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
	prism54-devel@prism54.org, netdev@oss.sgi.com,
	Domen Puncer <domen@coderock.org>, linux-kernel@vger.kernel.org
References: <20040923221303.GB13244@us.ibm.com> <20040923221303.GB13244@us.ibm.com> <5.1.0.14.2.20040924074745.00b1cd40@pop.t-online.de> <415CD9D9.2000607@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415CD9D9.2000607@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004, Jeff Garzik wrote:

> I would rather see an msleep implementation in 2.4.x...

thanks for Domen Puncer at helping out.

msleep() and msleep_interruptible() as found in current 2.6 to 2.4.
therefor also adds the helper functions ssleep(), jiffies_to_msecs(),
jiffies_to_usecs(), msecs_to_jiffies().

compile and boot tested.


Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 include/linux/delay.h |    8 ++++++
 include/linux/time.h  |   41 +++++++++++++++++++++++++++++++++
 kernel/Makefile       |    3 +-
 kernel/timer.c        |   33 ++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 1 deletion(-)

diff -puN kernel/Makefile~add-msleep-2.4 kernel/Makefile
--- a/kernel/Makefile~add-msleep-2.4	2004-10-30 22:48:46.000000000 +0200
+++ b/kernel/Makefile	2004-10-30 22:50:45.000000000 +0200
@@ -9,7 +9,8 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o printk.o
+export-objs   = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
+		printk.o timer.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
diff -puN kernel/timer.c~add-msleep-2.4 kernel/timer.c
--- a/kernel/timer.c~add-msleep-2.4	2004-10-30 22:48:46.000000000 +0200
+++ b/kernel/timer.c	2004-10-30 22:50:09.000000000 +0200
@@ -22,6 +22,7 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 
@@ -874,3 +875,35 @@ asmlinkage long sys_nanosleep(struct tim
 	return 0;
 }
 
+/**
+ * msleep - sleep safely even with waitqueue interruptions
+ * @msecs: Time in milliseconds to sleep for
+ */
+void msleep(unsigned int msecs)
+{
+	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+
+	while (timeout) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		timeout = schedule_timeout(timeout);
+	}
+}
+
+EXPORT_SYMBOL(msleep);
+
+/**
+ * msleep_interruptible - sleep waiting for waitqueue interruptions
+ * @msecs: Time in milliseconds to sleep for
+ */
+unsigned long msleep_interruptible(unsigned int msecs)
+{
+	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+
+	while (timeout && !signal_pending(current)) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		timeout = schedule_timeout(timeout);
+	}
+	return jiffies_to_msecs(timeout);
+}
+
+EXPORT_SYMBOL(msleep_interruptible);
diff -puN include/linux/delay.h~add-msleep-2.4 include/linux/delay.h
--- a/include/linux/delay.h~add-msleep-2.4	2004-10-30 22:48:46.000000000 +0200
+++ b/include/linux/delay.h	2004-10-30 22:48:46.000000000 +0200
@@ -34,4 +34,12 @@ extern unsigned long loops_per_jiffy;
 	({unsigned long msec=(n); while (msec--) udelay(1000);}))
 #endif
 
+void msleep(unsigned int msecs);
+unsigned long msleep_interruptible(unsigned int msecs);
+
+static inline void ssleep(unsigned int seconds)
+{
+	msleep(seconds * 1000);
+}
+
 #endif /* defined(_LINUX_DELAY_H) */
diff -puN include/linux/time.h~add-msleep-2.4 include/linux/time.h
--- a/include/linux/time.h~add-msleep-2.4	2004-10-30 22:48:46.000000000 +0200
+++ b/include/linux/time.h	2004-10-30 22:48:46.000000000 +0200
@@ -126,4 +126,45 @@ struct	itimerval {
 	struct	timeval it_value;	/* current value */
 };
 
+/*
+ * Convert jiffies to milliseconds and back.
+ *
+ * Avoid unnecessary multiplications/divisions in the
+ * two most common HZ cases:
+ */
+static inline unsigned int jiffies_to_msecs(const unsigned long j)
+{
+#if HZ <= 1000 && !(1000 % HZ)
+	return (1000 / HZ) * j;
+#elif HZ > 1000 && !(HZ % 1000)
+	return (j + (HZ / 1000) - 1)/(HZ / 1000);
+#else
+	return (j * 1000) / HZ;
+#endif
+}
+
+static inline unsigned int jiffies_to_usecs(const unsigned long j)
+{
+#if HZ <= 1000 && !(1000 % HZ)
+	return (1000000 / HZ) * j;
+#elif HZ > 1000 && !(HZ % 1000)
+	return (j*1000 + (HZ - 1000))/(HZ / 1000);
+#else
+	return (j * 1000000) / HZ;
+#endif
+}
+
+static inline unsigned long msecs_to_jiffies(const unsigned int m)
+{
+	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+		return MAX_JIFFY_OFFSET;
+#if HZ <= 1000 && !(1000 % HZ)
+	return (m + (1000 / HZ) - 1) / (1000 / HZ);
+#elif HZ > 1000 && !(HZ % 1000)
+	return m * (HZ / 1000);
+#else
+	return (m * HZ + 999) / 1000;
+#endif
+}
+
 #endif


