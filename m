Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVJRROz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVJRROz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 13:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVJRROz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 13:14:55 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:24462 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S1750870AbVJRROy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 13:14:54 -0400
Message-ID: <43552D7C.3010003@oracle.com>
Date: Tue, 18 Oct 2005 10:14:36 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, hch@infradead.org,
       Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [RFC] page lock ordering and OCFS2
References: <20051017222051.GA26414@tetsuo.zabbo.net>	<20051017161744.7df90a67.akpm@osdl.org>	<43544499.5010601@oracle.com> <20051017182407.1f2c591a.akpm@osdl.org>
In-Reply-To: <20051017182407.1f2c591a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>user thread				dlm thread
>>
>>
>>					kthread
>>					...
>>					ocfs2_data_convert_worker
> 
> 
>                                         I assume there's an ocfs2_data_lock
>                                         hereabouts?

No.  The thread is working behind the scenes to bring the lock to a
state where others can get the lock again.  It doesn't explicitly hold
the lock like regular fs paths do, but no one else can get the lock
until it finishes its work.

A wild over-simplification of the logic goes something like this:

dlm_lock(lock) {
	wait_event(, !lock->blocked);
	atomic_inc(&lock->ref);
}

dlm_unlock(lock) {
	if (atomic_dec_and_test(&lock->ref) {
		wake_worker_thread()
	}
}

incoming_drop_message() {
	lock->blocked = 1;
	wake_worker_thread();
}

worker_thread() {
	wait_event(, atomic_read(&lock->ref) == 0);
	truncate_inode_pages();
	lock->blocked = 0;
}

It's much worse than that, but that's the basic idea for our problem
here.  A network message comes in which forbids additional acquiry of
the lock until all the current holders have released it and the the
worker thread has truncated the page cache.

So in our inversion ocfs2_readpage() holds a page lock while waiting in
dlm_lock() for ->blocked to be clear, but worker_thread() can't clear
->blocked until it locks and truncates the page that ocfs2_readpage() holds.

> Have you considered using invalidate_inode_pages() instead of
> truncate_inode_pages()?  If that leaves any pages behind, drop the read
> lock, sleep a bit, try again - something klunky like that might get you out
> of trouble, dunno.

Yeah, that doesn't work because the locked pages aren't making forward
progress.  In the read case it would be fine to just skip them, they're
about to be re-read once ocfs2_readpage() gets its DLM lock.  But we'd
have to strongly identify locked pages waiting in ocfs2_readpage().  And
in the write case the DLM thread is responsible writing those pages back
before releasing the lock so that other nodes can read the pages in.

We think we could do this sort of thing with a specific truncation loop,
but that's the nasty code I wasn't sure would be any more acceptable
than this nasty core patch.  The truncation loop would need a way to
identify locked pages that it can just ignore or initiate writeback on
because it'd know that it's just another ocfs2 path that holds the page
lock while waiting for a dlm lock.  I wonder if we could just do it with
PG_fs_misc.  I can give it a try if that doesn't send shivers down
everyone's spine.

- z

