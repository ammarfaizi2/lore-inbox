Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbUJWVRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbUJWVRn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 17:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbUJWVRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 17:17:43 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:10235 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261323AbUJWVRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 17:17:36 -0400
Date: Sat, 23 Oct 2004 14:12:28 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>, kaigai@ak.jp.nec.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Message-ID: <20041023211228.GD1267@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041023185132.GA1268@us.ibm.com> <20041023202451.GA24099@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023202451.GA24099@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 10:24:51PM +0200, Ingo Molnar wrote:
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > o	The rcu_read_lock_spin(), rcu_read_lock_read(),
> > 	rcu_read_lock_bh_read(), rcu_read_lock_sem(), and
> > 	rcu_read_lock_bh_spin() APIs cannot be called recursively.
> > 	But you probably already knew that.  ;-)
> > 
> > 	I don't understand why the rcu_read_lock_sem() API gets its
> > 	own #ifdef.
> 
> actually, rcu_read_lock_read() is the variant that _can_ be called
> recursively and which i used in the networking code quite extensively.
> The others are only useful if the locking is 'flat' in the original
> code, or if the locking is extensively rewritten. (I havent tried to
> convert the IPC code back from the 'flat' locking to the original
> 'nested' locking, but i've done it for the networking code.)

OK, sorry for my confusion.  I still don't see why rcu_read_lock_sem()
is segregated, but it will clearly work either way.

> > o	Some recent RCU patches acquire the update-side lock
> > 	under rcu_read_lock(), which I believe will deadlock here.
> 
> which codepaths do you mean? Things are looking pretty good in -U10.3 so
> far.

The one that I am aware of has not yet hit mainline -- Kaigai Kohei's
scalability changes to Linux.  See:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=109628285418353&w=2

The function avc_update_cache() does an rcu_read_lock(), then
invokes avc_update_node(), which acquires the update-side lock.
No problem under conventional RCU, in the case where one might
realize that an update is needed during what is a read-only search
in the common case, but would be problematic given real-time preemption.

						Thanx, Paul
