Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313925AbSDUWzG>; Sun, 21 Apr 2002 18:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313933AbSDUWzF>; Sun, 21 Apr 2002 18:55:05 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:19556 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S313925AbSDUWzE>; Sun, 21 Apr 2002 18:55:04 -0400
Date: Mon, 22 Apr 2002 00:54:39 +0200
From: Hans-Peter Jansen <hpj@urpla.net>
To: andersen@codepoet.org
Cc: drd@homeworld.ath.cx, linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-Id: <20020422005439.0799e874.hpj@urpla.net>
In-Reply-To: <20020419200112.GA16209@codepoet.org>
Organization: Treewater
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2002 14:01:13 -0600
"Erik Andersen" <andersen@codepoet.org> wrote:

> This should help somewhat.  Currently, ide-cd.c retries ERROR_MAX
> (8) times when it sees an error.  But ide.c is also retrying
> ERROR_MAX times when _it_ sees an error, and does a bus reset
> after evey 4 failures.  So for each bad sector, you get 64
> retries (with typical timouts of 7 seconds each) plus 16 bus
> resets per bad sector.

Thanks for investigation. BTW: Does this cover the ide-scsi case, too?
 
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

.. and some curious will want to know which sector has thrown the error 
[which would save me to patch this some day myself...]

> +			cdrom_end_request (0, drive);
>  		} else if ((err & ~ABRT_ERR) != 0) {
>  			/* Go to the default handler
>  			   for other errors. */
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--

Cheers,
  Hans-Peter
