Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265251AbUEMXak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUEMXak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUEMXaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:30:39 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:48013 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S265237AbUEMXaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:30:18 -0400
Message-ID: <40A404A5.8070500@keyaccess.nl>
Date: Fri, 14 May 2004 01:28:37 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
References: <200405132116.44201.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405132116.44201.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Comments, suggestions, complains?

Yes, this works to stop it from complaining (on 6Y120P0). It comes up 
with write cache enabled, and hdparm -W0/-W1 work to disable/enable 
write cache as evidenced by the tiobench results. Not as evidenced by 
/proc/ide/hda/settings (drive->wcache) which is always 1 and which will 
probably confuse more users than just me -- I believe I saw hdparm just 
pushes a drive command through an ioctl?

Question though:

> @@ -1678,8 +1683,12 @@ static void idedisk_setup (ide_drive_t *
>  #endif	/* CONFIG_IDEDISK_MULTI_MODE */
>  	}
>  	drive->no_io_32bit = id->dword_io ? 1 : 0;
> -	if (drive->id->cfs_enable_2 & 0x3000)
> -		write_cache(drive, (id->cfs_enable_2 & 0x3000));
> +
> +	/* write cache enabled? */
> +	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
> +		drive->wcache = 1;
> +
> +	write_cache(drive, 1);

write_cache() also sets drive->wcache (to the argument, 1 in this case) 
and you call that unconditionally, so the "if (foo) drive->wcache = 1" 
seems superfluous. If the idea indeed is to unconditionally enable write 
cache, it seems just

write_cache(drive, 1);

would be equivalent. Or if that wasn't the intention, maybe:

if (foo)
	write_cache(drive, 1);

or if it should in fact be disabled if (!foo):

write_cache(drive, (id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)));

or ...

Ignore me if I completely missed the point, just looks odd.

Rene.
