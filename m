Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVAEFep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVAEFep (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 00:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbVAEFep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 00:34:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:36621 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262248AbVAEFem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 00:34:42 -0500
Date: Wed, 5 Jan 2005 06:28:41 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marek Habersack <grendel@caudium.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Message-ID: <20050105052841.GA24263@alpha.home.local>
References: <20050104195636.GA23034@beowulf.thanes.org> <20050104220313.GD7048@alpha.home.local> <20050104230733.GE5592@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104230733.GE5592@beowulf.thanes.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 05, 2005 at 12:07:33AM +0100, Marek Habersack wrote:
> Interestingly enough, the machine with the highest load average is the
> one generating 4Mbit/s and the one with 24Mbit/s has the smallest load
> average value.

This is common with multi-process servers like apache if the link is
saturated, because data takes more time to reach the client, so you have
a higher concurrency.

> The latter also suffers from the biggest loadavg increase. 
> All of the virtual machines have iptables accounting chains for each
> configured IP (there are between 62 IP numbers on one and 32 on the other).
> The virtual boxes have two 80GB SATA drives raided with softraid. The
> non-virtual box has a single IDE drive, no raid.

> (virtual #2, the 24Mbit/s one)
> # vmstat
> procs -----------memory---------- ---swap-- -----io---- --system------cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  5  3 172448  13084   1208 304048    4    4    90    50  109   117 19  8 73 0

I don't like something : with 73% idle, you have 5 processes in the rq. I think
this machine writes logs synchronously to disks, or stores SSL sessions on a
real disk and waits for writes. A tmpfs would be a great help.
You can try to trace the processes activity with :

# strace -Te write <process pid>
It will display the time elapsed in each write() syscall, you'll find the
fds in /proc/<pid>/fd. You may notice big times on logs or ssl sessions.

> (the non-virtual)
> # vmstat
> procs -----------memory---------- ---swap-- -----io---- --system------cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> 60  0  70300 115960      0 369244    0    0    79    32   90    45 73  7 21 0

Same note for this one, although it does more user space work (php? ssl?).
It's possible that some change in 2.4.28 touches the I/O subsystem and
increases your wait I/O time in this particular application.
(...) 
> One other interesting thing to note is that we have one
> other box with the similar configuration to the virtuals (also a virtual
> host) but it runs 2.4.28 with SMP+HT enabled - no load problems there at
> all.

So, to contradict myself, have you tried enabling HT on other boxes which
suffer from the load ?

> Let me know if you need more info,

You have send fairly enough info right now. Other than I/O work, I have no
idea. You may want to play with /proc/sys/vm/{bdflush,max-readahead} and
others to see if it changes things.

If your load is bursty, it might help to reduce the ratio of dirty blocks
before flushing (first field in bdflush), because although writes will
start more often, they will take fewer time.

I already have solved similar problems by disabling keep-alive to decrease
the number of processes.

Regards,
Willy

