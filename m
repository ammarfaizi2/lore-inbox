Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279930AbRKBCRu>; Thu, 1 Nov 2001 21:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279931AbRKBCRl>; Thu, 1 Nov 2001 21:17:41 -0500
Received: from ns.ithnet.com ([217.64.64.10]:1043 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279930AbRKBCRa>;
	Thu, 1 Nov 2001 21:17:30 -0500
Message-Id: <200111020217.DAA30459@webserver.ithnet.com>
Date: Fri, 02 Nov 2001 03:17:17 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Lorenzo Allegrucci <lenstra@tiscalinet.it>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Content-Transfer-Encoding: 7BIT
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
To: Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111011634340.12377-100000@penguin.transmeta.com>
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                                                     
> On Fri, 2 Nov 2001, Stephan von Krawczynski wrote:                  
> >                                                                   
> > To clarify this one a bit:                                        
> > shrink_cache is thought to do what it says, it is given a number  
of                                                                    
> > pages it should somehow manage to free by shrinking the cache.    
What my                                                               
> > patch does is go after the _whole_ list to fulfill that.          
>                                                                     
> I would suggest a slight modification: make "max_mapped" grow as the
> priority goes up.                                                   
>                                                                     
> Right now max_mapped is fixed at "nr_pages*10".                     
>                                                                     
> You could have something like                                       
>                                                                     
> 	max_mapped = nr_pages * 60 / priority;                             
>                                                                     
> instead, which might also alleviate the problem with not even       
bothering to                                                          
> scan much of the inactive list simply because 99% of all pages are  
mapped.                                                               
>                                                                     
> That way you don't waste time on looking at the rest of the inactive
list                                                                  
> until you _need_ to.                                                
                                                                      
Wait a minute: there is something illogical in this approach:         
Basically you say by making max_mapped bigger that the "early exit"   
from shrink_cache shouldn't be that early. But if you _know_ that     
merely all pages are mapped, then why don't you just go to swap_out   
right away without even walking through the list, because in the end, 
you will go to swap_out anyway (simply because of the high percentage 
of mapped pages). That makes scanning somehow superfluous. Making it  
priority-dependant sounds like you want to swap_out earlier the       
_lower_ memory pressure is. In the end it sounds just like a hack to  
hold up the early exit against every logic (but not against some      
benchmark of course).                                                 
It doesn't sound like the right thing.                                
Is the inactive list somehow sorted currently? If not, could it be    
implicitly sorted to match this criteria (not mapped versa mapped), so
that shrink_cache finds the not-mapped first (with a chance to fulfill
nr_pages-request). If it isn't fulfilled and hits the first mapped    
page, it can go to swap_out right away, because more scanning doesn't 
make sense and can only end in swap_out anyways.                      
                                                                      
I am no fan of complete list scanning, but if you are looking for     
something you have to scan until you find it.                         
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
PS: I am still no pro in this area, so I try to go after the global   
picture and find the right direction...                               
                                                                      
                                                                      
                                                                      
