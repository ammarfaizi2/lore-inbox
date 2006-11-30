Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758530AbWK3HVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758530AbWK3HVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758529AbWK3HVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:21:02 -0500
Received: from ns1.suse.de ([195.135.220.2]:47518 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1758518AbWK3HVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:21:00 -0500
Date: Thu, 30 Nov 2006 08:20:58 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: [patch 1/3] mm: pagecache write deadlocks zerolength fix
Message-ID: <20061130072058.GA18004@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


writev with a zero-length segment is a noop, and we shouldn't return EFAULT.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/linux/pagemap.h
===================================================================
--- linux-2.6.orig/include/linux/pagemap.h
+++ linux-2.6/include/linux/pagemap.h
@@ -198,6 +198,9 @@ static inline int fault_in_pages_writeab
 {
 	int ret;
 
+	if (unlikely(size == 0))
+		return 0;
+
 	/*
 	 * Writing zeroes into userspace here is OK, because we know that if
 	 * the zero gets there, we'll be overwriting it.
@@ -222,6 +225,9 @@ static inline int fault_in_pages_readabl
 	volatile char c;
 	int ret;
 
+	if (unlikely(size == 0))
+		return 0;
+
 	ret = __get_user(c, uaddr);
 	if (ret == 0) {
 		const char __user *end = uaddr + size - 1;
