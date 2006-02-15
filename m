Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWBOWU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWBOWU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWBOWU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:20:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39575 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751320AbWBOWU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:20:56 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Feb 2006 15:12:13 -0700
In-Reply-To: <20060215145942.GA9274@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Wed, 15 Feb 2006 08:59:42 -0600")
Message-ID: <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Hi,
>
> the lkml discussion on pid virtualization has been covering many of the
> issues both relating directly to pid virtualization, and relating to
> optimizations in the two specific implementations.
>
> However, if we're going to get anywhere, the first decision which we
> need to make is whether to go with a (container,pid), (pspace,pid) or
> equivalent pair like approach, or a virtualized pid approach.  Linus had
> previously said that he prefers the former.  Since there has been much
> discussion since then, I thought I'd try to recap the pros and cons of
> each approach, with the hope that the head Penguins will chime in one
> more time, after which we can hopefully focus our efforts.

Does anyone see problems with implementing this as series of namespaces?
If not we can move forward and start talking about pids, and the
other namespaces.

With respect to pids lets not get caught up in the implementation
details.  Let's first get clear on what the semantics should be.

- Should the first pid in a pid space have pid 1?

- Should pid == 1 ignore signals, it doesn't have a handler for?

- Should any children of pid 1 be allowed to live when pid == 1 is killed?

- Should a process have some sort of global (on the machine identifier)?

- Should the pids in a pid space be visible from the outside?

- Should the parent of pid 1 be able to wait for it for it's 
  children?

- Is a completely disjoin pid space acceptable to anyone?

- What should the parent of pid == 1 see?

- Should a process not in the default pid space be able to create 
  another pid space?

- Should we be able to monitor a pid space from the outside?

- Should we be able to have processes enter a pid space?

- Do we need to be able to be able to ptrace/kill individual processes
  in a pid space, from the outside, and why?

- After migration what identifiers should the tasks have?

If we can answer these kinds of questions we can likely focus in
on what the implementation should look like.  So far I have not
seen a question that could not be implemented with a (pspace, pid)/pid
or a vpid/pid implementation.

I think it is safe to say that from the inside things should look to
processes just as they do now.  Which answers a lot of those
questions.  But it still leaves a lot open.

Eric
