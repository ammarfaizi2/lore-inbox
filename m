Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVHVVop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVHVVop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVHVVop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:44:45 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:35970 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751263AbVHVVoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:44:44 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Howard Chu <hyc@symas.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com.suse.lists.linux.kernel>
	<17157.45712.877795.437505@gargle.gargle.HOWL.suse.lists.linux.kernel>
	<430666DB.70802@symas.com.suse.lists.linux.kernel>
	<p73oe7syb1h.fsf@verdi.suse.de> <87fyt3vzq0.fsf@mid.deneb.enyo.de>
	<43095E10.3010003@symas.com>
Date: Mon, 22 Aug 2005 15:20:57 +0200
In-Reply-To: <43095E10.3010003@symas.com> (Howard Chu's message of "Sun, 21
	Aug 2005 22:09:36 -0700")
Message-ID: <87zmranm4m.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Howard Chu:

>>> Has anybody contacted the Sleepycat people with a description of
>>> the problem yet?

>> Berkeley DB does not call sched_yield, but OpenLDAP does in some
>> wrapper code around the Berkeley DB backend.

> That's not the complete story. BerkeleyDB provides a 
> db_env_set_func_yield() hook to tell it what yield function it should 
> use when its internal locking routines need such a function. If you 
> don't set a specific hook, it just uses sleep(). The OpenLDAP backend 
> will invoke this hook during some (not necessarily all) init sequences, 
> to tell it to use the thread yield function that we selected in autoconf.

And this helps to increase performance substantially?

> Note that (on systems that support inter-process mutexes) a BerkeleyDB 
> database environment may be used by multiple processes concurrently.

Yes, I know this, and I haven't experienced that much trouble with
deadlocks.  Maybe the way you structure and access the database
environment can be optimized for deadlock avoidance?

> As such, the yield function that is provided must work both for
> threads within a single process (PTHREAD_SCOPE_PROCESS) as well as
> between processes (PTHREAD_SCOPE_SYSTEM).

If I understand you correctly, what you really need is a syscall along
the lines "don't run me again until all threads T that share property
X have run, where the Ts aren't necessarily in the same process".  The
kernel is psychic, it can't really know which processes to schedule to
satisfy such a requirement.  I don't even think "has joined the
Berkeley DB environment" is the desired property, but something like
"is part of this cycle in the wait-for graph" or something similar.

I would have to check the Berkeley DB internals in order to tell what
is feasible to implement.  This code shouldn't be on the fast path, so
some kernel-based synchronization is probably sufficient.
