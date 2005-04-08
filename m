Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVDHSK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVDHSK2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVDHSK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:10:28 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:33789 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262911AbVDHSKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:10:05 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 08 Apr 2005 11:10:01 -0700
Message-Id: <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 15:40 +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, 2005-04-08 at 00:37, Mingming Cao wrote:
> 
> > Actually, we do not have to do an rbtree link and unlink for every
> > window we search.  If the reserved window(old) has no free bit and the
> > new reservable window's is right after the old one, no need to unlink
> > the old window from the rbtree and then link the new window, just update
> > the start and end of the old one.
> 
> It still needs to be done under locking to prevent us from expanding
> over the next window, though.  And having to take and drop a spinlock a
> dozen times or more just to find out that there are no usable free
> blocks in the current block group is still expensive, even if we're not
> actually fully unlinking the window each time.
> 

Isn't this a rare case? The whole group is relatively full and the free
bits are all reserved by other files.  Probably we should avoid trying
to make reservation in this block group at the first place, if we could
find a way to detect the number of _usable_ free bits are less than the
requested window size. 


> I wonder if this can possibly be done safely without locking?  It would
> be really good if we could rotate windows forward with no global locks. 
> At the very least, a fair rwlock would let us freeze the total layout of
> the tree, while still letting us modify individual windows safely.  As
> long as we use wmb() to make sure that we always extend the end of the
> window before we shrink the start of it, I think we could get away with
> such shared locking.  And rw locking is much better for concurrency, so
> we might be able to hold it over the whole bitmap search rather than
> taking it and dropping it at each window advance.
> 

You are proposing that we hold the read lock first, do the window search
and bitmap scan, then once we confirm there is free bit in the candidate
window, we grab the write lock and update the tree?  

I think this is a good idea to address case you have concerned: when we
need to do lots of window search before settle down. Also if later we
decide (I think we have discussed this before) to always try to reserve
the window with at least 8 contigous free blocks, the search will be
more expensive and the read lock will help.

However I am still worried that the rw lock will allow concurrent files
trying to lock the same window at the same time. Only one succeed
though., high cpu usage then.  And also, in the normal case the
filesystem is not really full, probably rw lock becomes expensive.



