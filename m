Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUCXUT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbUCXUT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:19:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261225AbUCXUTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:19:18 -0500
Date: Wed, 24 Mar 2004 12:19:14 -0800
From: "David S. Miller" <davem@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Compile problem on sparc64
Message-Id: <20040324121914.00fb9bf9.davem@redhat.com>
In-Reply-To: <1080130448.2515.108.camel@pegasus>
References: <1080130448.2515.108.camel@pegasus>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Please us sparclinux@vger.kernel.org in the future, thanks... ]

On Wed, 24 Mar 2004 13:15:22 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> I am using Debian Sid with GCC 3.3.3 (Debian 20040320) and I got the
> following error on my sparc64 platform while compiling the latest
> Bitkeeper sources from 2.6:

This should cure it, let me know if it doesn't.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/24 12:16:41-08:00 davem@nuts.davemloft.net 
#   [SPARC64]: Do not use cast exprs as lvalues.
# 
# include/asm-sparc64/pgalloc.h
#   2004/03/24 12:16:19-08:00 davem@nuts.davemloft.net +7 -6
#   [SPARC64]: Do not use cast exprs as lvalues.
# 
diff -Nru a/include/asm-sparc64/pgalloc.h b/include/asm-sparc64/pgalloc.h
--- a/include/asm-sparc64/pgalloc.h	Wed Mar 24 12:17:02 2004
+++ b/include/asm-sparc64/pgalloc.h	Wed Mar 24 12:17:02 2004
@@ -38,11 +38,12 @@
 
 	preempt_disable();
 	if (!page->lru.prev) {
-		(unsigned long *)page->lru.next = pgd_quicklist;
+		page->lru.next = (void *) pgd_quicklist;
 		pgd_quicklist = (unsigned long *)page;
 	}
-	(unsigned long)page->lru.prev |=
-		(((unsigned long)pgd & (PAGE_SIZE / 2)) ? 2 : 1);
+	page->lru.prev = (void *)
+	  (((unsigned long)page->lru.prev) |
+	   (((unsigned long)pgd & (PAGE_SIZE / 2)) ? 2 : 1));
 	pgd_cache_size++;
 	preempt_enable();
 }
@@ -62,7 +63,7 @@
 			off = PAGE_SIZE / 2;
 			mask &= ~2;
 		}
-		(unsigned long)ret->lru.prev = mask;
+		ret->lru.prev = (void *) mask;
 		if (!mask)
 			pgd_quicklist = (unsigned long *)ret->lru.next;
                 ret = (struct page *)(__page_address(ret) + off);
@@ -76,10 +77,10 @@
 		if (page) {
 			ret = (struct page *)page_address(page);
 			clear_page(ret);
-			(unsigned long)page->lru.prev = 2;
+			page->lru.prev = (void *) 2UL;
 
 			preempt_disable();
-			(unsigned long *)page->lru.next = pgd_quicklist;
+			page->lru.next = (void *) pgd_quicklist;
 			pgd_quicklist = (unsigned long *)page;
 			pgd_cache_size++;
 			preempt_enable();
