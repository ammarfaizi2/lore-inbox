Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266509AbUHZFsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUHZFsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 01:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267664AbUHZFsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 01:48:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:21165 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266509AbUHZFsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 01:48:11 -0400
Date: Thu, 26 Aug 2004 07:48:09 +0200 (CEST)
From: Bernhard Kaindl <bk@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Cardbus card memory assignment on x86_64 (if base==maxbase)
Message-ID: <Pine.LNX.4.61.0408241923570.30921@jbgna.fhfr.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-692825366-1093499289=:21180"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-692825366-1093499289=:21180
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi,
    I've sent the patch below to Ivan Kokshaysky (bk login: ink) and got
a mail from him back that I should forward it and telling that it looks
correct. According to bitkeeper logs for 2.4 he initially did the pci_size
function this patch is about.

I've debugged a memory assignment problem which happens even with 2.6.8.1
on Amilo Laptops from Siemens Fujitsu with a RT2500 CardBus card.

The problem was that the PCI scan didn't report a memory range for the
card and thus the driver finally complained about not beind able to remap
the memory.

After plaching a dump_stack() into bus_add_device() to know thich 
functions were really involved, I worked my way forward into the PCI 
code.

Enabling the debug statement in the PCI code, I've found pci_setup_device().
>From there I added more printk's. Ultimatively, I've found that pci_size()
returned 0 for the memory size at this place in drivers/pci/probe.c:

  sz = pci_size(l, sz, PCI_BASE_ADDRESS_MEM_MASK);
  if (!sz)
     continue;

Here is the pci_size():

/*
  * Find the extent of a PCI decode..
  */
static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
{
    u32 size = mask & maxbase;      /* Find the significant bits */
    if (!size)
       return 0;

    /* Get the lowest of them to find the decode size, and
    from that the extent.  */
    size = (size & ~(size-1)) - 1;

    /* base == maxbase can be valid only if the BAR has
    already been programmed with all 1s.  */
    if (base == maxbase && ((base | size) & mask) != mask)
       return 0;

    return size;
}

Adding the results of my debug, it's called like this - for my card:
pci_size(u32 base = ffffe000, maxbase = ffffe000, mask = fffffffffffffff0)

Finally the CPU reaches this line:
if (base == maxbase && ((base | size) & mask) != mask)
  return 0;

With the values from my debug printks, it looks like this:

if (ffffe000 == ffffe000
  && ((ffffe000 | 1fff) & fffffffffffffff0) != fffffffffffffff0)

Evaluation of the if:

   1): ffffe000 == ffffe000 is true

   2): (ffffe000 | 1fff) & fffffffffffffff0)  results in fffffff0

   but this means 2) will always != fffffffffffffff0.
                                     (it's a large #defined mask)

It can never be equal, because "(base | size) & mask)" (base and size 32bit)
- the result of ((32-bit | 32-bit) & 64-bit)) can never match a large 64-bit
value such as fffffffffffffff0.

So, on 64-bit, calls to

      static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)

with base == maxbase and mask = ~0x0fUL will always result in
return 0.

I think that's the bug here, this function is intented to work
on 32-bit PCI values.

PCI64 is handled in a separate way, in pci_read_bases(), just a few
lines after pci_size() is called:

#if BITS_PER_LONG == 64
  res->start |= ((unsigned long) l) << 32;
  res->end = res->start + sz;
  pci_write_config_dword(dev, reg+4, ~0);
  pci_read_config_dword(dev, reg+4, &sz);
  pci_write_config_dword(dev, reg+4, l);
  if (~sz)
         res->end = res->start + 0xffffffff +
 				 (((unsigned long) ~sz) << 32);

I believe, pci_size() should work with 32-bit vaules
only and I've tested that the diff of

-static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
+static u32 pci_size(u32 base, u32 maxbase, u32 mask)

makes my card's memory appear as it does in a 32-bit kernel where mask
is a 32-bit value too.

It seems to be really a corner case, I don't know if many other
Cards provide such PCI config space where base == maxbase,
but there could be some others out there as well.

For these cards, the above diff fixes the memory assignment problem.

I hope this mail helps some of you, the patch is attached, I'll forward
this to the kernel maintainers.

Bernhard
--8323584-692825366-1093499289=:21180
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pci-probe-64bits.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0408260748090.21180@jbgna.fhfr.qr>
Content-Description: 
Content-Disposition: attachment; filename="pci-probe-64bits.diff"

LS0tIGRyaXZlcnMvcGNpL3Byb2JlLmMJMjAwNC8wOC8yMyAxNDozNjowNAkx
LjENCisrKyBkcml2ZXJzL3BjaS9wcm9iZS5jCTIwMDQvMDgvMjMgMTQ6MzY6
MjENCkBAIC04Miw3ICs4Miw3IEBADQogLyoNCiAgKiBGaW5kIHRoZSBleHRl
bnQgb2YgYSBQQ0kgZGVjb2RlLi4NCiAgKi8NCi1zdGF0aWMgdTMyIHBjaV9z
aXplKHUzMiBiYXNlLCB1MzIgbWF4YmFzZSwgdW5zaWduZWQgbG9uZyBtYXNr
KQ0KK3N0YXRpYyB1MzIgcGNpX3NpemUodTMyIGJhc2UsIHUzMiBtYXhiYXNl
LCB1MzIgbWFzaykNCiB7DQogCXUzMiBzaXplID0gbWFzayAmIG1heGJhc2U7
CS8qIEZpbmQgdGhlIHNpZ25pZmljYW50IGJpdHMgKi8NCiAJaWYgKCFzaXpl
KQ0K

--8323584-692825366-1093499289=:21180--
