Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUICP7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUICP7T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 11:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269072AbUICP7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 11:59:19 -0400
Received: from gsstark.mtl.istop.com ([66.11.160.162]:45958 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S269066AbUICP7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 11:59:11 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Stark <gsstark@mit.edu>, Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>
	<87u0ugt0ml.fsf@stark.xeocode.com>
	<1094209696.7533.24.camel@localhost.localdomain>
	<87d613tol4.fsf@stark.xeocode.com>
	<1094219609.7923.0.camel@localhost.localdomain>
In-Reply-To: <1094219609.7923.0.camel@localhost.localdomain>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 03 Sep 2004 11:58:07 -0400
Message-ID: <877jrbtkds.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Gwe, 2004-09-03 at 15:27, Greg Stark wrote:
> > Well I still have a problem. It seems once this occurs that *every* further
> > access generates the error.
> 
> If you are accessing it through the file system I'd expect that to an
> extent.

I've even unmounted the filesystem and tried mounting it again. Now I can't
even mount it without generating the error.

It seems like once I get the "ATA: abnormal status 0x59 on port 0xEFE7" error
the device becomes completely inaccessible.

Whereas before I get the "abnormal status" error I can mount the filesystem,
and read some of the directories just fine. Even once I hit the bad section I
can still access the good areas. It's only once I've hit the bad section
enough to trigger this message that the entire disk becomes inaccessible.

> Is this true copying the raw device ?

Well using "dd bs=512 if=/dev/sda4 of=/dev/null" I see errors on every block.
The errors below are from the dd. Notice the errors are for every logical
block starting at block 1.

I haven't gotten to writing a program to use O_DIRECT yet. But this is a
pretty strong indictment. Since the filesystem worked fine before the error I
know the superblock can be read at least.

Sep  3 11:48:39 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 11:48:39 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 11:48:39 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 11:48:39 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e 4f f7 81 00 00 7f 00 
Sep  3 11:48:39 stark kernel: Current sda: sense = 70  3
Sep  3 11:48:39 stark kernel: ASC=13 ASCQ= 0
Sep  3 11:48:39 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 11:48:39 stark kernel: end_request: I/O error, dev sda, sector 240121729
Sep  3 11:48:39 stark kernel: Buffer I/O error on device sda4, logical block 1
Sep  3 11:48:39 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 11:48:39 stark last message repeated 2 times
Sep  3 11:49:09 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 11:49:09 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 11:49:09 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 11:49:09 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e 4f f7 82 00 00 7e 00 
Sep  3 11:49:09 stark kernel: Current sda: sense = 70  3
Sep  3 11:49:09 stark kernel: ASC=13 ASCQ= 0
Sep  3 11:49:09 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 11:49:09 stark kernel: end_request: I/O error, dev sda, sector 240121730
Sep  3 11:49:09 stark kernel: Buffer I/O error on device sda4, logical block 2
Sep  3 11:49:09 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 11:49:09 stark last message repeated 2 times
Sep  3 11:49:39 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 11:49:39 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 11:49:39 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 11:49:39 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e 4f f7 83 00 00 7d 00 
Sep  3 11:49:39 stark kernel: Current sda: sense = 70  3
Sep  3 11:49:39 stark kernel: ASC=13 ASCQ= 0
Sep  3 11:49:39 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 11:49:39 stark kernel: end_request: I/O error, dev sda, sector 240121731
Sep  3 11:49:39 stark kernel: Buffer I/O error on device sda4, logical block 3
Sep  3 11:49:39 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 11:49:39 stark last message repeated 2 times
Sep  3 11:50:09 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 11:50:09 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 11:50:09 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 11:50:09 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e 4f f7 84 00 00 7c 00 
Sep  3 11:50:09 stark kernel: Current sda: sense = 70  3
Sep  3 11:50:09 stark kernel: ASC=13 ASCQ= 0
Sep  3 11:50:09 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 11:50:09 stark kernel: end_request: I/O error, dev sda, sector 240121732
Sep  3 11:50:09 stark kernel: Buffer I/O error on device sda4, logical block 4
Sep  3 11:50:09 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 11:50:09 stark last message repeated 2 times
Sep  3 11:50:39 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 11:50:39 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 11:50:39 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 11:50:39 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e 4f f7 85 00 00 7b 00 
Sep  3 11:50:39 stark kernel: Current sda: sense = 70  3
Sep  3 11:50:39 stark kernel: ASC=13 ASCQ= 0
Sep  3 11:50:39 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 11:50:39 stark kernel: end_request: I/O error, dev sda, sector 240121733
Sep  3 11:50:39 stark kernel: Buffer I/O error on device sda4, logical block 5
Sep  3 11:50:39 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 11:50:39 stark last message repeated 2 times
Sep  3 11:51:09 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 11:51:09 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 11:51:09 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 11:51:09 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e 4f f7 86 00 00 7a 00 
Sep  3 11:51:09 stark kernel: Current sda: sense = 70  3
Sep  3 11:51:09 stark kernel: ASC=13 ASCQ= 0
Sep  3 11:51:09 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 11:51:09 stark kernel: end_request: I/O error, dev sda, sector 240121734
Sep  3 11:51:09 stark kernel: Buffer I/O error on device sda4, logical block 6
Sep  3 11:51:09 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 11:51:09 stark last message repeated 2 times
Sep  3 11:51:39 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 11:51:39 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 11:51:39 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 11:51:39 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e 4f f7 87 00 00 79 00 
Sep  3 11:51:39 stark kernel: Current sda: sense = 70  3
Sep  3 11:51:39 stark kernel: ASC=13 ASCQ= 0
Sep  3 11:51:39 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 11:51:39 stark kernel: end_request: I/O error, dev sda, sector 240121735
Sep  3 11:51:39 stark kernel: Buffer I/O error on device sda4, logical block 7
Sep  3 11:51:39 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7
Sep  3 11:51:39 stark last message repeated 2 times
Sep  3 11:52:09 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
Sep  3 11:52:09 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
Sep  3 11:52:09 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
Sep  3 11:52:09 stark kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 0e 4f f7 88 00 00 78 00 
Sep  3 11:52:09 stark kernel: Current sda: sense = 70  3
Sep  3 11:52:09 stark kernel: ASC=13 ASCQ= 0
Sep  3 11:52:09 stark kernel: Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x13 0x00 0x00 0x00 0x00 0x00 
Sep  3 11:52:09 stark kernel: end_request: I/O error, dev sda, sector 240121736
Sep  3 11:52:09 stark kernel: Buffer I/O error on device sda4, logical block 8
Sep  3 11:52:09 stark kernel: ATA: abnormal status 0x59 on port 0xEFE7



-- 
greg

