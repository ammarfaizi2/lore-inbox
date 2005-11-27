Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVK0OP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVK0OP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 09:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVK0OP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 09:15:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38817 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751070AbVK0OPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 09:15:55 -0500
To: Andi Kleen <ak@suse.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Raj, Ashok" <ashok.raj@intel.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
References: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
	<20051127135833.GH20775@brahms.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 27 Nov 2005 07:14:16 -0700
In-Reply-To: <20051127135833.GH20775@brahms.suse.de> (Andi Kleen's message
 of "Sun, 27 Nov 2005 14:58:33 +0100")
Message-ID: <m1wtiufa9z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Sun, Nov 27, 2005 at 02:05:45AM -0800, Zwane Mwaikambo wrote:
>> http://bugzilla.kernel.org/show_bug.cgi?id=5203
>> 
>> There is a small race during SMP shutdown between the processor issuing 
>> the shutdown and the other processors clearing themselves off the 
>> cpu_online_map as they do this without using the normal cpu offline 
>> synchronisation. To avoid this we should wait for all the other processors 
>> to clear their corresponding bits and then proceed. This way we can safely 
>> make the cpu_online test in smp_send_reschedule, it's safe during normal 
>> runtime as smp_send_reschedule is called with a lock held / preemption 
>> disabled.
>
> Looking at the backtrace in the bug - how can sys_reboot call do_exit???
> I would say the problem is in whatever causes that. It shouldn't 
> do that. sys_reboot shouldn't schedule, it's that simple.
> Your patch is just papering over that real bug.

sys_reboot in the case of halt (after everything else is done)
has directly called do_exit for years.

There are some very subtle interactions there.  The one
I always remember (having found it the hard way) is that
interrupts must be left on so ctrl-alt-del still works.

This do_exit may be something similar, although I can't
think of how it could be useful.

Eric
