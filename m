Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVLNXvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVLNXvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVLNXvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:51:09 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:11364 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965124AbVLNXvH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:51:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UdVQEW5CW+7fLshOBOcp4HVNM5nNyEcMRMmRN7cGLk9i9C4i3B2Eu/4vs8pBzocG7llN2Sd1trP8fVdo1OlP9oC08uU1hwzcTYt1uz0KVIAMd3eOO55Ce88LKE3TBWuRoTE+D5FAsxTXJvdv9R0T1PM53eJ6Q1STUcLM12MLrTs=
Message-ID: <5b5833aa0512141551l638b2c05xcd4588a9370bfa51@mail.gmail.com>
Date: Wed, 14 Dec 2005 19:51:06 -0400
From: Anderson Lizardo <anderson.lizardo@gmail.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Cc: Anderson Briglia <anderson.briglia@indt.org.br>,
       Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>
In-Reply-To: <439FC4A6.4010900@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051213213208.303580000@localhost.localdomain>
	 <439F4AD6.9090203@indt.org.br> <439FC4A6.4010900@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Anderson Briglia wrote:
> > - Password caching: when inserting a locked card, the driver should try to
> >   unlock it with the currently stored password (if any), and if it fails,
> >   revoke the key containing it and fallback to the normal "no password present"
> >   situation.
> >
>
> Would it be possible to use the id of the card as a search key for the
> password? That way several passwords can coexist.

Yes, we have plans for that. The keys managed by the key retention
service have a description field that can be used to uniquely identify
keys and allows searching for specific keys. For this first version of
the code, we are using simply "mmc:key" as the description, which does
not allow more than one MMC password to be stored at a time.

Probably using the entire 128-bit CID for the key description would
waste too much space though, so we are thinking about using just some
CID fields to build a smaller unique ID. The key retention service has
quotas for how much space a keyring can use for payload and key
description, so we should try to keep the description as short as
possible. If a collision occurs and the password is wrong, we can
simply invalidate the key and ask for the password again.

> > - Currently, some host drivers assume the block length will always be a power
> >   of 2. This is not true for the MMC_LOCK_UNLOCK command, which is a block
> >   command that accepts arbitratry block lengths. We have made the necessary
> >   changes to the omap.c driver (present on the linux-omap tree), but the same
> >   needs to be done for other hosts' drivers.
> >
>
> The MMC layer is designed that way, so it's hardly surprising that
> drivers have been coded for it. I'm assuming you've removed blksz_bits
> in favor of something in bytes?

I actually just did the following change to the OMAP code (drivers/mmc/omap.c):

-
-	block_size = 1 << data->blksz_bits;
+	/*  password protection: we need to send the exact block size to the
+	 *  card (password + 2), not a 2-exponent. */
+	if (req->cmd->opcode == MMC_LOCK_UNLOCK)
+		block_size = data->sg[0].length;
+	else
+		block_size = 1 << data->blksz_bits;

Given that for the LOCK_UNLOCK command the sg_len will always be 1, we
can get the block size directly from the first entry of the
scatterlist. For other block operations, the blksz_bits value is used
as usual.

Maybe removing blksz_bits and using the block size directly would be
better? Is there any host/card which expects to always receive a
power-of-2 block size for block operations?
--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
