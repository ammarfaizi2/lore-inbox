Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319087AbSHMWhD>; Tue, 13 Aug 2002 18:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319089AbSHMWhD>; Tue, 13 Aug 2002 18:37:03 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:5602 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S319087AbSHMWhB> convert rfc822-to-8bit; Tue, 13 Aug 2002 18:37:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Date: Tue, 13 Aug 2002 17:29:50 -0500
X-Mailer: KMail [version 1.4]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208131729.50127.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > People in our benchmarking group (Andrew, cc'ed) have told me that
> > reducing the frequency of IO-APIC reprogramming by a factor of 20 or
> > so improves performance greatly - don't know what HZ that was at, but
> > the whole thing seems a little overenthusiastic to me.

I thought I saw a big difference in 2.4, but my latest runs could not 
reproduce this.  I also tested Andrea's version 
http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc3aa1/30_irq-balance-12
which addresses some of the problems:

[email to Andrea]
> Andrea,
> 
> I have some irqbalance results.  For some reason, Ingo's isn't performing as 
> bad as I thought on 2.4.  Your patch still performs better.  These results 
> are from NetBench, a CIFS network fileserver benchmark on a samba linux
> 4-way 
> P4 server:
> 
> 2.4.19-rc3aa3:
> 
> No Balance    Ingo IRQ Balance        Andrea IRQ Balance
> 794 Mbps              787 Mbps                        792 Mbps
> 
> With hyperthreading:
> 
> No Balance    Ingo IRQ Balance        Andrea IRQ Balance
> 773 Mbps              798 Mbps                        809 Mbps

Before I tried hyperthreading, no balance was always best performance, but 
"unfair".  However, with hyperthreading, (Andrea's) IRQbalance can be the 
best, probably because an interrupt rate of that level just can't be 
processed by "1/2" of a CPU and would benefit from a distrubution.  I did 
make a run on 2.5.25 a few weeks ago.  With IRQbalance turned off, I was 10% 
better.  I have not had a chance to try Andrea's in 2.5 but I suspect it 
would be best overall, since he compensates for HZ:
#define IRQ_BALANCE_INTERVAL (HZ/50) 
and does not seem to reprogram the IO-APIC as often.  IMO, I think Andrea's 
version is a little less aggressive and has less overhead, something I'd 
prefer in 2.5. 

-Andrew Theurer



