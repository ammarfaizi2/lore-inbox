Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQKQXHu>; Fri, 17 Nov 2000 18:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129504AbQKQXHk>; Fri, 17 Nov 2000 18:07:40 -0500
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:271 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129431AbQKQXHa>; Fri, 17 Nov 2000 18:07:30 -0500
Date: Fri, 17 Nov 2000 23:26:52 +0100
From: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
To: Andries.Brouwer@cwi.nl
Cc: koenig@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, kobras@tat.physik.uni-tuebingen.de
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Message-ID: <20001117232652.A1455@turtle.tat.physik.uni-tuebingen.de>
In-Reply-To: <UTC200011172141.WAA134635.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200011172141.WAA134635.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Nov 17, 2000 at 10:41:49PM +0100
X-fingerprint: 3B CD 5A A9 73 44 DD 04  A0 4E A0 34 20 7B 1E 38
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 17, Andries.Brouwer@cwi.nl wrote:

> 
> > > +               if (cpnt)
> > > +                       kfree(cpnt);
> 
> > this seems to make things much worse
> 
> Yes, I meant
> 
> 		if (cpnt) {
> 			kfree(cpnt);
> 			cpnt = NULL;
> 		}
> 
> at that place, otherwise things will be freed multiple times.

_MUCH_ better now!!!  no lockups anymore, no memory leak(s).


BUT:  there is still this small performace and memory usage issue:

each of these CDs contains >80k files in ~110 directories each
(the full db consists of 18 CDs!) and running "find" or "du"
on one CDROM (or 4MB isofs loop mount from hard disk) takes
a huge amount of time (real and system cpu) with cold cache:

	time find /cdrom
	0.610u 97.250s 1:40.58 97.2%    0+0k 0+0io 98pf+0w

flush cache...

	time du /cdrom
	0.470u 97.220s 1:40.29 97.4%    0+0k 0+0io 112pf+0w


whereas with hot cache (takes ~45MB memory off the value
for "free + buffer/cache" for a 4MB isofs image!) gives (PPro200, 128MB):

	time find /cdrom
	0.460u 1.280s 0:01.79 97.2%     0+0k 0+0io 102pf+0w

	time du /cdrom
	0.270u 1.260s 0:01.54 99.3%     0+0k 0+0io 108pf+0w



so it seems to work  (data still not checked, can do this only next week)
but performace really sucks :(



anyway, thanks a lot for your help and quick patch !  
now at least we can copy all the data to some hard disk
and use it that way.  

a patch for 2.2.x (the real production machine can't run 2.4.x yet)
and/or fixes for the bad performace would be appreciated anyway ;^)




thanks!

Harald
-- 
All SCSI disks will from now on                     ___       _____
be required to send an email notice                0--,|    /OOOOOOO\
24 hours prior to complete hardware failure!      <_/  /  /OOOOOOOOOOO\
                                                    \  \/OOOOOOOOOOOOOOO\
                                                      \ OOOOOOOOOOOOOOOOO|//
Harald Koenig,                                         \/\/\/\/\/\/\/\/\/
Inst.f.Theoret.Astrophysik                              //  /     \\  \
koenig@tat.physik.uni-tuebingen.de                     ^^^^^       ^^^^^
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
