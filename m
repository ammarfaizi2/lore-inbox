Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSIXBzj>; Mon, 23 Sep 2002 21:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbSIXBy4>; Mon, 23 Sep 2002 21:54:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24460 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261530AbSIXBvi>;
	Mon, 23 Sep 2002 21:51:38 -0400
Message-ID: <3D8FC5F4.12409FC6@us.ibm.com>
Date: Mon, 23 Sep 2002 18:55:00 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>, Hien Nguyen <hien@us.ibm.com>
Subject: [PATCH-RFC] 1 of 4 - New problem logging macros, Event Logging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please see [PATCH-RFC] README 1ST

Summary of this patch...

include/linux/evl_log.h
        Data structures, constants, and fucnction protos, 
        required for event logging.  Also included by
        libevl and user-space utilities.        

init/Config.help
        Added help text for event logging

init/Config.in
        CONFIG_EVLOG - default=disabled (problems
         become printks)
        CONFIG_EVLOG_BUFSIZE - Configurable static
          event buffer size.  

kernel/evlog.c
        * posix_log_write() - creates event record
          from introduce(), problem() detail(), and
          array_detail()
        * Static event buffer for kernel events
          (has nothing whatsoever to do with printk
           ring-buffer or printk behavior).
        * generates console messages from events
          (portion of event data that will fit on 
           a single line)
        * facility code and event_type generation
        
kernel/printk.c
        Added option to do_syslog() for evlogd 
        deamon to read events from kernel 
        event buffer.



diff -Naur linux.org/include/linux/evl_log.h linux.evlog.patched/include/linux/evl_log.h
--- linux.org/include/linux/evl_log.h	Wed Dec 31 16:00:00 1969
+++ linux.evlog.patched/include/linux/evl_log.h	Mon Sep 23 15:19:17 2002
@@ -0,0 +1,208 @@
+/*
+ * Linux Event Logging for the Enterprise
+ * Copyright (c) International Business Machines Corp., 2002
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
+#include <time.h>
+#ifdef _POSIX_THREADS
+#include <pthread.h>
+#endif
+#else
+#include <linux/time.h>
+#endif
+
+/* Values for log_flags member */
+#define POSIX_LOG_TRUNCATE  0x1
+#define EVL_KERNEL_EVENT	0x2
+#define EVL_INITIAL_BOOT_EVENT 	0x4
+#define EVL_KERNTIME_LOCAL	0x8
+#define EVL_INTERRUPT		0x10	/* Logged from interrupt context */
+#define EVL_PRINTK		0x20	/* Reserved */
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
+#define EVL_SYSLOG_MESSAGE      0x1	/* Reserved */
+#define EVL_PRINTK_MESSAGE      0x2	/* Reserved */
+#define EVL_BUFFER_OVERRUN      0x6
+#define EVL_DUPS_DISCARDED      0x7
+
+/*
+ * A record of type (LOG_LOGMGMT, EVLOG_REGISTER_FAC) is generated by
+ * evl_register_facility().
+ */
+#define EVLOG_REGISTER_FAC 40
+
+#define LOG_LOGMGMT              (12<<3)	/* EVL Facility */
+
+/*
+ * The optional portion of a record of type (LOG_LOGMGMT, EVLOG_REGISTER_FAC)
+ * is an evl_facreg_rq object followed by a string (the facility name).
+ * evlogd intercepts this record and does the requested registration, if needed.
+ *
+ * fr_kernel_fac_code is the facility code generated by the kernel's call
+ * to evl_register_facility().  This field is filled in by the kernel.
+ *
+ * fr_registry_fac_code is the facility code that appears in the registry.
+ * (This should match fr_kernel_fac_code.)  This field is filled in by
+ * evlogd after it intercepts and executes this request.
+ *
+ * fr_rq_status is the request's status:
+ *	frst_kernel_failed: Set by the kernel to indicate that it could not
+ *		generate a valid facility code for the given name.
+ *	frst_kernel_ok: Set by the kernel to indicate success so far.
+ * evlogd replaces the frst_kernel_ok value with one of the following:
+ *	frst_already_registered: No need to register the facility.  It's
+ *		already registered, and the code matches.
+ *	frst_registered_ok: We registered it, with the expected results.
+ *	frst_registration_failed: We tried to register it, but couldn't.
+ *	frst_faccode_mismatch: A facility by that name is in the registry,
+ *		but its code doesn't match fr_kernel_fac_code.
+ */
+typedef enum {
+	frst_kernel_failed = -1,
+	frst_kernel_ok = 0,
+	frst_already_registered,
+	frst_registered_ok,
+	frst_registration_failed,
+	frst_faccode_mismatch
+} evl_facreg_rq_status_t;
+
+struct evl_facreg_rq {
+	posix_log_facility_t	fr_kernel_fac_code;
+	posix_log_facility_t	fr_registry_fac_code;
+	evl_facreg_rq_status_t	fr_rq_status;
+};
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
+
+extern int evl_gen_event_type(const char *s1, const char *s2, const char *s3);
+
+extern int evl_gen_facility_code(const char *fname,
+		posix_log_facility_t *fcode);
+
+extern int evl_register_facility(const char *fname,
+		posix_log_facility_t *fcode);
+#else	/* ! CONFIG_EVLOG */
+inline int posix_log_write(posix_log_facility_t facility, int event_type,
+		posix_log_severity_t severity, const void *buf,
+		size_t len, int format, unsigned int flags)
+		{ return -ENOSYS; }
+
+inline int evl_gen_event_type(const char *s1, const char *s2, const char *s3)
+		{ return -ENOSYS; }
+
+inline int evl_gen_facility_code(const char *fname,
+		posix_log_facility_t *fcode)
+		{ return -ENOSYS; }
+
+inline int evl_register_facility(const char *fname,
+		posix_log_facility_t *fcode)
+		{ return -ENOSYS; }
+#endif	/* CONFIG_EVLOG */
+#endif	/* __KERNEL__ */
+
+#endif
diff -Naur linux.org/init/Config.help linux.evlog.patched/init/Config.help
--- linux.org/init/Config.help	Mon Sep 23 15:19:17 2002
+++ linux.evlog.patched/init/Config.help	Mon Sep 23 15:19:17 2002
@@ -115,3 +115,16 @@
   replacement for kerneld.) Say Y here and read about configuring it
   in <file:Documentation/kmod.txt>.
 
