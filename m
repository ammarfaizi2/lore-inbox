Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314269AbSD0Pu6>; Sat, 27 Apr 2002 11:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314270AbSD0Pu6>; Sat, 27 Apr 2002 11:50:58 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:20231 "EHLO
	mailrelay.nefonline.de") by vger.kernel.org with ESMTP
	id <S314269AbSD0Puz>; Sat, 27 Apr 2002 11:50:55 -0400
Message-Id: <200204271550.RAA11082@myway.myway.de>
From: "Daniela Engert" <dani@ngrt.de>
To: "Anton Altaparmakov" <aia21@cantab.net>
Cc: "Kevin Krieser" <kkrieser_list@footballmail.com>,
        "Ville Herva" <vherva@niksula.hut.fi>,
        "Andre Hedrick" <andre@linux-ide.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Martin Bene" <martin.bene@icomedias.com>
Date: Sat, 27 Apr 2002 17:50:43 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
In-Reply-To: <5.1.0.14.2.20020427153130.03ea8b30@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: RE: 48-bit IDE [Re: 160gb disk showing up as 137gb]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002 16:02:54 +0100, Anton Altaparmakov wrote:

>>You need an IDE controller that supports ATA133.  For most existing
>>computers, that is going to require a new card.
>
>Rubbish! The drives are backwards compatible with all ATA standards (do a 
>hparm -i on the drive and you will see). I certainly don't have an ATA133 
>controller and use one of the new Maxtor ATA133 drives just fine on it.

True.

>For LBA48 support I am not too sure whether you need a special controller 
>(for what it's worth I use a Promise ATA100 controller and it works fine on 
>my Maxtor 120G, LBA48, ATA133 disk but the disk is possibly not big enough 
>for any problems to manifest).

Nobody should take for granted, that LBA48 mode works flawlessly on any
IDE controller chip. In fact it doesn't! While you may safely assume
that LBA48 addressing is fine with PIO mode transfers, there are
controller chips out which simply fail with LBA48 in DMA mode (like
almost all ALi chips) or need "special treatment" (like Promise Ultra66
or pre-TX2 Ultra100 ) - there are probably more.

[BTW: the Linux driver's Promise LBA48 workaround will fail in
non-Ultra DMA mode because it is hard-wired for Ultra DMA only].

>Perhaps Andre (cc-ed) could shed some light on this?

Let's address a larger audience :-)

I've added an additional column to my "IDE drivers capabilities,
features and bug list" which summarizes my tests with LBA48 DMA modes.
A "?" means "no test conducted" (usually because of lack of hardware),
a "x" means supported, a "-" means "unsupported". and a "x!" means
"supported, special treatment required".

If there are people with hardware which still has a "?" I'd like to
hear of their experiences.


>>-----Original Message-----
>>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ville Herva
>>
>>But which IDE controllers support 48-bit addressing? Not all of them? Does
>>linux IDE driver support 48-bit for all of them? Do they require BIOS
>>upgrade in order to operate 48-bit?

AFAIK the BIOS is out of the picture. Most OS son't rely on the BIOS
for regular operation.

>>Or can I just grab a 160GB Maxtor and 2.4.19-preX, stick them into whatever
>>box I have and be done with it?

It *might* work, but your mileage will vary.

Ciao,
  Dani


 Vendor
 | Device
 | | Revision			      ATA  LBA48  ATAPI      
ATA66  ATA133
 | | | south/host bridge id	    PIO DMA DMA  PIO DMA  ATA33 |
ATA100|   Docs
 | | | | south/host bridge rev.    32bit |   |	32bit |    
|	|   |	|  avail
 | | | | |			     |	 |   |	  |   |  
  |	|   |	|    |
 v v v v v			     v	 v   v	  v   v  
  v	v   v	v    v

 0x8086 Intel
   0x1230 PIIX			     x	 x   ?	  x  
x     -	-   -	-    x
     < 02			     x	 -   -	  x   -   
 -	-   -	-    x
       0x84C4 Orion
	 < 04			     x	 -   -	  x  
-     -	-   -	-    x
   0x7010 PIIX3 		     x	 x   x	  x   x    
-	-   -	-    x
   0x7111 PIIX4 		     x	 x   x	  x   x    
