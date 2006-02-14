Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWBNAGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWBNAGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWBNAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:06:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54761 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030223AbWBNAGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:06:45 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
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
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <43ECE0AB.1010608@sw.ru>
	<m1lkwixn68.fsf@ebiederm.dsl.xmission.com> <43F046B0.7020702@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 13 Feb 2006 17:04:11 -0700
In-Reply-To: <43F046B0.7020702@sw.ru> (Kirill Korotaev's message of "Mon, 13
 Feb 2006 11:43:28 +0300")
Message-ID: <m1fymmvm9w.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

>>>2. Maybe I'm missing something in the discussions, but why is it required? if
>>>you provide fully isolated pid spaces, why do you care for wid?
>>>And how ptrace can work at all if cldstop reports some pid, but child is not
>>>accessiable via ptrace()? and if it doesn't work, what are your changes for?
>> A good question.
>> My pid spaces while isolated from each other are connected together in
>> something that resembles the mount relationship when mounting a filesystem.
> why? is it really required?

A very good question.  Supporting waitpid and the normal process management
semantics seems to be a requirement for usability.  Completely separate pid
spaces would probably be easier to implement.  However then we would need
to implement another interface like waitpid to allow for notifications when
the all of the processes exited.

I have not seen any alternatives being proposed to handle that case.

> doing it this way, you get all the issues with external refs we have with a weak
> isolation, i.e. pspace init can be seen from outside and inside (correct? or am
> I wrong?). 

Largely correct.  Looking at it from the outside is like looking at a thread
group leader.  Sometimes you see the leader sometimes you see the entire
group of processes.

> This makes your approach eseentially the same as ours from
> checkpointing point of view BTW.

Sure.  Any attempt to build a general purpose mechanism will suffer from
that.  But it is easy enough to drop the external references from the
init processes, and then it's children don't have a chance to get them.


>> The init process of a child pspace is visible in the parent pspace,
>> by it's wid.  So you should be able to ptrace pid == 1.  The other
>> children remain inaccessible directly.
>> The idea was to do my very best to preserve the unix process tree when
>> constructing a separate pid space
> This more looks like you were trying to make less changes with it and avoid
> fixing issus which can arise when pspaces are fully isolated. Maybe I'm wrong.

It's not sloth.  Simply trying to extend the existing API.  Not changing
what doesn't need to be changed is a virtue.

But yes fully isolated pid spaces are unmanageable unless you add and API
to deal with it.  My api is using the wid to allow a parent process to manage
it essentially like normal.

>> I have to admit I have not yet tested the ptrace corner case, or
>> digested all of it's ramifications.  Unless I have messed up somewhere
>> it should just work.
>> This visibility of the child tree by a single pid inside the parent
>> tree is why I think my approach doesn't suffer from most of the
>> problems a completely isolated pid space has.
> which problems? Actually I can't see much problems with isolated pid spaces. And
> isolated pid spaces doesn't require hierarchy, since they are fully isolated.

You also don't find them interesting enough to implement.  Or else we are using
the same terms to mean different things.

>> In fact I would even be willing to look at it as a global but
>> hierarchical pid space if that proved an interesting case.
>> So you could have something like pkill(int sig, int which, char *pid_path).
>> Where pid_path is something like "1537/3/58", and which specified
>> what kind of pid you are talking about (thread, pid, process group...)
> And here you need to introduce new non-unix semantics, security checks on
> lookups, etc.

Sure you need to introduce new semantics, etc.  But nothing more
than what you already have in OpenVZ.  The only necessary difference
is in how you name the process.   The target process is still being
manipulated by a process outside of it's scope of existence.

So if the need for doing that is as great as you say it is something
that is doable, and their may be other methods that are easier to work
with.

Personally I only implemented as much manipulation of the init
processes as I did because it came for free.  I don't see the need
to manipulate a process in another pid namespace.

Eric
