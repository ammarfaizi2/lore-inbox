Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVF0PVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVF0PVx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVF0PMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:12:13 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:49120 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261296AbVF0OZ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:25:56 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Vladimir Saveliev <vs@namesys.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, zam@namesys.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050627090640.GA5410@infradead.org>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <20050627090640.GA5410@infradead.org>
Content-Type: text/plain
Message-Id: <1119882343.4256.358.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 27 Jun 2005 18:25:43 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Mon, 2005-06-27 at 13:06, Christoph Hellwig wrote:
> On Mon, Jun 20, 2005 at 11:54:58PM -0700, Andrew Morton wrote:
> > reiser4
> 
> So looking over the code a little for the plugin debate I found that a
> reason patch introduces a ->put_inode method in reiser4.  We plan to
> kill ->put_inode because it's the wrong abstraction and almost impossible
> to use non-racy (reiser4 usage is racy).

Sorry, would you please explain what is wrong in having the below

if (inode->i_nlink != 0 || atomic_read(&inode->i_count) > 1)

in reiser4_put_inode.


> I had a discussion with someone from namesys how to solve this correctly,

We were trying to avoid need to have reiser4_drop_inode because you said
drop_inode is a hack for hugetlbfs.

The problem is that on file removal reiser4 wants to do
truncate_inode_pages in reiser4_delete_inode. We used reiser4_drop_inode
for that. As long as drop_inode was about to die, we decided to do file
predeletion in reiser4_put_inode when inode is about to get into
iput_final with inode->i_nlink == 0.

It is a pity that put_inode is also wrong abstraction.

> but I don't remember the details of either the solution or problem anymore.

You said:
--------
So what you want is actually to move the  truncate_inode_pages out of
generic_delete_inode and into ->delete_inode?


Looking at the code another strategt makes more sense:

 - move the truncate_inode_pages at the beginning of clear_inode.
   All callers but one already do it just before that call, but
   the one that doesn't will require a full audit of all ->delete_inode
   instances
 - make the first half of clear_inode into a helper (__clear_inode or
   whatever), and make ->clear_inode responsible for calling it as first
   thing for a normal fs or call it in clear_inode if ->clear_inode
doesn't
   exist.  that way we can also move the invalidate_inode_buffers out
there
   easily later for filesystems that don't use buffer_heads at all.

p.s. please try to keep -fsdevel Cc'ed on the mail related to core
changes
-------

I hoped that we can solve the problem internally in reiser4. If
put_inode is about to be removed we will have to do ssomething like
that.


> Unless someone else does let's describe the problem again so we can find
> a proper fix.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

