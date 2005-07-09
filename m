Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVGIXys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVGIXys (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 19:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVGIXys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 19:54:48 -0400
Received: from mx.wp.pl ([212.77.101.4]:52383 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S261782AbVGIXyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 19:54:47 -0400
From: "Stanislaw W. Gruszka" <stf_xl@wp.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm1] printk: add features when CONFIG_PRINTK_TIME=y
Date: Sun, 10 Jul 2005 01:34:43 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200507100134.43108.stf_xl@wp.pl>
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO AS2=NO(0.506163) AS3=NO AS4=NO                                                
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add 2 values which control time printing when CONFIG_PRINTK_TIME=y. Values can 
be changed on boot option printk_time=n,m or by /proc/sys/kernel/printk_time.
First one tell about what is printing: 0 - no additional time info, 1 - current time, 2 - difference between to consecutive printk calls. Second tell about 
resolution of printing time.    

Signed-off-by: Stanislaw W. Gruszka <stf_xl@wp.pl>

 include/linux/sysctl.h |    1 
 kernel/printk.c        |  119 ++++++++++++++++++++++++++++++++++++++-----------
 kernel/sysctl.c        |   14 +++++
 3 files changed, 109 insertions(+), 25 deletions(-)

diff -uprN -X dontdiff linux-2.6.13-rc2.orig/include/linux/sysctl.h linux-2.6.13-rc2/include/linux/sysctl.h
--- linux-2.6.13-rc2.orig/include/linux/sysctl.h	2005-07-08 14:18:53.000000000 +0200
+++ linux-2.6.13-rc2/include/linux/sysctl.h	2005-07-10 00:46:53.000000000 +0200
@@ -137,6 +137,7 @@ enum
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
 	KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid core */
+	KERN_PRINTK_TIME=70, /* int: behaviour of printk time */
 };
 
 
diff -uprN -X dontdiff linux-2.6.13-rc2.orig/kernel/printk.c linux-2.6.13-rc2/kernel/printk.c
--- linux-2.6.13-rc2.orig/kernel/printk.c	2005-07-08 14:18:54.000000000 +0200
+++ linux-2.6.13-rc2/kernel/printk.c	2005-07-10 00:48:20.000000000 +0200
@@ -472,21 +472,103 @@ static void zap_locks(void)
 	init_MUTEX(&console_sem);
 }
 
-#if defined(CONFIG_PRINTK_TIME)
-static int printk_time = 1;
-#else
-static int printk_time = 0;
-#endif
+#ifdef CONFIG_PRINTK_TIME
+
+int printk_time_parm[2] = {
+	1, /* 0 - no additional time info
+	    * 1 - current time
+	    * 2 - difference between to consecutive printk calls
+	    */
+	6  /* number of digits after dot
+	    * proper values: 1,...,9
+	    */
+};
+
+#define printk_time (printk_time_parm[0])
+#define printk_time_resolution (printk_time_parm[1])
 
 static int __init printk_time_setup(char *str)
 {
-	if (*str)
-		return 0;
-	printk_time = 1;
+	int i, ints[3];
+
+	get_options(str, 3, ints);
+	for (i = 1; i <= ints[0]; i++)
+		printk_time_parm[i - 1] = ints[i];
+
 	return 1;
 }
 
