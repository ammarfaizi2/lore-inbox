Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUHGMvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUHGMvD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 08:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUHGMvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 08:51:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47876 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261857AbUHGMu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 08:50:59 -0400
Date: Sat, 7 Aug 2004 13:50:56 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: [BUG] 2.6.8-rc3 redboot.c tries to kmalloc 256K
Message-ID: <20040807135056.C2805@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.6.8-rc3, I'm unable to mount the jffs2 root filesystem on one of
my test systems.  The system uses redboot, so has a redboot partition
table.  However, the kernel was not detecting the table.

After prodding about for a while, I've found that redboot.c seems to
be trying to kmalloc 256K of memory.   The largest size that kmalloc
supports is 128K on MMUfull systems.

static int parse_redboot_partitions(struct mtd_info *master,
                             struct mtd_partition **pparts,
                             unsigned long fis_origin)
{
	...
printk("erasesize: %d\n", master->erasesize);
        buf = kmalloc(master->erasesize, GFP_KERNEL);

        if (!buf)
                return -ENOMEM;

produces:

sa1100-0: Found 2 x16 devices at 0x0 in 32-bit bank
 Intel/Sharp Extended Query Table at 0x0031
cfi_cmdset_0001: Erase suspend on write enabled
Using buffer write method
SA1100 flash: CFI device at 0x00000000, 32MiB, 32-bit
CFI: Found no sa1100-1 device at location zero
cmdlinepart: c03e69ec
cmdlinepart: returned -22
RedBoot: c03e69d8
erasesize: 262144
RedBoot: returned -12
SA1100 flash: using static partition definition
Creating 3 MTD partitions on "sa1100-0":
0x00000000-0x00040000 : "bootloader"
0x00040000-0x00080000 : "bootloader params"
0x00080000-0x02000000 : "jffs"
...
Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
