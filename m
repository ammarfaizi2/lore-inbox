Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSGRQ6A>; Thu, 18 Jul 2002 12:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318271AbSGRQ6A>; Thu, 18 Jul 2002 12:58:00 -0400
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:33614
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S318270AbSGRQ55>; Thu, 18 Jul 2002 12:57:57 -0400
Message-Id: <200207181700.g6IH03U02415@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Dale Amon <amon@vnl.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: Re: 2.5.26 : drivers/scsi/BusLogic.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Jul 2002 12:00:02 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BusLogic.c:32: #error Please convert me to Documentation/
> DMA-mapping.txt BusLogic.c: In function `BusLogic_DetectHostAdapter':
> BusLogic.c:2841: warning: long unsigned int format,
> BusLogic_IO_Address_T arg (arg 2) BusLogic.c: In function
> `BusLogic_QueueCommand': BusLogic.c:3415: structure has no member
> named `address' BusLogic.c: In function `BusLogic_BIOSDiskParameters':
> BusLogic.c:4141: warning: implicit declaration of function
> `scsi_bios_ptable' BusLogic.c:4141: warning: assignment makes pointer
> from integer without a cast make[2]: *** [BusLogic.o] Error 1

I have a single MCA Buslogic card on my shelf.  Assuming it hasn't got bitrot, 
I may be able to look at this soon.

In the meantime, if you want to try, the trick looks to be to use 
pci_map_single in BusLogic_CreateInitialCCBs; but then set up a reverse 
mapping table for them in BusLogic_InitializeCCBs so that Bus_to_Virtual will 
still work (its only use is to convert bus physical CCB addresses into CPU 
virtual ones).

Next, in BusLogic_QueueCommand you need to use pci_map_single for non-sg 
transformations, and pci_map_sg for sg plus in the loop over segments, use the 
macros

sg_dma_address(&ScatterList[Segment]) in place of ScatterList[Segment].address
sg_dma_len(&ScatterList[Segment]) in place ofScatterList[Segment].length

Initially, don't worry about unmapping, but this should get the thing working.

There are probably other places in the driver I've missed (like sense 
buffers), but that should be the core of the necessary changes.

I'm off on holiday for 10 days, so I'll only be getting email sporadically, if 
at all.

James