-__setup("time", printk_time_setup);
+__setup("printk_time=", printk_time_setup);
+
+static unsigned long long diff_time_start;
+static unsigned long long diff_time_end;
+
+#define SET_DIFF_TIME_START() \
+	diff_time_start = sched_clock()
+#define SET_DIFF_TIME_END() \
+	diff_time_end = sched_clock()
+
+/* base to the power of exp */
+static unsigned long simple_pow(unsigned long base, unsigned exp)
+{
+	unsigned long res = 1;
+
+	while (exp) {
+		if (exp % 2)
+			res *= base;
+		exp /= 2;
+		base *= base;
+	}
+
+	return res;
+}
+
+static int time_print(char loglev_char)
+{
+	char tbuf[50], *tp;
+	char *fmt = "<%c>[%5lu.%09lu] ";
+	unsigned tlen;
+	int res, opt;
+	unsigned long long time;
+	unsigned long nanosec_rem, resolution_rem;
+
+	res = printk_time_resolution;
+	if (res < 1)
+		res = 1;
+	if (res > 9)
+		res = 9;
+	fmt[12] = res + '0';
+
+	opt = printk_time;
+	if (opt == 1)
+		time = sched_clock();
+	else if (opt == 2)
+		time = diff_time_end - diff_time_start;
+	else
+		time = 0;
+
+	nanosec_rem = do_div(time, 1000000000);
+	resolution_rem = nanosec_rem / simple_pow(10, 9 - res);
+	tlen = snprintf(tbuf, sizeof(tbuf), fmt, loglev_char,
+				(unsigned long) time, resolution_rem);
+
+	for (tp = tbuf; tp < tbuf + tlen; tp++)
+		emit_log_char(*tp);
+
+	return tlen - 3;
+}
+
+#else // CONFIG_PRINTK_TIME
+
+#define SET_DIFF_TIME_START()	do { } while (0)
+#define SET_DIFF_TIME_END()	do { } while (0)
+
+#define printk_time 0
+#define printk_time_resolution 0
+#define time_print(x) 0
+
+#endif // CONFIG_PRINTK_TIME
+
 
 /*
  * This is printk.  It can be called from any context.  We want it to work.
@@ -507,9 +589,11 @@ asmlinkage int printk(const char *fmt, .
 	va_list args;
 	int r;
 
+	SET_DIFF_TIME_END();
 	va_start(args, fmt);
 	r = vprintk(fmt, args);
 	va_end(args);
+	SET_DIFF_TIME_START();
 
 	return r;
 }
@@ -540,11 +624,6 @@ asmlinkage int vprintk(const char *fmt, 
                         /* log_level_unknown signals the start of a new line */
 			if (printk_time) {
 				int loglev_char;
-				char tbuf[50], *tp;
-				unsigned tlen;
-				unsigned long long t;
-				unsigned long nanosec_rem;
-
 				/*
 				 * force the log level token to be
 				 * before the time output.
@@ -558,17 +637,7 @@ asmlinkage int vprintk(const char *fmt, 
 					loglev_char = default_message_loglevel
 						+ '0';
 				}
-				t = sched_clock();
-				nanosec_rem = do_div(t, 1000000000);
-				tlen = sprintf(tbuf,
-						"<%c>[%5lu.%06lu] ",
-						loglev_char,
-						(unsigned long)t,
-						nanosec_rem/1000);
-
-				for (tp = tbuf; tp < tbuf + tlen; tp++)
-					emit_log_char(*tp);
-				printed_len += tlen - 3;
+				printed_len += time_print(loglev_char);
 			} else {
 				if (p[0] != '<' || p[1] < '0' ||
 				   p[1] > '7' || p[2] != '>') {
diff -uprN -X dontdiff linux-2.6.13-rc2.orig/kernel/sysctl.c linux-2.6.13-rc2/kernel/sysctl.c
--- linux-2.6.13-rc2.orig/kernel/sysctl.c	2005-07-08 14:18:54.000000000 +0200
+++ linux-2.6.13-rc2/kernel/sysctl.c	2005-07-10 00:46:53.000000000 +0200
@@ -122,6 +122,10 @@ extern int sysctl_hz_timer;
 extern int acct_parm[];
 #endif
 
+#ifdef CONFIG_PRINTK_TIME
+extern int printk_time_parm[];
+#endif
+
 int randomize_va_space = 1;
 
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
@@ -379,6 +383,16 @@ static ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#ifdef CONFIG_PRINTK_TIME
+	{
+		.ctl_name	= KERN_PRINTK_TIME,
+		.procname	= "printk_time",
+		.data		= printk_time_parm,
+		.maxlen		= 2*sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 #ifdef CONFIG_KMOD
 	{
 		.ctl_name	= KERN_MODPROBE,
