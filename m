Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbTEHXTe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 19:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTEHXTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 19:19:33 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59783 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262246AbTEHXTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 19:19:31 -0400
Subject: [PATCH 2.5.69 1/2] i_size atomic access (again)
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052436552.2492.32.camel@ibm-c.pdx.osdl.net>
References: <1052436552.2492.32.camel@ibm-c.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-U+TLpLvmdTxTnP7zH1jl"
Organization: 
Message-Id: <1052436725.2492.38.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 08 May 2003 16:32:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U+TLpLvmdTxTnP7zH1jl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

With the patch attached.

On Thu, 2003-05-08 at 16:29, Daniel McNeil wrote:
> This adds a sequence counter only version of the reader/writer
> consistent mechanism to seqlock.h  This is used in the second
> part of this patch give atomic access to i_size.
> 
> re-diff against 2.5.69.
> 
> The patch is also available for download from OSDL's patch lifecycle 
> manager (PLM):
> 
> http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1834
-- 
Daniel McNeil <daniel@osdl.org>

--=-U+TLpLvmdTxTnP7zH1jl
Content-Disposition: attachment; filename=patch-2.5.69-isize.1
Content-Type: text/x-patch; name=patch-2.5.69-isize.1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -rupN -X /home/daniel/dontdiff linux-2.5.69/include/linux/seqlock.h linux-2.5.69-isize/include/linux/seqlock.h
--- linux-2.5.69/include/linux/seqlock.h	Sun May  4 16:53:14 2003
+++ linux-2.5.69-isize/include/linux/seqlock.h	Wed May  7 16:00:25 2003
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

--=-U+TLpLvmdTxTnP7zH1jl--

