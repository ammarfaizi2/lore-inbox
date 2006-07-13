Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWGMQBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWGMQBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWGMQBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:01:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48771 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932225AbWGMQBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:01:54 -0400
Message-ID: <44B66E68.90204@fr.ibm.com>
Date: Thu, 13 Jul 2006 18:01:44 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <44B3D435.8090706@sw.ru> <44B3E21E.7090205@fr.ibm.com> <44B4DB39.2040208@sw.ru>
In-Reply-To: <44B4DB39.2040208@sw.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>> Lets take a look at sys_setpriority() or any other function calling
>>> find_user():
>>> it can change the priority for all user or group processes like:
>>>
>>> do_each_thread_ve(g, p) {
>>>   if (p->uid == who)
>>>       error = set_one_prio(p, niceval, error);
>>> } while_each_thread_ve(g, p);
>>
>>
>> eh. this is openvz code ! thanks :)
> it doesn't matter :)

it does. it means for me that you are studying proposals to see how if fits
with your existing code. which is good.

> 2.6.17 code is:
>                        do_each_thread(g, p)
>                                if (p->uid == who)
>                                        error = set_one_prio(p, niceval,
> error);
>                        while_each_thread(g, p);
> 
> when introducing process namespaces we will have to isolate processes
> somehow and this loop, agree?

yes

> in this case 1 user-namespace can belong to 2 process-namespaces, agree?
> how do you see this loop in the future making sure that above situation
> is handled correctly?

IMO, the loop should apply to the current->pidspace or equivalent inside
the loop

> how many other such places do we have?

if it's embedded in the loop, it should not be too much of an issue ?

>>> which essentially means that user-namespace becomes coupled with
>>> process-namespace. Sure, we can check in every such place for
>>> p->nsproxy->user_ns == current->nsproxy->user_ns
>>> condition. But this a way IMHO leading to kernel full of security
>>> crap which is hardly maintainable.
>>
>> only 4 syscalls use find_user() : sys_setpriority, sys_getpriority,
>> sys_ioprio_set, sys_ioprio_get and they use it very simply to check if a
>> user_struct exists for a given uid. So, it should be OK. But please
>> see the attached patch.
>
> the problem is not in find_user() actually. but in uid comparison inside
> some kind of process iteration loop. In this case you select processes
> p which belong to both namespaces simultenously: i.e. processes p which
> belong both to user-namespace U and process-namespace P.
> 
> I hope I was more clear this time :)

yes thanks,

for the moment, if processes are not isolated in some others ways, like in
openvz, these kind of loops would need the extra test 'p->nsproxy->user_ns
== current->nsproxy->user_ns' on user namespace to be valid. same issue for
filesystem and many other places. eric raised that point.

In theory, if I understand well eric's concept of namespaces, a task
belongs to a union of namespaces : ipc, process, user, net, utsname, fs,
etc. some of these namespaces could be default namespaces and some not
because they were unshared in some way: clone, unshare, exec, but in a safe
way.

They are necessary bricks for a bigger abstraction, let's call it
container, but they not sufficient by them selves because they have
dependencies. The container comes as a whole and not subsystem by
subsystem, I agree with you on that point.

>>> Another example of not so evident coupling here:
>>> user structure maintains number of processes/opened
>>> files/sigpending/locked_shm etc.
>>> if a single user can belong to different proccess/ipc/... namespaces
>>> all these becomes unusable.
>>
>>
>> this is the purpose of execns.
>>
>> user namespace can't be unshared through the unshare syscall().
>
> why? we do it fine in OpenVZ.

probably because you use the full container approach in openvz and start
the container by running init ? namespaces are a bit more painful ... I agree.

I'm still struggling with the limits of that namespace concept. Hopefully,
we meet next week because I'm also reaching my limits of digital
interaction on this topic :)

thanks,

C.

