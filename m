Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275050AbTHGBLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 21:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275052AbTHGBLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 21:11:50 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:49669 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S275050AbTHGBLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 21:11:49 -0400
Date: Thu, 7 Aug 2003 03:11:46 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Message-ID: <20030807011146.GB5454@win.tue.nl>
References: <20030806181142.GD25910@codepoet.org> <Pine.SOL.4.30.0308062024180.10247-300000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0308062024180.10247-300000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 08:32:23PM +0200, Bartlomiej Zolnierkiewicz wrote:

> diff -puN drivers/ide/ide-disk.c~ide-disk-capacity-init-cleanup drivers/ide/ide-disk.c
> --- linux-2.6.0-test2-bk5/drivers/ide/ide-disk.c~ide-disk-capacity-init-cleanup	2003-08-06 02:48:33.000000000 +0200

Ha - and you didnt even tell me you had this patch out.

Looks good.
You forgot to correct the do_div.
The part I most object to are things like

> +	id->lba_capacity_2 = capacity_2 = set_max_ext;

There have been many problems in the past, and it is a bad idea to add
more of this. We should be eliminating all cases.

I mean: 

We have info from BIOS, user, disk etc and conclude to a certain geometry.
Sneakily changing what the disk reported is very ugly. I recall a case
where a disk bounced between two capacities because the value that this
computation concluded to was not a fixed point. Also, the user gets an
incorrect report from HDIO_GET_IDENTITY.

So, the clean way is to examine what the disk reported, never change it
(except for the part

--------------------------------------------------------------
void ide_fix_driveid (struct hd_driveid *id)
{
#ifndef __LITTLE_ENDIAN
# ifdef __BIG_ENDIAN
        int i;
        u16 *shortcast;

        shortcast = (u16 *) id;
        for (i = 0; i < (sizeof(struct hd_driveid) / 2); i++)
                shortcast[i] = __le16_to_cpu(shortcast[i]);
# else
#  error "Please fix <asm/byteorder.h>"
# endif
#endif
}
--------------------------------------------------------------

that brings shorts into CPU order)
and store the results elsewhere. In particular, our conclusions
should go into drive->capacity and should not overwrite
id->lba_capacity.

Andries

[will try to find the appropriate fragment of my patch again
for comparison purposes]


