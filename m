Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVEIXXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVEIXXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVEIXWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:22:02 -0400
Received: from [151.97.230.9] ([151.97.230.9]:32786 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261392AbVEIXVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:21:38 -0400
Subject: [patch 2/6] uml: critical change memcpy to memmove [critical, for 2.6.12]
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 10 May 2005 00:45:12 +0200
Message-Id: <20050509224512.A9DFB13C214@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Replace one memcpy() call with overlapping source and dest arguments with one
call to memmove(), to avoid data corruption.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/irq_user.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/irq_user.c~uml-critical-change-memcpy-to-memmove arch/um/kernel/irq_user.c
--- linux-2.6.12/arch/um/kernel/irq_user.c~uml-critical-change-memcpy-to-memmove	2005-05-02 17:54:20.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/irq_user.c	2005-05-02 17:54:20.000000000 +0200
@@ -236,9 +236,15 @@ static void free_irq_by_cb(int (*test)(s
 				       (*prev)->fd, pollfds[i].fd);
 				goto out;
 			}
-			memcpy(&pollfds[i], &pollfds[i + 1],
-			       (pollfds_num - i - 1) * sizeof(pollfds[0]));
+
 			pollfds_num--;
+
+			/* This moves the *whole* array after pollfds[i] (though
+			 * it doesn't spot as such)! */
+
+			memmove(&pollfds[i], &pollfds[i + 1],
+			       (pollfds_num - i) * sizeof(pollfds[0]));
+
 			if(last_irq_ptr == &old_fd->next) 
 				last_irq_ptr = prev;
 			*prev = (*prev)->next;
_
