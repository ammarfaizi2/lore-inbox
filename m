Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUGZK7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUGZK7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 06:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUGZK7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 06:59:49 -0400
Received: from cantor.suse.de ([195.135.220.2]:22238 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265027AbUGZK7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 06:59:46 -0400
Message-ID: <4104E421.8080700@suse.de>
Date: Mon, 26 Jul 2004 12:59:45 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
References: <40FD23A8.6090409@suse.de> <20040725182006.6c6a36df.akpm@osdl.org>
In-Reply-To: <20040725182006.6c6a36df.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Hannes Reinecke <hare@suse.de> wrote:
> 
>>the attached patch limits the number of concurrent hotplug processes.
>> Main idea behind it is that currently each call to call_usermodehelper 
>> will result in an execve() of "/sbin/hotplug", without any check whether 
>> enough resources are available for successful execution. This leads to 
>> hotplug being stuck and in worst cases to machines being unable to boot.
>>
>> This check cannot be implemented in userspace as the resources are 
>> already taken by the time any resource check can be done; for the same 
>> reason any 'slim' programs as /sbin/hotplug will only delay the problem.
> 
> 
> hm, it's a bit sad that this happens.  Are you able to tell us more about
> what is causing such an explosion of module probes?
> 
As Christian Borntraeger already said, it's not so much an explosion of 
module probes but rather the triggering of quite a lot of events. 
Imagine loading scsi_debug with 512 devices or more ...

> 
>> Any comments/suggestions welcome; otherwise please apply.
> 
> 
> I suggest you just use a semaphore, initialised to a suitable value:
> 
> 
> static struct semaphore foo = __SEMAPHORE_INITIALIZER(foo, 50);
> 
> 
> {
> 	...
> 	down(&foo);
> 	...
> 	up(&foo);
> 	...
> }
> 
Hmm; looks good, but: It's not possible to reliably change the maximum 
number of processes on the fly.

The trivial way of course it when the waitqueue is empty and no 
processes are holding the semaphore. But it's quite non-obvious how this 
should work if processes are already holding the semaphore.
We would need to wait for those processes to finish, setting the length 
of the queue to 0 (to disallow any other process from grabbing the 
semaphore), and atomically set the queue length to the new value.
Apart from the fact that we would need a worker thread for that 
(otherwise the calling process might block indefinitely), there is no 
guarantee that the queue ever will become empty, as hotplug processes 
might be generated at any time.

Or is there an easier way?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
