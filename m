Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273484AbRIUMdT>; Fri, 21 Sep 2001 08:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273487AbRIUMdJ>; Fri, 21 Sep 2001 08:33:09 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:40971 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S273484AbRIUMcv>; Fri, 21 Sep 2001 08:32:51 -0400
From: Nikita Danilov <Nikita@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15275.13092.713804.491153@gargle.gargle.HOWL>
Date: Fri, 21 Sep 2001 16:31:32 +0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@zip.com.au (Andrew Morton), george@mvista.com (george anzinger),
        andrea@suse.de (Andrea Arcangeli), rml@tech9.net (Robert Love),
        Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?Q?N=FCtzel?=),
        mason@suse.com (Chris Mason), kuib-kl@ljbc.wa.edu.au (Beau Kuiper),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        reiserfs-list@namesys.com (ReiserFS List)
Subject: Re: [reiserfs-list] Re: [PATCH] Significant performace improvements on reiserfs systems
In-Reply-To: <E15kPGJ-0008EU-00@the-village.bc.nu>
In-Reply-To: <15275.2374.92496.536594@gargle.gargle.HOWL>
	<E15kPGJ-0008EU-00@the-village.bc.nu>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > > In Solaris, before spinning on a busy spin-lock, thread checks whether
 > > spin-lock holder runs on the same processor. If so, thread goes to sleep
 > > and holder wakes it up on spin-lock release. The same, I guess is going
 > 
 > 
 > > for interrupts that are served as separate threads. This way, one can
 > > re-schedule with spin-locks held.
 > 
 > This is one of the things interrupt handling by threads gives you, but the
 > performance cost is not nice. When you consider that ksoftirqd when it
 > kicks in (currently far too often) takes up to 10% off gigabit ethernet
 > performance, you can appreciate why we don't want to go that path.

I guess, reasoning behind Solaris design was that you have to disable
interrupts during critical sections more frequently than they would
actually block in them. So, you lose on interrupt thread creation and
when interrupts really block on a lock, but you gain because there is no
more need to disable interrupts when accessing data shared between
interrupt handler and the rest of the kernel. This can ultimately amount
to some net advantage especially when coupled with some sort of lazy
interrupt thread creation.

 > 
 > Our spinlock paths are supposed to be very small and predictable. Where 
 > there is sleeping involved we have semaphores.
 > 
 > As lockmeter shows we still have a few io_request_lock cases at least where
 > we lock for far too long

Reiserfs also likes to keep BKL while doing binary searches within nodes
of a tree.

 > 
 > Alan

Nikita.

 > -
 > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 > Please read the FAQ at  http://www.tux.org/lkml/
