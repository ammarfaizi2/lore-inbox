Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268294AbTGOPOZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268536AbTGOPOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:14:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3971 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268294AbTGOPE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:04:26 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.6972.694134.446140@gargle.gargle.HOWL>
Date: Tue, 15 Jul 2003 10:18:20 -0500
To: linux-kernel@vger.kernel.org
Cc: karim@opersys.com, bob@watson.ibm.com
Subject: [RFC][PATCH] dynamic printk
X-Mailer: VM(ViewMail) 7.01 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a dynamically auto-resizing printk.  It replaces
the static printk buffer with a dynamic relayfs channel at init time;
the static buffer is copied to the relayfs channel and then discarded.

The relayfs file system it depends on was posted to this list a few
minutes ago and is also available at http://www.opersys.com/relayfs.

There are a couple of benefits to using the dynamic version:

- the initial static printk buffer can be made large enough to capture
all the boot messages even on a noisy system

- printks are no longer lost, which can come in handy when debugging
drivers or the kernel

I've been running it on my uniprocessor x86 development machine, and
haven't had any problems.  I've verified that it does indeed save
printks that the static version loses, by generating a lot of printks
from a test module.  In fact it should never lose a printk (unless the
maximum buffer size is exceeded, currently that's an arbitrary 2M).
It still needs testing before I'd put it on a production machine, but
it should be pretty useful even so as a tool for diagnosing init-time
problems and debugging drivers and other kernel code.

The current version can always be found at
http://www.opersys.com/relayfs/printk-on-relayfs.html.

Known problems:

Buffer shrinking happens only when another printk comes along - if
one doesn't come along for awhile, it could remain at its expanded size
for awhile.  I need to make shrinking happen under a timer.

I wanted to keep the dynamic version separate from the static version
but since they're both needed at least until after init, I couldn't
just configure one out and the other in.  I had to make some of the
static printk variables non-static, and do some other ugly things to
make the unused static printk functions and variables go away after
init.  Also the else clause of the new dispatching versions of a few
printk functions reference the static versions which would have
disappeared after init, but since these paths can never be taken after
init, isn't a problem.  The alternative would be to use function
pointers, but that didn't seem great either.  I plan on extending
relayfs to work with static buffers, which will remove the need for
the static version altogether.

Comments welcome.

diff -urpN -X dontdiff linux-2.6.0-test1/include/linux/printk-dynamic.h linux-2.6.0-test1-relayfs-printk/include/linux/printk-dynamic.h
--- linux-2.6.0-test1/include/linux/printk-dynamic.h	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/include/linux/printk-dynamic.h	Sun Jul 13 22:32:59 2003
@@ -0,0 +1,38 @@
+/*
+ * linux/include/linux/printk-dynamic.h
+ *
+ * Copyright (C) 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
+ *
+ * Included by static printk (printk.c) so its functions and data
+ * get the right names and attributes depending on whether dynamic
+ * printk is configured in or not.  Also needed by printk channel
+ * registerers.
+ */
+
+#ifndef _LINUX_PRINTK_DYNAMIC_H
+#define _LINUX_PRINTK_DYNAMIC_H
+
+#if defined(CONFIG_DYNAMIC_PRINTK)
+/* static printk needs to be able to find these (in printk-dynamic.c) */
+extern int do_syslog(int type, char * buf, int len);
+extern void release_console_sem(void);
+extern int register_printk_channel(void);
+/* static printk data and functions go away after init */
+#define DO_SYSLOG		__init do_syslog_static
+#define RELEASE_CONSOLE_SEM	__init release_console_sem_static
+#define _PRINTK			__init _printk
+#define PRINTK			__init unused_printk
+#define PRINTK_INITDATA		__initdata = { 0, }
+#define PRINTK_INIT		__init
+#else
+/* normal printk */
+#define DO_SYSLOG		do_syslog
+#define RELEASE_CONSOLE_SEM	release_console_sem
+#define _PRINTK			_printk
+#define PRINTK			printk
+#define PRINTK_INITDATA
+#define PRINTK_INIT
+/* so init compiles if normal printk */
+#define register_printk_channel() (0)
+#endif /* CONFIG_DYNAMIC_PRINTK */
+#endif /* _LINUX_PRINTK_DYNAMIC_H */
diff -urpN -X dontdiff linux-2.6.0-test1/init/Kconfig linux-2.6.0-test1-relayfs-printk/init/Kconfig
--- linux-2.6.0-test1/init/Kconfig	Sun Jul 13 22:37:16 2003
+++ linux-2.6.0-test1-relayfs-printk/init/Kconfig	Sun Jul 13 22:32:59 2003
@@ -92,6 +92,20 @@ config SYSCTL
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.
 
+config DYNAMIC_PRINTK
+	bool "Dynamic printk support" if DEBUG_KERNEL
+	depends on RELAYFS_FS=y
+	---help---
+	  If you say Y here, printk will use a dynamically auto-resizing
+	  buffer.  The static printk buffer is still needed for system init,
+	  but will be discarded after that, and so can be configured much
+	  larger if necessary to capture large numbers of init-time messages
+	  (i.e. increase the LOG_BUF_SHIFT value).  The normal working size
+	  the dynamic printk buffer will try to maintain is specified by 
+	  MIN_LOG_BUF_SHIFT, which should probably be the same value you
+	  would have made the static printk buffer if dynamic printk wasn't
+	  enabled.
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
 	range 12 20
@@ -109,6 +123,26 @@ config LOG_BUF_SHIFT
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config MIN_LOG_BUF_SHIFT
+	int "Dynamic kernel log buffer size (16 => 64KB, 17 => 128KB)" if DYNAMIC_PRINTK
+	range 12 22
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  The normal working size the dynamic printk buffer will try to 
+	  maintain.  This should probably be the same value you would have
+	  made the static printk buffer if dynamic printk wasn't enabled.
+
+	  Select dynamic kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
 
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"
diff -urpN -X dontdiff linux-2.6.0-test1/init/main.c linux-2.6.0-test1-relayfs-printk/init/main.c
--- linux-2.6.0-test1/init/main.c	Sun Jul 13 22:31:20 2003
+++ linux-2.6.0-test1-relayfs-printk/init/main.c	Sun Jul 13 22:32:59 2003
@@ -38,6 +38,7 @@
 #include <linux/moduleparam.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
+#include <linux/printk-dynamic.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -551,6 +552,7 @@ extern void prepare_namespace(void);
 static int init(void * unused)
 {
 	static char * argv_sh[] = { "sh", NULL, };
+	int err;
 
 	lock_kernel();
 	/*
@@ -572,6 +574,9 @@ static int init(void * unused)
 	do_basic_setup();
 
 	prepare_namespace();
+	
+	if ((err = register_printk_channel()) < 0)
+		panic("Couldn't register printk channel: errcode %d\n", err);
 
 	/*
 	 * Ok, we have completed the initial bootup, and
diff -urpN -X dontdiff linux-2.6.0-test1/kernel/Makefile linux-2.6.0-test1-relayfs-printk/kernel/Makefile
--- linux-2.6.0-test1/kernel/Makefile	Sun Jul 13 22:31:50 2003
+++ linux-2.6.0-test1-relayfs-printk/kernel/Makefile	Sun Jul 13 22:32:59 2003
@@ -19,6 +19,7 @@ obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_DYNAMIC_PRINTK) += printk-dynamic.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urpN -X dontdiff linux-2.6.0-test1/kernel/printk-dynamic.c linux-2.6.0-test1-relayfs-printk/kernel/printk-dynamic.c
--- linux-2.6.0-test1/kernel/printk-dynamic.c	Wed Dec 31 18:00:00 1969
+++ linux-2.6.0-test1-relayfs-printk/kernel/printk-dynamic.c	Sun Jul 13 22:32:59 2003
@@ -0,0 +1,733 @@
+/*
+ *  linux/kernel/printk-dynamic.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ * Modified to make sys_syslog() more flexible: added commands to
+ * return the last 4k of kernel messages, regardless of whether
+ * they've been read or not.  Added option to suppress kernel printk's
+ * to the console.  Added hook for sending the console messages
+ * elsewhere, in preparation for a serial line console (someday).
+ * Ted Ts'o, 2/11/93.
+ * Modified for sysctl support, 1/8/97, Chris Horn.
+ * Fixed SMP synchronization, 08/08/99, Manfred Spraul 
+ *     manfreds@colorfullife.com
+ * Rewrote bits to get rid of console_lock
+ *	01Mar01 Andrew Morton <andrewm@uow.edu.au>
+ * This version uses relayfs to provide dynamic buffer sizing
+ *	09Jul03 Tom Zanussi <zanussi@us.ibm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/smp_lock.h>
+#include <linux/console.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/config.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/security.h>
+#include <linux/relayfs_fs.h>
+
+#include <asm/uaccess.h>
+
+/*
+ * MIN_LOG_BUF_LEN is the normal working size the dynamic buffer will
+ * try to maintain.  LOG_BUF_LEN becomes the size of the original static
+ * printk buffer, which will be used during init and then discarded.
+ */
+#define MIN_LOG_BUF_LEN	(1 << CONFIG_MIN_LOG_BUF_SHIFT)
+#define LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)
+#define LOG_BUF_MASK	(LOG_BUF_LEN-1)
+
+/* We still use these static printk variables and functions */
+extern void _printk(char *printk_buf, int printed_len);
+extern void release_console_sem_static(void);
+extern int do_syslog_static(int type, char * buf, int len);
+extern wait_queue_head_t log_wait;
+extern int oops_in_progress;
+extern struct semaphore console_sem;
+extern struct console *console_drivers;
+extern int console_may_schedule;
+
+/* Track the current buffer size */
+static int dyn_bufsize;			/* dynamic channel sub-buffer size */
+static int dyn_nbufs;			/* dynamic channel sub-buffer count */
+
+/* Resizing controls */
+static int resize_buf_size = 0;
+static int resize_n_bufs = 0;
+static int replace_pending = 0;
+static int needs_resize = 0;
+static int con_start_resized;
+static int log_start_resized;
+
+/* The dynamic channel and log buffer */
+static int dyn_channel;
+static char *dyn_logbuf;
+
+/* Offsets into dynamic printk buffer */
+static u32 dyn_log_start = 0;			/* Index into dyn_logbuf: next char to be read by syslog() */
+static u32 dyn_con_start = 0;			/* Index into dyn_logbuf: next char to be sent to consoles */
+static u32 dyn_logged_chars = 0;		/* Number of chars produced since last read+clear operation */
+
+/*
+ * logbuf_lock now protects the printk channel as well as dyn_log_start,
+ * dyn_con_start, and dyn_logged_chars.
+ * It is also still used in interesting ways to provide interlocking in
+ * release_console_sem().
+ */
+extern spinlock_t logbuf_lock;
+
+static int using_dynamic = 0;
+
+/*
+ * Commands to do_syslog:
+ *
+ * 	0 -- Close the log.  Currently a NOP.
+ * 	1 -- Open the log. Currently a NOP.
+ * 	2 -- Read from the log.
+ * 	3 -- Read all messages remaining in the ring buffer.
+ * 	4 -- Read and clear all messages remaining in the ring buffer
+ * 	5 -- Clear ring buffer.
+ * 	6 -- Disable printk's to console
+ * 	7 -- Enable printk's to console
+ *	8 -- Set level of messages printed to console
+ *	9 -- Return number of unread characters in the log buffer
+ */
+int do_syslog_dynamic(int type, char * buf, int len)
+{
+	unsigned long count;
+	int do_clear = 0;
+	int error = 0;
+	u32 new_dyn_log_start = 0;
+
+	error = security_syslog(type);
+	if (error)
+		return error;
+
+	switch (type) {
+	case 0:		/* Close log */
+		break;
+	case 1:		/* Open log */
+		break;
+	case 2:		/* Read from log */
+		error = -EINVAL;
+		if (!buf || len < 0)
+			goto out;
+		error = 0;
+		if (!len)
+			goto out;
+		error = verify_area(VERIFY_WRITE,buf,len);
+		if (error)
+			goto out;
+
+		error = relay_read(dyn_channel, buf, len, dyn_log_start, &new_dyn_log_start, 1);
+		if (error <= 0)
+			goto out;
+		relay_bytes_consumed(dyn_channel, error, dyn_log_start);
+		
+		spin_lock_irq(&logbuf_lock);
+		dyn_log_start = new_dyn_log_start;
+		spin_unlock_irq(&logbuf_lock);
+		break;
+	case 4:		/* Read/clear last kernel messages */
+		do_clear = 1; 
+		/* FALL THRU */
+	case 3:		/* Read last kernel messages */
+		error = -EINVAL;
+		if (!buf || len < 0)
+			goto out;
+		error = 0;
+		if (!len)
+			goto out;
+		error = verify_area(VERIFY_WRITE,buf,len);
+		if (error)
+			goto out;
+		count = len;
+		if (count > dyn_bufsize)
+			count = dyn_bufsize;
+		spin_lock_irq(&logbuf_lock);
+		if (count > dyn_logged_chars)
+			count = dyn_logged_chars;
+		if (do_clear)
+			dyn_logged_chars = 0;
+		if (count > 0) {
+			spin_unlock_irq(&logbuf_lock);
+			error = relay_read_last(dyn_channel, buf, count);
+			spin_lock_irq(&logbuf_lock);
+		}
+		spin_unlock_irq(&logbuf_lock);
+		break;
+	case 5:		/* Clear ring buffer */
+		dyn_logged_chars = 0;
+		break;
+	case 6:		/* Disable logging to console */
+		console_loglevel = minimum_console_loglevel;
+		break;
+	case 7:		/* Enable logging to console */
+		console_loglevel = default_console_loglevel;
+		break;
+	case 8:		/* Set level of messages printed to console */
+		error = -EINVAL;
+		if (len < 1 || len > 8)
+			goto out;
+		if (len < minimum_console_loglevel)
+			len = minimum_console_loglevel;
+		console_loglevel = len;
+		error = 0;
+		break;
+	case 9:		/* Number of chars in the log buffer */
+		error = relay_bytes_avail(dyn_channel, dyn_log_start);
+		break;
+	default:
+		error = -EINVAL;
+		break;
+	}
+out:
+	return error;
+}
+
+/*
+ * Shared by static and dynamic printk.  Dispatches to whichever is active.
+ */
+int do_syslog(int type, char * buf, int len)
+{
+	int error = 0;
+
+	if (using_dynamic)
+		error = do_syslog_dynamic(type, buf, len);
+	else
+		error = do_syslog_static(type, buf, len);
+
+	return error;
+}
+
+/*
+ * Call the console drivers on a range of log_buf
+ */
+static void __call_console_drivers_dynamic(unsigned long start, unsigned long end)
+{
+	struct console *con;
+
+	for (con = console_drivers; con; con = con->next) {
+		if ((con->flags & CON_ENABLED) && con->write)
+			con->write(con, dyn_logbuf + start, end - start);
+	}
+}
+
+/*
+ * Write out chars from start to end - 1 inclusive
+ */
+static void _call_console_drivers_dynamic(unsigned long start, unsigned long end, int msg_log_level)
+{
+	if (msg_log_level < console_loglevel && console_drivers && start != end) {
+		if (start > end) {
+			/* wrapped write */
+			__call_console_drivers_dynamic(start, dyn_bufsize);
+			__call_console_drivers_dynamic(0, end);
+		} else {
+			__call_console_drivers_dynamic(start, end);
+		}
+	}
+}
+
+/*
+ * Call the console drivers, asking them to write out
+ * printk_channel->buf[start] to printk_channel->buf[end - 1].
+ * The console_sem must be held.
+ */
+static void call_console_drivers_dynamic(unsigned long start, unsigned long end)
+{
+	unsigned long cur_index, start_print;
+	static int msg_level = -1;
+
+	cur_index = start;
+	start_print = start;
+
+	while (cur_index != end) {
+		if (	msg_level < 0 &&
+			((end - cur_index) > 2) &&
+			*(dyn_logbuf + cur_index + 0) == '<' &&
+			*(dyn_logbuf + cur_index + 1) >= '0' &&
+			*(dyn_logbuf + cur_index + 1) <= '7' &&
+			*(dyn_logbuf + cur_index + 2) == '>')
+		{
+			msg_level = *(dyn_logbuf + cur_index + 1) - '0';
+			cur_index += 3;
+			start_print = cur_index;
+		}
+		while (cur_index != end) {
+			char c = *(dyn_logbuf + cur_index);
+			cur_index++;
+
+			if (c == '\n') {
+				if (msg_level < 0) {
+					/*
+					 * printk() has already given us loglevel tags in
+					 * the buffer.  This code is here in case the
+					 * log buffer has wrapped right round and scribbled
+					 * on those tags
+					 */
+					msg_level = default_message_loglevel;
+				}
+				_call_console_drivers_dynamic(start_print, cur_index, msg_level);
+				msg_level = -1;
+				start_print = cur_index;
+				break;
+			}
+		}
+	}
+	_call_console_drivers_dynamic(start_print, end, msg_level);
+}
+
+/*
+ * Allocate a new channel buffer.  Must not be called with spinlocks held.
+ * If called from interrupt context, allocation happens on work queue.
+ */
+static void resize_buffer(int bufsize, int nbufs)
+{
+	int err;
+	
+	needs_resize = 0;
+	log_start_resized = 0;
+	con_start_resized = 0;
+	
+	err = relay_realloc_buffer(dyn_channel, bufsize, nbufs);
+}
+
+int printk_internal(const char *fmt, ...);
+
+/*
+ * Replace the current channel buffer with the newly allocated buffer.
+ * can be called in any context, but we need to make sure the channel isn't
+ * in use i.e. within logbuf lock.
+ */
+static void replace_buffer(void)
+{
+	int err;
+	struct rchan_info rchan_info;
+
+	err = relay_replace_buffer(dyn_channel);
+	if (!err) {
+		replace_pending = 0;
+
+		relay_info(dyn_channel, &rchan_info);
+		dyn_logbuf = rchan_info.buf_addr;
+
+		printk_internal("dynamic printk buffer resized to %d (%u x %u)\n", dyn_bufsize * dyn_nbufs, dyn_nbufs, dyn_bufsize);
+	}
+}
+
+/*
+ * Dynamic printk version of _printk()
+ */
+static void _printk_dynamic(char *printk_buf, int printed_len)
+{
+	char *p, *line;
+	static int log_level_unknown = 1;
+	int count = 0;
+
+	line = printk_buf + 3;
+
+	/*
+	 * Copy the output into log_buf.  If the caller didn't provide
+	 * appropriate log level tags, we insert them here
+	 */
+	for (p = line; *p; p++) {
+		if (log_level_unknown) {
+			if (p[0] != '<' || p[1] < '0' || p[1] > '7' || p[2] != '>') {
+				line -= 3;
+				line[0] = '<';
+				line[1] = default_message_loglevel + '0';
+				line[2] = '>';
+			}
+			log_level_unknown = 0;
+		}
+
+		if (*p == '\n') {
+			count = relay_write(dyn_channel, line, p - line + 1, -1);
+			dyn_logged_chars += count;
+			if (dyn_logged_chars > dyn_bufsize * dyn_nbufs)
+				dyn_logged_chars = dyn_bufsize * dyn_nbufs;
+			line = p + 1;
+			log_level_unknown = 1;
+		}
+	}
+
+	if (*(p-1) != '\n') {
+		count = relay_write(dyn_channel, line, p - line + 1, -1);
+		dyn_logged_chars += count;
+		if (dyn_logged_chars > dyn_bufsize * dyn_nbufs)
+			dyn_logged_chars = dyn_bufsize * dyn_nbufs;
+	}
+}
+
+/*
+ * This is printk.  It can be called from any context.  We want it to work.
+ * 
+ * We try to grab the console_sem.  If we succeed, it's easy - we log the output and
+ * call the console drivers.  If we fail to get the semaphore we place the output
+ * into the log buffer and return.  The current holder of the console_sem will
+ * notice the new output in release_console_sem() and will send it to the
+ * consoles before releasing the semaphore.
+ *
+ * One effect of this deferred printing is that code which calls printk() and
+ * then changes console_loglevel may break. This is because console_loglevel
+ * is inspected when the actual printing occurs.
+ *
+ * Shared by static and dynamic printk.  Dispatches to whichever is active.
+ */
+asmlinkage int printk(const char *fmt, ...)
+{
+	unsigned long flags;
+	va_list args;
+	int printed_len;
+	static char printk_buf[1024 + 3];
+
+	if (oops_in_progress) {
+		/* If a crash is occurring, make sure we can't deadlock */
+		spin_lock_init(&logbuf_lock);
+		/* And make sure that we print immediately */
+		init_MUTEX(&console_sem);
+	}
+
+	/* This stops the holder of console_sem just where we want him */
+	spin_lock_irqsave(&logbuf_lock, flags);
+
+	/* A new printk buffer was allocated, do the switchover now. */
+	if (replace_pending)
+		replace_buffer();
+
+	if (using_dynamic) {
+		/* Emit the output into the temporary buffer */
+		va_start(args, fmt);
+		printed_len = vsnprintf(printk_buf + 3, sizeof(printk_buf) - 3, fmt, args);
+		va_end(args);
+		_printk_dynamic(printk_buf, printed_len);
+	} else {
+		/* Emit the output into the temporary buffer */
+		va_start(args, fmt);
+		printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
+		va_end(args);
+		_printk(printk_buf, printed_len);		
+	}
+
+	if (!cpu_online(smp_processor_id())) {
+		/*
+		 * Some console drivers may assume that per-cpu resources have
+		 * been allocated.  So don't allow them to be called by this
+		 * CPU until it is officially up.  We shouldn't be calling into
+		 * random console drivers on a CPU which doesn't exist yet..
+		 */
+		spin_unlock_irqrestore(&logbuf_lock, flags);
+		goto out;
+	}
+	if (!down_trylock(&console_sem)) {
+		/*
+		 * We own the drivers.  We can drop the spinlock and let
+		 * release_console_sem() print the text
+		 */
+		spin_unlock_irqrestore(&logbuf_lock, flags);
+		console_may_schedule = 0;
+		release_console_sem();
+	} else {
+		/*
+		 * Someone else owns the drivers.  We drop the spinlock, which
+		 * allows the semaphore holder to proceed and to call the
+		 * console drivers with the output which we just produced.
+		 */
+		spin_unlock_irqrestore(&logbuf_lock, flags);
+	}
+
+out:
+	/* The printk buffer needs resizing, allocate it now */ 
+	if (needs_resize)
+		resize_buffer(resize_buf_size, resize_n_bufs);
+
+	return printed_len;
+}
+
+/*
+ * Dynamic printk version of release_console_sem()
+ */
+void release_console_sem_dynamic(void)
+{
+	unsigned long flags;
+	unsigned long _con_start, _log_end;
+	unsigned long wake_klogd = 0;
+	u32 new_dyn_con_start;
+	ssize_t bytes_avail;
+	
+	for ( ; ; ) {
+		bytes_avail = relay_read(dyn_channel, NULL, dyn_bufsize, dyn_con_start, &new_dyn_con_start, 0);
+		spin_lock_irqsave(&logbuf_lock, flags);
+		_con_start = dyn_con_start;
+		_log_end = dyn_con_start + bytes_avail;
+		wake_klogd = (unsigned long)bytes_avail;
+		
+		if (bytes_avail <= 0)
+			break;
+
+		dyn_con_start = new_dyn_con_start;
+
+		spin_unlock_irqrestore(&logbuf_lock, flags);
+		call_console_drivers_dynamic(_con_start, _log_end);
+	}
+	console_may_schedule = 0;
+	up(&console_sem);
+	spin_unlock_irqrestore(&logbuf_lock, flags);
+	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
+		wake_up_interruptible(&log_wait);
+}
+
+/**
+ * release_console_sem - unlock the console system
+ *
+ * Releases the semaphore which the caller holds on the console system
+ * and the console driver list.
+ *
+ * While the semaphore was held, console output may have been buffered
+ * by printk().  If this is the case, release_console_sem() emits
+ * the output prior to releasing the semaphore.
+ *
+ * If there is output waiting for klogd, we wake it up.
+ *
+ * release_console_sem() may be called from any context.
+ *
+ * Shared by static and dynamic printk.  Dispatches to whichever is active.
+ */
+void release_console_sem(void)
+{
+	if (using_dynamic)
+		release_console_sem_dynamic();
+	else
+		release_console_sem_static();
+}
+
+/*
+ * Offsets into a resized printk channel may have changed.
+ */
+static void printk_resize_offset(int rchan_id,
+				 u32 ge_offset,
+				 u32 le_offset,
+				 int delta)
+{
+	if (!log_start_resized &&
+	    dyn_log_start >= ge_offset &&
+	    dyn_log_start <= le_offset) {
+		dyn_log_start += delta;
+		log_start_resized = 1;
+	}
+	if (!con_start_resized &&
+	    dyn_con_start >= ge_offset &&
+	    dyn_con_start <= le_offset) {
+		dyn_con_start += delta;
+		con_start_resized = 1;
+	}
+}
+
+/*
+ * The printk channel needs to be resized or replaced.
+ */
+static void printk_buf_needs_resize(int rchan_id,
+				    int resize_type,
+				    u32 suggested_buf_size,
+				    u32 suggested_n_bufs)
+{
+	if (resize_type == RELAY_RESIZE_EXPAND || 
+	   resize_type == RELAY_RESIZE_SHRINK) {
+		resize_buf_size = suggested_buf_size;
+		resize_n_bufs = suggested_n_bufs;
+		needs_resize = 1;
+	} else if (resize_type == RELAY_RESIZE_REPLACED) {
+		dyn_bufsize = suggested_buf_size;
+		dyn_nbufs = suggested_n_bufs;
+		if (dyn_logged_chars > dyn_bufsize * dyn_nbufs)
+			dyn_logged_chars = dyn_bufsize * dyn_nbufs;
+	} else if (resize_type == RELAY_RESIZE_REPLACE)
+		replace_pending = 1;
+}
+
+/* relayfs channel callbacks */
+static struct rchan_callbacks printk_channel_callbacks = {
+	.buffer_start = NULL,
+	.buffer_end = NULL,
+	.deliver = NULL,
+	.buffers_full = NULL,
+	.needs_resize = printk_buf_needs_resize,
+	.resize_offset = printk_resize_offset
+};
+
+/* For copying static printk buf */
+extern char log_buf[];
+#define LOG_BUF(idx) (log_buf[(idx) & LOG_BUF_MASK])
+
+extern unsigned long log_start;
+extern unsigned long con_start;
+extern unsigned long log_end;
+extern unsigned long logged_chars;
+
+/*
+ * Figure out how big the initial dynamic printk channel should be and
+ * create it.  Returns handle to channel or err.
+ */
+static int __init create_printk_channel(void)
+{
+	u32 lockless_bufsize, lockless_nbufs, locking_bufsize, locking_nbufs;
+	u32 total_bufsize, resize_min;
+
+	u32 channel_flags = RELAY_DELIVERY_PACKET | RELAY_USAGE_GLOBAL;
+	channel_flags |= RELAY_SCHEME_ANY | RELAY_TIMESTAMP_ANY;
+	
+	lockless_bufsize = 8192; /* size of lockless scheme sub-buffers */
+	
+	if (logged_chars > LOG_BUF_LEN / 2)
+		lockless_nbufs = (LOG_BUF_LEN * 2) / lockless_bufsize;
+	else
+		lockless_nbufs = LOG_BUF_LEN / lockless_bufsize;
+	if (lockless_nbufs < 4)
+		lockless_nbufs = 4; /* minimum for lockless scheme is 4 */
+	else if (lockless_nbufs > RELAY_MAX_BUFS)
+		lockless_nbufs = RELAY_MAX_BUFS;
+
+	total_bufsize = lockless_nbufs * lockless_bufsize;
+	
+	locking_nbufs = 2; /* locking scheme can only use 2 sub-buffers*/
+	locking_bufsize = total_bufsize / locking_nbufs;
+	
+	resize_min = total_bufsize < MIN_LOG_BUF_LEN ? 
+		total_bufsize : MIN_LOG_BUF_LEN;
+
+	return relay_open("printk",
+			  lockless_bufsize,
+			  lockless_nbufs,
+			  locking_bufsize,
+			  locking_nbufs,
+			  channel_flags,
+			  &printk_channel_callbacks,
+			  0,
+			  0,
+			  0,
+			  resize_min,
+			  lockless_bufsize * RELAY_MAX_BUFS);
+}
+
+/*
+ * write count bytes of the static log buffer to the dynamic printk channel
+ */
+static int __init channel_write(int start, int count)
+{
+	int write_count = relay_write(dyn_channel, &LOG_BUF(start), count, -1);
+	dyn_logged_chars += write_count;
+	if (dyn_logged_chars > dyn_bufsize * dyn_nbufs)
+		dyn_logged_chars = dyn_bufsize * dyn_nbufs;
+
+	return write_count;
+}
+
+/*
+ * copy the initial static printk buffer to relayfs channel.
+ */
+static int __init copy_static_printk_buf(int start, int end, int space_left)
+{
+	int write_count, _log_index = start, _log_end = end;
+
+	if (space_left && (end - start > space_left)) {
+		write_count = channel_write(_log_index, space_left);
+		_log_index += space_left;
+	}
+	while (_log_index + dyn_bufsize < _log_end) {
+		write_count = channel_write(_log_index, dyn_bufsize);
+		_log_index += dyn_bufsize;
+	}
+	if (_log_end - _log_index)
+		write_count = channel_write(_log_index, _log_end - _log_index);
+	
+	return dyn_bufsize - (_log_end - _log_index);
+}
+
+/*
+ * Create the dynamic printk channel and copy the static printk buffer
+ * contents into it.  For the buffer copy, we assume log_start == 0 
+ * because syslog isn't alive yet.
+ */
+int __init register_printk_channel(void)
+{
+	unsigned long flags;
+	struct rchan_info rchan_info;
+	int copy_start, copy_end, space_left;
+	int wrapped = 0, err = 0;
+	
+	dyn_channel = create_printk_channel();
+	if (dyn_channel < 0) {
+		err = dyn_channel;
+		goto out;
+	}
+
+	spin_lock_irqsave(&logbuf_lock, flags);
+
+	if (logged_chars == LOG_BUF_LEN) {
+		wrapped = 1;
+		copy_start = log_end;
+		copy_end = LOG_BUF_LEN - copy_start;
+		space_left = copy_static_printk_buf(copy_start, copy_end, 0);
+
+		copy_start = 0;
+		copy_end = log_end;
+		copy_static_printk_buf(0, copy_end, space_left);
+	} else {
+		copy_start = 0;
+		copy_end = LOG_BUF_LEN > log_end ? log_end : LOG_BUF_LEN;
+		copy_static_printk_buf(copy_start, copy_end, 0);
+	}
+
+	dyn_con_start = con_start;
+
+	relay_info(dyn_channel, &rchan_info);
+	dyn_logbuf = rchan_info.buf_addr;
+
+	using_dynamic = 1;
+	
+	spin_unlock_irqrestore(&logbuf_lock, flags);
+
+	printk("Now using dynamic printk\n");
+	printk("Static printk buffer was %d bytes\n", LOG_BUF_LEN);
+	if (wrapped)
+		printk("Static printk buffer was too small for init messages - consider configuring it larger\n");
+	printk("Initial dynamic printk buffer is %u bytes (%u x %u)\n",
+	       rchan_info.buf_size * rchan_info.n_bufs, 
+	       rchan_info.n_bufs, rchan_info.buf_size);
+	printk("Minimum dynamic printk buffer is %u bytes\n", MIN_LOG_BUF_LEN);
+out:
+	return err;
+}
+
+/*
+ * Special printk for use internally within printk.
+ */
+int printk_internal(const char *fmt, ...)
+{
+	va_list args;
+	int printed_len = 0;
+	static char printk_buf[1024];
+	u32 cnt;
+
+	/* Emit the output into the temporary buffer */
+	va_start(args, fmt);
+	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
+	va_end(args);
+
+	cnt = relay_write(dyn_channel, printk_buf, printed_len, -1);
+	dyn_logged_chars += cnt;
+	if (dyn_logged_chars > dyn_bufsize * dyn_nbufs)
+		dyn_logged_chars = dyn_bufsize * dyn_nbufs;
+
+	return printed_len;
+}
+
+
diff -urpN -X dontdiff linux-2.6.0-test1/kernel/printk.c linux-2.6.0-test1-relayfs-printk/kernel/printk.c
--- linux-2.6.0-test1/kernel/printk.c	Sun Jul 13 22:39:24 2003
+++ linux-2.6.0-test1-relayfs-printk/kernel/printk.c	Sun Jul 13 22:32:59 2003
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <linux/security.h>
+#include <linux/printk-dynamic.h>
 
 #include <asm/uaccess.h>
 
@@ -58,7 +59,7 @@ int oops_in_progress;
  * provides serialisation for access to the entire console
  * driver system.
  */
-static DECLARE_MUTEX(console_sem);
+DECLARE_MUTEX(console_sem);
 struct console *console_drivers;
 
 /*
@@ -66,25 +67,26 @@ struct console *console_drivers;
  * It is also used in interesting ways to provide interlocking in
  * release_console_sem().
  */
-static spinlock_t logbuf_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t logbuf_lock = SPIN_LOCK_UNLOCKED;
+
+char log_buf[LOG_BUF_LEN] PRINTK_INITDATA;
 
-static char log_buf[LOG_BUF_LEN];
 #define LOG_BUF(idx) (log_buf[(idx) & LOG_BUF_MASK])
 
 /*
  * The indices into log_buf are not constrained to LOG_BUF_LEN - they
  * must be masked before subscripting
  */
-static unsigned long log_start;			/* Index into log_buf: next char to be read by syslog() */
-static unsigned long con_start;			/* Index into log_buf: next char to be sent to consoles */
-static unsigned long log_end;			/* Index into log_buf: most-recently-written-char + 1 */
-static unsigned long logged_chars;		/* Number of chars produced since last read+clear operation */
+unsigned long log_start;			/* Index into log_buf: next char to be read by syslog() */
+unsigned long con_start;			/* Index into log_buf: next char to be sent to consoles */
+unsigned long log_end;			/* Index into log_buf: most-recently-written-char + 1 */
+unsigned long logged_chars;		/* Number of chars produced since last read+clear operation */
 
 struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 static int preferred_console = -1;
 
 /* Flag: console code may call schedule() */
-static int console_may_schedule;
+int console_may_schedule;
 
 /*
  *	Setup a list of consoles. Called from init/main.c
@@ -155,7 +157,7 @@ __setup("console=", console_setup);
  *	8 -- Set level of messages printed to console
  *	9 -- Return number of unread characters in the log buffer
  */
-int do_syslog(int type, char __user * buf, int len)
+int DO_SYSLOG(int type, char __user * buf, int len)
 {
 	unsigned long i, j, limit, count;
 	int do_clear = 0;
@@ -289,7 +291,7 @@ asmlinkage long sys_syslog(int type, cha
 /*
  * Call the console drivers on a range of log_buf
  */
-static void __call_console_drivers(unsigned long start, unsigned long end)
+static void PRINTK_INIT __call_console_drivers(unsigned long start, unsigned long end)
 {
 	struct console *con;
 
@@ -302,7 +304,7 @@ static void __call_console_drivers(unsig
 /*
  * Write out chars from start to end - 1 inclusive
  */
-static void _call_console_drivers(unsigned long start, unsigned long end, int msg_log_level)
+static void PRINTK_INIT _call_console_drivers(unsigned long start, unsigned long end, int msg_log_level)
 {
 	if (msg_log_level < console_loglevel && console_drivers && start != end) {
 		if ((start & LOG_BUF_MASK) > (end & LOG_BUF_MASK)) {
@@ -320,7 +322,7 @@ static void _call_console_drivers(unsign
  * log_buf[start] to log_buf[end - 1].
  * The console_sem must be held.
  */
-static void call_console_drivers(unsigned long start, unsigned long end)
+static void PRINTK_INIT call_console_drivers(unsigned long start, unsigned long end)
 {
 	unsigned long cur_index, start_print;
 	static int msg_level = -1;
@@ -366,7 +368,7 @@ static void call_console_drivers(unsigne
 	_call_console_drivers(start_print, end, msg_level);
 }
 
-static void emit_log_char(char c)
+static void PRINTK_INIT emit_log_char(char c)
 {
 	LOG_BUF(log_end) = c;
 	log_end++;
@@ -391,30 +393,11 @@ static void emit_log_char(char c)
  * then changes console_loglevel may break. This is because console_loglevel
  * is inspected when the actual printing occurs.
  */
-asmlinkage int printk(const char *fmt, ...)
+void _PRINTK(char *printk_buf, int printed_len)
 {
-	va_list args;
-	unsigned long flags;
-	int printed_len;
 	char *p;
-	static char printk_buf[1024];
 	static int log_level_unknown = 1;
 
-	if (oops_in_progress) {
-		/* If a crash is occurring, make sure we can't deadlock */
-		spin_lock_init(&logbuf_lock);
-		/* And make sure that we print immediately */
-		init_MUTEX(&console_sem);
-	}
-
-	/* This stops the holder of console_sem just where we want him */
-	spin_lock_irqsave(&logbuf_lock, flags);
-
-	/* Emit the output into the temporary buffer */
-	va_start(args, fmt);
-	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
-	va_end(args);
-
 	/*
 	 * Copy the output into log_buf.  If the caller didn't provide
 	 * appropriate log level tags, we insert them here
@@ -432,6 +415,31 @@ asmlinkage int printk(const char *fmt, .
 		if (*p == '\n')
 			log_level_unknown = 1;
 	}
+}
+
+asmlinkage int PRINTK(const char *fmt, ...)
+{
+	va_list args;
+	unsigned long flags;
+	int printed_len;
+	static char printk_buf[1024];
+
+	if (oops_in_progress) {
+		/* If a crash is occurring, make sure we can't deadlock */
+		spin_lock_init(&logbuf_lock);
+		/* And make sure that we print immediately */
+		init_MUTEX(&console_sem);
+	}
+
+	/* This stops the holder of console_sem just where we want him */
+	spin_lock_irqsave(&logbuf_lock, flags);
+
+	/* Emit the output into the temporary buffer */
+	va_start(args, fmt);
+	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
+	va_end(args);
+
+	_printk(printk_buf, printed_len);
 
 	if (!cpu_online(smp_processor_id())) {
 		/*
@@ -460,6 +468,7 @@ asmlinkage int printk(const char *fmt, .
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 out:
+
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
@@ -495,7 +504,7 @@ EXPORT_SYMBOL(acquire_console_sem);
  *
  * release_console_sem() may be called from any context.
  */
-void release_console_sem(void)
+void RELEASE_CONSOLE_SEM(void)
 {
 	unsigned long flags;
 	unsigned long _con_start, _log_end;


-- 
Regards,

Tom Zanussi <zanussi@us.ibm.com>
IBM Linux Technology Center/RAS

