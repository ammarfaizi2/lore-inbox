Return-Path: <linux-kernel-owner+w=401wt.eu-S1752888AbWLWJgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbWLWJgZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 04:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbWLWJgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 04:36:25 -0500
Received: from javad.com ([216.122.176.236]:2375 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbWLWJgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 04:36:24 -0500
X-Greylist: delayed 1588 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Dec 2006 04:36:24 EST
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
Date: Sat, 23 Dec 2006 12:09:45 +0300
In-Reply-To: <552766292581216610@wsc.cz> (Jiri Slaby's message of "Sat, 23
 Dec
	2006 02:35:46 +0100 (CET)")
Message-ID: <87mz5fj7vq.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri,

Jiri Slaby <jirislaby@gmail.com> writes:
> osv@javad.com wrote:
>> Hi Jiri,
>> 
>> I've figured out that both old and new mxser drivers have two similar
>> problems:
>> 
>> 1. When there are data coming to a port, sometimes opening of the port
>>    entirely locks the box. This is quite reproducible. Any idea what's
>>    wrong and how can I help to debug it?
>
> Could you test the patch below, if something changes?

Thanks for looking into it. I'll be able to get to the box with moxa
installed on Monday and will try the patch.

As for SysRq, I'm afraid it didn't work though I'm not 100% sure. I'll
check that as well.

-- Sergei.

> ---
>
>  drivers/char/mxser_new.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
> index a2bca5d..c0af201 100644
> --- a/drivers/char/mxser_new.c
> +++ b/drivers/char/mxser_new.c
> @@ -2268,6 +2268,8 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
>  			if (bits & irqbits)
>  				continue;
>  			port = &brd->ports[i];
> +			if (!(port->flags & ASYNC_INITIALIZED))
> +				continue;
>  
>  			int_cnt = 0;
>  			do {
> @@ -2320,9 +2322,9 @@ static irqreturn_t mxser_interrupt(int irq, void *dev_id)
>  					if (status & UART_LSR_THRE)
>  						mxser_transmit_chars(port);
>  				}
> -			} while (int_cnt++ < MXSER_ISR_PASS_LIMIT);
> +			} while (int_cnt++ < 256);
>  		}
> -		if (pass_counter++ > MXSER_ISR_PASS_LIMIT)
> +		if (pass_counter++ > 64)
>  			break;	/* Prevent infinite loops */
>  	}
>  
