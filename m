Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbTCTV42>; Thu, 20 Mar 2003 16:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbTCTV42>; Thu, 20 Mar 2003 16:56:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:65197 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262633AbTCTV4Y>;
	Thu, 20 Mar 2003 16:56:24 -0500
Date: Thu, 20 Mar 2003 16:12:30 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Patch] ext3_journal_stop inode access
Message-Id: <20030320161230.3c4e0f47.akpm@digeo.com>
In-Reply-To: <1048196202.2491.603.camel@sisko.scot.redhat.com>
References: <1048185825.2491.386.camel@sisko.scot.redhat.com>
	<20030320131523.6c56d10f.akpm@digeo.com>
	<1048196202.2491.603.camel@sisko.scot.redhat.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2003 22:07:13.0539 (UTC) FILETIME=[0FAD7D30:01C2EF2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> Well, there's still the
> 
> 	if (err)
> 		__ext3_std_error(inode->i_sb, where, err);
> 
> case in ext3_journal_stop() to worry about

We already have that.

int __ext3_journal_stop(const char *where, handle_t *handle)
{
	struct super_block *sb;
	int err;
	int rc;

	sb = handle->h_transaction->t_journal->j_private;
	err = handle->h_err;
	rc = journal_stop(handle);

	sb->s_dirt = 1;
	if (!err)
		err = rc;
	if (err)
		__ext3_std_error(sb, where, err);
	return err;
}

> , so we still need it; and I'd
> much rather not hack this via j_private, when what we're doing at this
> point is most definitely a fs-specific, not journal-related, operation.

I don't think it's a hack at all.  ext3 owns the journal and there is plenty
of precedent for putting owner-private things into owned objects.

But I'm not particularly fussed either way - it will only be 100-200 bytes of
code saved.

> I was wondering why we've never seen this on 2.4, even with slab
> poisoning enabled.  But I think the vulnerability exists on 2.4 too, so
> yes, we ought to keep the two in sync.

It could be due to differences in inode reclaim.  If 2.4 sees an inode with
attached pages it will skip it.  2.5 will instead detach the pages and free
the inode.

And writepage() doesn't get used much in 2.4.

Plus this bug was hit on a preemptible kernel where the timing windows are
much wider.

> Well, the intent of the s_dirt was to force a call to ext3_write_super
> when the fs was dirty, back before the days when we had a sync_fs()
> method at all.  Now that we have the latter, it sounds like we should
> actually just drop the line which sets s_dirt in ext3_journal_stop
> entirely, because sync will always call the new sync_fs which will do
> the commit that we need.

OK.

> We still have the error handling path in ext3_journal_stop so we can't
> avoid having to find the sb, so _some_ rejigging is still needed.

That is available from the handle.  (And via
ext3_journal_current_handle()->j_private, even).

The journal and the superblock have a definite one-to-one relationship - I think the
backpointer makes sense.  But whatever - I'll let you flip that coin.

