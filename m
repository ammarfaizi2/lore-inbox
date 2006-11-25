Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935199AbWKYOM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935199AbWKYOM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 09:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935200AbWKYOM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 09:12:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:23213 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S935199AbWKYOM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 09:12:28 -0500
X-Authenticated: #14349625
Subject: Re: [patch] PM: suspend/resume debugging should depend on
	SOFTWARE_SUSPEND
From: Mike Galbraith <efault@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com>
	 <20061123133904.GD5561@ucw.cz> <1164317804.6222.11.camel@Homer.simpson.net>
	 <200611232236.58444.rjw@sisk.pl>
	 <1164350350.6128.9.camel@Homer.simpson.net>
	 <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org>
Content-Type: text/plain
Date: Sat, 25 Nov 2006 15:11:38 +0100
Message-Id: <1164463898.6221.24.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-24 at 10:08 -0800, Linus Torvalds wrote:
> 
> On Fri, 24 Nov 2006, Mike Galbraith wrote:
> > 
> > I tried the dynticks/hires-timers/kbd suggestion, no difference.  It
> > still boots in medicated snail mode, and emits a stream of IRQ9: nobody
> > cared messages (fasteoi acpi, irqpoll = nogo) while doing so.
> 
> "medicated snail mode". Lol.

It turns out, that this is caused by console=ttyS0,115200n8.  Without
the problematic driver found by pm_trace for the old Pinacle SAT card...

02:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
	Subsystem: Pinnacle Systems Inc. PCTV Sat (DBC receiver)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at f2100000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

went boom here -->02:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
	Subsystem: Pinnacle Systems Inc. PCTV Sat (DBC receiver)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at f2101000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 Multimedia controller: Philips Semiconductors SAA7134 Video Broadcast Decoder (rev 01)
	Subsystem: Creatix Polymedia GmbH Medion 7134
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 8000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at f2002000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

...and the serial console, I can now suspend to ram just fine with stock
2.6.19-rc6.  As a serial port test, I set up a getty on ttyS0, and
logged in via minicom prior to suspend.  After resume, the serial port
isn't talking.  Kill -9 the shell though, and all is fine again.

> Based on the "fasteoi", you're obviously right now using the APIC, and 
> that's _usually_ the mode that works better. But just in case, try booting 
> with "noapic".

Makes no difference for vanilla, works just fine either way, I don't
even have to remove vga=0x314. The RT kernel has some issues in this
area with s2ram, but that's a different story.

	Hope you're having/had a nice weekend, and thanks for the tips!

	-Mike

