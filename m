Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWFLKbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWFLKbs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWFLKbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:31:48 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:56476 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751825AbWFLKbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:31:47 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606121026.k5CAQA9S011158@wildsau.enemy.org>
Subject: Re: Q: how to send ATA cmds to USB drive?
In-Reply-To: <200606121002.k5CA2gGf011148@wildsau.enemy.org>
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Jun 2006 12:26:10 +0200 (MET DST)
CC: alan@lxorguk.ukuu.org.uk
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
>         ...
>                 /*
>                  * If SCSI-2 or lower, store the LUN value in cmnd.
>                  */
>                 if (cmd->device->scsi_level <= SCSI_2) {
>                         cmd->cmnd[1] = (cmd->cmnd[1] & 0x1f) |
>                                        (cmd->device->lun << 5 & 0xe0);
>                 }
> 
> hm. now what .... ? If scsi-2 requires this, and the device is scsi-2.

actually, the scsi-level reported by the device is *not* 2.

it is set to 2 by "slave_configure" from drivers/usb/storage/scsiglue.c:

static int slave_configure(struct scsi_device *sdev)
{
...
        /* Set the SCSI level to at least 2.  We'll leave it at 3 if that's
         * what is originally reported.  We need this to avoid confusing
         * the SCSI layer with devices that report 0 or 1, but need 10-byte
         * commands (ala ATAPI devices behind certain bridges, or devices
                                              ^^^^^^^^^^^^^^^

the CY7C68310 is exactly that.

         * which simply have broken INQUIRY data).
...

        if (sdev->scsi_level < SCSI_2)
                sdev->scsi_level = sdev->sdev_target->scsi_level = SCSI_2;


kind regards,
h.rosmanith
