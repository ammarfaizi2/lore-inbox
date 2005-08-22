Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVHVWVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVHVWVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVHVWVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:21:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28155 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751341AbVHVWVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:21:16 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Karsten Wiese <annabellesgarden@yahoo.de>,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124739895.5809.11.camel@localhost.localdomain>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Mon, 22 Aug 2005 15:19:52 -0700
Message-Id: <1124749192.17515.16.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 15:44 -0400, Steven Rostedt wrote:
> On Mon, 2005-08-22 at 20:33 +0200, Ingo Molnar wrote:
> 
> > any ideas how to get rid of pi_lock altogether?
> 
> I've toyed with the idea of adding another raw_spin_lock to the mutex. A
> lock specific pi_lock.   Instead of grabbing a global pi_lock, grab the
> pi_lock of a lock.  To modify any lock w.r.t PI, you must first grab all
> the lock's pi_locks being referenced.

Are you saying that you want to convert the current system to lock all
the pi_locks for all the locks in the sequence?

It seems like you could make it a per task lock, then only lock the
task's pi_lock for pi operations.

> The idea stems from the fact that the kernel must order its taking of
> locks to prevent deadlocks.  This way the order of locks that are taken
> are also always in order. 
> 
> So if you have the following case:
> 
> P1 blocked_on L1 owned_by P2 blocked_on L2 owned_by P3 ...
> 
> The L1, L2, L3 ... must always be in the same order, otherwise the
> kernel itself can have a deadlock.
> 
> OK, let me prove this (for myself as well ;-)
> 
> Lets go by contradiction.

Proof seems straight forward enough. 

One downside would be an increase in mutex structure size though.

Daniel

