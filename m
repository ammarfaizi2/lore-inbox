Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSKMWYI>; Wed, 13 Nov 2002 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSKMWYD>; Wed, 13 Nov 2002 17:24:03 -0500
Received: from 209-76-113-226.ded.pacbell.net ([209.76.113.226]:2097 "EHLO
	siamese.engr.3ware.com") by vger.kernel.org with ESMTP
	id <S264639AbSKMWXo>; Wed, 13 Nov 2002 17:23:44 -0500
Message-ID: <A1964EDB64C8094DA12D2271C04B812672C86A@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'Luben Tuikov'" <luben@splentec.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 3w-xxxx: additional ata->sense codes, avoid driver lo
	ckup
Date: Wed, 13 Nov 2002 14:32:35 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While there may need to be a fix so you don't loop on status=c1,flags=0x11,
you should know that:

command_packet->status is not a scsi or ATA register value at all.

(0xC1 == BSY|DRDY|ERR).
^^^^^^^^^^^^^^^^^^^^^^^^ this is not true.

-Adam

-----Original Message-----
From: Luben Tuikov [mailto:luben@splentec.com]
Sent: Wednesday, November 13, 2002 2:24 PM
To: Adam Radford
Cc: linux-scsi; linux-kernel
Subject: Re: [PATCH] 3w-xxxx: additional ata->sense codes, avoid driver
lockup


Adam Radford wrote:
> 
> Luben,
> 
> Thanks for submitting the patch, however, it appears part of it is wrong:
> 
> -               if ((command->status == 0xc7) || (command->status ==
0xcb))
> {
> +               if (command->status & 0xC1) {
> 
> What makes you think you should not check for c7 or cb, and only check c1?

Hi Adam,

I don't really ``only'' check for 0xc1, it just shows which bits I'm
interested in (0xc1 is a mask anded with the status).

In fact, I'm only interested in the error bit (ERR), but saw what you did
and decided to stay as close to 0xc7 and 0xcb, both of whom are in the 
subset of status & 0xC1, (0xC1 == BSY|DRDY|ERR). So in effect 0xC7 and 0xCB
still match.

Anyway, if you are throwing away

	if (command->status & 0xC1)

then you might as well throw away flags 0x11 from tw_sense_table[]
and then we're back at ``square 1'' -- this is exactly when the
driver gets into an inf. loop and eventually locks up the machine
and the serial console prints ... 
3w-xxxx: scsiX: Command failed:	status = 0xc1, flags = 0x11, unit #Y.
... ad infinitum.

I was just trying to avoid this deadlock.

-- 
Luben
