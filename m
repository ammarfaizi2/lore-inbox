Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbTCMRDw>; Thu, 13 Mar 2003 12:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262451AbTCMRDw>; Thu, 13 Mar 2003 12:03:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2445 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262460AbTCMRDu>;
	Thu, 13 Mar 2003 12:03:50 -0500
Date: Thu, 13 Mar 2003 18:14:26 +0100
From: Jens Axboe <axboe@suse.de>
To: James Stevenson <james@stev.org>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-ID: <20030313171426.GK836@suse.de>
References: <20030227221017.4291c1f6.skraw@ithnet.com> <014b01c2e978$701050e0$0cfea8c0@ezdsp.com> <20030313163707.GH836@suse.de> <016c01c2e980$b2d4ee60$0cfea8c0@ezdsp.com> <20030313164617.GI836@suse.de> <017e01c2e983$865e9bd0$0cfea8c0@ezdsp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017e01c2e983$865e9bd0$0cfea8c0@ezdsp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, James Stevenson wrote:
> > > > Your explanation doesn't quite make sense, but I can take a look at
> the
> > > > problem :-)
> > > >
> > > > What kernel is the below oops from? What compiler?
> > >
> > > i can trigger this on any 2.4.x series kernel.
> > > -> Insert dmaged / lightly scratched cd into drive
> > >    dd /dev/scd0 bs=8192k of=file
> > >    wait for opps.
> > >    opps also cd tries to re read several times
> > >    short hang then the following output
> > >
> > > gcc versions.
> > > Whatever shits with redhat 7.1 + 7.2 + 7.3 and the
> > > updates between them in each of the redhat versions.
> > > but normally
> > > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > > gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
> > >
> > > or
> > > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > > gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-113)
> >
> > weee ok not my choice for compilers, but probably alright. do me a favor
> > then:
> >
> > # cd /to/kernel/source
> > # rm drivers/scsi/ide-scsi.o
> > # EXTRA_CFLAGS=-g make drivers/scsi/ide-scsi.o
> > # objdump -S drivers/scsi/ide-scsi.o > /tmp/some_file
> 
> i know longer have the source tree from what the opps was generated
> from that was actually the 2.4.19 opps i posted but the kernel is now
> 2.4.20 it was the same trace and same place in the file i tracked it to
> this point.
> 
> >From 2.4.20 tree line 333 ide-scsi.c
> 
> 333:    if ((status & DRQ_STAT) == 0) {     /* No more interrupts */
>                 if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
>                         printk (KERN_INFO "Packet command completed, %d
> bytes transferred\n", pc->actually_transferred);
>                 ide__sti();
>                 if (status & ERR_STAT)
>  338:                    rq->errors++;
>                 idescsi_end_request (1, HWGROUP(drive));
>                 return ide_stopped;
>         }
> 
> 
>  the oops occurs on line 338
> 
> i know its only error counting on that line but rq->errors is used
> in idescsi_end_request as well which from what i can work out if it
> never hits the limit it will keep retrying on the drive for ever. Then
> i start to get lost / confused ....
> I cant retrigger at the weekend if you wish and provide all uptodate
> information on it.

Ok, please reproduce in 2.4.21-pre5, its end_request handling is a lot
different. If you just want a one-liner, I'd suggest trying something
ala this on 2.4.20 and see if it makes any difference:

--- drivers/scsi/ide-scsi.c~	2003-03-13 18:13:00.876624632 +0100
+++ drivers/scsi/ide-scsi.c	2003-03-13 18:13:14.167604096 +0100
@@ -313,7 +313,7 @@
 	byte status, ireason;
 	int bcount;
 	idescsi_pc_t *pc=scsi->pc;
-	struct request *rq = pc->rq;
+	struct request *rq = HWGROUP(drive)->rq;
 	unsigned int temp;
 
 #if IDESCSI_DEBUG_LOG


But really, 2.4.21-pre is much more interesting to reproduce on.

-- 
Jens Axboe

