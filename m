Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUGaPEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUGaPEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 11:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267699AbUGaPEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 11:04:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267199AbUGaPEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 11:04:33 -0400
Date: Sat, 31 Jul 2004 12:02:14 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 PATCH] problems with modular and nonmodular ide mix
Message-ID: <20040731150214.GG6497@logos.cnet>
References: <Pine.GSO.4.44.0407191332150.14892-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0407191332150.14892-100000@math.ut.ee>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2004 at 02:01:16PM +0300, Meelis Roos wrote:
> I was trying to figure out an unresolved modules symbol on PPC
> (2.4.27-BK): init_cmd640_vlb(). This is used in ide.c and defined in
> pci/cmd640.c. It appears that nothing from drivers/ide/pci is compiled
> at all - make traverses the directory but nothing gets compiled.
> Relevant part of .config is below.
> 
> So at least sl82c105 and cmd640 should get compiled but don't.
> 
> I suspected that since IDE is modular, only drivers configured as
> modules are compiled but not static ones. I set sl82c105 to M and it was
> compiled.
> 
> So the problem is that cmd640 can only be compiled in statically but not
> into modular IDE. What about the patch below to fix this? It builds
> and loads fine here, but it only fixes an obscure configuration.

Hi Meelis,

The thing is cmd640 can't be compiled as a module - just dont
use IDE modular if you need cmd640. 

> ===== drivers/ide/Config.in 1.41 vs edited =====
> --- 1.41/drivers/ide/Config.in	2004-05-22 23:30:37 +03:00
> +++ edited/drivers/ide/Config.in	2004-07-19 13:58:33 +03:00
> @@ -27,8 +27,10 @@
> 
>     comment 'IDE chipset support/bugfixes'
>     if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
> -      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
> -      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
> +      dep_tristate '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
> +      if [ "$CONFIG_BLK_DEV_CMD640" != "n" ]; then
> +         bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED
> +      fi
>        dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
>        if [ "$CONFIG_PCI" = "y" ]; then
>  	 bool '  PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
