Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbQJ3HaN>; Mon, 30 Oct 2000 02:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129151AbQJ3HaE>; Mon, 30 Oct 2000 02:30:04 -0500
Received: from chiara.elte.hu ([157.181.150.200]:37894 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129114AbQJ3H3t>;
	Mon, 30 Oct 2000 02:29:49 -0500
Date: Mon, 30 Oct 2000 09:39:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030002019.B19136@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010300934200.872-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> Is there an option to map Linux into a flat address space [...]

nope, Linux is fundamentally multitasked.

what you can do to hack around this is to not switch to the idle thread
after having done work in nfsd. Some simple & stupid thing in schedule:

	if (next == idle_task) {
		while (nr_running)
			barrier();
		goto repeat_schedule;
	}

(provided you are testing this on a UP system.) This way we do not destroy
the TLB cache when we wait a few microseconds for the next network
interrupt.

we do this in 2.4 already - ie. nfsd doesnt have to mark itself lazy-MM,
the idle thread will automatically 'inherit' the MM of nfsd, and is going
to switch CR3 only if the next process is not nfsd. So you can get an
apples to apples comparison by using 2.4.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
