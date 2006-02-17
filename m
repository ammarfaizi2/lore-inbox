Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWBQNVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWBQNVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWBQNVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:21:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17582 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751009AbWBQNVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:21:12 -0500
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
References: <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>
	<20060216142928.GA22358@sergelap.austin.ibm.com>
	<m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
	<20060216175326.GA11974@sergelap.austin.ibm.com>
	<m1mzgrp3nl.fsf@ebiederm.dsl.xmission.com>
	<20060216184407.GC11974@sergelap.austin.ibm.com>
	<1140115979.21383.11.camel@localhost.localdomain>
	<m1bqx6p815.fsf@ebiederm.dsl.xmission.com>
	<20060217114441.GA17940@MAIL.13thfloor.at>
	<m1vevenptl.fsf@ebiederm.dsl.xmission.com>
	<20060217124411.GB17940@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 17 Feb 2006 06:15:20 -0700
In-Reply-To: <20060217124411.GB17940@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Fri, 17 Feb 2006 13:44:11 +0100")
Message-ID: <m1oe16nn2v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> that's something I'm not so worried about, but a statically
> compiled userspace process with 20K sounds unusual in the
> time of 2M *libcs :)

For unshared data, a stack  and page tables is should be achievable
even with glibc but I haven't sat down and done the math.  But
last I looked if you took out the debug symbols glibc was only 1M.

If glibc can't do it one of the lightweight embedded c libraries
certainly should be able to.

>> That is significant but we are still cheap enough that it
>> isn't necessarily a show stopper.
>> 
>> I think the cost was only one extra process, for the case where you
>> have fakeinit now it would be init, for other cases it would be a
>> daemon that gets setup when you initialize the vserver.
>
> well, depends, currently we do not need a parent to handle
> the guest, so there is _no_ waiting process in the light-
> weight case either, which makes that two processes for each
> guest, no?

As I put it together you don't need a parent.  The parent can wait for it
or exit the child doesn't care.  Usual unix semantics here :)

If you are using a pipe to communicate to the outside world that
has to be put someplace, but you can always create a fifo in
the filesystem.  You could have a single parent for all of
the lightweight guests.

Lots of choices on how to put the pieces together.

> anyway, I'm not strictly against having an init process
> inside a guest, as long as it is not an essential part
> of the overall design, because that would make it much
> harder to rip it out later :)

Except for being a child reaper no.  Having a process that
is the child reaper is interesting mainly because it allows
you to get an accurate struct rusage picture of all of the
children in pspace.

Eric

