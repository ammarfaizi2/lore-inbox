Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269214AbUISKos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbUISKos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 06:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269215AbUISKos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 06:44:48 -0400
Received: from aun.it.uu.se ([130.238.12.36]:728 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269214AbUISKop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 06:44:45 -0400
Date: Sun, 19 Sep 2004 12:44:26 +0200 (MEST)
Message-Id: <200409191044.i8JAiQp9008476@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: R.E.Wolff@BitWizard.nl, akpm@osdl.org, vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: [PATCH][2.6.9-rc2] Specialix RIO driver gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2004 16:28:10 +0300, Denis Vlasenko wrote:
>On Saturday 18 September 2004 15:42, Mikael Pettersson wrote:
>> This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.6.9-rc2
>> kernel's Specialix RIO driver. This is a forward port of the fix
>> I made for the 2.4 kernel.
>> 
>> /Mikael
>> 
>> --- linux-2.6.9-rc2/drivers/char/rio/rio_linux.c.~1~	2004-03-11 14:01:27.000000000 +0100
>> +++ linux-2.6.9-rc2/drivers/char/rio/rio_linux.c	2004-09-18 14:27:33.000000000 +0200
>> @@ -1139,7 +1139,7 @@
>>        if (((1 << hp->Ivec) & rio_irqmask) == 0)
>>                hp->Ivec = 0;
>>        hp->CardP	= (struct DpRam *)
>> -      hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
>> +      (hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN));
>
>I think it's best to untangle assignments, it's easier to read this way:
>
>	hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
>	hp->CardP = (struct DpRam *) hp->Caddr;

Ok. I don't want to get into general cleanups, but this one can
easily be combined with the actual fix. Here's a revised patch:

--- linux-2.6.9-rc2/drivers/char/rio/rio_linux.c.~1~	2004-03-11 14:01:27.000000000 +0100
+++ linux-2.6.9-rc2/drivers/char/rio/rio_linux.c	2004-09-19 12:26:42.000000000 +0200
@@ -1138,8 +1138,8 @@
       hp->Ivec = pdev->irq;
       if (((1 << hp->Ivec) & rio_irqmask) == 0)
               hp->Ivec = 0;
-      hp->CardP	= (struct DpRam *)
       hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+      hp->CardP	= (struct DpRam *) hp->Caddr;
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy; 
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
@@ -1196,8 +1196,8 @@
       if (((1 << hp->Ivec) & rio_irqmask) == 0) 
       	hp->Ivec = 0;
       hp->Ivec |= 0x8000; /* Mark as non-sharable */
-      hp->CardP	= (struct DpRam *)
       hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+      hp->CardP	= (struct DpRam *) hp->Caddr;
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy;
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
@@ -1242,8 +1242,8 @@
     hp->PaddrP = rio_probe_addrs[i];
     /* There was something about the IRQs of these cards. 'Forget what.--REW */
     hp->Ivec = 0;
-    hp->CardP = (struct DpRam *)
     hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+    hp->CardP = (struct DpRam *) hp->Caddr;
     hp->Type = RIO_AT;
     hp->Copy = rio_pcicopy; /* AT card PCI???? - PVDL
                              * -- YES! this is now a normal copy. Only the 
