Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTEWVUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 17:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTEWVUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 17:20:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:43877 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264193AbTEWVUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 17:20:15 -0400
Date: Fri, 23 May 2003 14:31:38 -0700
From: Andrew Morton <akpm@digeo.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUGS] 2.5.69 syncppp
Message-Id: <20030523143138.4701982e.akpm@digeo.com>
In-Reply-To: <1053724551.2589.9.camel@diemos>
References: <1053724551.2589.9.camel@diemos>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 21:33:21.0617 (UTC) FILETIME=[EEFECC10:01C32172]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> wrote:
>
> 1. When syncppp tries to send a control protocol packet,
> I see the following kernel messages:
> 
>  Badness in local_bh_enable at kernel/softirq.c:105

sppp_lcp_open() is called from other places without that lock held, so it
is probably not totally stupid to drop it in the timer handler too.

It's good (and surprising) that someone is actually using that stuff. 
Please beat on it for a while.


diff -puN drivers/net/wan/syncppp.c~syncppp-locking-fix drivers/net/wan/syncppp.c
--- 25/drivers/net/wan/syncppp.c~syncppp-locking-fix	Fri May 23 14:28:50 2003
+++ 25-akpm/drivers/net/wan/syncppp.c	Fri May 23 14:29:24 2003
@@ -1297,6 +1297,7 @@ static void sppp_cp_timeout (unsigned lo
 		spin_unlock_irqrestore(&spppq_lock, flags);
 		return;
 	}
+	spin_unlock_irqrestore(&spppq_lock, flags);
 	switch (sp->lcp.state) {
 	case LCP_STATE_CLOSED:
 		/* No ACK for Configure-Request, retry. */
@@ -1333,7 +1334,6 @@ static void sppp_cp_timeout (unsigned lo
 		}
 		break;
 	}
-	spin_unlock_irqrestore(&spppq_lock, flags);
 }
 
 static char *sppp_lcp_type_name (u8 type)

_

