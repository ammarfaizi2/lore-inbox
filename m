Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264618AbTDYALI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTDYAJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 20:09:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:44440 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264602AbTDYAIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 20:08:50 -0400
Subject: [PATCH 2.5.68 1/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-wYx3ds37+cTnPTIOHWxJ"
Organization: 
Message-Id: <1051230054.2448.14.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Apr 2003 17:20:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wYx3ds37+cTnPTIOHWxJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds a sequence counter only version of the reader/writer
consistent mechanism to seqlock.h  This is used in the second
part of this patch give atomic access to i_size.

re-diff against 2.5.68.

The patch is also available for download from OSDL's patch lifecycle 
manager (PLM):
http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1801

Thanks,
-- 
Daniel McNeil <daniel@osdl.org>

--=-wYx3ds37+cTnPTIOHWxJ
Content-Disposition: attachment; filename=patch-2.5.68-isize.1
Content-Type: text/x-troff-man; name=patch-2.5.68-isize.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.5.68/include/linux/seqlock.h	Sat Apr 19 19:49:23 2003
+++ linux-2.5.68-isize/include/linux/seqlock.h	Thu Apr 24 14:30:57 2003
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

--=-wYx3ds37+cTnPTIOHWxJ--

