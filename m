Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267060AbRGIOZI>; Mon, 9 Jul 2001 10:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267037AbRGIOYr>; Mon, 9 Jul 2001 10:24:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:24080 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265003AbRGIOYk>; Mon, 9 Jul 2001 10:24:40 -0400
Date: Mon, 9 Jul 2001 16:24:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ville Nummela <ville.nummela@mail.necsom.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: tasklets in 2.4.6
Message-ID: <20010709162423.G1594@athlon.random>
In-Reply-To: <7an16iy2wa.fsf@necsom.com> <3B4563D5.89A1ACA3@mandrakesoft.com> <3B45760D.6F99149C@mandrakesoft.com> <7aelrqxycn.fsf@necsom.com> <7a8zhyxrel.fsf@necsom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a8zhyxrel.fsf@necsom.com>; from ville.nummela@mail.necsom.com on Mon, Jul 09, 2001 at 02:39:46PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 02:39:46PM +0300, Ville Nummela wrote:
> Ville Nummela <ville.nummela@mail.necsom.com> writes:
> 
> > Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> > > As I hacked around to fix this, I noticed Andrea's ksoftirq patch
> > > already fixed this.  So, I decided to look over his patch instead.
> > I tried that patch too, but with not so good results: The code LOOKS good to
> > mee too, but for some reason it still seems to stuck in looping the tasklet
> > code only. btw. I'm trying this on PPC, it might have something to do with
> > that.. :)
> 
> Stupid is stupid does.. I had used Adreas patch for a wrong kernel version,
> and therefore the patch hadn't quite succeeded. The right patch works well
> on the PPC too :-)

btw, I tell to you too, if you have an SMP you also need to fix this plain
scheduler cpu affinity bug or you can deadlock at boot when ksoftirqd
kicks in:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.7pre3aa1/00_cpus_allowed-1

attached here too:

--- 2.4.4pre3aa/kernel/sched.c.~1~	Sat Apr 14 15:49:11 2001
+++ 2.4.4pre3aa/kernel/sched.c	Sun Apr 15 18:31:14 2001
@@ -765,6 +765,8 @@
 	goto repeat_schedule;
 
 still_running:
+	if (!(prev->cpus_allowed & (1UL << this_cpu)))
+		goto still_running_back;
 	c = goodness(prev, this_cpu, prev->active_mm);
 	next = prev;
 	goto still_running_back;

Andrea
