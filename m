Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWGLLWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWGLLWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWGLLWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:22:11 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:14956 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751265AbWGLLWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:22:10 -0400
Message-ID: <44B4DB39.2040208@sw.ru>
Date: Wed, 12 Jul 2006 15:21:29 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <44B3D435.8090706@sw.ru> <44B3E21E.7090205@fr.ibm.com>
In-Reply-To: <44B3E21E.7090205@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Lets take a look at sys_setpriority() or any other function calling
>>find_user():
>>it can change the priority for all user or group processes like:
>>
>>do_each_thread_ve(g, p) {
>>   if (p->uid == who)
>>       error = set_one_prio(p, niceval, error);
>>} while_each_thread_ve(g, p);
> 
> 
> eh. this is openvz code ! thanks :)
it doesn't matter :)
2.6.17 code is:
                        do_each_thread(g, p)
                                if (p->uid == who)
                                        error = set_one_prio(p, niceval, error);
                        while_each_thread(g, p);

when introducing process namespaces we will have to isolate processes somehow and this loop, agree?
in this case 1 user-namespace can belong to 2 process-namespaces, agree?
how do you see this loop in the future making sure that above situation is handled correctly?
how many other such places do we have?

>>which essentially means that user-namespace becomes coupled with
>>process-namespace. Sure, we can check in every such place for
>> p->nsproxy->user_ns == current->nsproxy->user_ns
>>condition. But this a way IMHO leading to kernel full of security
>>crap which is hardly maintainable.
> 
> 
> only 4 syscalls use find_user() : sys_setpriority, sys_getpriority,
> sys_ioprio_set, sys_ioprio_get and they use it very simply to check if a
> user_struct exists for a given uid. So, it should be OK. But please see the
> attached patch.
the problem is not in find_user() actually. but in uid comparison inside
some kind of process iteration loop.
In this case you select processes p which belong to both namespaces simultenously:
i.e. processes p which belong both to user-namespace U and process-namespace P.

I hope I was more clear this time :)

>>Another example of not so evident coupling here:
>>user structure maintains number of processes/opened
>>files/sigpending/locked_shm etc.
>>if a single user can belong to different proccess/ipc/... namespaces
>>all these becomes unusable.
> 
> 
> this is the purpose of execns.
> 
> user namespace can't be unshared through the unshare syscall().
why? we do it fine in OpenVZ.

> they can
> only be unshared through execns() which flushes the previous image of the
> process. However, the execns patch still needs to close files without the
> close-on-exec flag. I didn't do it yet. lazy me :)

Kirill

