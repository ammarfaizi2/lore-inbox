Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966874AbWKYReS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966874AbWKYReS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 12:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966878AbWKYReS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 12:34:18 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:49559 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S966874AbWKYReR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 12:34:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Date: Sat, 25 Nov 2006 18:12:52 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@suse.cz>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200611190320_MC3-1-D21B-111C@compuserve.com> <Pine.LNX.4.64.0611240959170.6991@woody.osdl.org> <1164463898.6221.24.camel@Homer.simpson.net>
In-Reply-To: <1164463898.6221.24.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611251812.53246.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 25 November 2006 15:11, Mike Galbraith wrote:
> On Fri, 2006-11-24 at 10:08 -0800, Linus Torvalds wrote:
> > 
> > On Fri, 24 Nov 2006, Mike Galbraith wrote:
> > > 
> > > I tried the dynticks/hires-timers/kbd suggestion, no difference.  It
> > > still boots in medicated snail mode, and emits a stream of IRQ9: nobody
> > > cared messages (fasteoi acpi, irqpoll = nogo) while doing so.
> > 
> > "medicated snail mode". Lol.
> 
> It turns out, that this is caused by console=ttyS0,115200n8.  Without
> the problematic driver found by pm_trace for the old Pinacle SAT card...
> 
> 02:02.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
> 	Subsystem: Pinnacle Systems Inc. PCTV Sat (DBC receiver)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (4000ns min, 10000ns max)
> 	Interrupt: pin A routed to IRQ 17
> 	Region 0: Memory at f2100000 (32-bit, prefetchable) [size=4K]
> 	Capabilities: [44] Vital Product Data
> 	Capabilities: [4c] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> went boom here -->02:02.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
> 	Subsystem: Pinnacle Systems Inc. PCTV Sat (DBC receiver)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (1000ns min, 63750ns max)
> 	Interrupt: pin A routed to IRQ 17
> 	Region 0: Memory at f2101000 (32-bit, prefetchable) [size=4K]
> 	Capabilities: [44] Vital Product Data
> 	Capabilities: [4c] Power Management version 2
> 		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 02:03.0 Multimedia controller: Philips Semiconductors SAA7134 Video Broadcast Decoder (rev 01)
> 	Subsystem: Creatix Polymedia GmbH Medion 7134
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (2000ns min, 8000ns max)
> 	Interrupt: pin A routed to IRQ 20
> 	Region 0: Memory at f2002000 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [40] Power Management version 1
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
> 
> ...and the serial console, I can now suspend to ram just fine with stock
> 2.6.19-rc6.  As a serial port test, I set up a getty on ttyS0, and
> logged in via minicom prior to suspend.  After resume, the serial port
> isn't talking.  Kill -9 the shell though, and all is fine again.

Hm, could you please file a bugzilla report regarding the serial console for
the information of its maintainer(s)?

Greetings,
Rafael

