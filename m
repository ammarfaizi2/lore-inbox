Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273541AbRIYUld>; Tue, 25 Sep 2001 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273537AbRIYUlX>; Tue, 25 Sep 2001 16:41:23 -0400
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:58037 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S273526AbRIYUlO>; Tue, 25 Sep 2001 16:41:14 -0400
Date: Tue, 25 Sep 2001 13:40:09 -0700
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010925134009.B14537@helen.CS.Berkeley.EDU>
In-Reply-To: <20010925.125758.94556009.davem@redhat.com> <Pine.LNX.4.21.0109251539150.2193-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0109251539150.2193-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Sep 25, 2001 at 03:40:23PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marcelo Tosatti (marcelo@conectiva.com.br):
> 
> 
> On Tue, 25 Sep 2001, David S. Miller wrote:
> 
> >    From: Marcelo Tosatti <marcelo@conectiva.com.br>
> >    Date: Tue, 25 Sep 2001 14:49:40 -0300 (BRT)
> >    
> >    Do you really need to do this ? 
> >    
> >                    if (unlikely(!spin_trylock(&pagecache_lock))) {
> >                            /* we hold the page lock so the page cannot go away from under us */
> >                            spin_unlock(&pagemap_lru_lock);
> >    
> >                            spin_lock(&pagecache_lock);
> >                            spin_lock(&pagemap_lru_lock);
> >                    }
> >    
> >    Have you actually seen bad hold times of pagecache_lock by
> >    shrink_caches() ? 
> > 
> > Marcelo, this is needed because of the spin lock ordering rules.
> > The pagecache_lock must be obtained before the pagemap_lru_lock
> > or else deadlock is possible.  The spin_trylock is an optimization.
> 
> Not, it is not.
> 
> We can simply lock the pagecachelock and the pagemap_lru_lock at the
> beginning of the cleaning function. page_launder() use to do that.

Since your main concern seems to be simplicity, the code can remain
the way it is and be far more readable with, e.g.,

/* Aquire lock1 while holding lock2--reverse order. */
#define spin_reverse_lock(lock1,lock2)     \
    if (unlikely(!spin_trylock(&lock1))) { \           
            spin_unlock(&lock2);           \        
            spin_lock(&lock1);             \          
            spin_lock(&lock2);             \        
    }                                                          

You can't argue for simple in favor of increasing lock contention,
but you can keep it readable.

-josh
