Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTDRSne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTDRSne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:43:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:36811 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263201AbTDRSnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:43:32 -0400
Subject: [PATCH 2.5.67 1/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-2aoKYgjfGOUqhSXEgvq6"
Organization: 
Message-Id: <1050692126.5574.82.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Apr 2003 11:55:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2aoKYgjfGOUqhSXEgvq6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds a sequence counter only version of the reader/writer
consistent mechanism to seqlock.h  This is used in the second
part of this patch give atomic access to i_size.

re-diff against 2.5.67.

The patch is also available for download from OSDL's patch lifecycle 
manageer (PLM):

http://osdl.org/cgi-bin/plm?module=patch_info&patch_id=1778

-- 
Daniel McNeil <daniel@osdl.org>

--=-2aoKYgjfGOUqhSXEgvq6
Content-Disposition: attachment; filename=patch-2.5.67-isize.1
Content-Type: text/x-troff-man; name=patch-2.5.67-isize.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.5.67/include/linux/seqlock.h	Mon Apr  7 10:31:14 2003
+++ linux-2.5.67-isize/include/linux/seqlock.h	Wed Apr 16 13:54:49 2003
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

--=-2aoKYgjfGOUqhSXEgvq6--

