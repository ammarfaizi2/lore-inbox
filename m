Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265113AbUEVBwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUEVBwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbUEVBtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 21:49:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36350 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264804AbUEVBqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:46:18 -0400
Date: Thu, 20 May 2004 15:46:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, ipslinux@adaptec.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch] 2.4.27-pre3: SCSI ips compile error
Message-ID: <20040520134604.GL24287@fs.tum.de>
References: <20040518203039.GA9970@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518203039.GA9970@logos.cnet>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 05:30:40PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.27-pre2 to v2.4.27-pre3
> ============================================
>...
> Jack Hammer:
>   o ServeRAID driver update to 7.00.15: sync with v2.6
>...

It was nice if people would actually test at least the compilation of
their changes instead of blindly submitting the latest version of a
driver...

<--  snip  -->

...
gcc -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.27-pre3-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon   
-nostdinc -iwithprefix include -DKBUILD_BASENAME=ips  -c -o ips.o ips.c
In file included from ips.c:180:
ips.h:99: error: redefinition of `irqreturn_t'
/home/bunk/linux/kernel-2.4/linux-2.4.27-pre3-full/include/linux/interrupt.h:16: 
error: `irqreturn_t' previously declared here
make[3]: *** [ips.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.27-pre3-full/drivers/scsi'

<--  snip  -->


irqreturn_t was added to interrupt.h in 2.4.23, released nearly
6 months (!) ago.

Trivial fix below.

cu
Adrian



--- linux-2.4.27-pre3-full/drivers/scsi/ips.h.old	2004-05-19 21:40:58.000000000 +0200
+++ linux-2.4.27-pre3-full/drivers/scsi/ips.h	2004-05-19 21:42:01.000000000 +0200
@@ -95,11 +95,14 @@
       #define scsi_set_pci_device(sh,dev) (0)
    #endif
 
-   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,23)
       typedef void irqreturn_t;
       #define IRQ_NONE
       #define IRQ_HANDLED
       #define IRQ_RETVAL(x)
+   #endif
+
+   #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
       #define IPS_REGISTER_HOSTS(SHT)      scsi_register_module(MODULE_SCSI_HA,SHT)
       #define IPS_UNREGISTER_HOSTS(SHT)    scsi_unregister_module(MODULE_SCSI_HA,SHT)
       #define IPS_ADD_HOST(shost,device)
