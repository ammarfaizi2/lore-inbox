Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUJODDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUJODDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 23:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUJODDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 23:03:20 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:22246 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S265970AbUJODDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 23:03:13 -0400
Date: Thu, 14 Oct 2004 19:23:02 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: select, jiffies, and SIGALRM
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <008101c4b255$843cadf0$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=original; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.j10pg5k.1q08a2k@ifi.uio.no> <fa.je28id0.1i0sfq4@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do you mean, adversely affected? Without knowing the interval of real 
time elapsed between those lines, or what the app is doing with the timer, 
it's hard to say what's going on.


----- Original Message ----- 
From: "Vx Glenn" <VxGlenn@gmail.com>
Newsgroups: fa.linux.kernel
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Thursday, October 14, 2004 12:35 PM
Subject: Re: select, jiffies, and SIGALRM


> Thanks for the insight. I looked more closely at the trace I have and
> I see the POSIX timer is adversely affected by the wrap-around of the
> jiffies counter.
>
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={2146931,
> 982728}}) = 0
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={2146931,
> 962731}}) = 0
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={2146931,
> 962731}}) = 0
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={131, 
> 601993}}) = 0
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={131, 
> 601993}}) = 0
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={131, 
> 601993}}) = 0
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={131, 
> 599993}}) = 0
> getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={131, 
> 599993}}) = 0
>
> And when the SIGALRM fires, the app does not handle it.
>
> My next question is, should the POSIX timer be affected like this? I
> guess if it uses the jiffies counter, like everything else, it
> probably would.
>
>
>
> On Wed, 13 Oct 2004 21:28:26 -0600, Robert Hancock <hancockr@shaw.ca> 
> wrote:
>> I see calls to getitimer, so I'm assuming it's also using setitimer. 
>> SIGALRM
>> is what you get when those timers go off - if it's not handling that, 
>> that's
>> a bug, but presumably the timer is in there for a reason..
>>
>>
>>
>>
>> ----- Original Message -----
>> From: "Vx Glenn" <VxGlenn@gmail.com>
>> Newsgroups: fa.linux.kernel
>> To: <linux-net@vger.kernel.org>; <linux-kernel@vger.kernel.org>
>> Sent: Wednesday, October 13, 2004 10:13 AM
>> Subject: select, jiffies, and SIGALRM
>>
>> > Hi all,
>> >
>> > I am seeing an issue relating to the jiffies counter wrapping around
>> > at 0x7FFFFFFF.
>> >
>> > This is a legacy application, and when it runs on 32-bit Unix-Like
>> > OS's, the application silently dies without leaving core after 248
>> > days.
>> >
>> > I was able to manipulate the jiffies counter and run the application.
>> > I was able to reproduce the problem. I captured an strace log, and I
>> > see that SIGALRM (alarm clock) is raised after select times out
>> > (because of no data).
>> >
>> > I can add a signal handler to intercept the SIGALRM. But my question
>> > is, why should the signal be raised?
>> >
>> > ---[ strace.log ]---
>> > select(1024, [3 4 5 6], NULL, NULL, {0, 320000}) = 0 (Timeout)
>> > getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={0, 
>> > 684895}})
>> > = 0
>> > adjtimex({modes=32769, offset=0, freq=0, maxerror=16384000,
>> > esterror=16384000, status=64, constant=2, precision=1,
>> > tolerance=33554432, time={1097551596, 43475}}) = 5
>> > getitimer(ITIMER_REAL, {it_interval={2147157, 520}, it_value={0, 
>> > 684895}})
>> > = 0
>> > select(1024, [3 4 5 6], NULL, NULL, {1, 0}) = ? ERESTARTNOHAND (To be
>> > restarted)
>> > --- SIGALRM (Alarm clock) @ 0 (0) ---
>> > Process 4881 detached
>> > ---[ eof strace.log ]---
>> >
>> >
>> > Anyone have any ideas?
>> >
>> >
>> > --
>> > You're not your Job;
>> > You're not the contents of your wallet.
>> > You're the all singing all dancing crap of the world
>> > -
>> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>> > in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > Please read the FAQ at  http://www.tux.org/lkml/
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
> -- 
> Get Firefox
> http://getfirefox.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

