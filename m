Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbVJRBZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVJRBZJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVJRBZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:25:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28085 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751431AbVJRBZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:25:07 -0400
Date: Mon, 17 Oct 2005 18:24:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, adilger@clusterfs.com
Subject: Re: [RFC] page lock ordering and OCFS2
Message-Id: <20051017182407.1f2c591a.akpm@osdl.org>
In-Reply-To: <43544499.5010601@oracle.com>
References: <20051017222051.GA26414@tetsuo.zabbo.net>
	<20051017161744.7df90a67.akpm@osdl.org>
	<43544499.5010601@oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zach.brown@oracle.com> wrote:
>
> > So where is the lock inversion?
> > 
> > Perhaps if you were to cook up one of those little threadA/threadB ascii
> > diagrams we could see where the inversion occurs?
> 
> Yeah, let me give that a try.  I'll try to trim it down to the relevant
> bits.  First let's start with a totally fresh node and have a read get a
> read DLM lock and populate the page cache on this node:
> 
>  sys_read
>    generic_file_aio_read
>      ocfs2_readpage
>        ocfs2_data_lock
>        block_read_full_page
>        ocfs2_data_unlock
> 
> So it was only allowed to proceed past ocfs2_data_lock() towards
> block_read_full_page() once the DLM granted it a read lock.  As it calls
> ocfs2_data_unlock() it only is dropping this caller's local reference on
> the lock.  The lock still exists on that node and is still valid and
> holding data in the page cache until it gets a network message saying
> that another node, who is probably going to be writing, would like the
> lock dropped.
> 
> DLM kernel threads respond to the network messages and truncate the page
> cache.  While the thread is busy with this inode's lock other paths on
> that node won't be able get locks.  Say one of those messages arrives.
> While a local DLM thread is invalidating the page cache another user
> thread tries to read:
> 
> user thread				dlm thread
> 
> 
> 					kthread
> 					...
> 					ocfs2_data_convert_worker

                                        I assume there's an ocfs2_data_lock
                                        hereabouts?

> 					  truncate_inode_pages
> sys_read
>   generic_file_aio_read
>     * gets page lock
>     ocfs2_readpage
>       ocfs2_data_lock
>         (stuck waiting for dlm)
> 					    lock_page
> 					      (stuck waiting for page)
> 

Why does ocfs2_readpage() need to take ocfs2_data_lock?  (Is
ocfs2_data_lock a range-based read-lock thing, or what?)

> The user task holds a page lock while waiting for the DLM to allow it to
> proceed.  The DLM thread is preventing lock granting progress while
> waiting for the page lock that the user task holds.
> 
> I don't know how far to go in explaining what leads up to laying out the
> locking like this.  It is typical (and OCFS2 used to do this) to wait
> for the DLM locks up in file->{read,write} and pin them for the duration
> of the IO.  This avoids the page lock and DLM lock inversion problem,
> but it suffers from a host of other problems -- most fatally needing
> that vma walking to govern holding multiple DLM locks during an IO.

Oh.

Have you considered using invalidate_inode_pages() instead of
truncate_inode_pages()?  If that leaves any pages behind, drop the read
lock, sleep a bit, try again - something klunky like that might get you out
of trouble, dunno.


