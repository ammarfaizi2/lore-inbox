Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVHNCSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVHNCSg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 22:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVHNCSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 22:18:36 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:10134 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932424AbVHNCSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 22:18:36 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Dave Jones <davej@redhat.com>
Subject: Re: IDE CD problems in 2.6.13rc6
Date: Sun, 14 Aug 2005 10:30:00 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050813232957.GE3172@redhat.com> <200508141026.10734.kernel@kolivas.org>
In-Reply-To: <200508141026.10734.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508141030.00382.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2005 10:26, Con Kolivas wrote:
> On Sun, 14 Aug 2005 09:29, Dave Jones wrote:
> > I've noticed this week whilst trying to encode a bunch
> > of audio CDs to oggs that my boxes running the latest
> > kernels are having serious issues, whereas 2.6.12 seems
> > to cope just fine.
> >
> > The symptoms vary. On some of my machines just inserting
> > an audio CD makes the box instantly lock up.
> > If I boot with the same CD in the drive, sound-juicer
> > can read it just fine. When I get to the next CD, I have
> > to reboot again, or it locks up.
> >
> > On another box, it gets stuck in a loop where it
> > just prints out..
> >
> > hdc: irq timeout: status=0xd0 { Busy }    (This line sometimes has
> > status=0xc0) ide: failed opcode was: unknown
> >
> > The net result is that I've not got a single box that
> > will read audio CDs without doing something bad, and I've
> > tried it on several quite diverse systems.
> >
> >
> > I'll try and narrow down over the next few days when this
> > started happening, but IDE / CD folks may have some better
> > ideas about which changes were suspicious.
>
> Ok I just started noticing unusual things on my IDE DVD-RW as well,
> presumably related, on 2.6.13-rc6. Putting in a cd and trying to read it
> will cause huge delays and then error out with:
>
> ide-cd: cmd 0x28 timed out
> hdc: DMA timeout retry
> hdc: timeout waiting for DMA
> hdc: status timeout: status=0xd0 { Busy }
> ide: failed opcode was: unknown
> hdc: drive not ready for command
> hdc: ATAPI reset complete
>
> then it will read fine. If I start another read it goes through the same
> cycle. Forcing dma *off* with hdparm fixes the problem and all subsequent
> accesses don't have this pause, however this was never an issue on previous
> kernels with dma working fine.

> hdparm info of hdc:

>         DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

I should also point out the above *udma2 is interesting because:
hdparm /dev/hdc

/dev/hdc:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)

This *thinks* that dma is off yet querying hdc says it's in udma2 mode and the 
actual performance very much suggests to me that dma is enabled as it doesn't 
have those awful lags that dma off dvd access usually has.

Even though it apparently works fine I do get these instead though:
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec

blah...


Con
