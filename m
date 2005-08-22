Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVHVW4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVHVW4T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVHVW4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:56:18 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9614 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751292AbVHVW4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:56:16 -0400
Date: Sun, 21 Aug 2005 21:14:26 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Kumar Gala <galak@freescale.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>, vbordug@ru.mvista.com,
       panto@intracom.gr
Subject: Re: [PATCH] cpm_uart: Fix dpram allocation and non-console uarts
Message-ID: <20050822041426.GB4554@us.ibm.com>
References: <Pine.LNX.4.61.0508082239180.5117@nylon.am.freescale.net> <29495f1d0508172242734e1c99@mail.gmail.com> <20050821211235.GD6746@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050821211235.GD6746@dmt.cnet>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.2005 [18:12:35 -0300], Marcelo Tosatti wrote:
> Hi,
> 
> On Wed, Aug 17, 2005 at 10:42:36PM -0700, Nish Aravamudan wrote:
> > On 8/8/05, Kumar Gala <galak@freescale.com> wrote:
> > > (A believe Marcelo would like to see this in 2.6.13, but I'll let him
> > > fight over that ;)
> > > 
> > > * Makes dpram allocations work
> > > * Makes non-console UART work on both 8xx and 82xx
> > > * Fixed whitespace in files that were touched
> > > 
> > > Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> > > Signed-off-by: Pantelis Antoniou <panto@intracom.gr>
> > > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> > > 
> > > ---
> > > commit 1de80554bcae877dce3b6d878053eb092ef65c72
> > > tree aba124824607fea1070e86501ddccc9decce362d
> > > parent ad81111fd554c9d3c14c0a50885e076af2f9ac9b
> > > author Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:35:39 -0500
> > > committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 08 Aug 2005 22:35:39 -0500
> > 
> > <snip>
> > 
> > > diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
> > > --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> > > +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> > 
> > <snip>
> > 
> > > @@ -376,9 +396,19 @@ static int cpm_uart_startup(struct uart_
> > >                 pinfo->sccp->scc_sccm |= UART_SCCM_RX;
> > >         }
> > > 
> > > +       if (!(pinfo->flags & FLAG_CONSOLE))
> > > +               cpm_line_cr_cmd(line,CPM_CR_INIT_TRX);
> > >         return 0;
> > >  }
> > > 
> > > +inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
> > > +{
> > > +       unsigned long target_jiffies = jiffies + pinfo->wait_closing;
> > > +
> > > +       while (!time_after(jiffies, target_jiffies))
> > > +               schedule();
> > > +}
> > 
> > Not sure about that call here. Does the state need to be set so that
> > you won't be run again immediately? In any case, I think direct
> > schedule() callers are discouraged? Do you want to call a yield() or
> > schedule_timeout({0,1}) instead maybe?
> 
> Yep, schedule_timeout(pinfo->wait_closing) looks much better.
> 
> > >  /*
> > >   * Shutdown the uart
> > >   */
> > > @@ -394,6 +424,12 @@ static void cpm_uart_shutdown(struct uar
> > > 
> > >         /* If the port is not the console, disable Rx and Tx. */
> > >         if (!(pinfo->flags & FLAG_CONSOLE)) {
> > > +               /* Wait for all the BDs marked sent */
> > > +               while(!cpm_uart_tx_empty(port))
> > > +                       schedule_timeout(2);
> > 
> > <snip>
> > 
> > I think you are using 2 jiffies to guarantee that at least one jiffy
> > elapses, which is fine. But, if you do not set the state beforehand,
> > schedule_timeout() returns immediately, so you have a busy-wait here.
> 
> Right, what about the following untested patch.
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
> --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -403,10 +403,9 @@ static int cpm_uart_startup(struct uart_
>  
>  inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
>  {
> -	unsigned long target_jiffies = jiffies + pinfo->wait_closing;
> -
> -	while (!time_after(jiffies, target_jiffies))
> -   		schedule();
> +	set_current_state(TASK_UNINTERRUPTIBLE);
> +	schedule_timeout(pinfo->wait_closing);
> +	set_current_state(TASK_RUNNING);
>  }

Both changes look correct/better. Except you shouldn't need to set the
state back to TASK_RUNNING in either case, as schedule_timeout()
guarantees the task will return in that state.

Thanks,
Nish
