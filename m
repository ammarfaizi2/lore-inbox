Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276505AbRJGSAL>; Sun, 7 Oct 2001 14:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276511AbRJGSAB>; Sun, 7 Oct 2001 14:00:01 -0400
Received: from [195.223.140.107] ([195.223.140.107]:57841 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S276505AbRJGR7r>;
	Sun, 7 Oct 2001 13:59:47 -0400
Date: Sun, 7 Oct 2001 19:59:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011007195928.D726@athlon.random>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com> <20011004175526.C18528@redhat.com> <9piokt$8v9$1@penguin.transmeta.com> <20011004164102.E1245@w-mikek2.des.beaverton.ibm.com> <20011005024526.E724@athlon.random> <20011004213507.B1032@w-mikek2.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011004213507.B1032@w-mikek2.sequent.com>; from kravetz@us.ibm.com on Thu, Oct 04, 2001 at 09:35:07PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 09:35:07PM -0700, Mike Kravetz wrote:
> [..] the pipe routines only call
> the non-synchronous form of wake_up. [..]

Ok I see, I overlooked that when we don't need to block we wakeup-async.

So first of all it would be interesting to change the token passed
thorugh the pipe so that it always fills in the PAGE_SIZE pipe buffer so
that the task goes to sleep before reading from the next pipe in the
ring.

And if we want to optimize the current benchmark (with the small token that
triggers the async-wakeup and it always goes to sleep in read() rather
than write()) we'd need to invalidate a basic point of the scheduler
that have nothing to do with IPI reschedule, the point to invalidate is
that if the current task (the one that is running wake_up()) has a small
avg_slice we'd better not reschedule the wakenup task on a new idle cpu
but we'd better wait the current task to go away instead. Unless I'm
missing something this should fix lmbench in its current implementation.

Andrea
