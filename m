Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWF0XS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWF0XS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWF0XS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:18:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422719AbWF0XSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:18:25 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060627155549.786724cf.akpm@osdl.org> 
References: <20060627155549.786724cf.akpm@osdl.org>  <18192.1151320860@warthog.cambridge.redhat.com> <17567.31035.471039.999828@cse.unsw.edu.au> <17566.12727.489041.220653@cse.unsw.edu.au> <17564.52290.338084.934211@cse.unsw.edu.au> <15603.1150978967@warthog.cambridge.redhat.com> <553.1151156031@warthog.cambridge.redhat.com> <20946.1151251352@warthog.cambridge.redhat.com> <3087.1151403431@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, aviro@redhat.com,
       neilb@suse.de, jblunck@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Destroy the dentries contributed by a superblock on unmounting 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 28 Jun 2006 00:18:15 +0100
Message-ID: <15750.1151450295@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Is the cond_resched_lock() here safe?  Once we've dropped that lock, the
> list cursor `loop' is invalidated?

Yes.  Nothing else is permitted to modify the d_subdirs list.  Not the VFS,
not the filesystem, not the memory pressure shrinker.

> If all lookup paths to all entries on this list are removed at this time
> then OK - but these dentries are still on the LRU.

Ah... but the LRU shrinker may not touch dentries belonging to a filesystem
that's got s_umount writelocked (eg: one that's in the process of being
unmounted).  See prune_dcache():

		/*
		 * ...otherwise we need to be sure this filesystem isn't being
		 * unmounted, otherwise we could race with
		 * generic_shutdown_super(), and end up holding a reference to
		 * an inode while the filesystem is unmounted.
		 * So we try to get s_umount, and make sure s_root isn't NULL.
		 * (Take a local copy of s_umount to avoid a use-after-free of
		 * `dentry').
		 */
		s_umount = &dentry->d_sb->s_umount;
		if (down_read_trylock(s_umount)) {
			if (dentry->d_sb->s_root != NULL) {
				prune_one_dentry(dentry);
				up_read(s_umount);
				continue;
			}
			up_read(s_umount);
		}

		spin_unlock(&dentry->d_lock);

> (An answer-via-comment-patch would suit ;))

It is commented already:

/*
 * destroy the dentries attached to a superblock on unmounting
 * - we don't need to use dentry->d_lock, and only need dcache_lock when
 *   removing the dentry from the system lists and hashes because:
 *   - the superblock is detached from all mountings and open files, so the
 *     dentry trees will not be rearranged by the VFS
 *   - s_umount is write-locked, so the memory pressure shrinker will ignore
 *     any dentries belonging to this superblock that it comes across
 *   - the filesystem itself is no longer permitted to rearrange the dentries
 *     in this superblock
 */
void shrink_dcache_for_umount(struct super_block *sb)
{


Note the point about the memory pressure shrinker.

David
