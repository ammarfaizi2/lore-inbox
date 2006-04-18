Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWDRQrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWDRQrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWDRQrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:47:49 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:28648 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751099AbWDRQrs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:47:48 -0400
Message-ID: <44451828.3090501@compro.net>
Date: Tue, 18 Apr 2006 12:47:36 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dmarkh@cfl.rr.com, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: RT question : softirq and minimal user RT priority
References: <200601131527.00828.Serge.Noiraud@bull.net>	 <1137167600.7241.22.camel@localhost.localdomain>	 <4443966B.8020802@compro.net> <1145286325.16138.26.camel@mindpipe>	 <44449EE2.8070907@cfl.rr.com> <1145367111.17085.67.camel@localhost.localdomain>
In-Reply-To: <1145367111.17085.67.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Tue, 2006-04-18 at 04:10 -0400, Mark Hounschell wrote:
>> Lee Revell wrote:
>>> Please don't trim CC lists
>>>
>> Sorry.
> 
> No prob ;)
> 
>>> On Mon, 2006-04-17 at 09:21 -0400, Mark Hounschell wrote:
>>>> Steven Rostedt wrote:
>>>>>> Is the smallest usable real-time priority greater than the highest real-time softirq ?
>>>>> Nope, you can use any rt priority you want.  It's up to you whether you
>>>>> want to preempt the softirqs or not. Be careful, timers may be preempted
>>>>> from delivering signals to high priority processes.  I have a patch to
>>>>> fix this, but I'm waiting on input from either Thomas Gleixner or Ingo.
>>>>>
>>>>> -- Steve
>>>> I know this is an old thread but I seem to be having a problem similar
>>>> to this and I didn't find any real resolution in the archives.
>>>>
>>>> I'm using the rt16 patch on 2.6.16.5 with complete preemption. I have a
>>>> high priority rt compute bound task that isn't getting signals from a
>>>> pci cards interrupt handler. Only when I insure the rt priority of the
>>>> task is lower than the rt priority of the irq thread ([IRQ 193]) will my
>>>> task receive signals.
>>>>
>>>> Is this a bug? Is the bug in my interrupt handler? Or is this expected
>>>> and acceptable?
>>> It's expected if your high priority RT task never gives up the CPU - if
>>> this is the case the IRQ thread should have higher priority.
>>>
>>> Lee
>> The default IRQ threads seem to be at RT priorities 25-49. So a user
>> should never have a RT compute bound task at a RT priority higher than
>> 25? Doesn't seem quite right. In any case, I have other less compute
>> bound lower priority RT tasks also running on the same CPU so my high
>> priority RT task must be giving up the CPU somewhere along the line. Why
>> is it not able to receive signals? Something is not quite right here.
> 
> Those are just defaults, If a user is going to run a higher priority
> task and needs the use to those IRQS then they need to adjust the
> priorities of the interrupts themselves.
> 
> But remember that the softirqs which handle the bottom halve of
> interrupts are also threads, and they run at even a lower priority.  So
> if the interrupt uses its bottom half to send a signal to the process,
> then if you have a RT task lower in priority than the IRQ but higher
> than the softirq, it can still prevent the signal being sent.
> 
> Could you send a sample program that shows us the problem?  This would
> help us out in figuring out what is wrong.  I still suspect that it's a
> configuration problem, but who knows, maybe you found an indiscernible
> bug.
>

You probably sent this before seeing my next post. The other RT threads
are running on a different processor. The task in question is for sure
hogging it's CPU. It and the IRQ thread are the only tasks executing on
that CPU and the IRQ is a lower RT prio.

> Also, I've been ask to write a section in an O'Reilly book about how to
> use the -rt patch.  Knowing problems that users may have (such as the
> one you are experiencing) would help greatly in explaining to others the
> proper way to configure their setup.
> 

I'd be happy to send you sample code if you still think it might help in
some way. Let me know. In short the interrupt handler is just using
"send_sig" to signal the task. The RT task obviously has a signal
handler setup, but is not giving up any cpu time voluntarily. So I guess
it is a 'configuration' issue on this end.

I'd certainly be interested in that article BTW.

Mark


