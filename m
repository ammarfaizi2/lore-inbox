Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVKXOwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVKXOwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVKXOwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:52:41 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:49819 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751246AbVKXOwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:52:40 -0500
Date: Thu, 24 Nov 2005 15:51:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: [patch] broken kref-counting in find functions.
Message-ID: <20051124145132.GA5057@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Pavlic <pavlic@de.ibm.com>

[patch] broken kref-counting in find functions.

The klist reference counting in the find functions that use
klist_iter_init_node is broken. If the function (for example
driver_find_device) is called with a NULL start object then
everything is fine, the first call to next_device()/klist_next
increases the ref-count of the first node on the list and does
nothing for the start object which is NULL.
If they are called with a valid start object then klist_next
will decrement the ref-count for the start object but nobody
has incremented it. Logical place to fix this would be
klist_iter_init_node because the function puts a reference
of the object into the klist_iter struct.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

---

diff -urpN linux-2.6/lib/klist.c linux-2.6-patched/lib/klist.c
--- linux-2.6/lib/klist.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/lib/klist.c	2005-11-23 18:33:34.000000000 +0100
@@ -199,6 +199,8 @@ void klist_iter_init_node(struct klist *
 	i->i_klist = k;
 	i->i_head = &k->k_list;
 	i->i_cur = n;
+	if (n)
+		kref_get(&n->n_ref);
 }
 
 EXPORT_SYMBOL_GPL(klist_iter_init_node);
