Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUEVAQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUEVAQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265497AbUEVANo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:13:44 -0400
Received: from magic.adaptec.com ([216.52.22.17]:12745 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S264596AbUEVAKT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 20:10:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] 2.4.27-pre3: SCSI ips compile error
Date: Thu, 20 May 2004 09:50:42 -0400
Message-ID: <A121ABA5B472B74EB59076B8E3C8F0192AA469@rtpe2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] 2.4.27-pre3: SCSI ips compile error
Thread-Index: AcQ+cNL4BxeQJuUZQS6J/T9Znubk0wAAFJDQ
From: "IpsLinux" <ipslinux@adaptec.com>
To: "Adrian Bunk" <bunk@fs.tum.de>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adaptec had already discovered this error also and were in the process
of testing an update.
I concur with this change.

Jack 


-----Original Message-----
From: Adrian Bunk [mailto:bunk@fs.tum.de] 
Sent: Thursday, May 20, 2004 9:46 AM
To: Marcelo Tosatti; IpsLinux
Cc: linux-kernel@vger.kernel.org; linux-scsi@vger.kernel.org
Subject: [patch] 2.4.27-pre3: SCSI ips compile error

On Tue, May 18, 2004 at 05:30:40PM -0300, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.27-pre2 to v2.4.27-pre3  
>============================================
>...
> Jack Hammer:
>   o ServeRAID driver update to 7.00.15: sync with v2.6 ...

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
/home/bunk/linux/kernel-2.4/linux-2.4.27-pre3-full/include/linux/interru
pt.h:16: 
error: `irqreturn_t' previously declared here
make[3]: *** [ips.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.27-pre3-full/drivers/scsi'

<--  snip  -->


irqreturn_t was added to interrupt.h in 2.4.23, released nearly
6 months (!) ago.

Trivial fix below.

cu
Adrian



--- linux-2.4.27-pre3-full/drivers/scsi/ips.h.old	2004-05-19
21:40:58.000000000 +0200
+++ linux-2.4.27-pre3-full/drivers/scsi/ips.h	2004-05-19
21:42:01.000000000 +0200
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
       #define IPS_REGISTER_HOSTS(SHT)
scsi_register_module(MODULE_SCSI_HA,SHT)
       #define IPS_UNREGISTER_HOSTS(SHT)
scsi_unregister_module(MODULE_SCSI_HA,SHT)
       #define IPS_ADD_HOST(shost,device)
