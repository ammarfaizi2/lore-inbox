Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWBTMJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWBTMJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWBTMJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:09:27 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:22572 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964915AbWBTMJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:09:26 -0500
Message-ID: <43F9B1F4.4040907@sw.ru>
Date: Mon, 20 Feb 2006 15:11:32 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       Dmitry Mishin <dim@sw.ru>, Andi Kleen <ak@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
References: <43E7C65F.3050609@openvz.org>	<m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>	<20060207201908.GJ6931@sergelap.austin.ibm.com>	<43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com>
In-Reply-To: <43E92EDC.8040603@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The questions seem to break down into:
>> 1) Where do we put the references to the different namespaces?
>>    - Do we put the references in a struct container that we reference 
>> from struct task_struct?
>>    - Do we put the references directly in struct task_struct?
> 
> 
> You "cache"   task_struct->container->hotsubsys   under 
> task_struct->hotsubsys.
> We don't change containers other then at clone time, so no coherency 
> issue here !!!!
> Which subsystems pointers to "cache", should be agreed by the experts,
> but first approach should always not to cache and go through the container.
agreed. I see no much reason to cache it and make tons of the same 
pointers in all the tasks. Only if needed.
Also, in OpenVZ container has many fields intergrated inside, so there 
is no additional dereference, but task->container->subsys_field

>> 2) What is the syscall interface to create these namespaces?
>>    - Do we add clone flags?       (Plan 9 style)
> Like that approach .. flexible .. particular when one has well specified 
> namespaces.
mmm, how do you plan to pass additional flags to clone()?
e.g. strong or weak isolation of pids?

another questions:
how do you plan to meet the dependancies between namespaces?
e.g. conntracks require netfilters to be initialized.
network requires sysctls and proc to be initialized and so on.
do you propose to track all this in clone()? huh...

>>    - Do we add a syscall (similar to setsid) per namespace?
>>      (Traditional unix style)?
can be so...

>>    - Do we in addition add syscalls to manipulate containers generically?
>>
>>    I don't think having a single system call to create a container and 
>> a new
>>    instance of each namespace is reasonable as that does not give us a
>>    path into the future when we create yet another namespace.
>>
> Agreed.
why do you think so?
this syscalls will start handling this new namespace and that's all.
this is not different from many syscalls approach.

>> 4) How do we implement each of these namespaces?
>>    Besides being maintainable are there other constraints?
>>
> Good question... at least with PID and FS two are there ..
>>
>> 6) How do we do all of this efficiently without a noticeable impact on
>>    performance?
>>    - I have already heard concerns that I might be introducing cache
>>      line bounces and thus increasing tasklist_lock hold time.
>>      Which on big way systems can be a problem.
this is nothing compared to hierarchy operations.
BTW, heirarchy also introduces complicated resource accounting, 
sometimes making it even impossible.

Kirill

