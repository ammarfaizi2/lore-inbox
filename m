Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274744AbRI2QTH>; Sat, 29 Sep 2001 12:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276539AbRI2QS6>; Sat, 29 Sep 2001 12:18:58 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:61450 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S274744AbRI2QSt>;
	Sat, 29 Sep 2001 12:18:49 -0400
Date: Sat, 29 Sep 2001 18:19:13 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.10 VM, active cache pages, and OOM
Message-ID: <Pine.LNX.4.33.0109291645260.16885-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First I'd like to say that the 2.4.10 VM works great for my desktop and
home server, much better than previous versions.  I have not tried Alan's
kernels.

I do have one problem, though, and it is illustrated by the following very
simple program:

	#include <unistd.h>
	int main()
	{
		char buf[512];
		while (read(0, buf, sizeof(buf)) == sizeof(buf))
			;
		return 0;
	}

The program should be reading a block device, but a big file probably does
the trick as well.

	./a.out < /dev/hde1

When the program is running, all cached pages pop up in the active list,
and when the memory is full of active pages, the computer starts to page
out stuff, becomes VERY unresponsive, and after half a minute or so it
goes OOM and starts killing processes.  There are lots and lots of free
swap at this time.  I also get a bunch of 0-order allocation failures in
the log.

(I'd say that the OOM killer does seem to kill the most memory-hog-like
processes, but the problem is that it is not the processes that use up all
the memory, it is the active cache pages.)

If the buf size is changed to a multiple of the page size, such as 4096,
the cache pages are instead added to the inactive list, and the system is
very responsive, no paging occurs, and it does not go OOM.  In other
words, it works perfectly.

I assume that the difference between a buf size of 512 and 4096 is that
for the 512-byte case, each page is touched more than once, and that's why
the system think the pages are active.  This is a very wrong decision,
since I'm doing a sequential read.

Fixing that particular problem will get rid of my problem, but I'm
guessing that it would only hide another real problem, which is that
2.4.10 has a huge problem freeing pages from the list of active pages,
even if they are clean, and thus making a wrong decision on the
availibility of free(able) pages.

Am I right to assume that if I would make the program do random seeks, or
read each page twice, the pages would again be added to the active list,
even if I would read whole pages at a time?

I also wonder why the system get so unresponsive before it goes OOM.
Perhaps there is a kernel process running, scanning lists trying to free
memory, but not finding any, wasting all CPU cycles.

What do you think?

/Tobias

