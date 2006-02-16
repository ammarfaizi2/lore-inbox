Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbWBPNpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWBPNpL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 08:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWBPNpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 08:45:11 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:29063 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161118AbWBPNpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 08:45:08 -0500
Date: Thu, 16 Feb 2006 07:44:47 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       "Serge E. Hallyn" <serue@us.ibm.com>,
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
Message-ID: <20060216134447.GA12039@sergelap.austin.ibm.com>
References: <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215133131.GD28677@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Herbert Poetzl (herbert@13thfloor.at):
> > I also don't understand why you are eager to introduce new sys calls 
> > like pkill(path_to_process), but is trying to use waitpid() for pspace 
> > die notifications? Maybe it is simply better to introduce container 
> > specific syscalls which should be clean and tidy, instead of messing 
> > things up with clone()/waitpid() and so on? The more simple code we 
> > have, the better it is for all of us.
> 
> now that you mention it, maybe we should have a few
> rounds how those 'generic' container syscalls would 
> look like?

I still like the following:

clone(): extended with flags for asking a private copy of various
	namespaces.  For the CLONE_NEWPIDSPACE flag, the pid which
	is returned to the parent process is it's handle to the
	new pidspace.

sys_execpid(pid, argv, envp): exec a new syscall with the requested
	pid, if the pid is available.  Else either return an error,
	or pick a random pid.  Error makes sense to me, but that's
	probably debatable.

sys_fork_slide(pid): fork and slide into the pidspace belong to pid.
	This way we can do things like

	p = sys_fork_slide(2794);
	if (p == 0) {
		kill(2974);
	} else {
		waitpid(p, 0, 0);
	}

Ok, this last one in particular needs to be improved, but these two
syscalls and the clone flags together give us all we need.  Right?

-serge
