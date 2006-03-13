Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWCMVi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWCMVi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWCMViz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:38:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932461AbWCMViy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:38:54 -0500
Date: Mon, 13 Mar 2006 13:36:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 004 of 4] Make address_space_operations->invalidatepage
 return void
Message-Id: <20060313133625.26496547.akpm@osdl.org>
In-Reply-To: <1142277225.9949.3.camel@kleikamp.austin.ibm.com>
References: <20060313104910.15881.patches@notabene>
	<1060312235331.15985@suse.de>
	<1142267531.9971.5.camel@kleikamp.austin.ibm.com>
	<1142277225.9949.3.camel@kleikamp.austin.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:
>
> On Mon, 2006-03-13 at 10:32 -0600, Dave Kleikamp wrote:
>  > I'll try to stress test jfs with these patches to see if I can trigger
>  > the an oops here.
> 
>  While stress testing on a jfs volume (dbench), I hit an assert in jbd:
> 
>  Assertion failure in journal_invalidatepage() at fs/jbd/transaction.c:1920: "!page_has_buffers(page)"

Yes, thanks, that assertion has become wrong.

--- devel/fs/jbd/transaction.c~make-address_space_operations-invalidatepage-return-void-jbd-fix	2006-03-13 13:33:12.000000000 -0800
+++ devel-akpm/fs/jbd/transaction.c	2006-03-13 13:33:12.000000000 -0800
@@ -1915,9 +1915,8 @@ void journal_invalidatepage(journal_t *j
 	} while (bh != head);
 
 	if (!offset) {
-		/* Maybe should BUG_ON !may_free - neilb */
-		try_to_free_buffers(page);
-		J_ASSERT(!page_has_buffers(page));
+		if (may_free && try_to_free_buffers(page))
+			J_ASSERT(!page_has_buffers(page));
 	}
 }
 

However I'm more inclined to drop the whole patch, really - having
->invalidatepage() return a success indication makes sense.  The fact that
we're currently not using that return value doesn't mean that we shouldn't,
didn't and won't.
