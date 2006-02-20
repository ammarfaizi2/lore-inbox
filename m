Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWBTJWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWBTJWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWBTJWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:22:18 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:53290 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964800AbWBTJWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:22:17 -0500
Message-ID: <43F9882C.3060501@sw.ru>
Date: Mon, 20 Feb 2006 12:13:16 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> With respect to pids lets not get caught up in the implementation
> details.  Let's first get clear on what the semantics should be.
> 
> - Should the first pid in a pid space have pid 1?
yup.

> - Should pid == 1 ignore signals, it doesn't have a handler for?
yup.

> - Should any children of pid 1 be allowed to live when pid == 1 is killed?
nope. you have this problem in your code, when child_reaper references 
freed task.

> - Should a process have some sort of global (on the machine identifier)?
yep. otherwise it is imposible to manage (ptrace, kill, ...) it, without 
introducing new syscalls.

> - Should the pids in a pid space be visible from the outside?
This can be done tunable, but this is VERY highly desired.
This also makes introducing many new syscalls unneeded.

> - Should the parent of pid 1 be able to wait for it for it's 
>   children?
What for? This doesn't guarantee any completion of the container destroy.

> - Is a completely disjoin pid space acceptable to anyone?
no, not acceptable for us :)

> - What should the parent of pid == 1 see?
if pidspaces are fully isolated it should see nothing (otherwise, it is 
still weak isolation, as host admin will be able to get access to the 
container).
if pidspaces are weak isolated it should see the whole process tree.

> - Should a process not in the default pid space be able to create 
>   another pid space?
optional. I really can hardly see it's usecases, if any...
Yes, I remember some talks about checkpointing of group of processes, 
but this doesn't help it, believe me (ask Kuznetsov :) )...

> - Should we be able to monitor a pid space from the outside?
Yes. We strongly beleive we need it.

> - Should we be able to have processes enter a pid space?
Yes. The same.

> - Do we need to be able to be able to ptrace/kill individual processes
>   in a pid space, from the outside, and why?
Yes. This is very helpful management feature. Otherwise you won't be 
able to resolve issues with containers. Why it stuck? For example, after 
checkpoint/restore how do plan to debug it?

> - After migration what identifiers should the tasks have?
pids? in pspace it should the same pids which were assigned to them on 
fork(). in host they can have any other pid allocated.

> If we can answer these kinds of questions we can likely focus in
> on what the implementation should look like.  So far I have not
> seen a question that could not be implemented with a (pspace, pid)/pid
> or a vpid/pid implementation.
It seems to me that we still talk too much about PID spaces, while this 
is not the most problematic thing. This can be out of tree for some time 
if required.

> I think it is safe to say that from the inside things should look to
> processes just as they do now.  Which answers a lot of those
> questions.  But it still leaves a lot open.

Kirill

