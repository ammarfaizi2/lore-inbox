Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279944AbRKBCbK>; Thu, 1 Nov 2001 21:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279945AbRKBCbB>; Thu, 1 Nov 2001 21:31:01 -0500
Received: from ns.ithnet.com ([217.64.64.10]:28691 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S279944AbRKBCau>;
	Thu, 1 Nov 2001 21:30:50 -0500
Message-Id: <200111020230.DAA30535@webserver.ithnet.com>
Date: Fri, 02 Nov 2001 03:30:36 +0100
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
                                                                      
Ok. I re-checked the code and found out this approach cannot stand.   
the list scan _is_ already exited early when priority is low:         
                                                                      
        int max_scan = nr_inactive_pages / priority;                  
                                                                      
        while (--max_scan >= 0 && (entry = inactive_list.prev) !=     
&inactive_list) {                                                     
                                                                      
It will not make big sense to do it again in max_mapped.              
                                                                      
On the other hand I am also very sure, that refining:                 
                                                                      
        if (max_mapped==0)                                            
                swap_out(priority, gfp_mask, classzone);              
                                                                      
        return nr_pages;                                              
                                                                      
in the end to:                                                        
                                                                      
        if (max_mapped==0 && nr_pages>0)                              
                swap_out(priority, gfp_mask, classzone);              
                                                                      
        return nr_pages;                                              
                                                                      
is a good thing. We don't need swap_out if we gained all the pages    
requested, no matter if we _could_ do it or not.                      
                                                                      
Is there some performance difference in this approach, Lorenzo? I     
guess it should.                                                      
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
