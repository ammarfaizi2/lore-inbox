Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWBAEjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWBAEjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWBAEjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:39:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39571 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964912AbWBAEjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:39:41 -0500
Date: Tue, 31 Jan 2006 20:39:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
In-Reply-To: <m13bj34spw.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0601312027450.7301@g5.osdl.org>
References: <20060117143258.150807000@sergelap> <20060117143326.283450000@sergelap>
 <1137511972.3005.33.camel@laptopd505.fenrus.org> <20060117155600.GF20632@sergelap.austin.ibm.com>
 <1137513818.14135.23.camel@localhost.localdomain> <1137518714.5526.8.camel@localhost.localdomain>
 <20060118045518.GB7292@kroah.com> <1137601395.7850.9.camel@localhost.localdomain>
 <m1fyniomw2.fsf@ebiederm.dsl.xmission.com> <43D14578.6060801@watson.ibm.com>
 <Pine.LNX.4.64.0601311248180.7301@g5.osdl.org> <m13bj34spw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Jan 2006, Eric W. Biederman wrote:
> 
> Yes.  Although there are a few container lifetimes problems with that
> approach.  Do you want your container alive for a long time after every
> process using it has exited just because someone has squirrelled away their
> pid.  While container lifetime issues crop up elsewhere as well PIDs are
> by far the worst, because it is current safe to store a PID indefinitely 
> with nothing worse that PID wrap around.

Are people really expecting to have a huge turn-over on containers? It 
sounds like this shouldn't be a problem in any normal circumstance: 
especially if you don't even do the "big hash-table per container" 
approach, who really cares if a container lives on after the last process 
exited?

I'd have expected that the major user for this would end up being ISP's 
and the like, and I would not expect the virtual machines to be brought up 
all the time. 

If it's a problem, you can do the same thing that the "struct mm_struct" 
does: it has life-time issues because a mm_struct actually has to live for 
potentially a _long_ time (zombies) but at the same time we want to free 
the data structures allocated to the mm_struct as soon as possible, 
notably the VMA's and the page tables.

So a mm_struct uses a two-level counter, with the "real" users (who need 
the page tables etc) incrementing one ("mm_users"), and the "secondary" 
ones (who just need to have an mm_struct pinned, but are ok with an empty 
VM being attached) incrementing the other ("mm_count").

The same approach might be valid for "containers": you can destroy most of 
the associated container when the actual processes are gone, but keep just 
the empty container around until all secondary references are finally also 
gone.

It's pretty simple: the secondary reference starts at 1 - with the 
"primary" counter being the single ref to the secondary. Then freeing a 
primary does:

	if (atomic_dec_and_test(&container->primary_counter)) {
		.. free the core resources here ..

		/* then release the ref from the primary to secondary */
		secondary_free(container);
	}

(for "mm_struct", the primary is dropped "mmput()" and the secondary is 
dropped with "mmdrop()", which is absolutely horrid naming. Please name 
things better than I did ;)

			Linus
