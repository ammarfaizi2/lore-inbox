Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTDQUcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTDQUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:32:35 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:40945 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S262578AbTDQUce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:32:34 -0400
Date: Thu, 17 Apr 2003 21:46:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] stop swapoff 1/3 vm_enough_memory?
Message-ID: <Pine.LNX.4.44.0304172142530.2039-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of three small "stop swapoff" patches based on 2.5.67-mm3:

 include/linux/sched.h |    1 +
 mm/oom_kill.c         |    2 ++
 mm/swapfile.c         |   21 +++++++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

stop swapoff 1/3 vm_enough_memory?

Before embarking upon swapoff, check vm_enough_memory.  Mainly
for consistency in the overcommit_memory 2 (strict accounting) case:
fail with -ENOMEM if it wouldn't let the amount removed be committed.

Will always succeed in the overcommit_memory 1 case, as it should in
root-shoot-foot mode.  In the overcommit_memory 0 case, well, I don't
care much either way, so opted for the simplest code: no special case.
Which means it could now fail at the start; but that's unlikely (case 0
is over-generous) and only when it would have got stuck later on anyway.

--- 2.5.67-mm3/mm/swapfile.c	Mon Apr 14 13:05:36 2003
+++ swapoff1/mm/swapfile.c	Thu Apr 17 18:32:40 2003
@@ -7,6 +7,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
@@ -1030,12 +1031,18 @@
 		}
 		prev = type;
 	}
-	err = -EINVAL;
 	if (type < 0) {
+		err = -EINVAL;
+		swap_list_unlock();
+		goto out_dput;
+	}
+	if (vm_enough_memory(p->pages))
+		vm_unacct_memory(p->pages);
+	else {
+		err = -ENOMEM;
 		swap_list_unlock();
 		goto out_dput;
 	}
-
 	if (prev < 0) {
 		swap_list.head = p->next;
 	} else {

