Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSDOT2o>; Mon, 15 Apr 2002 15:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSDOT2n>; Mon, 15 Apr 2002 15:28:43 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:61452 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313182AbSDOT2m>;
	Mon, 15 Apr 2002 15:28:42 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: axboe@suse.de
Date: Mon, 15 Apr 2002 21:28:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] IDE TCQ #4
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <27670700DF5@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr 02 at 21:11, Petr Vandrovec wrote:
> On 15 Apr 02 at 21:00, Jens Axboe wrote:
> > > 
> > > NULL pointer ...
> > 
> > Could you decode that? It doesn't look like any of your drives support
> > TCQ, it should have enabled them right here:
> 
> They were already decoded... Also others reported that - after accessing
> /proc/ide/ide0/hda/identify system dies... I believe that passing
> hand-created request to ide_raw_taskfile corrupts drive->free_req,
> and so subsequent drive command after this cat finds that 
> drive->free_req.next is NULL and dies.

ide_raw_taskfile() sets rq.special to &ar - and &ar is on the stack,
in this function. Later it falls through to __ide_end_request(), which
does

  ar = rq->special;
  ...
  if (ar)
    ata_ar_put(drive, ar);
    
which adds this ar into drive's free_req chain unconditionally. Maybe 
ata_ar_put should check for ar_queue validity. And where ar_queue
member is initialized (or at least cleared) in this case at all?

Unfortunately here my knowledge ends.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
