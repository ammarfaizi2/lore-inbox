Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbTISTZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTISTZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:25:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55430
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261712AbTISTZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:25:52 -0400
Date: Fri, 19 Sep 2003 21:25:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roland Bless <bless@tm.uka.de>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org, walter@tm.uka.de,
       winter@tm.uka.de, doll@tm.uka.de
Subject: Re: Fix for wrong OOM killer trigger?
Message-ID: <20030919192544.GC1312@velociraptor.random>
References: <20030919191613.36750de3.bless@tm.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919191613.36750de3.bless@tm.uka.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roland,

On Fri, Sep 19, 2003 at 07:16:13PM +0200, Roland Bless wrote:
> Hi Miquel,
> 
> I read your e-mail http://www.cs.helsinki.fi/linux/linux-kernel/2003-27/1274.html
> in the archive, but was not able to find a solution.
> We have a similar problem:
> HW: 4x 2,4GHz Xeon, 4GB Ram, 3ware 7000-series ATA-RAID
> SW: Kernel 2.4.22 (also seen on 2.4.21, 2.4.22-ac3), lvm, software raid,
> reiserfs, SuSE 8.1. Swap turned off (see later).
> 
> **Symptom: programs that heavily search the whole filesystem
> (e.g., rsync, ssync, TSM backup client dsmc) cause to trigger the 
> OOM killer procedure (not very funny if NIS or NFS gets killed).
> 
> Sep 17 21:49:07 fs1 kernel: Out of Memory: Killed process 1384 (lmgrd).
> Sep 17 21:49:12 fs1 kernel: Out of Memory: Killed process 1617 (exim).
> Sep 17 21:49:18 fs1 kernel: Out of Memory: Killed process 1402 (ntpd).
> Sep 17 21:49:23 fs1 kernel: Out of Memory: Killed process 1278 (portmap).
> Sep 17 21:49:29 fs1 kernel: Out of Memory: Killed process 2715 (dsmc).
> Sep 17 21:49:29 fs1 kernel: Out of Memory: Killed process 2716 (dsmc).
> Sep 17 21:49:29 fs1 kernel: Out of Memory: Killed process 2717 (dsmc).
> Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1600 (nscd).
> Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1601 (nscd).
> Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1602 (nscd).
> Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1603 (nscd).
> Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1604 (nscd).
> Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1605 (nscd).
> Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1606 (nscd).
> Sep 17 21:49:40 fs1 kernel: Out of Memory: Killed process 1602 (nscd).
> Sep 17 21:49:46 fs1 kernel: Out of Memory: Killed process 1421 (ypbind).
> Sep 17 21:49:46 fs1 kernel: Out of Memory: Killed process 1422 (ypbind).
> Sep 17 21:49:46 fs1 kernel: Out of Memory: Killed process 1423 (ypbind).
> Sep 17 21:49:46 fs1 kernel: Out of Memory: Killed process 1424 (ypbind).
> Sep 17 21:49:51 fs1 kernel: Out of Memory: Killed process 1584 (atd).
> Sep 17 21:49:57 fs1 kernel: Out of Memory: Killed process 1329 (ypserv).
> 
> The OOM kill occured also when the cache memory didn't exhausted the
> available memory (total mem usage was around 1.8GB).
> echo 2>/proc/sys/vm/overcommit_memory did not solve the problem either.
> In my understanding it has to do something with the fs cache/vm. We have some
> files that are larger than 2GB, but usually the killing process starts at 
> different points in time.
> 
> However, I also saw that kswapd used a lot CPU though swap was not active.
> With swap space activated, the load on the cpu increases dramatically
> so that the system becomes unusable, too. This is our file server and
> I'm currently not able to make a backup to other systems. That's really
> frustrating.
> 
> Anyone any ideas? Please Cc: to me in your replies since I'm not on the lkml.

can you try with 2.4.22aa1? the oom killer there will only work on tasks
that are allocating memory, not on idle daemons, so the probability of
killing rsync first should be higher. stock SuSE 8.1 kernel should do
the same too.

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
