Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWJFQnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWJFQnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbWJFQnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:43:49 -0400
Received: from pas38-1-82-67-71-117.fbx.proxad.net ([82.67.71.117]:38314 "EHLO
	siegfried.gbfo.org") by vger.kernel.org with ESMTP id S1422707AbWJFQnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:43:47 -0400
Date: Fri, 6 Oct 2006 18:42:00 +0200 (CEST)
From: Jean-Marc Saffroy <saffroy@gmail.com>
X-X-Sender: saffroy@erda.mds
To: linux-kernel@vger.kernel.org
Subject: [announce] kdump2gdb: analyze kdumps with gdb (well, almost)
Message-ID: <Pine.LNX.4.64.0610061742270.9250@erda.mds>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

Following earlier discussions on how nice it would be to use gdb on kdump 
cores, I took some time and wrote a small tool to do just that:
   http://jeanmarc.saffroy.free.fr/kdump2gdb/

The main limitation is that there is absolutely no backtrace of 
non-running tasks yet, but I will try to see how it can be done. Also, it 
works only on x86-64, but people are welcome to contribute ports. :)

Below is the README, and an example of gdb stack trace.


Cheers,

-- 
saffroy@gmail.com

kdump2gdb
---------

The kdump2gdb script converts a kdump core file (which is essentially an ELF
core) into a slightly different ELF core that can be directly used with gdb.
It also produces a gdb script that loads the required kernel modules.

Features:
  - completely automated: run kdump2gdb, then start gdb on your new core file,
    load modules, and enjoy!
  - the power of gdb to explore stack frames with full debug infos

Limitations:
  - currently limited to x86-64; but support for other arches should not be
    difficult to add
  - only running processes can be backtraced: it is certainly possible to
    enable stack trace of all tasks, and I'd love to add this feature!
    Give me some time to look into it.
  - gdb scripting is *slow*! But a patch that improves this is already
    available, and I suspect there could be more in the near future.


Sample session
--------------

Below is an example of how I use kdump2gdb (from the tarball). As you can see,
even on a 2GHz Athlon box with a patched gdb, it takes 5 minutes to complete.

  $ cd kdump2gdb-0.1
  $ make
gcc -Wall -g  -lelf  kdumpfix.c   -o kdumpfix
  $ \time ./kdump2gdb -k /var/dump/dump-2006-09-21_11\:15\:21i \
    -d ../build-2.6.18/ -o /tmp/core -g modload
Restoring low identity-mapped areas...
Gathering vmalloc-mapped areas...

warning: shared library handler failed to enable breakpoint
Restoring vmalloc-mapped areas...
Preparing gdb script to map modules...

warning: shared library handler failed to enable breakpoint
All done. Now you can do:
  $ gdb ../build-2.6.18//vmlinux /tmp/core
  (gdb) source modload
  (gdb) bt
203.21user 6.57system 5:07.01elapsed 68%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (37196major+1055938minor)pagefaults 0swaps

(The warnings are produced by gdb, they are harmless.)


Gdb patches
-----------

I use gdb 6.5, and encountered the following problems:
  - gdb crashes in realloc on add-symbol-file:
    the fix is here:
      http://sources.redhat.com/ml/gdb-patches/2006-10/msg00056.html
  - gdb scripts are sooooooooooo sloooooow:
    a significant improvement is observed with the patch mentioned here:
      http://sources.redhat.com/ml/gdb/2006-10/msg00023.html

You should edit the kdump2gdb script to use a specific gdb binary if needed.


Licensing
---------

This program is free software, distributed under the terms of the
GNU General Public License version 2.


Contact
-------

Jean-Marc Saffroy <saffroy@gmail.com>

%%%%%%%%%%%%%%%%

Compare the stack below with my older post (same dump):
   http://lkml.org/lkml/2006/9/24/76

(gdb) bt
#0  resample_expand (plugin=0xffff81003f2e9ec0,
     src_channels=0xffff81001fe532c0, dst_channels=0xffff81002412e140,
     src_frames=1024, dst_frames=6150)
     at /home/saffroy/kernel/linux-2.6.18/sound/core/oss/rate.c:116
#1  0xffffffff8822387b in rate_transfer (plugin=0xffff81003f2e9ec0,
     src_channels=0xffff81001fe532c0, dst_channels=0xffff81002412e140,
     frames=1024) at /home/saffroy/kernel/linux-2.6.18/sound/core/oss/rate.c:280
#2  0xffffffff88221438 in snd_pcm_plug_write_transfer (
     plug=0xffff81003e0a6400, src_channels=0xffff81001fe532c0,
     size=<value optimized out>)
     at /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_plugin.c:594
#3  0xffffffff8821f4b5 in snd_pcm_oss_write2 (substream=0xffff81003e0a6400,
     buf=<value optimized out>, bytes=4096, in_kernel=<value optimized out>)
     at /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c:1283
#4  0xffffffff882207e6 in snd_pcm_oss_write (file=<value optimized out>,
     buf=0xac13178 <Address 0xac13178 out of bounds>, count=8192,
     offset=<value optimized out>)
     at /home/saffroy/kernel/linux-2.6.18/sound/core/oss/pcm_oss.c:1339
#5  0xffffffff80215a22 in vfs_write (file=0xffff81003e9c9dc0,
     buf=0xac13178 <Address 0xac13178 out of bounds>, count=8192,
     pos=0xffff81002c243f48)
     at /home/saffroy/kernel/linux-2.6.18/fs/read_write.c:316
#6  0xffffffff80216320 in sys_write (fd=<value optimized out>,
---Type <return> to continue, or q <return> to quit---
     buf=0xac13178 <Address 0xac13178 out of bounds>, count=8192)
     at /home/saffroy/kernel/linux-2.6.18/fs/read_write.c:369
#7  0xffffffff8026480e in ia32_do_syscall () at include2/asm/current.h:11
#8  0x00000000f7e2f3a1 in ?? ()
Previous frame inner to this frame (corrupt stack?)
(gdb)
