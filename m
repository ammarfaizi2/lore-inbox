Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273535AbRIYUsn>; Tue, 25 Sep 2001 16:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273533AbRIYUsd>; Tue, 25 Sep 2001 16:48:33 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17935 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273535AbRIYUsX>; Tue, 25 Sep 2001 16:48:23 -0400
Date: Tue, 25 Sep 2001 16:25:15 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <20010925134009.B14537@helen.CS.Berkeley.EDU>
Message-ID: <Pine.LNX.4.21.0109251620330.2193-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Sep 2001, Josh MacDonald wrote:

> Quoting Marcelo Tosatti (marcelo@conectiva.com.br):
> > 
> > 
> > On Tue, 25 Sep 2001, David S. Miller wrote:
> > 
> > >    From: Marcelo Tosatti <marcelo@conectiva.com.br>
> > >    Date: Tue, 25 Sep 2001 14:49:40 -0300 (BRT)
> > >    
> > >    Do you really need to do this ? 
> > >    
> > >                    if (unlikely(!spin_trylock(&pagecache_lock))) {
> > >                            /* we hold the page lock so the page cannot go away from under us */
> > >                            spin_unlock(&pagemap_lru_lock);
> > >    
> > >                            spin_lock(&pagecache_lock);
> > >                            spin_lock(&pagemap_lru_lock);
> > >                    }
> > >    
> > >    Have you actually seen bad hold times of pagecache_lock by
> > >    shrink_caches() ? 
> > > 
> > > Marcelo, this is needed because of the spin lock ordering rules.
> > > The pagecache_lock must be obtained before the pagemap_lru_lock
> > > or else deadlock is possible.  The spin_trylock is an optimization.
> > 
> > Not, it is not.
> > 
> > We can simply lock the pagecachelock and the pagemap_lru_lock at the
> > beginning of the cleaning function. page_launder() use to do that.
> 
> Since your main concern seems to be simplicity, the code can remain
> the way it is and be far more readable with, e.g.,
> 
> /* Aquire lock1 while holding lock2--reverse order. */
> #define spin_reverse_lock(lock1,lock2)     \
>     if (unlikely(!spin_trylock(&lock1))) { \           
>             spin_unlock(&lock2);           \        
>             spin_lock(&lock1);             \          
>             spin_lock(&lock2);             \        
>     }                                                          
> 
> You can't argue for simple in favor of increasing lock contention,
> but you can keep it readable.

Making the code readable is different from making it logically simple.

I've already seen pretty subtle races on the VM which were living for long
times (eg the latest race which Hugh and me found on
add_to_swap_cache/try_to_swap_out which was there since 2.4.early), so I
prefer to make the code as simpler as possible.

If there is really long hold times by shrink_cache(), then I agree to keep
the current snippet of code to avoid that.

