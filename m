Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVCWH5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVCWH5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVCWH5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:57:08 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:49096 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262843AbVCWHzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:55:01 -0500
Date: Wed, 23 Mar 2005 02:54:53 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <20050323071604.GA32712@elte.hu>
Message-ID: <Pine.LNX.4.58.0503230251180.13140@localhost.localdomain>
References: <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu>
 <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu>
 <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu>
 <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu>
 <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu>
 <20050323071604.GA32712@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Mar 2005, Ingo Molnar wrote:

>
> * Ingo Molnar <mingo@elte.hu> wrote:
>
> > That callback will be queued on CPU#2 - while the task still keeps
> > current->rcu_data of CPU#1. It also means that CPU#2's read counter
> > did _not_ get increased - and a too short grace period may occur.
> >
> > it seems to me that that only safe method is to pick an 'RCU CPU' when
> > first entering the read section, and then sticking to it, no matter
> > where the task gets migrated to. Or to 'migrate' the +1 read count
> > from one CPU to the other, within the scheduler.
>
> i think the 'migrate read-count' method is not adequate either, because
> all callbacks queued within an RCU read section must be called after the
> lock has been dropped - while with the migration method CPU#1 would be
> free to process callbacks queued in the RCU read section still active on
> CPU#2.
>

Hi Ingo,

Although you can't disable preemption for the duration of the
rcu_readlock, what about pinning the process to a CPU while it has the
lock.  Would this help solve the migration issue?

-- Steve

