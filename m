Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWBMRCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWBMRCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWBMRCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:02:18 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:42906 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932147AbWBMRCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:02:17 -0500
Date: Mon, 13 Feb 2006 11:02:07 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
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
Message-ID: <20060213170207.GB24200@sergelap.austin.ibm.com>
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com> <m1vevsmgvz.fsf@ebiederm.dsl.xmission.com> <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F04FD6.5090603@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill Korotaev (dev@sw.ru):
> >>1.
> >>flags are neither atomic nor protected with any lock.
> >
> >
> >flags are atomic as they are a machine word.  So they do not
> >require a read/modify write so they will either be written
> >or not written.  Plus this allows write-sharing of the appropriate
> >cache line which is very polite (assuming the line is not shared with
> >something else)
> Eric I'm familiar with SMP, thanks :)
> Why do you write all this if you agreed below that have problems with it?
> 
> >>2. due to 1) you code is buggy. in this respect do_exit() is not 
> >>serialized with
> >>copy_process().
> >Yes. I may need a memory barrier in there.  I need to think
> >about that a little more.
> memory barrier doesn't help. you really need to think about.
> 
> >>3. due to the same 1) reason
> >>> +		kill_pspace_info(SIGKILL, (void *)1, tsk->pspace);
> >>can miss a task being forked. Bang!!!
> >
> >Well the only bad thing that can happen is that I get a process that
> >can run and observe pid == 1 has exited.  So Bang!! is not too
> >painful.
> And what about references to pspace->child_reaper which was freed already?

This seems a very valid point.  And even if you implement code to detect
when a process exits whether it is a child_reaper for some pspace, you
can't just make pspace->child_reaper = pspace->child_reaper->child_reaper,
as the wid may not be valid in the grandparent's namespace, right?

-serge
