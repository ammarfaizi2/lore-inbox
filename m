Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRIRHdw>; Tue, 18 Sep 2001 03:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273880AbRIRHdm>; Tue, 18 Sep 2001 03:33:42 -0400
Received: from colorfullife.com ([216.156.138.34]:33799 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273879AbRIRHdV>;
	Tue, 18 Sep 2001 03:33:21 -0400
Message-ID: <000901c14014$494f9380$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrea Arcangeli" <andrea@suse.de>,
        "Linus Torvalds" <torvalds@transmeta.com>
Cc: <dhowells@redhat.com>, <Ulrich.Weigand@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <001701c13fc2$cda19a90$010411ac@local> <200109172339.f8HNd5W13244@penguin.transmeta.com> <20010918020139.B698@athlon.random>
Subject: Re: Deadlock on the mm->mmap_sem
Date: Tue, 18 Sep 2001 09:31:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrea Arcangeli" <andrea@suse.de>
> > The mmap semaphore is a read-write semaphore, and it _is_
permissible to
> > call "copy_to_user()" and friends while holding the read lock.
> >
> > The bug appears to be in the implementation of the write semaphore -
> > down_write() doesn't undestand that blocked writes must not block
new
> > readers, exactly because of this situation.
>
> Exactly, same reason for which we need the same property from the rw
> spinlocks (to be allowed to read_lock without clearing irqs). Thanks
so
> much for reminding me about this! Unfortunately my rwsemaphores are
> blocking readers at the first down_write (for the better fairness
> property issuse, but I obviously forgotten that doing so I would
> introduce such a deadlock).

i386 has a fair rwsemaphore, too - probably other archs must be modified
as well.

> The fix is a few liner for my
> implementation, here it is:
>

Obivously your patch fixes the race, but we could starve down_write() if
there are many page faults.
Which multithreaded apps rely on mmap for file io? innd, perhaps samba
if mmap is enabled (I'm not sure what's the default and if samba is
multithreaded).

If you compile a kernel for 80386, then i386 uses the generic
semaphores.
Could someone with innd compile his kernel for i386, apply Andrea's
patch and check that the performance doesn't break down?

IMHO modifying proc_pid_read_maps() is far simpler - I'm not aware of
another recursive mmap_sem user.
--
    Manfred


