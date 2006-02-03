Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWBCKuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWBCKuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 05:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWBCKuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 05:50:21 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:18696 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932196AbWBCKuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 05:50:20 -0500
Message-ID: <43E335D4.9000401@sw.ru>
Date: Fri, 03 Feb 2006 13:52:04 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	<20060117143326.283450000@sergelap>	<1137511972.3005.33.camel@laptopd505.fenrus.org>	<20060117155600.GF20632@sergelap.austin.ibm.com>	<1137513818.14135.23.camel@localhost.localdomain>	<1137518714.5526.8.camel@localhost.localdomain>	<20060118045518.GB7292@kroah.com>	<1137601395.7850.9.camel@localhost.localdomain>	<m1fyniomw2.fsf@ebiederm.dsl.xmission.com>	<43D14578.6060801@watson.ibm.com>	<Pine.LNX.4.64.0601311248180.7301@g5.osdl.org>	<43E21BD0.6000606@sw.ru> <m1d5i5vln3.fsf@ebiederm.dsl.xmission.com>	<43E2249D.8060608@sw.ru> <m1vevxu5bh.fsf@ebiederm.dsl.xmission.com>	<43E22DCA.3070004@sw.ru> <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkwtu3om.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I hope you understand, that such things do not make anything
>>secure. Administrator of the node will always have access to /proc/kcore,
>>devices, KERNEL CODE(!) etc. No security from this point of view.
> Only if they have CAP_SYS_RAWIO.  I admit it takes a lot more
> to get there than just that.  But having a mechanism that has the
> potential to be secured and is much simpler to understand
> and to setup for minimal privileges than any of the other unix
> addons I have seen is very interesting.
ok. I suppose it can be done as an option. If required, access from host 
system can be allowed. If "secure" environment is requested - fully 
isolated.

>>>3) Nesting of containers, (so they are general purpose and not special hacks).
>>
>>Why are you interested in nesting? Any applications for this?
>>Until everything is virtualized in nesting way (including TCP/IP stack, routing
>>etc.) I see no much use of it.
> For everything except the PID namespace I am just interested in having multiple
> separate namespaces.  For the PID namespace to keep the traditional unix
> model you need a parent process so it is actually nesting.
Yes, but nesting can be one level as in OpenVZ, when VPS is a nested 
namespace inside host system or it can be a fully isolated separate 
traditional namespace.

By real nesting I mean hierarchical containers, when containers inside 
multiple containers are allowed. This is hard to implement. For example, 
for real containers you will need to have isolated TCP/IP stacks and 
with complex rules of routing etc.

> I am interested because, it is easy, because if it is possible than
> the range of applications you can apply a containers to is much
> larger.  At the far end of that spectrum is migrating a server running
> on real hardware and bringing it up as a guest on a newer much more
> powerful machine.  With the appearance that it had only been
> unreachable for a few seconds.
You can use fully isolated containers like OpenVZ VPSs for this. They 
are naturally suitable for this, because provide you not PIDs isolation 
only, but also IPC, sockets, etc.

How can you migrate application which consists of two processes doing 
IPC via signals? They are not tired inside kernel anyhow and there is no 
way to automatically detect that both should be migrated together.
VPSs what provides you such kind of boundaries of what should be 
considered as a whole.

>>>The vserver way of solving some of these problems is to provide a way
>>>to enter the guest.  I would rather have some explicit operation that puts
>>>you into the guest context so there is a single point where we can tackle
>>>the nested security issues, than to have hundreds of places we have to
>>>look at individually.
>>
>>Huh, it sounds too easy. Just imagine that VPS owner has deleted ps, top, kill,
>>bash and other tools. You won't be able to enter. 

> Entering is different from execing a process on the inside.
> Implementation wise it is changing the context pointer on your task.
If I understand you correctly it is fully insecure way of doing things. 
After changing context without applying all the restrictions which 
should be implied by VPS your process will be ptrace'able and so on.

>>Another example when VPS owner
>>is near its resource limits - you won't be able to do anything after VPS
>>entering.
> For debugging this is a good reason for being inside.  What if the
> problem is that you are out of resources?  
Debugging - yes, in production - no.
That is why OpenVZ allows host system to access VPS resources - for 
debugging in production.

> I have no intention of requiring monitoring to work from the inside though.
>>Do you need other examples?
> No I need to post patches.
Thanks a lot for valuable discussion and your time!

Kirill

