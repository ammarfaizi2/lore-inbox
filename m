Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVCTQ6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVCTQ6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 11:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCTQ6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 11:58:16 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:31455 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261238AbVCTQ6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 11:58:11 -0500
Message-ID: <423DAB73.2030904@colorfullife.com>
Date: Sun, 20 Mar 2005 17:57:23 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       dipankar@in.ibm.com, shemminger@osdl.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, rusty@au1.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, gh@us.ibm.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption and RCU
References: <20050318002026.GA2693@us.ibm.com>	 <20050318091303.GB9188@elte.hu> <20050318092816.GA12032@elte.hu>	 <423BB299.4010906@colorfullife.com> <20050319162601.GA28958@elte.hu>	 <423D19FE.7020902@colorfullife.com> <1111310736.17944.24.camel@tglx.tec.linutronix.de>
In-Reply-To: <1111310736.17944.24.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:

>On Sun, 2005-03-20 at 07:36 +0100, Manfred Spraul wrote:
>  
>
>>cpu 1:
>>acquire random networking spin_lock_bh()
>>
>>cpu 2:
>>read_lock(&tasklist_lock) from process context
>>interrupt. softirq. within softirq: try to acquire the networking lock.
>>* spins.
>>
>>cpu 1:
>>hardware interrupt
>>within hw interrupt: signal delivery. tries to acquire tasklist_lock.
>>
>>--> deadlock.
>>    
>>
>
>Signal delivery from hw interrupt context (interrupt is flagged
>SA_NODELAY) is not possible in RT preemption mode. The
>local_irq_save_nort() check in __cache_alloc will catch you.
>
>  
>
That was just one random example.
Another one would be :

drivers/chat/tty_io.c, __do_SAK() contains
    read_lock(&tasklist_lock);
    task_lock(p);

kernel/sys.c, sys_setrlimit contains
    task_lock(current->group_leader);
    read_lock(&tasklist_lock);

task_lock is a shorthand for spin_lock(&p->alloc_lock). If read_lock is 
a normal spinlock, then this is an A/B B/A deadlock.

--
    Manfred
