Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbQKMSxn>; Mon, 13 Nov 2000 13:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbQKMSxe>; Mon, 13 Nov 2000 13:53:34 -0500
Received: from linux.viasys.com ([194.252.219.193]:1028 "EHLO linux.viasys.com")
	by vger.kernel.org with ESMTP id <S129211AbQKMSxV>;
	Mon, 13 Nov 2000 13:53:21 -0500
Date: Mon, 13 Nov 2000 20:53:05 +0200
From: Ville Herva <vherva@viasys.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: kai.makisara@metla.fi, skarkkai@woods.iki.fi, mkp@viasys.com,
        a-it@viasys.com
Subject: 2.2.18pre19 and HP DAT40i: mysterious medium error
Message-ID: <20001113205305.A1361@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem: 
  When writing to /dev/st0, I get 

  st0: Error with sense data: [valid=0] Info fld=0x0, Deferred
  st09:00: sense key Medium Error
  Additional sense indicates Track following error
  st0: Error with sense data: Info fld=0x0, Current st09:00: sense key
   Medium Error
  Additional sense indicates Sequential positioning error
  st0: Error on write filemark.

  after some gigs. The writing stops and tar (or whatever I'm using)
  reports an error. The test command I usually use is

  dd if=/dev/sda of=/dev/st0 bs=65536

  but others fail as well (see below).

The hardware:
        o Tyan S1832 DL Tiger 100 motherboard (440BX)
	  BIOS upgraded to 1.18 (newer ones (2.x) do not support PII)
        o 2x PII 300Mhz Klamath
        o 2x 128MB DIMM        
        o Seagate Barracuda 9GB 7200RPM SCSI-levy (narrow-scsi)
        o 2x IBM 34 GXP 34GB 7200rpm IDE
        o floppy drive
        o Matrox Millennium G200 display adapter
        o 3COM 905B 100/10 NIC
        o Adaptec 2940-UW Pro SCSI adapter, newest firmware
        o HP DAT40i (internal, wide) C5683A  Firmware rev: C908
(2940 is the SCSI adapter HP recommends to be used with this tape drive.)

The software:
        x kernel 2.2.18pre19 + RAID-2.2.17-A0 + IDE-2.2.18-17.all.20001027
	  + e2compr-0.4.38 + lm_sensors
	o tar-1.13.17
	o dd 4.0p
	o glibc-2.1.3-21
	o redhat-6.2 + updates in general

What I have tried (I hope I remember everything):
        o tar from fs. Same result.
	x dd if=/dev/hdc etc. Same problem.
	o MANY different values for dd bs=X/tar --block-factor=X.
        o Cleansing tape, dozens of times. That's not it.
	o Tens of different tapes: 40GB DATs, 24GB DATs, ones that came with 
	  the drive, ones from different batch, different brand. Always the 
	  same error.
        o Different tape drive: HP 24i C1537A internal, narrow. Same 
	  problem (The problem originally appeared with this combo.)
        x Upgrading from kernel-2.2.15pre17 + raid + ide + e2compr to
	  2.2.18pre19. The problem persist. (The problem originally 
	  appeared with 2.2.15pre17.)
        o kernel-2.2.15pre17 + newest st.c and aic7xxx.c. Problem
	  persists.
	o Different scsi cable. Didn't help.
	o Different order of the tape drive and the hard disk on the
	  cable. No cure.
	o Upgraded tape drive firmware (this was only possible on Windows
	  with the HP whizbangard tape admin program). No help.
	o Upgraded the scsi adapter firmware/bios. No help.
	o Kai Mäkisara suggested that this could be a heat or power supply
	  problem. I tried putting the drive on an external scsi rack 
	  that has its own power supply. The rack was open and the drive
	  was the only device in it. I'm sure it had enough power and cool 
	  air. Didn't help.
	x Different scsi adapter: Adaptec 29160. Same problem. On the 29160, 
	  the tape drive and the harddisk were on different buses. The
	  termination was surely correct as it was just as in the user's guide
	  of the tape drive: single device on the last connector of a 
	  terminated cable.
	x I also tried putting the harddisk on the 2940UW Pro and the tape 
	  drive 29160. Still the same message.
	x Different machines: on a Celeron 466, i815 and 2.2.18pre18 the same
	  scsi adapter and tape drive *do work*. I ran the test almost ten
	  times. With the same kernel (2.2.15pre16 + patches) it also worked
	  many many times, but failed ONCE when reading the tape with
	  *different* medium error. That could have been a cleansing problem,
	  since the problem went away after running the cleansing tape once. 
	  I also verified the 2.2.18pre19 kernel image I use on the problematic
	  machine works with this machine.
	x 2x200Ppro (440FX), 2.2.18pre18SMP. Different 2940 Adaptec, and a
    	  almost similar 9GB scsi disk (difference being that this one is wide
	  whereas the one on the problematic machine is narrow). Works like a
	  charm.
	x HP's TapeWare backup software with latest patches. (The setup blindly
  	  installs wrong version of the sgm.o kernel module the software
	  includes (anyone know what this sgm.o is for?). Even after 
	  installing the latest service pack and recompiling the kernel module,
	  TapeWare tends to hang often requiring a reboot.) When it works, it 
	  has a nice GUI, though, and I *was* able to produce the problem with
	  it, too. Different error message, of course.
	x And last... (drum roll)... I tried calling HP support. Despite my
  	  _very_ low expectations I was able to contact someone who knows what
	  a tape drive (and linux!) is. They suggested trying TapeAssure (diag
	  program of some sort), but there's no Linux version. They did even
	  call me back and suggest different SCSI adapter settings (lower
	  transfer rate etc). That didn't help. They said they were going to
	  bring the issue up "with their engineers" and I haven't heard of them
	  since.

