Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUHJRYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUHJRYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUHJRXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:23:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267523AbUHJRUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:20:30 -0400
Date: Tue, 10 Aug 2004 13:20:24 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org, Matt Domsch <Matt_Domsch@dell.com>,
       Ernie Petrides <petrides@redhat.com>
Subject: [PATCH] reserved buffers only for PF_MEMALLOC
Message-ID: <Pine.LNX.4.44.0408101310580.7156-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The buffer allocation path in 2.4 has a long standing bug,
where non-PF_MEMALLOC tasks can dig into the reserved pool
in get_unused_buffer_head().  The following patch makes the
reserved pool only accessible to PF_MEMALLOC tasks.

Other processes will loop in create_buffers() - the only
function that calls get_unused_buffer_head() - and will call
try_to_free_pages(GFP_NOIO), freeing any buffer heads that
have become freeable due to IO completion.

Note that PF_MEMALLOC tasks will NOT do anything inside
try_to_free_pages(), so it is needed that they are able to
dig into the reserved buffer heads while other tasks are
not.

Signed-off-by:  Rik van Riel <riel@redhat.com>

--- linux/fs/buffer.c.deadlock	2004-08-10 11:33:08.000000000 -0400
+++ linux/fs/buffer.c	2004-08-10 11:34:54.000000000 -0400
@@ -1260,8 +1260,9 @@ struct buffer_head * get_unused_buffer_h
 
 	/*
 	 * If we need an async buffer, use the reserved buffer heads.
+	 * Non-PF_MEMALLOC tasks can just loop in create_buffers().
 	 */
-	if (async) {
+	if (async && (current->flags & PF_MEMALLOC)) {
 		spin_lock(&unused_list_lock);
 		if (unused_list) {
 			bh = unused_list;

