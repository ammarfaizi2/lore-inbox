Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbRBQJxZ>; Sat, 17 Feb 2001 04:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129204AbRBQJxP>; Sat, 17 Feb 2001 04:53:15 -0500
Received: from mercury.ST.HMC.Edu ([134.173.57.219]:2052 "HELO
	mercury.st.hmc.edu") by vger.kernel.org with SMTP
	id <S129107AbRBQJxB>; Sat, 17 Feb 2001 04:53:01 -0500
From: Nate Eldredge <neldredge@hmc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14990.18933.849551.526672@mercury.st.hmc.edu>
Date: Sat, 17 Feb 2001 01:52:53 -0800
To: linux-kernel@vger.kernel.org
Subject: 2.4.1ac17 hang on mounting loopback fs
X-Mailer: VM 6.76 under Emacs 20.5.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one should be easy to track down, it's reproducible (2 for 2 so
far).

Kernel 2.4.1ac17 compiled by gcc 2.95.2.

Scenario: In single-user mode; only user process running is /bin/bash
(pid 1).  Only fs'es mounted are / (ro), /spare (rw) (both ext2),
/proc.

# mount -t ext2 -o loop /spare/i486-linuxaout.img /spare/mnt
loop: enabling 8 loop devices

then it hangs.  No ctrl-C etc.

I did Ctrl+ScrollLock.  The entry for mount had the following (copied
manually):

mount D C7E33E78 5012  23   1  (NOTLB)
Call trace: c012f17a c0130167 c0151dc1 c01267af c0133102 c013331c
c0108e84 c0133e65 c0133c9c [maybe 3cac] c013401c c0108d43

Appropriate lines of System.map, in order:

c012f110 T __wait_on_buffer
c0130124 T bread
c0151d0c T ext2_read_super
c0126740 T kmalloc
c0132ffc t read_super
c01331d0 t get_sb_bdev
c0108e50 t error_code
c0133cec T do_mount
c0133c4c t copy_mount_options [in either case]
c0133fa0 T sys_mount
c0108d10 T system_call

The image file in question is ext2, about 20 MB, 1K blocksize.  loop.o
is compiled as a module.

Incidentally this also happened under more normal circumstances, when
it tried to mount the fs from fstab.  I haven't yet booted without
mounting that fs.

Btw, this machine has a FIC PA-2013 motherboard with VIA chipset, and
I have CONFIG_IDEDMA_PCI_AUTO enabled.  But this doesn't seem like the
other trouble such machines were having.

I'm happy to provide more info, test patches, etc.  Please CC me
directly if convenient as I can only read the list through a web
gateway, which is slow.

-- 

Nate Eldredge
neldredge@hmc.edu
