Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVCXIsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVCXIsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVCXIsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:48:05 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45202 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262724AbVCXIsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:48:00 -0500
Date: Thu, 24 Mar 2005 03:47:56 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <Pine.LNX.4.58.0503240310490.18714@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503240341280.18714@localhost.localdomain>
References: <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com>
 <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu>
 <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu>
 <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com>
 <20050323063317.GB31626@elte.hu> <20050324052854.GA1298@us.ibm.com>
 <20050324053456.GA14494@elte.hu> <Pine.LNX.4.58.0503240310490.18714@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, Steven Rostedt wrote:
>
> I've noticed the following situation which is caused by __up_mutex
> assigning an owner right away.
>

I also see this with non rt tasks causing a burst of schedules.

1. Process A runs and grabs lock L. then finishes its time slice.
2. Process B runs and tries to grab Lock L.
3. Process A runs and releases lock L.
4. __up_mutex gives process B lock L.
5. Process A tries to grab lock L.
6. Process B runs and releases lock L.
7. __up_mutex gives lock L to process A.
8. Process B tries to grab lock L again.
9. Process A runs...

Here we have more unnecessary schedules.  So the condition to grab a lock
should be:

1. not owned.
2. partially owned, and the owner is not RT.
3. partially owned but the owner is RT and so is the grabber, and the
    grabber's priority is >= the owner's priority.

-- Steve

