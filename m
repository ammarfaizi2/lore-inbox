Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSHAOON>; Thu, 1 Aug 2002 10:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSHAOON>; Thu, 1 Aug 2002 10:14:13 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:59335 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S313190AbSHAOOM>; Thu, 1 Aug 2002 10:14:12 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A664702CD66AB@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: linux-kernel@vger.kernel.org
Subject: hang in 2.4.18 with CONFIG_SERIAL=m (?)
Date: Thu, 1 Aug 2002 07:17:45 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hoping that someone has seen this before and can help me understand why
this happens.  

FAILING CONFIGURATION:
kernel 2.4.18
CONFIG_SERIAL=m
CONFIG_SCSI_AIC7XXX=m

WORKING CONFIGURATION:
kernel 2.4.18
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SCSI_AIC7XXX=m

The boot disk is SCSI, attached to the aic7xxx, and the initrd.img contains
aic7xxx.  The hardware (arch=i386) supports two on-board aic7899 channels,
and two on-board serial ports.  
com1 = IRQ 4, IOAddr  3F8
com2 = IRQ 3, IOAddr  2F8
aic1 = IRQ 7, IOAddr 2400
aic2 = IRQ 9, IOAddr 2000

Failure symptoms:
System hangs during boot, fails to insmod aic7xxx.  
By inserting some printk's in the driver, it is found that:
The hang occurs when the MMIO physical address for the second channel is 
mapped into the kernel space by using ioremap. And in the ioremap, the hang 
really happens when the inline function flush_tlb_all() is called.
I did try applying the free_pgtables tlb patch, and it still happens.
It is also found that only this only affects the MMIO approach of the
driver. 
If the driver is built with MMIO disabled, it works fine. 

If the failing configuration is modified to set CONFIG_SERIAL=y, the normal
aic7xxx with MMIO comes up fine.  

Could there be some kind of IO space conflict between SERIAL=m and SCSI?

Andy Cress
