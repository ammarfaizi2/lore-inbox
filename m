Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133053AbRDLEu0>; Thu, 12 Apr 2001 00:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133054AbRDLEuQ>; Thu, 12 Apr 2001 00:50:16 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:61166 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S133053AbRDLEuC>; Thu, 12 Apr 2001 00:50:02 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200104120448.f3C4mtlD016247@webber.adilger.int>
Subject: Re: Fwd: Re: memory usage - dentry_cacheg
In-Reply-To: <0104111336150G.25951@webman> "from Marcin Kowalski at Apr 11, 2001
 01:36:15 pm"
To: kowalski@datrix.co.za
Date: Wed, 11 Apr 2001 22:48:55 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Kowalski writes:
> if I do a can on /proc/slabinfo I get  on the machine with "MISSING" memory:
> ---- 
> slabinfo - version: 1.1 (SMP)
> --- cut out
> inode_cache       920558 930264    480 116267 116283    1 :  124   6
> --- cut out
> dentry_cache      557245 638430    128 21281 21281    1 :  252  126

I just discovered a similar problem when testing Daniel Philip's new ext2
directory indexing code with bonnie++.  I was running bonnie under single
user mode (basically nothing else running) to create 100k files with 1 data
block each (in a single directory).  This would create a directory about
8MB in size, 32MB of dirty inode tables, and about 400M of dirty buffers.
I have 128MB RAM, no swap for the testing.

In short order, my single user shell was OOM killed, and in another test
bonnie was OOM-killed (even though the process itself is only 8MB in size).
There were 80k entries each of icache and dcache (38MB and 10MB respectively)
and only dirty buffers otherwise.  Clearly we need some VM pressure on the
icache and dcache in this case.  Probably also need more agressive flushing
of dirty buffers before invoking OOM.

There were patches floating around on l-k which addressed these issues.
Seems it is time to try them out, which I hadn't before because I wasn't
having any problems myself until now.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
