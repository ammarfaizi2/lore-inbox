Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVJFSwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVJFSwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVJFSwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:52:03 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:50516 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751298AbVJFSwB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:52:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hBidx1/wXbKd7Ptr30pzgqpIIK1s8SSsBn8cOowG4KssWKdN+Oes5g12zQMLjfuEIZp2HhLlPyEfN1Vku9E+Hv7N694/jfKF/+z5nxhlDLL/queTx8GvP6ZGCEqQnWR3BC+/u4V7VsJcP2w2SH3+57AVdFcARtmjrW94ks4uPmc=
Message-ID: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
Date: Thu, 6 Oct 2005 11:52:00 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc3-rt10 - xruns & config questions
Cc: Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I am still getting a few xruns even after raising Jack's priority
level to 80. I am wondering whether it's fair to report these when I
have  CONFIG_DEBUG_PREEMPT set?

   Should I unset this option and test for a while without it, or
shall we work on the root cause of my xruns with it set?

   The most recent xrun was caused when I:

1) Switched to desktop #4 in Gnome
2) Opened Firefox and went to Gentoo's bugzilla to report a fix had
worked. When the browser was updaing the page I heard a click in my
audio.
3) Returned to Desktop #1 wherre QJC reported an xrun:

configuring for 44100Hz, period = 128 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
11:30:45.312 Server configuration saved to "/home/mark/.jackdrc".
11:30:45.312 Statistics reset.
11:30:45.454 Client activated.
11:30:45.456 Audio connection change.
11:30:45.459 Audio connection graph change.
11:31:00.256 Audio connection graph change.
11:31:00.335 Audio connection change.
11:31:02.616 Audio connection graph change.
11:33:06.199 XRUN callback (1).
**** alsa_pcm: xrun of at least 2.545 msecs

mark@lightning ~ $ ps -Leo pid,pri,rtprio,cmd | grep jack
  7911  24      - qjackctl
  7911 119     79 qjackctl
  7913  20      - /usr/bin/jackd -R -P80 -dalsa -dhw:1 -r44100 -p128 -n2
  7913  23      - /usr/bin/jackd -R -P80 -dalsa -dhw:1 -r44100 -p128 -n2
  7913  23      - /usr/bin/jackd -R -P80 -dalsa -dhw:1 -r44100 -p128 -n2
  7913 130     90 /usr/bin/jackd -R -P80 -dalsa -dhw:1 -r44100 -p128 -n2
  7913 120     80 /usr/bin/jackd -R -P80 -dalsa -dhw:1 -r44100 -p128 -n2
 7922  24      - aqualung -o jack --auto=alsa_pcm:playback_17
alsa_pcm:playback_18
 7922  24      - aqualung -o jack --auto=alsa_pcm:playback_17
alsa_pcm:playback_18
 7922 119     79 aqualung -o jack --auto=alsa_pcm:playback_17
alsa_pcm:playback_18
 7993  21      - grep jack
mark@lightning ~ $ ps -Leo pid,pri,rtprio,cmd | grep IRQ
   15  89     49 [IRQ 9]
  798  88     48 [IRQ 8]
  801  87     47 [IRQ 7]
  805  86     46 [IRQ 12]
  815  85     45 [IRQ 6]
  850  84     44 [IRQ 14]
  867  83     43 [IRQ 225]
  872  82     42 [IRQ 233]
  887  81     41 [IRQ 50]
  893  80     40 [IRQ 217]
  908  79     39 [IRQ 1]
  4559  78     38 [IRQ 58]
  4663  77     37 [IRQ 66]
  7371  76     36 [IRQ 4]
  7995  21      - grep IRQ
mark@lightning ~ $ cat /proc/interrupts
           CPU0
  0:     338305    IO-APIC-edge  timer
  1:       1993    IO-APIC-edge  i8042
  7:          2    IO-APIC-edge  lpptest
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
  12:      62930    IO-APIC-edge  i8042
  14:         48    IO-APIC-edge  ide0
  50:          2   IO-APIC-level  ehci_hcd:usb1
  58:     257570   IO-APIC-level  hdsp
  66:       3951   IO-APIC-level  ohci1394
217:     134711   IO-APIC-level  ohci_hcd:usb2, eth0
225:          0   IO-APIC-level  libata, NVidia CK804
233:       7751   IO-APIC-level  libata
NMI:        169
LOC:     338277
ERR:          1
MIS:          0
mark@lightning ~ $

Since my NIC is getting a higher priority than both my sound card and
my 1394 audio drives (IRQ217 vs. IRQ58/IRQ66) I assume that network
activity might possibly sometimes cause a problem? Or is this not
true?

0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
        Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 217

0000:05:06.0 Multimedia audio controller: Xilinx Corporation RME
Hammerfall DSP (rev 68)
        Flags: bus master, medium devsel, latency 255, IRQ 58
        Memory at da000000 (32-bit, non-prefetchable) [size=64K]

0000:05:08.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2
IEEE-1394b Link Layer Controller (rev 01) (prog-if 10 [OHCI])
        Subsystem: Texas Instruments TSB82AA2 IEEE-1394b Link Layer Controller
        Flags: bus master, medium devsel, latency 32, IRQ 66

Ideally I think I'd like the NIC to be lower priority than the sound
card or the 1394 drives, and possibly lower then the system's SATA
drive also.

Thanks in advance,
Mark
