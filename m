Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266314AbUGPDY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUGPDY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 23:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266317AbUGPDY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 23:24:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5530 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266314AbUGPDYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 23:24:25 -0400
Subject: Re: Losing interrupts
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, sbenno@gardena.net
In-Reply-To: <1089843559.22841.8.camel@mindpipe>
References: <1089843559.22841.8.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1089948269.24832.36.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Jul 2004 23:24:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 18:19, Lee Revell wrote:
> It seems that interrupts are being disabled for long periods, resulting
> in the soundcard interrupt being lost.  I hacked the ALSA emu10k1 driver
> to keep track in the interrupt handler of the number of CPU cycles
> elapsed since the last time it ran.  I am using a period that
> corresponds to 666 microseconds between interrupts, or ~400000 cycles on
> my 600Mhz CPU.  As you can see the average jitter is *extremely* low -
> 50-400 CPU cycles of per interrupt.  I hardcoded it to printk if the
> jitter is more than 15000 (only happens every 5-10 seconds), and error
> if it's really big.  As you can see, something is disabling interrupts
> for a long time.  This is a completely different issue from an XRUN,
> improving the scheduler latency will not solve this.

The problem is with the video driver (Via CastleRock integrated,
AGP4x).  By dragging a window in X more quickly than the machine can
keep up with, I can reliably cause interrupts to be completely disabled
for tens or hundreds of milliseconds.

There was an issue several years ago where Matrox figured out they could
get slightly better benchmark scores by not checking whether a FIFO on
the video card was full before writing to it, which would cause the PCI
bus to completely freeze until the FIFO had drained.  Lots of vendors
followed suit until one of the audio software vendors figred it out and
called them on it, at which point they fixed their drivers.  The effects
(massive audio drouputs) and the steps to reproduce (drag a window
around the screen) were identical.

Is it possible for the XFree86 DRI module to cause this, or would it
have to be in the kernel?

Here is the lspci output:

0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics (rev 03) (prog-if 00 [VGA])
        Subsystem: VIA Technologies, Inc. VT8623 [Apollo CLE266] integrated CastleRock graphics
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

Lee

