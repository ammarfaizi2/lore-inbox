Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTFKTIY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTFKTIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:08:24 -0400
Received: from u212-239-189-116.adsl.pi.be ([212.239.189.116]:14601 "EHLO
	italy.lashout.net") by vger.kernel.org with ESMTP id S264061AbTFKTIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:08:22 -0400
Subject: Re: siI3112 crash on enabling dma
From: Adriaan Peeters <apeeters@lashout.net>
Reply-To: apeeters@lashout.net
To: Justin Cormack <justin@street-vision.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1055276951.2046.5.camel@lotte>
References: <1054929160.1793.121.camel@localhost>
	 <1055261120.28365.40.camel@localhost>  <1055276951.2046.5.camel@lotte>
Content-Type: text/plain
Organization: 
Message-Id: <1055359316.28365.317.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 21:21:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 22:29, Justin Cormack wrote:

> I got severe filesystem corruption on an Sii3112 system (Supermicro
> E7505 with 2 onboard SiI3112) but I later memtested the machine and
> found bad ram, so I dont think it is a valid example of corruption.
> However I am still slightly suspicious. Did you have 

The memory is stable, no problems in memtest.

> echo "max_kb_per_request:15" > /proc/ide/hdXX/settings
> set for the relevant drives? This is a known bug (I didnt have this
> either, another reason why this is not a valid datapoint...)

These were not set when the error occured. I found this option after the
crash somewhere on the net, but I can't find any references to it on
google at the moment :( Can it cause that severe filesystem corruption ?

Was DMA enabled on your system, and what drives did you use ?

I tested several firmware revisions, disabled mmio in the driver,
nothing helped. No DMA at boot, and the crash is easy to reproduce, for
example:

console1: dd if=/dev/hda of=/dev/null
console2: hdparm -X66 -d1 /dev/hda

result without max_kb_per_request:
---
/dev/hda:
 setting using_dma to 1 (on)
blk: queue c0468b00, I/O limit 4095Mb (mask 0xffffffff)
 setting xfermode to 66 (UltraDMA mode2)
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hda: dma_intr: status=0xd0 { Busy }

hda: DMA disabled
--

result with max_kb_per_request:
---
/dev/hda:
 setting using_dma to 1 (on)
blk: queue c0468b00, I/O limit 4095Mb (mask 0xffffffff)
 setting xfermode to 66 (UltraDMA mode2)
hda: dma_timer_expiry: dma status = 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
--

The system hangs and nothing is written to syslog.

I don't know where to look next.

-- 
Adriaan Peeters <apeeters@lashout.net>

