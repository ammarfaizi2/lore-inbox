Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKDX6S>; Sat, 4 Nov 2000 18:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129036AbQKDX56>; Sat, 4 Nov 2000 18:57:58 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:47613 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129030AbQKDX56>; Sat, 4 Nov 2000 18:57:58 -0500
Message-ID: <3A04A285.3CA6FD37@uow.edu.au>
Date: Sun, 05 Nov 2000 10:57:57 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Multithreaded locks.c
In-Reply-To: <3A042031.A170B555@uow.edu.au> from "Andrew Morton" at Nov 05, 2000 01:41:53 AM <E13s7vQ-0004hr-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > have got it right.  Does anyone know what this part of the
> > flock(2) manpage means?
> >
> >        A  single file may not simultaneously have both shared and
> >        exclusive locks.
> 
> AFAIK its saying LOCK_EX is exclusive and blocks shared locks and vice
> versa.  Its a standard reader-writer lock setup. LOCK_EX is writer, LOCK_SH
> is reader.

Thanks, Alan.  You're right, and this is indeed how the current
implementation behaves.  The DG/UX manpage makes a bit more sense
here.

One interesting factoid: if a process currently has an exclusive
lock, and it changes that to an exclusive lock (ie: no change),
this has the effect of dropping the lock and reclaiming it.

The DG/UX dg_flock() departs from BSD in that "Upgrading a lock 
will be an atomic operation.  That is, a lock is not released
to upgrade that lock".  Linux doesn't do that - the lock is
effectively dropped and reclaimed when we go from LOCK_SH to LOCK_EX.

Even the DG/UX manpage doesn't say what happens when you sidegrade
the lock.  LOCK_EX->LOCK_EX :)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
