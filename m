Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUHCFCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUHCFCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 01:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUHCFCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 01:02:32 -0400
Received: from adsl-68-95-0-242.dsl.rcsntx.swbell.net ([68.95.0.242]:26753
	"EHLO arion.soze.net") by vger.kernel.org with ESMTP
	id S265041AbUHCFC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 01:02:28 -0400
Date: Tue, 3 Aug 2004 05:02:23 +0000
From: Justin Guyett <justin-lkml@soze.net>
To: linux-kernel@vger.kernel.org
Cc: Hibbard Smith <Hibbard.Smith@nasdaq.com>
Subject: mainline i2o issues with adaptec raid (was: i2o and adaptec raid)
Message-ID: <20040803050223.GB2295@arion.soze.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Orig-In-Reply-To: <FFB5EEE014075A45A02FAE38D9F68141074649@mer-exch2.corp.nasdaq.com>
X-PGP-Fingerprint: 9AE2 9FC3 D98B 9AE2 EE83  15CC 9C7D 1925 4568 5243
X-Hashcash: 0:040803:linux-kernel@vger.kernel.org:6e1a71868f8ff19ecc819039
X-Hashcash: 0:040803:hibbard.smith@nasdaq.com:1321152731f0cbc0270c08f1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just started toying with an adaptec i2o card, an Adaptec 2110s, and
for random reads and writes bonnie++ shows that the i2o driver is
somewhat slower than the dpt_i2o driver.

Then there's instability with i2o.  The bonnie++ rewrite stage with 5G
files causes the process to hang with almost all physical memory
consumed.  When it doesn't hang, memory is not reclaimable after it
exits.

If i2o is compiled as a module and I can get the reaper to kill bonnie++
(SAK kills the shell but obviously not bonnie++), the memory leak
remains if I then unload i2o_block and i2o_core.

When the i2o_block is unloaded:
 Debug: sleeping in function called from invalid context at mm/slab.c:1989
(Aug 3 02:35:33 in min-log at the url below)

The memory and freeze issues are not module dependent, and it's not
eaten up in cache or buffers.  One example: 4036k cached, 140k buffers.

Swap is working fine.  Once when bonnie++ froze, I tried dd from
/dev/urandom to the same partition bonnie++ is testing, and swap starts
getting used.  With xfs.  Even with bonnie++ reaped, the memory seems
unreclaimable.

That's all with xfs, but the same thing happens with ext3
data=writeback; the difference is I can't seem to get the oom killer to
reap bonnie++ when it's writing to a file on an ext3 partition.

I didn't try SAK on bonnie++ under xfs.  I forgot.

general details: dual xeon w/HT, 1G (4G Highmem setting), adaptec 2110s.
(but without 4k stacks, the villain of the week).  Hung processes are in
state D.  There's no swapping, but swap is available.  For the ext3
hang, swap usage is at 44k and memory isn't even entirely used, only
927M of it.

http://skoda.sockpuppet.org/~tyme/i2o/

"min-cpu"	cpuinfo
"min-mod-(log|config)" are with i2o as a module, under xfs; this one
  contains the Debug: statement above, triggered by rmmod i2o_block
"min-ci-(log|config)" are with i2o compiled in, under xfs
"min-ext3-(log|ps)" is with i2o compiled in, under ext3 (same .config).

typical memory usage at time of freeze is 900-1020MiB (out of 1G)

In the ext3 log, there are two process dumps.  I took the second with
bash (tab completion) and dd frozen as well (as bonnie++).

Under ext3, anything writing to the same directory as bonnie seems to
freeze.  With xfs, anything not dealing with the file in question (i.e.
the dd I use to try to get bonnie++ reaped) succeed, though they may be
slow.

The bonnie cmd line is in min-ext3-ps.  The same bonnie trial succeeds
if dpt_i2o is used rather than i2o.

One final tidbit.  umount -f /db ends up with:

umount2: Device or resource busy
umount: /dev/i2o/hda/part7: not mounted
umount: /db: Illegal seek
umount2: Devoce or resource busy
umount: /db: device is busy


I can't test this system beyond Tuesday afternoon, unfortunately.

-- 
"When in our age we hear these words: It will be judged by the result--then we
know at once with whom we have the honor of speaking.  Those who talk this way
are a numerous type whom I shall designate under the common name of assistant
professors."  -- Kierkegaard, Fear and Trembling (Wong tr.), III, 112

