Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTLOXk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbTLOXk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:40:29 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:58063 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264255AbTLOXk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:40:26 -0500
Message-ID: <3FDE3EF7.7000001@cyberone.com.au>
Date: Tue, 16 Dec 2003 10:08:39 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       John Hawkes <hawkes@sgi.com>
Subject: Re: [CFT][RFC] HT scheduler
References: <20031215060838.BF3D32C257@lists.samba.org>
In-Reply-To: <20031215060838.BF3D32C257@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rusty Russell wrote:

>In message <3FDAB517.4000309@cyberone.com.au> you write:
>
>>Rusty Russell wrote:
>>
>>
>>>In message <3FD9679A.1020404@cyberone.com.au> you write:
>>>
>>>
>>>>Thanks for having a look Rusty. I'll try to convince you :)
>>>>
>
>Actually, having produced the patch, I've changed my mind.
>
>While it was spiritually rewarding to separate "struct runqueue" into
>the stuff which was to do with the runqueue, and the stuff which was
>per-cpu but there because it was convenient, I'm not sure the churn is
>worthwhile since we will want the rest of your stuff anyway.
>

OK nice, I haven't heard any other objections. I'll be trying to get
this included in 2.6, so if anyone doesn't like it please speak up.

>
>It (and lots of other things) might become worthwhile if single
>processors with HT become the de-facto standard.  For these, lots of
>our assumptions about CONFIG_SMP, such as the desirability of per-cpu
>data, become bogus.
>
>A few things need work:
>
>1) There's a race between sys_sched_setaffinity() and
>   sched_migrate_task() (this is nothing to do with your patch).
>

Yep. They should both take the task's runqueue lock.

>
>2) Please change those #defines into an enum for idle (patch follows,
>   untested but trivial)
>

Thanks, I'll take the patch.

>
>3) conditional locking in load_balance is v. bad idea.
>

Yeah... I'm thinking about this. I don't think it should be too hard
to break out the shared portion.

>
>4) load_balance returns "(!failed && !balanced)", but callers stop
>   calling it when it returns true.  Why not simply return "balanced",
>   or at least "balanced && !failed"?
>
>

No, the idle balancer stops calling it when it returns true, the periodic
balancer sets idle to 0 when it returns true.

!balanced && !failed means it has moved a task.

I'll either comment that, or return it in a more direct way.


