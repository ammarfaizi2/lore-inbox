Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTDKXbT (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTDKXbT (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:31:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:42114 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262563AbTDKX0c (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:26:32 -0400
Message-ID: <3E97518C.99A60D89@us.ibm.com>
Date: Fri, 11 Apr 2003 16:36:44 -0700
From: "Jim Keniston[UNIX]" <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
Content-Type: multipart/mixed;
 boundary="------------2267824871255DC9011DCA6B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2267824871255DC9011DCA6B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 2003-04-11 at 12:16, Alan Cox wrote:

> Providing the viewer is translating the originals always exist. Indeed
> you can do
> 
>         LANG=es view-logs
>         LANG=ru view-logs
>         ...
> 
> You can have sysadmins with no common language("not a recommended
> configuration" ;))
> 
> You are right about needing to log parameters, but given a log line
> of the form
> 
> %s: went up in flames\n\0eth0\0\0
> 
> that can be handled by the log viewer

Other contributors have also endorsed the idea of creating a message
log where the format and args are kept separate.  Here's code to do it.

Enclosed is a patch that adds support for logging kernel events to a
structured event log (see evlog.sourceforge.net).  When EVLOG_FWPRINTK
is enabled, printk messages are automatically forwarded to the event
log in this form.  (They are also logged to klogd/syslogd, as usual.)

The log viewer (evlview) can reconstruct the complete message from the
components.  If you provide translations (AKA formatting templates) for
particular messages, and set your LANG environment variable
appropriately,
evlview will display those messages in the selected language.  (Messages
without translations are displayed in English.)

A few more notes about this event-logging support:
- printk calls don't change; one line is added to printk(), about 20 to
printk.c.
- Like syslog, it also handles messages from user space.  There are also
a variety of other ways to use this support to log information from the
kernel.
- User-mode event logging requires no kernel support.
- There's a bunch of stuff that sysadmins and tech support people have
found useful, such as APIs for examining the log and receiving
notification
of events.

See evlog.sourceforge.net for more info.

Jim Keniston
IBM Linux Technology Center
--------------2267824871255DC9011DCA6B
Content-Type: text/plain; charset=us-ascii;
 name="evlog-1.5.2_kernel-2.5.67.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="evlog-1.5.2_kernel-2.5.67.patch"

diff -Naur linux.org/include/linux/evl_log.h linux.kernel.patched/include/linux/evl_log.h
--- linux.org/include/linux/evl_log.h	Wed Dec 31 16:00:00 1969
+++ linux.kernel.patched/include/linux/evl_log.h	Fri Apr 11 15:27:45 2003
@@ -0,0 +1,142 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2003
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+#ifndef _LINUX_EVL_LOG_H
+#define _LINUX_EVL_LOG_H
+
+#ifndef __KERNEL__
+#ifdef _POSIX_THREADS
+#include <pthread.h>
+#endif
+#endif
+
+/* Values for log_flags member */
+#define POSIX_LOG_TRUNCATE  0x1
+#define EVL_KERNEL_EVENT	0x2
+#define EVL_INITIAL_BOOT_EVENT 	0x4
+#define EVL_KERNTIME_LOCAL	0x8
+#define EVL_INTERRUPT		0x10	/* Logged from interrupt context */
+#define EVL_PRINTK		0x20	/* Logged by printk() */
+
+/* Formats for optional portion of record. */
+#define POSIX_LOG_NODATA    0
+#define POSIX_LOG_BINARY    1
+#define POSIX_LOG_STRING    2
+#define POSIX_LOG_PRINTF    3
+
+/* Maximum length of variable portion of record */
+#define POSIX_LOG_ENTRY_MAXLEN      (8 * 1024)
+
+/* Maximum length for a string returned by posix_log_memtostr */
+/* Thus also the max length of a facility name */
+#define POSIX_LOG_MEMSTR_MAXLEN	128
+
+typedef unsigned int posix_log_facility_t;
+typedef int posix_log_severity_t;
+typedef int posix_log_recid_t;
+typedef int posix_log_procid_t;
+
+#define EVL_INVALID_FACILITY ((posix_log_facility_t)-1)
+
+struct posix_log_entry {
+	unsigned int            log_magic;
+        posix_log_recid_t   	log_recid;
+        size_t          	log_size;
+        int             	log_format;
+        int             	log_event_type;
+        posix_log_facility_t 	log_facility;
+        posix_log_severity_t    log_severity;
+        uid_t           	log_uid;
+        gid_t           	log_gid;
+        pid_t           	log_pid;
+        pid_t           	log_pgrp;
+        struct timespec 	log_time;
+        unsigned int    	log_flags;
+#ifdef __KERNEL__
+        unsigned long int	log_thread;
+#else
+#ifdef _POSIX_THREADS
+	pthread_t		log_thread;
+#else
+	unsigned long int	log_thread;
+#endif
+#endif
+        posix_log_procid_t	log_processor;
+}; 
+
+typedef struct posix_log_entry rec_hdr_t;
+typedef struct evl_buf_rec {
+        struct posix_log_entry  rechdr;
+        char                    varbuf[1];
+} evl_buf_rec_t;
+
+
+#define LOGFILE_MAGIC   0xbeefface
+#define LOGREC_MAGIC    0xfeefface
+#define REC_HDR_SIZE    sizeof(struct posix_log_entry)
+
+/*
+ * Reserved Event Types
+ */
+#define EVL_SYSLOG_MESSAGE      0x1
+#define EVL_PRINTK_MESSAGE      0x2
+#define EVL_BUFFER_OVERRUN      0x6
+#define EVL_DUPS_DISCARDED      0x7
+
+#define LOG_LOGMGMT              (12<<3)	/* EVL Facility */
+
+#ifdef __KERNEL__
+/*
+ * Reserved Facilities
+ */
+#define LOG_KERN        (0<<3)  /* Kernel Facility */
+#define LOG_AUTHPRIV    (10<<3) /* security/authorization messages (private) */
+/*
+ * priorities (these are ordered)
+ */
+#define LOG_EMERG   0   /* system is unusable */
+#define LOG_ALERT   1   /* action must be taken immediately */
+#define LOG_CRIT    2   /* critical conditions */
+#define LOG_ERR     3   /* error conditions */
+#define LOG_WARNING 4   /* warning conditions */
+#define LOG_NOTICE  5   /* normal but significant condition */
+#define LOG_INFO    6   /* informational */
+#define LOG_DEBUG   7   /* debug-level messages */
+
+#ifdef CONFIG_EVLOG
+extern int posix_log_write(posix_log_facility_t facility, int event_type,
+         	posix_log_severity_t severity, const void *buf,
+        	size_t len, int format, unsigned int flags);
+#else	/* ! CONFIG_EVLOG */
+inline int posix_log_write(posix_log_facility_t facility, int event_type,
+		posix_log_severity_t severity, const void *buf,
+		size_t len, int format, unsigned int flags)
+		{ return -ENOSYS; }
+#endif	/* CONFIG_EVLOG */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_EVL_LOG_H */
diff -Naur linux.org/init/Kconfig linux.kernel.patched/init/Kconfig
--- linux.org/init/Kconfig	Fri Apr 11 15:27:45 2003
+++ linux.kernel.patched/init/Kconfig	Fri Apr 11 15:27:45 2003
@@ -92,6 +92,35 @@
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.
 
+config EVLOG
+	bool "Enterprise event logging support"
+	help
+	  This enables support for enterprise-level event logging based
+	  upon the draft POSIX 1003.25 standard.  Enabling this feature
+	  does not affect the operation of the sysklogd package in any
+	  way.  In order to fully utilize this feature, user must also
+	  install the companion evlog package in user-space.
+
+	  For more information see http://evlog.sourceforge.net
+
+	  If you don't know what to do here, say N.
+
+config EVLOG_BUFSIZE
+	int "Event log buffer size (in Kbytes)"
+	depends on EVLOG
+	default "128"
+	help
+	  Event log buffer size in Kbytes. Default size is 128 Kbytes.
+
+config EVLOG_FWPRINTK
+	bool "Forward printk messages to enterprise event log"
+	depends on EVLOG
+	help
+	  This option forwards printk log messages to the enterprise event
+	  log.  Printk messages are still logged to /var/log/messages.
+
+	  If you don't know what to do here, say N.
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size" if DEBUG_KERNEL
 	default 17 if ARCH_S390
diff -Naur linux.org/kernel/Makefile linux.kernel.patched/kernel/Makefile
--- linux.org/kernel/Makefile	Fri Apr 11 15:27:45 2003
+++ linux.kernel.patched/kernel/Makefile	Fri Apr 11 15:27:45 2003
@@ -18,6 +18,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_EVLOG) += evlog.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Naur linux.org/kernel/evlog.c linux.kernel.patched/kernel/evlog.c
--- linux.org/kernel/evlog.c	Wed Dec 31 16:00:00 1969
+++ linux.kernel.patched/kernel/evlog.c	Fri Apr 11 15:27:45 2003
@@ -0,0 +1,933 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2003
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ *  Please send e-mail to lkessler@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ *
+ */
+
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/spinlock.h>
+#include <linux/time.h>
+#include <linux/smp.h>
+#include <linux/sched.h>
+#include <linux/ptrace.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <asm/uaccess.h>
+#include <asm/semaphore.h>
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/nls.h>
+#include <linux/ctype.h>
+#include <linux/console.h>
+#include <linux/smp_lock.h>
+#include <linux/crc32.h>
+
+#ifdef __i386__
+#include <asm/fixmap.h>
+#include <asm/mpspec.h>
+#include <asm/io_apic.h>
+#include <asm/apic.h>
+#endif
+
+#include <asm/bitops.h>
+#include <asm/smp.h>
+
+#include <linux/evl_log.h>
+
+
+static void mk_rec_header(struct posix_log_entry *rechdr,
+	posix_log_facility_t facility, int event_type,
+	posix_log_severity_t severity, size_t recsize,
+	uint recflags, int format);
+
+extern struct timezone sys_tz;
+
+#define EVL_BUF_SIZE (CONFIG_EVLOG_BUFSIZE * 1024)   /* EVL buffer size */
+#define EVL_BUF_FREESPACE (64*1024U) /* max free space reqd after buff */
+				    /* overrun to start writing events again. */
+
+/*
+ * This data structure describes the circular buffer that is written into
+ * by evl_kwrite_buf() and drained by evl_kbufread().
+ *
+ * bf_buf, bf_len, and bf_end are the start, length, and end of the buffer,
+ * and in the current implementation these remain constant.
+ *
+ * bf_tail advances as event records are logged to the buffer, and bf_head
+ * advances as records are drained from the buffer.  bf_curr is used
+ * internally by certain functions.  bf_dropped maintains a count of
+ * records that have been dropped due to buffer overrun.
+ */
+struct cbuf {
+	unsigned char	*bf_buf;	/* base buffer address */
+	unsigned int	bf_len;		/* buffer length */
+	unsigned int	bf_dropped;	/* (internal) dropped count */
+	unsigned char	*bf_head;	/* head-pointer for circ. buf */
+	unsigned char	*bf_tail;	/* tail-pointer for circ. buf */
+	unsigned char	*bf_curr;	/* (internal) current write ptr */
+	unsigned char	*bf_end;	/* end buffer address */
+};
+ 
+static unsigned char evl_buffer[EVL_BUF_SIZE + sizeof(long)];
+
+static struct cbuf evl_ebuf = {
+	evl_buffer,
+	EVL_BUF_SIZE,
+	0,
+	evl_buffer,
+	evl_buffer, 
+	evl_buffer,
+	evl_buffer + EVL_BUF_SIZE
+};
+
+/*
+ * This is for the serialisation of reads from the kernel buffer.
+ */
+static DECLARE_MUTEX(evl_read_sem);
+DECLARE_WAIT_QUEUE_HEAD(readq);
+spinlock_t ebuf_lock = SPIN_LOCK_UNLOCKED;
+
+/*
+ * FUNCTION     : cbufwrap
+ * Caller wants to write a chunk of size len bytes into the buffer starting at
+ * bf_curr.  If bf_curr is near the end of the buffer, then we may have to
+ * split the chunk so that some of it appears at the end of the buffer and
+ * the rest appears at the beginning.  dont_split_hdr=1 means the chunk is
+ * an entire record, and we're not allowed to split the record's header --
+ * we may have to leave unused space at the end of the buffer and start the
+ * record at the beginning.
+ *
+ * Return the location where the chunk should start, or NULL if there's
+ * no room for it (i.e., it would overrun the buffer's head pointer).
+ *
+ * ARGUMENTS    : bf_curr - where caller wants to put record
+ *              : len - total record size
+ *              : dont_split_hdr - 0 if it's OK to split the header, else 1
+ *
+ * RETURN       : where the record should be put, or NULL if no room
+ */
+static unsigned char *
+cbufwrap(unsigned char *bf_curr, size_t len, int dont_split_hdr)
+{
+	unsigned char *head, *end;
+	unsigned char *wrapbuf = bf_curr;
+
+	end = bf_curr + len;
+	head = evl_ebuf.bf_head;
+
+	if (bf_curr < head && end >= head) {
+		/* Insufficient free space in buffer; drop record. */
+		return NULL;
+	}
+	if (end > evl_ebuf.bf_end) {
+		/* end would be of end of buffer */
+		if (dont_split_hdr
+		    && bf_curr + REC_HDR_SIZE > evl_ebuf.bf_end) {
+			/* Start record at start of buffer. */
+			wrapbuf = evl_ebuf.bf_buf;
+		} else {
+			/* Split record */
+			len -= evl_ebuf.bf_end - bf_curr;
+		}
+
+		end = evl_ebuf.bf_buf + len;
+		if (end >= head) {
+			/* Insufficient free space in buffer; drop record. */
+			return NULL;
+		}
+	}
+	return wrapbuf;
+}
+
+/*
+ * FUNCTION     : cbufwrite
+ * Copy the len bytes starting at s into the buffer starting at bufp,
+ * splitting the data if we run off the end of the buffer.
+ *
+ * ARGUMENTS    : The pointer in cbuf to write at,
+ *                the buffer to write,
+ *                the number of bytes to write
+ * RETURN       : The pointer in cbuf at the end of the copied data
+ * NOTE
+ *      bf_head is owned by the drainer. bf_curr is allowed to be equal to
+ *      bf_head only when buffer is empty indicated by drainer. It is never
+ *      set to be equal by writer.
+ */
+static unsigned char *
+cbufwrite(unsigned char *bufp, unsigned char *s, size_t len)
+{
+	unsigned char *e;
+	size_t n, lw;
+
+	e = bufp + len;
+	n = len;
+
+	if (e > evl_ebuf.bf_end) {
+		lw = evl_ebuf.bf_end - bufp;
+		n -= lw;
+		e = evl_ebuf.bf_buf + n;
+		memcpy(bufp, s, lw);
+		memcpy(evl_ebuf.bf_buf, s + lw, n);
+		return e;
+	} else {
+		memcpy(bufp, s, n);
+		return (e == evl_ebuf.bf_end) ? evl_ebuf.bf_buf : e;
+	}
+}
+
+/*
+ * FUNCTION     : cbufptr
+ * Return cbuf_ptr + offset, taking possible wraparound into account.
+ *
+ * ARGUMENTS    : starting pointer in cbuf,
+ *                offset in bytes from pointer
+ * RETURN       : The pointer in circular buf that is offset bytes from
+ *                starting pointer.
+ */
+static unsigned char *
+cbufptr(unsigned char *cbuf_ptr, size_t offset)
+{
+	unsigned char *e;
+	size_t lw;
+
+	e = cbuf_ptr + offset;
+	if (e >= evl_ebuf.bf_end) {
+		lw = evl_ebuf.bf_end - cbuf_ptr;
+		e = evl_ebuf.bf_buf + (offset - lw);
+	}
+	return e;
+}
+
+/*
+ * FUNCTION     : copy_data_to_cbuf
+ * Copies the indicated record into the buffer at evl_ebuf.bf_curr.
+ * Assumes we've previously verified that the header won't be split.
+ * Updates evl_ebuf.bf_curr to point past the record just copied in.
+ *
+ * ARGUMENTS    : Record header
+ *                pointer to variable data
+ */
+static int
+copy_data_to_cbuf(struct posix_log_entry *rhdr, unsigned char *vbuf)
+{
+	memcpy(evl_ebuf.bf_curr, rhdr, REC_HDR_SIZE);
+	evl_ebuf.bf_curr += REC_HDR_SIZE;
+
+	if (rhdr->log_size > 0) {
+		evl_ebuf.bf_curr = 
+			cbufwrite(evl_ebuf.bf_curr, vbuf, rhdr->log_size);
+	}
+	
+	return 0;
+}
+
+/*
+ * EVL circular buffer had been full and caused later messages to be
+ * dropped. Now the buffer has space.  (Still it is better to identify the
+ * cause so it doesn't repeat. The buffer gets full if the rate of incoming
+ * messages is much higher than can be drained. This could happen if messages
+ * are repeated at an excessively high rate or the daemon in user-space is
+ * not running.)
+ *
+ * Now that we can log events again, log one giving the number of events
+ * dropped.
+ */
+static int
+log_dropped_recs_event(void)
+{
+	unsigned char sbuf[255];
+	struct posix_log_entry drechdr;
+	size_t vbuflen;
+	unsigned char *oldcur = evl_ebuf.bf_curr;
+
+	snprintf(sbuf, sizeof(sbuf), "%d event records dropped due to EVL buffer overflow.", 
+		evl_ebuf.bf_dropped);
+	evl_ebuf.bf_dropped = 0;
+	vbuflen = strlen(sbuf) + 1;
+	mk_rec_header(&drechdr, LOG_KERN, EVL_BUFFER_OVERRUN, LOG_INFO,
+		vbuflen, 0, POSIX_LOG_STRING);
+	evl_ebuf.bf_curr = cbufwrap(evl_ebuf.bf_curr, REC_HDR_SIZE+vbuflen, 1);
+	if (evl_ebuf.bf_curr != (unsigned char *)NULL) {
+		copy_data_to_cbuf(&drechdr, sbuf);
+		return 0;
+	} else {
+		/*
+		 * This shouldn't happen, since EVL_BUF_FREESPACE is much
+		 * bigger than the event we're logging here.
+		 */
+		evl_ebuf.bf_curr = oldcur;
+		return -1;
+	}
+}
+
+/*
+ * FUNCTION     : evl_check_buf
+ * ARGUMENTS    : NONE
+ * RETURN       : -1 for failure, ie. insufficient buffer space
+ *                 0 for success
+ * If buffer free space is greater than the applicable water-mark,
+ * returns 0.  If not, return -1.  Sets evl_buf.bf_curr to the location
+ * where the next record should go.
+ *
+ * Once the high water mark is hit and failure is returned (discarded
+ * messages) it sets a substantial low water mark before permitting
+ * messages to be buffered again.  It counts the number of discards
+ * in the meantime and reports them when restarted.  If the water
+ * marks were equivalent, then there could be a thrashing of stops
+ * and starts, making the discarded message reporting annoying.
+ *
+ */
+static int
+evl_check_buf(void)
+{
+	unsigned char *head, *tail;
+	size_t water_mark, avail;
+
+	head    = evl_ebuf.bf_head;
+	tail	= evl_ebuf.bf_tail;
+	avail   = (head <= tail) ?
+	      (evl_ebuf.bf_len - (tail - head)) :
+	      (head - tail);
+
+	if (evl_ebuf.bf_dropped != 0) {
+		/*
+		 * Still recovering from buffer overflow.
+		 * Apply the low water mark.
+		 */
+		water_mark = min(EVL_BUF_FREESPACE, evl_ebuf.bf_len / 2);
+	} else {
+		water_mark = REC_HDR_SIZE;
+	}
+
+	if (avail < water_mark) {
+		return -1;
+	}
+
+	/* There's enough free buffer space.  Return success. */
+	evl_ebuf.bf_curr = tail;
+	if (evl_ebuf.bf_dropped != 0) {
+		return log_dropped_recs_event();
+	}
+	return 0;
+}
+
+/*
+ * FUNCTION     : evl_getnext_rec
+ * ARGUMENTS    : rec is a pointer to the log event record.
+ *                The next record pointer mustn't be beyond tail.
+ * RETURN       : This function returns a pointer to the place to start the
+ *                next record in the circular buffer.  As a special case,
+ *                if rec is NULL, then the location of the first record at
+ *                or after bf_head is returned; else the record following
+ *                rec is returned.
+ */
+static unsigned char *
+evl_getnext_rec(unsigned char *rec, size_t recsize, unsigned char *tail)
+{
+	if (rec == NULL) {
+		rec = evl_ebuf.bf_head;
+	} else {
+		rec = cbufptr(rec, recsize);
+	}
+
+	if (rec == tail) {
+		return rec;
+	}
+
+	/* Check for wrap. */
+	if ((rec + REC_HDR_SIZE) > evl_ebuf.bf_end) {
+		rec = evl_ebuf.bf_buf;
+	}
+	return rec;
+}
+
+/*
+ * FUNCTION     : evl_kbufread - Used to read event records from the EVL
+ *                circular buffer.
+ * ARGUMENTS    : retbuf is a pointer to the buffer to be filled with the
+ *                event records.
+ *              : bufsize is length of the buffer allocated by the user.
+ * RETURN       : Number of bytes copied if read is successful, else -ve value.
+ *                event record and data to buffer.
+ */
+
+int
+evl_kbufread(unsigned char *retbuf, size_t bufsize)
+{
+	unsigned char *rec;
+	size_t rec_size;
+	int error = 0;
+	int retbuflen = 0;
+	unsigned char *tail, *buf = retbuf;
+
+	/*
+	 * the read request size must be at least rec_hdr_t size
+	 */
+	if (bufsize < REC_HDR_SIZE) {
+		return -EINVAL;
+	}
+	/* 
+	 * Serialize all reads, just in case someone got sneaky 
+	 */
+	error = down_interruptible(&evl_read_sem);
+	if (error == -EINTR) {
+		return -EINTR;
+	}
+	/*
+	 * Go to sleep if the buffer is empty.
+	 */
+	error = wait_event_interruptible(readq, 
+		(evl_ebuf.bf_head != evl_ebuf.bf_tail));
+	if (error) {
+		up(&evl_read_sem);
+		return error;
+	}
+	/*
+	 * Assemble message(s) into the user buffer, as many as will
+	 * fit.  On running out of space in the buffer, try to copy
+	 * the header for the overflowing message.  This means that
+	 * there will always be at least a header returned.  The caller
+	 * must compare the numbers of bytes returned (remaining) with
+	 * the length of the message to see if the entire message is
+	 * present.  A subsequent read will get the entire message,
+	 * including the header (again).
+	 */
+	tail = evl_ebuf.bf_tail;
+	rec = evl_getnext_rec(NULL, 0, tail);	/* typically evl_ebuf.bf_head */
+	if (rec == NULL) { 
+		/* Should not happen. Buffer must have atleast one record. */
+		error = -EFAULT;
+		goto out;
+	}
+
+	do {
+#if defined(__ia64__)
+		evl_buf_rec_t record;
+		memcpy(&record, rec, sizeof(evl_buf_rec_t));
+		rec_size = REC_HDR_SIZE + record.rechdr.log_size;
+#else
+		evl_buf_rec_t *p_rec;
+		p_rec = (evl_buf_rec_t *) rec;
+		rec_size = REC_HDR_SIZE + p_rec->rechdr.log_size;
+#endif
+
+		if (bufsize < REC_HDR_SIZE) {
+			/* user buffer is smaller than header */
+			break;
+		}
+		if (bufsize < rec_size) {
+			/* 
+			 * Copyout only the header 'cause user buffer can't
+			 * hold full record.
+			 */
+			error = copy_to_user(buf, rec, REC_HDR_SIZE);
+			if (error) {
+				error = -EFAULT;
+				break;
+			}
+			bufsize -= REC_HDR_SIZE;
+			retbuflen += REC_HDR_SIZE;
+			break;
+		}
+		if ((rec + rec_size) > evl_ebuf.bf_end) {
+			size_t lw = evl_ebuf.bf_end - rec;
+			error = copy_to_user(buf, rec, lw);
+			if (!error) {
+				error = copy_to_user(buf + lw, evl_ebuf.bf_buf, 
+					rec_size - lw); 
+			}
+		} else {
+			error = copy_to_user(buf, rec, rec_size);
+		}
+		if (error) {
+			error = -EFAULT;
+			break;
+		}
+		rec = evl_getnext_rec(rec, rec_size, tail);
+		buf += rec_size;
+		bufsize -= rec_size;
+		retbuflen += rec_size;
+	} while (rec != tail);
+
+	if (error == 0) {
+		evl_ebuf.bf_head = rec;
+		error = retbuflen;
+	}
+
+out:
+	up(&evl_read_sem);
+	return(error);
+}
+
+/*
+ * FUNCTION	: kwrite_buf
+ * Called by evl_kwrite_buf() to write to the buffer the event record
+ * consisting of rec_hdr and vardata.
+ *
+ * RETURN	: 0 on success, -ENOSPC on failure
+ *		On success evl_ebuf.bf_curr is updated to point just past
+ *		the event we just wrote to the buffer.
+ */
+static int
+kwrite_buf(struct posix_log_entry *rec_hdr, unsigned char *vardata)
+{
+	size_t recsize;
+	unsigned char *rec;
+	if (rec_hdr->log_size > POSIX_LOG_ENTRY_MAXLEN) {
+		rec_hdr->log_size = POSIX_LOG_ENTRY_MAXLEN;
+		rec_hdr->log_flags |= POSIX_LOG_TRUNCATE;
+	}
+	recsize = REC_HDR_SIZE + rec_hdr->log_size;
+	rec = cbufwrap(evl_ebuf.bf_curr, recsize, 1);
+	if (rec == (unsigned char *)NULL) {
+		return -ENOSPC;
+	}
+
+	evl_ebuf.bf_curr = rec;
+	copy_data_to_cbuf(rec_hdr, vardata);
+
+	/*
+	 * If the variable data is a truncated string, make sure it
+	 * ends with a null character.
+	 */
+	if ((rec_hdr->log_flags & POSIX_LOG_TRUNCATE) &&
+	    rec_hdr->log_format == POSIX_LOG_STRING) {
+		if (evl_ebuf.bf_curr == evl_ebuf.bf_buf) {
+			*(evl_ebuf.bf_end - 1) = '\0';
+		} else {
+			*(evl_ebuf.bf_curr - 1) = '\0';
+		}
+	}
+	return 0;
+}
+
+/*
+ * FUNCTION     : evl_kwrite_buf - Used to write kernel level messages.
+ * RETURN       : 0 if writing to buffer is successful, else -errno.
+ */
+
+static int
+evl_kwrite_buf(posix_log_facility_t    fac,
+		int                    ev_type,
+		posix_log_severity_t   sev,
+		int                    format,
+		unsigned char          *recbuf,
+		uint                   var_rec_len,
+		uint                   flags) 
+{
+	uint recflags = flags;
+	struct posix_log_entry rec_hdr;
+	int error = 0;
+	unsigned char *oldtail = evl_ebuf.bf_tail;
+		/* Used to wake the read call if it sleeps */ 
+	long iflags;	/* for spin_lock_irqsave() */
+
+	if (sev > LOG_DEBUG) {
+		return -EINVAL;
+	}
+	
+	recflags |= EVL_KERNEL_EVENT;   /* kernel mesagge */    
+	if (in_interrupt()) {
+		recflags |= EVL_INTERRUPT;
+	}
+	mk_rec_header(&rec_hdr, fac, ev_type, sev, var_rec_len, recflags,
+		format);
+	
+	spin_lock_irqsave(&ebuf_lock, iflags);
+	if (evl_check_buf() < 0) {
+		evl_ebuf.bf_dropped++;
+		spin_unlock_irqrestore(&ebuf_lock, iflags);
+		return -ENOSPC;
+	}
+
+	error = kwrite_buf(&rec_hdr, recbuf);
+
+	if (error == 0) {
+		evl_ebuf.bf_tail = evl_ebuf.bf_curr;
+		if ((evl_ebuf.bf_head == oldtail) &&
+		    (evl_ebuf.bf_head != evl_ebuf.bf_tail)) {
+			wake_up_interruptible(&readq);
+		}
+	} else if (error == -ENOSPC) {        
+		evl_ebuf.bf_dropped++;
+	}
+	spin_unlock_irqrestore(&ebuf_lock, iflags);
+	return error;
+}
+
+/*
+ *      This is the standard POSIX function for writing events to the event log, *      See event logging specification at:
+ *      http://evlog.sourceforge.net/linuxEvlog.html
+ */
+int posix_log_write(posix_log_facility_t facility, int event_type,
+                posix_log_severity_t severity, const void *buf,
+                size_t recsize, int format, unsigned int flags)
+{
+        int ret = 0;
+
+        if ((buf == (void *)NULL) && (recsize > 0)) {
+                return -EINVAL;
+        }
+        if (recsize == 0 && format != POSIX_LOG_NODATA) {
+                return -EINVAL;
+        }
+        if (format == POSIX_LOG_STRING) {
+                if (strlen((const char*)buf) != recsize-1) {
+                        return -EBADMSG;
+                }
+        }
+
+        ret = evl_kwrite_buf(facility, event_type, severity, format,
+                                (char *)buf, recsize, flags);
+
+        return ret;
+}
+
+/*
+ * buf is a buffer of size POSIX_LOG_ENTRY_MAXLEN.  It currently contains
+ * *reclen bytes.  Append as much of data to buf as will fit.  Set *reclen
+ * to what the updated size would be if buf were big enough.
+ */
+void
+evl_append_to_buf(char *buf, size_t *reclen, const void *data, size_t datasz)
+{
+        int copysz = (int) datasz;
+        int room = (int) POSIX_LOG_ENTRY_MAXLEN - (int) *reclen;
+        if (room > 0) {
+                if (copysz > room) {
+                        copysz = room;
+                }
+                (void) memcpy(buf + *reclen, data, copysz);
+        }
+        *reclen += datasz;
+}
+
+/*
+ * Append a string to the buffer.  If null == 1, we include the terminating
+ * null.  If the string extends over the end of the buffer, terminate the
+ * buffer with a null.
+ */
+void
+evl_append_string_to_buf(char *buf, size_t *reclen, const char *s, int null)
+{
+        size_t old_reclen = *reclen;
+        evl_append_to_buf(buf, reclen, s, strlen(s) + null);
+        if (*reclen > POSIX_LOG_ENTRY_MAXLEN
+            && old_reclen < POSIX_LOG_ENTRY_MAXLEN) {
+                buf[POSIX_LOG_ENTRY_MAXLEN-1] = '\0';
+        }
+}
+
+/*
+ * Note: This function is derived from vsnprintf() (see * lib/vsprintf.c),
+ * and should be kept in sync with that function.
+ */
+
+static int skip_atoi(const char **s)
+{
+        int i=0;
+
+        while (isdigit(**s))
+                i = i*10 + *((*s)++) - '0';
+        return i;
+}
+
+/*
+ * fmt points to the '%' in a printk conversion specification.  Advance
+ * fmt past any flags, width and/or precision specifiers, and qualifiers
+ * such as 'l' and 'L'.  Return a pointer to the conversion character.
+ * Stores the qualifier character (or -1, if there is none) at *pqualifier.
+ * *wp is set to flags indicating whether the width and/or precision are '*'.
+ * For example, given
+ *      %*.2lx
+ * *pqualifier is set to 'l', *wp is set to 0x1, and a pointer to the 'x'
+ * is returned.
+ *
+ * Note: This function is derived from vsnprintf() (see * lib/vsprintf.c),
+ * and should be kept in sync with that function.
+ */
+const char *
+parse_printf_fmt(const char *fmt, int *pqualifier, int *wp)
+{
+        int qualifier = -1;
+        *wp = 0;
+
+        /* process flags */
+        repeat:
+                ++fmt;          /* this also skips first '%' */
+                switch (*fmt) {
+                        case '-':
+                        case '+':
+                        case ' ':
+                        case '#':
+                        case '0':
+                                goto repeat;
+                }
+
+        /* get field width */
+        if (isdigit(*fmt))
+                skip_atoi(&fmt);
+        else if (*fmt == '*') {
+                ++fmt;
+                /* it's the next argument */
+                *wp |= 0x1;
+        }
+
+        /* get the precision */
+        if (*fmt == '.') {
+                ++fmt;
+                if (isdigit(*fmt))
+                        skip_atoi(&fmt);
+                else if (*fmt == '*') {
+                        ++fmt;
+                        /* it's the next argument */
+                        *wp |= 0x2;
+                }
+        }
+
+        /* get the conversion qualifier */
+        if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' || *fmt =='Z') {
+                qualifier = *fmt;
+                ++fmt;
+                if (qualifier == 'l' && *fmt == 'l') {
+                        qualifier = 'L';
+                        ++fmt;
+                }
+        }
+
+        *pqualifier = qualifier;
+        return fmt;
+}
+
+static void
+pack_args(char *buf, size_t *reclen, const char *fmt, va_list args)
+{
+#define COPYARG(type) { type v=va_arg(args,type); evl_append_to_buf(buf,reclen,&v,sizeof(v)); }
+	const char *s;
+	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
+	                    /* 'z' support added 23/7/1999 S.H.    */
+	                    /* 'z' changed to 'Z' --davidm 1/25/99 */
+
+	for (; *fmt ; ++fmt) {
+		int wp = 0x0;
+		if (*fmt != '%') {
+			continue;
+		}
+
+		fmt = parse_printf_fmt(fmt, &qualifier, &wp);
+		if (wp & 0x1) {
+			/* width is '*' (next arg) */
+			COPYARG(int)
+		}
+		if (wp & 0x2) {
+			/* ditto precision */
+			COPYARG(int)
+		}
+
+		switch (*fmt) {
+			case 'c':
+				COPYARG(int)
+				continue;
+
+			case 's':
+				s = va_arg(args, char *);
+				evl_append_string_to_buf(buf, reclen, s, 1);
+				continue;
+
+			case 'p':
+				COPYARG(void*)
+				continue;
+
+			case 'n':
+				/* Skip over the %n arg. */
+				if (qualifier == 'l') {
+					(void) va_arg(args, long *);
+				} else if (qualifier == 'Z') {
+					(void) va_arg(args, size_t *);
+				} else {
+					(void) va_arg(args, int *);
+				}
+				continue;
+
+			case '%':
+				continue;
+
+				/* integer number formats - handle outside switch */
+			case 'o':
+			case 'X':
+			case 'x':
+			case 'd':
+			case 'i':
+			case 'u':
+				break;
+
+			default:
+				/* Bogus conversion.  Pass thru unchanged. */
+				if (*fmt == '\0')
+					--fmt;
+				continue;
+		}
+		if (qualifier == 'L') {
+			COPYARG(long long)
+		} else if (qualifier == 'l') {
+			COPYARG(long)
+		} else if (qualifier == 'Z') {
+			COPYARG(size_t)
+		} else if (qualifier == 'h') {
+			COPYARG(int)
+		} else {
+			COPYARG(int)
+		}
+	}
+}
+
+/*
+ * These buffers are currently used only by evl_fwd_printk(), and hence
+ * are protected by printk's logbuf_lock.  They're too big to be auto
+ * variables in evl_fwd_printk().
+ */
+static char prtk_argbuf[POSIX_LOG_ENTRY_MAXLEN];
+static size_t argbuf_idx;
+static char prtk_msgbuf[POSIX_LOG_ENTRY_MAXLEN + 1];
+static int msgbuf_idx = 0;
+/*
+ * msg is the message obtained by applying vsnprintf() to
+ * fmt and args.  (Caller does this anyway, so we don't have to.)
+ * Create and log a PRINTF-format event record whose contents are:
+ *	format string (possibly concatenated from multiple segments)
+ *	int containing args size
+ *	args
+ *	return address
+ *
+ * We consult msg only to determine the severity (e.g., "<1>") and whether
+ * we have a terminating newline.  If this message segment doesn't end
+ * in a newline, we save the fmt and args for concatenation with the next
+ * printk.
+ *
+ */
+int
+evl_fwd_printk(const char *fmt, va_list args, const char *msg)
+{
+	static int sev = -1;
+	int event_type;
+	int ret = 0;
+	int argsz;
+	int msglen = strlen(msg);
+	int last_segment = (msglen > 0 && msg[msglen-1] == '\n');
+
+	if (sev == -1) {
+		/* Severity not yet defined.  Must be a new message. */
+		sev = LOG_NOTICE;
+		if (msg[0] == '<'
+		    && msg[1] >= '0' && msg[1] <= '7'
+		    && msg[2] == '>') {
+			sev = msg[1] - '0';
+		}
+		msgbuf_idx = 0;
+		argbuf_idx = 0;
+	}
+
+	evl_append_string_to_buf(prtk_msgbuf, &msgbuf_idx, fmt, 0);
+	pack_args(prtk_argbuf, &argbuf_idx, fmt, args);
+	if (!last_segment) {
+		return 0;
+	}
+
+	/*
+	 * Message completed.  Change the terminating newline to a null.
+	 * We remove the terminating newline to increase flexibility when
+	 * formatting the record for viewing.
+	 */
+	if (msgbuf_idx <= POSIX_LOG_ENTRY_MAXLEN) {
+		prtk_msgbuf[msgbuf_idx-1] = '\0';
+	}
+
+	argsz = (int) argbuf_idx;
+	evl_append_to_buf(prtk_msgbuf, &msgbuf_idx, &argsz, sizeof(argsz));
+	evl_append_to_buf(prtk_msgbuf, &msgbuf_idx, prtk_argbuf, argbuf_idx);
+
+	if (msgbuf_idx > POSIX_LOG_ENTRY_MAXLEN) {
+		msgbuf_idx = POSIX_LOG_ENTRY_MAXLEN;
+	}
+
+	/* event type = CRC of format string */
+	event_type = (int) crc32(0, prtk_msgbuf, strlen(prtk_msgbuf));
+	
+	ret = evl_kwrite_buf(LOG_KERN, event_type, sev, POSIX_LOG_PRINTF,
+		prtk_msgbuf, msgbuf_idx, EVL_PRINTK);
+	sev = -1;
+	return ret;
+}
+
+/*
+ * FUNCTION             : mk_rec_header
+ * ARGS                 : rec_hdr - the record header stucture
+ *                      : facility -
+ *                      : event_type -
+ *                      : severity -
+ *                      : recsize
+ *                      : flags -
+ *                      : format - indicates string or binary format or no data
+ * RETURN       : void
+ */
+static void mk_rec_header(struct posix_log_entry *rec_hdr,
+		   posix_log_facility_t   facility,
+		   int                    event_type,
+		   posix_log_severity_t   severity,
+		   size_t                 recsize,
+		   uint                   flags,
+		   int            	  format)
+{
+
+	rec_hdr->log_size               =  recsize;
+	rec_hdr->log_format             =  format;
+	rec_hdr->log_event_type         =  event_type;
+	rec_hdr->log_facility           =  facility;
+	rec_hdr->log_severity           =  severity;
+	rec_hdr->log_uid                =  current->uid;
+	rec_hdr->log_gid                =  current->gid;
+	rec_hdr->log_pid                =  current->pid;
+	rec_hdr->log_pgrp               =  current->pgrp;
+	rec_hdr->log_flags              =  flags;
+	rec_hdr->log_thread             =  0;
+	rec_hdr->log_processor          =  smp_processor_id();
+
+	if (get_seconds() == 0) {
+		rec_hdr->log_flags |= EVL_INITIAL_BOOT_EVENT;
+	} else {
+#if defined(__i386__)
+		if (sys_tz.tz_minuteswest == 0) {
+			/* localtime */
+                        rec_hdr->log_flags |= EVL_KERNTIME_LOCAL;
+		}
+#endif
+	}
+	rec_hdr->log_time = CURRENT_TIME;
+}
+
+EXPORT_SYMBOL(posix_log_write);
diff -Naur linux.org/kernel/printk.c linux.kernel.patched/kernel/printk.c
--- linux.org/kernel/printk.c	Fri Apr 11 15:27:45 2003
+++ linux.kernel.patched/kernel/printk.c	Fri Apr 11 15:27:45 2003
@@ -83,6 +83,13 @@
 struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 static int preferred_console = -1;
 
+#ifdef CONFIG_EVLOG
+extern int evl_kbufread(char *, size_t);
+#endif
+#ifdef CONFIG_EVLOG_FWPRINTK
+extern int evl_fwd_printk(const char *fmt, va_list args, const char *msg);
+#endif
+
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
 
@@ -154,6 +161,7 @@
  * 	7 -- Enable printk's to console
  *	8 -- Set level of messages printed to console
  *	9 -- Return number of unread characters in the log buffer
+ *     20 -- Read from event logging buffer 
  */
 int do_syslog(int type, char * buf, int len)
 {
@@ -268,6 +276,17 @@
 	case 9:		/* Number of chars in the log buffer */
 		error = log_end - log_start;
 		break;
+	case 20:
+#ifdef CONFIG_EVLOG
+		error = verify_area(VERIFY_WRITE, buf, len);
+		if (error) {
+			goto out;
+		}
+		error = evl_kbufread(buf, len);
+#else
+		error = -EIO;
+#endif
+		break;
 	default:
 		error = -EINVAL;
 		break;
@@ -408,6 +427,9 @@
 	/* Emit the output into the temporary buffer */
 	va_start(args, fmt);
 	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
+#ifdef CONFIG_EVLOG_FWPRINTK
+	(void) evl_fwd_printk(fmt, args, printk_buf);
+#endif
 	va_end(args);
 
 	/*

--------------2267824871255DC9011DCA6B--

