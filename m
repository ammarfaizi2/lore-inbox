Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317309AbSGRITv>; Thu, 18 Jul 2002 04:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317328AbSGRITv>; Thu, 18 Jul 2002 04:19:51 -0400
Received: from holomorphy.com ([66.224.33.161]:9098 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317309AbSGRITt>;
	Thu, 18 Jul 2002 04:19:49 -0400
Date: Thu, 18 Jul 2002 01:22:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020718082238.GO1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Matthew Wilcox <willy@debian.org>,
	Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk> <20020714010506.GW23693@holomorphy.com> <20020714102219.A9412@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020714102219.A9412@in.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 10:22:19AM +0530, Dipankar Sarma wrote:
> Even if you replace timemr_bh() with a tasklet, you still need
> to take the global_bh_lock to ensure that timers don't race with
> single-threaded BH processing in drivers. I wrote this patch [included]
> to get rid of timer_bh in Ingo's smptimers, but it acquires
> global_bh_lock as well as net_bh_lock, the latter to ensure
> that some older protocol code that expected serialization of
> NET_BH and timers work correctly (see deliver_to_old_ones()).
> They need to be cleaned up too.
> My patch of course was experimental to see what is needed to
> get rid of timer_bh. It needs some cleanup itself ;-)

It turns out those profiling results are total garbage. oprofile
hit counts during the tbench 1024 run with smptimers-X1 on the 16-way
16GB NUMA-Q follow:

c020249d 43051806 73.9493     .text.lock.dev
c0196750 2138900  3.67395     csum_partial_copy_generic
c020090c 1454023  2.49755     netif_rx
c0200e78 1237550  2.12572     process_backlog
c0200480 1083695  1.86144     dev_queue_xmit
c0120bf8 1013839  1.74145     run_timer_tasklet
c0228c8c 946933   1.62653     tcp_v4_rcv
c0196920 773495   1.32862     __generic_copy_to_user
c012009c 605591   1.04021     mod_timer
c01fbe98 477906   0.820891    sock_wfree
c0218e14 392831   0.674759    tcp_recvmsg
c0112648 362804   0.623182    try_to_wake_up
c01132fc 278976   0.479192    schedule
c0136087 251550   0.432083    .text.lock.page_alloc
c0211d14 215139   0.36954     ip_queue_xmit
c021759c 205078   0.352259    tcp_sendmsg
c0220ad4 203218   0.349064    tcp_rcv_established
c0112f64 189216   0.325013    scheduler_tick
c02221a4 187313   0.321744    tcp_transmit_skb
c021f5fc 184471   0.316863    tcp_data_queue
c02189a8 163828   0.281404    tcp_data_wait
c01dd820 139310   0.23929     loopback_xmit
c01fcfcc 137241   0.235736    skb_release_data


I'll follow up with the "before"  profile next.


Cheers,
Bill
