Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261964AbTCHAFS>; Fri, 7 Mar 2003 19:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbTCHAFS>; Fri, 7 Mar 2003 19:05:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:7844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261964AbTCHAFO>;
	Fri, 7 Mar 2003 19:05:14 -0500
Subject: [PATCH 2.5.64 1/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047082539.2636.96.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Mar 2003 16:15:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds a sequence counter only version of the reader/writer
consistent mechanism to seqlock.h  This is used in the second
part of this patch give atomic access to i_size.

-- 
Daniel McNeil <daniel@osdl.org>

diff -urNp -X /home/daniel/dontdiff linux-2.5.64/include/linux/seqlock.h
linux-2.5.64-isize/include/linux/seqlock.h
--- linux-2.5.64/include/linux/seqlock.h	Tue Mar  4 19:29:17 2003
+++ linux-2.5.64-isize/include/linux/seqlock.h	Thu Mar  6 15:30:42 2003
@@ -94,6 +94,57 @@ static inline int read_seqretry(const se
 	return (iv & 1) | (sl->sequence ^ iv);
 }
 
+
+/*
+ * Version using sequence counter only. 
+ * This can be used when code has its own mutex protecting the
+ * updating starting before the write_seqcntbeqin() and ending
+ * after the write_seqcntend().
+ */
+
+typedef struct seqcnt {
+	unsigned sequence;
+} seqcnt_t;
+
+#define SEQCNT_ZERO { 0 }
+#define seqcnt_init(x)	do { *(x) = (seqcnt_t) SEQCNT_ZERO; } while (0)
+
+/* Start of read using pointer to a sequence counter only.  */
+static inline unsigned read_seqcntbegin(const seqcnt_t *s)
+{
+	unsigned ret = s->sequence;
+	smp_rmb();
+	return ret;
+}
+
+/* Test if reader processed invalid data.
+ * Equivalent to: iv is odd or sequence number has changed.
+ *                (iv & 1) || (*s != iv)
+ * Using xor saves one conditional branch.
+ */
+static inline int read_seqcntretry(const seqcnt_t *s, unsigned iv)
+{
+	smp_rmb();
+	return (iv & 1) | (s->sequence ^ iv);
+}
+
+
+/* 
+ * Sequence counter only version assumes that callers are using their
+ * own mutexing.
+ */
+static inline void write_seqcntbegin(seqcnt_t *s)
+{
+	s->sequence++;
+	smp_wmb();			
+}	
+
+static inline void write_seqcntend(seqcnt_t *s) 
+{
+	smp_wmb();
+	s->sequence++;
+}
+
 /*
  * Possible sw/hw IRQ protected versions of the interfaces.
  */



