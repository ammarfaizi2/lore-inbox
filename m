Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWBTJZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWBTJZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWBTJZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:25:26 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:9127 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964805AbWBTJZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:25:26 -0500
Message-ID: <43F98B67.60800@sw.ru>
Date: Mon, 20 Feb 2006 12:27:03 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at> <20060216134447.GA12039@sergelap.austin.ibm.com>
In-Reply-To: <20060216134447.GA12039@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>I also don't understand why you are eager to introduce new sys calls 
>>>like pkill(path_to_process), but is trying to use waitpid() for pspace 
>>>die notifications? Maybe it is simply better to introduce container 
>>>specific syscalls which should be clean and tidy, instead of messing 
>>>things up with clone()/waitpid() and so on? The more simple code we 
>>>have, the better it is for all of us.
>>
>>now that you mention it, maybe we should have a few
>>rounds how those 'generic' container syscalls would 
>>look like?
> 
> 
> I still like the following:
> 
> clone(): extended with flags for asking a private copy of various
> 	namespaces.  For the CLONE_NEWPIDSPACE flag, the pid which
> 	is returned to the parent process is it's handle to the
> 	new pidspace.
- clone has limited number of flags.
- sooner or later you will need to add flags about what and how you want 
to close (e.g. pspace with weak or strong isolation and so on)

> sys_execpid(pid, argv, envp): exec a new syscall with the requested
> 	pid, if the pid is available.  Else either return an error,
> 	or pick a random pid.  Error makes sense to me, but that's
> 	probably debatable.
the problem is that in real life environments where executables can be 
substitutes this is kind of a security issue. Also I really hate the 
idea of using exec() for changing something.
In OpenVZ we successfully do context changes without exec()'s.

> sys_fork_slide(pid): fork and slide into the pidspace belong to pid.
> 	This way we can do things like
> 
> 	p = sys_fork_slide(2794);
> 	if (p == 0) {
> 		kill(2974);
> 	} else {
> 		waitpid(p, 0, 0);
> 	}
> Ok, this last one in particular needs to be improved, but these two
> syscalls and the clone flags together give us all we need.  Right?
Again, you concentrate on PIDspaces forgeting about all the other 
namespaces.

I would prefer:

- sys_ns_create()
creates namespace and makes a task to inherit this namespace. If 
_needed_, it _can_ fork inside.

- sys_ns_inherit()
change active namespace.

But how should we reference namespace? by globabl ID?

Kirill

