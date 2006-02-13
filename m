Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWBMQk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWBMQk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWBMQk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:40:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:35245 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932148AbWBMQky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:40:54 -0500
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
	process id namespace
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
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
In-Reply-To: <m13biqxjj5.fsf@ebiederm.dsl.xmission.com>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	 <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	 <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	 <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	 <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
	 <m13biqxjj5.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 08:40:21 -0800
Message-Id: <1139848821.9209.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-11 at 03:43 -0700, Eric W. Biederman wrote:
> Kirill Korotaev <dev@sw.ru> writes:
> >> +static inline int pspace_task_visible(struct pspace *pspace, struct
> > task_struct *tsk)
> >> +{
> >> +	return (tsk->pspace == pspace) ||
> >> +		((tsk->pspace->child_reaper.pspace == pspace) &&
> >> +		 (tsk->pspace->child_reaper.task == tsk));
> > <<< the logic with child_reaper which can be somehow partly inside pspace... and
> > this check is not that abvious.
> 
> This is the check for what shows up in /proc.
> 
> Given that is how I have explicitly documented things to work, (the
> init process straddles the boundary) I fail to see how it is not obvious.  

I'd claim that the (tsk->pspace == pspace) test is pretty obvious.

However, the child_reaper one takes a little deduction.  Sometimes, I
think separating out even trivial functions into even trivialler :)
functions really does make sense for these.  They can be really
confusing.  BTW, I _still_ don't understand exactly what this is doing,
but I haven't had any coffee.

Is something like this more clear?

static inline int pspace_task_visible(struct pspace *pspace, struct
task_struct *tsk)
{
	if (tsk->pspace == pspace)
		return 1;

	/*
	 * Init tasks straggle namespaces.  They have the explicit
	 * pspace of their parent, but are visible from thier
	 * children.
	 */
	if (pspace_child_reaper_is_task(pspace, tsk)
		return 1;

	return 0;
}

int pspace_child_reaper_is_task(struct pspace *pspace,
				struct task_struct *tsk)
{
	if ((tsk->pspace->child_reaper.pspace == pspace) &&
	    (tsk->pspace->child_reaper.task == tsk))
		return 1;

	return 0;
}

-- Dave

