Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbUAUQOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUAUQOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:14:36 -0500
Received: from c211-28-164-234.eburwd2.vic.optusnet.com.au ([211.28.164.234]:56707
	"EHLO willster") by vger.kernel.org with ESMTP id S265976AbUAUQOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:14:32 -0500
Subject: Oops while trying to mount (possibly faulty) HFS cdrom
From: Stewart Smith <stewart@flamingspork.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1074699785.2623.274.camel@willster>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 02:43:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I (think) this is a HFS formatted CD-ROM. It was created quite a while
ago, with an old version of Toast. The media seems to currently be
faulty (no surprise, it was burnt with a half dodgy CD-R, it would only
burn on this brand of media) - I can't get it to mount on MacOS 9 on a
Beige G3.

Kernel:
Linux version 2.6.1-ben1 (stewart@willster) (gcc version 3.3.3 20040110
(prerelease) (Debian)) #6 Wed Jan 21 16:31:57 EST 2004

(rsynced today)

The log mesage just before the oops could be interesting:
size: 0,1125980,0

kernel BUG in grow_buffers at fs/buffer.c:1189!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C005CA40 LR: C005C9FC SP: D2813C40 REGS: d2813b90 TRAP: 0700    Not
taintedMSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = d1eec0c0[2407] 'mount' Last syscall: 21
GPR00: 000007FF D2813C40 D1EEC0C0 00000000 00000000 00000001 00000000
00000000
GPR08: 0000001C 00000000 00000000 00000800 22004422 1002ADF0 10020000
100C0000
GPR16: 00000000 00000000 00000000 00000000 7FFFFEF5 00000000 10020000
00000000
GPR24: 7FFFFF00 D2813EB0 00000000 00000800 00000000 D7AC4260 00000000
D6E07800
Call trace:
 [c005cfb0] __getblk+0x5c/0x64
 [c005d010] __bread+0x10/0x40
 [d98a03cc] hfs_mdb_get+0xa4/0x6bc [hfs]
 [d98a1720] hfs_fill_super+0x94/0x1a4 [hfs]
 [c0061b74] get_sb_bdev+0x128/0x180
 [d98a1848] hfs_get_sb+0x18/0x28 [hfs]
 [c0061e48] do_kern_mount+0x64/0x120
 [c007809c] do_add_mount+0x90/0x1bc
 [c0078418] do_mount+0x140/0x178
 [c0078834] sys_mount+0xa4/0xf4
 [c0007c6c] ret_from_syscall+0x0/0x4c


Incidently, on 2.4.20-powerpc-xfs (from the PPC debian xfs net-inst cd),
I get the following error:

ATAPI device hdc:
  Error: Not ready -- (Sense key=0x02)
  Unable to recover table of contents -- (asc=0x57, ascq=0x00)
  The failed "Test Unit Ready" packet command was:
  "00 00 00 00 00 00 00 00 00 00 00 00 "
ATAPI device hdc:
  Error: Not ready -- (Sense key=0x02)
  Unable to recover table of contents -- (asc=0x57, ascq=0x00)
  The failed "Start/Stop Unit" packet command was:
  "1b 00 00 00 03 00 00 00 00 00 00 00 "
cdrom: open failed.
ATAPI device hdc:
  Error: Not ready -- (Sense key=0x02)
  Unable to recover table of contents -- (asc=0x57, ascq=0x00)
  The failed "Test Unit Ready" packet command was:
  "00 00 00 00 00 00 00 00 00 00 00 00 "
ATAPI device hdc:
  Error: Not ready -- (Sense key=0x02)
  Unable to recover table of contents -- (asc=0x57, ascq=0x00)
  The failed "Test Unit Ready" packet command was:
  "00 00 00 00 00 00 00 00 00 00 00 00 "

looking through those functions, it seems as though the sector size
isn't valid - possibly a product of the bad disk.

I'm not quite sure which bit should be fixed here, but somewhere along
the lines, a function should return an error, and not continue (at least
to the BUG() line).

thanks and enjoy :)

-- 
Stewart Smith (stewart@flamingspork.com)
http://www.flamingspork.com/