x	-   -	-    x
   0x7199 PIIX4 MX		     x	 x   x	  x   x  
  x	-   -	-   (x)
   0x2411 ICH			     x	 x   x	  x  
x     x	x   -	-    x
   0x7601 ICH			     x	 x   x	  x  
x     x	x   -	-   (x)
   0x2421 ICH0			     x	 x   x	  x  
x     x	-   -	-    x
   0x244B ICH2			     x	 x   x	  x  
x     x	x   x  (x)   x
   0x244A ICH2 mobile		     x	 x   x	  x  
x     x	x   x  (x)   x
   0x245B C-ICH 		     x	 x   x	  x   x    
x	x   x  (x)   x
   0x248B ICH3			     x	 x   x	  x  
x     x	x   x  (x)   x
   0x248A ICH3 mobile		     x	 x   x	  x  
x     x	x   x  (x)   x

 known bugs and features:
   - PIIX3: some chips 'forget' to assert the IRQ sometimes. These
chips are not
	    detectable in advance.
   - ICH2+: despite the docs, the ATA/100 capable chips also can do
ATA/133

------------------------------------------------------------------------
--------
 0x1106 VIA
   0x1571 571			     x	 x   ?	  x  
x     -	-   -	-    -
   0x0571 571
       0x0586
	 < 0x20  586		     x	 x   ?	  x   x
    -	-   -	-    x
	 >=0x20  586A/B 	     x	 x   x	  x   x    
x	-   -	-    x
       0x0596
	 < 0x10  596/A		     x	 x   x	  x  
x     x	-   -	-    x
	 >=0x10  596B		     x	 x   x	  x  
x     x	x   -	-    x
       0x0686
	 < 0x10  686		     x	 x   x	  x   x
    x	-   -	-    -
	 < 0x40  686A		     x	 x   x	  x  
x     x	x   -	-    x
	 >=0x40  686B		     x	 x   x	  x  
x     x	x   x	-    x
       0x8231	 VT8231 	     x	 x   x	  x  
x     x	x   x	-    -
       0x3074	 VT8233 	     x	 x   x	  x  
x     x	x   x	-    x
       0x3109	 VT8233c	     x	 x   x	  x  
x     x	x   x	-    -
       0x3147	 VT8233a	     x	 x   x	  x  
x     x	x   x	x    -

 known bugs:
   - all:  no host side cable type detection.
   - all:  the busmaster 'active' bit doesn't match the actual
busmaster state.
   - 596B: don't touch the busmaster registers too early after
interrupt
	   don't touch taskfile registers before stopping the
busmaster!
   - 686 rev 40/41 and VT8231 rev 10/11 have the PCI corruption
bug!

------------------------------------------------------------------------
--------
 0x10B9 ALi
   0x5229 M5229
     < 0x20			     x	 x   -	  x   - 
   -	-   -	-   (x)
     < 0xC1	 1533, 1543E/F	     x	 x   -	 
x   -     x	-   -	-   (x)
     < 0xC2	 1543C		     x	 x   -	 
x   xR    x	-   -	-   (x)
	 0xC3/
	 0x12	 1543C-E	     x	 x   -	  x  
xR   (x)	-   -	-   (x)
     < 0xC4	 1535, 1553,	     x	 x   -	  x 
 x     x	x   -	-    x
		 1543C-B, 1535D
     ==0xC4	 1535D+ 	     x	 x   -	  x   x 
   x	x   x	-    x
     > 0xC4	 1535D+ 	     x	 x   x	  x   x 
   x	x   x	x    -

 known bugs:
   - 1535 and better: varying methods of host side cable type
detection.
   - up to 1543C: busmaster engine 'active' status bit is nonfunctional
		  in UltraDMA modes.
   - up to 1543C: can't do ATAPI DMA writes.
   - 1543C-E:	  UltraDMA CRC checker fails with older WDC disks.
   - 1543C-Bx:	  must stop busmaster reads with 0x00 instead of
0x08.

------------------------------------------------------------------------
--------
 0x1039 SiS
   0x5513 5513
     < 0xD0			     x	 x   ?	  x   x 
   -	-   -	-    x
     >=0xD0			     x	 x   ?	  x   x 
   x	-   -	-    x
       >= 0x0530		     x	 x   ?	  x   x    
x	x   -	-   (x)
       >  0x0630		     x	 x   ?	  x   x    
