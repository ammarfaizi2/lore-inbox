Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278102AbRJWRXC>; Tue, 23 Oct 2001 13:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278112AbRJWRWx>; Tue, 23 Oct 2001 13:22:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25412 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278105AbRJWRWf>; Tue, 23 Oct 2001 13:22:35 -0400
Date: Tue, 23 Oct 2001 19:23:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Robert Macaulay <robert_macaulay@dell.com>
Subject: Re: x86 smp_call_function recent breakage
Message-ID: <20011023192307.Q26029@athlon.random>
In-Reply-To: <20011023182954.O26029@athlon.random> <E15w4kB-0006Vf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15w4kB-0006Vf-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Oct 23, 2001 at 05:49:35PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 05:49:35PM +0100, Alan Cox wrote:
> > This isn't the right fix:
> 
> The cache thing you may be right on. The core fix is not about caching
> its about fixing races on IPI replay. We have to handle an IPI reoccuring
> potentially with a small time delay due to a retransmit of a message
> lost by one party on the bus. Furthermore it seems other messages can
> pass the message that then gets retransmitted.
> 
> > Robert, this explains the missed IPI during drain_cpu_caches, it isn't
> > ram fault or IPI missed by the hardware, so I suggest to just backout
> > the second diff above and try again. Will be fixed also in next -aa of
> > course.
> 
> I'm not sure I follow why it explains a missed IPI. Please explain in
> more detail.

The bug is very simple and it have nothing to do with hardware details,
it is a plain software bug:

-	if (wait) {
-		mb();
-		atomic_inc(&call_data->finished);
-	}
+	if (wait)
+		set_bit(smp_processor_id(), &call_data->finished);

since 2.4.10pre12 (and in all previous -ac also) you still use the above
"call_data" for notifying "finished", but you also allowed "call_data"
to be changed under the IPI handler by another incoming IPI (the
scalability optimization), so the first IPI handler will notify the
completion of the second IPI (instead of the first one) generating the
"missed IPI" generating kernel instability (deadlock for Roboert in
drain_cpu_caches that waits all cpus to "finish").

So you wonder about reply IPI or whatever, and you add further hackery
plus you left the NR_CPUS array that now is useless since there's
nothing to scale and we hold the spinlock for the whole duration of the
IPI cycle, while the only fix in your ac5<->ac6 diff is that you now
spin_unlock after touching ->finished like the old code correctly did,
so you notify completion of the right IPI and not of the wrong one, so
it won't deadlock anymore.

I don't think it's necessary to read ->func and friends before checking
->started, also there's no need of testing ->started. we have the
guarantee that only 1 IPI cycle can run at once because of the spinlock
held for the whole duration of the IPI cycle, so if we are running in
smp_call_function_interrupt we know all ->func,->started == 0 fields are
just coherent and freely usable in memory, we only need to care to mb()
between reading them and increasing ->started like the old code
correctly did.  So I think the old code was just perfect.

Andrea
