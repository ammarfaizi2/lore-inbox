Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTKAXWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 18:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTKAXWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 18:22:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:8662 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261267AbTKAXWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 18:22:40 -0500
Date: Sat, 1 Nov 2003 15:24:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: svdmade@planet.nl, linux-kernel@vger.kernel.org
Subject: Re: Di-30 non working [bug 967]
Message-Id: <20031101152453.42346338.akpm@osdl.org>
In-Reply-To: <200311012228.29085.bzolnier@elka.pw.edu.pl>
References: <3FA41703.1030408@planet.nl>
	<200311012228.29085.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
>
> Noticed by Stuart_Hayes@Dell.com:
> 
> I've noticed that, in the 2.6 (test 9) kernel, the "cmd" field (of type int)
> in struct request has been removed, and it looks like all of the code in
> ide-tape has just had a find & replace run on it to replace any instance of
> rq.cmd or rq->cmd with rq.flags or rq->flags.

Nasty.

> @@ -193,6 +193,11 @@ enum rq_flag_bits {
>  	__REQ_PM_SUSPEND,	/* suspend request */
>  	__REQ_PM_RESUME,	/* resume request */
>  	__REQ_PM_SHUTDOWN,	/* shutdown request */
> +	__REQ_IDETAPE_PC1,	/* packet command (first stage) */
> +	__REQ_IDETAPE_PC2,	/* packet command (second stage) */
> +	__REQ_IDETAPE_READ,
> +	__REQ_IDETAPE_WRITE,
> +	__REQ_IDETAPE_READ_BUFFER,
>  	__REQ_NR_BITS,		/* stops here */
>  };

This takes us up to about 28 flags; we'll run out soon.

Probably it is time to split this into generic and private flags, as we did
with bh_state_bits.  The scope of the "private" section needs to be
defined: maybe "whoever created the queue"?

blk_dump_rq_flags() will need updating.  Probably change it to only decode
the "generic" flags, and print "bit XX" for the remainders.

Your patch forgot to update rq_flags[] btw.

