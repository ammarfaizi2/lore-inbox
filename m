Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVDFFgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVDFFgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVDFFgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:36:03 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:42450 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262104AbVDFFfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:35:55 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Ingo Molnar <mingo@elte.hu>, sct@redhat.com
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050405041359.GA17265@elte.hu>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 05 Apr 2005 22:35:51 -0700
Message-Id: <1112765751.3874.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 06:13 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I can trigger latencies up to ~1.1 ms with a CVS checkout.  It looks
> > like inside ext3_try_to_allocate_with_rsv, we spend a long time in this
> > loop:
> > 
> > ext3_test_allocatable (bitmap_search_next_usable_block)
> > find_next_zero_bit (bitmap_search_next_usable_block)
> > find_next_zero_bit (bitmap_search_next_usable_block)
> > 
> > ext3_test_allocatable (bitmap_search_next_usable_block)
> > find_next_zero_bit (bitmap_search_next_usable_block)
> > find_next_zero_bit (bitmap_search_next_usable_block)
> 
> Breaking the lock is not really possible at that point, and it doesnt 
> look too easy to make that path preemptable either. (To make it 
> preemptable rsv_lock would need to become a semaphore (this could be 
> fine, as it's only used when a new reservation window is created).)

It seems we are holding the rsv_block while searching the bitmap for a
free bit.  In alloc_new_reservation(), we first find a available to
create a reservation window, then we check the bitmap to see if it
contains any free block. If not, we will search for next available
window, so on and on. During the whole process we are holding the global
rsv_lock.  We could, and probably should, avoid that.  Just unlock the
rsv_lock before the bitmap search and re-grab it after it.  We need to
make sure that the available space that are still available after we re-
grab the lock. 

Another option is to hold that available window before we release the
rsv_lock, and if there is no free bit inside that window, we will remove
it from the tree in the next round of searching for next available
window.

I prefer the second option, and plan to code it up soon. Any comments?

Thanks,

Mingming

