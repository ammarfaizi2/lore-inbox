Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTI0J1f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 05:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbTI0J1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 05:27:35 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:24194
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262418AbTI0J1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 05:27:34 -0400
Date: Sat, 27 Sep 2003 05:27:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Eric Balsa <eric@onewest.net>
Subject: [PATCH][2.6] fix atp870u boot oops
In-Reply-To: <001701c3845e$f3e4b470$fad11341@corporate.onewest.net>
Message-ID: <Pine.LNX.4.53.0309270302110.16940@montezuma.fsmlabs.com>
References: <001701c3845e$f3e4b470$fad11341@corporate.onewest.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver's probe function accesses uninitialised data. I also made it 
use pci_get_device instead of pci_find_device to bump the refcount on the 
pci devices it finds.

> Preempt SMP
> CPU: 0
> EIP: 0060:[<02293d33>] Not tainted VLI
> EFLAGS: 00010202
> EIP is at atp870u_detect+0x18b/0x9c8
> eax: 00000000 ebx: 023e8cd4 ecx: 41fa5f7c edx: 000006f2
> esi: 00000000 edi: 00000000 ebp: 0000000e esp: 41fa5c08
> ds: 007b es: 007b ss:0068
> Process Swapper (pid: 1,threadinfo=41fa4000 task=03a57900)
> Stack: 023e8cd4 023e8c60 00000000 00000000 00000001 00000100 00000005
> 41fa5f7c
> 55789004 00000002 00000001 00000100 00000006 00060020 21789004 00000003
> 00804001 00000101 00000007 00060020 08389004 00000000 00804001 41fa5cb2
> 
> Call Trace:
> [<0243a1bb>] init_this_scsi_driver+0x4b/0xe0
> [<0242280d>] do_initcalls+0x3d/0x8c
> [<02422875>] do_basic_setup+0x19/0x24
> [<021070ef>] init+0x5b/0x15c
> [<02107094>] init+0x0/0x15c
> [<0210a991>] kernel_thread_helper+0x5/0xc

Index: linux-2.6.0-test5-mm4/drivers/scsi/atp870u.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test5-mm4/drivers/scsi/atp870u.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 atp870u.c
--- linux-2.6.0-test5-mm4/drivers/scsi/atp870u.c	25 Sep 2003 02:36:18 -0000	1.1.1.1
+++ linux-2.6.0-test5-mm4/drivers/scsi/atp870u.c	27 Sep 2003 08:42:09 -0000
@@ -2290,7 +2290,7 @@ static int atp870u_detect(Scsi_Host_Temp
 	unsigned char irq, h, k, m;
 	unsigned long flags;
 	unsigned int base_io, error, tmport;
-	struct pci_dev *pdev[MAX_ATP];
+	struct pci_dev *pdev[MAX_ATP] = { [0 ... MAX_ATP-1] = NULL };
 	unsigned char chip_ver[MAX_ATP], host_id;
 	unsigned short dev_id[MAX_ATP], n;
 	struct Scsi_Host *shpnt = NULL;
@@ -2306,8 +2306,8 @@ static int atp870u_detect(Scsi_Host_Temp
 
 	for (h = 0; devid[h]; h++) {
 		struct pci_dev *dev = NULL;
-		
-		while((dev = pci_find_device(0x1191, devid[h], dev))!=NULL)
+	
+		while((dev = pci_get_device(0x1191, devid[h], dev)))
 		{
 			if(pci_enable_device(dev))
 				continue;
