Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267635AbUHFCuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267635AbUHFCuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268089AbUHFCuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:50:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:60575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267635AbUHFCue (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:50:34 -0400
Date: Thu, 5 Aug 2004 19:50:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
In-Reply-To: <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408051923420.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <200408042216.12215.gene.heskett@verizon.net> <Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Aug 2004, Linus Torvalds wrote:
> 
> I _suspect_ you hit the new "list_del-debug.patch" in Andrew's tree, 
> because in my tree there are no BUG_ON's in prune_cache() at all. 

Hmm.. I'm starting to have a wild suspicion here.

Let's look at this: the d_lru list is used for dentries that have had 
their count go down to zero in dput() (which is most of them, actually), 
and we do _not_ move them away from the unused list when we increment 
their count again, because we don't want to take the dcache lock in the 
critical lookup region.

So what we do to determine whether they are on the list or not is not to
look at the count, but is we mark dentries that are _not_ on the LRU list
by making their d_lru list be empty. This is why the dcache code uses the
"careful"  delete function "list_del_init()" a lot - because when we
remove the dentry from the unused list, we really need to _mark_ it
removed. Then the removal code does

	if (!list_empty(&dentry->d_lru)) ..

Fine. HOWEVER. Sometimes we use the plain "list_del()", because we know 
that we're going to throw the dentry away. And in shrink_dcache_anon() we 
do it because we expect to add it back to the dentry list.

BUT WE DON'T ALWAYS DO THAT!

So as far as I can tell, shrink_dcache_anon() will have _removed_ a dentry 
from the unused_list, but still left the dentry with wild pointers 
pointing to other dentries. Next time around we do a dput() on such a 
dentry, we'll be screwed, because we'll try to remove it again. Boom.

Does anybody see why this isn't a serious dentry list corruption case? Or 
am I just crazy?

But if I'm right, this particular bug should only hit you if you export a
filesystem through knfsd (I don't see how you'd get an anonymous dentry 
any other way). Oh. XFS with some of the magic ioctls will do it too. But 
I don't think Gene had either of those enabled, so..

But this may explain _some_ of the dcache problems, and maybe we have 
more than one bug here. Comments? Am I getting senile?

		Linus

----
===== fs/dcache.c 1.88 vs edited =====
--- 1.88/fs/dcache.c	2004-06-24 01:55:55 -07:00
+++ edited/fs/dcache.c	2004-08-05 19:35:03 -07:00
@@ -628,7 +628,7 @@
 			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
 			if (!list_empty(&this->d_lru)) {
 				dentry_stat.nr_unused--;
-				list_del(&this->d_lru);
+				list_del_init(&this->d_lru);
 			}
 
 			/* 
