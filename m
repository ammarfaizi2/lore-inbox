Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286944AbSAFCKh>; Sat, 5 Jan 2002 21:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSAFCK2>; Sat, 5 Jan 2002 21:10:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14484 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286938AbSAFCKU>;
	Sat, 5 Jan 2002 21:10:20 -0500
Date: Sun, 6 Jan 2002 05:07:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <E16N2oW-00021c-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201060501560.5193-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jan 2002, Alan Cox wrote:

> 64 queues costs a tiny amount more than 32 queues. If you can get it
> down to eight or nine queues with no actual cost (espcially for non
> realtime queues) then it represents a huge win since an 8bit ffz can
> be done by lookup table and that is fast on all processors

i'm afraid that while 32 might work, 8 will definitely not be enough. In
the interactivity-detection scheme i added it's important for interactive
tasks to have some room (in terms of priority levels) to go up without
hitting the levels of the true CPU abusers.

we can do 32-bit ffz by doing 4x 8-bit ffz's though:

	if (likely(byte[0]))
		return ffz8[byte[0]];
	else if (byte[1])
		return ffz8[byte[1]];
	else if (byte[2]
		return ffz8[byte[2]];
	else if (byte[3]
		return ffz8[byte[3]];
	else
		return -1;

and while this is still 4 branches, it's better than a loop of 32. But i
also think that George Anzinger's idea works well too to reduce the cost
of bitsearching. Or those platforms that decide to do so could search the
arrray directly as well - if it's 32 queues then it's a cache footprint of
4 cachelines, which can be searched directly without any problem.

	Ingo


