Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279856AbRKAXfm>; Thu, 1 Nov 2001 18:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279857AbRKAXfc>; Thu, 1 Nov 2001 18:35:32 -0500
Received: from ns.ithnet.com ([217.64.64.10]:46094 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279856AbRKAXfa>;
	Thu, 1 Nov 2001 18:35:30 -0500
Message-Id: <200111012335.AAA29493@webserver.ithnet.com>
Date: Fri, 02 Nov 2001 00:35:23 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>
Content-Transfer-Encoding: 7BIT
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
In-Reply-To: <3.0.6.32.20011101225943.01fee1b0@pop.tiscalinet.it>
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At 22.08 01/11/01 +0100, you wrote:                                 
> >> Well, your patch works but it hurts performance :(               
                                                                      
> >>                                                                  
> >> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
                                                                      
> >> 71.500u 1.790s 2:29.18 49.1%    0+0k 0+0io 18498pf+0w            
                                                                      
> >> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
                                                                      
> >> 71.460u 1.990s 2:26.87 50.0%    0+0k 0+0io 18257pf+0w            
                                                                      
> >> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
                                                                      
> >> 71.220u 2.200s 2:26.82 50.0%    0+0k 0+0io 18326pf+0w            
                                                                      
> >> 0:55 kswapd                                                      
                                                                      
> >>                                                                  
                                                                      
> >> Linux-2.4.14-pre5:                                               
                                                                      
> >> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
                                                                      
> >> 70.340u 3.450s 2:13.62 55.2%    0+0k 0+0io 16829pf+0w            
                                                                      
> >> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
                                                                      
> >> 70.590u 2.940s 2:15.48 54.2%    0+0k 0+0io 17182pf+0w            
                                                                      
> >> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
                                                                      
> >> 70.140u 3.480s 2:14.66 54.6%    0+0k 0+0io 17122pf+0w            
                                                                      
> >> 0:01 kswapd                                                      
                                                                      
> >                                                                   
                                                                      
> >Hello Lorenzo,                                                     
                                                                      
> >                                                                   
                                                                      
> >to be honest: I expected that. The patch according to my knowledge 
                                                                      
> >fixes a "definition hole" in the shrink_cache algorithm. I tend to 
say                                                                   
> >it is the right thing to do it this way, but I am sure it is not as
                                                                      
> >fast as immediate exit to swap. It would be interesting to know if 
it                                                                    
> >does hurt performance in not-near-oom environment. I'd say Andrea  
or                                                                    
> >Linus might know that, or you can try, of course :-)               
                                                                      
To clarify this one a bit:                                            
shrink_cache is thought to do what it says, it is given a number of   
pages it should somehow manage to free by shrinking the cache. What my
patch does is go after the _whole_ list to fulfill that. One cannot   
really say that this is the wrong thing to do, I guess. If it takes   
time to _find_ free pages with shrink_cache, then probably the idea to
use it was wrong in the first place (which is not the fault of the    
function itself). Or the number of free-pages to find is to high, or  
(as a last but guess unrealistic approach) the swap_out eats the time 
and shouldn't be called when nr_pages (return value) is equal to zero.
This last one could be checked (hint hint Lorenzo ;-) by simply       
modifiying                                                            
                                                                      
if (max_swapped==0)                                                   
                                                                      
to                                                                    
                                                                      
if (max_swapped==0 && nr_pages>0)                                     
                                                                      
at the end of shrink_cache.                                           
Thinking again about this it really sounds like the right choice,     
because there is no need to swap when we fulfilled the requested      
number of free-pages.                                                 
                                                                      
You should try.                                                       
                                                                      
Thank you for your patience Lorenzo                                   
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
PS: just fishing for lobster, Linus ;-)                               
                                                                      
                                                                      
