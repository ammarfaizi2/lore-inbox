Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266039AbUAFABD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266015AbUAEX67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:58:59 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33527 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266024AbUAEX4x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:56:53 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Christophe Saout <christophe@saout.de>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Tue, 6 Jan 2004 00:59:52 +0100
User-Agent: KMail/1.5.4
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401051808.49010.bzolnier@elka.pw.edu.pl> <20040105225117.GA5841@leto.cs.pocnet.net>
In-Reply-To: <20040105225117.GA5841@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401060059.52833.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of January 2004 23:51, Christophe Saout wrote:
> Remember? Can bio be NULL somewhere? Or what do you mean? It's our
> scratchpad and ide_multwrite never puts a NULL bio on it.

After last sector of the whole transfer is processed ide_multwrite() will set
it to NULL.  Next IRQ is only ACK of previous datablock, no transfer happens.

> > Otherwise I patch is OK for me.
>
> Ok, take two.
>
> I also did legacy/pdc4030.c, it's more or less the same though I'm not
> able to test it.

Looks OK.

> @@ -333,14 +332,17 @@
>  			 *	we can end the original request.
>  			 */
>  			if (!rq->nr_sectors) {	/* all done? */
> +				bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
>  				rq = hwgroup->rq;
>  				ide_end_request(drive, 1, rq->nr_sectors);
>  				return ide_stopped;
>  			}
>  		}
>  		/* the original code did this here (?) */
> +		bio->bi_idx = bio->bi_vcnt - rq->nr_cbio_segments;
>  		return ide_stopped;

Move it before the comment.

--bart

