Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291703AbSBHSNO>; Fri, 8 Feb 2002 13:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291701AbSBHSNF>; Fri, 8 Feb 2002 13:13:05 -0500
Received: from gw.sp.op.dlr.de ([129.247.188.16]:35476 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S291693AbSBHSMy>;
	Fri, 8 Feb 2002 13:12:54 -0500
Message-ID: <3C641511.9555ED47@dlr.de>
Date: Fri, 08 Feb 2002 19:12:33 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org, akpm@zip.com.au,
        mingo@elte.hu, haveblue@us.ibm.com
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <Pine.LNX.4.33.0202081027070.2672-100000@athlon.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Now, before we go further, can people explain _why_ we want this?
> 
> If something is getting a lot of short contention as a semaphore, maybe
> it's just broken locking. Let's not work around it with a new locking
> primitive just because we can.
> 
> What is the _existing_ problem this is trying to solve, and why?
> 
>                 Linus

There are currently several attempts discussed to push out the
BKL and replace it by a semaphore e.g. the next step Robert Love
planned for his ll_seek patch (replace the BKL by inode i_sem). 

The naive replacement BKL -> semaphore is surely bad.
Now on the other extreme you may always find a splitting of
the data you want to protected into short locked and long locked
sections like Christoph Hellwig suggested for i_sem:
> 
> No.  i_sem should be split into a spinlock for short-time accessed
> fields that get written to even if the file content is only read (i.e.
> atime) and a read-write semaphore.
> 
But this approach needs a lot a proper documentation and discipline.

So for most BKL removal work I suggested the combi-lock which scales
better than a semaphore but is more manageable than splitted locking. 

   Martin

P.S.: I posted the combi-lock as a practical RFC to bring the discussion
about lock scalability, latency and possible preemptiblity of the
linux kernel back to a concrete technical level (if you look at the 
"[2.4.17/18] VM and swap - it's really unusable" thread some weeks 
ago you can surely imagine why). And the simple reason is that for
my real time data acquisition systems I really would like to get rid
of my SunOS 5.8 and W2K machines. But the truth is that the standard
linux kernel is a real (worst case) latency hog even when compared with
these two bloated OS, at least for my applications. Only Andrew
Morton's (full)-ll patch boosts linux to comparable performance 
(less than 1-2 ms latency under heavy io-load). (I know that SunOS 5.8
and W2K also can have larger latencies under special circumstances,
but not for a simple streaming data acquisition with some online
visualization).
