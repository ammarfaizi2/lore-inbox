Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270701AbTHAK1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270703AbTHAK1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:27:09 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:64726 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S270701AbTHAK1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:27:06 -0400
Date: Fri, 1 Aug 2003 12:26:58 +0200 (MEST)
Message-Id: <200308011026.h71AQwHp004725@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, joe.korty@ccur.com
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 15:47:40 -0700, Andrew Morton <akpm@osdl.org> wrote:
>Joe Korty <joe.korty@ccur.com> wrote:
>>
>> Lock out users from changing the cpu affinity of those per-cpu system
>> daemons which cannot survive such a change, such as migration/%d.
>
>Generally we prefer to not add code which purely protects root from making
>mistakes.  Once the sysadmin has nuked his box he'll learn to not do it
>again.
>
>Or do you have some deeper reaon for needing this?

I have a different reason for wanting something like what Korty's
patch achieves.

My problem is that the perfctr driver needs to enforce CPU affinity
masks on HT P4s due to the fact that they actually are _asymmetric_
MPs (perfctr HW wasn't duplicated as the rest of the state was) which
leads to dynamic scheduling restrictions.

Setting p->cpus_allowed fixes this by replacing the dynamic scheduling
restriction with a static one, which Linux' scheduler handles nicely.
(I'm telling it to use only thread #0 in each processor package.)

The problem is that some _other_ process can change a process'
->cpus_allowed via sys_sched_setaffinity(). Users can shoot themselves,
fine, but in doing so they also mess up the state of the driver and
the perfctrs of other processes.

I could add checks in set_cpus_allowed() and kill the target
process' perfctrs, but another problem is that set_cpus_allowed()
doesn't synchronize with the target process before messing with
its task_struct. So this doesn't work.

Right now my only safe solution is to do additional checks in
switch_to()'s resume path, which slows down context-switches.

/Mikael
