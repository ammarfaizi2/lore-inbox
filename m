Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUJUHbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUJUHbF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270241AbUJUH12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:27:28 -0400
Received: from pat.uio.no ([129.240.130.16]:49377 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S270333AbUJUH04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:26:56 -0400
Subject: Re: [PATCH] sunrpc: replace sleep_on_timeout()
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1098300093.20821.58.camel@thomas>
References: <1098300093.20821.58.camel@thomas>
Content-Type: text/plain
Date: Thu, 21 Oct 2004 09:26:37 +0200
Message-Id: <1098343597.28394.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 20.10.2004 Klokka 21:21 (+0200) skreiv Thomas Gleixner:
> Use wait_event_timeout() instead of the obsolete sleep_on_timeout()
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Ingo Molnar <mingo@elte.hu>
> ---
> 
>  2.6.9-bk-041020-thomas/net/sunrpc/clnt.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN net/sunrpc/clnt.c~sunrpc net/sunrpc/clnt.c
> --- 2.6.9-bk-041020/net/sunrpc/clnt.c~sunrpc	2004-10-20
> 15:56:37.000000000 +0200
> +++ 2.6.9-bk-041020-thomas/net/sunrpc/clnt.c	2004-10-20
> 15:56:37.000000000 +0200
> @@ -231,7 +231,8 @@ rpc_shutdown_client(struct rpc_clnt *cln
>  		clnt->cl_oneshot = 0;
>  		clnt->cl_dead = 0;
>  		rpc_killall_tasks(clnt);
> -		sleep_on_timeout(&destroy_wait, 1*HZ);
> +		wait_event_timeout(destroy_wait,
> +			atomic_read(&clnt->cl_users) > 0, 1*HZ);
>  	}
>  

No. The above is incorrect, and has the potential for a pretty
catastrophic hang due to the enclosing loop. Please replace with

	wait_event_timeout(destroy_wait, atomic_read(&clnt->cl_users) == 0,
1*HZ);

   Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

