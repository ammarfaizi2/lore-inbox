Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWBPOaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWBPOaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWBPOaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:30:35 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:26774 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932484AbWBPOae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:30:34 -0500
Date: Thu, 16 Feb 2006 15:30:30 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
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
Message-ID: <20060216143030.GA27585@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Hansen <haveblue@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Suleiman Souhlal <ssouhlal@FreeBSD.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Cedric Le Goater <clg@fr.ibm.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, Greg <gkurz@fr.ibm.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
	Andi Kleen <ak@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jes Sorensen <jes@sgi.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 03:12:13PM -0700, Eric W. Biederman wrote:
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Hi,
> >
> > the lkml discussion on pid virtualization has been covering many of the
> > issues both relating directly to pid virtualization, and relating to
> > optimizations in the two specific implementations.
> >
> > However, if we're going to get anywhere, the first decision which we
> > need to make is whether to go with a (container,pid), (pspace,pid) or
> > equivalent pair like approach, or a virtualized pid approach.  Linus had
> > previously said that he prefers the former.  Since there has been much
> > discussion since then, I thought I'd try to recap the pros and cons of
> > each approach, with the hope that the head Penguins will chime in one
> > more time, after which we can hopefully focus our efforts.
> 
> Does anyone see problems with implementing this as series of namespaces?
> If not we can move forward and start talking about pids, and the
> other namespaces.
> 
> With respect to pids lets not get caught up in the implementation
> details.  Let's first get clear on what the semantics should be.
> 
> - Should the first pid in a pid space have pid 1?

depends, usually either one process has pid==1 (the init)
or no process should use that pid (still handled special)
nevertheless, the latter case requires a 'fake' pid==1
to make some userspace processes happy (e.g. pstree)

> - Should pid == 1 ignore signals, it doesn't have a handler for?

the 'init' process must be protected in a similar fashion
than the real init is, otherwise guests will end up dying
in certain situations, of course, it would be nice to have
some kind of flag to turn this on and off

> - Should any children of pid 1 be allowed to live 
>   when pid == 1 is killed?

agan that's a feature which would be nice, especially
for the lightweight contexts, which do not have an init
process running inside the guest

> - Should a process have some sort of global (on the machine identifier)?

this is mandatory, as it is required to kill any process
from the host (admin) context, without entering the pid
space (which would lead to all kind of security issues)

> - Should the pids in a pid space be visible from the outside?

yes, while not strictly required, folks really like to
view the overall system state. this can be done with the
help of special tools, but again it should be done
without entering each guest pid space ...

> - Should the parent of pid 1 be able to wait for it for it's 
>   children?

definitely, we (Linux-VServer) added this some time ago
and it helps to maintain/restart a guest.

> - Is a completely disjoin pid space acceptable to anyone?

yes, as long as the beforementioned access, management
and control mechanisms are in place ...

> - What should the parent of pid == 1 see?

doesn't really matter, but I see three options there:
 
 - the parent space
 - the child space
 - both

> - Should a process not in the default pid space be able to create 
>   another pid space?

that would be a requirement for hierarchical spaces

> - Should we be able to monitor a pid space from the outside?

yes, definitely, but it could happen via some special
interfaces, i.e. no need to make it compatible

> - Should we be able to have processes enter a pid space?

definitely, without that, the entire VPS concept will
not work, folks use the 'admin' backdoors 90% of the
time ...

> - Do we need to be able to be able to ptrace/kill individual 
> processes in a pid space, from the outside, and why?

ptrace: no not really, if there are issues which want
  to be investigated, you can always enter the space and
  attach the strace there. IMHO there is not much info
  in ptracing the space creation/transition

kill: yes, once you identified an evil guest process,
  you want to get rid of it, without entering the space

> - After migration what identifiers should the tasks have?

doesn't matter, as long as they are unique, so
 ppid1/ppid2/ppid3/pid would work ...

> If we can answer these kinds of questions we can likely focus in on
> what the implementation should look like. So far I have not seen a
> question that could not be implemented with a (pspace, pid)/pid or a
> vpid/pid implementation.

best,
Herbert

> I think it is safe to say that from the inside things should look to
> processes just as they do now.  Which answers a lot of those
> questions.  But it still leaves a lot open.
> 
> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
