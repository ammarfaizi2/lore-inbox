Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311572AbSCNJrO>; Thu, 14 Mar 2002 04:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311573AbSCNJrF>; Thu, 14 Mar 2002 04:47:05 -0500
Received: from mail.medav.de ([213.95.12.190]:7434 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S311572AbSCNJqv> convert rfc822-to-8bit;
	Thu, 14 Mar 2002 04:46:51 -0500
From: "Daniela Engert" <dani@ngrt.de>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
        "Martin Dalecki" <martin@dalecki.de>, "Shawn Starr" <spstarr@sh0n.net>,
        "Vojtech Pavlik" <vojtech@suse.cz>
Date: Thu, 14 Mar 2002 10:48:10 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <20020314091808.B31998@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-Id: <20020314084211.2611E5246@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002 09:18:08 +0100, Vojtech Pavlik wrote:

>>  Vendor
>>  | Device
>>  | | Revision		       ATA	ATAPI	     ATA66  ATA133
>>  | | | south/host bridge id	     PIO  DMA  PIO  DMA  ATA33 | ATA100|   Docs
>>  | | | | south/host bridge rev.  32bit  |  32bit  |	   |   |   |   |  avail
>>  | | | | |			      |    |	|    |	   |   |   |   |    |
>>  v v v v v			      v    v	v    v	   v   v   v   v    v
>> 
>>  0x8086 Intel
>>    0x1230 PIIX		      x    x	x    x	   -   -   -   -    x
>>      < 02			      x    -	x    -	   -   -   -   -    x
>
>I suppose this means on PIIXes with rev 00 and 01 of the IDE controller
>DMA transfers don't work reliably, right?

True.

>>        0x84C4 Orion
>> 	 < 04			      x    -	x    -	   -   -   -   -    x
>
>And this means that if there is an 84c4 PCI bridge in the system with
>rev less than 04 (04 is OK), then DMA transfers are broken again.

True.

>>    0x84CA PIIX4 NX		      x    x	x    x	   x   -   -   -    x
>
>This one confuses me, because the 0x84ca chip doesn't seem to have any
>IDE capability. Is this id by any chance taken from the linux kernel?

I can't remember. The driver has its roots more than 10 years ago, and
there are so many open and closed driver sources around.

>>    0x7601 ICH			      x    x	x    x	   x   x   -   -    x
>
>This one is actually a PIIX5, not ICH.

May be, but who cares about names ;-)

>>  known bugs:
>>    - PIIX3: some chips 'forget' to assert the IRQ sometimes. These chips are not
>> 	    detectable in advance.
>
>Is there any workaround for that? Or there isn't to do anything about
>the bug and we just have to live with it ...

There is no known workaround. My driver has the option to tune the
command timeouts such that missing interrupts have no noticable impact.
The choice is up to the user.

>>  0x1106 VIA
>>    0x1571 571			      x    x	x    x	   -   -   -   -    -
>
>Irq unmasking during PIO transfers is known to cause problems on
>these. Also, some have wrong ISA bridge vendor ID of 1107.

True, but this is stone-age technology. I don't really care about
non-UltraDMA capable chips at all.


>>    0x0571 571
>>        0x0586
>> 	 < 0x20  586		      x    x	x    x	   -   -   -   -    -
>
>I have docs on this one.
>
>> 	 >=0x20  586A/B 	      x    x	x    x	   x   -   -   -    x
>
>00..1f 586
>20..2f 586a
>30..3f 586b
>40..46 586b 3040 silicon
>Has a bug where the preq# til ddack# bit must be cleared or can cause
>spontaneous reboots.
>47..4f 586b 3041 silicon

True. I leave this particular setup to the BIOS which is supposed to
take care of such idiosyncrasies...

>>        0x0596
>> 	 < 0x10  596/A		      x    x	x    x	   x   -   -   -    x
>> 	 < 0x10  596B		      x    x	x    x	   x   x   -   -    x
>
>That probably should be >= 10

Oops - fixed :-)

>>        0x0686
>> 	 < 0x10  686		      x    x	x    x	   x   -   -   -    -
>> 	 < 0x40  686A		      x    x	x    x	   x   x   -   -    x
>> 	 >=0x40  686B		      x    x	x    x	   x   x   x   -    -
>
>I have docs here as well.
>
>>        0x8231	 VT8231 	      x    x	x    x	   x   x   x   -    -
>>        0x3074	 VT8233 	      x    x	x    x	   x   x   x   -    -
>
>And for this, too.
>
>>        0x3109	 VT8233c	      x    x	x    x	   x   x   x   -    -
>>        0x3147	 VT8233a	      x    x	x    x	   x   x   x   x    -
>> 
>>  known bugs:
>>    - all:  no host side cable type detection.
>
>Not true, for the UDMA100 and UDMA133 capable ones, there are defined
>bits in the UDMA_TIMING register. Not all BIOSes use those, though.

Interesting. None of the user reports ever indicated that.

>> --------------------------------------------------------------------------------
>>  0x10DE Nvidia
>>    0x01BC     nForce		      x    x	x    x	   x   x   x   -    -
>> 
>>  known bugs:
>>    - nForce: no host side cable type detection.
>
>Do you have any info on this one? I'd really like to have a Linux driver
>for it ...

I have no docs, but my father's machine has this chip built in :-) My
driver is running it just fine. In fact, this is a clone of the ATA/100
capable AMD IDE chip cell with all config register addresses shifted up
by 0x10.

I'm looking forward to the new ATI chipset, let's bet where their IDE
cell is licenced from :-)

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


