Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbTGON0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbTGON0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:26:06 -0400
Received: from [212.34.224.163] ([212.34.224.163]:15373 "HELO rod.elitel.it")
	by vger.kernel.org with SMTP id S267614AbTGON0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:26:01 -0400
Date: Tue, 15 Jul 2003 02:03:50 +0200
From: Federico Stella <derfel@alessandria.linux.it>
To: linux-kernel@vger.kernel.org
Subject: Re: DVD/CD Read Problem: cdrom_decode_status: status=0x51 {DriveReady SeekComplete Error}
Message-ID: <20030715000350.GA2004@lorien.arda>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200307131950.44923.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307131950.44923.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* domenica 13 luglio 2003, alle 19:51, Andrey Borzenkov scrive:

>> I get the following errors and an unkillable process when trying to play
>> DVDs, using the latest 2.5.75: 

>> Jul 13 00:15:03 joehill kernel: hdc: cdrom_decode_status: status=0x51 { 
> DriveReady SeekComplete Error }
>> Jul 13 00:15:03 joehill kernel: hdc: cdrom_decode_status: 
> error=0x30LastFailedSense 0x03 

> this is ide-cd problem. drivers/ide/ide-cd:cdrom_decode_status():

>                } else if ((err & ~ABRT_ERR) != 0) {
>                         /* Go to the default handler
>                            for other errors. */
>                         DRIVER(drive)->error(drive, 
> "cdrom_decode_status",stat);
>                         return 1;
>                 } else if (sense_key == MEDIUM_ERROR) {
>                         /* No point in re-trying a zillion times on a bad
>                          * sector...  If we got here the error is not 
> correctabl
> e */
>                         ide_dump_status (drive, "media error (bad sector)", 
> stat
> );
>                         cdrom_end_request(drive, 0);


> The above sense key is exactly MEDIUM_ERROR but driver never has chance to 
> stop "retring zillion times" simply because it immediately falls down into 
> driver->error again. So "innocent" media error results half an hour retries 
> and disabled DMA.

Yesterday I've found a similar problem using 2.5.75. Trying to read a DVD
with a ASUS CD-S500/A the machine gives some errors in log then freezes.

>From log:
 kernel: hdb: timeout waiting for DMA
 kernel: hdb: timeout waiting for DMA
 kernel: hdb: (__ide_dma_test_irq) called while not waiting
 kernel: hdb: status timeout: status=0xd0 { Busy }
 kernel: hdb: status timeout: error=0x00
 kernel: hdb: drive not ready for command
 kernel: hdb: ATAPI reset complete
 kernel: hdb: cdrom_decode_status: status=0x51 { DriveReady SeekComplete Error }
 kernel: hdb: cdrom_decode_status: error=0x30LastFailedSense 0x03

I've swapped the two conditions and after 5 "Bad Sector" the machine runs normally.



