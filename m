Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283714AbRLHSi2>; Sat, 8 Dec 2001 13:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283718AbRLHSiS>; Sat, 8 Dec 2001 13:38:18 -0500
Received: from ns.ithnet.com ([217.64.64.10]:34565 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S283714AbRLHSiM>;
	Sat, 8 Dec 2001 13:38:12 -0500
Message-Id: <200112081838.TAA19684@webserver.ithnet.com>
From: Stephan von Krawczynski <skraw@ithnet.com>
Date: Sat, 08 Dec 2001 19:38:00 +0100
Subject: Typedefs / gcc / HIGHMEM
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,                                                            
                                                                      
I recently cam across a warning during compilation of kernel in       
/linux/drivers/net/tulip/interrupt.c. It looks like this:             
                                                                      
interrupt.c: In function `tulip_rx':                                  
interrupt.c:201: warning: unsigned int format, different type arg (arg
4)                                                                    
                                                                      
The source in question looks like this:                               
                                                                      
printk(KERN_ERR "%s: Internal fault: The skbuff addresses "           
"do not match in tulip_rx: %08x vs. %08x  %p / %p.\n",                
dev->name,                                                            
le32_to_cpu(tp->rx_ring[entry].buffer1),                              
tp->rx_buffers[entry].mapping,                                        
skb->head, temp);                                                     
                                                                      
Problem lies in tp->rx_buffers[entry].mapping which is of type        
dma_addr_t.                                                           
dma_addr_t is either defined as u32 (no highmem) or u64 (highmem).    
u32 is unsigned int.                                                  
u64 is unsigned long long                                             
                                                                      
The warning only occurs in the highmem-case. This obviously means that
gcc is not able to evaluate u64 as comparable to unsigned (long). We  
can fix this by casting the value, but on the other hand there seem to
be additional issues possible, the value-comparation one line above   
shows this:                                                           
                                                                      
if (tp->rx_buffers[entry].mapping !=                                  
   le32_to_cpu(tp->rx_ring[entry].buffer1)) {                         
                                                                      
The first is u64, the second u32. Either the u64 value is not         
required, or the statement is broken. Astonishing there is _no_       
compiler warning in this line.                                        
                                                                      
Has anybody looked across the kernel-code to verify if statements like
this are more widespread?                                             
                                                                      
BTW, my personal opinion to "typedef unsigned int u32" is that it     
should rather be "typedef unsigned long u32", but this is religious.  
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
