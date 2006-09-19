Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWISGj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWISGj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbWISGj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:39:56 -0400
Received: from mx1.suse.de ([195.135.220.2]:17113 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750795AbWISGj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:39:56 -0400
From: Andi Kleen <ak@suse.de>
To: Robin Lee Powell <rlpowell@digitalkingdom.org>
Subject: Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM
Date: Tue, 19 Sep 2006 08:39:51 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060912223258.GM4612@chain.digitalkingdom.org> <200609190804.14786.ak@suse.de> <20060919062828.GD7845@chain.digitalkingdom.org>
In-Reply-To: <20060919062828.GD7845@chain.digitalkingdom.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609190839.51123.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 September 2006 08:28, Robin Lee Powell wrote:
> On Tue, Sep 19, 2006 at 08:04:14AM +0200, Andi Kleen wrote:
> > 
> > > Done; it's at
> > > http://teddyb.org/~rlpowell/media/regular/lkml/hacked-boot.txt
> > > 
> > > Note that I had to us "mce=off acpi=off pci=conf1" to get any of
> > > that hack's output to show up at all; I wasn't clear whether you
> > > intended that or not.
> > 
> > Unfortunately with mce=off we can't see which device breaks. Can
> > you please boot with the patch and just 
> > 
> > acpi=off pci=conf1 ? 
> > 
> > and send the full output?
> 
> The result is a reboot in the middle of bringing up CPU#1.  No
> output from the patch is printed.
> 
> I've printed it below anyways.


What happens when you additionally add this patch and boot with
the same options again? 

-Andi


diff -u linux-2.6.17-hack/include/asm-x86_64/pci-direct.h-o linux-2.6.17-hack/include/asm-x86_64/pci-direct.h
--- linux-2.6.17-hack/include/asm-x86_64/pci-direct.h-o	2006-03-03 08:14:00.000000000 +0100
+++ linux-2.6.17-hack/include/asm-x86_64/pci-direct.h	2006-09-19 08:38:25.000000000 +0200
@@ -7,33 +7,32 @@
 /* Direct PCI access. This is used for PCI accesses in early boot before
    the PCI subsystem works. */ 
 
-#define PDprintk(x...)
+#define PDprintk(x...) printk(x)
 
 static inline u32 read_pci_config(u8 bus, u8 slot, u8 func, u8 offset)
 {
 	u32 v; 
+	PDprintk("%x reading 4 from %x: %x\n", slot, offset, v);
 	outl(0x80000000 | (bus<<16) | (slot<<11) | (func<<8) | offset, 0xcf8);
 	v = inl(0xcfc); 
-	if (v != 0xffffffff)
-		PDprintk("%x reading 4 from %x: %x\n", slot, offset, v);
 	return v;
 }
 
 static inline u8 read_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset)
 {
 	u8 v; 
+	PDprintk("%x reading 1 from %x: %x\n", slot, offset, v);
 	outl(0x80000000 | (bus<<16) | (slot<<11) | (func<<8) | offset, 0xcf8);
 	v = inb(0xcfc + (offset&3)); 
-	PDprintk("%x reading 1 from %x: %x\n", slot, offset, v);
 	return v;
 }
 
 static inline u16 read_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset)
 {
 	u16 v; 
+	PDprintk("%x reading 2 from %x: %x\n", slot, offset, v);
 	outl(0x80000000 | (bus<<16) | (slot<<11) | (func<<8) | offset, 0xcf8);
 	v = inw(0xcfc + (offset&2)); 
-	PDprintk("%x reading 2 from %x: %x\n", slot, offset, v);
 	return v;
 }
 
