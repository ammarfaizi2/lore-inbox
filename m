Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752309AbWJOAdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbWJOAdR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 20:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbWJOAdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 20:33:17 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:29352 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751452AbWJOAdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 20:33:16 -0400
Date: Sat, 14 Oct 2006 17:33:15 -0700 (PDT)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Florin Malita <fmalita@gmail.com>
cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [PATCH] V4L/DVB: potential leak in dvb-bt8xx
In-Reply-To: <453120EC.8030503@gmail.com>
Message-ID: <Pine.LNX.4.58.0610141720560.13331@shell2.speakeasy.net>
References: <453120EC.8030503@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006, Florin Malita wrote:
> If dvb_attach
> <http://www.coverity.com:7448/display-error.cgi?user=fmalita&magic=8997c91336813f372812011c89e0e75e&source=2693a21be69533084392e43c4f3c5220&runid=86&table=file&line=107>(dst_attach,
> ...) fails in *frontend_init*(), the previously allocated 'state' is
> leaked (Coverity ID 1437).

I believe that 'state' will be kfree'd by the dst_attach() function if there
is a failure.  Not what you would expect, to have it allocated in the bt8xx
driver (why do is there??) and freed on error in a different function.

You know, I had a patch to fix all these dst problems two months ago....

>
> Also, when allocating 'state' the result of kmalloc() needs to be checked.
>
> Signed-off-by: Florin Malita <fmalita@gmail.com>
> ---
>
>  drivers/media/dvb/bt8xx/dvb-bt8xx.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> index fb6c4cc..d22ba4e 100644
> --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> @@ -665,6 +665,9 @@ static void frontend_init(struct dvb_bt8
>  	case BTTV_BOARD_TWINHAN_DST:
>  		/*	DST is not a frontend driver !!!		*/
>  		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
> +		if (!state)
> +			break;
> +
>  		/*	Setup the Card					*/
>  		state->config = &dst_config;
>  		state->i2c = card->i2c_adapter;
> @@ -673,6 +676,7 @@ static void frontend_init(struct dvb_bt8
>  		/*	DST is not a frontend, attaching the ASIC	*/
>  		if (dvb_attach(dst_attach, state, &card->dvb_adapter) == NULL) {
>  			printk("%s: Could not find a Twinhan DST.\n", __FUNCTION__);
> +			kfree(state);
>  			break;
>  		}
>  		/*	Attach other DST peripherals if any		*/
>
>
>
> _______________________________________________
> v4l-dvb-maintainer mailing list
> v4l-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/v4l-dvb-maintainer
>
