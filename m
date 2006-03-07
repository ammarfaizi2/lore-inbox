Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWCGVNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWCGVNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWCGVNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:13:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:59090 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932212AbWCGVNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:13:49 -0500
Date: Tue, 7 Mar 2006 15:13:44 -0600
From: Dean Roe <roe@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, riel@redhat.com
Subject: [PATCH] Prevent NULL pointer deref in grab_swap_token
Message-ID: <20060307211344.GA2946@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grab_swap_token() assumes that the current process has an mm struct,
which is not true for kernel threads invoking get_user_pages().  Since
this should be extremely rare, just return from grab_swap_token()
without doing anything.

	Signed-off-by: Dean Roe <roe@sgi.com>


Index: linux-2.6/mm/thrash.c
===================================================================
--- linux-2.6.orig/mm/thrash.c
+++ linux-2.6/mm/thrash.c
@@ -54,6 +54,9 @@
 	struct mm_struct *mm;
 	int reason;
 
+	if (current->mm == NULL)
+		return;
+
 	/* We have the token. Let others know we still need it. */
 	if (has_swap_token(current->mm)) {
 		current->mm->recent_pagein = 1;
