Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271015AbUJVKZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271015AbUJVKZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271013AbUJVKZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:25:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41400 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S271017AbUJVKYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:24:48 -0400
Date: Fri, 22 Oct 2004 12:22:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
Message-ID: <20041022102210.GA21734@elte.hu>
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <4177FAB0.6090406@spymac.com> <20041021164018.GA11560@elte.hu> <16759.63466.507400.649099@thebsh.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16759.63466.507400.649099@thebsh.namesys.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nikita Danilov <nikita@clusterfs.com> wrote:

>  > look but it doesnt seem simple to convert it. Reiserfs should really use
>  > a normal Linux waitqueue and nothing more...
> 
> Why? Condition variable is very well known and widely used concept. In
> the area of their applicability (where predicate whose change is
> waited upon is protected by a single lock) they provide clean and
> easily recognizable synchronization device.

sorry, but just look at the kcond code and compare the 'fastpath' with
say the fastpath of Linux semaphores or waitqueue handling.

condition variables (here i dont mean your code specifically, but the
general pthread concept) are simply trying to achieve too much via a
single object, which increases their complexity quite significantly.

Separating out a few select atomic synchronization primitives that can
be used for each appropriate purpose does the job equally well.

condition variables are fine if you 1) already know them from userspace
and 2) want to use a single locking abstraction for everything. It is
thus also a kitchen-sink primitive that is inevitably slow and complex.
I still have to see a locking problem where condvars are the
cleanest/simplest answer, and i've yet to see a locking problem where
condvars are not the slowest answer ;)

of course this too is valid kernel code so i'm not complaining at all.
It was simply too complex to be converted at first sight to
PREEMPT_REALTIME.

	Ingo
