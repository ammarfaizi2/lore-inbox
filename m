Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTE2Rag (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTE2Rag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:30:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262429AbTE2Rad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:30:33 -0400
Subject: [PATCH 2.5.70 1/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-U0Qydlv/gZDuvW+i6isH"
Organization: 
Message-Id: <1054230227.2468.11.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 29 May 2003 10:43:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U0Qydlv/gZDuvW+i6isH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds a sequence counter only version of the reader/writer
consistent mechanism to seqlock.h  This is used in the second
part of this patch give atomic access to i_size.

re-diff against 2.5.70.

The patch is also available for download from OSDL's patch lifecycle 
manager (PLM):


https://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1873
-- 
Daniel McNeil <daniel@osdl.org>

--=-U0Qydlv/gZDuvW+i6isH
Content-Disposition: attachment; filename=patch-2.5.70-isize.1
Content-Type: text/x-troff-man; name=patch-2.5.70-isize.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.5.70/include/linux/seqlock.h	2003-05-26 18:00:39.000000000 -0700
+++ linux-2.5.70-isize/include/linux/seqlock.h	2003-05-28 10:39:24.000000000 -0700
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

--=-U0Qydlv/gZDuvW+i6isH--

