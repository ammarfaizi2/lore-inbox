Return-Path: <linux-kernel-owner+w=401wt.eu-S965081AbXATHF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbXATHF6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 02:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbXATHF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 02:05:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:60459 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965081AbXATHF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 02:05:57 -0500
Date: Sat, 20 Jan 2007 08:05:46 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: [patch] buffer: memorder fix
Message-ID: <20070120070546.GC30774@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anyone mind telling me why unlock_buffer, unlike unlock_page, thinks it can
clear the lock without ensuring the critical section is closed (ie. with a
barrier)?

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -78,6 +78,7 @@ EXPORT_SYMBOL(__lock_buffer);
 
 void fastcall unlock_buffer(struct buffer_head *bh)
 {
+	smp_mb__before_clear_bit();
 	clear_buffer_locked(bh);
 	smp_mb__after_clear_bit();
 	wake_up_bit(&bh->b_state, BH_Lock);
