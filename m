Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbTCMQxk>; Thu, 13 Mar 2003 11:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCMQxj>; Thu, 13 Mar 2003 11:53:39 -0500
Received: from jack.stev.org ([217.79.103.51]:19253 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id <S262480AbTCMQxi>;
	Thu, 13 Mar 2003 11:53:38 -0500
Message-ID: <017e01c2e983$865e9bd0$0cfea8c0@ezdsp.com>
From: "James Stevenson" <james@stev.org>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Stephan von Krawczynski" <skraw@ithnet.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
References: <20030227221017.4291c1f6.skraw@ithnet.com> <014b01c2e978$701050e0$0cfea8c0@ezdsp.com> <20030313163707.GH836@suse.de> <016c01c2e980$b2d4ee60$0cfea8c0@ezdsp.com> <20030313164617.GI836@suse.de>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Date: Thu, 13 Mar 2003 17:11:01 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Your explanation doesn't quite make sense, but I can take a look at
the
> > > problem :-)
> > >
> > > What kernel is the below oops from? What compiler?
> >
> > i can trigger this on any 2.4.x series kernel.
> > -> Insert dmaged / lightly scratched cd into drive
> >    dd /dev/scd0 bs=8192k of=file
> >    wait for opps.
> >    opps also cd tries to re read several times
> >    short hang then the following output
> >
> > gcc versions.
> > Whatever shits with redhat 7.1 + 7.2 + 7.3 and the
> > updates between them in each of the redhat versions.
> > but normally
> > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
> >
> > or
> > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)
>
> weee ok not my choice for compilers, but probably alright. do me a favor
> then:
>
> # cd /to/kernel/source
> # rm drivers/scsi/ide-scsi.o
> # EXTRA_CFLAGS=-g make drivers/scsi/ide-scsi.o
> # objdump -S drivers/scsi/ide-scsi.o > /tmp/some_file

i know longer have the source tree from what the opps was generated
from that was actually the 2.4.19 opps i posted but the kernel is now
2.4.20 it was the same trace and same place in the file i tracked it to
this point.

>From 2.4.20 tree line 333 ide-scsi.c

333:    if ((status & DRQ_STAT) == 0) {     /* No more interrupts */
                if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
                        printk (KERN_INFO "Packet command completed, %d
bytes transferred\n", pc->actually_transferred);
                ide__sti();
                if (status & ERR_STAT)
 338:                    rq->errors++;
                idescsi_end_request (1, HWGROUP(drive));
                return ide_stopped;
        }


 the oops occurs on line 338

i know its only error counting on that line but rq->errors is used
in idescsi_end_request as well which from what i can work out if it
never hits the limit it will keep retrying on the drive for ever. Then
i start to get lost / confused ....
I cant retrigger at the weekend if you wish and provide all uptodate
information on it.




