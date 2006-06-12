Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWFLJ15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWFLJ15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWFLJ15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:27:57 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:53916 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751338AbWFLJ14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:27:56 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606120922.k5C9MFMO011138@wildsau.enemy.org>
Subject: Re: Q: how to send ATA cmds to USB drive?
In-Reply-To: <1148469753.4753.4.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 12 Jun 2006 11:22:15 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > But now I also have to support USB harddisks from the same company.
> > The USB harddisk uses the same set of ATA commands as the IDE harddisk,
> > well, at least that's what I suppose.
> 
> USB storage is a sort of 'pigdin' SCSI. You send SCSI commands to the
> USB storage device but you may find anything too clever breaks.

hm, that depends 
on where "too much cleverness" is implemented.
I just noticed that scsi-commands I send to
via SG_IO get modified underway.

the userland program looks like this:

        memset(cmd,0,16);
        cmd[0]=0x24;
        cmd[1]=0x24;
        cmd[2]=0x01;
        cmd[3]=0x01;

        memset(&ioh,0,sizeof(ioh));
        ioh.interface_id='S';
        ioh.dxfer_direction=SG_DXFER_FROM_DEV;
        ioh.dxferp = buf;
        ioh.dxfer_len = 8;
        ioh.cmdp=cmd;
        ioh.cmd_len=16;
        ioh.sbp=sbuf;
        ioh.mx_sb_len=SG_MAX_SENSE;
        ioh.timeout = 2000;     // 2 sekunden
        ioh.flags = SG_FLAG_DIRECT_IO;

        if ((i=ioctl(fd,SG_IO,&ioh))==-1)
                die("ioctl");

but what's really sent to the device is:

> usb_stor_Bulk_transport
Bulk Command S 0x43425355 T 0x2a L 8 F 0 Trg 0 LUN 0 CL 16
> usb_stor_bulk_transfer_buf (length=31)
 55
 53
 42
 43
 2a
 00
 00
 00
 08
 00
 00
 00
 00
 00
 10
 24
 04
 01
 01
 00
 00
 00
 00
 00
 00
 00
 00
 00
 00
 00
 00

the data really sent is "0x24 0x04 0x01 0x01", which means that 0x20 gets
cleared in byte 2 (for whatever reason).

the specs I have (CY7C68310.pdf from http://www.rockbox.org/twiki/pub/Main/DataSheets/)
say that this field has to be 0x24 for ATACB commands. this is on page12. with the
ATACB, I want to implement TaskFileRead and TaskFileWrite (page 13).
the device is a "Low-Power USB 2.0 ATA/ATPAI Bridge IC".

do you have any idea why the data is modified and how I can prevent this?

kind regards,
herbert rosmanith

