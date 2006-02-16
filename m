Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWBPTMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWBPTMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWBPTMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:12:47 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:63894 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932319AbWBPTMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:12:46 -0500
Date: Thu, 16 Feb 2006 20:12:45 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dave Hansen <haveblue@us.ibm.com>
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
Subject: Re: (pspace,pid) vs true pid virtualization
Message-ID: <20060216191245.GA28223@MAIL.13thfloor.at>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216143030.GA27585@MAIL.13thfloor.at> <1140111692.21383.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140111692.21383.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 09:41:32AM -0800, Dave Hansen wrote:
> On Thu, 2006-02-16 at 15:30 +0100, Herbert Poetzl wrote:
> > > - Should a process have some sort of global (on the machine identifier)?
> > 
> > this is mandatory, as it is required to kill any process
> > from the host (admin) context, without entering the pid
> > space (which would lead to all kind of security issues) 
> 
> Giving admin processes the ability to enter pid spaces seems like it
> solves an entire class of problems, right?. 

really depends on the situation and the setup.
let me give a few examples here (I'll assume
fully blown guests not just pid spaces here)

 - guest is running some kind of resource hog, 
   which already reached the given guest limits

   any attempt to enter the guest will fail
   because the limits do not permit that

 - the guest has been suspended (unscheduled)
   because of some fork bomb running inside
   and you want to kill off only the bomb

   entering the guest would immediately stop
   your process, so no way to send signals

 - there is a pid killer running inside the
   guest, which kills every newly created
   process as soon as it is discovered

   entering the guest would kill your shell

> Could you explain a bit what kinds of security issues it introduces?

well, it introduces a bunch of issues, not all
directly security related, here some of them:
(I keep them general because most of them can
be worked around by additional checks and flags)

 - ptrace from inside the context could hijack
   your 'admin' task and use it for all kind
   of evil stuff

 - entering the guest *spaces might cause some
   issues with dynamic libraries

 - you process would show up in task lists and
   guest security tracers, which might give a
   false alarm when they get aware of your kill
   task

 - the entire guest accounting, regarding tasks
   would get messed up by the 'outside' process

In general, I prefer to think of this as working 
with nuclear material via an actuator from behind 
a 4" lead wall -- you just do not want to go in 
to fix things :)

best,
Herbert

> -- Dave
