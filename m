Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbUKXVaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbUKXVaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKXV3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:29:06 -0500
Received: from mail.gmx.de ([213.165.64.20]:25049 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261295AbUKXV26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:28:58 -0500
X-Authenticated: #20450766
Date: Wed, 24 Nov 2004 22:28:13 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Len Brown <len.brown@intel.com>
cc: linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       sensors@stimpy.netroedge.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [sensors] system slow since ~ 2.6.7
In-Reply-To: <1101186291.20008.247.camel@d845pe>
Message-ID: <Pine.LNX.4.60.0411242139090.2319@poirot.grange>
References: <Pine.LNX.4.60.0411180115490.941@poirot.grange>
 <1101186291.20008.247.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(added Andrew to CC as he also answered my original email. Don't know if 
sensors@stimpy.netroedge.com allows non-subscribers)

On Tue, 23 Nov 2004, Len Brown wrote:

> On Wed, 2004-11-17 at 19:25, Guennadi Liakhovetski wrote:
> > "Slow" means just running top alone in a vt it takes 1.6% CPU. Under
> > 2.6.3 it takes 0.2% (Duron 900MHz). Another peculiarity with 2.6.7 and
> > 2.6.9 is that the power LED is blinking with about 1Hz frequency. It's
> > an ASUS A7VI-VM motherboard. In the manual there's nothing about
> 
> PCI: Disabling Via external APIC routing
> 
> Curiously, this line appears in 2.6.3, but not in 2.6.7 or 2.6.9 dmesg
> -- even though all the configs build in IOAPIC support.
> 
> Can you forward the /proc/interrupts from 2.6.3, and from 2.6.9 with and
> without acpi=off?  do you see a significant change in /proc/interrupts
> before and after the sensor-provoked slowness starts?
> 
> if you build 2.6.9 w/o the CONFIG_ACPI_PROCESSOR and boot w/o cmdline
> params, do you still see slowness?
> 
> if you boot 2.6.9 with these parameters, do you see any additional dmesg
> lines?
> 
> acpi_dbg_level=0xF acpi_dbg_layer=0xFFFF3FFF

Ok, I started debugging the problem closely, and after booting into 2.6.9 
with acpi=off I still could reproduce the problem by starting sensors... 
So, I guess, there's no need to do all the acpi debugging you are 
suggesting above, right? As for /proc/interrupts with / without acpi and 
before / after sensors I don't see any difference. Notice also, that the 
slowness doesn't necessarily start immediately after starting sensors, it 
can start later, and it can spontaneously stop later. Just now while 
typing this email I saw the power LED stopped blinking and the speed went 
back to normal.

This reminds me: about a year ago my CPU fan burnt down. Then too, shortly 
after booting the PC, it slowed down. Then by accident I noticed in BIOS 
CPU temperature 98 deg C. With a new fan problem disappeared.

So, can it be, that the BIOS automatically slows down (throttles) the CPU 
at high temperature. And after ~ 2.6.7 sensors program the sensor 
interface with some (wrong) coefficient, and then it throttles the CPU 
wrongly? Yes, some coefficients are definitely wrong. Here are a couple of 
snapshots:

via686a-isa-e200
Adapter: ISA adapter
CPU core:  +1.09 V  (min =  +2.00 V, max =  +2.50 V)   ALARM
+2.5V:     +1.16 V  (min =  +3.10 V, max =  +1.57 V)   ALARM
I/O:       +3.40 V  (min =  +4.13 V, max =  +4.13 V)   ALARM
+5V:       +5.55 V  (min =  +6.44 V, max =  +6.44 V)   ALARM
+12V:      +4.81 V  (min = +15.60 V, max = +15.60 V)   ALARM
CPU Fan:  5443 RPM  (min =    0 RPM, div = 2)          
P/S Fan:     0 RPM  (min =    0 RPM, div = 2)          
SYS Temp:  +45.4 C  (high =   +45 C, hyst =   +40 C)   ALARM
CPU Temp:  +34.5 C  (high =   +60 C, hyst =   +55 C)   
SBr Temp:  +28.4 C  (high =   +65 C, hyst =   +60 C)   

via686a-isa-e200
Adapter: ISA adapter
CPU core:  +1.09 V  (min =  +2.00 V, max =  +2.50 V)   ALARM
+2.5V:     +1.16 V  (min =  +3.10 V, max =  +1.57 V)   ALARM
I/O:       +3.40 V  (min =  +4.13 V, max =  +4.13 V)   ALARM
+5V:       +5.55 V  (min =  +6.44 V, max =  +6.44 V)   ALARM
+12V:      +4.81 V  (min = +15.60 V, max = +15.60 V)   ALARM
CPU Fan:  5487 RPM  (min =    0 RPM, div = 2)          
P/S Fan:     0 RPM  (min =    0 RPM, div = 2)          
SYS Temp:  +45.2 C  (high =   +91 C, hyst =   +40 C)   ALARM
CPU Temp:  +34.4 C  (high =   +60 C, hyst =   +55 C)   
SBr Temp:  +28.4 C  (high =   +65 C, hyst =   +60 C)   

Notice how SYS Temp high changed... Can my guesses be correct and how 
can the situation be fixed? Again - no problems with 2.6.3.

Thanks
Guennadi
---
Guennadi Liakhovetski

