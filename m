Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314056AbSDVFkT>; Mon, 22 Apr 2002 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314057AbSDVFkS>; Mon, 22 Apr 2002 01:40:18 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30475
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S314056AbSDVFkS>; Mon, 22 Apr 2002 01:40:18 -0400
Date: Sun, 21 Apr 2002 22:38:23 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Hans-Peter Jansen <hpj@urpla.net>
cc: andersen@codepoet.org, drd@homeworld.ath.cx, linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
 reading damadged files
In-Reply-To: <20020422005439.0799e874.hpj@urpla.net>
Message-ID: <Pine.LNX.4.10.10204212235220.24428-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have addressed the core problem I have been working on quietly.
The export of the sense data and end request per subdriver is required to
make the personalities proper.  This is messy for two of the four current
subdrivers, and teh fifth new one will be clean from the start.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Mon, 22 Apr 2002, Hans-Peter Jansen wrote:

> On Fri, 19 Apr 2002 14:01:13 -0600
> "Erik Andersen" <andersen@codepoet.org> wrote:
> 
> > This should help somewhat.  Currently, ide-cd.c retries ERROR_MAX
> > (8) times when it sees an error.  But ide.c is also retrying
> > ERROR_MAX times when _it_ sees an error, and does a bus reset
> > after evey 4 failures.  So for each bad sector, you get 64
> > retries (with typical timouts of 7 seconds each) plus 16 bus
> > resets per bad sector.
> 
> Thanks for investigation. BTW: Does this cover the ide-scsi case, too?
>  
> > The funny thing is though, we knew after the first read that we
> > had an uncorrectable medium error.  Try this patch vs 2.4.19-pre7
> > 
> > --- linux/drivers/ide/ide-cd.c.orig	Tue Apr  9 06:59:56 2002
> > +++ linux/drivers/ide/ide-cd.c	Tue Apr  9 07:04:59 2002
> > @@ -657,6 +657,11 @@
> >  			   request or data protect error.*/
> >  			ide_dump_status (drive, "command error", stat);
> >  			cdrom_end_request (0, drive);
> > +		} else if (sense_key == MEDIUM_ERROR) {
> > +			/* No point in re-trying a zillion times on a bad 
> > +			 * sector...  If we got here the error is not correctable */
> > +			ide_dump_status (drive, "media error (bad sector)", stat);
> 
> .. and some curious will want to know which sector has thrown the error 
> [which would save me to patch this some day myself...]
> 
> > +			cdrom_end_request (0, drive);
> >  		} else if ((err & ~ABRT_ERR) != 0) {
> >  			/* Go to the default handler
> >  			   for other errors. */
> >  -Erik
> > 
> > --
> > Erik B. Andersen             http://codepoet-consulting.com/
> > --This message was written using 73% post-consumer electrons--
> 
> Cheers,
>   Hans-Peter
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

