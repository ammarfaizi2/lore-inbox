Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbUCRUb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUCRUb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:31:27 -0500
Received: from zork.zork.net ([64.81.246.102]:21987 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262922AbUCRUbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:31:20 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: USB: gphoto2 hangs, device disconnection oddity (was Re:
 2.6.5-rc1-mm2)
References: <20040317201454.5b2e8a3c.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
 linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Date: Thu, 18 Mar 2004 20:31:16 +0000
In-Reply-To: <20040317201454.5b2e8a3c.akpm@osdl.org> (Andrew Morton's
 message of "Wed, 17 Mar 2004 20:14:54 -0800")
Message-ID: <6u4qslhp7v.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On one machine (a Dell Inspiron 4100 laptop), with 2.6.5-rc1-mm2 and
2.6.5-rc1-mm1, but not with 2.6.5-rc1, gphoto2 hangs trying to talk to
my camera:

    $ ps -C gphoto2 -o comm,s,wchan
    COMMAND          S WCHAN
    gphoto2          D usb_disable_device

However, I was able to connect, mount and perform large transfers to a
USB Storage device without any problems, although the device still
shows up in lsusb after it is umounted and disconnected, and plugging
in the camera has no effect, which is how I first noticed this problem.

Here's the Inspiron's controller:

    $ sudo lspci -s 00:1d.0 -vvvv
    00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
            Subsystem: Intel Corp.: Unknown device 4541
            Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
            Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 0
            Interrupt: pin A routed to IRQ 11
            Region 4: I/O ports at bf80 [size=32]

But on another machine (Gigabyte 6VTXD board, VIA chipset) running
2.6.5-rc1-mm1, gphoto2 works fine.  Here's its controller:

    $ sudo lspci -s 00:07 -vvvv
    [...]
    00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
            Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64, Cache Line Size: 0x08 (32 bytes)
            Interrupt: pin D routed to IRQ 10
            Region 4: I/O ports at c800 [size=32]
            Capabilities: [80] Power Management version 2
                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-

    00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
            Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
            Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
            Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
            Latency: 64, Cache Line Size: 0x08 (32 bytes)
            Interrupt: pin D routed to IRQ 10
            Region 4: I/O ports at cc00 [size=32]
            Capabilities: [80] Power Management version 2
                    Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                    Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    [...]

