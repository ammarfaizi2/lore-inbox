Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWINVjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWINVjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWINVjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:39:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21459 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751143AbWINVje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:39:34 -0400
Date: Thu, 14 Sep 2006 22:39:30 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 05/25] dm snapshot: make read and write exception functions void
Message-ID: <20060914213930.GM3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark McLoughlin <markmc@redhat.com>

read_exception() and write_exception() only return an error if
supplied with an out-of-range index.  If this ever happens it's the
result of a bug in the calling code so we handle this with an
assertion and remove the error handling in the callers.

Signed-off-by: Mark McLoughlin <markmc@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-exception-store.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-exception-store.c	2006-09-14 20:38:48.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-exception-store.c	2006-09-14 20:39:03.000000000 +0100
@@ -296,42 +296,29 @@ static int write_header(struct pstore *p
  */
 static struct disk_exception *get_exception(struct pstore *ps, uint32_t index)
 {
-	if (index >= ps->exceptions_per_area)
-		return NULL;
+	BUG_ON(index >= ps->exceptions_per_area);
 
 	return ((struct disk_exception *) ps->area) + index;
 }
 
-static int read_exception(struct pstore *ps,
-			  uint32_t index, struct disk_exception *result)
+static void read_exception(struct pstore *ps,
+			   uint32_t index, struct disk_exception *result)
 {
-	struct disk_exception *e;
-
-	e = get_exception(ps, index);
-	if (!e)
-		return -EINVAL;
+	struct disk_exception *e = get_exception(ps, index);
 
 	/* copy it */
 	result->old_chunk = le64_to_cpu(e->old_chunk);
 	result->new_chunk = le64_to_cpu(e->new_chunk);
-
-	return 0;
 }
 
-static int write_exception(struct pstore *ps,
-			   uint32_t index, struct disk_exception *de)
+static void write_exception(struct pstore *ps,
+			    uint32_t index, struct disk_exception *de)
 {
-	struct disk_exception *e;
-
-	e = get_exception(ps, index);
-	if (!e)
-		return -EINVAL;
+	struct disk_exception *e = get_exception(ps, index);
 
 	/* copy it */
 	e->old_chunk = cpu_to_le64(de->old_chunk);
 	e->new_chunk = cpu_to_le64(de->new_chunk);
-
-	return 0;
 }
 
 /*
@@ -349,10 +336,7 @@ static int insert_exceptions(struct psto
 	*full = 1;
 
 	for (i = 0; i < ps->exceptions_per_area; i++) {
-		r = read_exception(ps, i, &de);
-
-		if (r)
-			return r;
+		read_exception(ps, i, &de);
 
 		/*
 		 * If the new_chunk is pointing at the start of
