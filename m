Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUG0HHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUG0HHE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUG0HHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:07:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:56793 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266303AbUG0HGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:06:48 -0400
Message-ID: <4105FE68.7040506@suse.de>
Date: Tue, 27 Jul 2004 09:04:08 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
References: <40FD23A8.6090409@suse.de>	<20040725182006.6c6a36df.akpm@osdl.org>	<4104E421.8080700@suse.de> <20040726131807.47816576.akpm@osdl.org>
In-Reply-To: <20040726131807.47816576.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Hannes Reinecke <hare@suse.de> wrote:
> 
>> >> Any comments/suggestions welcome; otherwise please apply.
>> > 
>> > 
>> > I suggest you just use a semaphore, initialised to a suitable value:
>> > 
>> > 
>> > static struct semaphore foo = __SEMAPHORE_INITIALIZER(foo, 50);
>> > 
>> > 
>> > {
>> > 	...
>> > 	down(&foo);
>> > 	...
>> > 	up(&foo);
>> > 	...
>> > }
>> > 
>> Hmm; looks good, but: It's not possible to reliably change the maximum 
>> number of processes on the fly.
>>
>> The trivial way of course it when the waitqueue is empty and no 
>> processes are holding the semaphore. But it's quite non-obvious how this 
>> should work if processes are already holding the semaphore.
>> We would need to wait for those processes to finish, setting the length 
>> of the queue to 0 (to disallow any other process from grabbing the 
>> semaphore), and atomically set the queue length to the new value.
>> Apart from the fact that we would need a worker thread for that 
>> (otherwise the calling process might block indefinitely), there is no 
>> guarantee that the queue ever will become empty, as hotplug processes 
>> might be generated at any time.
>>
>> Or is there an easier way?
> 
> 
> Well if you want to increase the maximum number by ten you do:
> 
> 	for (i = 0; i < 10; i++)
> 		up(&foo);
> 
Indeed. That will work nicely.

> and similarly for decreasing the limit.  That will involve doing down()s,
> which will automatically wait for the current number of threads to fall to
> the desired level.
> 
Hmm. Really? I mean, is there really an effect when the semaphore 
waitqueue is active?
AFAICS down() on an semaphore with active waitqueue will always set the 
counter to -1; and as we don't have any thread corresponding to the 
down() we just issued the semaphore will continue starting threads once 
an up() is executed.

Probably not making myself clear here ...
The problem (from my point of view) with semaphores is that we don't 
have an direct counter of the number of processes waiting on that 
semaphore to become free. We do have a counter for the number of 
processes which are allowed to use the semaphore concurrently (namely 
->count), but the number of waiting processes must be gathered 
indirectly by the number of entries in the waitqueue.
Given enough processes in the waitqueue, the number of currently running 
processes effectively determines the number of processes to be started.
And as those processes are already running, I don't see an effective 
procedure how we could _reduce_ the number of processes to be started.

> But I don't really see a need to tune this on the fly - probably the worse
> problem occurs during bootup when the operator cannot perform tuning.
> 
Och aye, there is. If the calling parameters to call_usermodehelper are 
stored temporarily, you can allow for the call to return immediately 
when not enough resources are available. This way, it is even possible 
to stop khelper processes altogether (and effectively queueing all 
events) and re-enable the khelper processes at a later stage.

or you can throttle the number of khelper processes to some insanely 
small number (my test here runs with khelper_max=1), which lets you test 
your boot scripts for race conditions resp. hotplug awareness quite nicely.

> So a __setup parameter seems to be the best way of providing tunability. 
> Initialise the semaphore in usermodehelper_init().
> 
Which is what I've done.

THX Andrew, your feedback was _very_ welcome. Will wrap up a new patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
