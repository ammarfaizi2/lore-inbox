Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbTC1Ca7>; Thu, 27 Mar 2003 21:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261949AbTC1Ca7>; Thu, 27 Mar 2003 21:30:59 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:5335 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261937AbTC1Ca6>; Thu, 27 Mar 2003 21:30:58 -0500
Date: Thu, 27 Mar 2003 21:42:14 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: BLKGETSIZE64 is broken (0x80041272)
Message-ID: <20030327214214.B19517@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was adding ioctl translations and found that BLKGETSIZE64
equals 0x80041272, with wrong size. Apparently, a whole bunch
of ioctls takes sizeof(sizeof(foo)), which evaluates to 4
in 32 bit userland, regardless of the size of foo.
Are we going to do anything about it? At the bare minimum,
I suggest we add comments near EVERY of the offenders,
marking them as broken and warning that we are leaving them
as is for binary compatibility. I compared 2.4 and 2.5, and
the same breakage is present in both, only more people fell
for this trap in 2.5, so it obviously needs some action.

-- Pete

[zaitcev@niphredil linux-2.5.64-sparc]$ grep _IOR include/linux/*.h | grep sizeof
include/linux/fs.h:#define BLKELVGET  _IOR(0x12,106,sizeof(blkelv_ioctl_arg_t))/* elevator get */
include/linux/fs.h:#define BLKBSZGET  _IOR(0x12,112,sizeof(int))
include/linux/fs.h:#define BLKGETSIZE64 _IOR(0x12,114,sizeof(u64))      /* return device size in bytes (u64 *arg) */
include/linux/i8k.h:#define I8K_POWER_STATUS    _IOR ('i', 0x82, sizeof(int))
include/linux/i8k.h:#define I8K_FN_STATUS               _IOR ('i', 0x83, sizeof(int))
include/linux/i8k.h:#define I8K_GET_TEMP                _IOR ('i', 0x84, sizeof(int))
include/linux/matroxfb.h:#define MATROXFB_GET_OUTPUT_CONNECTION _IOR('n',0xF8,sizeof(__u32))
include/linux/matroxfb.h:#define MATROXFB_GET_AVAILABLE_OUTPUTS _IOR('n',0xF9,sizeof(__u32))
include/linux/matroxfb.h:#define MATROXFB_GET_ALL_OUTPUTS       _IOR('n',0xFB,sizeof(__u32))
include/linux/pmu.h:#define PMU_IOC_GET_BACKLIGHT       _IOR('B', 1, sizeof(__u32*))
include/linux/pmu.h:#define PMU_IOC_GET_MODEL   _IOR('B', 3, sizeof(__u32*))
include/linux/pmu.h:#define PMU_IOC_HAS_ADB             _IOR('B', 4, sizeof(__u32*))
include/linux/pmu.h:#define PMU_IOC_CAN_SLEEP   _IOR('B', 5, sizeof(__u32*))
include/linux/radeonfb.h:#define FBIO_RADEON_GET_MIRROR _IOR('@', 3, sizeof(__u32*))
include/linux/sisfb.h:#define SISFB_GET_INFO      _IOR('n',0xF8,sizeof(__u32))
[zaitcev@niphredil linux-2.5.64-sparc]$

-- Pete
