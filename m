Return-Path: <linux-kernel-owner+w=401wt.eu-S1423133AbWLUXdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423133AbWLUXdR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 18:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423132AbWLUXdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 18:33:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57154 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423130AbWLUXdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 18:33:16 -0500
Date: Fri, 22 Dec 2006 00:30:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mm: export cancel_dirty_page()
Message-ID: <20061221233018.GA28046@elte.hu>
References: <20061221231328.GA21217@elte.hu> <20061221232850.GJ6993@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221232850.GJ6993@stusta.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> On Fri, Dec 22, 2006 at 12:13:28AM +0100, Ingo Molnar wrote:
> > From: Ingo Molnar <mingo@elte.hu>
> > Subject: [patch] export cancel_dirty_page()
> > 
> > export cancel_dirty_page() - it's used by hugetlbfs which can be 
> > modular. (This makes my -git based kernel yum repository build again.)
> >...
> 
> No, it can't be:
> 
> config HUGETLBFS
>         bool "HugeTLB file system support"
>         ^^^^

ah, indeed - but i dont see a fundamental reason why hugetlbfs is not 
modular. Nevertheless exporting this makes sense. My quick hack below to 
guess to convert reiserfs (just to make the rpm build) also needs it.

	Ingo

Index: linux/fs/reiserfs/stree.c
===================================================================
--- linux.orig/fs/reiserfs/stree.c
+++ linux/fs/reiserfs/stree.c
@@ -1439,6 +1439,8 @@ static void unmap_buffers(struct page *p
 
 	if (page) {
 		if (page_has_buffers(page)) {
+			cancel_dirty_page(page, PAGE_CACHE_SIZE);
+
 			tail_index = pos & (PAGE_CACHE_SIZE - 1);
 			cur_index = 0;
 			head = page_buffers(page);
@@ -1458,9 +1460,6 @@ static void unmap_buffers(struct page *p
 				}
 				bh = next;
 			} while (bh != head);
-			if (PAGE_SIZE == bh->b_size) {
-				clear_page_dirty(page);
-			}
 		}
 	}
 }
