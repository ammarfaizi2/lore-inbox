Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWBTLqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWBTLqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWBTLqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:46:20 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:4530 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964819AbWBTLqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:46:20 -0500
Message-ID: <43F9A80A.6050808@sw.ru>
Date: Mon, 20 Feb 2006 14:29:14 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, "Serge E. Hallyn" <serue@us.ibm.com>,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com> <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at>
In-Reply-To: <20060215133131.GD28677@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>And we are too cycled on PIDs. Why? I think this is the most minor 
>>feature which can easily live out of mainstream if needed, while 
>>virtualization is the main goal.
> 
> 
> although I could be totally ignorant regarding the PID
> stuff, it seems to me that it pretty well reflects the
> requirements for virtualization in general, while being
> simple enough to check/test several solutions ...
> 
> why? simple: it reflects the way 'containers' work in
> general, it has all the issues with administration and
> setup, similar to 'guests' (it requires some management
> and access from outside, while providing security and
> isolation inside), containers could be easily built on
> top of that or as an addition to the pid space structures
> at the same time it's easy to test, and issues will show
> up quite early, so that they can be discussed and, if
> necessary, solved without rewriting an entire framework.
I would disagree with you. These discussions IMHO led us to the wrong 
direction.

Can I ask a bunch of questions which are related to other virtualization 
issues, but which are not addressed by Eric anyhow?

- How are you planning to make hierarchical namespaces for such 
resources as IPC? Sockets? Unix sockets?
Process tree is hierarchical by it's nature. But what is heirarchical 
IPC and other resources?
And no one ever told me why we need heierarchy at all. No any _real_ use 
cases. But it's ok.

- Eric wants to introduce name spaces, but totally forgots how much they 
are tied with each other. IPC refers to netlinks, network refers to proc 
and sysctl, etc. It is some rare cases when you will be able to use 
namespaces without full OpenVZ/vserver containers.
But yes, you are right it will be quite easy for us to use containers on 
top of namespaces :)

- How long these namespaces live? And which management interface each of 
them will have?
For example, can you destroy some namespace? Or it is automatically 
destroyed when the last reference to it is dropped? This is not that 
simple question as it may seem to be, especially taking into account 
that some namespaces can live longer (e.g. time wait buckets should live 
some time after container died; or shm which also can die in a foreign 
context...).

So I really hate that we concentrated on discussion of VPIDs, while 
there are more general and global questions on the whole virtualization 
itself.

> now that you mention it, maybe we should have a few
> rounds how those 'generic' container syscalls would 
> look like?

First of all, I don't think syscalls like
"do_something and exec" should be introduced.

Next, these syscalls interfaces can be introduced only after we 
discussed the _general_ concepts, like: how these containers exist, 
live, are created, waited and so on. But this is impossible to discuss 
on PID example only. Because:
1. pids are directly related to process lifetime. no much issues here.
2. pids are hierarchical by its nature.
3. there are much more approaches here, then in network for example.

Kirill

