Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267598AbUG2Q2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267598AbUG2Q2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUG2Q1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:27:43 -0400
Received: from the-village.bc.nu ([81.2.110.252]:18332 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267601AbUG2QV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:21:59 -0400
Subject: Incorrect patch merged (Fwd: [PATCH] fdomain_cs needs ISA])
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, akpm@osdl.org, pluto@pld-linux.org,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091114358.987.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 29 Jul 2004 16:19:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fdomain_cs only needs PCMCIA, PCMCIA _is_ ISA bus with wrappers. The
problem arises because the driver uses isa_readb not ioremap when doing
bios scans that are only in the non PCMCIA code path. This broken patch
breaks fdomain_cs on platforms that it supports just fine.

The real fix is 

--- drivers/scsi/fdomain.c~	2004-07-29 17:17:10.133762816 +0100
+++ drivers/scsi/fdomain.c	2004-07-29 17:17:10.133762816 +0100
@@ -681,6 +681,7 @@
 
 static int fdomain_isa_detect( int *irq, int *iobase )
 {
+#ifndef PCMCIA
    int i, j;
    int base = 0xdeadbeef;
    int flag = 0;
@@ -786,6 +787,9 @@
    *iobase = base;
 
    return 1;			/* success */
+#else
+   return 0;
+#endif   
 }
 
 /* PCI detection function: int fdomain_pci_bios_detect(int* irq, int*


-----Forwarded Message-----
> From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> To: bk-commits-head@vger.kernel.org
> Subject: [PATCH] fdomain_cs needs ISA
> Date: Thu, 29 Jul 2004 06:02:05 +0000
> 
> ChangeSet 1.1844, 2004/07/28 23:02:05-07:00, pluto@pld-linux.org
> 
> 	[PATCH] fdomain_cs needs ISA
> 	
> 	drivers/scsi/pcmcia/fdomain_cs.ko needs unknown symbol isa_memcpy_fromio
> 	drivers/scsi/pcmcia/fdomain_cs.ko needs unknown symbol isa_readb
> 	
> 	iirc the isa bus isn't available on ppc.
> 	
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff -Nru a/drivers/scsi/pcmcia/Kconfig b/drivers/scsi/pcmcia/Kconfig
> --- a/drivers/scsi/pcmcia/Kconfig	2004-07-29 00:17:32 -07:00
> +++ b/drivers/scsi/pcmcia/Kconfig	2004-07-29 00:17:32 -07:00
> @@ -17,7 +17,7 @@
>  
>  config PCMCIA_FDOMAIN
>  	tristate "Future Domain PCMCIA support"
> -	depends on m
> +	depends on m && ISA
>  	help
>  	  Say Y here if you intend to attach this type of PCMCIA SCSI host
>  	  adapter to your computer.
> -
> To unsubscribe from this list: send the line "unsubscribe bk-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
