Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262870AbTCKJAx>; Tue, 11 Mar 2003 04:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbTCKJAx>; Tue, 11 Mar 2003 04:00:53 -0500
Received: from vs-dmz.germanparcel.de ([193.155.135.231]:9387 "EHLO
	vs-dmz.germanparcel.de") by vger.kernel.org with ESMTP
	id <S262870AbTCKJAo> convert rfc822-to-8bit; Tue, 11 Mar 2003 04:00:44 -0500
To: Andries.Brouwer@cwi.nl, davidsen@tmr.com, andre@linux-ide.org,
       harald.schaefer@gls-germany.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OFA849C5DE.9CB4AE6F-ONC1256CE6.003026CC-C1256CE6.00319038@LocalDomain>
From: Thomas.Mieslinger@gls-germany.com
Date: Tue, 11 Mar 2003 10:03:22 +0100
X-MIMETrack: Serialize by Router on deln001/europa(Release 5.0.9a |January 7, 2002) at
 03/11/2003 10:03:28 AM,
	Serialize complete at 03/11/2003 10:03:28 AM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

sorry for my late answer but I was not in my office yesterday.

First I'd like to explain why we need the correct bios-translation within 
linux:
We install our Windows-boxes with a linux bootdisk like the project http://unattended.sourceforge.net
After creating and formatting the partitions with linux and dosemu we boot 
dos from hd, and run the windows setup-script. It is running fine on any 
hardware with kernel 2.2.22 and the patched 2.4.21-pre5.

These are our problems:
- We cannot read the mapping from the partition-table because in most 
cases there are no partitions before booting linux!
- We also cannot supply a fixed mapping in the kernel append-line because 
this would require an extra bootdisk for each hd.

Why not extend the append-parameter?
current:
give a fixed mapping to the kernel                      hda=1050,32,64

this may be a possible solution:
give a fixed mapping to the kernel                      hda=1050,32,64
use bios-supplied mapping:                              hda=bios-lba
read mapping from newer disk:                           hda=disk-lba
force a mapping with 255 heads like current kernel:     hda=*,255,*

I think the kernel 2.2.22 was "more lucky" finding the correct mapping 
because the very new disk-devices which cause the problem are only in use 
since we have switched to kernel 2.4 ;-)
The problem only appears with the following parameters:
- very new hd (maxtor 4D040H2 from dec-2001 was running fine, but maxtor 
6E040L0 manufactured oct-2002 does not. both disk are of the same size of 
40GB)
- computer has a bios which uses 240-head mapping by default with this 
disk. This applies to about the half of our pc-types, about 800 computers 
alltogether. These are the desktops Compaq Evo 510 and HP Vectra Vli-8 and 
the notebooks Compaq Evo N610c and HP Omnibook 6000. It will also hit the 
HP Omnibook 6100 and the older HP Omnibook 4150 after installing a newer 
hd.
I think that many brand-computers will get this problem with newer drives 
attached and using dual-boot Linux-windows on the disk. This may cause 
data-loss on the windows-partition, i fear.


hdparm output with kernel 2.2.22:
# cat /proc/version
Linux version 2.2.22 (root@fm) (gcc version 2.95.3 20010315 (SuSE)) #3 Sat 
Oct 26 17:11:59 CEST 2002

# hdparm -i /dev/hda                    Maxtor 6E040L0, "bad disk"
/dev/hda:
 Model=Maxtor 6E040L0, FwRev=NAR61590, SerialNo=E11G00EE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4

# hdparm -I /dev/hda
/dev/hda:
 Model=aMtxro6 0E040L                          , FwRev=AN6R5109, 
SerialNo=1EG100EE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4


# hdparm -i /dev/hda                    Maxtor 4D040H2, good disk
/dev/hda:
 Model=Maxtor 4D040H2, FwRev=DAH017K0, SerialNo=D22AKNYE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80043264
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4

# hdparm -I /dev/hda
/dev/hda:
 Model=aMtxro4 0D042H                          , FwRev=AD0H710K, 
SerialNo=2DA2NKEY
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=off
 DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80043264
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4

Regards

Harald Schäfer
-- 
General Logistics Systems
Thomas Mieslinger
German-Parcel-Str. 1-7     fon: +49 6677 17 463
36286 Neuenstein            fax: +49 6677 17 111
Germany                           eMail: thomas.mieslinger@gls-germany.com
