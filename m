Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030631AbWBQOyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030631AbWBQOyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbWBQOyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:54:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:1245 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030600AbWBQOyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:54:10 -0500
Date: Fri, 17 Feb 2006 08:53:50 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
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
Message-ID: <20060217145350.GA26437@sergelap.austin.ibm.com>
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216142928.GA22358@sergelap.austin.ibm.com> <43F5448A.6020501@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F5448A.6020501@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hubertus Franke (frankeh@watson.ibm.com):
> >>- Should a process have some sort of global (on the machine identifier)?
> 
> First establish whether that global ID has to be persistent ...
> I don't see why ! In which case the TASK_REF is the perfect global ID.

The task_refs were only intended to be used in the kernel, iiuc.

...

> >>- Should we be able to have processes enter a pid space?
> >
> >
> >IMO that is crucial.
> 
> Existing ones .. now that is potentially difficult to do. Particular
> if you want to enter a pidspace that has already been migrated.
> Because ones assigned pid might already been taken in the target pspace.

Well the answer changes depending on whether the question asks
about pid spaces, or full containers.  For full containers, you have
problems with unsharing various pieces of namespace.  But for the
pidspace, a simple function with clone() semantics makes perfect sense.
So your code does:

	child_pid = pidspace_clone(pspace_id);
	if (child_pid == 0) {
		/* we are inside pspace 'pspace_id' with a random
		   pid which is unique in that pspace */
	} else {
		/* the child_pid is known by some other pid in it's
		   own pspace, but in our pspace it's known and hashed
		   by 'child_pid'.  child_pid and that other pid are
		   likely different.
		 */
	 }

So long as we're just talking about the pidspaces, I don't see any
unexpected side effects here.

-serge
