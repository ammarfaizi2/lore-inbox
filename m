Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266450AbUF3Fef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266450AbUF3Fef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 01:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUF3Fef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 01:34:35 -0400
Received: from acrogw.sw.ru ([195.133.213.225]:20460 "EHLO dhcp6-7.acronis.ru")
	by vger.kernel.org with ESMTP id S266450AbUF3Fed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 01:34:33 -0400
Date: Wed, 30 Jun 2004 09:39:56 +0400
From: Andrey Ulanov <Andrey.Ulanov@acronis.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCMCIA bug fix
Message-ID: <20040630053956.GA1942@dhcp6-7.acronis.ru>
References: <20040629153809.GA6531@dhcp6-7.acronis.ru> <20040629164832.C24951@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040629164832.C24951@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Russell!

On Tue, Jun 29, 2004 at 04:48:32PM +0100, Russell King wrote:
> On Tue, Jun 29, 2004 at 07:38:09PM +0400, Andrey Ulanov wrote:
>> I tested with one of ieee1394+usb2.0 PCMCIA adapters. Worked fine.
>> Without this patch only first device (ieee1394 controller) was
>> detected.
> Can you provide the lspci output, and a better description of the
> problem you're trying to solve please?

OK. Sorry.

This PCMCIA has four devices:

  Bus  6, device   0, function  0:
    Class 0c00: PCI device 104c:8024 (rev 0).
      IRQ 10.
      Master Capable.  Latency=16.  
      Non-prefetchable 32 bit memory at 0x11000000 [0x110007ff].
      Non-prefetchable 32 bit memory at 0x11004000 [0x11007fff].
  Bus  6, device   0, function  4:
    Class 0c03: PCI device 104c:0035 (rev 67).
      IRQ 10.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0x11001000 [0x11001fff].
  Bus  6, device   0, function  5:
    Class 0c03: PCI device 104c:0035 (rev 67).
      IRQ 10.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0x11002000 [0x11002fff].
  Bus  6, device   0, function  6:
    Class 0c03: PCI device 104c:00e0 (rev 4).
      IRQ 10.
      Master Capable.  Latency=68.  
      Non-prefetchable 32 bit memory at 0x11000800 [0x110008ff].

As you can see functions numbers do not form continual sequence
beginning with zero. That's why current implementation do not work for
me. Here is the part of old code:

fn = 1;
if (hdr & 0x80) {
  do {
    tmp.devfn = fn;
    if (pci_readw(&tmp, PCI_VENDOR_ID, &v) || !v || v == 0xffff)
      break;
    fn++;
  } while (fn < 8);
}
s->functions = fn;

I hope now it is obvious that it detects only first one in my case.

-- 
with best regards, Andrey Ulanov.
