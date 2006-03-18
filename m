Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWCRXMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWCRXMt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCRXMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:12:49 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:1761
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751116AbWCRXMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:12:48 -0500
Message-ID: <42788.84.154.225.163.1142723566.squirrel@www.tglx.de>
In-Reply-To: <20060318142520.2dcbb46c.akpm@osdl.org>
References: <20060318142827.419018000@localhost.localdomain>
    <20060318142830.607556000@localhost.localdomain>
    <20060318120728.63cbad54.akpm@osdl.org>
    <1142712975.17279.131.camel@localhost.localdomain>
    <20060318123102.7d8c048a.akpm@osdl.org>
    <1142714332.17279.148.camel@localhost.localdomain>
    <20060318130925.616d11c5.akpm@osdl.org>
    <1142719518.10017.17.camel@localhost.localdomain>
    <20060318142520.2dcbb46c.akpm@osdl.org>
Date: Sun, 19 Mar 2006 00:12:46 +0100 (CET)
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
From: tglx@linutronix.de
To: "Andrew Morton" <akpm@osdl.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       trini@kernel.crashing.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton" <akpm@osdl.org> wrote:

>> 1. sys_alarm()
>>
>> The alarm value 0xFFFFFFFF is valid as the argument to alarm() is an
>> unsigned int. So we have to convert this to 0x7FFFFFFF (for 32bit
>> machines) because timeval.tv_sec is a signed long. This is done by the
>> alarm patch, which is necessary whether we check the sanity of the
>> timeval in do_setitimer or not. The current -rc6 kernel sends the alarm
>> with the next timer tick, which will break an application which set it
>> to something > INT_MAX.
>>
>> Of course we could do this by the silent conversion of negative values
>> in setitimer too. But thats insane as we rely on some broken feature.
>
> So you're saying that sys_alarm(0xffffffff) needs to behave as
> sys_alarm(0x7ffffffff)?
>
> I guess if we have to do it that way, the risk of breaking anything is
> very small.
>
> What's the 2.4/2.6.13 behaviour of sys_alarm(0xffffffff)?

It gets converted to MAX_SEC_IN_JIFFIES, which depends on HZ, but is
definitely <= 0x7fffffff. For HZ = 1000 its 2147483 seconds (~24days), for
HZ = 250 its *4 .....

>> 2. setitimer()
>>
>> An application would have to set value.it_value.tv_sec to a negative
>> value to trigger this. Also uninitialized usage of struct timevals can
>> cause such behaviour.
>>
>> I'm not sure, if it is sane to ingore this.
>
> What does 2.4/2.6.13 do?   Let's do that.
>
> If you're proposing that we depart from previous behaviour by converting
> setitimer(0xffffffff) into setitimer(0x7fffffff) then I guess we could
> live with that.

Note that this is different to alarm().

alarm(unsigned int seconds);
vs.
setitimer(struct timeval *value, struct timeval *oldvalue);

So you have to willingly set value->it_value.tv_sec to a negative value or
let it randomly uninitialized.

>> I can change the itimer
>> validate patch for now to do
>>
>> if (unlikely(!timeval_valid(v))
>> 	fixup_timeval(v);
>>
>> and print an appropriate warning in fixup_timeval() for the time being.
>>
>
> No, we cannot warn - it'll enable unprivileged users to spam the logs.
>
> One could generate a once-per-reboot warning, I guess.  The message should
> include the PID and current->comm.

Yeah, I would have limited it to 10 warnings, but I can also do only one.

I make up a patch tomorrow morning.

       tglx



