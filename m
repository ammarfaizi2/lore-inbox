Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSDVOtV>; Mon, 22 Apr 2002 10:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314213AbSDVOtU>; Mon, 22 Apr 2002 10:49:20 -0400
Received: from mailf.telia.com ([194.22.194.25]:14290 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S313019AbSDVOtT>;
	Mon, 22 Apr 2002 10:49:19 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: andersen@codepoet.org, "Dr. Death" <drd@homeworld.ath.cx>
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Date: Mon, 22 Apr 2002 16:49:54 +0200
X-Mailer: KMail [version 1.4.5]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CBEC67F.3000909@filez> <20020419200112.GA16209@codepoet.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204221649.54875.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Byt why does it look up the whole system during these retries?
Does it busy wait? (on timer or HW status)

In that case the preemtive kernel could help too... (assuming that it
does not busy wait under a lock - but it is not unlikely...)

/RogerL

On Friday 19 April 2002 22.01, Erik Andersen wrote:
> On Thu Apr 18, 2002 at 03:13:35PM +0200, Dr. Death wrote:
> > Problem:
> > 
> > I use SuSE Linux 7.2 and when I create md5sums from damaged files on a 
> > CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the 
> > damaged part of the file !
> 
> This should help somewhat.  Currently, ide-cd.c retries ERROR_MAX
> (8) times when it sees an error.  But ide.c is also retrying
> ERROR_MAX times when _it_ sees an error, and does a bus reset
> after evey 4 failures.  So for each bad sector, you get 64
> retries (with typical timouts of 7 seconds each) plus 16 bus
> resets per bad sector.
> 
> The funny thing is though, we knew after the first read that we
> had an uncorrectable medium error.  Try this patch vs 2.4.19-pre7
> 
> --- linux/drivers/ide/ide-cd.c.orig	Tue Apr  9 06:59:56 2002
> +++ linux/drivers/ide/ide-cd.c	Tue Apr  9 07:04:59 2002
> @@ -657,6 +657,11 @@
>  			   request or data protect error.*/
>  			ide_dump_status (drive, "command error", stat);
>  			cdrom_end_request (0, drive);
> +		} else if (sense_key == MEDIUM_ERROR) {
> +			/* No point in re-trying a zillion times on a bad 
> +			 * sector...  If we got here the error is not correctable */
> +			ide_dump_status (drive, "media error (bad sector)", stat);
> +			cdrom_end_request (0, drive);
>  		} else if ((err & ~ABRT_ERR) != 0) {
>  			/* Go to the default handler
>  			   for other errors. */
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Roger Larsson
Skellefteå
Sweden

