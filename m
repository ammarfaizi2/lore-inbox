Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288811AbSAUWqQ>; Mon, 21 Jan 2002 17:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288827AbSAUWqH>; Mon, 21 Jan 2002 17:46:07 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:37896 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S288811AbSAUWpx>;
	Mon, 21 Jan 2002 17:45:53 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linuxdiskcert.org>
Date: Mon, 21 Jan 2002 23:45:00 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Linux 2.5.3-pre1-aia1
CC: <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <F9158D81E5D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did not want to participate in this discussion, as it is probably
impossible to explain to you that there is nothing wrong with doing
requests not evenly divisible by block size.

On 21 Jan 02 at 13:44, Andre Hedrick wrote:
> On Mon, 21 Jan 2002, Jens Axboe wrote:
> > On Mon, Jan 21 2002, Andre Hedrick wrote:
> > > > I always thought it is like this (and this is what I still believe after
> > > > having read the sprcification):
> > > > 
> > > > ---
> > > > SET_MUTIPLE 16 sectors
> > > > ---
> > > > READ_MULTIPLE 24 sectors
> > > > IRQ
> > > > PIO transfer 16 sectors
> > > > IRQ
> > > > PIO transfer 8 sectors
> > > > ---
> 
> 255 * 512bytes != 128K  BUG
> 256 * 512bytes == 128K
> 
> You insure we will fail on alignemnt.

SET MULTIPLE MODE description says that host should try block size only
1,2,4,8,16,32,64 or 128 sectors. So where you got 255 from?

> You have stated BLOCK can not deal with correct sector alignments, and
> thus 255 so please fix it first.  I have accepted this brokeness in BLOCK
> and dropped to 128 sectors or a clean 64k.
>
> If we restrict multi-sector PIO to 8 sectors we can do multi interrupt
> ATOMIC disk IO on the paging alignments, but you have enforced single
> sector IO in the multi-sector writing and can not see the difference.

Why we cannot do multi-sector PIO with 16...128 sectors? There is no need
to read all data with one insw() loop, you can store each of these
64kB of data in 65536 different, non-continuous, locations, and ATA device
will not complain, as it will always see 32768 of word reads from its
data port, nothing else... And no, there is no requirement that host
must do back-to-back reads or writes from ATA device data port. Otherwise
we would see upper bound on t0 in PIO-in and PIO-out cycles description.

> If rq->current_nr_sectors is less than 8 we do PIO single sector IO, but
> we are doing that now w/ the copy paste changes from the old ide-disk.c
> stuff that we are attempting deleting.

Please tell me what page 168 (it is number of paper page, page number
in PDF is by 14 greater) of Volume 2, Revision 0, of ATA/ATAPI rev.7
(T13/1532D) in description of READ MULTIPLE talks about?

If the number of requested sectors is not evenly divisible by the block
count, as many full blocks as possible are transferred, followed by a final,
partial block transfer. The partial block transfer shall be for n sectors,
where n = remainder (sector count/block count).

And almost identical text appears on page 296, where it talks about
WRITE MULTIPLE. 

If you are trying to persuade us that there are devices which support
ATA interface, and do not follow these paragraphs word by word, there
is certainly something wrong in the ATA world...
                            Best regards,
                                    Petr Vandrovec
                                    vandrove@vc.cvut.cz
                                    
