Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbTIJKFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbTIJKFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:05:23 -0400
Received: from mid-1.inet.it ([213.92.5.18]:20379 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S261512AbTIJKFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:05:11 -0400
Message-ID: <01f801c37783$9ead8960$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Arjan van de Ven" <arjanv@redhat.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <01c601c3777f$97c92680$5aaf7450@wssupremo> <20030910114414.B14352@devserv.devel.redhat.com>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 12:09:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For fun do the measurement on a pIV cpu. You'll be surprised.
> The microcode "mark dirty" (which is NOT a btsl, it gets done when you do
a write
> memory access to the page content) result will be in the 2000 to 4000
range I
> predict.

I'm not responsible for microarchitecture designer stupidity.
If a simple STORE assembler instruction will eat up 4000 clock cycles,
as you say here, well, I think all we Computer Scientists can go home and
give it up now.

> There are things like SMP synchronisation to do, but also
> if the cpu marks a page dirty in the page table, that means the page table
> changes which means the pagetable needs to be marked in the
> PMD. Which means the PMD changes, which means the PGD needs the PMD marked
> dirty. Etc Etc. It's microcode. It'll take several 1000 cycles.

Please, return to the fact.
Modifying the page contents is done by that part of benchmark application we
are not misuring.
That is, the code ***BEFORE*** the zc_send() (write() on pipe or whatever
you choose)
and ***AFTER*** a zc_receive() (or read() from pipe ot whatever else).
This is nice, thanks, but out of our interests.

We are only reading the relocation tables or inserting new entries in it.
Not modifying page contents.

> if you change a page table, you need to flush the TLB on all other cpus
> that have that same page table mapped, like a thread app running
> on all cpu's at once with the same pagetables.

Ok. Simply, this is not the case in my experiment.
This does not apply.
We have no threads. But only detached process address spaces.
Threads are a bit different from processes.

> why would you need a global lock for copying memory ?

System call sys_write() calls
locks_verify_area() which calls
locks_mandatory_area() which calls
lock_kernel()

oops...
global spin_lock locking...

SMP is crying...
But not so much, if the lock is not lasting much, is it right?

THIS IS NOT WHAT WE CALL A SHORT LOCK SECTION:

732 repeat:
733         /* Search the lock list for this inode for locks that conflict
with
734          * the proposed read/write.
735          */
736         for (fl = inode->i_flock; fl != NULL; fl = fl->fl_next) {
737                 if (!(fl->fl_flags & FL_POSIX))
738                         continue;
739                 if (fl->fl_start > new_fl->fl_end)
740                         break;
741                 if (posix_locks_conflict(new_fl, fl)) {
742                         error = -EAGAIN;
743                         if (filp && (filp->f_flags & O_NONBLOCK))
744                                 break;
745                         error = -EDEADLK;
746                         if (posix_locks_deadlock(new_fl, fl))
747                                 break;
748
749                         error = locks_block_on(fl, new_fl);
750                         if (error != 0)
751                                 break;
752
753                         /*
754                          * If we've been sleeping someone might have
755                          * changed the permissions behind our back.
756                          */
757                         if ((inode->i_mode & (S_ISGID | S_IXGRP)) !=
S_ISGID)
758                                 break;
759                         goto repeat;
760                 }
761         }

>From the source code of your Operating System.

