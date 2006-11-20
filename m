Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934034AbWKTN0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934034AbWKTN0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 08:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934035AbWKTN0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 08:26:40 -0500
Received: from h155.mvista.com ([63.81.120.155]:56003 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S934034AbWKTN0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 08:26:39 -0500
Message-ID: <4561AD63.1060201@ru.mvista.com>
Date: Mon, 20 Nov 2006 16:28:03 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Stefan Roese <ml@stefan-roese.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
References: <200611201200.36780.ml@stefan-roese.de>
In-Reply-To: <200611201200.36780.ml@stefan-roese.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Stefan Roese wrote:
> This patch fixes a problem seen on multiple 4xx platforms, where
> the UART0 interrupt number is 0. The macro "is_real_interrupt" lead
> on those systems to not use an real interrupt but the timer based
> implementation.

> This problem was detected and fixed by
> Charles Gales <cgales@amcc.com> and John Baxter <jbaxter@amcc.com>
> from AMCC.

> Signed-off-by: Stefan Roese <sr@denx.de>

> ---
> commit f83094acd3258575c9a5cdb1d65e241c16eff03a
> tree 72582c5eeb2a9c8ea57287616d51e42fff8ed641
> parent f56f68c4e1977f0e884a304af4c617bed4909417
> author Stefan Roese <sr@denx.de> Sat, 18 Nov 2006 10:28:50 +0100
> committer Stefan Roese <sr@denx.de> Sat, 18 Nov 2006 10:28:50 +0100

>  drivers/serial/8250.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)

> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index e34bd03..a51679e 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -76,8 +76,14 @@ static unsigned int nr_uarts = CONFIG_SE
>   * We default to IRQ0 for the "no irq" hack.   Some
>   * machine types want others as well - they're free
>   * to redefine this in their header file.
> + * NOTE:  Some PPC4xx use IRQ0 for a UART Interrupt, so
> + * we will assume that the IRQ is always real
>   */
> +#ifdef CONFIG_4xx
> +#define is_real_interrupt(irq)	(1)
> +#else
>  #define is_real_interrupt(irq)	((irq) != 0)
> +#endif

    This should have been done in <asm/serial.h> instead, like this:

#undef is_real_interrupt(irq)
#define is_real_interrupt(irq)	1

    Not too smart as well,but at least this wasy you won't be pulluting the 
generic code...

WBR, Sergei
