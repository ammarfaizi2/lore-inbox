Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUFTQrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUFTQrT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 12:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUFTQrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 12:47:19 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:40639 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264561AbUFTQrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 12:47:16 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: rmk+lkml@arm.linux.org.uk, david-b@pacbell.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
In-Reply-To: <20040620165042.393f2756.spyro@f2s.com>
References: <1087584769.2134.119.camel@mulgrave>
	<20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net>
	<20040618204438.35278560.spyro@f2s.com> <1087588627.2134.155.camel@mulgrave
	<40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave>
	<40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave>
	<40D4849B.3070001@pacbell.net>
	<20040619214126.C8063@flint.arm.linux.org.uk>
	<1087681604.2121.96.camel@mulgrave> <20040619234933.214b810b.spyro@f2s.com>
	<1087738680.10858.5.camel@mulgrave>  <20040620165042.393f2756.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Jun 2004 11:46:53 -0500
Message-Id: <1087750024.11222.81.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-20 at 10:50, Ian Molton wrote:
> Those two statements are contradictory. clearly the iseries cant use the
> DMA API *now* so I dont see how that makes any difference. We're talking
> about adding propper support for *addresssable* memory mapped devices
> with limited size DMA-able windows to the DMA API, not adding support
> for a whole new weird way of talking to devices. These devices work the
> same way as all the other devices that use the DMA API but are simply
> restricted in the range of addresses they can DMA from. they require no
> special 'accessors'.
> 
> iseries cant work the usual way now and wont with these modifications -
> so nothing is made worse.

OK, let's try and make this as simple as I know how.  The system looks
like this


       +-----+
       | CPU |
       +--+--+
          |
    <-----+-----+----------------------+-----> Central Bus
                |                      |
          +-----+------+        +------+-----+
          |   Memory   |        |    I/O     |
          | Controller |        | Controller |
          +-----+------+        +------+-----+
                |                      |
            +---+-----+             +--+---+    +--------+
            | Memory  |             | OHCI |----| Memory |
            +---------+             +------+    +--------+

In order to access this OHCI memory, both the I/O controller and the
OHCI have to respond to the memory access cycles, rather than the memory
controller.  This is why such memory is termed "bus remote".

Even though ARM can programm the I/O controller and the OHCI device to
access this memory as though it were behind the memory controller (i.e.
using normal CPU memory cycles), you'll find that even on ARM there's
probably special page table trickery involved (probably to do with cache
coherency issues).  Next, you'll find that no other device can see this
memory without some type of i2o support, so it can't be the target of a
DMA transaction. So even on ARM, you can't treat it as "normal" memory.

On iSeries, the I/O controller sits behind the hypervisor and can't be
the target of normal memory cycles, that's why the CPU can't address
this bus remote memory normally. As I've explained.

The DMA API is about allowing devices to transact directly with memory
behind the memory controller, it's an API that essentially allows the
I/O controller and memory controller to communicate without CPU
intervention.  This is still possible through the hypervisor, so the
iSeries currently fully implements the DMA API.

James


