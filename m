Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWBMInp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWBMInp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWBMIno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:43:44 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:21397 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751348AbWBMIno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:43:44 -0500
Message-ID: <43F046B0.7020702@sw.ru>
Date: Mon, 13 Feb 2006 11:43:28 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
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
Subject: Re: [RFC][PATCH 01/20] pid: Intoduce the concept of a wid (wait id)
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <43ECE0AB.1010608@sw.ru> <m1lkwixn68.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkwixn68.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>2. Maybe I'm missing something in the discussions, but why is it required? if
>>you provide fully isolated pid spaces, why do you care for wid?
>>And how ptrace can work at all if cldstop reports some pid, but child is not
>>accessiable via ptrace()? and if it doesn't work, what are your changes for?
> 
> 
> A good question.
> 
> My pid spaces while isolated from each other are connected together in
> something that resembles the mount relationship when mounting a filesystem.
why? is it really required?
doing it this way, you get all the issues with external refs we have 
with a weak isolation, i.e. pspace init can be seen from outside and 
inside (correct? or am I wrong?). This makes your approach eseentially 
the same as ours from checkpointing point of view BTW.

> The init process of a child pspace is visible in the parent pspace,
> by it's wid.  So you should be able to ptrace pid == 1.  The other
> children remain inaccessible directly.
> 
> The idea was to do my very best to preserve the unix process tree when
> constructing a separate pid space
This more looks like you were trying to make less changes with it and 
avoid fixing issus which can arise when pspaces are fully isolated. 
Maybe I'm wrong.

> I have to admit I have not yet tested the ptrace corner case, or
> digested all of it's ramifications.  Unless I have messed up somewhere
> it should just work.
> 
> This visibility of the child tree by a single pid inside the parent
> tree is why I think my approach doesn't suffer from most of the
> problems a completely isolated pid space has.
which problems? Actually I can't see much problems with isolated pid 
spaces. And isolated pid spaces doesn't require hierarchy, since they 
are fully isolated.

> In fact I would even be willing to look at it as a global but
> hierarchical pid space if that proved an interesting case.
> So you could have something like pkill(int sig, int which, char *pid_path).
> Where pid_path is something like "1537/3/58", and which specified
> what kind of pid you are talking about (thread, pid, process group...)
And here you need to introduce new non-unix semantics, security checks 
on lookups, etc.

>>From a security stand point I want the option of a fully isolated
> group of processes, so there is a possibility of keeping secrets from
> the system administrator, but there is no reason that needs to be tied
> to a pid space.

Kirill

