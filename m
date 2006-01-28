Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWA1PVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWA1PVh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWA1PVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 10:21:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58017 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751418AbWA1PVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 10:21:36 -0500
Date: Sat, 28 Jan 2006 16:22:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: [lock validator] inet6_destroy_sock(): soft-safe -> soft-unsafe lock dependency
Message-ID: <20060128152204.GA13940@elte.hu>
References: <20060127001807.GA17179@elte.hu> <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1F2IcV-0007Iq-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Good catch.  In fact the other spin lock operation in the same file 
> needs BH protection as well since it is invoked by the output route 
> path which can be in user-context for local packets.

ok, cool.

Today i've added rwlocks to the coverage of the validator too, and it 
triggers in the networking code straight away - see the output below. Is 
this a genuine deadlock-site too? (Take this with a large grain of salt 
- while it did find another genuine bug in floppy.c and it passes a 
couple of testcases too, the rwlock validation feature is literally just 
1 hour old.)

let me know if you need explanation about the output, or if you need 
more info.

	Ingo

 ===========================================================
 [ BUG: soft-safe -> soft-unsafe lock dependency detected! ]
 -----------------------------------------------------------
 sshd/2853 [HC0[0]:SC0[1]:HE1:SE0] is trying to acquire:
  (&newsk->sk_dst_lock){+-}, at: [<c048f385>] inet6_destroy_sock+0x25/0x100
 
 and this task is already holding:
  (&((sk)->sk_lock.slock)){+-}, at: [<c0464832>] tcp_close+0x142/0x650
 which would create a new lock dependency:
   (&((sk)->sk_lock.slock)){+-} -> (&newsk->sk_dst_lock){+-}
 
 but this new dependency connects a softirq-safe lock:
  (&((sk)->sk_lock.slock)){+-}, at: [<c0464832>] tcp_close+0x142/0x650
 ... which became softirq-safe at:
 ... [<c0102e27>] sysenter_past_esp+0x84/0x8d
 
 to a softirq-unsafe lock:
  (&newsk->sk_dst_lock){+-}, at: [<c048f385>] inet6_destroy_sock+0x25/0x100
 ... which became softirq-unsafe at:
 ... [<00000000>] 0x0
 
 which could lead to deadlocks!
 
 other info that might help us debug this:
 
 1 locks held by sshd/2853:
  #0:  (&((sk)->sk_lock.slock)){+-}, at: [<c0464832>] tcp_close+0x142/0x650
 
 the softirq-safe lock's dependencies:
 -> (&((sk)->sk_lock.slock)){+-} {
    used       at: [<c0438429>] lock_sock+0x29/0xd0
    in-softirq at: [<c047081b>] tcp_delack_timer+0x1b/0x200
    hardirq-on at: [<c0102e27>] sysenter_past_esp+0x84/0x8d
  }
  ... key      at: [<c0438375>] sock_lock_init+0x15/0x30
  ... acquired at: [<c0464832>] tcp_close+0x142/0x650
 
   -> (&sk->sk_callback_lock){+-} {
      used       at: [<c048c8b3>] unix_release_sock+0x43/0x2d0
      hardirq-on at: [<c0162738>] kmem_cache_free+0x78/0xb0
    }
    ... key      at: [<c043963f>] sock_init_data+0x10f/0x1d0
    ... acquired at: [<c046484e>] tcp_close+0x15e/0x650
 
   -> (cpa_lock){++} {
      used       at: [<c011474c>] change_page_attr+0x1c/0x2a0
      in-hardirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
      in-softirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
    }
    ... key      at: [<c0581950>] cpa_lock+0x10/0x40
    ... acquired at: [<c011474c>] change_page_attr+0x1c/0x2a0
 
   -> (&dev->queue_lock){+-} {
      used       at: [<c044d44d>] qdisc_lock_tree+0x1d/0x20
      in-softirq at: [<c0441ef4>] dev_queue_xmit+0x64/0x290
      hardirq-on at: [<c0102ea7>] restore_nocheck+0x8/0xb
    }
    ... key      at: [<c044288b>] register_netdevice+0x4b/0x3a0
    ... acquired at: [<c0441ef4>] dev_queue_xmit+0x64/0x290
 
     -> (&dev->xmit_lock){+-} {
        used       at: [<c0443e6c>] dev_mc_upload+0x1c/0x40
        in-softirq at: [<c044d6bb>] dev_watchdog+0x1b/0xc0
        hardirq-on at: [<c04d40fa>] __mutex_lock_slowpath+0x27a/0x4e0
      }
      ... key      at: [<c044289d>] register_netdevice+0x5d/0x3a0
      ... acquired at: [<c044e019>] dev_activate+0x69/0x110
 
       -> (&tp->lock){++} {
          used       at: [<c0338c8a>] rtl8139_interrupt+0x2a/0x5e0
          in-hardirq at: [<c0338c8a>] rtl8139_interrupt+0x2a/0x5e0
          in-softirq at: [<c033839a>] rtl8139_start_xmit+0x7a/0x1a0
        }
        ... key      at: [<c03376bb>] rtl8139_init_one+0x2ab/0x960
        ... acquired at: [<c0337d92>] rtl8139_set_rx_mode+0x22/0x180
 
       -> (&base->t_base.lock){++} {
          used       at: [<c01269f3>] lock_timer_base+0x23/0x50
          in-hardirq at: [<c01269f3>] lock_timer_base+0x23/0x50
          in-softirq at: [<c0127612>] run_timer_softirq+0x42/0x1f0
        }
        ... key      at: [<c1fdaef0>] 0xc1fdaef0
        ... acquired at: [<c01269f3>] lock_timer_base+0x23/0x50
 
       -> (modlist_lock){++} {
          used       at: [<c0140289>] module_text_address+0x19/0x40
          in-hardirq at: [<c0140289>] module_text_address+0x19/0x40
          in-softirq at: [<c0140289>] module_text_address+0x19/0x40
        }
        ... key      at: [<c05842f0>] modlist_lock+0x10/0x40
        ... acquired at: [<c0140289>] module_text_address+0x19/0x40
 
       -> (cpa_lock){++} {
          used       at: [<c011474c>] change_page_attr+0x1c/0x2a0
          in-hardirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
          in-softirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
        }
        ... key      at: [<c0581950>] cpa_lock+0x10/0x40
        ... acquired at: [<c011474c>] change_page_attr+0x1c/0x2a0
 
   -> (&tcp_hashinfo.ehash[i].lock){+-} {
      used       at: [<c0460dbd>] inet_hash_connect+0x3dd/0x480
      in-softirq at: [<c0460eed>] __inet_twsk_hashdance+0x8d/0x130
      hardirq-on at: [<c0161b26>] kmem_cache_alloc+0x96/0xd0
    }
    ... key      at: [<c0696b8d>] tcp_init+0x2ad/0x300
    ... acquired at: [<c0472fa4>] tcp_v4_syn_recv_sock+0x184/0x340
 
   -> (&tcp_hashinfo.bhash[i].lock){+-} {
      used       at: [<c046275a>] inet_csk_get_port+0xea/0x240
      in-softirq at: [<c0460eaa>] __inet_twsk_hashdance+0x4a/0x130
      hardirq-on at: [<c0102e27>] sysenter_past_esp+0x84/0x8d
    }
    ... key      at: [<c0696b44>] tcp_init+0x264/0x300
    ... acquired at: [<c0472ffe>] tcp_v4_syn_recv_sock+0x1de/0x340
 
     -> (&parent->list_lock){++} {
        used       at: [<c0161bca>] cache_alloc_refill+0x6a/0x730
        in-hardirq at: [<c016362b>] do_drain+0x2b/0x60
        in-softirq at: [<c0162a46>] free_block+0x136/0x150
      }
      ... key      at: [<c01610ba>] kmem_list3_init+0x3a/0x50
      ... acquired at: [<c0161bca>] cache_alloc_refill+0x6a/0x730
 
     -> (&cachep->spinlock){+-} {
        used       at: [<c0161ea2>] cache_alloc_refill+0x342/0x730
        in-softirq at: [<c0161ea2>] cache_alloc_refill+0x342/0x730
      }
      ... key      at: [<c0163c71>] kmem_cache_create+0x2c1/0x780
      ... acquired at: [<c0161ea2>] cache_alloc_refill+0x342/0x730
 
       -> (&parent->list_lock){++} {
          used       at: [<c0161bca>] cache_alloc_refill+0x6a/0x730
          in-hardirq at: [<c016362b>] do_drain+0x2b/0x60
          in-softirq at: [<c0162a46>] free_block+0x136/0x150
        }
        ... key      at: [<c01610ba>] kmem_list3_init+0x3a/0x50
        ... acquired at: [<c01636a1>] __cache_shrink+0x41/0x140
 
       -> (cpa_lock){++} {
          used       at: [<c011474c>] change_page_attr+0x1c/0x2a0
          in-hardirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
          in-softirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
        }
        ... key      at: [<c0581950>] cpa_lock+0x10/0x40
        ... acquired at: [<c011474c>] change_page_attr+0x1c/0x2a0
 
     -> (cpa_lock){++} {
        used       at: [<c011474c>] change_page_attr+0x1c/0x2a0
        in-hardirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
        in-softirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
      }
      ... key      at: [<c0581950>] cpa_lock+0x10/0x40
      ... acquired at: [<c011474c>] change_page_attr+0x1c/0x2a0
 
     -> (&tcp_hashinfo.ehash[i].lock){+-} {
        used       at: [<c0460dbd>] inet_hash_connect+0x3dd/0x480
        in-softirq at: [<c0460eed>] __inet_twsk_hashdance+0x8d/0x130
        hardirq-on at: [<c0161b26>] kmem_cache_alloc+0x96/0xd0
      }
      ... key      at: [<c0696b8d>] tcp_init+0x2ad/0x300
      ... acquired at: [<c0460dbd>] inet_hash_connect+0x3dd/0x480
 
   -> (&queue->syn_wait_lock){+-} {
      used       at: [<c043a7bc>] reqsk_queue_alloc+0x8c/0xd0
      in-softirq at: [<c0461e88>] inet_csk_reqsk_queue_hash_add+0xd8/0x110
      hardirq-on at: [<c04d5105>] _spin_unlock_irqrestore+0x25/0x30
    }
    ... key      at: [<c043a7a2>] reqsk_queue_alloc+0x72/0xd0
    ... acquired at: [<c0475bf2>] tcp_check_req+0x2c2/0x3f0
 
   -> (&base->t_base.lock){++} {
      used       at: [<c01269f3>] lock_timer_base+0x23/0x50
      in-hardirq at: [<c01269f3>] lock_timer_base+0x23/0x50
      in-softirq at: [<c0127612>] run_timer_softirq+0x42/0x1f0
    }
    ... key      at: [<c1fd2ef0>] 0xc1fd2ef0
    ... acquired at: [<c01269f3>] lock_timer_base+0x23/0x50
 
   -> (modlist_lock){++} {
      used       at: [<c0140289>] module_text_address+0x19/0x40
      in-hardirq at: [<c0140289>] module_text_address+0x19/0x40
      in-softirq at: [<c0140289>] module_text_address+0x19/0x40
    }
    ... key      at: [<c05842f0>] modlist_lock+0x10/0x40
    ... acquired at: [<c0140289>] module_text_address+0x19/0x40
 
   -> (&q->lock){++} {
      used       at: [<c0132050>] add_wait_queue+0x20/0x50
      in-hardirq at: [<c0114fab>] __wake_up+0x1b/0x50
      in-softirq at: [<c0114fab>] __wake_up+0x1b/0x50
    }
    ... key      at: [<c0131e62>] init_waitqueue_head+0x12/0x20
    ... acquired at: [<c0114fab>] __wake_up+0x1b/0x50
 
     -> (&rq->lock){++} {
        used       at: [<c01162a9>] init_idle+0x49/0x70
        in-hardirq at: [<c0117fb6>] scheduler_tick+0xe6/0x380
        in-softirq at: [<c01175ae>] try_to_wake_up+0x3e/0x410
      }
      ... key      at: [<c1fda4f0>] 0xc1fda4f0
      ... acquired at: [<c01175ae>] try_to_wake_up+0x3e/0x410
 
     -> (&rq->lock){++} {
        used       at: [<c01162a9>] init_idle+0x49/0x70
        in-hardirq at: [<c0117fb6>] scheduler_tick+0xe6/0x380
        in-softirq at: [<c0117fe7>] scheduler_tick+0x117/0x380
      }
      ... key      at: [<c1fd24f0>] 0xc1fd24f0
      ... acquired at: [<c01175ae>] try_to_wake_up+0x3e/0x410
 
       -> (&rq->lock){++} {
          used       at: [<c01162a9>] init_idle+0x49/0x70
          in-hardirq at: [<c0117fb6>] scheduler_tick+0xe6/0x380
          in-softirq at: [<c01175ae>] try_to_wake_up+0x3e/0x410
        }
        ... key      at: [<c1fda4f0>] 0xc1fda4f0
        ... acquired at: [<c0114e6c>] double_rq_lock+0x3c/0x50
 
   -> (&parent->list_lock){++} {
      used       at: [<c0161bca>] cache_alloc_refill+0x6a/0x730
      in-hardirq at: [<c016362b>] do_drain+0x2b/0x60
      in-softirq at: [<c0162a46>] free_block+0x136/0x150
    }
    ... key      at: [<c01610ba>] kmem_list3_init+0x3a/0x50
    ... acquired at: [<c0161bca>] cache_alloc_refill+0x6a/0x730
 
   -> (&cachep->spinlock){+-} {
      used       at: [<c0161ea2>] cache_alloc_refill+0x342/0x730
      in-softirq at: [<c0161ea2>] cache_alloc_refill+0x342/0x730
    }
    ... key      at: [<c0163c71>] kmem_cache_create+0x2c1/0x780
    ... acquired at: [<c0161ea2>] cache_alloc_refill+0x342/0x730
 
     -> (&parent->list_lock){++} {
        used       at: [<c0161bca>] cache_alloc_refill+0x6a/0x730
        in-hardirq at: [<c016362b>] do_drain+0x2b/0x60
        in-softirq at: [<c0162a46>] free_block+0x136/0x150
      }
      ... key      at: [<c01610ba>] kmem_list3_init+0x3a/0x50
      ... acquired at: [<c01636a1>] __cache_shrink+0x41/0x140
 
     -> (cpa_lock){++} {
        used       at: [<c011474c>] change_page_attr+0x1c/0x2a0
        in-hardirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
        in-softirq at: [<c011474c>] change_page_attr+0x1c/0x2a0
      }
      ... key      at: [<c0581950>] cpa_lock+0x10/0x40
      ... acquired at: [<c011474c>] change_page_attr+0x1c/0x2a0
 
   -> (&newsk->sk_callback_lock){+-} {
      used       at: [<c047f9ad>] inet_accept+0x4d/0xc0
      hardirq-on at: [<c0162738>] kmem_cache_free+0x78/0xb0
    }
    ... key      at: [<c04399fb>] sk_clone+0xeb/0x1c0
    ... acquired at: [<c046484e>] tcp_close+0x15e/0x650
 
 
 the softirq-unsafe lock's dependencies:
 -> (&newsk->sk_dst_lock){+-} {
    used       at: [<c045fda6>] ip_setsockopt+0x526/0xbf0
    softirq-on at: [<c04384c1>] lock_sock+0xc1/0xd0
    hardirq-on at: [<c0102e27>] sysenter_past_esp+0x84/0x8d
  }
  ... key      at: [<c04399e9>] sk_clone+0xd9/0x1c0
  ... acquired at: [<c048f385>] inet6_destroy_sock+0x25/0x100 
 

 stack backtrace:
  [<c010432d>] show_trace+0xd/0x10
  [<c0104347>] dump_stack+0x17/0x20
  [<c01380f0>] check_mask+0x2b0/0x300
  [<c013a109>] debug_lock_chain+0xce9/0x1090
  [<c013a4ed>] debug_lock_chain_spin+0x3d/0x60
  [<c02684f2>] _raw_write_lock+0x32/0x1a0
  [<c04d50d8>] _write_lock+0x8/0x10
  [<c048f385>] inet6_destroy_sock+0x25/0x100
  [<c04aede2>] tcp_v6_destroy_sock+0x12/0x20
  [<c046217a>] inet_csk_destroy_sock+0x4a/0x150
  [<c0464b7f>] tcp_close+0x48f/0x650
  [<c047ffa7>] inet_release+0x37/0x60
  [<c048ed10>] inet6_release+0x30/0x40
  [<c0436957>] sock_release+0x17/0xa0
  [<c0436df1>] sock_close+0x21/0x40
  [<c01674e3>] __fput+0xb3/0x170
  [<c01675c7>] fput+0x27/0x50
  [<c01647d7>] filp_close+0x47/0x80
  [<c011e685>] put_files_struct+0x85/0xf0
  [<c011f58e>] do_exit+0x14e/0x840
  [<c011fcbd>] do_group_exit+0x3d/0xa0
  [<c011fd2f>] sys_exit_group+0xf/0x20
  [<c0102df7>] sysenter_past_esp+0x54/0x8d
