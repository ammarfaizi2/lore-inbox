Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWCBWVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWCBWVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWCBWVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:21:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5265 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750763AbWCBWVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:21:17 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
	<44074479.15D306EB@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Mar 2006 15:19:27 -0700
In-Reply-To: <44074479.15D306EB@tv-sign.ru> (Oleg Nesterov's message of
 "Thu, 02 Mar 2006 22:16:09 +0300")
Message-ID: <m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Eric W. Biederman wrote:
>>
>> Holding a reference to a task_struct pins about 10K of low memory even after
>> that task has exited.  Which seems to be at 1 or 2 orders of mangnitude more
>> memory than any other data structure in the kernel.  Not holding a reference
>> to a task_struct and you risk problems with pid wrap around.
>
> I think there is another, much simpler solution. We can make a "reference" to
> the
> pid itself to protect it against free_pidmap(), so that this pid can't be
> reused.

I kind of like the idea of not releasing the pid when someone is using it.
However with my trivial hostile program I can with 32 or 33 living processes
each with 1000 references to dead processes I can completely saturate the
default pid map.  And it won't be obvious why alloc_pidmap is failing.

Your resource consumption with the extra hash table is higher than
mine at until very high process counts.

In addition it doesn't really help with the problem that inspired
this work.  That of having multiple pid spaces.  I could make it work
by throwing a pspace reference in struct pid_ref, but without some
fancy footwork it would prevent cleanup until all of the outside
references are gone.

> What do you think?

So I kind of like it but I don't feel it does as good a job solving
the problems I am solving.  

In this instance I'm not at all certain I like having NULL ref
pointers.  It increases the number of cases you have to deal with when
reading back the pid, but that is minor and something task_refs suffer
from more than pid_refs.

Eric
