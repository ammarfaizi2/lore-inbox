Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263327AbTJBK0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 06:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbTJBK0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 06:26:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34512 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263327AbTJBK0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 06:26:46 -0400
Date: Thu, 2 Oct 2003 11:26:45 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
Message-ID: <20031002102644.GA7665@parcelfarce.linux.theplanet.co.uk>
References: <1064936688.4222.14.camel@localhost.localdomain> <200309302006.32584.vitaly@namesys.com> <1065019441.4226.1.camel@localhost.localdomain> <16251.5348.570797.101912@laputa.namesys.com> <20031001184338.GW7665@parcelfarce.linux.theplanet.co.uk> <16251.63770.622805.143036@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16251.63770.622805.143036@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 02:08:26PM +0400, Nikita Danilov wrote:
 
> 1. r_start() call sget() and this seems somewhat expensive (sget()
> starts by allocating new super block just for case) to be done at the
> beginning of each read operation, especially given that we already have
> pointer to the super block. Probably slook() function that only looks
> for the super block without creating it would be useful.
> 
> 2. More importantly, sget() doesn't actually seem to provide protection
> against races with umount (which I think is its purpose): test_sb
> callback will succeed for any super block with the same *address*, which
> may be (and will be, given slab allocator) some completely unrelated
> super block that just happened to be allocated at the same address as
> (already freed) de->parent->data. Roughly speaking, super block in
> de->parent->data is untrusted pointer and, as such, is almost completely
> useless.

That's OK.  Yes, we could get reused superblock.  Which is perfectly fine,
since
	a) whatever superblock we get, we know that it won't go away
	b) if it had been reused, we will know that immediately - in that
case ->put_super() had already run its course and thus de->deleted had
been set before sget() had returned.

IOW, sget() alone would *not* be enough, but sget() + check for ->deleted +
desactivate_super() if ->deleted was set *is*.  See how it works?

The first point is true and applies not only to that case - indeed, sget()
is pessimistic.  It should be dealt with in sget() itself, though, and it's
easy to deal with.  The same way as iget() does it.

diff -urN B6-rest/fs/super.c B6-current/fs/super.c
--- B6-rest/fs/super.c	Sat Sep 27 22:04:57 2003
+++ B6-current/fs/super.c	Thu Oct  2 06:23:22 2003
@@ -226,13 +226,10 @@
 			int (*set)(struct super_block *,void *),
 			void *data)
 {
-	struct super_block *s = alloc_super();
+	struct super_block *s = NULL;
 	struct list_head *p;
 	int err;
 
-	if (!s)
-		return ERR_PTR(-ENOMEM);
-
 retry:
 	spin_lock(&sb_lock);
 	if (test) list_for_each(p, &type->fs_supers) {
@@ -242,9 +239,18 @@
 			continue;
 		if (!grab_super(old))
 			goto retry;
-		destroy_super(s);
+		if (s)
+			destroy_super(s);
 		return old;
 	}
+	if (!s) {
+		spin_unlock(&sb_lock);
+		s = alloc_super();
+		if (!s)
+			return ERR_PTR(-ENOMEM);
+		goto retry;
+	}
+		
 	err = set(s, data);
 	if (err) {
 		spin_unlock(&sb_lock);
