Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315597AbSENKX6>; Tue, 14 May 2002 06:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315598AbSENKX5>; Tue, 14 May 2002 06:23:57 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46858 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315597AbSENKX4>; Tue, 14 May 2002 06:23:56 -0400
Message-ID: <3CE0D6DE.8090407@evision-ventures.com>
Date: Tue, 14 May 2002 11:20:30 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: tomita <tomita@cinet.co.jp>
CC: Martin Dalecki <dalecki@evision-venures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE PIO write Fix #2
In-Reply-To: <3CE0795B.62C956F0@cinet.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik tomita napisa?:
> Hi.
> This patch solves problem (for me)
> "kernel stops without message at heavy usage of IDE HDD".
> But, "hda: lost interrupt" message appears, instead. 
> My BOX has both IDE and SCSI HDD.
> This message appears at accessing SCSI HDD by another
> task, during IDE heavy accsess.
> I guess, IDE driver has "critical section" needing "cli"
> (and so on).
> Any suggestions ?
> 
> --- linux-2.5.15/drivers/ide/ide-taskfile.c.orig	Fri May 10 11:49:35 2002
> +++ linux-2.5.15/drivers/ide/ide-taskfile.c	Tue May 14 10:40:43 2002
> @@ -606,7 +606,7 @@
>  		if (!ide_end_request(drive, rq, 1))
>  			return ide_stopped;
>  
> -	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
> +	if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
>  		pBuf = ide_map_rq(rq, &flags);
>  		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);


Hmm. There is something else that smells in the above, since the XOR operator
doesn't seem to be proper. Why shouldn't we get DRQ_STAT at all on short
request? Could you perhaps just try to replace it with an OR?

Thinking about the kernel hang and SCSI - I would have to ask whatever there
is really interrupt sharing between IDE and SCSI. If the hangs happen due to
the usage of ide-scsi then I already know what's going - ide-scsi doesn't
do proper locking on command submission to the ATA layer.

