Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261975AbSIYNU2>; Wed, 25 Sep 2002 09:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261976AbSIYNU1>; Wed, 25 Sep 2002 09:20:27 -0400
Received: from relay.muni.cz ([147.251.4.35]:32211 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S261975AbSIYNU0>;
	Wed, 25 Sep 2002 09:20:26 -0400
Date: Wed, 25 Sep 2002 15:24:22 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, kernel@street-vision.com,
       Petr Konecny <pekon@informatics.muni.cz>,
       "Bruno A. Crespo" <bruno@conectatv.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
Message-ID: <20020925132422.GC14381@fi.muni.cz>
Reply-To: 20020912161258.A9056@informatics.muni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, all!

two weeks ago I've posted to the LKML the following message:

[...]
: my dual athlon box is unstable in some situations. I can consistently
: lock it up by running the following code:
: 
: fd = open("/dev/hda3", O_RDWR);
: for (i=0; i<1024*1024; i++) {
:         read(fd, buffer, 8192);
:         lseek(fd, -8192, SEEK_CUR);
:         write(fd, buffer, 8192);
: }
[...]

	I think I have been hit by AMD 768 southbridge erratum number 10.
After plugging in the PS/2 mouse, the server is able to run 10 iterations
of bonnie++ without any problem (w/o PS/2 mouse it locks up in first
or second iterations).

	I want to ask everyone who replied to me that the above code
works for him on the 760MPX-based system to re-run the above code
(or run bonnie++ benchmark several times in a loop), but _without_
the PS/2 mouse connected?

	Since this is an official AMD errata, we should have a work-around
for this, or at least the big fat warning during boot, when the 768
southbridge is detected - something like the following:

WARNING: Using the system with AMD 768 southbridge without the PS/2
WARNING: mouse plugged in can cause instabilities. See the AMD 768 erratum #10

	The AMD 768 Revision Guide is at the following URL:

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/24472.pdf

the erratum #10 is described on page 7 (pstotext output, manually edited):

: 10	Multiprocessor System May Hang While in FULL APIC Mode
: 	and IOAPIC Interrupt is Masked
: 
: Products Affected. B1, B2
: 
: Normal Specified Operation. The AMD-768 peripheral bus controller is
: designed to support FULL APIC mode in multiprocessor systems for system
: management events. If an interrupt is masked in the APIC controller of
: the AMD-768, then the corresponding interrupt message should not be
: sent to the processor via the 3-wire APIC bus.
: 
: Non-conformance. The AMD-768 peripheral bus controller will send an
: interrupt message via the 3-wire APIC bus regardless if the interrupt
: is masked or not.
: 
: Potential Effect on System. Since the processor had previously masked
: the APIC interrupt, it is not expecting to receive future APIC messages
: for the masked interrupt. The APIC controller will continuously send
: the interrupt message via the 3-wire bus until a processor accepts the
: message, causing the system to hang.
: 
: A system hang has been observed when executing a server shutdown
: command in Novell Netware versions 5.0 or 5.1 while using a serial
: mouse. During the server shutdown sequence, software writes an invalid
: CPU ID to the IOAPIC redirection table, and the system does not
: complete the shutdown.
: 
: Note: No failure has been observed when using a PS/2 mouse.
: 
: Suggested Workaround. None.
: 
: Resolution Status: No fix planned.


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
