Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbTFSSCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbTFSSCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:02:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265877AbTFSSCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:02:35 -0400
Subject: [PATCH 2.5.72 1/2] i_size atomic access
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Content-Type: multipart/mixed; boundary="=-5fZdQvXIMEaAytk7UvwN"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Jun 2003 11:16:56 -0700
Message-Id: <1056046616.17359.18.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5fZdQvXIMEaAytk7UvwN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds a sequence counter only version of the reader/writer
consistent mechanism to seqlock.h  This is used in the second
part of this patch give atomic access to i_size.

re-diff against 2.5.72.

The patch is also available for download from OSDL's patch lifecycle 
manager (PLM):

http://www.osdl.org/cgi-bin/plm?module=patch_info&patch_id=1939

Daneil McNeil <daniel@osdl.org>

--=-5fZdQvXIMEaAytk7UvwN
Content-Disposition: attachment; filename=patch.2.5.72-isize.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch.2.5.72-isize.1; charset=ISO-8859-1

diff -rupN -X /home/daniel_nfs/dontdiff linux-2.5.72/include/linux/seqlock.=
h linux-2.5.72-isize/include/linux/seqlock.h
--- linux-2.5.72/include/linux/seqlock.h	2003-06-16 21:20:00.000000000 -070=
0
+++ linux-2.5.72-isize/include/linux/seqlock.h	2003-06-17 16:56:25.15995628=
9 -0700
@@ -94,6 +94,57 @@ static inline int read_seqretry(const se
 	return (iv & 1) | (sl->sequence ^ iv);
 }
=20
+
+/*
+ * Version using sequence counter only.=20
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
+#define seqcnt_init(x)	do { *(x) =3D (seqcnt_t) SEQCNT_ZERO; } while (0)
+
+/* Start of read using pointer to a sequence counter only.  */
+static inline unsigned read_seqcntbegin(const seqcnt_t *s)
+{
+	unsigned ret =3D s->sequence;
+	smp_rmb();
+	return ret;
+}
+
+/* Test if reader processed invalid data.
+ * Equivalent to: iv is odd or sequence number has changed.
+ *                (iv & 1) || (*s !=3D iv)
+ * Using xor saves one conditional branch.
+ */
+static inline int read_seqcntretry(const seqcnt_t *s, unsigned iv)
+{
+	smp_rmb();
+	return (iv & 1) | (s->sequence ^ iv);
+}
+
+
+/*=20
+ * Sequence counter only version assumes that callers are using their
+ * own mutexing.
+ */
+static inline void write_seqcntbegin(seqcnt_t *s)
+{
+	s->sequence++;
+	smp_wmb();		=09
+}=09
+
+static inline void write_seqcntend(seqcnt_t *s)=20
+{
+	smp_wmb();
+	s->sequence++;
+}
+
 /*
  * Possible sw/hw IRQ protected versions of the interfaces.
  */

--=-5fZdQvXIMEaAytk7UvwN--

