Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVHHI3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVHHI3g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVHHI3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:29:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750762AbVHHI3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:29:35 -0400
Date: Mon, 8 Aug 2005 01:28:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ak@suse.de, linux-kernel@vger.kernel.org,
       Alexander Nyberg <alexn@telia.com>
Subject: Re: 2.6.13-rc5-mm1: oops when starting nscd on AMD64
Message-Id: <20050808012809.2a708b3e.akpm@osdl.org>
In-Reply-To: <200508072316.02918.rjw@sisk.pl>
References: <200508071851.16864.rjw@sisk.pl>
	<20050807102329.006f7d95.akpm@osdl.org>
	<200508072316.02918.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> > I don't think it was supposed to do that.
>  > 
>  > Quite possibly it's something to do with the new debugging code - could you
>  > please take a copy of the offending config, send it over and then try
>  > removing debug options, see if the crash goes away?  CONFIG_DEBUG_PREEMPT
>  > would be the first to try..
> 
>  The (offending) .config is attached and here's what happens without CONFIG_DEBUG_PREEMPT
>  (the other debug options being unchanged):

Yes, my emt64 machine keels over with your .config too.  Maybe it's due to
CONFIG_SMP=n, not sure.

Bisection searching shows that the bug was introduced by
slab-leak-detector-give-longer-traces.patch.


Starting NFS statd: [  OK  ]
Starting NFS4 idmapd: Unable to handle kernel NULL pointer dereference at 0000000000000408 RIP: 
<ffffffff8015eb28>{kmem_cache_alloc+222}                                                        
PGD 17cd3b067 PUD 17cd36067 PMD 0       
Oops: 0000 [1] PREEMPT            
CPU 0                  
Modules linked in: sunrpc af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core binm
Pid: 5237, comm: rpc.idmapd Not tainted 2.6.13-rc6-mm1                                               
RIP: 0010:[<ffffffff8015eb28>] <ffffffff8015eb28>{kmem_cache_alloc+222}
RSP: 0018:ffff81017cc85e88  EFLAGS: 00010202                           
RAX: 0000000000000400 RBX: ffffffff8010e8fa RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff81017d8c48b8 RDI: ffff81007ffcf6c0
RBP: ffff81017cc85eb8 R08: 00000000ffffff5d R09: 0000000000000000
R10: ffff81017d8c48c0 R11: 0000000000000100 R12: ffff81007ffcf6c0
R13: ffff81017d8c48b8 R14: 00000000800000d0 R15: ffffffff801a17bb
FS:  00002aaaaaadcb00(0000) GS:ffffffff80540880(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b                           
CR2: 0000000000000408 CR3: 000000017cd30000 CR4: 00000000000006e0
Process rpc.idmapd (pid: 5237, threadinfo ffff81017cc84000, task ffff81017ecf6ad0)
Stack: 0000000000000246 0000000000000000 ffff81017f1d2e60 ffff81017c089c88        
       00000000fffffff4 0000000000000003 ffff81017cc85f78 ffffffff801a17bb 
       00000000fffffffe ffff81017f1d2e60                                   
Call Trace:<ffffffff801a17bb>{sys_epoll_create+568} <ffffffff8018b1f7>{vfs_readdir+167}
       <ffffffff80231000>{add_preempt_count+93} <ffffffff8010e8fa>{system_call+126}    
                                                                                   
BUG: spinlock trylock failure on UP on CPU#0, rpc.idmapd/5237
 lock: ffffffff803f2b00, .magic: dead4ead, .owner: rpc.idmapd/5237, .owner_cpu: 0
                                                                                 
Call Trace:<ffffffff80231000>{add_preempt_count+93} <ffffffff80230acf>{spin_bug+187}
       <ffffffff8010fb4a>{show_trace+524} <ffffffff80230c53>{_raw_spin_trylock+62}  
       <ffffffff80377591>{_spin_trylock+30} <ffffffff8010fe13>{oops_begin+17}     
       <ffffffff80378745>{do_page_fault+1733} <ffffffff80132177>{vprintk+812}
       <ffffffff80132177>{vprintk+812} <ffffffff8010f1ed>{error_exit+0}      
       <ffffffff8010fb4a>{show_trace+524} <ffffffff8010fb46>{show_trace+520}
       <ffffffff8010fc3a>{show_stack+210} <ffffffff8010fce9>{show_registers+132}
       <ffffffff8010ff22>{__die+143} <ffffffff803787b3>{do_page_fault+1843}     
       <ffffffff8022e630>{vsnprintf+1344} <ffffffff801a17bb>{sys_epoll_create+568}
       <ffffffff8010f1ed>{error_exit+0} <ffffffff801a17bb>{sys_epoll_create+568}  
       <ffffffff8010e8fa>{system_call+126} <ffffffff8015eb28>{kmem_cache_alloc+222}
       <ffffffff8015eb18>{kmem_cache_alloc+206} <ffffffff801a17bb>{sys_epoll_create+568}
       <ffffffff8018b1f7>{vfs_readdir+167} <ffffffff80231000>{add_preempt_count+93}     
       <ffffffff8010e8fa>{system_call+126}                                         
---------------------------                
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<ffffffff80377589>] .... _spin_trylock+0x16/0x56
.....[<ffffffff8010fe13>] ..   ( <= oops_begin+0x11/0x55)
.. [<ffffffff80377589>] .... _spin_trylock+0x16/0x56     
.....[<ffffffff8010fe13>] ..   ( <= oops_begin+0x11/0x55)
                                                         
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP: 
<ffffffff8010fb4a>{show_trace+524}                                        
PGD 17cd3b067 PUD 17cd36067 PMD 0 
