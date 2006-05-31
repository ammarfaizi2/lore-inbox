Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWEaOPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWEaOPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWEaOPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:15:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:59378 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964995AbWEaOPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:15:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Vy2R6qgiZKshUyqW+4ZnFsZvy/cZj/Y0kGxwZDdodQOTVkknaf0dDEDS8/Xy1tJ6a8Q7jHJ42pM1uN/czzbwIOnT6BoIYUD8L4BCFLf50mLRrTRziT2vzmm0Wzr0prhaC9upjiqlAO+rvMpTp1HGkLba+CXuitL/NQ9p8WvuxoY=
Date: Wed, 31 May 2006 18:19:26 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
Message-Id: <20060531181926.51c4f4c5.pauldrynoff@gmail.com>
In-Reply-To: <20060530132540.a2c98244.akpm@osdl.org>
References: <20060530195417.e870b305.pauldrynoff@gmail.com>
	<20060530132540.a2c98244.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 13:25:40 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 30 May 2006 19:54:17 +0400
> Paul Drynoff <pauldrynoff@gmail.com> wrote:
> 
> > During boot 2.6.17-rc5-mm1 I got such message:
> > Uncompressing Linux... Ok, booting kernel.
> > 
> > And that's all, 2.6.17-rc5 booted successfully.
> 
> I'm not able to reproduce this with your .config.  Perhaps you could
> disable kgdb, enable CONFIG_EARLY_PRINTK and boot with earlyprintk=vga (or,
> better, earlyprintk=serial[,ttySn[,baudrate]]).
> 
> (you can get a nicer backtrace out gdb by simply using `bt', btw)

Thanks, `bt' help, the problem was "kgbd", I switch off it and all works fine now.

Here is output of "lock validator":

Linux version 2.6.17-rc5-mm1
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBTYPES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... TYPEHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1080 bytes
-------------------------------------------------------
Good, all 210 testcases passed! |
---------------------------------

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {hardirq-on-W} -> {in-hardirq-W} usage.
dhclient/2176 [HC1[1]:SC0[1]:HE0:SE0] takes:
 (&ei_local->page_lock){+...}, at: [<c035b822>] ei_interrupt+0x4a/0x2b4
{hardirq-on-W} state was registered at:
  [<c012ef8c>] lockdep_acquire+0x4b/0x63
  [<c05a57e0>] _spin_lock+0x18/0x26
  [<c035b666>] ei_start_xmit+0x81/0x1f3
  [<c054fc30>] qdisc_restart+0xb9/0x162
  [<c05478ea>] dev_queue_xmit+0xc5/0x1cb
  [<c0594228>] packet_sendmsg_spkt+0x177/0x1b2
  [<c053d886>] sock_sendmsg+0xd2/0xeb
  [<c053dbf3>] sys_sendto+0xbe/0xdc
  [<c053ebaf>] sys_socketcall+0xe5/0x161
  [<c05a5c63>] syscall_call+0x7/0xb
irq event stamp: 7953
hardirqs last  enabled at (7952): [<c05a5a94>] _spin_unlock_irqrestore+0x36/0x3f
hardirqs last disabled at (7953): [<c010306f>] common_interrupt+0x1b/0x2c
softirqs last  enabled at (7934): [<c011c939>] __do_softirq+0x97/0x9f
softirqs last disabled at (7946): [<c05478c1>] dev_queue_xmit+0x9c/0x1cb

other info that might help us debug this:
1 locks held by dhclient/2176:
 #0:  (&dev->xmit_lock){-+..}, at: [<c054fbb1>] qdisc_restart+0x3a/0x162

stack backtrace:
 [<c01035eb>] show_trace+0x16/0x19
 [<c0103b0b>] dump_stack+0x1a/0x1f
 [<c012d5d6>] print_usage_bug+0x1a4/0x1b0
 [<c012e0a9>] mark_lock+0x92/0x40c
 [<c012e92c>] __lockdep_acquire+0x302/0x917
 [<c012ef8c>] lockdep_acquire+0x4b/0x63
 [<c05a57e0>] _spin_lock+0x18/0x26
 [<c035b822>] ei_interrupt+0x4a/0x2b4
 [<c0135849>] handle_IRQ_event+0x18/0x4d
 [<c0136877>] handle_level_irq+0x6e/0xbb
 [<c0104841>] do_IRQ+0x33/0x42
 [<c0103079>] common_interrupt+0x25/0x2c
 [<c0135d6d>] enable_irq+0x82/0x8a
 [<c035b7be>] ei_start_xmit+0x1d9/0x1f3
 [<c054fc30>] qdisc_restart+0xb9/0x162
 [<c05478ea>] dev_queue_xmit+0xc5/0x1cb
 [<c0594228>] packet_sendmsg_spkt+0x177/0x1b2
 [<c053d886>] sock_sendmsg+0xd2/0xeb
 [<c053dbf3>] sys_sendto+0xbe/0xdc
 [<c053ebaf>] sys_socketcall+0xe5/0x161
 [<c05a5c63>] syscall_call+0x7/0xb

