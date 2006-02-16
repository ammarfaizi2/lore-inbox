Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWBPO3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWBPO3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWBPO3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:29:40 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:45717 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932474AbWBPO3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:29:39 -0500
Date: Thu, 16 Feb 2006 08:29:28 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
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
Message-ID: <20060216142928.GA22358@sergelap.austin.ibm.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> With respect to pids lets not get caught up in the implementation
> details.  Let's first get clear on what the semantics should be.
> 
> - Should the first pid in a pid space have pid 1?
> 
> - Should pid == 1 ignore signals, it doesn't have a handler for?
> 
> - Should any children of pid 1 be allowed to live when pid == 1 is killed?

But doesn't that depend on whether we use (pspace,pid) or vpids?  If
vpids, then init isn't really a problem, since from kernelspace
processes in a comtainer stil have a global pid and global parent, and
init knows them.  If (pspace,pid), then we need a fakeinit bc the real
init doesn't know about the processes in the container...

> - Should a process have some sort of global (on the machine identifier)?

I think to satisfy openvz existing customers this must be a yes.  With
vpid the answer is simple.  With (pspace,pid), there are three anwers i've
heard, namely

	1. just use pspaceid, pid
	2. make pspaceid small and use (pspaceid << SOMEBITS | pid)
	3. use pid1/pid2/pid3 where pid1 is creator of pid and its
	pspace, etc...

But the openvz guys also don't want userspace tool changes, making (2)
the most likely option.  Any other ideas?

> - Should the pids in a pid space be visible from the outside?

Again, the openvz guys say yes.

I think it should be acceptable if a pidspace is visible in all it's
ancestor pidspaces.  I.e. if I create pspace2 and pspace3 from pid 234
in pspace1, then pspace2 doesn't need to be able to address pspace3
and vice versa.

Kirill, is that acceptable?

> - Should the parent of pid 1 be able to wait for it for it's 
>   children?

Yes.

> - Is a completely disjoin pid space acceptable to anyone?

To anyone?  yes  :)

TO everyone, I don't think so.

> - What should the parent of pid == 1 see?
> 
> - Should a process not in the default pid space be able to create 
>   another pid space?

Yes.

This is to support using pidspaces for vservers, and creating
migrateable sub-pidspaces in each vserver.

> - Should we be able to monitor a pid space from the outside?

To some extent, yes.

> - Should we be able to have processes enter a pid space?

IMO that is crucial.

> - Do we need to be able to be able to ptrace/kill individual processes
>   in a pid space, from the outside, and why?

I think this is completely unnecessary so long as a process can enter a
pidspace.

> - After migration what identifiers should the tasks have?

It must be possible to retain the same pids, at least from inside the
container.

So this is irrelevant, as the openvz approach can just virtualize the
old pid, while (pspace, pid) will be able to create a new container and
use the old pid values, which are then guaranteed to not be in use.

> If we can answer these kinds of questions we can likely focus in
> on what the implementation should look like.  So far I have not
> seen a question that could not be implemented with a (pspace, pid)/pid
> or a vpid/pid implementation.

But you have, haven't you?  Namely, how can openvz provide it's
customers with a global view of all processes without putting 5 years of
work into a new sysadmin interface?

-serge
