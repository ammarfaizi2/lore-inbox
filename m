Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315478AbSEHBoK>; Tue, 7 May 2002 21:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315479AbSEHBoJ>; Tue, 7 May 2002 21:44:09 -0400
Received: from pop.gmx.net ([213.165.64.20]:62967 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315478AbSEHBoI> convert rfc822-to-8bit;
	Tue, 7 May 2002 21:44:08 -0400
Reply-To: <bPObject@axelero.hu>
From: "P. Breuer" <bPObject@gmx.ch>
To: <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: silent data corruption using HPT370 on an ABIT VP6
Date: Wed, 8 May 2002 03:43:59 +0200
Message-ID: <EGEOJJNFHLHGOKNADENLOEGCCFAA.bPObject@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Silent disk corruption using HPT370 on an ABIT VP6

2. I have tracked down a crooked bug somewhere in the IDE driver
   leading to a slow and silent data corruption, which is a most alarming threat
   for the incautious. The case is simple: "cp file1 file2; diff file1 file2"
   shows differences under certain conditions.

3. Keywords: kernel, driver, ide, data corruption, i386

4. Kernel versions: 2.4.16 or 2.4.18 (error reproducible in both versions)

5. Hardware environment (details see below):
   ABIT VP6 motherboard including: dual Pentium III, VIA APOLLO PRO chipset
   VIA onboard EIDE controller,
   HPT370 "raid" UDMA/100 controller, integrated on board
   Promise TX2 (PDC) UDMA/100 PCI controller card
   Hard disks (all masters):
     2 x 6GB Quantum Fireball EX6.4A on VIA,
     2 x 40GB Quantum FireballP AS40.0 on PDC,
     2 x 40GB Quantum FireballP AS40.0 on HPT

6. Software environment:
   IDE driver (kernel-integrated)
   raidtools-0.90-5 (optional)
   General: four 40GB disks of identical geometry have three partitions each,
     same partitioning, identified by /dev/hd[e,g,i,k][1-3],
     /dev/md[0-2} are three RAID-5 arrays defined on the four disks accordingly
     each out of three raid partitions are formatted ext3 with internal journal

7. ERROR description:
   Let "file1" be a "large" data file, e.g. 1GB, on a RAID array described above.
   Then "cp file1 file2; cmp -l file1 file2" shows (subtle) differences.
   There are random differences on several random spots between the files.
   The "spots" occur usually as blocks of few bytes in succession. The difference
   is up to several dozens of bytes at a 1GB file copy.

8. Tracking down the error:
   I have conducted over 100 test cases: the error is consistent, though random.

   First I excluded an error in the raid software:
     umount /dev/md[0-2]; raidstop /dev/md[0-2].
   I used a script to read all four raw disks concurrent:
   
   for d in e, g, i, k; do \
    (for i in 1 2 3 4 5; do \
      dd if=/dev/hd"$d"1 count=2500000 \
      2> /dev/null | md5sum; done \
    ) >> trc"$d".md5sum done
   
   I found NO differences in trce.md5sum and trcg.md5sum (both disks are on the
   Promise controller), but significant differences in trci.md5sum and trck.md5sum,
   displaying 3 and 5 different read results out of 5 identical reads, resp.
   (both disks are on the HPT370 controller).

   Oops!!!

   I stayed focused on the HPT370 controller, and compiled a small test environment with a
   single processor motherboard and a HPT370A PCI controller card, which, in addition, has
   the same HPT BIOS version (1.0.3b1) as the integrated one. I found no problem using this
   configuration, so the error might well be related only to the SMP architecture.

9. Solution or workaround?
   I browsed through the HighPoint Software web pages and found a remarkable replacement
   for the kernel IDE-driver. This is a SCSI IDE emulation module, called hpt37x2.o, that
   can be built for "any" 2.4.x kernel. And IT WORKS, at least for me, since at least two days ;)
   The only drawback is, that it is not GPL-d and the complete source is not available.
   The existence of a working driver is a profound proof for the kernel driver to be in error!

10. Attachments:
   I have saved several files out of /proc, boot log, etc. from the test period,
   i.e. by using the faulty driver. They are available upon request. Due to the fact, that the
   HPT driver is not a native IDE-driver, but a SCSI-emulation, it is not possible to switch
   between booting the old and new kernels very easily. One example, the raid arrays are not
   recognised from the foreign configuration.

Peter Breuer [P.Breuer@freemail.hu]
   

