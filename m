Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWBQDfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWBQDfu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 22:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWBQDfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 22:35:50 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:28593 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750810AbWBQDft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 22:35:49 -0500
Message-ID: <43F5448A.6020501@watson.ibm.com>
Date: Thu, 16 Feb 2006 22:35:38 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com>
In-Reply-To: <20060216142928.GA22358@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> Quoting Eric W. Biederman (ebiederm@xmission.com):
> 
>>"Serge E. Hallyn" <serue@us.ibm.com> writes:
>>With respect to pids lets not get caught up in the implementation
>>details.  Let's first get clear on what the semantics should be.
>>
>>- Should the first pid in a pid space have pid 1?
that should only be required if you have system containers
or if there are tools or requirements that if I wonderup my process tree
that I ultimately must end up at 1.
>>
>>- Should pid == 1 ignore signals, it doesn't have a handler for?

Yes
>>
>>- Should any children of pid 1 be allowed to live when pid == 1 is killed?
No  .. it has init semantics !

> 
> 
> But doesn't that depend on whether we use (pspace,pid) or vpids?  If
> vpids, then init isn't really a problem, since from kernelspace
> processes in a comtainer stil have a global pid and global parent, and
> init knows them.  If (pspace,pid), then we need a fakeinit bc the real
> init doesn't know about the processes in the container...
> 
> 
>>- Should a process have some sort of global (on the machine identifier)?

First establish whether that global ID has to be persistent ...
I don't see why ! In which case the TASK_REF is the perfect global ID.
> 
> 
> I think to satisfy openvz existing customers this must be a yes.  With
> vpid the answer is simple.  With (pspace,pid), there are three anwers i've
> heard, namely
> 
> 	1. just use pspaceid, pid
> 	2. make pspaceid small and use (pspaceid << SOMEBITS | pid)
> 	3. use pid1/pid2/pid3 where pid1 is creator of pid and its
> 	pspace, etc...
This implies that pid2 can be looked up in the context of pid1.
In OpenVZ approach that's possible, In pspaces.. isn't that the wpid ?

> 
> But the openvz guys also don't want userspace tool changes, making (2)
> the most likely option.  Any other ideas?
> 
> 
>>- Should the pids in a pid space be visible from the outside?
> 
> 
> Again, the openvz guys say yes.
> 
> I think it should be acceptable if a pidspace is visible in all it's
> ancestor pidspaces.  I.e. if I create pspace2 and pspace3 from pid 234
> in pspace1, then pspace2 doesn't need to be able to address pspace3
> and vice versa.

That means you need to do a more complicated lookup ! for instance let's say you have hierarchy
pspace1
    |--->pspace2
    |       |--->pspace2a
    |--->pspace3	
            |--->pspace3a

let's assume we use the (pspaceid<<BITS | pid ) global id. To verify I have to
ensure that the target pid can reach the originating pid in its ancestor path.
Not a biggy as these pspace trees probably won't get much deeper then 3 or 4.

> 
> Kirill, is that acceptable?
> 
> 
>>- Should the parent of pid 1 be able to wait for it for it's 
>>  children?
> 
> Yes.

Yes ... VPID does that and wpid in pspace does that as well.
> 
> 
>>- Is a completely disjoin pid space acceptable to anyone?
> 
> 
> To anyone?  yes  :)
> 
> TO everyone, I don't think so.
> 
hehh...   yes they should be disjoined other then at the top
where we want to wait ..
> 
>>- What should the parent of pid == 1 see?
>>
>>- Should a process not in the default pid space be able to create 
>>  another pid space?
> 
> 
> Yes.

How else do you get hierarchy ....

> 
> This is to support using pidspaces for vservers, and creating
> migrateable sub-pidspaces in each vserver.
> 
> 
>>- Should we be able to monitor a pid space from the outside?
> 
> 
> To some extent, yes.
> 
> 
>>- Should we be able to have processes enter a pid space?
> 
> 
> IMO that is crucial.

Existing ones .. now that is potentially difficult to do. Particular
if you want to enter a pidspace that has already been migrated.
Because ones assigned pid might already been taken in the target pspace.

> 
> 
>>- Do we need to be able to be able to ptrace/kill individual processes
>>  in a pid space, from the outside, and why?
> 
> 
> I think this is completely unnecessary so long as a process can enter a
> pidspace.
> 
> 
>>- After migration what identifiers should the tasks have?
> 
> 
> It must be possible to retain the same pids, at least from inside the
> container.

Absolutely .. otherwise all cashed pids in userspace are meaningless.

> 
> So this is irrelevant, as the openvz approach can just virtualize the
> old pid, while (pspace, pid) will be able to create a new container and
> use the old pid values, which are then guaranteed to not be in use.

Exactly .. mute issue, this is "trivial" as long as you can fork with
a particular pid used.

> 
> 
>>If we can answer these kinds of questions we can likely focus in
>>on what the implementation should look like.  So far I have not
>>seen a question that could not be implemented with a (pspace, pid)/pid
>>or a vpid/pid implementation.
> 
> 
> But you have, haven't you?  Namely, how can openvz provide it's
> customers with a global view of all processes without putting 5 years of
> work into a new sysadmin interface?
> 
> -serge
> 


