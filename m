Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271708AbRIQU6y>; Mon, 17 Sep 2001 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272413AbRIQU6p>; Mon, 17 Sep 2001 16:58:45 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:65495 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S271708AbRIQU6b>; Mon, 17 Sep 2001 16:58:31 -0400
Importance: Normal
Subject: Deadlock on the mm->mmap_sem
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFAA4120C7.50E3F5A3-ONC1256ACA.0072466F@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Mon, 17 Sep 2001 22:57:42 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 17/09/2001 22:57:45
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we're experiencing deadlocks on the mm->mmap_sem which appear to be
caused by proc_pid_read_maps (on S/390, but I believe this is arch-
independent).

What happens is that proc_pid_read_maps grabs the mmap_sem as a reader,
and *while it holds the lock*, does a copy_to_user.  This can of course
page-fault, and the handler will also grab the mmap_sem (if it is the
same task).

Now, normally this just works because both are readers.  However, on SMP
it might just so happen that another thread sharing the mm wants to grab
the lock as a writer after proc_pid_read_maps grabbed it as reader, but
before the page fault handler grabs it.

In that situation, that second thread blocks (because there's already a
writer), and then the first thread blocks in the page fault handler
(because a writer is pending).  Instant deadlock ...

B.t.w. S/390 uses the generic spinlock based rwsem code, if this is of
relevance.

Any ideas how to fix this?  Should proc_pid_read_maps just drop the lock
before copy_to_user?


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

