Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTJFPWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTJFPWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:22:24 -0400
Received: from tolkor.SGI.COM ([198.149.18.6]:45008 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262066AbTJFPWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:22:22 -0400
Message-ID: <3F8188A6.9020006@sgi.com>
Date: Mon, 06 Oct 2003 10:22:14 -0500
From: Steve Modica <modica@sgi.com>
Organization: SGI
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: simple mod_timer patch
References: <3F7DEABF.2040606@sgi.com> <20031003150747.451fd845.akpm@osdl.org>
In-Reply-To: <20031003150747.451fd845.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:
> Steve Modica <modica@sgi.com> wrote:
> 
>>I pulled this back from the 2.6 kernel to reduce some serious contention on the 
>>timerlist_lock when I had 8 gigabit cards runnings.
>>
> 
> By how much did it reduce contention?


I got some profile results on the recv side for a 64p system running 8 recv 
threads using 1500 byte frames and the 1.5 tg3 driver (with NAPI)

The 4 cpus I was using were pegged.. Here's the sorted profile useage:

23581672 total                                      3.7362
22193477 cpu_idle                                 43346.6348
282048 tg3_poll                                 275.4375
218033 mod_timer                                272.5412
158467 __copy_user                               66.9202
  71956 sn_gettimeoffset                         249.8472
  60643 tcp_v4_rcv                                11.8443
  59058 tcp_rcv_established                        9.5625
  42402 kmalloc                                   31.5491
  41140 alloc_skb                                 33.8322
  38985 __kfree_skb                               46.8570
  36601 skb_release_data                          81.6987
  31168 kfree                                     57.2941
  24531 __wake_up                                 45.0938
  22551 kmem_cache_alloc                          19.0465

Here's an 8 cpu run (1 cpu per interface):


35664353 cpu_idle                                 69656.9395
 > > 550978 mod_timer                                688.7225
 > > 141781 sn_gettimeoffset                         492.2951
 > > 428917 tg3_poll                                 418.8643
 > > 310004 __copy_user                              130.9139
 > >   50981 skb_release_data                         113.7969
 > >   30982 do_gettimeofday                           74.4760
 > >   52091 __kfree_skb                               62.6094
 > >   25806 kfree                                     47.4375
 > >   36212 tcp_v4_do_rcv                             37.7208
 > >   44090 alloc_skb                                 36.2582
 > >   11238 tg3_recycle_rx                            35.1187


Here's a run with 8 cards receiving, 4 interrupt cpus with the mod_timer fix and 
a change so the stack isn't time stamping every packet (it's sorted based on the 
weighted load, but mod_timer had just dropped way down into the noise for these 
runs.)

[root@ascender2 modica]# head profile.recv.1500
40057535 cpu_idle                                 78237.3730
228061 tg3_poll                                 222.7158
  36780 skb_release_data                          82.0982
  13100 pciio_dmatrans_addr                       81.8750
  39542 __wake_up                                 72.6875
   4494 ia64_page_valid                           70.2188
  35029 kfree                                     64.3915
140595 __copy_user                               59.3729
  16307 __release_sock                            46.3267
  18897 kmem_cache_free                           45.4255



-- 
Steve Modica
work: 651-683-3224
MTS-Technical Lead
"Give a man a fish, and he will eat for a day, hit him with a fish and
he leaves you alone" - me

