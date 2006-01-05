Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWAEA44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWAEA44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWAEAub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:63673 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750966AbWAEAtx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:53 -0500
Cc: pavlic@de.ibm.com
Subject: [PATCH] klist: Fix broken kref counting in find functions
In-Reply-To: <1136422170815@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:30 -0800
Message-Id: <11364221703195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] klist: Fix broken kref counting in find functions

The klist reference counting in the find functions that use
klist_iter_init_node is broken.  If the function (for example
driver_find_device) is called with a NULL start object then everything is
fine, the first call to next_device()/klist_next increases the ref-count of
the first node on the list and does nothing for the start object which is
NULL.

If they are called with a valid start object then klist_next will decrement
the ref-count for the start object but nobody has incremented it.  Logical
place to fix this would be klist_iter_init_node because the function puts a
reference of the object into the klist_iter struct.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>
Cc: Patrick Mochel <mochel@digitalimplant.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e22dafbcd7a579c29a424d5203b5b33b131948a7
tree 122969a87ba706be8374beb15bc03493e3601404
parent bf74ad5bc41727d5f2f1c6bedb2c1fac394de731
author Frank Pavlic <pavlic@de.ibm.com> Sat, 26 Nov 2005 20:48:40 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:08 -0800

 lib/klist.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/klist.c b/lib/klist.c
index bb2f355..9c94f0b 100644
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -199,6 +199,8 @@ void klist_iter_init_node(struct klist *
 	i->i_klist = k;
 	i->i_head = &k->k_list;
 	i->i_cur = n;
+	if (n)
+		kref_get(&n->n_ref);
 }
 
 EXPORT_SYMBOL_GPL(klist_iter_init_node);

