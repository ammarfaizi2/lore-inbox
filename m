Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSKMWRc>; Wed, 13 Nov 2002 17:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSKMWRc>; Wed, 13 Nov 2002 17:17:32 -0500
Received: from ns.splentec.com ([209.47.35.194]:18446 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S262887AbSKMWRa>;
	Wed, 13 Nov 2002 17:17:30 -0500
Message-ID: <3DD2D110.C122D161@splentec.com>
Date: Wed, 13 Nov 2002 17:24:16 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Radford <aradford@3WARE.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3w-xxxx: additional ata->sense codes, avoid driver lockup
References: <A1964EDB64C8094DA12D2271C04B812672C867@tabby>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Radford wrote:
> 
> Luben,
> 
> Thanks for submitting the patch, however, it appears part of it is wrong:
> 
> -               if ((command->status == 0xc7) || (command->status == 0xcb))
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
