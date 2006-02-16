Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbWBPSpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbWBPSpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 13:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbWBPSpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 13:45:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:30153 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030406AbWBPSpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 13:45:06 -0500
Date: Thu, 16 Feb 2006 12:44:07 -0600
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
Message-ID: <20060216184407.GC11974@sergelap.austin.ibm.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com> <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com> <20060216175326.GA11974@sergelap.austin.ibm.com> <m1mzgrp3nl.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mzgrp3nl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> >> What happens when you migrate pspace 3 into a different pspace
> >> on a different machine?
> >
> > Nothing special.  "Migrate" was just a checkpoint (from pspace 1)
> > and a resume (from pspace N on some machine).  So now pspace N on
> > the new machine has created a new pspace - which happens to be
> > immediately populated with the contents of the old pspace 3 - and
> > see the pid of the init process of this new pspace.
> >
> >> Is there a sane implementation for this?
> >
> > IMO, definately yes.
> >
> > But I haven't tried it, so my opinion is just that.
> 
> If you are just talking the pid of the init process the problem seems
> tractable.
> 
> Where I see real problems with migration is and nested pid spaces
> is when you expose all of your pids to your parent, and perhaps
> there was some miscommunication on this point.
> 
> To try and give an example.
> 
> pspace 1        pspace 2      pspace 3      pspace 4
>      pid 234 ->      pid 1    
>      pid 235 ->      pid 2 ->      pid 1
>      pid 236 ->      pid 3 ->      pid 2 ->      pid 1
> 
> Hopefully this clearly shows what I was trying to avoid, by
> only allow pid 1 of any pspace to be visible in the parent.

Yes, I saw it more like:

> pspace 1        pspace 2      pspace 3      pspace 4
>      pid 234 ->      pid 1    
>                      pid 2 ->      pid 1
>                                    pid 2 ->      pid 1
>                      pid 3

Now Dave and I were just talking about actually using the
init process in a pspace to do administration from outside.
For instance, the userspace code, in /sbin/pspaceinit, which
runs as (pspace 2, pid 1), could open a pipe with it's parent
(pspace1, pid 234).  pid 234 can then ask the init process to
do things like list processes, kill a process, and maybe even
recursively talk to the init process in pspace 3.

-serge
