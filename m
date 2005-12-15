Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbVLOGtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVLOGtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVLOGts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:49:48 -0500
Received: from [85.8.13.51] ([85.8.13.51]:6579 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964789AbVLOGts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:49:48 -0500
Message-ID: <43A11204.2070403@drzeus.cx>
Date: Thu, 15 Dec 2005 07:49:40 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anderson Lizardo <anderson.lizardo@gmail.com>
CC: Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
References: <20051213213208.303580000@localhost.localdomain>	 <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx> <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com>
In-Reply-To: <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Lizardo wrote:

>Probably using the entire 128-bit CID for the key description would
>waste too much space though, so we are thinking about using just some
>CID fields to build a smaller unique ID. The key retention service has
>quotas for how much space a keyring can use for payload and key
>description, so we should try to keep the description as short as
>possible. If a collision occurs and the password is wrong, we can
>simply invalidate the key and ask for the password again.
>
>  
>

For SD cards we can also use the RCA, which tends to be a bit random.
Perhaps a generic hash function so that we can extend and tweak this
algorithm in one place?

>I actually just did the following change to the OMAP code (drivers/mmc/omap.c):
>
>-
>-	block_size = 1 << data->blksz_bits;
>+	/*  password protection: we need to send the exact block size to the
>+	 *  card (password + 2), not a 2-exponent. */
>+	if (req->cmd->opcode == MMC_LOCK_UNLOCK)
>+		block_size = data->sg[0].length;
>+	else
>+		block_size = 1 << data->blksz_bits;
>
>Given that for the LOCK_UNLOCK command the sg_len will always be 1, we
>can get the block size directly from the first entry of the
>scatterlist. For other block operations, the blksz_bits value is used
>as usual.
>
>  
>

I can't say that I approve of this code. It's my firm belief that
drivers that are protocol aware are horribly broken.

>Maybe removing blksz_bits and using the block size directly would be
>better? Is there any host/card which expects to always receive a
>power-of-2 block size for block operations?
>  
>

Sounds like a much better solution. Hacking around problems instead of
solving them usually lead to even more problems.

I haven't studied all drivers in detail, but I believe all of them
should be able to handle the transistion.

Rgds
Pierre

