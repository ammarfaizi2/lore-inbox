Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbUKUBzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUKUBzX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 20:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUKUBzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 20:55:23 -0500
Received: from dp.samba.org ([66.70.73.150]:5553 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261726AbUKUByP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 20:54:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16799.62734.463565.38876@samba.org>
Date: Sun, 21 Nov 2004 12:53:18 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <419F6D1F.10001@namesys.com>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<419ECAB5.10203@namesys.com>
	<16798.59519.63931.494579@samba.org>
	<419F6D1F.10001@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

 > Actually, I would, because I have never read its code, and have been at 
 > a loss for years to understand its meaning as a result of that.

ok, first a bit of history.

In 1992 Ziff-Davis developed a benchmark called "NetBench" for
benchmarking file serving in PC client environments. NetBench was
freely downloadable, but without source code.

Over the years Netbench became the main benchmark used in the Windows
file serving world. In the Network Attached Storage market, good
NetBench numbers are absolutely essential, and companies tend to put a
lot of effort into building large "NetBench labs" for testing NetBench
performance. A couple of companies I have worked at have had people
working almost full time on running netbench results with various
configurations.

NetBench is quite different from Bonnie and other similar benchmarks,
as it is based on "replay of captured load". The load files for
NetBench come from common real-world scenarios where PC clients run
popular applications like MS Word, Excel, Corel Draw, MS Access,
Paradox, MS PowerPoint etc while storing their files on a remote PC
file server.

The usual output of Netbench is an Excel spreadsheet showing fairly
detailed performance numbers for different numbers of clients, plus
min, max and standard deviation numbers for the response time of each
type of operation.

NetBench came to prominance in the Linux world when Microsoft paid a
company called MindCraft to run some benchmarks comparing Windows file
server performance to Samba on Linux. It was initially difficult for
the Linux community to respond to this as we had no easy access to a
NetBench lab, and setting one up could easily be a million-dollar
effort.

To fix this, I wrote a suite of three benchmark tools, called
"nbench", "dbench" and "tbench". These tools were designed to provide
a fairly close emulation of NetBench, and to be extremely simple to
use (much simpler than NetBench). I also wanted them to be able to be
run on the typical hardware available to many home Linux
developers. They don't give output that is nearly as detailed as
NetBench, but when combined with common profiling tools this usually
isn't a problem.

The three tools are:

  - nbench. This completely emulates a NetBench run. The current
    versions produce almost identical sets of CIFS network packets to
    a run of NetBench on WinXP. You need to have a CIFS file server
    (like Samba) installed to run nbench.

  - dbench. This emulates just the file system calls that a Samba
    server would have to perform in order to complete a NetBench
    run. It doesn't need Samba installed.

  - tbench. This emulates just the TCP traffic that a Samba server
    would have to send/receive in order to complete a NetBench run. It
    doesn't need Samba installed.

Over the years I have improved these tools to give better and better
emulation of NetBench. Unfortunately this means that you can't
meaningfully compare results between versions.

All 3 tools use a load file to tell them what operations to
perform. This load file is written in terms of CIFS file sharing
operations, which are then interpreted by the benchmark tools into
either CIFS requests, filesystem requests or TCP traffic. 

There are a number of ways to generate these load files. You can write
one yourself (good for measuring just write speed for example), or you
can capture a load file from any CIFS network activity, either by
post-processing a tcpdump or by using a Samba. The load files I
provide come from capturing real NetBench runs.

Note that in all of the above I never claimed that these tools are
"good" benchmarks. I merely try to make them produce results that
closely predict the results of real NetBench runs. Whether NetBench is
actually a "good" benchmark is another topic entirely.

Finally, I should note that Spec is considering adding CIFS
benchmarking to their suite of benchmarks. Interestingly, they are
looking at using something based on my nbench tool, or something close
to it, so eventually nbench might become the more "official"
benchmark. That would certainly be an interesting turn of events :)

Cheers, Tridge
