Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWBTNAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWBTNAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWBTNAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:00:23 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:37091 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932156AbWBTNAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:00:21 -0500
Date: Mon, 20 Feb 2006 14:00:20 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Hansen <haveblue@us.ibm.com>,
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
Message-ID: <20060220130020.GD17478@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
	vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216143030.GA27585@MAIL.13thfloor.at> <43F990CA.5080102@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F990CA.5080102@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 12:50:02PM +0300, Kirill Korotaev wrote:
> Hello,
> 
> >>- Should any children of pid 1 be allowed to live 
> >> when pid == 1 is killed?
> 
> >agan that's a feature which would be nice, especially
> >for the lightweight contexts, which do not have an init
> >process running inside the guest
> whom should child_reaper refer to?

as Eric already pointed out, those tasks could
either be self reaping or be reaped by a single
kernel init/reaper

> >>- Should a process have some sort of global (on the machine
> >>identifier)?
> >this is mandatory, as it is required to kill any process
> >from the host (admin) context, without entering the pid
> >space (which would lead to all kind of security issues)
> fine, agreed on this finally, same for OpenVZ.

hey we have soemthing :)

> >>- Should the pids in a pid space be visible from the outside?
> >yes, while not strictly required, folks really like to
> >view the overall system state. this can be done with the
> >help of special tools, but again it should be done
> >without entering each guest pid space ...
> also fine.
> 
> >>- Should the parent of pid 1 be able to wait for it for it's 
> >> children?
> >definitely, we (Linux-VServer) added this some time ago
> >and it helps to maintain/restart a guest.
> but why sys_waitpid? we can make it in many other ways,

yes, we currently have a syscall switch command 
to wait for the guest, but, of course, it is
very similar to the 'normal' unix waitpid()

> can't we? moreover, sys_waitpid() is the most unnatural from my point
> of view, since container is not fully dead when the last process dies,
> it makes some cleanup postponed.

that is correct, the interesting event is not
the disposal of the pid space (i.e. not the last
reference to it) it is the exit of the last task
inside the pid space ...

> And we had issues in OpenVZ, that very fast VPS stop/start can fail due 
> to not freed resources yet.

this is a design problem, if your design allows
to have _more_ than one pid space with the same
identifier/properties, but with only one active
and thus reachable space, it is no problem to 
create a new one right after the old one did send
the event (which doesn't mean that it was destroyed
just that the last process left the space)

> >>- Is a completely disjoin pid space acceptable to anyone?
> >yes, as long as the beforementioned access, management
> >and control mechanisms are in place ...
> then it is not disjoin? :)

well, really depends, disjoin is something which
refers to the existing interfaces, no? otherwise
disjoin spaces are not accepted by any party as
we all agreed that management and backdoors seem
essential ...

> >>- What should the parent of pid == 1 see?
> >doesn't really matter, but I see three options there:
> > 
> > - the parent space
> > - the child space
> > - both
> but should parent see pspace init? only one task from pspace?

as I'd like to have the option to get completely
rid of this parent, I do not really care what it
sees or not :)

> >>- Should we be able to monitor a pid space from the outside?
> >yes, definitely, but it could happen via some special
> >interfaces, i.e. no need to make it compatible
> disagree. why we need to introduce copy of existing syscalls? 
> do you want to fix all the existing apps? ps, top, kill etc.? 

well, they should be pid space aware anyway, so
they will need some change, and the older apps'll
only see what they saw before (and will not get
confused)

> How about third party apps?

I don't think we care about third party apps when
adding new kernel functionality, especially not
proprietary ones which cannot be modified easily

> >>- Should we be able to have processes enter a pid space?
> >definitely, without that, the entire VPS concept will
> >not work, folks use the 'admin' backdoors 90% of the
> >time ...
> agreed. Though I don't like a backdoor name :) 
> It is just a way to get access to VPS.

well, it is often a way to get access to the VPS
without the 'owner' of that VPS even knowing, so
IMHO it's a backdoor, access would be via sshd or
console :)

best,
Herbert

> Kirill
