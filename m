Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVHRFmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVHRFmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVHRFmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:42:40 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:8426 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750784AbVHRFmi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:42:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PhOpxTB6WHu4zJ5Lo0H8N7pY+jDdED0sOXHscdz9WsrHyGRPZPaUVkjfggyLgcUHV3gJtw+gqNkmQ+btizoQoDKkIdZUf31pYA6jSRssA4KS6sfI9B64sx0JzbKtce7vBxS0Cf24s0mRtbBrllHWSNzgNJ77YvXEwUTjlofLD9k=
Message-ID: <29495f1d0508172242734e1c99@mail.gmail.com>
Date: Wed, 17 Aug 2005 22:42:36 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] cpm_uart: Fix dpram allocation and non-console uarts
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, vbordug@ru.mvista.com,
       panto@intracom.gr, marcelo.tosatti@cyclades.com
In-Reply-To: <Pine.LNX.4.61.0508082239180.5117@nylon.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0508082239180.5117@nylon.am.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/05, Kumar Gala <galak@freescale.com> wrote:
> (A believe Marcelo would like to see this in 2.6.13, but I'll let him
> fight over that ;)
> 
> * Makes dpram allocations work
> * Makes non-console UART work on both 8xx and 82xx
> * Fixed whitespace in files that were touched
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> Signed-off-by: Pantelis Antoniou <panto@intracom.gr>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> 
> ---
> commit 1de80554bcae877dce3b6d878053eb092ef65c72
> tree aba124824607fea1070e86501ddccc9decce362d
> parent ad81111fd554c9d3c14c0a50885e076af2f9ac9b
> author Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:35:39 -0500
> committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:35:39 -0500

<snip>

> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
> --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c

<snip>

> @@ -376,9 +396,19 @@ static int cpm_uart_startup(struct uart_
>                 pinfo->sccp->scc_sccm |= UART_SCCM_RX;
>         }
> 
> +       if (!(pinfo->flags & FLAG_CONSOLE))
> +               cpm_line_cr_cmd(line,CPM_CR_INIT_TRX);
>         return 0;
>  }
> 
> +inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
> +{
> +       unsigned long target_jiffies = jiffies + pinfo->wait_closing;
> +
> +       while (!time_after(jiffies, target_jiffies))
> +               schedule();
> +}

Not sure about that call here. Does the state need to be set so that
you won't be run again immediately? In any case, I think direct
schedule() callers are discouraged? Do you want to call a yield() or
schedule_timeout({0,1}) instead maybe?

>  /*
>   * Shutdown the uart
>   */
> @@ -394,6 +424,12 @@ static void cpm_uart_shutdown(struct uar
> 
>         /* If the port is not the console, disable Rx and Tx. */
>         if (!(pinfo->flags & FLAG_CONSOLE)) {
> +               /* Wait for all the BDs marked sent */
> +               while(!cpm_uart_tx_empty(port))
> +                       schedule_timeout(2);

<snip>

I think you are using 2 jiffies to guarantee that at least one jiffy
elapses, which is fine. But, if you do not set the state beforehand,
schedule_timeout() returns immediately, so you have a busy-wait here.

Thanks,
Nish
