Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSGQXyz>; Wed, 17 Jul 2002 19:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSGQXyz>; Wed, 17 Jul 2002 19:54:55 -0400
Received: from holomorphy.com ([66.224.33.161]:39816 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315198AbSGQXyy>;
	Wed, 17 Jul 2002 19:54:54 -0400
Date: Wed, 17 Jul 2002 16:57:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020717235741.GK1096@holomorphy.com>
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

It runs here. New profile (hopefully I'll get some fixed-up stuff like
oprofile, kernprof, & lockmeter to play with at some point):


14465232 total                                  114.2269
10694436 mod_timer                            33420.1125
1089589 __global_cli                           4005.8419
961598 timer_bh                                1059.0286
453404 do_gettimeofday                         3333.8529
440086 __wake_up                               2340.8830
298729 schedule                                 268.6412
294945 default_idle                            5672.0192
155762 do_softirq                               708.0091
 43256 tasklet_hi_action                        220.6939
 12724 system_call                              289.1818
 
mod_timer is 75%, __global_cli() appears to be 7.5%, and timer_bh()
is 6.6%... I wonder what happened to the plot for lockless gettimeofday(),
esp as that accounts for 3.1% here...

It's still spinning with interrupts off for several minutes at a time.


Cheers,
Bill
