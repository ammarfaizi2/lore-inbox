Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWCJKNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWCJKNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 05:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWCJKNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 05:13:16 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:7477 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751626AbWCJKNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 05:13:16 -0500
Message-ID: <4411524B.1000707@openvz.org>
Date: Fri, 10 Mar 2006 13:17:47 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com
Subject: Re: sysctls inside containers
References: <43F9E411.1060305@sw.ru>	 <m1oe0wbfed.fsf@ebiederm.dsl.xmission.com>	 <1141062132.8697.161.camel@localhost.localdomain>	 <m1ek1owllf.fsf@ebiederm.dsl.xmission.com> <1141442246.9274.14.camel@localhost.localdomain>
In-Reply-To: <1141442246.9274.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I at least got to the point of seeing how the sysctls interact
> when I tried to containerize them.  Eric, I think the idea of the sysv
> code being nicely and completely isolated is pretty much gone, due to
> their connection to sysctls.  I think I'll go back and just isolate the
> "struct ipc_ids" portion.  We can do the accounting bits later.
> 
> The patches I have will isolate the IDs, but I'm not sure how much sense
> that makes without doing the things like the shm_tot variable.  Does
> anybody think we need to go after sysctls first, perhaps?  Or, is this a
> problem graph with cycles in it? :)
> 
> I don't see an immediately clear solution on how to containerize sysctls
> properly.  The entire construct seems to be built around getting data
> from in and out of global variables and into /proc files.
> 
> We obviously want to be rid of many of these global variables.  So, does
> it make sense to introduce different classes of sysctls, at least
> internally?  There are probably just two types: global, writable only
> from the root container and container-private.  Does it make sense to
> have _both_?  Perhaps a sysadmin 
> 
> Eric, can you think of how you would represent these in the hierarchical
> container model?  How would they work?
> 
> On another note, after messing with putting data in the init_task for
> these things, I'm a little more convinced that we aren't going to want
> to clutter up the task_struct with all kinds of containerized resources,
> _plus_ make all of the interfaces to share or unshare each of those.
> That global 'struct container' is looking a bit more attractive.

After checking proposed yours, Eric and vserver solutions, I must say 
that these all are hacks.
If we want to virtualize sysctl we need to do it in honest way:
multiple sysctl trees, which can be different in different namespaces.
For example, one namespace can see /proc/sys/net/route and the other one 
not. Introducing helpers/handlers etc. doesn't fully solve the problem 
of visibility of different parts of sysctl tree and it's access rights.
Another example, the same network device can present in 2 namespaces and 
these are dynamically(!) created entries in sysctl.

So we need to address actually 2 issues:
- ability to limit parts of sysctl tree visibility to namespace
- ability to limit/change sysctl access rights in namespace

You can check OpenVZ for cloning sysctl tree code. It is not clean, nor 
elegant, but can be cleanuped.

Thanks,
Kirill

