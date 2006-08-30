Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWH3QTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWH3QTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWH3QTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:19:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:47845 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751109AbWH3QS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:18:59 -0400
Message-ID: <44F5BA6F.2070900@fr.ibm.com>
Date: Wed, 30 Aug 2006 18:18:55 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: video4linux-list@redhat.com, kraxel@bytesex.org, Containers@lists.osdl.org,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] kthread: saa7134-tvaudio.c
References: <20060829211555.GB1945@us.ibm.com>	<20060829143902.a6aa2712.akpm@osdl.org>	<m1k64rf9om.fsf@ebiederm.dsl.xmission.com>	<m164gafld6.fsf@ebiederm.dsl.xmission.com>	<44F59B84.3090906@fr.ibm.com> <m1lkp6cjq2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkp6cjq2.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

[ ... ]

>>> That plus the obvious bit.  For the pid namespace we have to declare
>>> war on people storing a pid_t values.  Either converting them to
>>> struct pid * or removing them entirely.  Doing the kernel_thread to
>>> kthread conversion removes them entirely.
>> we've started that war, won a few battles but some drivers need more work
>> that a simple replace. If we could give some priorities, it would help to
>> focus on the most important ones. check out the list bellow.
> 
> Sure, I think I can help.
> 
> There are a couple of test I can think of that should help.
> 1) Is the pid value stored.  If not a pid namespace won't affect
>    it's normal operation.

I've extracted this list from a table which includes a pid cache column.
this pid cache column is not complete yet. I'd be nice if we could use a
wiki to maintain this table, the existing openvz or vserver wiki ?

> 2) Is this thread started during kernel boot before this thread
>    could have a user space parent.  If it can't have a user space
>    parent then it can't take a reference to user space resources.

ok we need to add this one.

> 3) Can the code be compiled modular and will it break when we stop
>    exporting kernel_thread.

got that also.

> 4) How frequently is this thing used.  The more common code is probably
>    in better shape and more likely to get a good maintainer response, and
>    we care more :)

sure :) some drivers are for some exotic piece of hardware that are not
currently found on a standard server.

> irqbalanced from arch/i386/kernel/io_apic.c should be safe to leave alone 
> because it doesn't store a pid_t, it is started during boot, and it can't
> be compiled modular. 
> 
>>From what I have seen you can shorten the list by several entries by removing
> code like irqbalanced that can't possibly cause us any problems.
> kvoyagerd from arch/i386/mach-voyager/voyager_thread.c is another one.

ok thanks, will update.

> The first on my personal hit list is nfs.  
>> fs/lockd/clntlock.c
>> fs/nfs/delegation.c
>> net/sunrpc/svc.c
> 
> Because it does store pid_t values, it isn't started during kernel boot,
> it can be compiled modular, and people use it all of the time.

yes yes. hard stuff though which requires time.

> I do agree from what I have seen, that changing idioms to the kthread way of
> doing things isn't simply a matter of substitute and replace which is
> unfortunate.  Although the biggest hurdle seems to be to teach kernel threads
> to communicate with something besides signals.  Which is a general help anyway.
> 
> Unfortunately I'm distracted at the moment so I haven't gone through the entire
> list but I hope this helps.

we would need a wiki to maintain the work in progress on that topic while
we work on the pidspace.

another list to maintain would be the pid_t to struct pid replacement.

C.
