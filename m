Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWBPTjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWBPTjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWBPTjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:39:00 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3202 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964882AbWBPTi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:38:59 -0500
Subject: Re: (pspace,pid) vs true pid virtualization
From: Dave Hansen <haveblue@us.ibm.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
In-Reply-To: <20060216191245.GA28223@MAIL.13thfloor.at>
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
	 <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	 <20060216143030.GA27585@MAIL.13thfloor.at>
	 <1140111692.21383.2.camel@localhost.localdomain>
	 <20060216191245.GA28223@MAIL.13thfloor.at>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 11:38:13 -0800
Message-Id: <1140118693.21383.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 20:12 +0100, Herbert Poetzl wrote:
> On Thu, Feb 16, 2006 at 09:41:32AM -0800, Dave Hansen wrote:
> > Giving admin processes the ability to enter pid spaces seems like it
> > solves an entire class of problems, right?. 
> 
> really depends on the situation and the setup.
> let me give a few examples here (I'll assume
> fully blown guests not just pid spaces here)
> 
>  - guest is running some kind of resource hog, 
>    which already reached the given guest limits
> 
>    any attempt to enter the guest will fail
>    because the limits do not permit that
> 
>  - the guest has been suspended (unscheduled)
>    because of some fork bomb running inside
>    and you want to kill off only the bomb
> 
>    entering the guest would immediately stop
>    your process, so no way to send signals
> 
>  - there is a pid killer running inside the
>    guest, which kills every newly created
>    process as soon as it is discovered
> 
>    entering the guest would kill your shell

Brainstorming ... what do you think about having a special init process
inside the child to act as a proxy of sorts?  It is controlled by the
parent vserver/container, and would not be subject to resource limits.
It would not necessarily need to fork in order to kill other processes
inside the vserver (not subject to resource limits).  It could also
continue when the rest of the guest was suspended.

A pid killer would be ineffective against such a process because you
can't kill init.  

> > Could you explain a bit what kinds of security issues it introduces?
> 
> well, it introduces a bunch of issues, not all
> directly security related, here some of them:
> (I keep them general because most of them can
> be worked around by additional checks and flags)
> 
>  - ptrace from inside the context could hijack
>    your 'admin' task and use it for all kind
>    of evil stuff

You can't ptrace init, right?

> In general, I prefer to think of this as working 
> with nuclear material via an actuator from behind 
> a 4" lead wall -- you just do not want to go in 
> to fix things :)

Where does that lead you?  Having a single global pid space which the
admin can see?  Or, does a special set of system calls do it well
enough?

-- Dave

