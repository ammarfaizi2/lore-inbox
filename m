Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbVHIUMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVHIUMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbVHIUMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:12:36 -0400
Received: from mxsf27.cluster1.charter.net ([209.225.28.227]:27561 "EHLO
	mxsf27.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932565AbVHIUMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:12:35 -0400
X-IronPort-AV: i="3.96,93,1122868800"; 
   d="scan'208"; a="1423790437:sNHT17542614"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17145.3629.933024.963438@smtp.charter.net>
Date: Tue, 9 Aug 2005 16:12:29 -0400
From: "John Stoffel" <john@stoffel.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: John Stoffel <john@stoffel.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
In-Reply-To: <1123617516.5170.42.camel@mulgrave>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
	<200508081954.52638.jesper.juhl@gmail.com>
	<17145.1417.329260.524528@smtp.charter.net>
	<1123617516.5170.42.camel@mulgrave>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Bottomley <James.Bottomley@SteelEye.com> writes:

Thank you for looking into this with me, I really appreciate it.  I'm
kinda stumped why this suddenly started happening, but it could be
hardware related of course...

James> So basically the problem is on scsi1 with the tape device, which
James> apparently negotiates only narrow async?

It's not a performance problem, it's a lockup problem.  I use bacula
to make my backups using the DLT7000 as my media.  But the tape drives
hangs, it's hung now so that I can't do my backups.

James> What do the domain validation messages say about this device?
James> They should be in dmesg.  I'm fairly certain that DLT tapes do
James> better than narrow async.

The drive should be able to do 10MBytes/sec to the interface, the
drive itself can only do 5Mbytes/sec to the media, but with 2:1
compression and an 8MB buffer on the drive, it likes to be fed data as
quickly as it can.  

Here's the validation results for my two disks and tape drive:

  scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
	  <Adaptec aic7890/91 Ultra2 SCSI adapter>
	  aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

   target0:0:0: asynchronous.
    Vendor: COMPAQ    Model: HC01841729        Rev: 3208
    Type:   Direct-Access                      ANSI SCSI revision: 02
  scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
   target0:0:0: Beginning Domain Validation
   target0:0:0: wide asynchronous.
   target0:0:0: Domain Validation skipping write tests
   target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
   target0:0:0: Ending Domain Validation
    Vendor: COMPAQ    Model: BD018222CA        Rev: B016
    Type:   Direct-Access                      ANSI SCSI revision: 02
   target0:0:1: asynchronous.
  scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
   target0:0:1: Beginning Domain Validation
   target0:0:1: wide asynchronous.
   target0:0:1: Domain Validation skipping write tests
   target0:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 63)
   target0:0:1: Ending Domain Validation
  scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
	  <Adaptec aic7880 Ultra SCSI adapter>
	  aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

    Vendor: SUN       Model: DLT7000           Rev: 1E48
    Type:   Sequential-Access                  ANSI SCSI revision: 02
   target1:0:6: asynchronous.
   target1:0:6: Beginning Domain Validation
   target1:0:6: wide asynchronous.
   target1:0:6: Domain Validation skipping write tests
   target1:0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 8)
   target1:0:6: Ending Domain Validation
  st: Version 20050501, fixed bufsize 32768, s/g segs 256
  Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
  st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
  SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
  SCSI device sda: drive cache: write through
  SCSI device sda: 35566000 512-byte hdwr sectors (18210 MB)
  SCSI device sda: drive cache: write through
   sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
  Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
  SCSI device sdb: drive cache: write through
  SCSI device sdb: 35565080 512-byte hdwr sectors (18209 MB)
  SCSI device sdb: drive cache: write through
   sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
  Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
