Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317766AbSGRK0t>; Thu, 18 Jul 2002 06:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317780AbSGRK0t>; Thu, 18 Jul 2002 06:26:49 -0400
Received: from holomorphy.com ([66.224.33.161]:32394 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317766AbSGRK0s>;
	Thu, 18 Jul 2002 06:26:48 -0400
Date: Thu, 18 Jul 2002 03:29:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>, Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020718102932.GP1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Matthew Wilcox <willy@debian.org>,
	Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk> <20020714010506.GW23693@holomorphy.com> <20020714102219.A9412@in.ibm.com> <20020718082238.GO1096@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020718082238.GO1096@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 10:22:19AM +0530, Dipankar Sarma wrote:
>> Even if you replace timemr_bh() with a tasklet, you still need
>> to take the global_bh_lock to ensure that timers don't race with
>> single-threaded BH processing in drivers. I wrote this patch [included]
>> to get rid of timer_bh in Ingo's smptimers, but it acquires
>> global_bh_lock as well as net_bh_lock, the latter to ensure
>> that some older protocol code that expected serialization of
>> NET_BH and timers work correctly (see deliver_to_old_ones()).
>> They need to be cleaned up too.
>> My patch of course was experimental to see what is needed to
>> get rid of timer_bh. It needs some cleanup itself ;-)

On Thu, Jul 18, 2002 at 01:22:38AM -0700, William Lee Irwin III wrote:
> I'll follow up with the "before"  profile next.

By the way, since it applies with just offsets to 2.5.26 I did my testing
on it. Here they are:

c01210c3 15914360 73.4974     .text.lock.timer
c0120114 1740662  8.03891     mod_timer
c0196480 533190   2.46243     csum_partial_copy_generic
c0196650 409733   1.89227     __generic_copy_to_user
c0112658 271923   1.25582     try_to_wake_up
c022893c 227856   1.05231     tcp_v4_rcv
c021ba91 219423   1.01336     .text.lock.tcp
c0107bb4 216722   1.00089     apic_timer_interrupt
c02118a4 160277   0.740208    ip_output
c011330c 123467   0.570208    schedule
c021727c 121239   0.559919    tcp_sendmsg
c0200170 121187   0.559679    dev_queue_xmit
c02021ad 83061    0.383601    .text.lock.dev
c02119f4 80365    0.37115     ip_queue_xmit
c0112f74 77876    0.359655    scheduler_tick
c01fcd98 75855    0.350322    __kfree_skb
c010fb30 73084    0.337524    smp_apic_timer_interrupt
c0218688 68854    0.317989    tcp_data_wait
c0218af4 66201    0.305736    tcp_recvmsg
c01207f8 64625    0.298458    timer_bh
c021e448 55844    0.257905    tcp_ack
c010cd60 52670    0.243246    do_gettimeofday
c02207b4 51631    0.238448    tcp_rcv_established

