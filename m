Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311035AbSCNHnq>; Thu, 14 Mar 2002 02:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311072AbSCNHni>; Thu, 14 Mar 2002 02:43:38 -0500
Received: from mail.medav.de ([213.95.12.190]:56586 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S311035AbSCNHnX> convert rfc822-to-8bit;
	Thu, 14 Mar 2002 02:43:23 -0500
From: "Daniela Engert" <dani@ngrt.de>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
        "Martin Dalecki" <martin@dalecki.de>, "Shawn Starr" <spstarr@sh0n.net>,
        "Vojtech Pavlik" <vojtech@suse.cz>
Date: Thu, 14 Mar 2002 08:44:42 +0100 (CET)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <20020314083038.A31923@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-Id: <20020314063843.E0E3210921@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002 08:30:38 +0100, Vojtech Pavlik wrote:

>> Are you aware of the batches of broken PIIX3 chips ?
>
>I don't know of any IDE-related errata for the PIIX3 chip. At least
>Intel didn't publish any and there doesn't seem to be any workarounds in
>the original piix.c code, only a statement stating that the PIIX3 UDMA
>is broken, however, as far as I know, PIIX3 isn't UDMA capable at all.
>
>(Hmm, perhaps some BIOSes enable UDMA on PIIX3, that'd explain it ...
>though I believe that's quite improbable).
>
>In what way are those batches broken?

Have a look at the table below which summarizes my findings from personal experiences, 
user reports and manufacturer info, accumulated in my 3 years of writing IDE drivers 
(well, actually only one - it's an universal driver).

The PIIX3 bug is real, I have several user reports about it!

Ciao,
  Dani


 Vendor
 | Device
 | | Revision			       ATA	ATAPI	     ATA66  ATA133
 | | | south/host bridge id	     PIO  DMA  PIO  DMA  ATA33 | ATA100|   Docs
 | | | | south/host bridge rev.     32bit  |  32bit  |	   |   |   |   |  avail
 | | | | |			      |    |	|    |	   |   |   |   |    |
 v v v v v			      v    v	v    v	   v   v   v   v    v

 0x8086 Intel
   0x1230 PIIX			      x    x	x    x	   -   -   -   -    x
     < 02			      x    -	x    -	   -   -   -   -    x
       0x84C4 Orion
	 < 04			      x    -	x    -	   -   -   -   -    x
   0x7010 PIIX3 		      x    x	x    x	   -   -   -   -    x
   0x7111 PIIX4 		      x    x	x    x	   x   -   -   -    x
   0x7199 PIIX4 MX		      x    x	x    x	   x   -   -   -    x
   0x84CA PIIX4 NX		      x    x	x    x	   x   -   -   -    x
   0x2411 ICH			      x    x	x    x	   x   x   -   -    x
   0x7601 ICH			      x    x	x    x	   x   x   -   -    x
   0x2421 ICH0			      x    x	x    x	   x   -   -   -    x
   0x244B ICH2			      x    x	x    x	   x   x   x   -    x
   0x244A ICH2 mobile		      x    x	x    x	   x   x   x   -    x
   0x248B ICH3			      x    x	x    x	   x   x   x   -    x
   0x248A ICH3 mobile		      x    x	x    x	   x   x   x   -    x

 known bugs:
   - PIIX3: some chips 'forget' to assert the IRQ sometimes. These chips are not
	    detectable in advance.

--------------------------------------------------------------------------------
 0x1106 VIA
   0x1571 571			      x    x	x    x	   -   -   -   -    -
   0x0571 571
       0x0586
	 < 0x20  586		      x    x	x    x	   -   -   -   -    -
	 >=0x20  586A/B 	      x    x	x    x	   x   -   -   -    x
       0x0596
	 < 0x10  596/A		      x    x	x    x	   x   -   -   -    x
	 < 0x10  596B		      x    x	x    x	   x   x   -   -    x
       0x0686
	 < 0x10  686		      x    x	x    x	   x   -   -   -    -
	 < 0x40  686A		      x    x	x    x	   x   x   -   -    x
	 >=0x40  686B		      x    x	x    x	   x   x   x   -    -
       0x8231	 VT8231 	      x    x	x    x	   x   x   x   -    -
       0x3074	 VT8233 	      x    x	x    x	   x   x   x   -    -
       0x3109	 VT8233c	      x    x	x    x	   x   x   x   -    -
       0x3147	 VT8233a	      x    x	x    x	   x   x   x   x    -

 known bugs:
   - all:  no host side cable type detection.
   - all:  the busmaster 'active' bit doesn't match the actual busmaster state.
   - 596B: don't touch the busmaster registers too early after interrupt
	   don't touch taskfile registers before stopping the busmaster!
   - 686 rev 40/41 and VT8231 rev 10/11 have the PCI corruption bug!

--------------------------------------------------------------------------------
 0x10B9 ALi
   0x5229 M5229
     < 0x20			      x    x	x    -	   -   -   -   -   (x)
     < 0xC1	 1533, 1543E, 1543F   x    x	x    -	   x   -   -   -   (x)
     < 0xC2	 1543C		      x    x	x    xR    x   -   -   -   (x)
	 0xC3/
	 0x12	 1543C-E	      x    x	x    xR   (x)  -   -   -   (x)
     < 0xC4	 1535, 1553, 1543C-Bx x    x	x    x	   x   x   -   -    x
		 1535D
     ==0xC4	 1535D+ 	      x    x	x    x	   x   x   x   -    x
     > 0xC4	 1535D+ 	      x    x	x    x	   x   x   x   x    -

 known bugs:
   - 1535 and better: varying methods of host side cable type detection.
   - up to 1543C: busmaster engine 'active' status bit is nonfunctional
		  in UltraDMA modes.
   - up to 1543C: can't do ATAPI DMA writes.
   - 1543C-E:	  UltraDMA CRC checker fails with WDC disks.
   - 1543C-Bx:	  must stop busmaster reads with 0x00 instead of 0x08.

--------------------------------------------------------------------------------
 0x1039 SiS
   0x5513 5513
     < 0xD0			      x    x	x    x	   -   -   -   -    x
     >=0xD0			      x    x	x    x	   x   -   -   -    x
       >= 0x0530		      x    x	x    x	   x   x   -   -   (x)
       >  0x0630		      x    x	x    x	   x   x   x   -   (x)
       6/746 6/751		      x    x	x    x	   x   x   x   x    -

   - older SiS: don't touch the busmaster registers too early after interrupt

--------------------------------------------------------------------------------
 0x1095 CMD
   0x0640 CMD 640		      -    -	-    -	   -   -   -   -    x
     00   refuse!
   0x0643 CMD 643
     < 03			      x    x	x    x	   -   -   -   -    x
     >=03			      x    x	x    x	   x   -   -   -    x
   0x0646 CMD 646
     < 03			      x    x	x    x	   -   -   -   -    x
     >=03			      x    x	x    x	   x   -   -   -    x
   0x0648 CMD 648		      x    x	x    x	   x   x   -   -    x
   0x0649 CMD 649		      x    x	x    x	   x   x   x   -   (x)

 known bugs:
   - 640: the enable bit of the secondary channel is erratic. You need to check
	  both settings '0' and '1' for a populated channel.
   - 640: revision 0 doesn't work reliably.
   - up to 646: both channels share internal resources. Serialization is
	  required.

--------------------------------------------------------------------------------
 0x105A Promise
   0x4D33 Ultra/FastTrack33	      x    x	-    -	   x   -   -   -    -
   0x4D38 Ultra/FastTrack66	      x    x	-   (x)    x   x   -   -    x
   0x4D30 Ultra/FastTrack100	      x    x	-   (x)    x   x   x   -    x
   0x0D30 Ultra/FastTrack100	      x    x	-   (x)    x   x   x   -    x
   0x4D68 Ultra/FastTrack100 TX2      x    x	x    x	   x   x   x   -   (x)
   0x6268 Ultra/FastTrack100 TX2      x    x	x    x	   x   x   x   -   (x)
   0x4D69 Ultra/FastTrack133	      x    x	x    x	   x   x   x   x    x
   0x1275 Ultra/FastTrack133	      x    x	x    x	   x   x   x   x    -

 known bugs:
   - up to Ultra100: don't issue superfluous PIO transfer mode setups.
   - up to Ultra100: if any device is initialized to UltraDMA, you need to
	  reset the channel if you want to select MultiWord DMA instead.
   - Ultra66/100: ATAPI DMA should work according to Windows drivers, but I
	  can see channel lockups only.

--------------------------------------------------------------------------------
 0x1078 Cyrix
   0x0102 CX5530		      x    x	x    x	   x   -   -   -    x

 known bugs:
   - all: busmaster transfers need to be 16 byte aligned instead of word
	  aligned.

--------------------------------------------------------------------------------
 0x1103 HighPoint
   0x0004 HPT 36x/37x
     <=01 HPT 366		      x    x	x    x	   x   x   -   -    x
       02 HPT 368		      x    x	x    x	   x   x   -   -    -
       03 HPT 370		      x    x	x    x	   x   x   x   -    x
       04 HPT 370A		      x    x	x    x	   x   x   x   -   (x)
       05 HPT 372		      x    x	x    x	   x   x   x   x    x
   0x0008 HPT 36x/37x dual
       07 HPT 374		      x    x	x    x	   x   x   x   x    x

 known bugs:
   - HPT366: random failures with several disks.
   - HPT366: random PCI bus lockups in case of too long bursts.
   - HPT366: IBM DTLA series drives must be set to Ultra DMA mode 5 (!!) to work
	     reliably at Ultra DMA mode 4 speed.

--------------------------------------------------------------------------------
 0x1022 AMD
   0x7401 AMD 751		      x    x	x    x	   x   -   -   -    -
   0x7409 AMD 756		      x    x	x    x	   x   x   -   -    x
   0x7411 AMD 766  MP		      x    x	x    x	   x   x   x   -    x
   0x7441 AMD 768  MPX		      x    x	x    x	   x   x   x   -    x
   0x7469 AMD 8111		      x    x	x    x	   x   x   x   -    -

 known bugs:
   - 756: no host side cable type detection.
   - 756: SingleWord DMA doesn't work on early chip revisions.
   - 766: read/write prefetches must be disabled to defeat infinite
	  PCI bus retries.

--------------------------------------------------------------------------------
 0x1191 AEC/Artop
   0x0005 AEC 6210		      x    x	?    ?	   x   -   -   -    -
   0x0006 AEC 6260		      x    x	?    ?	   x   x   -   -    -
   0x0007 AEC 6260		      x    x	?    ?	   x   x   -   -    -
   0x0009 AEC 6280/6880 	      x    x	?    ?	   x   x   x   x    -

 known bugs:
   - 6210 (possibly 6260): task file registers are inaccessible until busmaster
		 engine is stopped.
   - possibly all: both channels share internal resources. Serialization is
		 required.

--------------------------------------------------------------------------------
 0x1055 SMSC
   0x9130 SLC90E66		      ?    x	?    ?	   x   x   -   -    x

--------------------------------------------------------------------------------
 0x1166 ServerWorks
   0x0211 OSB4			      x    x	?    ?	   x   -   -   -    x
   0x0212 CSB5
     < 0x92			      x    x	?    ?	   x   x   -   -    -
    >= 0x92			      x    x	?    ?	   x   x   x   -    -

 known bugs:
   - OSB4: at least some chip revisions can't do Ultra DMA mode 1 and above
   - CSB5: no host side cable type detection.

--------------------------------------------------------------------------------
 0x1045 Opti
   0xC621     n/a		      x    -	?    -	   -   -   -   -    x
   0xC558     Viper		      x    x	?    ?	   -   -   -   -    x
   0xD568			      x    x	?    ?	   -   -   -   -    x
     < 0xC700 Viper		      x    x	?    ?	   -   -   -   -    x
     >=0xC700 FireStar/Vendetta?      x    x	x    x	   x   -   -   -    x
   0xD721     Vendetta? 	      x    x	x    x	   x   -   -   -    x
   0xD768     Vendetta		      x    x	x    x	   x   -   -   -    x

 known bugs:
   - C621: both channels share internal resources. Serialization is required.
   - FireStar: Ultra DMA works reliably only at mode 0.
	       Update: not even that! Better do MWDMA2 at most.

--------------------------------------------------------------------------------
 0x10DE Nvidia
   0x01BC     nForce		      x    x	x    x	   x   x   x   -    -

 known bugs:
   - nForce: no host side cable type detection.

--------------------------------------------------------------------------------
 0x100B National Semiconductor
   0x0502 SCx200		      x    x	x    x	   x   -   -   -    -

 known bugs:
   - all: busmaster transfers need to be 16 byte aligned instead of word
	  aligned.



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


