Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbUL0XlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUL0XlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbUL0XlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:41:08 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:54659 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261999AbUL0Xkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 18:40:55 -0500
Date: Tue, 28 Dec 2004 01:41:30 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: nico@cam.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add missing dependencies on MTD_PARTITIONS
Message-ID: <20041227234130.GA13703@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041227222348.GB13628@mellanox.co.il> <20041227225014.GD5345@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227225014.GD5345@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Adrian Bunk (bunk@stusta.de) "[2.6 patch] add missing dependencies on MTD_PARTITIONS":
> On Tue, Dec 28, 2004 at 12:23:48AM +0200, Michael S. Tsirkin wrote:
> 
> > Hello!
> 
> Hi Michael!
> 
> > Sorry, I had a wrong subject.
> > 
> > It seems that you can disable MTD partitioning support 
> > but enable , e.g. NAND.
> > And, if you are upgrading from and older kernel without
> > the paritioning option, and do oldconfig and are not careful,
> > thats what you end up with.
> > But, lots of code is calling del_mtd_partitions now, so you get
> > unresolved del_mtd_partitions.
> > 
> > Its easy to work around this by enabling partitioning, but
> > should not the dependency be added in the relevant KConfig?
> 
> First of all thanks for your report.
> You didn't send the exact error mesage.

Thats because I built partitions in so I dont see it anymore.

> I'm able to reproduce the following in 2.6.10-rc3-mm1:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.init.text+0x6464b): In function `init_scx200_docflash':
> : undefined reference to `add_mtd_partitions'
> drivers/built-in.o(.init.text+0x66ab8): In function `ns_init_module':
> : undefined reference to `add_mtd_partitions'
> drivers/built-in.o(.exit.text+0x8bf4): In function `cleanup_scx200_docflash':
> : undefined reference to `del_mtd_partitions'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->

True.

> The patch below fixes them.

Maybe, but I believe its not the correct fix.

> Please tell whether this fixes the problems you observed.

I may. But:

/usr/src/linux-2.6.10/drivers/mtd # grep -rIil del_mtd_partitions .
./devices/lart.c
./maps/wr_sbc82xx_flash.c
./maps/ixp4xx.c
./maps/ocotea.c
./maps/bast-flash.c
./maps/db1x00-flash.c
./maps/dmv182.c
./maps/cstm_mips_ixx.c
./maps/lasat.c
./maps/h720x-flash.c
./maps/tqm8xxl.c
./maps/impa7.c
./maps/dilnetpc.c
./maps/fortunet.c
./maps/sa1100-flash.c
./maps/nettel.c
./maps/db1550-flash.c
./maps/omap-toto-flash.c
./maps/arctic-mtd.c
./maps/ceiva.c
./maps/dc21285.c
./maps/pnc2000.c
./maps/elan-104nc.c
./maps/sbc_gxx.c
./maps/pb1550-flash.c
./maps/physmap.c
./maps/beech-mtd.c
./maps/ipaq-flash.c
./maps/mpc1211.c
./maps/lubbock-flash.c
./maps/scx200_docflash.c
./maps/redwood.c
./maps/epxa10db-flash.c
./maps/netsc520.c
./maps/ebony.c
./maps/iq80310.c
./maps/uclinux.c
./maps/ts5500_flash.c
./maps/dbox2-flash.c
./maps/ixp2000.c
./maps/ocelot.c
./maps/pb1xxx-flash.c
./maps/cfi_flagadm.c
./maps/integrator-flash.c
./maps/solutionengine.c
./maps/scx200_docflash.mod.c
./maps/physmap.mod.c
./nand/nand_base.c
./nand/nand.mod.c
./mtdpart.c

So I expect all map devices, and all nand devices and not just
these you fixed, must depend on MTD partitions.


> > Cc me directly, I'm not on the list.
> > Thanks,
> > MST
> 
> cu
> Adrian
> 
> 
> diffstat output:
>  drivers/mtd/maps/Kconfig |    2 +-
>  drivers/mtd/nand/Kconfig |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.10-rc3-mm1-full/drivers/mtd/maps/Kconfig.old	2004-12-27 23:43:00.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/drivers/mtd/maps/Kconfig	2004-12-27 23:44:01.000000000 +0100
> @@ -159,7 +159,7 @@
>  
>  config MTD_SCx200_DOCFLASH
>  	tristate "Flash device mapped with DOCCS on NatSemi SCx200"
> -	depends on X86 && MTD_CFI
> +	depends on X86 && MTD_CFI && MTD_PARTITIONS
>  	help
>  	  Enable support for a flash chip mapped using the DOCCS signal on a
>  	  National Semiconductor SCx200 processor.
> --- linux-2.6.10-rc3-mm1-full/drivers/mtd/nand/Kconfig.old	2004-12-27 23:44:44.000000000 +0100
> +++ linux-2.6.10-rc3-mm1-full/drivers/mtd/nand/Kconfig	2004-12-27 23:45:37.000000000 +0100
> @@ -198,7 +198,7 @@
>   
>   config MTD_NAND_NANDSIM
>   	bool "Support for NAND Flash Simulator"
> - 	depends on MTD_NAND
> + 	depends on MTD_NAND && MTD_PARTITIONS
>  
>  	help
>  	  The simulator may simulate verious NAND flash chips for the
