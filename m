Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262931AbVA2Pyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbVA2Pyd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 10:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVA2Pyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 10:54:32 -0500
Received: from cantor.suse.de ([195.135.220.2]:58298 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262931AbVA2Pxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 10:53:48 -0500
Date: Sat, 29 Jan 2005 16:53:44 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: Add support for Pegasos machines
Message-ID: <20050129155344.GA9832@suse.de>
References: <200501260514.j0Q5E5iq017078@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200501260514.j0Q5E5iq017078@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 26, Linux Kernel Mailing List wrote:

> ChangeSet 1.2046, 2005/01/25 20:33:08-08:00, benh@kernel.crashing.org
> 
> 	[PATCH] ppc32: Add support for Pegasos machines
> 	
> 	This patch, mostly from Sven Luther and reworked by me, adds support for
> 	Pegasos machines to the ppc32 arch. The patch contains all of the arch
> 	code. I'll send separately a few driver changes as well.
> 	
> 	Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  arch/ppc/platforms/chrp_pci.c   |   38 +++++++++++++++++---

> diff -Nru a/arch/ppc/platforms/chrp_pci.c b/arch/ppc/platforms/chrp_pci.c
> --- a/arch/ppc/platforms/chrp_pci.c	2005-01-25 21:14:21 -08:00
> +++ b/arch/ppc/platforms/chrp_pci.c	2005-01-25 21:14:21 -08:00
> @@ -195,7 +215,7 @@
>  	struct pci_controller *hose;
>  	unsigned int *dma;
>  	char *model, *machine;
> -	int is_longtrail = 0, is_mot = 0;
> +	int is_longtrail = 0, is_mot = 0, is_pegasos = 0;
>  	struct device_node *root = find_path_device("/");
>  
>  	/*
> @@ -207,6 +227,10 @@
>  	if (machine != NULL) {
>  		is_longtrail = strncmp(machine, "IBM,LongTrail", 13) == 0;
>  		is_mot = strncmp(machine, "MOT", 3) == 0;
> +		if (strncmp(machine, "Pegasos2", 8) == 0)
> +			is_pegasos = 2;
> +		else if (strncmp(machine, "Pegasos", 7) == 0)
> +			is_pegasos = 1;
>  	}
>  	for (dev = root->child; dev != NULL; dev = dev->sibling) {
>  		if (dev->type == NULL || strcmp(dev->type, "pci") != 0)
> @@ -275,5 +303,7 @@
>  		}
>  	}
>  
> -	ppc_md.pcibios_fixup = chrp_pcibios_fixup;
> +	/* Do not fixup interrupts from OF tree on pegasos */
> +	if (is_pegasos != 0)
> +		ppc_md.pcibios_fixup = chrp_pcibios_fixup;
>  }

This breaks other chrp boards, like a B50.

PCI: Enabling device 0000:00:10.0 (0140 -> 0143)
sym0: <875> rev 0x4 at pci 0000:00:10.0 irq 7
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18n
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT operation timed-out.
sym0:0:0: DEVICE RESET operation started.
sym0:0:0: DEVICE RESET operation timed-out.
sym0:0:0: BUS RESET operation started.
sym0:0:0: BUS RESET operation timed-out.
sym0:0:0: HOST RESET operation started.
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0xc02a0000, data=0x28000028
Call trace:
 [c0028028] check_timer_failed+0x7c/0x9c
 [c0028074] del_timer+0x2c/0xb0
 [c0111c68] __sym_eh_done+0x8c/0x98
 [c0110654] sym_xpt_done+0x2c/0x40
 [c0117930] sym_flush_comp_queue+0x160/0x190
 [c0117fd0] sym_start_up+0x194/0x7d8
 [c0111994] sym_eh_handler+0x1bc/0x2d0
 [c0107644] scsi_try_host_reset+0x8c/0x104
 [c0108ac0] scsi_error_handler+0x8c0/0xe68
 [c0006e14] kernel_thread+0x44/0x60
sym0: SCSI BUS has been reset.
sym0:0:0: HOST RESET operation timed-out.
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0


Signed-off-by: Olaf Hering <olh@suse.de>

--- ./arch/ppc/platforms/chrp_pci.c~	2005-01-29 16:22:09.288047704 +0100
+++ ./arch/ppc/platforms/chrp_pci.c	2005-01-29 16:44:03.905193820 +0100
@@ -304,6 +304,6 @@
 	}
 
 	/* Do not fixup interrupts from OF tree on pegasos */
-	if (is_pegasos != 0)
+	if (!is_pegasos)
 		ppc_md.pcibios_fixup = chrp_pcibios_fixup;
 }
