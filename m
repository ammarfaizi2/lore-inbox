Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTBBPJ0>; Sun, 2 Feb 2003 10:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbTBBPJ0>; Sun, 2 Feb 2003 10:09:26 -0500
Received: from mail.ithnet.com ([217.64.64.8]:56839 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S265339AbTBBPJY>;
	Sun, 2 Feb 2003 10:09:24 -0500
Date: Sun, 2 Feb 2003 16:18:37 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, jgarzik@pobox.com
Subject: 2.4.21-pre4: tg3 driver problems with shared interrupts
Message-Id: <20030202161837.010bed14.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave, Jeff, all

I just started experiments with a new setup consisting of:

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:04.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
00:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
00:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05)
00:0f.3 Host bridge: ServerWorks: Unknown device 0225
01:02.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev
01)
01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit
Ethernet (rev 15)
02:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit
Ethernet (rev 15)
02:03.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:03.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)

I found out within minutes that this setup does not survive if you let the
Broadcom cards share interrupts with anything else. It works ok now like
this (eth2 is tg3):

           CPU0       
  0:     343269          XT-PIC  timer
  1:       6804          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      37952          XT-PIC  EMU10K1
  7:        515          XT-PIC  HiSax
  9:     711212          XT-PIC  aic7xxx, aic7xxx, eth0, eth1
 10:    4710570          XT-PIC  eth2
 11:     639316          XT-PIC  ide2, ide3
 12:     107821          XT-PIC  PS/2 Mouse
 15:      69222          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

But horribly failed in such a setup:

  0:     XT-PIC  timer
  1:     XT-PIC  keyboard
  2:     XT-PIC  cascade
  5:     XT-PIC  EMU10K1
  7:     XT-PIC  HiSax
  9:     XT-PIC  eth2, aic7xxx, aic7xxx, eth0, eth1, ide2, ide3
 12:     XT-PIC  PS/2 Mouse
 15:     XT-PIC  ide1

I cannot even produce a "cat /proc/interrupts" for this because I am not fast
enough at login (the network at eth2 is heavy loaded). I sometimes read about
problems here with tg3-drivers, and I just wanted to point you to the shared
case, maybe it has to do with this special case rather than with the drivers
internals itself.
(PS: its not the ide2-3, I checked that out)

-- 
Regards,
Stephan
