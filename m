Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264240AbTKKDup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbTKKDup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:50:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:51870 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264240AbTKKDuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:50:39 -0500
Date: Mon, 10 Nov 2003 19:54:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Venezia <pvenezia@jpj.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
Message-Id: <20031110195433.4331b75e.akpm@osdl.org>
In-Reply-To: <1068519213.22809.81.camel@soul.jpj.net>
References: <1068519213.22809.81.camel@soul.jpj.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Venezia <pvenezia@jpj.net> wrote:
>
> I've been running some benchmarks on 2.4 v 2.6 recently, and came across
> another oddity. 
> 
> Running smbtorture's NBENCH test against the 2.6 kernel shows a
> significant performance disparity vs Redhat 2.4.20 or 2.4.22. The target
> system is running RH AS 3.0, and is an IBM x335 dual P4 XEON with 1.5GB
> RAM, Broadcom gigabit NIC linked at 1000/full and an MPT RAID
> controller.
> 
> Running a 12-client NBENCH test against this server running 2.4.22
> consistently produces a result of ~33MB/s. Running 2.6.0-test9 through
> bk-11 however, produces a much lower result, usually ~14MB/s. The test
> will start at ~80MB/s, sustained for 10-15 seconds, then throughput
> drops precipitously, and the file transfers slow to a crawl. The target
> system shows that it's 100% I/O bound, but I can't seem to locate the
> constraint. iostat and sar don't show anything out of the ordinary, but
> top shows the CPUs at 99% iowait. Eventually, the bottleneck disappears,
> and the performance increases, but never substantially. 

It's not clear here what direction the data is being transferred in.  Is it
mostly client->server, or mostly server->client?

What filesystem is the server using?

> I can reproduce this at will on this system, and a dual Itanium2 system
> with Samba 2.2.8a and 3.0. Removing Samba from the equation, copying a
> 550MB file via NFS takes 240s under 2.6.0-test9-bk11 (~2.5MB/s average),
> exhibiting the same iowait problem, while under 2.4.22 the same transfer
> takes ~13s (~44MB/s average) without any iowait issues.

OK well that's a good step: break the problem down to the simplest possible
operation.

In which direction was the file transferred?  client to server or server to
client?  What kernel was running on each?


As next steps I'd suggest that you log into the server and do

	time (dd if=/dev/zero of=x bs=1M count=2048 ; sync)

and

	time (dd if=x of=/dev/null bs=1M count=2048 ; sync)

(this assumes that the machine has less that 2G of memory, to avoid caching
effects).

And then run the same two commands across NFS.

So break it down to the simplest possible step which exhibits the problem.

