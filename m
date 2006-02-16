Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWBPQni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWBPQni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWBPQni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:43:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60833 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932338AbWBPQnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:43:37 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	<m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	<20060216142928.GA22358@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 16 Feb 2006 09:37:42 -0700
In-Reply-To: <20060216142928.GA22358@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Thu, 16 Feb 2006 08:29:28 -0600")
Message-ID: <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> "Serge E. Hallyn" <serue@us.ibm.com> writes:
>> With respect to pids lets not get caught up in the implementation
>> details.  Let's first get clear on what the semantics should be.
>> 
>> - Should the first pid in a pid space have pid 1?
>> 
>> - Should pid == 1 ignore signals, it doesn't have a handler for?
>> 
>> - Should any children of pid 1 be allowed to live when pid == 1 is killed?
>
> But doesn't that depend on whether we use (pspace,pid) or vpids? 

No.  This is completely an implementation detail.

>  If
> vpids, then init isn't really a problem, since from kernelspace
> processes in a comtainer stil have a global pid and global parent, and
> init knows them.  If (pspace,pid), then we need a fakeinit bc the real
> init doesn't know about the processes in the container...

If you take the fakeinit you can't run a normal distro, because you are
not running init, but that is a slightly separate issue.

If (pspace, pid) we still may want to wait until all of the process die
before we report to the parent.

I choose the semantics that I figured best match what currently happens
now and would most likely make existing user space software work.

>> - Should a process have some sort of global (on the machine identifier)?
>
> I think to satisfy openvz existing customers this must be a yes.  With
> vpid the answer is simple.  With (pspace,pid), there are three anwers i've
> heard, namely
>
> 	1. just use pspaceid, pid
> 	2. make pspaceid small and use (pspaceid << SOMEBITS | pid)
> 	3. use pid1/pid2/pid3 where pid1 is creator of pid and its
> 	pspace, etc...
>
> But the openvz guys also don't want userspace tool changes, making (2)
> the most likely option.  Any other ideas?

Not really.  

Part of the problem is with pids we don't have very many bits, and
the users of pids aren't interested in all to all communication by
pids.

There is a certain sanity in making all of the pids visible in a
single flat pid namespace.  But I think there are implementation
issues.

>> - Should the pids in a pid space be visible from the outside?
>
> Again, the openvz guys say yes.

Please let them speak for themselves.

> I think it should be acceptable if a pidspace is visible in all it's
> ancestor pidspaces.  I.e. if I create pspace2 and pspace3 from pid 234
> in pspace1, then pspace2 doesn't need to be able to address pspace3
> and vice versa.

A good rule.  Now consider pspace 4 which is a child of pid 567
in pspace 3.

What should pspace 3 see? 
What should pspace 1 see?

What happens when you migrate pspace 3 into a different pspace
on a different machine?

Is there a sane implementation for this?

My only real objection to this approach is that I cannot see a sane
and simple implementation.

>> - Should the parent of pid 1 be able to wait for it for it's 
>>   children?
>
> Yes.
>
>> - Is a completely disjoin pid space acceptable to anyone?
>
> To anyone?  yes  :)
>
> TO everyone, I don't think so.

Well I would love to hear from someone it is acceptable to.
That would be an interesting perspective.

>> - What should the parent of pid == 1 see?
>> 
>> - Should a process not in the default pid space be able to create 
>>   another pid space?
>
> Yes.
>
> This is to support using pidspaces for vservers, and creating
> migrateable sub-pidspaces in each vserver.

Agreed.

Now this case is very interesting, because supporting it creates
interesting restrictions on the rest of the problem, and
unless I miss something this is where the OpenVZ implementation
currently falls down.

Which names does the intermediate pidspace (vserver) see the child
pidspace with?

Which names does the initial pidspace see the child pid space with?


>> - Should we be able to monitor a pid space from the outside?
>
> To some extent, yes.

Especially if you don't want to migrate your monitor tools
with your jobs...

>> - Should we be able to have processes enter a pid space?
>
> IMO that is crucial.

It seems to be.  However I am not yet convinced we want to
implement this in the kernel.  The in-kernel implementation is
easy but that may be dictating security policy.  So this
needs a thorough review.

A side note here is that if we allow ptrace from the outside
on even just the init process this opens things up very much
like an enter would (with respect to security). 

>> - Do we need to be able to be able to ptrace/kill individual processes
>>   in a pid space, from the outside, and why?
>
> I think this is completely unnecessary so long as a process can enter a
> pidspace.

Which is likely a good compromise.

>> - After migration what identifiers should the tasks have?
>
> It must be possible to retain the same pids, at least from inside the
> container.
>
> So this is irrelevant, as the openvz approach can just virtualize the
> old pid, while (pspace, pid) will be able to create a new container and
> use the old pid values, which are then guaranteed to not be in use.

Actually this gets to the heart of my issue with the openvz vpid
implementation.   Either I am blind or it does not address the pids 
in a nested pidspace when talking about migration.  I am not even
certain it currently allows for nested pid spaces.

If I migrate a vserver with a sub-pidspace and migrate that what do I
see?


>> If we can answer these kinds of questions we can likely focus in
>> on what the implementation should look like.  So far I have not
>> seen a question that could not be implemented with a (pspace, pid)/pid
>> or a vpid/pid implementation.
>
> But you have, haven't you?  Namely, how can openvz provide it's
> customers with a global view of all processes without putting 5 years of
> work into a new sysadmin interface?

Well I think we can reuse most of the old sysadmin interfaces yes.

Eric
