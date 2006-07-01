Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWGANgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWGANgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 09:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWGANgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 09:36:15 -0400
Received: from jenny.ondioline.org ([66.220.1.122]:17413 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1750740AbWGANgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 09:36:14 -0400
From: Paul Collins <paul@briny.ondioline.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: faulty 64-bit resource printk fixup in macio_asic.c
Mail-Followup-To: Greg Kroah-Hartman <gregkh@suse.de>,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Date: Sat, 01 Jul 2006 23:30:18 +1000
Message-ID: <878xndqwph.fsf@briny.internal.ondioline.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The patch titled "64bit resource: fix up printks for resources in misc
drivers", committed as e29419fffceb8ec36def3c922040e1ca7bcd3de5 in
Linus's tree, causes my PowerBook to Oops early in boot and udev to
not function.

  Unable to handle kernel paging request for data at address 0x6f000000
  Faulting instruction address: 0xc00c901c
  Oops: Kernel access of bad area, sig: 11 [#1]
  PREEMPT 
  Modules linked in:
  NIP: C00C901C LR: C00C901C CTR: C00C8F78
  REGS: efed5db0 TRAP: 0300   Not tainted  (2.6.17-g9262e914)
  MSR: 00009032 <EE,ME,IR,DR>  CR: 22000484  XER: 20000000
  DAR: 6F000000, DSISR: 40000000
  TASK = efe97240[378] 'udevtrigger' THREAD: efed4000
  GPR00: C00C901C EFED5E60 EFE97240 00000000 CFC0BB40 00010001 CFC0BB40 C02E9754 
  GPR08: 00000000 00000001 EFFE8EA4 EFED4000 44000428 1001D140 100D0000 100D0000 
  GPR16: 00000000 100EBF08 100D0000 100B0000 100D0000 100B0000 100EBEA8 100EC068 
  GPR24: 00000000 EFEEDA20 C0DF7880 EFED4000 CFC0BB40 EFEEDA20 C0DF78D0 6F000000 
  NIP [C00C901C] sysfs_open_file+0xa4/0x284
  LR [C00C901C] sysfs_open_file+0xa4/0x284
  Call Trace:
  [EFED5E60] [C00C901C] sysfs_open_file+0xa4/0x284 (unreliable)
  [EFED5E90] [C007D6A8] __dentry_open+0x108/0x2a4
  [EFED5EC0] [C007D988] do_filp_open+0x5c/0x78
  [EFED5F20] [C007D9FC] do_sys_open+0x58/0xf8
  [EFED5F40] [C000FDB8] ret_from_syscall+0x0/0x38
  --- Exception: c01 at 0xff248d8
      LR = 0xffb525c
  Instruction dump:
  3be0ffea 812b0050 83c90014 419e007c 2f9e0000 419e006c 83fe0004 2f9f0000 
  419e0080 38600001 4bf5b229 4809726d <801f0000> 3ba00000 2f800002 419e0024 
   <6>note: udevtrigger[378] exited with preempt_count 1


The only hunk of that commit affecting my configuration is this one,
which when reverted lets my machine work again.

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index 431bd37..c687ac7 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -428,10 +428,10 @@ #endif
 
 	/* MacIO itself has a different reg, we use it's PCI base */
 	if (np == chip->of_node) {
-		sprintf(dev->ofdev.dev.bus_id, "%1d.%08lx:%.*s",
+		sprintf(dev->ofdev.dev.bus_id, "%1d.%016llx:%.*s",
 			chip->lbus.index,
 #ifdef CONFIG_PCI
-			pci_resource_start(chip->lbus.pdev, 0),
+			(unsigned long long)pci_resource_start(chip->lbus.pdev, 0),
 #else
 			0, /* NuBus may want to do something better here */
 #endif


When applied, this hunk yields

	/* MacIO itself has a different reg, we use it's PCI base */
	if (np == chip->of_node) {
		sprintf(dev->ofdev.dev.bus_id, "%1d.%016llx:%.*s",
			chip->lbus.index,
#ifdef CONFIG_PCI
			(unsigned long long)pci_resource_start(chip->lbus.pdev, 0),
#else
			0, /* NuBus may want to do something better here */
#endif
			MAX_NODE_NAME_SIZE, np->name);


Since dev->ofdev.dev is a struct device, bus_id is 20 bytes, of which
19 are consumed by "%1d.%016llx:".  But the field width used by "%.*s"
is MAX_NODE_NAME_SIZE, which is 8.

drivers/macintosh/macio_asic.c:36:#define MAX_NODE_NAME_SIZE (BUS_ID_SIZE - 12)

So I think the sprintf overflows bus_id and clobbers the next few
bytes of struct device.

I'm not sure what the right thing to do is.  Making bus_id bigger will
cost everyone, but right now with bus_id at 20 bytes, there's no room
after the colon for any of np->name.

-- 
Paul Collins
Melbourne, Australia

Dag vijandelijk luchtschip de huismeester is dood
