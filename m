Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVIDXpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVIDXpn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVIDXpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:45:42 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:49164 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932177AbVIDXph convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:45:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FsPInjDLb263d1Y8Y/7C5Ck4QY/EVwsnKTSTze6BZjujK8FbykIiqoD1bpJfhhuOmKZW/vJB17jZmr6jAWesiw3jBTnODHI5e6295v1cu94K2bqnRbNCff5U1NpjZ4duyRz6SVY2MYsuwiBwpqcE16e+NdENA079IPpuxVZXmPM=
Message-ID: <29495f1d05090416453841f8d4@mail.gmail.com>
Date: Sun, 4 Sep 2005 16:45:35 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [DVB patch 54/54] ttusb-budget: use time_after_eq()
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>,
       Domen Puncer <domen@coderock.org>
In-Reply-To: <20050904232337.296861000@abc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904232259.777473000@abc> <20050904232337.296861000@abc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
> 
> Use of the time_after_eq() macro, defined at linux/jiffies.h, which deal
> with wrapping correctly and are nicer to read.
> 
> Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
> Signed-off-by: Domen Puncer <domen@coderock.org>
> Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
> 
>  drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.13-git4.orig/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c    2005-09-04 22:28:03.000000000 +0200
> +++ linux-2.6.13-git4/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c 2005-09-04 22:31:06.000000000 +0200
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/time.h>
>  #include <linux/errno.h>
> +#include <linux/jiffies.h>
>  #include <asm/semaphore.h>
> 
>  #include "dvb_frontend.h"
> @@ -570,7 +571,8 @@ static void ttusb_handle_sec_data(struct
>                                   const u8 * data, int len);
>  #endif
> 
> -static int numpkt = 0, lastj, numts, numstuff, numsec, numinvalid;
> +static int numpkt = 0, numts, numstuff, numsec, numinvalid;
> +static unsigned long lastj;
> 
>  static void ttusb_process_muxpack(struct ttusb *ttusb, const u8 * muxpack,
>                            int len)
> @@ -779,7 +781,7 @@ static void ttusb_iso_irq(struct urb *ur
>                         u8 *data;
>                         int len;
>                         numpkt++;
> -                       if ((jiffies - lastj) >= HZ) {
> +                       if (time_after_eq(jiffies, lastj + HZ)) {

I think you actually want:

static void ttusb_iso_irq(....)
{
     unsigned long lastj;

     ...

     lastj = jiffies + HZ;
     if (time_after_eq(jiffies, lastj)) {
          ...

}

The current code doesn't assign jiffies to lastj at any point that I see.

Thanks,
Nish
