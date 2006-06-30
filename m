Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWF3Wpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWF3Wpz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWF3Wpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:45:54 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:8599 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750708AbWF3Wpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:45:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R+zK76M+06Em4UGc7eqBEOAW/RhKM7PhovcG+c2B67+hPySBmQ5t/XU/d54TZDAqm2UvfG6dLTqFffgwr2yyZp57fob+k+Oc4SZHCr4lur93JdCNZGX4rNRp9Duj1vfTXwTMoJCw3+gjxXTxHXuh6++xUBj/norTOm6bHy7Cftk=
Message-ID: <a44ae5cd0606301545s33496174lcd7136d8bf41897@mail.gmail.com>
Date: Fri, 30 Jun 2006 15:45:53 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch] lockdep, annotate slocks: turn lockdep off for them
Cc: "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060630203804.GA1950@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com>
	 <20060630065041.GB6572@elte.hu> <20060630072231.GB7057@elte.hu>
	 <20060630091850.GA10713@elte.hu>
	 <20060630111734.GA22202@gondor.apana.org.au>
	 <20060630113758.GA18504@elte.hu>
	 <a44ae5cd0606301321y6ce6b7dbo2b405d3d76a670f1@mail.gmail.com>
	 <20060630203804.GA1950@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I rebuilt my kernel with your combo patch applied.
Then, I inserted my US Robotics USR2210 PCMCIA wifi card,
ran "pccardutil eject", popped out the card and then inserted
a Compaq iPaq wifi card.  This triggered the following.

[ INFO: possible circular locking dependency detected ]
-------------------------------------------------------
syslogd/1886 is trying to acquire lock:
 (&dev->queue_lock){-+..}, at: [<c11a50b5>] dev_queue_xmit+0x120/0x24b

but task is already holding lock:
 (&dev->_xmit_lock){-+..}, at: [<c11a5118>] dev_queue_xmit+0x183/0x24b

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&dev->_xmit_lock){-+..}:
       [<c102d1b6>] lock_acquire+0x60/0x80
       [<c12013ed>] _spin_lock_bh+0x28/0x37
       [<c11b0045>] dev_activate+0xce/0x100
       [<c11a42e7>] dev_open+0x4c/0x64
       [<c11a2e44>] dev_change_flags+0x51/0xf1
       [<c11ab07d>] do_setlink+0x73/0x312
       [<c11aadcc>] rtnetlink_rcv_msg+0x1ae/0x1d1
       [<c11b5c91>] netlink_run_queue+0x69/0x100
       [<c11aabd4>] rtnetlink_rcv+0x29/0x42
       [<c11b6104>] netlink_data_ready+0x12/0x4f
       [<c11b4f51>] netlink_sendskb+0x1f/0x50
       [<c11b5a42>] netlink_unicast+0x1b4/0x1ce
       [<c11b60e5>] netlink_sendmsg+0x259/0x266
       [<c1199c7a>] sock_sendmsg+0xe8/0x103
       [<c119a2a5>] sys_sendmsg+0x14f/0x1aa
       [<c119b5e3>] sys_socketcall+0x16b/0x186
       [<c1002d6d>] sysenter_past_esp+0x56/0x8d

-> #0 (&dev->queue_lock){-+..}:
       [<c102d1b6>] lock_acquire+0x60/0x80
       [<c12013b6>] _spin_lock+0x23/0x32
       [<c11a50b5>] dev_queue_xmit+0x120/0x24b
       [<f948379e>] hostap_data_start_xmit+0x610/0x61a [hostap]
       [<c11a371d>] dev_hard_start_xmit+0x206/0x212
       [<c11a5134>] dev_queue_xmit+0x19f/0x24b
       [<f939c7c9>] mld_sendpack+0x1a0/0x26a [ipv6]
       [<f939d3a3>] mld_ifc_timer_expire+0x1d6/0x1fd [ipv6]
       [<c101db26>] run_timer_softirq+0xf2/0x14a
       [<c101a709>] __do_softirq+0x55/0xb0
       [<c1004a64>] do_softirq+0x58/0xbd

other info that might help us debug this:

4 locks held by syslogd/1886:
 #0:  (&inode->i_mutex){--..}, at: [<c120028e>] mutex_lock+0x1c/0x1f
 #1:  (&journal->j_state_lock){--..}, at: [<c10aee62>]
journal_stop+0x109/0x1f8 #2:  (&transaction->t_handle_lock){--..}, at:
[<c10aee6c>] journal_stop+0x113/0x1f8
 #3:  (&dev->_xmit_lock){-+..}, at: [<c11a5118>] dev_queue_xmit+0x183/0x24b

stack backtrace:
 [<c1003502>] show_trace_log_lvl+0x54/0xfd
 [<c1003b6a>] show_trace+0xd/0x10
 [<c1003c0e>] dump_stack+0x19/0x1b
 [<c102c576>] print_circular_bug_tail+0x59/0x64
 [<c102cd5c>] __lock_acquire+0x7db/0x970
 [<c102d1b6>] lock_acquire+0x60/0x80
 [<c12013b6>] _spin_lock+0x23/0x32
 [<c11a50b5>] dev_queue_xmit+0x120/0x24b
 [<f948379e>] hostap_data_start_xmit+0x610/0x61a [hostap]
 [<c11a371d>] dev_hard_start_xmit+0x206/0x212
 [<c11a5134>] dev_queue_xmit+0x19f/0x24b
 [<f939c7c9>] mld_sendpack+0x1a0/0x26a [ipv6]
 [<f939d3a3>] mld_ifc_timer_expire+0x1d6/0x1fd [ipv6]
 [<c101db26>] run_timer_softirq+0xf2/0x14a
 [<c101a709>] __do_softirq+0x55/0xb0
 [<c1004a64>] do_softirq+0x58/0xbd
 [<c101a6a8>] irq_exit+0x3f/0x4b
 [<c1004b89>] do_IRQ+0xc0/0xcf
 [<c1002fd9>] common_interrupt+0x25/0x2c


On 6/30/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Miles Lane <miles.lane@gmail.com> wrote:
>
> > I cannot get this patch to apply cleanly to 2.6.17-mm4. Since the
> > patch listed in this message covers the same files as your previous
> > lockdep-annotate-slock.patch, I am assuming this is supposed to
> > replace it.  I should also still apply
> > lockdep-core-add-set-class-and-name.patch, correct?
>
> correct. My latest combo patch has it all included, it's at:
>
>   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-mm4.patch
>
> could you try that one?
>
>         Ingo
>
