Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAOQPm>; Mon, 15 Jan 2001 11:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbRAOQPd>; Mon, 15 Jan 2001 11:15:33 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:64648 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129729AbRAOQP0>; Mon, 15 Jan 2001 11:15:26 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware
Message-ID: <3A632215.981FAE01@fi.muni.cz>
Date: Mon, 15 Jan 2001 16:15:17 GMT
To: Linus Torvalds <torvalds@transmeta.com>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <Pine.LNX.4.10.10101121652160.8097-100000@penguin.transmeta.com>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test1-RTL3.0pre10 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 13 Jan 2001, Frank de Lange wrote:
> 
> IDE is not my favourite example of a "known stable driver". Also, in many
> cases IDE is for historical reasons connected to an EDGE io-apic pin (ie
> it's still considered an ISA interrupt). Which probably wouldn't show this
> problem anyway.

I've been having similar problem with my network card 3c59x. My BP6 was
hanging with 
50% probablity while running netscape from nfs mounted /usr partition).

For 2.2 kernel I've created this patch which has solved this problem
(so I don't have any problems until recentely I've started to use UDMA4
with ATA66
- but this seems to be related to BX chipset problem and as far as I
know Andre
is working on this issue)

While using this patch - I've got many messages about irq_enter in my
kernel log,
but the system was stable and running quite happy.

With the latest 2.4 kernels I do not have same problems (at least it
looks so far)
(So I assume the problem was hidden somewhere inside NFS).
However with 2.4.0 & ac patches I'm seeing some problem when one CPU is
locked
and the computer becomes unusable without any reason - there is no
network trafick
no ide intensive actions - all I can do is to move mouse within Xfree
(so maybe
its xfree bug - but its hard to recognize this - all I could say is that
I'm not seeing
such problems with -test12 kernels)


Here the patch for 2.2 I've been using:


--- linux.orig/arch/i386/kernel/irq.h   Wed May 31 11:21:04
2000                
+++ linux/arch/i386/kernel/irq.h        Wed May 31 11:21:47
2000                
@@ -138,8 +138,22
@@                                                            
 static inline void irq_enter(int cpu, unsigned int
irq)                        

{                                                                              
       
hardirq_enter(cpu);                                                     
-       while (test_bit(0,&global_irq_lock))
{                                  
-               /* nothing
*/;                                                  
+       if (global_irq_holder == cpu && test_bit(0, &global_irq_lock))
{        
+                printk(KERN_WARNING "irq_enter - CPU:%d already holder
(count:%
+                       cpu, global_irq_count,
local_irq_count[cpu]);           
+                /* avoid deadlock bellow
*/                                    
+               
clear_bit(0,&global_irq_lock);                                 
+        } else
{                                                               
+            unsigned long i =
1000000;                                         
+            while (test_bit(0,&global_irq_lock) && i)
{                        
+               
i--;                                                           
+                /* nothing
*/;                                                 
+           
}                                                                  
+            if (!i)
{                                                          
+               
clear_bit(0,&global_irq_lock);                                 
+                printk(KERN_WARNING "irq_enter - loop timeout CPU:%d 
Holder:%d!
+                       cpu,
global_irq_holder);                                
+           
}                                                                  
       
}                                                                       

}                                                                              
               printk(KERN_WARNING "irq_enter - loop timeout CPU:%d 
Holder:%d!

-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
