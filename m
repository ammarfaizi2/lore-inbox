Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSIAK6q>; Sun, 1 Sep 2002 06:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316667AbSIAK6q>; Sun, 1 Sep 2002 06:58:46 -0400
Received: from mailb.telia.com ([194.22.194.6]:40132 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S316659AbSIAK6p>;
	Sun, 1 Sep 2002 06:58:45 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.33 preempt, schedule() with irqs disabled
From: Peter Osterlund <petero2@telia.com>
Date: 01 Sep 2002 13:03:11 +0200
Message-ID: <m2it1q0y6o.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I first reported this problem in 2.5.29 but now I have more details.]

In 2.5.33, with CONFIG_PREEMPT enabled on an x86 UP machine, I can
reliably provoke the message "bad: schedule() with irqs disabled!". It
happens if I use ssh to login to the machine running 2.5.33, then
start xv or ee to display a large image using the encrypted X11
connection.

The problem goes away if I use rlogin instead of slogin. The machine
has a 233MHz CPU and the network is 100Mbit, so when using slogin the
image data transfer speed is CPU limited but when using rlogin the cpu
is about 50% idle.

The problem does not happen if I use scp to copy a large file from the
test machine. When using scp the machine generates about 2000
interrupts/s compared to 5500 ints/s when transferring the image data.

Disabling CONFIG_PREEMPT also makes the problem go away.

Here is a backtrace:

        Trace; c0110a38 <global_flush_tlb+1e8/200>
        Trace; c0110a5b <wake_up_process+b/5b0>
        Trace; c01191ce <do_softirq+9e/b0>
        Trace; c024945c <ip_cmsg_recv+4b2c/5150>
        Trace; c022ddcb <alloc_skb+2cb/330>
        Trace; c0265b88 <unregister_inetaddr_notifier+1ce8/2080>
        Trace; c022a995 <sock_sendmsg+75/a0>
        Trace; c022ac9e <sock_recvmsg+2de/7d0>
        Trace; c022ad21 <sock_recvmsg+361/7d0>
        Trace; c013a03c <vfs_write+44c/ca0>
        Trace; c022ad7e <sock_recvmsg+3be/7d0>
        Trace; c01487d7 <kill_fasync+3e7/440>
        Trace; c013a259 <vfs_write+669/ca0>
        Trace; c0107567 <__up_wakeup+10fb/2644>

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
