Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbWFMCkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbWFMCkB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 22:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWFMCkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 22:40:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:50638 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932669AbWFMCkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 22:40:00 -0400
Subject: Replace kmalloc and memset in get_undo_list with kzalloc
From: Matt Helsley <matthltc@us.ibm.com>
To: trivial@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 19:31:05 -0700
Message-Id: <1150165865.21787.85.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies get_undo_list() by dropping the unnecessary cast,
removing the size variable, and switching to kzalloc() instead of a
kmalloc() followed by a memset().

This cleanup was split then modified from Jes Sorenson's Task Notifiers
patches.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Jes Sorensen <jes@sgi.com>
--

Compiles, boots.

 ipc/sem.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

Index: linux-2.6.17-rc6/ipc/sem.c
===================================================================
--- linux-2.6.17-rc6.orig/ipc/sem.c
+++ linux-2.6.17-rc6/ipc/sem.c
@@ -1002,19 +1002,16 @@ static inline void unlock_semundo(void)
  * This can block, so callers must hold no locks.
  */
 static inline int get_undo_list(struct sem_undo_list **undo_listp)
 {
 	struct sem_undo_list *undo_list;
-	int size;
 
 	undo_list = current->sysvsem.undo_list;
 	if (!undo_list) {
-		size = sizeof(struct sem_undo_list);
-		undo_list = (struct sem_undo_list *) kmalloc(size, GFP_KERNEL);
+		undo_list = kzalloc(sizeof(*undo_list), GFP_KERNEL);
 		if (undo_list == NULL)
 			return -ENOMEM;
-		memset(undo_list, 0, size);
 		spin_lock_init(&undo_list->lock);
 		atomic_set(&undo_list->refcnt, 1);
 		current->sysvsem.undo_list = undo_list;
 	}
 	*undo_listp = undo_list;


