Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265851AbSKOF6K>; Fri, 15 Nov 2002 00:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbSKOF6K>; Fri, 15 Nov 2002 00:58:10 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:39352 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265851AbSKOF6J>;
	Fri, 15 Nov 2002 00:58:09 -0500
Date: Fri, 15 Nov 2002 11:40:12 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Corey Minyard <cminyard@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021115114012.A5088@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3DD47858.3060404@mvista.com> <Pine.LNX.4.44.0211142338230.2750-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211142338230.2750-100000@montezuma.mastecende.com>; from zwane@holomorphy.com on Thu, Nov 14, 2002 at 11:40:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 11:40:04PM -0500, Zwane Mwaikambo wrote:
> What interrupt rate have you tested this at? SMP? Adding handlers at 
> runtime? I'm still skeptical on how RCU protects you, but i'm RCU clueless...

The RCU part is fairly simple - you want to avoid having to acquire
a lock for every NMI event to walk the handler so you do it
lockfree. If a process running in a different CPU tries to
free an nmi handler, it removes it from the list, issues an
rcu callback (to be invoked after all CPUs have gone through
a context switch or executed user-level code ensuring that the
deleted nmi handler can't be running) and waits for completion of
the callback. The rcu callback handler wakes it up.
It is all hidden under list_add_rcu()/list_del_rcu() and __list_for_each_rcu().

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
