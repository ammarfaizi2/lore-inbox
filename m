Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319039AbSHFKNj>; Tue, 6 Aug 2002 06:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319040AbSHFKNj>; Tue, 6 Aug 2002 06:13:39 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:21520 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S319039AbSHFKNi>;
	Tue, 6 Aug 2002 06:13:38 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Marcin Dalecki <dalecki@evision.ag>
Date: Tue, 6 Aug 2002 12:16:45 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.5.30 IDE 113
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.50
Message-ID: <13A77E76028@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Aug 02 at 11:02, Marcin Dalecki wrote:
> diff -durNp -X /tmp/diff.hDAz3d linux-2.5.30/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
> --- linux-2.5.30/drivers/ide/ide-taskfile.c 2002-08-06 01:18:47.000000000 +0200
> +++ linux/drivers/ide/ide-taskfile.c    2002-08-04 02:24:49.000000000 +0200
> @@ -188,41 +188,26 @@ static ide_startstop_t special_intr(stru
>  
>  int ide_raw_taskfile(struct ata_device *drive, struct ata_taskfile *ar, char *buf)
>  {
> -   struct request *rq;
> -   unsigned long flags;
> +   struct request *rq = &drive->srequest;
>     struct ata_channel *ch = drive->channel;
>     request_queue_t *q = &drive->queue;
> -   struct list_head *queue_head = &q->queue_head;
>     DECLARE_COMPLETION(wait);
> -   struct request req;
>  
>  #ifdef CONFIG_BLK_DEV_PDC4030
>     if (ch->chipset == ide_pdc4030 && buf)
>         return -ENOSYS;  /* special drive cmds not supported */
>  #endif
>  
> -   memset(&req, 0, sizeof(req));
> -   rq = &req;
> -   
> -   rq->flags = REQ_SPECIAL;
> +   memset(rq, 0, sizeof(*rq));
> +

Hi Marcin,
  what synchronizes these accesses to make sure that you do not have
two ide_raw_taskfile requests on the flight, both using same 
drive->srequest? It looks to me like that nothing, so you can overwrite 
request's contents while somebody else already uses this buffer.
                                                     Petr Vandrovec
                                                     vandrove@vc.cvut.cz
                                                     
