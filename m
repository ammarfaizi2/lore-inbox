Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277293AbRJJP7s>; Wed, 10 Oct 2001 11:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277295AbRJJP7j>; Wed, 10 Oct 2001 11:59:39 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:37383 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S277288AbRJJP7Y>;
	Wed, 10 Oct 2001 11:59:24 -0400
Date: Wed, 10 Oct 2001 09:54:36 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010095436.A8784@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15299.64114.664515.425183@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 05:36:18PM +1000, Paul Mackerras wrote:
> Linus Torvalds writes:
> 
> > And THAT is the hard part. Doing lookup without locks ends up being
> > pretty much worthless, because you need the locks for the removal
> > anyway, at which point the whole thing looks pretty moot.
> > 
> > Did I miss something?
> 
> I believe this all becomes (much more) useful when you are doing
> read-copy-update.
> 
> There is an assumption that anyone modifying the list (inserting or
> deleting) would take a lock first, so the deletion is just a pointer
> assignment.  Any reader traversing the list (without a lock) sees
> either the old pointer or the new, which is fine.
> 
> The difficulty is in making sure that no reader is still inspecting
> the list element you just removed before you free it, or modify any
> field that the reader would be looking at (particularly the `next'
> field :).  One way of doing that is to defer the free or modification
> to a quiescent point.  If you have a separate `next_free' field, you
> could safely put the element on a list of elements to be freed at the
> next quiescent point.


And the "next quiescent point" must be a synchronization point and that must
have spinlocks around it!
Although I kind of like the idea of
	normal operation create mess by avoiding synchronization
	when system seems idle, get BKL, and clean up. 


> 
> Paul.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
