Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTJGL7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTJGL7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:59:50 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:38056 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262283AbTJGL7s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:59:48 -0400
Importance: Normal
MIME-Version: 1.0
Sensitivity: 
To: linux-kernel@vger.kernel.org
Subject: [RFC][Patch 2.6.0-test6] Console hack change
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Message-ID: <OFD907F10C.295DFF84-ONC1256DB8.003BDCEE-C1256DB8.0041E1F8@de.ibm.com>
Date: Tue, 7 Oct 2003 13:59:38 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 07/10/2003 13:59:41,
	Serialize complete at 07/10/2003 13:59:41
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.0-test6 and spinlock  debugging I get the following debug 
message:

Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:63
in_atomic():0, irqs_disabled():1
000000000032db68 0000000000352d50 0000000000352d75 000000000027fee8
       0000000000036f8a 000000000032da78 0000000040000000 0000000000000000
       00000000002d2a20 0000000000373180 0000000000000000 000000000032db68
       00000000002cf9e0 000000000027ff00 00000000000176fa 000000000032dac8
       0000000014b52a02 0000000014b52200 04000000002d9a20 04000000002d9a20
Call Trace:
 [<00000000000332fc>] __might_sleep+0xd0/0xe0
 [<0000000000037030>] acquire_console_sem+0x54/0xb0
 [<00000000000373e4>] register_console+0xc0/0x22c
 [<000000000033b836>] sclp_console_init+0x152/0x16c
 [<000000000033838c>] console_init+0x54/0x64
 [<000000000032e7c6>] start_kernel+0xfe/0x224
 [<0000000000011046>] _pend+0x46/0xa0

Reason is, that console_init is called before IRQs are enabled.
This patch fixes the situation for me, but I am not sure, if it is the 
right approach:

--- /tmp/linux-2.5/init/main.c  2003-09-29 13:30:46.000000000 +0200
+++ init/main.c 2003-10-07 12:57:24.439243533 +0200
@@ -416,9 +416,9 @@
         * we've done PCI setups etc, and console_init() must be aware of
         * this. But we do want output early, in case something goes 
wrong.
         */
+       local_irq_enable();
        console_init();
        profile_init();
-       local_irq_enable();
 #ifdef CONFIG_BLK_DEV_INITRD
        if (initrd_start && !initrd_below_start_ok &&
                        initrd_start < min_low_pfn << PAGE_SHIFT) {

Does somebody have an idea if this is the proper solution for the debug 
message above?

cheers

-- 
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49  7031 16 1975

