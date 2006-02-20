Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWBTREv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWBTREv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161044AbWBTREv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:04:51 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:34020 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161042AbWBTREu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:04:50 -0500
Date: Mon, 20 Feb 2006 18:04:48 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process id namespace
Message-ID: <20060220170448.GG18841@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
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
References: <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at> <20060216134447.GA12039@sergelap.austin.ibm.com> <43F98B67.60800@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F98B67.60800@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 12:27:03PM +0300, Kirill Korotaev wrote:
>>>> I also don't understand why you are eager to introduce new sys
>>>> calls like pkill(path_to_process), but is trying to use waitpid()
>>>> for pspace die notifications? Maybe it is simply better to
>>>> introduce container specific syscalls which should be clean and
>>>> tidy, instead of messing things up with clone()/waitpid() and so
>>>> on? The more simple code we have, the better it is for all of us.

>>> now that you mention it, maybe we should have a few
>>> rounds how those 'generic' container syscalls would 
>>> look like?

>> I still like the following:
>> 
>> clone(): extended with flags for asking a private copy of various
>> 	namespaces.  For the CLONE_NEWPIDSPACE flag, the pid which
>> 	is returned to the parent process is it's handle to the
>> 	new pidspace.

> - clone has limited number of flags.
> - sooner or later you will need to add flags about what and how 
>   you want to close (e.g. pspace with weak or strong isolation 
>   and so on)

I still do not see a need to do that at clone() time
but I assume you have your reasons for postulating this ...

>> sys_execpid(pid, argv, envp): exec a new syscall with the requested
>> 	pid, if the pid is available.  Else either return an error,
>> 	or pick a random pid.  Error makes sense to me, but that's
>> 	probably debatable.
> the problem is that in real life environments where executables can be 
> substitutes this is kind of a security issue. Also I really hate the 
> idea of using exec() for changing something.

> In OpenVZ we successfully do context changes without exec()'s.

here I agree, changes between *spaces should be independant 
from exex(), but IMHO there is no need to reuse existing
interfaces for that, a syscall will do fine here ...

>> sys_fork_slide(pid): fork and slide into the pidspace belong to pid.
>> 	This way we can do things like
>> 
>> 	p = sys_fork_slide(2794);
>> 	if (p == 0) {
>> 		kill(2974);
>> 	} else {
>> 		waitpid(p, 0, 0);
>> 	}
>> Ok, this last one in particular needs to be improved, but these two
>> syscalls and the clone flags together give us all we need.  Right?
> Again, you concentrate on PIDspaces forgeting about all the other 
> namespaces.
> 
> I would prefer:
> 
> - sys_ns_create()
>   creates namespace and makes a task to inherit this namespace. 
>   If _needed_, it _can_ fork inside.

I don't see why not have both, the auto-created
*space on clone() and the ability to create empty
*spaces which can be populated and/or entered

> - sys_ns_inherit()
>   change active namespace.

hmm, sounds like a misnomer to me ...

> But how should we reference namespace? by globabl ID?

definitely by some system-unique identifier ...

best,
Herbert

> Kirill
