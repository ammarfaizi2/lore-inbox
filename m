Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbRHAW5A>; Wed, 1 Aug 2001 18:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbRHAW4u>; Wed, 1 Aug 2001 18:56:50 -0400
Received: from [63.209.4.196] ([63.209.4.196]:5125 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S267018AbRHAW4n>;
	Wed, 1 Aug 2001 18:56:43 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 1 Aug 2001 15:54:04 -0700
Message-Id: <200108012254.f71Ms4W14080@penguin.transmeta.com>
To: bristuccia@starentnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: repeated failed open()'s results in lots of used memory [Was: [Fwd: memory consumption]]
Newsgroups: linux.dev.kernel
In-Reply-To: <3B686D73.6040602@starentnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B686D73.6040602@starentnetworks.com> you write:
>
>Note that we increase the default values for certain FS parameters:
>
>echo '16384' >/proc/sys/fs/super-max
>echo '32768' >/proc/sys/fs/file-max
>echo '65535' > /proc/sys/fs/inode-max

Doesn't matter.

The thing that you end up hitting looks very much like just tons of
negative dentries lying around.

If you are even moderately confident about playing around with the
kernel, I would suggest testing the following approach (if you aren't
comforable with playing with the kernel, I hope somebody else is willing
to try this out, or I could try to cook up a patch to test later this
week)

 - add a new dentry list in addition to the current 'dentry_unused' list
   in linux/fs/dentry.c:

	static LIST_HEAD(dentry_unused_negative);

 - when 'dput()' adds a dentry to the old 'dentry_unused' list it would
   instead check whether the dentry is negative, and if so add it to the
   negative list instead:

	list = &dentry_unused;
	if (!dentry->d_inode)
		list = &dentry_unused_negative;
	list_add(&dentry->d_lru, list);

 - add a new "shrink_negative_dentries()" function that just does
   something like

	struct list_head *tmp;

	spin_lock(&dcache_lock);
	for (;;) {
		struct list_head * tmp = dentry_unused_negative.next;
		if (tmp == &dentry_unused_negative)
			break;
		struct dentry *dentry = list_entry(tmp, struct dentry, d_lru);
		tmp = tmp->next;
		if (atomic_read(&dentry->d_count))
			BUG();
		if (dentry->d_inode)
			BUG();
		prune_one_dentry(dentry);
		/* prune_one_dentry() releases the lock */
		spin_lock(&dcache_lock);
	}
	spin_unlock(&dcache_lock);

 - make all the things that shrink dentries (notably the
   shrink_dcache_memory() function) call the above function first. 

Does that fix the behaviour for you?

		Linus
