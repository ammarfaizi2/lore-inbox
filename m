Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752131AbWAETU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbWAETU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752160AbWAETU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:20:28 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:54423 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1752131AbWAETUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:20:04 -0500
Message-ID: <43BD7162.2090906@vc.cvut.cz>
Date: Thu, 05 Jan 2006 20:20:02 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: Dane Mutters <dmutters@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: (1) ACPI messes up Parallel support in kernels >2.6.9
References: <200601042203.12377.dmutters@gmail.com> <20060104225209.56e35802.akpm@osdl.org> <20060105085559.GA1357@neo.rr.com>
In-Reply-To: <20060105085559.GA1357@neo.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:
> On Wed, Jan 04, 2006 at 10:52:09PM -0800, Andrew Morton wrote:
> 
>>Dane Mutters <dmutters@gmail.com> wrote:
>>
>>>	I've been attempting to figure out this problem for a long time, and have 
>>> come to the conclusion that it must be a kernel bug (that or perhaps I'm a 
>>> bit dense).  Whenever I have the option, "Device Drivers > Plug and Play > 
>>> ACPI Support" enabled, I become unable to print using my parallel port.
>>
>>hm, regressions are bad and the fact that it _used_ to work meand that we
>>should be able to make it work again.
>>
>>Could you please raise a bug reports against acpi at bugzilla.kernel.org? 
>>It might help if that report includes the output of `dmesg -s 1000000' for
>>both working and non-working kernels.
>>
>>Thanks.
> 
> 
> This may be a PnP bug.  If you can provide further information, I'll
> look into it.

At least on my hardware (ASUS A8V, W83627THF superio) problem is that it now 
uses ECP...

Once parport_pc is loaded, it says it found PnPBIOS parport and finds printer

parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 
[PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
parport0: Printer, HEWLETT-PACKARD DESKJET 690C
lp0: using parport0 (interrupt-driven).
lp0: ECP mode

unfortunately write to /dev/lp* blocks indefinitely.  SuperIO registers 
inspection reveals that SIO is actually programmed to use DMA 1 and not DMA 3. 
When SuperIO is reprogrammed, data are apparently sent somewhere (as writes to 
/dev/lp no longer blocks), IRQ count is incremented for each block sent, but 
unfortunately printer does not seem to agree that any data arrived.

Actually I believe that ECP mode never worked for me - but in the past 
parport_pc just used SPP or EPP, and everything was happy.  Now 'modprobe 
parport_pc io=0x378' does not work anymore as parallel port hardware is kindly 
disabled by PnPBIOS code :-(  So I have to first enable parport in SuperIO, then 
set parport mode to SPP, PS2, EPP1.7 or EPP1.9 (low three bits of F0 register in 
function 1 must be 100, 000, 001 or 101) and load parport_pc io=0x378 
io_hi=0x778 irq=7 dma=1.  Then ECP mode is not used and printing works...

parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
parport0: Printer, HEWLETT-PACKARD DESKJET 690C
lp0: using parport0 (interrupt-driven).

If you are interested, ACPI DSDT is available at 
http://platan.vc.cvut.cz/ftp/private/a8v.acpi.dsdt.  W83627THF datasheet is 
available from Winbond website...  I do not understand AML sufficiently to tell 
whether problem with DMA is caused by parport or AML interpreter or buggy DSDT. 
  Non-working ECP is either dead hardware or parport problem existing for very long.

SuperIO dump after initial parport_pc load:

       RR/EN 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F 10 11 12 13 14 15 16 17
BASE: 0B    82 84 FF FE A2 00 00 FF 20 00 00 1A 48 00 00 FF
FN00: 01    03 F0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF 06 FF FF FF 02 FF FF FF
     :       8E 00 FF FF 00 00 FF FF FF FF FF FF FF FF FF FF
FN01: 01    03 78 FF FF FF FF FF FF FF FF FF FF FF FF FF FF 07 FF FF FF 01 FF FF FF
     :       3A FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
FN02: 01    03 F8 FF FF FF FF FF FF FF FF FF FF FF FF FF FF 04 FF FF FF FF FF FF FF
     :       00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
FN03: 01    02 F8 FF FF FF FF FF FF FF FF FF FF FF FF FF FF 03 FF FF FF FF FF FF FF
     :       00 00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF
FN04: 01    FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
     :       FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
FN05: 00    00 00 00 00 FF FF FF FF FF FF FF FF FF FF FF FF 00 FF 00 FF FF FF FF FF
     :       83 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
FN06: 00    FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
     :       FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
FN07: 08    02 01 03 30 FF FF FF FF FF FF FF FF FF FF FF FF 00 FF FF FF FF FF FF FF
     :       FF FF FF FF E3 00 FF FF FF FF FF FF FF FF FF 00
FN08: 01    FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
     :       FF 38 00 00 FF 00 00 00 FF FF FF FF FF FF FF FF
FN09: 03    FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
     :       FF 51 00 00 DF 21 00 FF FF FF FF FF FF FF FF FF
FN0A: 01    FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 00 FF FF FF FF FF FF FF
     :       00 AF FF 3F 00 FF 00 00 FF 00 FF FF FF FF 00 00
FN0B: 01    02 90 FF FF FF FF FF FF FF FF FF FF FF FF FF FF 00 FF FF FF FF FF FF FF
     :       01 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
PowerState: 01

								Petr

