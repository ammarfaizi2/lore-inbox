Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbTIGJyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 05:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTIGJyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 05:54:35 -0400
Received: from platane.lps.ens.fr ([129.199.121.28]:57993 "EHLO
	platane.lps.ens.fr") by vger.kernel.org with ESMTP id S263314AbTIGJyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 05:54:33 -0400
Date: Sun, 7 Sep 2003 11:54:23 +0200
From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
To: Patrick Mochel <mochel@osdl.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Power Management Update
Message-ID: <20030907095423.GA10520@lps.ens.fr>
References: <20030904224112.GA26556@lps.ens.fr> <Pine.LNX.4.33.0309041637440.940-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0309041637440.940-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been testing swsusp to disk on my computer using kernel
2.6.0-test4 + Patrick Mochel's main PM patch (posted on lkml on aug 31) +
IDE PM fix from benh (posted on lkml by P. Mochel on sep 2)

I found that my computer is able to suspend to disk if I boot with
init=/bin/sh, but not with a normal boot. I tried swsusp with a normal
boot (Xfree, kde, ...) but after removing several modules form
/lib/modules, to see which modules make problems. What I found:

* swsusp doesn't like accelerated graphics. If the following modules are
  loaded:
    i830                   68120  20
    intel_agp              14744  1
    agpgart                25640  3 intel_agp
  resuming fails. (Different kind of failures, from spontaneous reboot to
  kernel panic.) I could try to pinpoint more precisely which module
  causes trouble.

* Apart from that, the computer can suspend and come back to life !
  Modules loaded:
    snd_mixer_oss          16768  3
    binfmt_misc             8200  1
    autofs                 12928  0
    ne2k_pci                8288  0
    8390                    8576  1 ne2k_pci
    snd_virmidi             3584  2
    snd_seq_virmidi         5632  1 snd_virmidi
    ipchains               48080  15
    ide_cd                 36736  0
    cdrom                  33312  1 ide_cd
    loop                   13192  14
    hid                    30272  0
    ehci_hcd               21120  0
    uhci_hcd               27656  0
    usbcore                91348  5 hid,ehci_hcd,uhci_hcd
  However, the mouse is not working anymore (mouse is usb, the only usb
  device connected) nor network on eth1 (I haven't tried eth0.)
  Here are the last lines of the log after resuming:
	Restarting tasks...<6>usb 1-1: USB disconnect, address 2 done
	PM: Removing info for usb:1-1:0
	PM: Removing info for usb:1-1
	hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
	eth1: mismatched read page pointers 3c vs 66.
	eth1: mismatched read page pointers 4c vs d7.
	eth1: mismatched read page pointers 4c vs d7.
	eth1: mismatched read page pointers 4c vs d7.
	eth1: mismatched read page pointers 4c vs d7.
	eth1: mismatched read page pointers 4c vs d7.
	eth1: mismatched read page pointers 4c vs d7.
	eth1: mismatched read page pointers 4c vs d7.
	eth1: mismatched read page pointers 4c vs d7.
	hub 1-0:0: new USB device on port 1, assigned address 3
	usb 1-1: control timeout on ep0out
  eth1 is
   01:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  	   Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	   Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
           Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
           Interrupt: pin A routed to IRQ 20
           Region 0: I/O ports at c800 [size=32]

A last point; lates patch from P. Mochel (posted on Sep 3, supposed to
fix configuration with preempt enabled) completely prevents me from
suspending to disk.

Many data on my computer (.config, lspci, dsdt) available on
http://perso.nerim.net/~tudia/bug-reports/


Éric Brunet


