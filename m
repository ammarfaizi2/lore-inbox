Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267661AbUIOWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267661AbUIOWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267657AbUIOWYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:24:05 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:57534 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267650AbUIOWWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:22:01 -0400
Date: Wed, 15 Sep 2004 15:21:57 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
Message-ID: <20040915222157.GA17284@plexity.net>
Reply-To: dsaxena@plexity.net
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org> <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 15 2004, at 09:30, Linus Torvalds was caught saying:
> At the same time, we've had the proper "accessor" functions (read[bwl](), 
> write[bwl]() and friends) that on purpose dropped all type information 
> from the MMIO pointer, mostly just because of historical reasons, and as a 
> result some drivers didn't use a pointer at all, but some kind of integer. 
> Sometimes even one that couldn't _fit_ a MMIO address in it on a 64-bit 
> machine.

Linus,

Since we are on the subject of io-access, I would like a
clarification/opinion on the read*/write* & in*/out* accessors 
(and now the ioread/write equivalents). Are these functions only meant 
to be used for PCI memory-mapped devices or _any_ memory mapped devices? 
Same with ioremap(). I ask because there are bits of code in the
kernel that use these on non-PCI devices and this sometimes causes 
some complication in platform-level code. For example, b/c of
the way PCI access work on the IXP4xx (indirect access via register
read/writes), we have to do the following to differentiate b/w
PCI and non-PCI devices (include/asm-arm/arch-ixp4xx/io.h):

static inline void *
__ixp4xx_ioremap(unsigned long addr, size_t size, unsigned long flags, unsigned long align)
{
	extern void * __ioremap(unsigned long, size_t, unsigned long, unsigned long);
	if((addr < 0x48000000) || (addr > 0x4fffffff))
		return __ioremap(addr, size, flags, align);

	return (void *)addr;
}

static inline void 
__ixp4xx_writeb(u8 value, u32 addr)
{
	u32 n, byte_enables, data;

	if (addr >= VMALLOC_START) {
		__raw_writeb(value, addr);
		return;
	}

	n = addr % 4;
	byte_enables = (0xf & ~BIT(n)) << IXP4XX_PCI_NP_CBE_BESL;
	data = value << (8*n);
	ixp4xx_pci_write(addr, byte_enables | NP_CMD_MEMWRITE, data);
}

#define	writeb(p, v)			__ixp4xx_writeb(p, v)

(0x48000000 -> 0x4fffffff is the PCI memory window on this CPU).

While this is not a huge level of uglyness, I have systems where 
this is going to get much uglier b/c we have overlapping addresses
on different buses and we need to be able to differentiate accesses
It raises the question of whether we need a different interface 
for non-PCI devices, if we should be passing a struct device into all 
the I/O accessors functions to make it easier for platform code to 
determine what to do, or if we should make I/O access functions a 
property of devices. So instead of doing read*/write/in*/out*, we 
would do either:

a) pass device into io-access routines:

	cookie = iomap(dev, foo, len);
	bar = read32(dev, cookie + offset);

or

b) make access routines a function of the devices themselves

	cookie = dev->iomap(foo, len);
	bar = dev->read32(cookie + REG_OFFSET);

The former is nicer b/c it allows the dev to be ignored on systems where
we do not care about PCI vs non-PCI devices.

Comments?

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
