Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVCBVOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVCBVOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbVCBVOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:14:30 -0500
Received: from tantale.fifi.org ([64.81.251.130]:64649 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262465AbVCBVOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:14:22 -0500
To: linux-kernel@vger.kernel.org
Subject: Static with esound (esd) and via82cxxx_audio on 2.4.29.
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 02 Mar 2005 13:14:20 -0800
Message-ID: <87mztlbvir.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 

Linux 2.4.29 #1 SMP Mon Feb 21 02:11:56 PST 2005 i686 unknown

on an Asus K8W SE Deluxe, bios 1005 with an embedded via82cxxx audio
controller:

  00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 60)
        Subsystem: Asustek Computer, Inc.: Unknown device 80b0
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- \
                 ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium \
                >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at c800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA \
                       PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Inserting via82cxxx_audio reports:

  Via 686a/8233/8235 audio driver 1.9.1-ac3
  via82cxxx: Six channel audio available
  PCI: Setting latency timer of device 00:11.5 to 64
  via82cxxx: timeout while reading AC97 codec (0xAA0000)
  ac97_codec: AC97 Audio codec, id: ADS112 (Unknown)
  via82cxxx: board #1 at 0xC800, IRQ 22

Playing sound via /dev/dsp works fine, however, when running esound
(esd), I get a lot and endless loop of some audio fragment playing on
the speakers, like if the driver was keeping on playing contents of
the last processed audio buffer.

I've traced it down to the SNDCTL_DSP_POST ioctl, and actually this
source code will reproduce the problem: it will replay the contents of
the "last" submitted audio buffer:

   #include <fcntl.h>
   #include <stdio.h>
   #include <errno.h>
   #include <string.h>
   #include <sys/ioctl.h>
   #include <linux/soundcard.h>
   #include <unistd.h>

   #define CK(args)                                                \
   if ((args) == -1)                                               \
     {                                                             \
       fprintf(stderr, "%s: %s\n", #args, strerror(errno));        \
       exit(1);                                                    \
     }

   int main()
   {
     int fd;

     CK(fd = open("/dev/dsp", O_WRONLY));
     CK(ioctl(fd, SNDCTL_DSP_POST, 0));
     sleep(1);
     return 0;
   }

I've tried backporting 1.9.1-ac4 from 2.6.x, but it has the same
problems.

Phil.
