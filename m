Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264104AbUKZU5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264104AbUKZU5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264090AbUKZU4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:56:10 -0500
Received: from imap.gmx.net ([213.165.64.20]:29612 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264107AbUKZUwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:52:04 -0500
Date: Thu, 25 Nov 2004 13:45:24 +0100 (MET)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Rik van Riel <riel@redhat.com>
Cc: hugh@veritas.com, chrisw@osdl.org, manfred@colorfullife.com,
       torvalds@osdl.org, akpm@osdl.org, michael.kerrisk@gmx.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.61.0411250639530.10497@chimarrao.boston.redhat.com>
Subject: Re: Further shmctl() SHM_LOCK strangeness
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <13535.1101386724@www65.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

> On Thu, 25 Nov 2004, Michael Kerrisk wrote:
> 
> > As noted by Hugh, the problem also applies for
> > SHM_UNLOCK: anyone can unlock any System V shared
> > memory segment.  If our reason for locking memory
> > was security (no swapping), then this does allow
> > for exploits.
> 
> Good point.  I guess that for SHM_UNLOCK operations
> we need to check for either:
> 
> 1) current->user is the same user who SHM_LOCKed the
>     segment in question

I don't think this is sufficient -- there must
be protection against arbitrary SHM_LOCKs.

> or
> 
> 2) the process has the correct capabilities set

How about the following:

For *both* SHM_LOCK and SHM_UNLOCK, the process should either 
be the owner or the creator of the object or have the 
CAP_IPC_LOCK capability.

Note the following:

1. SHM_LOCK should be covered so that a process with a high
   RLIMIT_MEMLOCK is allowed to lock arbitrary segments 
   that it  doesn't own.

2. A framework like the above is consistent with the 
   semantics of the existing shmctl() IPC_SET and IPC_RMID
   operations (see the shmctl(2) man page).

Cheers,

Michael

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
