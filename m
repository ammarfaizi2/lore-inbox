Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbUJZP1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUJZP1t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUJZP1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:27:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262293AbUJZP10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:27:26 -0400
Date: Tue, 26 Oct 2004 11:27:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] SELinux: fix sidtab locking bug
Message-ID: <Xine.LNX.4.44.0410261120580.3811-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch by Kaigai Kohei fixes a bug in the SELinux sidtab code, where 
we do a spin_unlock_irq() while nested under another irq lock, which 
enables interrupts and allows a deadlock to happen:

  sidtab_set() is called between POLICY_WRLOCK and POLICY_WRUNLOCK in 
  services.c:1092. sidtab_set() uses SIDTAB_LOCK()/SIDTAB_UNLOCK(), but 
  SIDTAB_UNLOCK() enables any interruptions because it's defined as 
  spin_unlock_irq(). If an interruption occurs between SIDTAB_UNLOCK() and 
  POLICY_WRUNLOCK, and interruption context try to hold the POLICY_RDLOCK, 
  then a deadlock happen in the result.

The solution is to save & restore flags on the inner lock, per the patch 
below.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>
Signed-off-by: Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by: Kaigai Kohei <kaigai@ak.jp.nec.com>

---

 security/selinux/ss/sidtab.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff -purN -X dontdiff linux-2.6.9-mm1.p/security/selinux/ss/sidtab.c linux-2.6.9-mm1.w/security/selinux/ss/sidtab.c
--- linux-2.6.9-mm1.p/security/selinux/ss/sidtab.c	2004-08-14 01:37:25.000000000 -0400
+++ linux-2.6.9-mm1.w/security/selinux/ss/sidtab.c	2004-10-22 11:53:03.152654328 -0400
@@ -16,8 +16,8 @@
 (sid & SIDTAB_HASH_MASK)
 
 #define INIT_SIDTAB_LOCK(s) spin_lock_init(&s->lock)
-#define SIDTAB_LOCK(s) spin_lock_irq(&s->lock)
-#define SIDTAB_UNLOCK(s) spin_unlock_irq(&s->lock)
+#define SIDTAB_LOCK(s, x) spin_lock_irqsave(&s->lock, x)
+#define SIDTAB_UNLOCK(s, x) spin_unlock_irqrestore(&s->lock, x)
 
 int sidtab_init(struct sidtab *s)
 {
@@ -237,12 +237,13 @@ int sidtab_context_to_sid(struct sidtab 
 {
 	u32 sid;
 	int ret = 0;
+	unsigned long flags;
 
 	*out_sid = SECSID_NULL;
 
 	sid = sidtab_search_context(s, context);
 	if (!sid) {
-		SIDTAB_LOCK(s);
+		SIDTAB_LOCK(s, flags);
 		/* Rescan now that we hold the lock. */
 		sid = sidtab_search_context(s, context);
 		if (sid)
@@ -257,7 +258,7 @@ int sidtab_context_to_sid(struct sidtab 
 		if (ret)
 			s->next_sid--;
 unlock_out:
-		SIDTAB_UNLOCK(s);
+		SIDTAB_UNLOCK(s, flags);
 	}
 
 	if (ret)
@@ -320,17 +321,21 @@ void sidtab_destroy(struct sidtab *s)
 
 void sidtab_set(struct sidtab *dst, struct sidtab *src)
 {
-	SIDTAB_LOCK(src);
+	unsigned long flags;
+
+	SIDTAB_LOCK(src, flags);
 	dst->htable = src->htable;
 	dst->nel = src->nel;
 	dst->next_sid = src->next_sid;
 	dst->shutdown = 0;
-	SIDTAB_UNLOCK(src);
+	SIDTAB_UNLOCK(src, flags);
 }
 
 void sidtab_shutdown(struct sidtab *s)
 {
-	SIDTAB_LOCK(s);
+	unsigned long flags;
+
+	SIDTAB_LOCK(s, flags);
 	s->shutdown = 1;
-	SIDTAB_UNLOCK(s);
+	SIDTAB_UNLOCK(s, flags);
 }


