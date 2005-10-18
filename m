Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbVJRAly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVJRAly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVJRAly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:41:54 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:35065 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1751432AbVJRAlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:41:53 -0400
Message-ID: <43544499.5010601@oracle.com>
Date: Mon, 17 Oct 2005 17:40:57 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, hch@infradead.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [RFC] page lock ordering and OCFS2
References: <20051017222051.GA26414@tetsuo.zabbo.net> <20051017161744.7df90a67.akpm@osdl.org>
In-Reply-To: <20051017161744.7df90a67.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Zach Brown <zach.brown@oracle.com> wrote:
> 
>>
>>I sent an ealier version of this patch to linux-fsdevel and was met with
>>deafening silence.
> 
> 
> Maybe because nobody understood your description ;)

I have no trouble believing that :)  Adding the DLM to the already
complicated FS universe isn't exactly a barrel of laughs.

> The patch is of course pretty unwelcome: lots of weird stuff in the core
> VFS which everyone has to maintain but probably will not test.

Yeah, believe me, we want minimal impact.  With this patch we were
considering the whole kernel once OCFS2 was merged.  We think we *could*
probably handle this internally in OCFS2, it would just be a bit of a
mess.  It could conceivably involve ocfs2-local truncation loops that
check special lists of page pointers, that kind of thing.  It's unclear
to me which is the lesser evil.

> So I think we need a better understanding of what the locking inversion
> problem is, so we can perhaps find a better solution.  Bear in mind that
> ext3 has (rare, unsolved) lock inversion problems in this area as well, so
> commonality will be sought for.

This hits almost immediately with one node spinning with appending
writes (>> from the shell, say) and another node sitting in tail -f.  We
don't have the luxury of leaving it unsolved :(

I'd love to learn more about the ext3 case.  Maybe I'll bug Andreas :)

>>OCFS2 maintains page cache coherence between nodes by requiring that a node
>>hold a valid lock while there are active pages in the page cache.
> 
> "active pages in the page cache" means present pagecache pages in the node
> which holds pages in its pagecache, yes?

Yeah, a node associates a held DLM lock with the pages it has in its
page cache.  Other nodes might be doing the same thing, say, if they all
have read locks and all have cached reads in their page caches.  We can
illustrate the mechanics a little more by starting with that scenario
and adding another node who wants to write to this file (these
associations and locks are per-inode).  This new node will try to
acquire a write lock on the inode.  Before its write lock is granted it
will ask the other nodes to all drop their read locks.  As part of
dropping their locks they will invalidate their page caches.  In the
future those nodes will have to read the pages back from shared disk,
after having gotten the right to do so from the DLM..

I guess it's important to realize that DLM locks can remain valid
between system calls.  They're pinned by references *during* the system
calls, but they remain valid and held on the node between system calls
as long as another node doesn't send network messages asking them to be
dropped.

>> The page
>>cache is invalidated before a node releases a lock so that another node can
>>acquire it.  While this invalidation is happening new locks can not be acquired
>>on that node.  This is equivalent to a DLM processing thread acquiring
>>PG_locked during truncation while holding a DLM lock.  Normal file system user
>>tasks come to the a_ops with PG_locked acquired by their callers before they
>>have a chance to get DLM locks.
> 
> 
> So where is the lock inversion?
> 
> Perhaps if you were to cook up one of those little threadA/threadB ascii
> diagrams we could see where the inversion occurs?

Yeah, let me give that a try.  I'll try to trim it down to the relevant
bits.  First let's start with a totally fresh node and have a read get a
read DLM lock and populate the page cache on this node:

 sys_read
   generic_file_aio_read
     ocfs2_readpage
       ocfs2_data_lock
       block_read_full_page
       ocfs2_data_unlock

So it was only allowed to proceed past ocfs2_data_lock() towards
block_read_full_page() once the DLM granted it a read lock.  As it calls
ocfs2_data_unlock() it only is dropping this caller's local reference on
the lock.  The lock still exists on that node and is still valid and
holding data in the page cache until it gets a network message saying
that another node, who is probably going to be writing, would like the
lock dropped.

DLM kernel threads respond to the network messages and truncate the page
cache.  While the thread is busy with this inode's lock other paths on
that node won't be able get locks.  Say one of those messages arrives.
While a local DLM thread is invalidating the page cache another user
thread tries to read:

user thread				dlm thread


					kthread
					...
					ocfs2_data_convert_worker
					  truncate_inode_pages
sys_read
  generic_file_aio_read
    * gets page lock
    ocfs2_readpage
      ocfs2_data_lock
        (stuck waiting for dlm)
					    lock_page
					      (stuck waiting for page)


The user task holds a page lock while waiting for the DLM to allow it to
proceed.  The DLM thread is preventing lock granting progress while
waiting for the page lock that the user task holds.

I don't know how far to go in explaining what leads up to laying out the
locking like this.  It is typical (and OCFS2 used to do this) to wait
for the DLM locks up in file->{read,write} and pin them for the duration
of the IO.  This avoids the page lock and DLM lock inversion problem,
but it suffers from a host of other problems -- most fatally needing
that vma walking to govern holding multiple DLM locks during an IO.

Hmm, I managed to dig up a console log of a sysrq-T of one of the dlm
threads stuck in this state.. maybe it clarifies a little.  I can't seem
to find the matching read state, but it should be more comfortable..
ocfs2_readpage really is the first significant ocfs2 call in that path
and the first thing it does is ask the DLM for a read lock.

 [<c035a46e>] __wait_on_bit_lock+0x5e/0x70
 [<c0147934>] __lock_page+0x84/0x90
 [<c0154e47>] truncate_inode_pages_range+0x207/0x320
 [<c0154f91>] truncate_inode_pages+0x31/0x40
 [<d0f55978>] ocfs2_data_convert_worker+0x148/0x260 [ocfs2]
 [<d0f55540>] ocfs2_generic_unblock_lock+0x90/0x380 [ocfs2]
 [<d0f55b11>] ocfs2_unblock_data+0x81/0x360 [ocfs2]
 [<d0f5674d>] ocfs2_process_blocked_lock+0x9d/0x3f0 [ocfs2]
 [<d0f8b089>] ocfs2_vote_thread_do_work+0xa9/0x270 [ocfs2]
 [<d0f8b36f>] ocfs2_vote_thread+0x5f/0x170 [ocfs2]
 [<c0137c9a>] kthread+0xba/0xc0

I guess all that really illustrates its lots of funky DLM internals and
then truncate_inode_pages(). :)

Does this help?

- z
