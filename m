Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268586AbTGORib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269185AbTGORib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:38:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:65240 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268586AbTGOReY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:34:24 -0400
Message-ID: <3F143DCA.8369CDE6@us.ibm.com>
Date: Tue, 15 Jul 2003 10:45:46 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, akpm@osdl.org, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk, rddunlap@osdl.org, kuznet@ms2.inr.ac.ru,
       jkenisto@us.ibm.com
Subject: Re: [PATCH] [2/2] kernel error reporting (revised)
References: <Mutt.LNX.4.44.0307131052420.2146-100000@excalibur.intercode.com.au> <3F143D0A.A052F0B6@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------C7D4C0502BFD8844E4AD4ADE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C7D4C0502BFD8844E4AD4ADE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch is described in the previous post.

Jim Keniston
IBM Linux Technology Center
--------------C7D4C0502BFD8844E4AD4ADE
Content-Type: text/plain; charset=us-ascii;
 name="evlog-2.5.75.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="evlog-2.5.75.patch"

diff -Naur linux.org/include/linux/evlog.h linux.evlog.patched/include/linux/evlog.h
--- linux.org/include/linux/evlog.h	Wed Dec 31 16:00:00 1969
+++ linux.evlog.patched/include/linux/evlog.h	Mon Jul 14 09:52:59 2003
@@ -0,0 +1,109 @@
+/*
+ * Linux Event Logging
+ * Copyright (c) International Business Machines Corp., 2001
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
+ *  Please send e-mail to kenistoj@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ */
+
+#ifndef _LINUX_EVLOG_H
+#define _LINUX_EVLOG_H
+
+#include <stdarg.h>
+#include <linux/types.h>
+#include <asm/types.h>
+
+/* Values for log_flags member */
+#define EVL_TRUNCATE		0x1
+#define EVL_KERNEL_EVENT	0x2
+#define EVL_INTERRUPT		0x10	/* Logged from interrupt context */
+#define EVL_PRINTK		0x20	/* Strip leading <n> when formatting */
+#define EVL_EVTYCRC		0x40	/* Daemon will set event type = CRC */
+					/* of format string. */
+
+/* Formats for optional portion of record. */
+#define EVL_NODATA    0
+#define EVL_BINARY    1
+#define EVL_STRING    2
+#define EVL_PRINTF    3
+
+/* Maximum length of variable portion of record */
+#define EVL_ENTRY_MAXLEN (8 * 1024)
+
+/* Facility (e.g., driver) names are truncated to 15+null. */
+#define FACILITY_MAXLEN 16
+
+/*
+ * struct kern_log_entry - kernel record header
+ * Each record sent to group KERROR_GROUP_EVLOG begins with this header.
+ */
+struct kern_log_entry {
+	__u16	log_kmagic;	/* always LOGREC_KMAGIC */
+	__u16	log_kversion;	/* which version of this struct? */
+	__u16	log_size;	/* # bytes in variable part of record */
+	__s8	log_format;	/* BINARY, STRING, PRINTF, NODATA */
+	__s8	log_severity;	/* DEBUG, INFO, NOTICE, WARN, etc. */
+	__s32	log_event_type;	/* facility-specific event ID */
+	__u32	log_flags;	/* EVL_TRUNCATE, etc. */
+	__s32	log_processor;	/* CPU ID */
+	uid_t	log_uid;	/* event context... */
+	gid_t	log_gid;
+	pid_t	log_pid;
+	pid_t	log_pgrp;
+	char	log_facility[FACILITY_MAXLEN];	/* e.g., driver name */
+}; 
+
+#define LOGREC_KMAGIC	0x7af8
+#define LOGREC_KVERSION	3
+
+#ifdef __KERNEL__
+/*
+ * severities, AKA priorities
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
+#ifdef CONFIG_NET
+extern int evl_write(const char *facility, int event_type,
+	int severity, const void *buf, size_t len, int format);
+extern int evl_printf(const char *facility, int event_type, int sev,
+	const char *fmt, ...);
+extern int evl_vprintf(const char *facility, int event_type, int sev,
+	const char *fmt, va_list args);
+#else	/* ! CONFIG_NET */
+static inline int evl_write(const char *facility, int event_type,
+	int severity, const void *buf, size_t len, int format)
+	{ return -ENOSYS; }
+static inline int evl_printf(const char *facility, int event_type, int sev,
+	const char *fmt, ...);
+	{ return -ENOSYS; }
+static inline int evl_vprintf(const char *facility, int event_type, int sev,
+	const char *fmt, va_list args)
+	{ return -ENOSYS; }
+#endif	/* CONFIG_NET */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_EVLOG_H */
diff -Naur linux.org/kernel/Makefile linux.evlog.patched/kernel/Makefile
--- linux.org/kernel/Makefile	Mon Jul 14 09:52:59 2003
+++ linux.evlog.patched/kernel/Makefile	Mon Jul 14 09:52:59 2003
@@ -19,6 +19,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_NET) += evlog.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -Naur linux.org/kernel/evlog.c linux.evlog.patched/kernel/evlog.c
--- linux.org/kernel/evlog.c	Wed Dec 31 16:00:00 1969
+++ linux.evlog.patched/kernel/evlog.c	Mon Jul 14 09:52:59 2003
@@ -0,0 +1,542 @@
+/*
+ * Linux Event Logging
+ * Copyright (c) International Business Machines Corp., 2003
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
+ *  Please send e-mail to kenistoj@users.sourceforge.net if you have
+ *  questions or comments.
+ *
+ *  Project Website:  http://evlog.sourceforge.net/
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kerror.h>
+#include <linux/stddef.h>
+#include <linux/uio.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/ctype.h>
+#include <linux/evlog.h>
+
+static void report_dropped_event(const struct kern_log_entry *hdr,
+	const void *vardata);
+static void report_dropped_printf_event(const struct kern_log_entry *hdr,
+	const char *fmt, va_list args);
+
+/**
+ * mk_rec_header() - Populate evlog record header.
+ * @fac: facility name (e.g., "kern", driver name)
+ * @event_type: event type (event ID assigned by programmer; may also be
+ *	computed by recipient -- e.g., CRC of format string)
+ * @severity: severity level (e.g., LOG_INFO)
+ * @size: length, in bytes, of variable data
+ * @flags: event flags (e.g., EVL_TRUNCATE, EVL_EVTYCRC)
+ * @format: format of variable data (e.g., EVL_STRING)
+ */
+static void
+mk_rec_header(struct kern_log_entry *rec_hdr,
+		const char *facility,
+		int	event_type,
+		int	severity,
+		size_t	size,
+		uint	flags,
+		int	format)
+{
+	rec_hdr->log_kmagic		=  LOGREC_KMAGIC;
+	rec_hdr->log_kversion		=  LOGREC_KVERSION;
+	rec_hdr->log_size		=  (__u16) size;
+	rec_hdr->log_format		=  (__s8) format;
+	rec_hdr->log_event_type		=  (__s32) event_type;
+	rec_hdr->log_severity		=  (__s8) severity;
+	rec_hdr->log_uid		=  current->uid;
+	rec_hdr->log_gid		=  current->gid;
+	rec_hdr->log_pid		=  current->pid;
+	rec_hdr->log_pgrp		=  current->pgrp;
+	rec_hdr->log_flags		=  (__u32) flags;
+	rec_hdr->log_processor		=  (__s32) smp_processor_id();
+
+	strncpy(rec_hdr->log_facility, facility, FACILITY_MAXLEN);
+	rec_hdr->log_facility[FACILITY_MAXLEN-1] = '\0';
+}
+
+/**
+ * evl_sendh() - Log event, given a pre-constructed header.
+ * In case of sloppiness, clean it up rather than failing, since the caller
+ * is unlikely to handle failure.
+ * Returns 0 on success, or a negative error code otherwise.
+ */
+static int
+evl_sendh(struct kern_log_entry *hdr, const void *vardata)
+{
+	struct iovec iov[2] = {
+		{ hdr, sizeof(struct kern_log_entry) },
+		{ (void*) vardata, hdr->log_size }
+	};
+	int nsegs = 2;
+
+	if (hdr->log_severity < 0 || hdr->log_severity > LOG_DEBUG) {
+		hdr->log_severity = LOG_WARNING;
+	}
+	if (vardata == NULL || hdr->log_size == 0) {
+		vardata = NULL;
+		hdr->log_size = 0;
+		hdr->log_format = EVL_NODATA;
+		nsegs = 1;
+	}
+	hdr->log_flags |= EVL_KERNEL_EVENT;
+	if (in_interrupt()) {
+		hdr->log_flags |= EVL_INTERRUPT;
+	}
+	if (hdr->log_size > EVL_ENTRY_MAXLEN) {
+		iov[1].iov_len = hdr->log_size = EVL_ENTRY_MAXLEN;
+		hdr->log_flags |= EVL_TRUNCATE;
+	}
+
+	return kernel_error_event_iov(iov, nsegs, KERROR_GROUP_EVLOG);
+}
+
+/**
+ * evl_write() - write header + optional buffer to event handler
+ *
+ * @buf: optional variable-length data
+ * other args as per mk_rec_header()
+ */
+int
+evl_write(const char *fac, int event_type, int severity, const void *buf,
+	size_t size, int format)
+{
+	int ret;
+	struct kern_log_entry hdr;
+
+	mk_rec_header(&hdr, fac, event_type, severity, size, 0, format);
+	ret = evl_sendh(&hdr, buf);
+	if (ret == -ESRCH) {
+		report_dropped_event(&hdr, buf);
+	}
+	return ret;
+}
+
+/*
+ * A buffer to pack with data, one value at a time.  By convention, b_tail
+ * reflects the total amount you've attempted to add, and so may be past b_end.
+ */
+struct evl_recbuf {
+	char *b_buf;	/* start of buffer */
+	char *b_tail;	/* add next data here */
+	char *b_end;	/* b_buf + buffer size */
+};
+
+void
+evl_init_recbuf(struct evl_recbuf *b, char *buf, size_t size)
+{
+	b->b_buf = buf;
+	b->b_tail = buf;
+	b->b_end = buf + size;
+}
+
+/**
+ * evl_put() - Append data to buffer; handle overflow.
+ * @b - describes buffer; updated to reflect data appended
+ * @data - data to append
+ * @datasz - data length in bytes
+ */
+void
+evl_put(struct evl_recbuf *b, const void *data, size_t datasz)
+{
+	ptrdiff_t room = b->b_end - b->b_tail;
+	if (room > 0) {
+		(void) memcpy(b->b_tail, data, min(datasz, (size_t)room));
+	}
+	b->b_tail += datasz;
+}
+
+/**
+ * evl_puts() - Append string to buffer; handle overflow.
+ * Append a string to the buffer.  If null == 1, we include the terminating
+ * null.  If the string extends over the end of the buffer, terminate the
+ * buffer with a null.
+ *
+ * @b - describes buffer; updated to reflect data appended
+ * @s - null-terminated string
+ * @null - 1 if we append the terminating null, 0 otherwise
+ */
+void
+evl_puts(struct evl_recbuf *b, const char *s, int null)
+{
+	char *old_tail = b->b_tail;
+	evl_put(b, s, strlen(s) + null);
+	if (b->b_tail > b->b_end && old_tail < b->b_end) {
+		*(b->b_end - 1) = '\0';
+	}
+}
+
+static inline void
+skip_atoi(const char **s)
+{
+	while (isdigit(**s)) {
+		(*s)++;
+	}
+}
+
+/**
+ * parse_printf_fmt() - Parse printf/printk conversion spec.
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
+ * Note: This function is derived from vsnprintf() (see lib/vsprintf.c),
+ * and should be kept in sync with that function.
+ *
+ * @fmt - points to '%' in conversion spec
+ * @pqualifier - *pqualifier is set to conversion spec's qualifier, or -1.
+ * @wp - Bits in *wp are set if the width or/and precision are '*'.
+ */
+const char *
+parse_printf_fmt(const char *fmt, int *pqualifier, int *wp)
+{
+	int qualifier = -1;
+	*wp = 0;
+
+	/* process flags */
+	repeat:
+		++fmt;          /* this also skips first '%' */
+		switch (*fmt) {
+			case '-':
+			case '+':
+			case ' ':
+			case '#':
+			case '0':
+				goto repeat;
+		}
+
+	/* get field width */
+	if (isdigit(*fmt))
+		skip_atoi(&fmt);
+	else if (*fmt == '*') {
+		++fmt;
+		/* it's the next argument */
+		*wp |= 0x1;
+	}
+
+	/* get the precision */
+	if (*fmt == '.') {
+		++fmt;
+		if (isdigit(*fmt))
+			skip_atoi(&fmt);
+		else if (*fmt == '*') {
+			++fmt;
+			/* it's the next argument */
+			*wp |= 0x2;
+		}
+	}
+
+	/* get the conversion qualifier */
+	if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
+	    *fmt == 'Z' || *fmt == 'z') {
+		qualifier = *fmt;
+		++fmt;
+		if (qualifier == 'l' && *fmt == 'l') {
+			qualifier = 'L';
+			++fmt;
+		}
+	}
+
+	*pqualifier = qualifier;
+	return fmt;
+}
+
+/**
+ * evl_pack_args() - Pack args into buffer, guided by format string.
+ * b describes a buffer.  fmt and args are as passed to vsnprintf().  Using
+ * fmt as a guide, copy the args into b's buffer.
+ *
+ * @b - describes buffer; updated to reflect data added
+ * @fmt - printf/printk-style format string
+ * @args - values to be packed into buffer
+ */
+void
+evl_pack_args(struct evl_recbuf *b, const char *fmt, va_list args)
+{
+#define COPYARG(type) \
+    do { type v=va_arg(args,type); evl_put(b,&v,sizeof(v)); } while(0)
+
+	const char *s;
+	int qualifier;
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
+			COPYARG(int);
+		}
+		if (wp & 0x2) {
+			/* ditto precision */
+			COPYARG(int);
+		}
+
+		switch (*fmt) {
+			case 'c':
+				COPYARG(int);
+				continue;
+
+			case 's':
+				s = va_arg(args, char *);
+				evl_puts(b, s, 1);
+				continue;
+
+			case 'p':
+				COPYARG(void*);
+				continue;
+
+			case 'n':
+				/* Skip over the %n arg. */
+				if (qualifier == 'l') {
+					(void) va_arg(args, long *);
+				} else if (qualifier == 'Z' || qualifier == 'z') {
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
+			COPYARG(long long);
+		} else if (qualifier == 'l') {
+			COPYARG(long);
+		} else if (qualifier == 'Z' || qualifier == 'z') {
+			COPYARG(size_t);
+		} else if (qualifier == 'h') {
+			COPYARG(int);
+		} else {
+			COPYARG(int);
+		}
+	}
+}
+
+/*
+ * Scratch buffer for constructing event records.  This is static because
+ * (1) we want events to be logged even in low-memory situations; and
+ * (2) the buffer is too big to be an auto variable.
+ */
+static spinlock_t msgbuf_lock = SPIN_LOCK_UNLOCKED;
+static char msgbuf[EVL_ENTRY_MAXLEN];
+
+/**
+ * evl_send_printf() - Format and log a PRINTF-format message.
+ * Create and log a PRINTF-format event record whose contents are:
+ *	format string
+ *	int containing args size
+ *	args
+ * @hdr - pre-constructed record header
+ * @fmt - format string
+ * @args - arg list
+ */
+static int
+evl_send_printf(struct kern_log_entry *hdr, const char *fmt, va_list args)
+{
+	int ret;
+	struct evl_recbuf b;
+	int argsz = 0;
+	char *nl, *pargsz, *pargs;
+	unsigned long iflags;
+
+	spin_lock_irqsave(&msgbuf_lock, iflags);
+	evl_init_recbuf(&b, msgbuf, EVL_ENTRY_MAXLEN);
+	evl_puts(&b, fmt, 1);
+
+	/*
+	 * If the format ends in a newline, remove it.  We remove the
+	 * terminating newline to increase flexibility when formatting
+	 * the record for viewing.
+	 */
+	nl = b.b_tail - 2;
+	if (b.b_buf <= nl && nl < b.b_end && *nl == '\n') {
+		*nl = '\0';
+		b.b_tail--;
+	}
+
+	/* Remember where to store argsz; store 0 for now. */
+	pargsz = b.b_tail;
+	evl_put(&b, &argsz, sizeof(argsz));
+	pargs = b.b_tail;
+
+	evl_pack_args(&b, fmt, args);
+	if (pargs <= b.b_end) {
+		argsz = (int) (b.b_tail - pargs);
+		memcpy(pargsz, &argsz, sizeof(argsz));
+	}
+
+	hdr->log_size = b.b_tail - b.b_buf;
+	if (hdr->log_size > EVL_ENTRY_MAXLEN) {
+		hdr->log_size = EVL_ENTRY_MAXLEN;
+		hdr->log_flags |= EVL_TRUNCATE;
+	}
+	
+	ret = evl_sendh(hdr, b.b_buf);
+	spin_unlock_irqrestore(&msgbuf_lock, iflags);
+
+	if (ret == -ESRCH) {
+		report_dropped_printf_event(hdr, fmt, args);
+	}
+	return ret;
+}
+
+/**
+ * evl_vprintf() - Format and log a PRINTF-format record.
+ * @fmt - format string
+ * @args - arg list
+ * other args as per mk_rec_header().  If event_type == 0, set flag to
+ *	request that recipient set event type.
+ */
+int
+evl_vprintf(const char *facility, int event_type, int severity,
+	const char *fmt, va_list args)
+{
+	struct kern_log_entry hdr;
+	unsigned int flags = 0;
+	if (event_type == 0) {
+		flags |= EVL_EVTYCRC;
+	}
+	mk_rec_header(&hdr, facility, event_type, severity, 0, flags,
+		EVL_PRINTF);
+	
+	return evl_send_printf(&hdr, fmt, args);
+}
+
+/**
+ * evl_printf() - Format and log a PRINTF-format record.
+ * @fmt - format string
+ * other args as per mk_rec_header()
+ */
+int
+evl_printf(const char *facility, int event_type, int severity,
+	const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+	va_start(args, fmt);
+	ret = evl_vprintf(facility, event_type, severity, fmt, args);
+	va_end(args);
+	return ret;
+}
+
+/*** Functions for handling of events logged when nobody was listening ***/
+static void
+report_dropped_hdr(const struct kern_log_entry *hdr)
+{
+	printk("<%d>evlog packet dropped: size=%u fmt=%d evty=%#x"
+		" fac=%s sev=%d uid=%u gid=%u pid=%d pgrp=%d"
+		" flags=%#x cpu=%d\n",
+		hdr->log_severity, hdr->log_size, hdr->log_format,
+		hdr->log_event_type, hdr->log_facility, hdr->log_severity,
+		hdr->log_uid, hdr->log_gid, hdr->log_pid, hdr->log_pgrp,
+		hdr->log_flags, hdr->log_processor);
+}
+
+static void
+report_dropped_printf_event(const struct kern_log_entry *hdr, const char *fmt,
+	va_list args)
+{
+	char msg[500];
+	if (hdr->log_flags & EVL_PRINTK) {
+		/* printk's already reporting this event. */
+		return;
+	}
+	report_dropped_hdr(hdr);
+	vsnprintf(msg, 500, fmt, args);
+	printk("<%d>%s\n", hdr->log_severity, msg);
+}
+
+static void
+hexdump(const void *data, size_t nbytes, int severity)
+{
+#define MAX_HEXDUMP_LEN 512	/* Keep this small: don't flood printk buffer */
+	size_t nb = min(nbytes, (size_t)MAX_HEXDUMP_LEN);
+	const unsigned char *dbase = (const unsigned char*) data;
+	const unsigned char *dp = dbase, *dend = dbase + nb;
+	char *lp, line[100];
+	int i;
+
+	while (dp < dend) {
+		lp = line;
+		lp += sprintf(lp, "%04X ", (unsigned) (dp - dbase));
+		for (i = 0; i < 16 && dp < dend; i++, dp++) {
+			lp += sprintf(lp, "%02X ", *dp);
+		}
+		printk("<%d>%s\n", severity, line);
+	}
+}
+
+static void
+report_dropped_event(const struct kern_log_entry *hdr, const void *vardata)
+{
+	if (hdr->log_flags & EVL_PRINTK) {
+		/* printk's already reporting this event. */
+		return;
+	}
+	report_dropped_hdr(hdr);
+	switch (hdr->log_format) {
+	case EVL_STRING:
+		printk("<%d>%s\n", hdr->log_severity, (const char*) vardata);
+		break;
+	case EVL_PRINTF:
+		/* Should be handled by report_dropped_printf_event() */
+		/*FALLTHRU*/
+	case EVL_BINARY:
+		hexdump(vardata, hdr->log_size, hdr->log_severity);
+		break;
+	case EVL_NODATA:
+	default:
+		break;
+	}
+}
+
+EXPORT_SYMBOL(evl_write);
+EXPORT_SYMBOL(evl_printf);
+EXPORT_SYMBOL(evl_vprintf);

--------------C7D4C0502BFD8844E4AD4ADE--

