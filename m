Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264105AbUKZU6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbUKZU6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264125AbUKZU5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:57:48 -0500
Received: from pop.gmx.de ([213.165.64.20]:22700 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264105AbUKZU5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:57:00 -0500
Date: Thu, 25 Nov 2004 17:30:14 +0100 (MET)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Rik van Riel <riel@redhat.com>
Cc: hugh@veritas.com, chrisw@osdl.org, manfred@colorfullife.com,
       torvalds@osdl.org, akpm@osdl.org, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.61.0411250941230.10497@chimarrao.boston.redhat.com>
Subject: Re: Further shmctl() SHM_LOCK strangeness
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <15277.1101400214@www65.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

> On Thu, 25 Nov 2004, Michael Kerrisk wrote:
> 
> > I don't think this is sufficient -- there must
> > be protection against arbitrary SHM_LOCKs.
> 
> Why?   We already have ulimits do that...

My gut feeling is that processes should not be able to 
arbitrarily lock shared memory segments created by other 
users in memory.  I mean: why should I be able to 
someone else's segment into shared memory when I 
can't even access the contents of that shared memory.
(Such semantics are simply inconsistent with the 
System V IPC model.)

Also (more below), I don't see any other sensible 
semantics for these operations, other than the ones 
I've proposed.

> > How about the following:
> >
> > For *both* SHM_LOCK and SHM_UNLOCK, the process should either
> > be the owner or the creator of the object or have the
> > CAP_IPC_LOCK capability.
> 
> It makes a lot of sense, but I don't know whether or not
> it'd break any applications...

There is no reason why it should.  In 2.6.8, the only 
processes that could lock shared memory segments were those
with CAP_IPC_LOCK.  Unprivileged processes did not get a 
look in.

2.6.9 changed things, but it is very unlikely that
any applications depend on this (yet).  Most userland
developers are probably not even aware of the changed 
semantics in 2.6.9.  The time to repair these 
semantics is *now*, before someone does depend 
on them.  (In any case changes are required, since 
at a minimum, SHM_UNLOCK must be repaired.)

You earlier suggested the idea that SHM_UNLOCK 
might check to see if the process's user ID matched 
that of the process that did the SHM_LOCK.  This 
doesn't work.  Suppose someone else locks *my* segment
(even though they don't have permission to access its 
contents or perform other "ctl" operations on it like 
IPC_RMID).  Under your idea, I would not be able to
do a SHM_UNLOCK to remove that lock.

Cheers,

Michael

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
