Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVFAO5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFAO5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVFAO5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:57:12 -0400
Received: from kanga.kvack.org ([66.96.29.28]:11714 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261403AbVFAO5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:57:04 -0400
Date: Wed, 1 Jun 2005 10:59:14 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __mod_page_state - pass unsigned long instead of unsigned
Message-ID: <20050601145914.GA25250@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By making the offset argument of __mod_page_state an unsigned long instead 
of unsigned, we can avoid forcing the compiler to sign extend a usually 
constant argument.  This saves 1 instruction on x86-64.

		-ben

Signed-off-by: Benjamin LaHaise <benjamin.c.lahaise@intel.com>
diff -purN v2.6.12-rc5/include/linux/page-flags.h test-rc5/include/linux/page-flags.h
--- v2.6.12-rc5/include/linux/page-flags.h	2005-05-30 13:29:33.000000000 -0400
+++ test-rc5/include/linux/page-flags.h	2005-06-01 10:45:53.000000000 -0400
@@ -137,7 +137,7 @@ struct page_state {
 extern void get_page_state(struct page_state *ret);
 extern void get_full_page_state(struct page_state *ret);
 extern unsigned long __read_page_state(unsigned offset);
-extern void __mod_page_state(unsigned offset, unsigned long delta);
+extern void __mod_page_state(unsigned long offset, unsigned long delta);
 
 #define read_page_state(member) \
 	__read_page_state(offsetof(struct page_state, member))
diff -purN v2.6.12-rc5/mm/page_alloc.c test-rc5/mm/page_alloc.c
--- v2.6.12-rc5/mm/page_alloc.c	2005-05-30 13:29:34.000000000 -0400
+++ test-rc5/mm/page_alloc.c	2005-06-01 10:46:25.000000000 -0400
@@ -1128,7 +1128,7 @@ unsigned long __read_page_state(unsigned
 	return ret;
 }
 
-void __mod_page_state(unsigned offset, unsigned long delta)
+void __mod_page_state(unsigned long offset, unsigned long delta)
 {
 	unsigned long flags;
 	void* ptr;