(Kai: for your convenience, I've marked the points that I think I haven't
yet reported to you with 'x').

The place where the writing fails varies from 10MB to 20GB. On successive
trials with the same data, the point of failure *tends to be the same*,
even with different tapes! On fifth run or so, however, the writing
process may go much farther.

This could of course be caused by the RAID, IDE and/or e2compr patch, but
it seems a bit far fetched since the "dd if=/dev/sda of=/dev/st0" should
touch none of them (the two ide disks are md'd together, and the only
e2compr'd fs is on that device.)

I'm also a bit confused of the fact that the said dd command sometimes
yields transfer rate of ~3MB/s (for multiple gigas of same data) but
sometimes only ~1MB/s (with the same data, tape drive and scsi
adapter). What's also weird is that it seems that the failure rate has
gone up during these months of debugging. At first, it seemed to fail
maybe every second or third time, but now it happens practically every
time. On the other machines, it still works.

Originally I thought the problem was caused by too low input data rate
when tarring from the compressed fs. dd'ing the scsi disk should however
be fast enough.

There are absolutely no other problems with the machine or the kernel.
I've ran memtest's, kernel compilations (a la -j10), seti@homes etc and
even before installing more fans (before the tape drive was installed)
when the machine ran at >60C ambient temperature(!), there were NO
stability problems. The temperature inside the box and and on CPU's
remains well below 35C nowadays.

I'm _very_ low on ides here. The only thing I've not tried is installing
NT on the problematic machine, but I a somewhat hasty to do that since the
machine is in production use. The machine is known, though, to have worked
well with a 8GB scsi drive and the 2940UW in its previous life as an NT
workstation.

If anybody can suggest anything I could try, please do so... I'm also
interested in success/failure reports on similar hardware. If any
information is missing from this post, please ask.

I also want to thank Kai Mäkisara for his forbearing efforts with this
problems -- even though a solution is yet to be found.


--
Ville Herva            vhe@viasys.com                +358-50-5164500
Viasys Oy              Pohjantie 3  FIN-02100 Espoo  +358-9-4301460
PGP key available: http://www.iki.fi/v/pgp.html  fax +358-9-4301221
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
