Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTKYVEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 16:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTKYVEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 16:04:48 -0500
Received: from vaxjo.synopsys.com ([198.182.60.75]:22439 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S263241AbTKYVEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 16:04:42 -0500
Message-ID: <3FC3C3BC.CAEC23CA@synopsys.com>
Date: Tue, 25 Nov 2003 16:03:56 -0500
From: Chris Petersen <Chris.Petersen@synopsys.com>
Reply-To: Chris.Petersen@synopsys.com
Organization: Synopsys, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: PROBLEM:  Blk Dev Cache causing kswapd thrashing
Content-Type: multipart/mixed;
 boundary="------------48CC3EA5C75A4F05C064D1C3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------48CC3EA5C75A4F05C064D1C3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The block device cache is causing kswapd thrashing, usually bringing
the system to a halt.

This problem has been reproduced on kernels as recent as 2.4.21.

In our application we deal with large (multi-GB) files on multi-CPU
4GB platforms.  While handling these files, the block device cache
allocates all remaining available memory (3.5G) up to the 4G
physical limit.

Once the block device cache has pegged the physical memory limit,
it doesn't seem to manage it's allocation of that memory well enough
to prevent unnecessary page-swapping.  Ultimately, thrashing takes
over and the SYSTEM COMES TO A HALT.

After the application closes all files and exits, the cache maintains
its allocation of this memory until either: 1) the file is removed,
or 2) somebody requests more memory.  In the former case, used memory
(top, /proc/meminfo) drops instantly to the amount used by all
processes (sum of ps use).  In the latter, memory use remains pegged
and swapping typically remains a problem.  There doesn't appear to be
a timeout on the cache's allocation.

This problem is most noticable when the (cached) files causing the
problem are on a local disk.

Below is an example of a pseudo-idle system (only running 'du')
which is affected by the trashing problem.  Both CPUs are 99% system,
kswapd is 99.9%, load average exceeds 4 and growing, and virtually
all memory is consumed, although only 717,140K is reported to be
used by "all" processes (using a sum of 'ps -aux' memory use).

  5:31pm  up 53 days, 11:28, 19 users,  load average: 4.64, 3.14, 2.14
160 processes: 157 sleeping, 2 running, 0 zombie, 1 stopped
CPU0 states:  0.1% user, 99.0% system,  0.0% nice,  0.2% idle
CPU1 states:  0.1% user, 99.2% system,  0.0% nice,  0.0% idle
Mem:  3928460K av, 3828808K used,   99652K free,       0K shrd,   26148K buff
Swap: 4194224K av,  696384K used, 3497840K free                 2715008K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    5 root      17   0     0    0     0 RW   99.9  0.0 218:52 kswapd

I have seen situations where the load average exceeds 12.0 (!), and
others on a 4-CPU 64-bit 6GB machine (running 2.4.21[-4.EL]) where
all four CPUs are at 100% system, and page-swapping.

THIS PROBLEM IS READILY REPRODUCIBLE.

I have attached a tarball which includes the source to a file-seek
test program (fst); and a simple memory reclaimation program (reclaim).

fst can be used to generate large files (with seek behavior typical
of our application, as seeking seems to aggrevate the problem).  When
using fst (on a 4GB system), specify 'num_blks' to be 2,000,000 to
4,000,000, with mode = 1 (seek-updating enabled):

    fst 3000000 fst.out 1

This will create a file with 3,000,000 blocks of random size between
1-2048 bytes.  Midway through creating fst.out, the block device cache
should have allocated all of memory.  If thrashing doesn't immediately
occur you can run multiple fst's to aggravate the problem.

reclaim can be used to illustrate that, with fst still running (and
pegged), it is possible to manually reclaim/free the memory used by
the block device cache, thereby eliminating the issues with kswapd,
bdflush, kupdated, etc.  But given that fst's still running, memory
usage creeps back up, as expected.

This seems to be a fairly fundamental and substantial problem.  Over
time rogue memory use by the block device cache simply creeps up and
up toward the physical limit.  And it becomes a probem more readily.

Can anyone provide a means to mitigate or eliminate this problem?
We've toyed with altering parameters to bdflush and the like, with
no success.

Thanks for your help,
-chris

-----------------------------------------------------------------
Chris M. Petersen                                cmp@synopsys.com
Sr. R&D Engineer

Synopsys, Inc.                                    o: 919.425.7342
1101 Slater Road, Suite 300                       c: 919.349.6393
Durham, NC  27703                                 f: 919.425.7320
-----------------------------------------------------------------
--------------48CC3EA5C75A4F05C064D1C3
Content-Type: application/x-gzip;
 name="lk-bdcache-bug.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="lk-bdcache-bug.tar.gz"

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
--------------48CC3EA5C75A4F05C064D1C3--

