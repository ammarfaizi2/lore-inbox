Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVDJLKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVDJLKy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 07:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVDJLKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 07:10:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64956 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261473AbVDJLKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 07:10:25 -0400
Date: Sun, 10 Apr 2005 13:09:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       inaky.perez-gonzalez@intel.com, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>, Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH] Priority Lists for the RT mutex
Message-ID: <20050410110945.GA7871@elte.hu>
References: <1112896344.16901.26.camel@dhcp153.mvista.com> <20050408062811.GA19204@elte.hu> <1112947503.7093.28.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112947503.7093.28.camel@sdietrich-xp.vilm.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sven-Thorsten Dietrich <sdietrich@mvista.com> wrote:

> On Fri, 2005-04-08 at 08:28 +0200, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > 	This patch adds the priority list data structure from Inaky 
> > > Perez-Gonzalez to the Preempt Real-Time mutex.
> > 
> > this one looks really clean.
> > 
> > it makes me wonder, what is the current status of fusyn's? Such a light 
> > datastructure would be much more mergeable upstream than the former 
> > 100-queues approach.
> 
> Ingo,
> 
> Joe Korty has been doing a lot of work on Fusyn recently.
> 
> Fusyn is now a generic implementation, similar to the RT mutex. SMP 
> scalability is somewhat better for decoupled locks on PI (last I 
> checked). It has the extra bulk required to support user space.
> 
> The major issue that concerns the Fusym and the real-time patch is 
> that merging the kernel portion of Fusyn creates a collision of 
> redundant PI implementations with respect to the RT mutex.

i'd not mind merging the extra bits to PREEMPT_RT to enable fusyn's, if 
they come in small, clean steps. E.g. Daniel's plist.h stuff was nice 
and clean.

> There are a few mistakes on the page, (RT mutex does not do priority 
> ceiling), but for the most part the info is current.

is priority ceiling coming in via some POSIX feature that fusyn's need
to address? What would be needed precisely - a way to set a priority for
a lock (independently of the owner's task priority), and let that
control the PI mechanism?

Unless i'm missing something, this could be implemented by detaching
lock->owner_prio from lock->owner - via e.g. negative values. Thus some
minimal code would check whether we need the owner's priority in the PI
logic, or the semaphore's "own" priority level.

i.e. this doesnt seem to really affect the core design of RT mutexes.

OTOH, deadlock detection is another issue. It's quite expensive and i'm 
not sure we want to make it a runtime thing. But for fusyn's deadlock 
detection and safe teardown on owner-exit is a must-have i suspect?

> If the RT mutex could be exposed in non PREEMPT_RT configurations, the 
> fulock portion could be superseded by the RT mutex, and the remaining 
> pieces merged in. Or vice versa.

sure, RT mutexes could be exposed in !PREEMPT_RT.

	Ingo
