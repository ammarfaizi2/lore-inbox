Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262605AbTCRXH0>; Tue, 18 Mar 2003 18:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbTCRXH0>; Tue, 18 Mar 2003 18:07:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262605AbTCRXHX>;
	Tue, 18 Mar 2003 18:07:23 -0500
Subject: [PATCH 2.5.65 1/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: multipart/mixed; boundary="=-+FRtAsHvDrK8j0yfvtjo"
Organization: 
Message-Id: <1048029496.2559.12.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Mar 2003 15:18:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+FRtAsHvDrK8j0yfvtjo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds a sequence counter only version of the reader/writer
consistent mechanism to seqlock.h  This is used in the second
part of this patch give atomic access to i_size.

re-diff against 2.5.65.

-- 
Daniel McNeil <daniel@osdl.org>

--=-+FRtAsHvDrK8j0yfvtjo
Content-Disposition: attachment; filename=patch-2.5.65-isize.1
Content-Type: text/x-patch; name=patch-2.5.65-isize.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -rupN linux-2.5.65/include/linux/seqlock.h linux-2.5.65-isize/include/linux/seqlock.h
--- linux-2.5.65/include/linux/seqlock.h	Mon Mar 17 13:44:05 2003
+++ linux-2.5.65-isize/include/linux/seqlock.h	Tue Mar 18 13:56:12 2003
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

--=-+FRtAsHvDrK8j0yfvtjo--

