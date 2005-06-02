Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFBRV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFBRV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 13:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFBRV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 13:21:57 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:40338 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S261192AbVFBRVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 13:21:53 -0400
Date: Thu, 2 Jun 2005 12:18:28 +0200
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: Overcommit problems with 2.6.12-rc4 (on AMD64)
Message-ID: <20050602101828.GA11794@uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 2.6.11.8 on a i686
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.9i
X-Spam-Score: -2.6 (--)
X-Spam-Report: Status=No hits=-2.6 required=5.0 tests=ALL_TRUSTED,DATE_IN_PAST_06_12 version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please Cc me on answers, I don't follow LKML.)

Hi,

Suddenly one of our servers, a Dual Opteron with 2GB memory (running 32-bit
userland, but 64-bit kernel) started to behave oddly:

  imapd[31528]: segfault at 00000000fff00000 rip 00000000556a1a6d rsp 00000000ffffd394 error 4
  imapd[31527]: segfault at 00000000fff00000 rip 00000000556a1a6d rsp 00000000ffffcbe4 error 4
  sh[31530]: segfault at 00000000ffff7ff4 rip 000000005555e556 rsp 00000000ffff7ff8 error 6
  sh[31531]: segfault at 00000000ffff7e5c rip 00000000555dc575 rsp 00000000ffff7e60 error 6
  Unable to load interpreter /lib/ld-linux.so.2
  Unable to load interpreter /lib/ld-linux.so.2
  (ad infinitum)

It turned out it had some sort of memory problem:

  Jun  2 11:56:02 cassarossa smbd[7171]: oplock_break: malloc fail for input buffer. 
  Jun  2 11:56:02 cassarossa smbd[7171]: open_mode_check: FAILED when breaking oplock (3) on file login.bat, dev = 900, inode = 110665 

This wasn't a RAM problem, as the machine has ECC RAM and we received no
warnings from it. Also, we definitely had enough swap:

  cassarossa:~# free
               total       used       free     shared    buffers     cached
  Mem:       2058300    2041136      17164          0      39576    1601468
  -/+ buffers/cache:     400092    1658208
  Swap:      3903712          0    3903712

It looks like somehow, the kernel couldn't really distinguish between memory
used as cache and just "used". It couldn't even swapoff:

  cassarossa:~# swapoff -a
  swapoff: /dev/sda5: Cannot allocate memory
  swapoff: /dev/sdf5: Cannot allocate memory

However, we run with vm.overcommit_memory=2, so we figured out it was worth a
shot:

  cassarossa:~# echo 0 > /proc/sys/vm/overcommit_memory 
  cassarossa:~# swapoff -a
  cassarossa:~# swapon -a 
  cassarossa:~# free -m
               total       used       free     shared    buffers     cached
  Mem:          2010       1993         16          0         39       1595
  -/+ buffers/cache:        358       1651
  Swap:         3812          0       3812

Suddenly everything seems to be back to normal (ie. we could swapoff, and the
programs stopped running out of memory; no changes in the cache used,
though), and after a quick restart of services, everything is back to normal.
So to me, it looks like vm.overcommit_memory=2 is broken, at least on AMD64.
Any ideas why this would happen?

for the record:

  cassarossa:~# uname -a
  Linux cassarossa 2.6.12-rc4 #1 SMP Fri May 13 18:49:40 CEST 2005 x86_64 unknown

No kernel patches except for a microscopic forward-port of the ELF fix from
2.6.11.9.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