+CONFIG_EVLOG
+  This enables support for enterprise level event logging based upon
+  the draft POSIX 1003.25 standard. Enabling this feature does not affect
+  the operation of the sysklogd package in any way. In order to fully
+  utilize this feature user must also install the companion evlog package
+  in user-space.
+
+  For more information see http://evlog.sourceforge.net
+
+  If you don't know what to do here, say N.
+
+CONFIG_EVLOG_BUFSIZE
+  Event log buffer size in kBytes. Default size is 128 kBytes.
diff -Naur linux.org/init/Config.in linux.evlog.patched/init/Config.in
--- linux.org/init/Config.in	Mon Sep 23 15:19:17 2002
+++ linux.evlog.patched/init/Config.in	Mon Sep 23 15:19:17 2002
@@ -9,6 +9,10 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+bool 'Enterprise event logging support' CONFIG_EVLOG
+if [ "$CONFIG_EVLOG" != "n" ]; then
+   int 'Eventlog buffer size (in K bytes)' CONFIG_EVLOG_BUFSIZE 128
+fi
 endmenu
 
 mainmenu_option next_comment
diff -Naur linux.org/kernel/Makefile linux.evlog.patched/kernel/Makefile
--- linux.org/kernel/Makefile	Mon Sep 23 15:19:17 2002
+++ linux.evlog.patched/kernel/Makefile	Mon Sep 23 15:19:17 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o evlog.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -17,6 +17,7 @@
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_EVLOG) += evlog.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Naur linux.org/kernel/evlog.c linux.evlog.patched/kernel/evlog.c
--- linux.org/kernel/evlog.c	Wed Dec 31 16:00:00 1969
+++ linux.evlog.patched/kernel/evlog.c	Mon Sep 23 15:19:17 2002
@@ -0,0 +1,1206 @@
+/*
+ * Linux Event Logging for the Enterprise
+* Copyright (c) International Business Machines Corp., 2002
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
+void evl_console_print(posix_log_facility_t facility, int event_type,
+                                           posix_log_severity_t severity, int format, uint rec_len,
+                                           const char * databuf);
+void _evl_console_print(const char * s);
+static char *formatbytes(const char *dp, const char *dend, char *bp, size_t size);
+static posix_log_facility_t get_linux_fac_code_by_name(const char *name);
+static const char * get_linux_fac_name_by_code(posix_log_facility_t code);
+static int gen_canonical_facility_name(const unsigned char *fac_name,
+                        unsigned char *canonical);
+static uint32_t crc32(const unsigned char *data, int len);
+static uint32_t crc32simple(const unsigned char *data, int len);
+
+void mk_rec_header(struct posix_log_entry *rechdr,
+	posix_log_facility_t facility, int event_type,
+	posix_log_severity_t severity, size_t recsize,
+	uint recflags, int format);
+
+void evl_console_print(posix_log_facility_t facility, int event_type,
+	posix_log_severity_t severity, int format, uint rec_len, 
+	const char * databuf);
+
+extern int console_loglevel;
+extern struct console *console_drivers;
+extern struct semaphore console_sem;
+extern struct timezone sys_tz;
+
+#define EVL_BUF_SIZE (CONFIG_EVLOG_BUFSIZE * 1024)   /* EVL buffer size */
+#define EVL_BUF_FREESPACE (64*1024) /* max free space reqd after buff */
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
+#define min(a,b) (((a)<(b))?(a):(b))
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
+unsigned char *
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
+unsigned char *
+cbufwrite(unsigned char *bufp, unsigned char *s, size_t len)
+{
+	register unsigned char *e;
+	register size_t n, lw;
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
+unsigned char *
+cbufptr(unsigned char *cbuf_ptr, size_t offset)
+{
+	register unsigned char *e;
+	register size_t lw;
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
+int
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
+int
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
+unsigned char *
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
+	register size_t rec_size;
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
+int
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
+	/* Caller will call evl_console_print() as needed. */
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
+        if (severity < console_loglevel && console_drivers) {
+                evl_console_print(facility, event_type, severity, format, recsize, buf);
+        }
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
+                if (qualifier == 'h' && *fmt == 'h') {
+                        qualifier = 'H';
+                        ++fmt;
+                } else if (qualifier == 'l' && *fmt == 'l') {
+                        qualifier = 'L';
+                        ++fmt;
+                }
+        }
+
+        *pqualifier = qualifier;
+        return fmt;
+}
+
+/* Compute event type as the sum of the checksums of one to three strings. */
+int
+evl_gen_event_type(const char *s1, const char *s2, const char *s3)
+{
+        uint32_t evtype = crc32(s1, strlen(s1));
+        if (s2) {
+                evtype += crc32(s2, strlen(s2));
+        }
+        if (s3) {
+                evtype += crc32(s3, strlen(s3));
+        }
+        return (int) evtype;
+}
+
+/*
+ * Set *fcode to the canonical facility code that corresponds to the facility
+ * name fname.  Return 0 on success.
+ *
+ * If fname is the upper or lower case name of a standard Linux facility,
+ * return the corresponding facility code.
+ *
+ * Otherwise, compute the facility code as the CRC of the name.  If the
+ * resulting code is the same as a reserved code (either a Linux code or
+ * EVL_INVALID_FACILITY), we return -EEXIST.
+ */
+int
+evl_gen_facility_code(const char *fname, posix_log_facility_t *fcode)
+{
+        posix_log_facility_t fac_num;
+        size_t name_len;
+        char canonical[POSIX_LOG_MEMSTR_MAXLEN];
+
+        if (!fname || !fcode) {
+                return -EINVAL;
+        }
+
+        name_len = strlen(fname);
+        if (name_len == 0 || name_len >= POSIX_LOG_MEMSTR_MAXLEN) {
+                return -EINVAL;
+        }
+
+        (void) gen_canonical_facility_name(fname, canonical);
+
+        fac_num = get_linux_fac_code_by_name(canonical);
+        if (fac_num != EVL_INVALID_FACILITY) {
+                /* fname names a standard Linux facility. */
+                *fcode = fac_num;
+                return 0;
+        }
+
+        fac_num = crc32(canonical, strlen(canonical));
+        if (fac_num == EVL_INVALID_FACILITY) {
+                /* CRC happens to match EVL_INVALID_FACILITY */
+                return -EEXIST;
+        }
+        if (get_linux_fac_name_by_code(fac_num) != NULL) {
+                /* CRC happens to match a standard Linux facility code. */
+                return -EEXIST;
+        }
+        *fcode = fac_num;
+        return 0;
+}
+
+/*
+ * Compute the appropriate facility code for the facility whose name is fname.
+ * To ensure that this facility is registered in the facility registry, log
+ * a special event with facility = LOG_LOGMGMT and event type =
+ * EVLOG_REGISTER_FAC.  evlogd will intercept this event record and, if
+ * the facility is not already registered, register it.
+ *
+ * If the facility code we compute for fname collides with a reserved code
+ * (and fname is not the corresponding reserved name), we return -EEXIST
+ * and set *fcode to EVL_INVALID_FACILITY.  But we still log the event.
+ */
+int
+evl_register_facility(const char *fname, posix_log_facility_t *fcode)
+{
+        int status;
+        int ret;
+        struct evl_facreg_rq rq;
+        posix_log_severity_t sev;
+	char buf[sizeof(rq) + POSIX_LOG_MEMSTR_MAXLEN];
+	
+	/* evlogd will set this value eventually. */
+        rq.fr_registry_fac_code = EVL_INVALID_FACILITY;
+
+        status = evl_gen_facility_code(fname, fcode);
+        if (status == -EINVAL) {
+                return -EINVAL;
+        } else if (status == 0) {
+                rq.fr_kernel_fac_code = *fcode;
+                rq.fr_rq_status = frst_kernel_ok;
+                sev = LOG_INFO;
+                ret = 0;
+        } else {
+                /* *fcode must conflict with a reserved facility code. */
+                *fcode = EVL_INVALID_FACILITY;
+                rq.fr_kernel_fac_code = EVL_INVALID_FACILITY;
+                rq.fr_rq_status = frst_kernel_failed;
+                sev = LOG_ERR;
+                ret = -EEXIST;
+        }
+
+        /* Log the event no matter whether evl_gen_facility_code() succeeded. */
+	memcpy(buf, &rq, sizeof(rq));
+	strcpy(buf + sizeof(rq), fname);
+	status = posix_log_write(LOG_LOGMGMT, EVLOG_REGISTER_FAC, sev, buf, 
+		(sizeof(rq) + strlen(fname) + 1), POSIX_LOG_BINARY, 0);
+        if (status != 0) {
+                return status;
+        }
+        return ret;
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
+void mk_rec_header(struct posix_log_entry *rec_hdr,
+		   posix_log_facility_t   facility,
+		   int                    event_type,
+		   posix_log_severity_t   severity,
+		   size_t                 recsize,
+		   uint                   flags,
+		   int            format)
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
+	if (CURRENT_TIME == 0) {
+		rec_hdr->log_flags |= EVL_INITIAL_BOOT_EVENT;
+	} else {
+#if defined(__i386__)
+		if (sys_tz.tz_minuteswest == 0) {
+			/* localtime */
+                        rec_hdr->log_flags |= EVL_KERNTIME_LOCAL;
+		}
+#endif
+	}
+	rec_hdr->log_time.tv_sec  = CURRENT_TIME;
+}
+
+/*
+ * print evlog message to the console
+ */
+
+void evl_console_print(posix_log_facility_t facility, int event_type,
+				posix_log_severity_t severity, int format, uint rec_len,
+				const char * databuf)
+{
+	char s[256 + 41];               /* print buffer - only print first 256 chars  */
+	char b[36+1];                   /* (16 bytes x 2) + 4 spaces + null */
+
+	if (format == POSIX_LOG_STRING) {
+		if (rec_len >= 256) {
+			snprintf(s, sizeof(s) - 2, "F%04x:T%04x:S: %s", facility, event_type, databuf);
+			strcat(s, "\n");
+		} else {
+			snprintf(s, sizeof(s), "F%04x:T%04x:S: %s\n", facility,
+				event_type, databuf);
+		}
+	} else if (format == POSIX_LOG_BINARY) {
+		char *tmp = b;
+		if (rec_len >= 16 ) {
+			formatbytes(databuf, databuf+16, tmp, sizeof(b));
+			snprintf(s, sizeof(s), "F%04x:T%04x:B: <%s...> %d more bytes\n", facility,
+				event_type, b, rec_len - 16);
+		} else {
+			formatbytes(databuf, databuf+rec_len, tmp, sizeof(b));
+			snprintf(s, sizeof(s), "F%04x:T%04x:B: <%s>\n", facility,
+				event_type, b);
+		}
+	} else {
+		snprintf(s, sizeof(s), "F%04x:T%04x:N: <no data>\n", facility,
+				event_type);
+	}
+	_evl_console_print(s);
+
+}
+void _evl_console_print(const char * s)
+{
+	struct console *con;
+
+	down(&console_sem);
+	for (con = console_drivers; con; con = con->next) {
+		if ((con->flags & CON_ENABLED) && con->write)
+			con->write(con, s, strlen(s));
+	}
+	up(&console_sem);
+}
+
+static char *hexDigits = "0123456789ABCDEF";
+
+static char *formatbytes(const char *dp, const char *dend, char *bp, size_t size)
+{
+	char *oldbp = bp, *bpend = bp + size - 1;
+	int i;
+	int nbytes = dend - dp;
+	int n = 0;
+	for (i = 1; i <= nbytes; i++, dp++, bp += 2) {
+		if (dp <= dend && bp + 2 < bpend) {
+			bp[0] = hexDigits[(*dp >> 4) & 0xF];
+			bp[1] = hexDigits[*dp & 0xF];
+			n++;
+			if (n >= 4 && bp + 1 < bpend) {
+				bp[2] = ' ';
+				bp++;
+				n = 0;
+			}
+		}
+	}
+	*bp='\0';
+	return oldbp;
+}
+
+/*** Facility registration functions start here. ***/
+
+struct nv_pair {
+	int     nv_value;
+	char    *nv_name;
+};
+
+/*
+ * This should look a lot like the DEFAULT version of the facility registry,
+ * /var/evlog/facility_registry.  DO NOT UPDATE THIS TABLE when you add a
+ * new facility.
+ */
+static struct nv_pair linux_facilities[] = {
+	{ 0, "kern" },
+	{ 8, "user" },
+	{ 16, "mail" },
+	{ 24, "daemon" },
+	{ 32, "auth" },
+	{ 40, "syslog" },
+	{ 48, "lpr" },
+	{ 56, "news" },
+	{ 64, "uucp" },
+	{ 72, "cron" },
+	{ 80, "authpriv" },
+	{ 88, "ftp" },
+	{ 96, "logmgmt" },
+	{ 128, "local0" },
+	{ 136, "local1" },
+	{ 144, "local2" },
+	{ 152, "local3" },
+	{ 160, "local4" },
+	{ 168, "local5" },
+	{ 176, "local6" },
+	{ 184, "local7" },
+	{ -1, NULL }
+};
+
+static posix_log_facility_t
+get_linux_fac_code_by_name(const char *name)
+{
+	struct nv_pair *nv;
+	for (nv = linux_facilities; nv->nv_name; nv++) {
+		if (!strcmp(name, nv->nv_name)) {
+			return (posix_log_facility_t) nv->nv_value;
+		}
+	}
+	return EVL_INVALID_FACILITY;
+}
+
+static const char *
+get_linux_fac_name_by_code(posix_log_facility_t code)
+{
+	struct nv_pair *nv;
+	for (nv = linux_facilities; nv->nv_name; nv++) {
+		if (code == (posix_log_facility_t) (nv->nv_value)) {
+			return nv->nv_name;
+		}
+	}
+	return NULL;
+}
+
+/*
+ * Copy fac_name to canonical, converting characters as necessary so that
+ * canonical is the canonical version of facility name fac_name.  Returns
+ * -EINVAL if fac_name is null or empty, or if canonical is null; 0 otherwise.
+ *
+ * Here are the rules for forming a canonical name:
+ * 1. The following bytes are passed through unchanged: ASCII digits,
+ * ASCII lowercase letters, period, underscore, and any bytes outside
+ * the ASCII code set.
+ * 2. Uppercase ASCII letters are converted to lowercase.
+ * 3. A space character is converted to an underscore.
+ * 4. Any other ASCII character is converted to a period.
+ */
+static int
+gen_canonical_facility_name(const unsigned char *fac_name,
+	unsigned char *canonical)
+{
+	const unsigned char *f;
+	unsigned char *c;
+
+	if (!fac_name || !canonical || fac_name[0] == '\0') {
+		return -EINVAL;
+	}
+
+	for (f=fac_name, c=canonical; *f; f++, c++) {
+		unsigned int uf = *f;
+		if ('A' <= uf && uf <= 'Z') {
+			*c = uf | 0x20;         /* ASCII toupper(uf) */
+		} else if (uf > 0x7f
+		    || ('a' <= uf && uf <= 'z')
+		    || ('0' <= uf && uf <= '9')
+		    || uf == '.'
+		    || uf == '_') {
+			*c = uf;
+		} else if (uf == ' ') {
+			*c = '_';
+		} else {
+			*c = '.';
+		}
+	}
+	*c = '\0';
+
+	/* "." and ".." are reserved directory names, so we convert them. */
+	if (!strcmp(canonical, ".") || !strcmp(canonical, "..")) {
+		canonical[0] = '_';
+	}
+	return 0;
+}
+
+/*
+ * This is essentially CRC algorithm #3 from
+ * http://www.cl.cam.ac.uk/Research/SRG/bluebook/21/crc/node6.html.
+ * Some other CRC algorithms hard-wire crctab -- i.e.,
+ *      uint32_t crctab[256] = { 256 strange numbers here };
+ * We stick with the original code to make it at least a little easier to
+ * understand what's going on.  Since crc32_init() typically gets called
+ * very soon after boot, that's the only time the spinlock comes into play.
+ * Even then, the spinlock may be unnecessary if you can guarantee that
+ *      crctab[i] = crc
+ * is an atomic operation.
+ */
+#define QUOTIENT 0x04c11db7
+uint32_t crctab[256];
+static spinlock_t crctab_lock = SPIN_LOCK_UNLOCKED;
+static int crctab_initialized = 0;
+
+static void
+crc32_init(void)
+{
+	int i, j;
+	uint32_t crc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&crctab_lock, flags);
+	if (crctab_initialized) {
+		/* Somebody else beat us to it. */
+		spin_unlock_irqrestore(&crctab_lock, flags);
+		return;
+	}
+
+	for (i = 0; i < 256; i++) {
+		crc = i << 24;
+		for (j = 0; j < 8; j++) {
+			if (crc & 0x80000000) {
+				crc = (crc << 1) ^ QUOTIENT;
+			} else {
+				crc = crc << 1;
+			}
+		}
+		crctab[i] = crc;
+	}
+
+	crctab_initialized = 1;
+	spin_unlock_irqrestore(&crctab_lock, flags);
+}
+
+static uint32_t
+crc32(const unsigned char *data, int len)
+{
+	uint32_t result;
+	int i;
+
+	if (len < 4) {
+		return crc32simple(data, len);
+	}
+
+	if (!crctab_initialized) {
+		crc32_init();
+	}
+
+	result = *data++ << 24;
+	result |= *data++ << 16;
+	result |= *data++ << 8;
+	result |= *data++;
+	result = ~ result;
+
+	for (i=4; i<len; i++) {
+		result = (result << 8 | *data++) ^ crctab[result >> 24];
+	}
+
+	for (i=0; i<4; i++) {
+		result = (result << 8) ^ crctab[result >> 24];
+	}
+
+	return ~result;
+}
+
+/*
+ * This is the code for CRC algorithm #1 from
+ * http://www.cl.cam.ac.uk/Research/SRG/bluebook/21/crc/node6.html.
+ * It is not as efficient as algorithm #3, but it can handle data lengths < 4.
+ */
+static uint32_t
+crc32simple(const unsigned char *data, int len)
+{
+	uint32_t result;
+	int i,j;
+	unsigned char octet;
+
+	result = -1;
+
+	for (i=0; i<len; i++) {
+		octet = *(data++);
+		for (j=0; j<8; j++) {
+			if ((octet >> 7) ^ (result >> 31)) {
+				result = (result << 1) ^ QUOTIENT;
+			} else {
+				result = (result << 1);
+			}
+			octet <<= 1;
+		}
+	}
+
+	return ~result; /* The complement of the remainder */
+}
+
+EXPORT_SYMBOL(posix_log_write);
+EXPORT_SYMBOL(evl_gen_event_type);
+EXPORT_SYMBOL(evl_gen_facility_code);
+EXPORT_SYMBOL(evl_register_facility);
diff -Naur linux.org/kernel/printk.c linux.evlog.patched/kernel/printk.c
--- linux.org/kernel/printk.c	Mon Sep 23 15:19:17 2002
+++ linux.evlog.patched/kernel/printk.c	Mon Sep 23 15:19:17 2002
@@ -68,7 +68,7 @@
  * provides serialisation for access to the entire console
  * driver system.
  */
-static DECLARE_MUTEX(console_sem);
+DECLARE_MUTEX(console_sem);
 struct console *console_drivers;
 
 /*
@@ -92,6 +92,9 @@
 
 struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
 static int preferred_console = -1;
+#ifdef CONFIG_EVLOG
+extern int evl_kbufread(char *, size_t);
+#endif
 
 /* Flag: console code may call schedule() */
 static int console_may_schedule;
@@ -166,6 +169,7 @@
  *	9 -- Return number of unread characters in the log buffer
  *     10 -- Printk from userspace.  Includes loglevel.  Returns number of
  *           chars printed.
+ *     20 -- Read from event logging buffer 
  */
 int do_syslog(int type, char * buf, int len)
 {
@@ -297,6 +301,17 @@
 			break;
 		lbuf[len] = '\0';
 		error = printk("%s", lbuf);
+		break;
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
 		break;
 	default:
 		error = -EINVAL;
