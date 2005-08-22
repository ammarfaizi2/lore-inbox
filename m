Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVHVXUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVHVXUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVHVXUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:20:49 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:50182 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S1751308AbVHVXUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:20:48 -0400
Message-ID: <430A5D9D.90307@symas.com>
Date: Mon, 22 Aug 2005 16:19:57 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050821 SeaMonkey/1.0a
MIME-Version: 1.0
To: Florian Weimer <fw@deneb.enyo.de>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com.suse.lists.linux.kernel>	<17157.45712.877795.437505@gargle.gargle.HOWL.suse.lists.linux.kernel>	<430666DB.70802@symas.com.suse.lists.linux.kernel>	<p73oe7syb1h.fsf@verdi.suse.de> <87fyt3vzq0.fsf@mid.deneb.enyo.de>	<43095E10.3010003@symas.com> <87zmranm4m.fsf@mid.deneb.enyo.de>
In-Reply-To: <87zmranm4m.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer wrote:
>  * Howard Chu:
> > That's not the complete story. BerkeleyDB provides a
> > db_env_set_func_yield() hook to tell it what yield function it
> > should use when its internal locking routines need such a function.
> > If you don't set a specific hook, it just uses sleep(). The
> > OpenLDAP backend will invoke this hook during some (not necessarily
> > all) init sequences, to tell it to use the thread yield function
> > that we selected in autoconf.

>  And this helps to increase performance substantially?

When the caller is a threaded program, yes, there is a substantial 
(measurable and noticable) difference. Given that sleep() blocks the 
entire process, the difference is obvious.

> > Note that (on systems that support inter-process mutexes) a
> > BerkeleyDB database environment may be used by multiple processes
> > concurrently.
>
>  Yes, I know this, and I haven't experienced that much trouble with
>  deadlocks.  Maybe the way you structure and access the database
>  environment can be optimized for deadlock avoidance?

Maybe we already did this deadlock analysis and optimization, years ago 
when we first started developing this backend? Do you think everyone 
else in the world is a total fool?

> > As such, the yield function that is provided must work both for
> > threads within a single process (PTHREAD_SCOPE_PROCESS) as well as
> > between processes (PTHREAD_SCOPE_SYSTEM).

>  If I understand you correctly, what you really need is a syscall
>  along the lines "don't run me again until all threads T that share
>  property X have run, where the Ts aren't necessarily in the same
>  process".  The kernel is psychic, it can't really know which
>  processes to schedule to satisfy such a requirement.  I don't even
>  think "has joined the Berkeley DB environment" is the desired
>  property, but something like "is part of this cycle in the wait-for
>  graph" or something similar.

You seem to believe we're looking for special treatment for the 
processes we're concerned with, and that's not true. If the system is 
busy with other processes, so be it, the system is busy. If you want 
better performance, you build a dedicated server and don't let anything 
else make the system busy. This is the way mission-critical services are 
delivered, regardless of the service. If you're not running on a 
dedicated system, then your deployment must not be mission critical, and 
so you shouldn't be surprised if a large gcc run slows down some other 
activities in the meantime. If you have a large nice'd job running 
before your normal priority jobs get their timeslice, then you should 
certainly wonder wtf the scheduler is doing, and why your system even 
claims to support nice() when clearly it doesn't mean anything on that 
system.

>  I would have to check the Berkeley DB internals in order to tell what
>  is feasible to implement.  This code shouldn't be on the fast path,
>  so some kernel-based synchronization is probably sufficient.

pthread_cond_wait() probably would be just fine here, but BerkeleyDB 
doesn't work that way.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

