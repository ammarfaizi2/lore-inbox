Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVADA3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVADA3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVADAWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:22:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38151 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262030AbVADAPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:15:22 -0500
Date: Tue, 4 Jan 2005 01:15:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mark_H_Johnson@raytheon.com
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       nico@cam.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
Subject: [2.6 patch] add missing dependencies on MTD_PARTITIONS (fwd)
Message-ID: <20050104001516.GU2980@stusta.de>
References: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0551C40F.E8032010-ON86256F7E.007EFEBA-86256F7E.007EFF1F@raytheon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 05:07:08PM -0600, Mark_H_Johnson@raytheon.com wrote:
> I was looking to compare RT latency between this kernel and the latest from
> Ingo and I had the following warnings / errors building 2.6.10-mm1:
> 
> [no apparent compile / link errors]
>...
> *** Warning: "del_mtd_partitions" [drivers/mtd/maps/scx200_docflash.ko]
> undefined!
> *** Warning: "add_mtd_partitions" [drivers/mtd/maps/scx200_docflash.ko]
> undefined!
>...


Known bug, fix below:


<--  snip  -->


Date:   Mon, 27 Dec 2004 23:50:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: nico@cam.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] add missing dependencies on MTD_PARTITIONS

On Tue, Dec 28, 2004 at 12:23:48AM +0200, Michael S. Tsirkin wrote:

> Hello!

Hi Michael!

> Sorry, I had a wrong subject.
> 
> It seems that you can disable MTD partitioning support 
> but enable , e.g. NAND.
> And, if you are upgrading from and older kernel without
> the paritioning option, and do oldconfig and are not careful,
> thats what you end up with.
> But, lots of code is calling del_mtd_partitions now, so you get
> unresolved del_mtd_partitions.
> 
> Its easy to work around this by enabling partitioning, but
> should not the dependency be added in the relevant KConfig?

First of all thanks for your report.
You didn't send the exact error mesage.
I'm able to reproduce the following in 2.6.10-rc3-mm1:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.init.text+0x6464b): In function `init_scx200_docflash':
: undefined reference to `add_mtd_partitions'
drivers/built-in.o(.init.text+0x66ab8): In function `ns_init_module':
: undefined reference to `add_mtd_partitions'
drivers/built-in.o(.exit.text+0x8bf4): In function `cleanup_scx200_docflash':
: undefined reference to `del_mtd_partitions'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

The patch below fixes them.

Please tell whether this fixes the problems you observed.

> Cc me directly, I'm not on the list.
> Thanks,
> MST

cu
Adrian


diffstat output:
 drivers/mtd/maps/Kconfig |    2 +-
 drivers/mtd/nand/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/drivers/mtd/maps/Kconfig.old	2004-12-27 23:43:00.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/mtd/maps/Kconfig	2004-12-27 23:44:01.000000000 +0100
@@ -159,7 +159,7 @@
 
 config MTD_SCx200_DOCFLASH
 	tristate "Flash device mapped with DOCCS on NatSemi SCx200"
-	depends on X86 && MTD_CFI
+	depends on X86 && MTD_CFI && MTD_PARTITIONS
 	help
 	  Enable support for a flash chip mapped using the DOCCS signal on a
 	  National Semiconductor SCx200 processor.
--- linux-2.6.10-rc3-mm1-full/drivers/mtd/nand/Kconfig.old	2004-12-27 23:44:44.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/drivers/mtd/nand/Kconfig	2004-12-27 23:45:37.000000000 +0100
@@ -198,7 +198,7 @@
  
  config MTD_NAND_NANDSIM
  	bool "Support for NAND Flash Simulator"
- 	depends on MTD_NAND
+ 	depends on MTD_NAND && MTD_PARTITIONS
 
 	help
 	  The simulator may simulate verious NAND flash chips for the
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

