Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRKAV53>; Thu, 1 Nov 2001 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279802AbRKAV5U>; Thu, 1 Nov 2001 16:57:20 -0500
Received: from mailrelay3.inwind.it ([212.141.54.103]:32976 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S277012AbRKAV5I>; Thu, 1 Nov 2001 16:57:08 -0500
Message-Id: <3.0.6.32.20011101225943.01fee1b0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Thu, 01 Nov 2001 22:59:43 +0100
To: Stephan von Krawczynski <skraw@ithnet.com>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <200111012108.WAA28044@webserver.ithnet.com>
In-Reply-To: <3.0.6.32.20011101214957.01feaa70@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22.08 01/11/01 +0100, you wrote:
>> At 15.44 01/11/01 +0100, Stephan von Krawczynski wrote:             
>> >On Wed, 31 Oct 2001 22:31:40 +0100 Lorenzo Allegrucci              
><lenstra@tiscalinet.it>                                               
>> >wrote:                                                             
>> >                                                                   
>> >> Linus,                                                           
>> >>                                                                  
>> >> your patch seems to help one case out of three.                  
>> >> (even though I have not any meaningful statistical data)         
>> >                                                                   
>> >Hm, I will not say that I expected that :-), he knows by far more  
>than me.                                                              
>> >But can you try my patch below in addition or comparison to linus' 
>?                                                                     
>> >Give me a hint what happens.                                       
>>                                                                     
>> Well, your patch works but it hurts performance :(                  
>>
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100   
>> 71.500u 1.790s 2:29.18 49.1%    0+0k 0+0io 18498pf+0w               
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100   
>> 71.460u 1.990s 2:26.87 50.0%    0+0k 0+0io 18257pf+0w               
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100   
>> 71.220u 2.200s 2:26.82 50.0%    0+0k 0+0io 18326pf+0w               
>> 0:55 kswapd                                                         
>>                                                                     
>> Linux-2.4.14-pre5:                                                  
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100   
>> 70.340u 3.450s 2:13.62 55.2%    0+0k 0+0io 16829pf+0w               
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100   
>> 70.590u 2.940s 2:15.48 54.2%    0+0k 0+0io 17182pf+0w               
>> lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100   
>> 70.140u 3.480s 2:14.66 54.6%    0+0k 0+0io 17122pf+0w               
>> 0:01 kswapd                                                         
>                                                                      
>Hello Lorenzo,                                                        
>                                                                      
>to be honest: I expected that. The patch according to my knowledge    
>fixes a "definition hole" in the shrink_cache algorithm. I tend to say
>it is the right thing to do it this way, but I am sure it is not as   
>fast as immediate exit to swap. It would be interesting to know if  it
>does hurt performance in not-near-oom environment. I'd say Andrea or  
>Linus might know that, or you can try, of course :-)                  

400M of swap now (from 200M), Linux-2.4.14-pre6 + your vmscan-patch:

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.320u 2.260s 2:28.92 49.4%    0+0k 0+0io 18755pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.330u 2.120s 2:28.40 49.4%    0+0k 0+0io 18838pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.880u 2.100s 2:28.31 49.8%    0+0k 0+0io 18646pf+0w
0:56 kswapd

qsbench vsize is just 343M, definitely not-near-oom environment :)

>Anyway may I beg you to post my patch and your answer to the list,    
>because I currently cannot do it (I am not in office right now, but on
>a web-terminal somewhere in the outbacks ;-). I have neither patch at 
>hand nor am I able to attach it with this mailer...                   
>                                                                      
>Thanks,                                                               
>Stephan                                                               

your vmscan-patch:

--- linux-orig/mm/vmscan.c	Wed Oct 31 12:32:11 2001
+++ linux/mm/vmscan.c	Thu Nov  1 15:38:13 2001
@@ -469,16 +469,10 @@
 			spin_unlock(&pagecache_lock);
 			UnlockPage(page);
 page_mapped:
-			if (--max_mapped >= 0)
-				continue;
+			if (max_mapped > 0)
+				max_mapped--;
+			continue;
 
-			/*
-			 * Alert! We've found too many mapped pages on the
-			 * inactive list, so we start swapping out now!
-			 */
-			spin_unlock(&pagemap_lru_lock);
-			swap_out(priority, gfp_mask, classzone);
-			return nr_pages;
 		}
 
 		/*
@@ -514,6 +508,14 @@
 		break;
 	}
 	spin_unlock(&pagemap_lru_lock);
+
+	/*
+	 * Alert! We've found too many mapped pages on the
+	 * inactive list, so we start swapping out - delayed!
+	 * -skraw
+	 */
+	if (max_mapped==0)
+		swap_out(priority, gfp_mask, classzone);
 
 	return nr_pages;
 }



-- 
Lorenzo
