Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276237AbRI1Svw>; Fri, 28 Sep 2001 14:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276236AbRI1Svn>; Fri, 28 Sep 2001 14:51:43 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:16910 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S276239AbRI1Sv2>; Fri, 28 Sep 2001 14:51:28 -0400
Date: Fri, 28 Sep 2001 14:51:48 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: kuznet@ms2.inr.ac.ru
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, andrea@suse.de
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
Message-ID: <20010928145148.A14758@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0109281904200.8840-100000@localhost.localdomain> <200109281756.VAA04730@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109281756.VAA04730@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Fri, Sep 28, 2001 at 09:56:24PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 09:56:24PM +0400, kuznet@ms2.inr.ac.ru wrote:
> > (Lets assume that a loop of 10 still ensures basic safety in situations
> > where external load overloads the system.
> 
> It does not, evidently. And 1 does not. But 10 is 10 times worse.

10 is not 10 times worse.  The effect is much more subtle than that 
when you factor in the amount of work done as well as the cache state.

> Ingo, I told net_rx_action() is small do_softirq() restarting not 10,
> but not less than 300 times in row.

The problem comes from net_rx_action doing less than the allowable amount 
of work if another rx interrupt comes in while softirqs were being 
run -- if the rx action is not repeated, the new packets are not 
acknowledged until 10's of ms later, which is a *lot* of data in the 
future.  Running the logic via ksoftirqd alone results in a significant 
cache hit for just the context switch (our stack and task structs all 
map to the *SAME* L1 cache lines in many processors), which softirqs 
do not.  Blanket disallowing repeats generates more overhead than it 
reduces overload: it makes things worse by increasing the amount of 
work that needs to be done during overload.

		-ben
