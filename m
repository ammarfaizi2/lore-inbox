Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSL2Vri>; Sun, 29 Dec 2002 16:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSL2Vri>; Sun, 29 Dec 2002 16:47:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:8950 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261799AbSL2Vrc>;
	Sun, 29 Dec 2002 16:47:32 -0500
Message-ID: <3E0F6F64.DDE742A3@digeo.com>
Date: Sun, 29 Dec 2002 13:55:48 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more deprectation bits
References: <20021229215554.A11360@lst.de> <3E0F6B6B.2FCEC917@digeo.com> <20021229224713.A12011@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2002 21:55:48.0458 (UTC) FILETIME=[0BE0ACA0:01C2AF85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Sun, Dec 29, 2002 at 01:38:51PM -0800, Andrew Morton wrote:
> > Christoph Hellwig wrote:
> > >
> > > Rename the deprecated attribute to __deprecated to make it obvious
> > > this is something special and to avoid namespace clashes.
> > >
> > > Mark more functionality deprecated:
> > >
> > >  - sleep_on & friends
> >
> > Please do not make sleep_on() generate a warning.  Unless you intend
> > to do the same to lock_kernel().
> >
> > ext3 uses sleep_on().  It is perfectly safe.
> 
> Even if it's safe in that particular case, most code in the kernel runs
> without BKL.  This patch just makes the deprication of sleep_on
> explicit.

This would be more appropriate:


--- 25/kernel/sched.c~a	Sun Dec 29 13:53:24 2002
+++ 25-akpm/kernel/sched.c	Sun Dec 29 13:54:27 2002
@@ -1264,7 +1264,14 @@ long interruptible_sleep_on_timeout(wait
 
 void sleep_on(wait_queue_head_t *q)
 {
+	static int count;
+
 	SLEEP_ON_VAR
+
+	if (count < 10 && !kernel_locked()) {
+		count++;
+		WARN_ON(1);
+	}
 	
 	current->state = TASK_UNINTERRUPTIBLE;
 


> > Weaning ext3 off lock_kernel()
> > is a large, delicate and thus-far undesigned body of work.  I've been
> > working on other stuff and it is quite unlikely that ext3 locking will
> > be redesigned in the 2.5 timeframe.
> 
> Then ext3 has to live with using depricated interfaces during 2.6,
> what's the point?

We shouldn't generate tons of bogus warnings for something which
everyone knows about anyway.
