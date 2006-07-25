Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWGYPUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWGYPUZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 11:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWGYPUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 11:20:25 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:64727 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964775AbWGYPUY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 11:20:24 -0400
Subject: [PATCH] [nfsd] Add lock annotations to e_start and e_stop
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       nfs@lists.sourceforge.net
Content-Type: text/plain
Date: Tue, 25 Jul 2006 08:20:24 -0700
Message-Id: <1153840824.12517.9.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e_start acquires svc_export_cache.hash_lock, and e_stop releases it.  Add lock
annotations to these two functions so that sparse can check callers for lock
pairing, and so that sparse will not complain about these functions since they
intentionally use locks in this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/nfsd/export.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 01bc68c..6fe54eb 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1078,6 +1078,7 @@ exp_pseudoroot(struct auth_domain *clp, 
 /* Iterator */
 
 static void *e_start(struct seq_file *m, loff_t *pos)
+	__acquires(svc_export_cache.hash_lock)
 {
 	loff_t n = *pos;
 	unsigned hash, export;
@@ -1131,6 +1132,7 @@ static void *e_next(struct seq_file *m, 
 }
 
 static void e_stop(struct seq_file *m, void *p)
+	__releases(svc_export_cache.hash_lock)
 {
 	read_unlock(&svc_export_cache.hash_lock);
 	exp_readunlock();


