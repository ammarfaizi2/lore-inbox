Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWAGLZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWAGLZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 06:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWAGLZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 06:25:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030414AbWAGLZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 06:25:58 -0500
Date: Sat, 7 Jan 2006 03:25:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mitch@sfgoth.com, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] protect remove_proc_entry
Message-Id: <20060107032530.24a8a2f0.akpm@osdl.org>
In-Reply-To: <1135980542.6039.84.camel@localhost.localdomain>
References: <1135973075.6039.63.camel@localhost.localdomain>
	<1135978110.6039.81.camel@localhost.localdomain>
	<20051230215544.GI27284@gaz.sfgoth.com>
	<1135980542.6039.84.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> God, we should be getting rid of the stupid BKL, not add more.  But
>  seeing that this is what is used to protect that list, I guess I'll add
>  it.
> 
>  I'm also assuming that interrupt context wont use this.
> 
>  -- Steve
> 
>  Index: linux-2.6.15-rc7/fs/proc/generic.c
>  ===================================================================
>  --- linux-2.6.15-rc7.orig/fs/proc/generic.c	2005-12-30 14:19:39.000000000 -0500
>  +++ linux-2.6.15-rc7/fs/proc/generic.c	2005-12-30 17:05:56.000000000 -0500
>  @@ -693,6 +693,8 @@
>   	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
>   		goto out;
>   	len = strlen(fn);
>  +
>  +	lock_kernel();
>   	for (p = &parent->subdir; *p; p=&(*p)->next ) {
>   		if (!proc_match(len, fn, *p))
>   			continue;
>  @@ -713,6 +715,7 @@
>   		}
>   		break;
>   	}
>  +	unlock_kernel();
>   out:
>   	return;
>   }

OK, we're kind of screwed here.

Debug: sleeping function called from invalid context at include/asm/semaphore.h:105
in_atomic():1, irqs_disabled():0

Call Trace:<ffffffff8012689b>{__might_sleep+190} <ffffffff803e83ce>{lock_kernel+53}
       <ffffffff801a6db2>{remove_proc_entry+74} <ffffffff8016b295>{poison_obj+58}
       <ffffffff80134ee5>{unregister_proc_table+121} <ffffffff80134eb6>{unregister_proc_table+74}
       <ffffffff80134eb6>{unregister_proc_table+74} <ffffffff80134eb6>{unregister_proc_table+74}
       <ffffffff80134eb6>{unregister_proc_table+74} <ffffffff80134fdb>{unregister_sysctl_table+232}
       <ffffffff803a2a0e>{ip_mc_dec_group+181} <ffffffff803e802e>{_write_lock_irqsave+32}
       <ffffffff80133dc2>{local_bh_enable+114} <ffffffff803e82b3>{_write_unlock_bh+24}
       <ffffffff8039ebfe>{devinet_sysctl_unregister+31} <ffffffff8039ecc1>{inetdev_destroy+171}
       <ffffffff8039f1c1>{inet_del_ifa+509} <ffffffff8039f2dc>{inet_rtm_deladdr+268}
       <ffffffff8036efea>{rtnetlink_rcv_msg+437} <ffffffff803761c3>{netlink_run_queue+140}
       <ffffffff8036ee35>{rtnetlink_rcv_msg+0} <ffffffff8036f032>{rtnetlink_rcv+41}
       <ffffffff803758af>{netlink_data_ready+23} <ffffffff80374d77>{netlink_sendskb+41}
       <ffffffff80374ff4>{netlink_unicast+539} <ffffffff80375881>{netlink_sendmsg+667}
       <ffffffff8035bedf>{sock_sendmsg+232} <ffffffff803e8203>{_read_unlock_irq+20}
       <ffffffff80142e90>{autoremove_wake_function+0} <ffffffff80171a1e>{fget+157}
       <ffffffff80142e90>{autoremove_wake_function+0} <ffffffff80171a1e>{fget+157}
       <ffffffff8035bbea>{sockfd_lookup+18} <ffffffff8035d408>{sys_sendto+246}
       <ffffffff803e80cc>{_spin_unlock_irqrestore+27} <ffffffff80238031>{__up_write+371}
       <ffffffff8010db46>{system_call+126} 


Because CONFIG_PREEMPT_BKL makes lock_kernel do down() and some callers of
remove_proc_entry() do it from inside spinlock.

And the spinlocking variant of lock_kernel() is also pretty much illegal,
because (in this case) whatever lock networking has taken may be taken
elsewhere inside lock_kernel(), so we have an ab/ba deadlock.

Best I can think of is that we need a private spinlock for this list.
