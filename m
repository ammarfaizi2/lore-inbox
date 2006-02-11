Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWBKJ2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWBKJ2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWBKJ2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:28:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18627 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750824AbWBKJ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:28:38 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
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
Subject: Re: [RFC][PATCH 01/20] pid: Intoduce the concept of a wid (wait id)
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <43ECE0AB.1010608@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 11 Feb 2006 02:25:03 -0700
In-Reply-To: <43ECE0AB.1010608@sw.ru> (Kirill Korotaev's message of "Fri, 10
 Feb 2006 21:51:23 +0300")
Message-ID: <m1lkwixn68.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Eric,
>
> 1. I would rename wid to wpid :)
:)

> 2. Maybe I'm missing something in the discussions, but why is it required? if
> you provide fully isolated pid spaces, why do you care for wid?
> And how ptrace can work at all if cldstop reports some pid, but child is not
> accessiable via ptrace()? and if it doesn't work, what are your changes for?

A good question.

My pid spaces while isolated from each other are connected together in
something that resembles the mount relationship when mounting a filesystem.

The init process of a child pspace is visible in the parent pspace,
by it's wid.  So you should be able to ptrace pid == 1.  The other
children remain inaccessible directly.

The idea was to do my very best to preserve the unix process tree when
constructing a separate pid space.

I have to admit I have not yet tested the ptrace corner case, or
digested all of it's ramifications.  Unless I have messed up somewhere
it should just work.

This visibility of the child tree by a single pid inside the parent
tree is why I think my approach doesn't suffer from most of the
problems a completely isolated pid space has.

In fact I would even be willing to look at it as a global but
hierarchical pid space if that proved an interesting case.
So you could have something like pkill(int sig, int which, char *pid_path).
Where pid_path is something like "1537/3/58", and which specified
what kind of pid you are talking about (thread, pid, process group...)

>From a security stand point I want the option of a fully isolated
group of processes, so there is a possibility of keeping secrets from
the system administrator, but there is no reason that needs to be tied
to a pid space.

Eric
