Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUFAOI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUFAOI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUFAOFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:05:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41220 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265067AbUFAOAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:00:32 -0400
Date: Tue, 1 Jun 2004 15:00:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.6.7-rc2: mpage_writepage
Message-ID: <20040601150025.A31301@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to look at a cache problem on ARM PXA, but unfortunately
hit the following problem:

Opening 'l/testfile'
Unable to handle kernel NULL pointer dereference at virtual address 00000000
Modules linked in: mmc_block mmc_core vfat msdos fat nls_cp850 nls_cp437 nls_iso8859_1 nls_utf8
CPU: 0
PC is at 0x0
LR is at mpage_writepage+0x1fc/0x5e0
pc : [<00000000>]    lr : [<c0091904>]    Not tainted
sp : c37c1bec  ip : 00000000  fp : c37c1c88
r10: 00000000  r9 : 000000ff  r8 : 00000000
r7 : c0284060  r6 : c3f08574  r5 : c3f08540  r4 : 00000000
r3 : 00000001  r2 : c37c1c10  r1 : 00000000  r0 : c3f08540
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 397F  Table: A34E4000  DAC: 00000015
Process disktest (pid: 281, stack limit = 0xc37c0190)
[stack removed]
Backtrace:
[<c0091708>] (mpage_writepage+0x0/0x5e0) from [<c0091ed0>] (mpage_writepages+0x1e8/0x2f0)
[<c0091ce8>] (mpage_writepages+0x0/0x2f0) from [<c00905e4>] (__sync_single_inode+0x60/0x190)
[<c0090584>] (__sync_single_inode+0x0/0x190) from [<c0090cf8>] (write_inode_now+0x44/0x64)
[<c0090cb4>] (write_inode_now+0x0/0x64) from [<c0090ddc>] (generic_osync_inode+0xb0/0xc8)
 r5 = C37C0000  r4 = C3F085D8
[<c0090d2c>] (generic_osync_inode+0x0/0xc8) from [<c0054784>] (generic_file_aio_write_nolock+0xa7c/0xafc)
[<c0053d08>] (generic_file_aio_write_nolock+0x0/0xafc) from [<c005485c>] (generic_file_write_nolock+0x58/0x7c)
[<c0054804>] (generic_file_write_nolock+0x0/0x7c) from [<c00549a8>] (generic_file_write+0x54/0x7c)
 r5 = C39E8EC4  r4 = C3F085A8
[<c0054954>] (generic_file_write+0x0/0x7c) from [<c0071354>] (vfs_write+0xe8/0x120)
 r4 = 00000000
[<c007126c>] (vfs_write+0x0/0x120) from [<c0071428>] (sys_write+0x40/0x5c)
[<c00713e8>] (sys_write+0x0/0x5c) from [<c00221e0>] (ret_fast_syscall+0x0/0x2c)
 r6 = 00100000  r5 = 00011158  r4 = 00000003
Code: bad PC value.

It appears that mpage_writepage() was passed a NULL get_block function.

In the intended test case, we do:

- ramfs filesystem on /tmp
- /tmp/lo contains an ext2 filesystem image
- endlessly repeat
  - mount /tmp/lo /tmp/l -t ext2 -o loop
  - open + write /tmp/l/testfile + close
  - open + mmap file + close
  - read file from last page to first page
  - unmount /tmp/l

However, because I messed up and got the /etc/fstab entry wrong for this
test, /tmp/l was just a directory, so instead of accessing the loopback
filesystem, we accessed ramfs directly.

The source for the test program concerned can be found at:

  http://lkml.org/lkml/2003/5/23/88

(and yes, the old cache bug which was talked about back then still
remains...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
