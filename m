Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbTDPPMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTDPPM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:12:29 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:4515 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264378AbTDPPM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:12:27 -0400
Message-ID: <3E9D755A.8060601@colorfullife.com>
Date: Wed, 16 Apr 2003 17:23:06 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: Catalin BOIE <util@deuroconsult.ro>, Tomas Szepe <szepe@pinerecords.com>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] qdisc oops fix
References: <20030415084706.O1131@shell.cyberus.ca> <Pine.LNX.4.53.0304160838001.25861@hosting.rdsbv.ro> <20030416072952.E4013@shell.cyberus.ca>
In-Reply-To: <20030416072952.E4013@shell.cyberus.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

>This is a different problem from previous one posted.
>
>Theres a small window (exposed given that you are provisioning a lot
>of qdiscs  and running traffic at the same time) that an incoming packet
>interupt will cause the BUG().
>
>GFP_ATOMIC will fix it, but i wonder if it appropriate.
>  
>
This is a 2.4 kernel, correct?

>>With many rules (~5000 classes and ~3500 qdiscs and ~50000 filters)
>>the kernel oopses in slab.c:1128.
>>
This check?
       if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
                BUG();
It's triggered, because someone does something like
    spin_lock_bh(&my_lock);
    p = kmalloc(,GFP_KERNEL);

I don't like the proposed fix: usually code that calls 
kmalloc(,GFP_KERNEL) assumes that it runs at process space, e.g. uses 
semaphores, or non-bh spinlocks, etc.
slab just happens to contain a test that complains about illegal calls.

>>Trace; c0127e0f <kmalloc+eb/110>
>>Trace; c01d3cac <qdisc_create_dflt+20/bc>
>>Trace; d081ecc7 <END_OF_CODE+1054ff0f/????>
>>Trace; c01d5265 <tc_ctl_tclass+1cd/214>
>>Trace; d0820600 <END_OF_CODE+10551848/????>
>>Trace; c01d27e4 <rtnetlink_rcv+298/3bc>
>>Trace; c01d0605 <__neigh_event_send+89/1b4>
>>Trace; c01d7cd4 <netlink_data_ready+1c/60>
>>Trace; c01d7730 <netlink_unicast+230/278>
>>Trace; c01d7b73 <netlink_sendmsg+1fb/20c>
>>Trace; c01c79d5 <sock_sendmsg+69/88>
>>Trace; c01c8b48 <sys_sendmsg+18c/1e8>
>>Trace; c0120010 <map_user_kiobuf+8/f8>
>>
>>
>>    
>>
I don't understand the backtrace. Were any modules loaded? Perhaps 
0xd081ecc7 is a module.

I'd add a
    if(in_interrupt()) show_stack(NULL);
into qdisc_create_dflt(), and try to reproduce the bug without modules.

--
    Manfred

