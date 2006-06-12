Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751734AbWFLKIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbWFLKIU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWFLKIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:08:20 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:55196 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751730AbWFLKIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:08:19 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606121002.k5CA2gGf011148@wildsau.enemy.org>
Subject: Re: Q: how to send ATA cmds to USB drive?
In-Reply-To: <200606120922.k5C9MFMO011138@wildsau.enemy.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Jun 2006 12:02:41 +0200 (MET DST)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the userland program looks like this:
> 
>         memset(cmd,0,16);
>         cmd[0]=0x24;
>         cmd[1]=0x24;
>         cmd[2]=0x01;
>         cmd[3]=0x01;
...
>         if ((i=ioctl(fd,SG_IO,&ioh))==-1)
>                 die("ioctl");
> 
...
> the data really sent is "0x24 0x04 0x01 0x01", which means that 0x20 gets
> cleared in byte 2 (for whatever reason).
> 
> do you have any idea why the data is modified and how I can prevent this?

ok, got it:

        int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
        ...
                /*
                 * If SCSI-2 or lower, store the LUN value in cmnd.
                 */
                if (cmd->device->scsi_level <= SCSI_2) {
                        cmd->cmnd[1] = (cmd->cmnd[1] & 0x1f) |
                                       (cmd->device->lun << 5 & 0xe0);
                }

hm. now what .... ? If scsi-2 requires this, and the device is scsi-2 (in fact,
cmd->device->scsi_level equals 3, which means SCSI_2) then the device is a violation
of the scsi-specs. do you have any suggestion how to fix this (beside from commenting
the source)

kind regards,
herbert rosmanith