x	x   x	-   (x)
       6/746 6/751		     x	 x   ?	  x   x  
  x	x   x	x    -

   - older SiS: don't touch the busmaster registers too early after
interrupt

------------------------------------------------------------------------
--------
 0x1095 CMD/Silicon Image
   0x0640 CMD 640		     -	 -   -	  -   -   
 -	-   -	-    x
     00   refuse!
   0x0643 CMD 643
     < 03			     x	 x   ?	  x   x   
 -	-   -	-    x
     >=03			     x	 x   ?	  x   x   
 x	-   -	-    x
   0x0646 CMD 646
     < 03			     x	 x   ?	  x   x   
 -	-   -	-    x
     >=03			     x	 x   ?	  x   x   
 x	-   -	-    x
   0x0648 CMD 648		     x	 x   ?	  x   x   
 x	x   -	-    x
   0x0649 CMD 649		     x	 x   x	  x   x   
 x	x   x	-   (x)
   0x0680 SiI 680		     x	 x   x	  x   x   
 x	x   x	x    x

 known bugs:
   - 640: the enable bit of the secondary channel is erratic. You need
to check
	  both settings '0' and '1' for a populated channel.
   - 640: revision 0 doesn't work reliably.
   - up to 646: both channels share internal resources. Serialization
is
	 
required.

------------------------------------------------------------------------
--------
 0x105A Promise
   0x4D33 PDC20246   Ultra33	     x	 x   ?	  -   -
    x	-   -	-    x
   0x4D38 PDC20262   Ultra66	     x	 x   x!   -  (x)   
x	x   -	-    x
   0x0D38 PDC20263   Ultra66	     x	 x   x!   -  (x)   
x	x   -	-   (x)
   0x0D30 PDC20265   Ultra100	     x	 x   x!   -  (x)   
x	x   x	-    x
   0x4D30 PDC20267   Ultra100	     x	 x   x!   -  (x)   
x	x   x	-    x
   0x4D68 PDC20268   Ultra100 TX2    x	 x   x	  x   x    
x	x   x	-   (x)
   0x6268 PDC20270   Ultra100 TX2    x	 x   x	  x   x    
x	x   x	-   (x)
   0x4D69 PDC20269   Ultra133 TX2    x	 x   x	  x   x    
x	x   x	x    x
   0x6269 PDC20271   Ultra133 TX2    x	 x   x	  x   x    
x	x   x	x   (x)
   0x1275 PDC20275   Ultra133 TX2    x	 x   x	  x   x    
x	x   x	x   (x)
   0x5275 PDC20276   Ultra133 TX2    x	 x   x	  x   x    
x	x   x	x    x
   0x7275 PDC20277   Ultra133 TX2    x	 x   x	  x   x    
x	x   x	x   (x)

 known bugs:
   - up to Ultra100: don't issue superfluous PIO transfer mode setups.
   - up to Ultra100: if any device is initialized to UltraDMA, you need
to
	  reset the channel if you want to select MultiWord DMA
instead.
   - Ultra66/100: a LBA48 DMA mode transfer needs an extra "kick".
   - Ultra66/100: ATAPI DMA should work according to Windows drivers,
but the
	  register model is very
"strange".

------------------------------------------------------------------------
--------
 0x1078 Cyrix
   0x0102 CX5530		     x	 x   ?	  x   x    
x	-   -	-    x

 known bugs:
   - all: busmaster transfers need to be 16 byte aligned instead of
word
	  aligned.
   - all: a DMA block of 64KiB comes out as 0 bytes in the DMA
engine

------------------------------------------------------------------------
--------
 0x1103 HighPoint
   0x0004 HPT 36x/37x
     <=01 HPT 366		     x	 x   x	  x   x   
 x	x   -	-    x
       02 HPT 368		     x	 x   x	  x   x   
 x	x   -	-    -
       03 HPT 370		     x	 x   x	  x   x   
 x	x   x	-    x
       04 HPT 370A		     x	 x   x	  x   x  
  x	x   x	-   (x)
       05 HPT 372		     x	 x   x	  x   x   
 x	x   x	x    x
   0x0005 HPT 372		     x	 x   x	  x   x   
 x	x   x	x   (x)
   0x0008 HPT 36x/37x dual
       07 HPT 374		     x	 x   x	  x   x   
 x	x   x	x    x

 known bugs:
   - HPT366: random failures with several disks.
   - HPT366: random PCI bus lockups in case of too long bursts.
   - HPT366: IBM DTLA series drives must be set to Ultra DMA mode 5
