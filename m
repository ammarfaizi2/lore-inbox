Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279877AbRJ3GpE>; Tue, 30 Oct 2001 01:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279878AbRJ3Goz>; Tue, 30 Oct 2001 01:44:55 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:12299 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279877AbRJ3Goj>; Tue, 30 Oct 2001 01:44:39 -0500
Message-ID: <3BDE4B56.F90300C5@zip.com.au>
Date: Mon, 29 Oct 2001 22:40:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: i/o stalls on 2.4.14-pre3 with ext3
In-Reply-To: <Pine.LNX.4.21.0110292120340.16895-100000@admin> <3BDE161A.D8289730@zip.com.au> <9rl9ag$7su$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3BDE161A.D8289730@zip.com.au>,
> Andrew Morton  <akpm@zip.com.au> wrote:
> >
> >ext3's problem is that it is unable to react to VM pressure
> >for metadata (buffercache) pages.  Once upon a time it did
> >do this, but we backed it out because it involved mauling
> >core kernel code.  So at present we only react to VM pressure
> >for data pages.
> 
> Note that the new VM has some support in place for the low-level
> filesystem reacting to VM pressure. In particular, one thing the fs can
> do is to look at the PG_launder bit (for pages) and PG_launder bit (for
> buffers), to figure out if the IO is due to memory pressure.

We don't get that far, unfortunately.  ext3's problem is that the data
journalling (and its consequent ordering requirements) mean that a bare
try_to_free_buffers() will always fail, because we're holding elevated
refcounts against the buffers.  This is why we added an a_op here.  To
give the fs a chance to strip its stuff off the page before
try_to_free_buffers() has its try.

> There are two really silly request bugs in 2.4.14-pre3. I'd suggest
> trying pre5 which cleans up other things too, but even more notably
> should fix the request queue thinkos.
> 

Hum.   I did a quick test here.  cvs checkout of a kernel
tree with source and dest both on the same platter.  Using
ext2:

2.4.13: 	1:34
2.4.14-pre3:	1:28
2.4.14-pre5:	1:37

We need more silly bugs.

I'll poke at it a bit more.  One perennial problem which
we face is that there isn't, IMO, a good set of tests for tracking
changes in thoughput.  All the tools which are readily available
are good for stress testing and silly corner cases but they
don't seem to model real-world workloads well.

-
