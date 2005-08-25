Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVHYPeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVHYPeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVHYPeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:34:00 -0400
Received: from everest.sosdg.org ([66.93.203.161]:52865 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S932151AbVHYPd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:33:59 -0400
From: "Coywolf Qi Hunt" <coywolf@sosdg.org>
Date: Thu, 25 Aug 2005 23:35:46 +0800
To: coywolf@sosdg.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <20050825153546.GA10202@gmail.com>
References: <20050825083751.GA4076@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825083751.GA4076@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Scan-Signature: a772fa79f254a9a4d3a3c5c6ceb66bb8
X-SA-Exim-Connect-IP: 66.93.203.161
X-SA-Exim-Mail-From: coywolf@sosdg.org
Subject: [patch] alloc_buffer_head() and free_buffer_head() cleanup
X-Spam-Report: * -0.0 BAYES_40 BODY: Bayesian spam probability is 40 to 44%
	*      [score: 0.4369]
X-SA-Exim-Version: 4.2 (built Tue, 12 Apr 2005 17:41:13 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 04:37:51PM +0800, Coywolf Qi Hunt wrote:
> Hello,
> 
> This cleanups up alloc_buffer_head(), by using a single get_cpu_var().
> Boot tested.
 
Also cleanup free_buffer_head().

 	Coywolf
 
 
Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

 buffer.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

--- 2.6.13-rc6-mm2/fs/buffer.c~orig	2005-08-25 22:50:29.000000000 +0800
+++ 2.6.13-rc6-mm2/fs/buffer.c	2005-08-25 23:03:32.000000000 +0800
@@ -3049,10 +3049,9 @@ struct buffer_head *alloc_buffer_head(un
 {
 	struct buffer_head *ret = kmem_cache_alloc(bh_cachep, gfp_flags);
 	if (ret) {
-		preempt_disable();
-		__get_cpu_var(bh_accounting).nr++;
+		get_cpu_var(bh_accounting).nr++;
 		recalc_bh_state();
-		preempt_enable();
+		put_cpu_var(bh_accounting);
 	}
 	return ret;
 }
@@ -3062,10 +3061,9 @@ void free_buffer_head(struct buffer_head
 {
 	BUG_ON(!list_empty(&bh->b_assoc_buffers));
 	kmem_cache_free(bh_cachep, bh);
-	preempt_disable();
-	__get_cpu_var(bh_accounting).nr--;
+	get_cpu_var(bh_accounting).nr--;
 	recalc_bh_state();
-	preempt_enable();
+	put_cpu_var(bh_accounting);
 }
 EXPORT_SYMBOL(free_buffer_head);
 