(!!) to work
	     reliably at Ultra DMA mode 4
speed.

------------------------------------------------------------------------
--------
 0x1022 AMD
   0x7401 AMD 751		     x	 x   ?	  x   x   
 x	-   -	-    -
   0x7409 AMD 756		     x	 x   ?	  x   x   
 x	x   -	-    x
   0x7411 AMD 766  MP		     x	 x   ?	  x  
x     x	x   x	-    x
   0x7441 AMD 768  MPX		     x	 x   ?	  x  
x     x	x   x	-    x
   0x7469 AMD 8111		     x	 x   ?	  x   x  
  x	x   x	-    -

 known bugs:
   - 756: no host side cable type detection.
   - 756: SingleWord DMA doesn't work on early chip revisions.
   - 766: read/write prefetches must be disabled to defeat infinite
	  PCI bus
retries.

------------------------------------------------------------------------
--------
 0x1191 AEC/Artop
   0x0005 AEC 6210		     x	 x   ?	  ?   ?  
  x	-   -	-    -
   0x0006 AEC 6260		     x	 x   ?	  ?   ?  
  x	x   -	-    -
   0x0007 AEC 6260		     x	 x   ?	  ?   ?  
  x	x   -	-    -
   0x0009 AEC 6280/6880 	     x	 x   ?	  ?   ?    
x	x   x	x    -

 known bugs:
   - 6210 (possibly 6260): task file registers are inaccessible until
busmaster
		 engine is stopped.
   - possibly all: both channels share internal resources.
Serialization is
		
required.

------------------------------------------------------------------------
--------
 0x1055 SMSC
   0x9130 SLC90E66		     ?	 x   ?	  ?   ?  
  x	x   -	-   
x

------------------------------------------------------------------------
--------
 0x1166 ServerWorks
   0x0211 OSB4			     x	 x   ?	  ?  
?     x	-   -	-    x
   0x0212 CSB5
     < 0x92			     x	 x   ?	  ?   ? 
   x	x   -	-    -
    >= 0x92			     x	 x   ?	  ?   ? 
   x	x   x	-    -
   0x0213 CSB6
     < 0xA0			     x	 x   ?	  ?   ? 
   x	3   -	-    -
    >= 0xA0			     x	 x   ?	  ?   ? 
   x	x   x	-    -

 known bugs:
   - OSB4: at least some chip revisions can't do Ultra DMA mode 1 and
above
   - OSB4: some chip revisions may get stuck in the DMA engine in Ultra
DMA
	   with some disks
   - CSB5: no host side cable type detection (vendor specific).
   - CSB6: no host side cable type detection (vendor
specific).

------------------------------------------------------------------------
--------
 0x1045 Opti
   0xC621     n/a		     x	 -   -	  -   -   
 -	-   -	-    x
   0xC558     Viper		     x	 x   ?	  ?   ? 
   -	-   -	-    x
   0xD568			     x	 x   ?	  ?   ?   
 -	-   -	-    x
     < 0xC700 Viper		     x	 x   ?	  ?   ? 
   -	-   -	-    x
     >=0xC700 FireStar/Vendetta?     x	 x   ?	  x   x    
x	-   -	-    x
   0xD721     Vendetta? 	     x	 x   ?	  x   x    
x	-   -	-    x
   0xD768     Vendetta		     x	 x   ?	  x  
x     x	-   -	-    x

 known bugs:
   - C621: both channels share internal resources. Serialization is
required.
   - FireStar: Ultra DMA works reliably only at mode 0.
	       Update: not even that! Better do MWDMA2 at
most.

------------------------------------------------------------------------
--------
 0x10DE Nvidia
   0x01BC     nForce		     x	 x   ?	  x   x
    x	x   x	-    -

 known bugs:
   - nForce: no host side cable type
detection.

------------------------------------------------------------------------
--------
 0x100B National Semiconductor
   0x0502 SCx200		     x	 x   ?	  x   x    
x	-   -	-    -

 known bugs:
   - all: busmaster transfers need to be 16 byte aligned instead of
word
	  aligned.




