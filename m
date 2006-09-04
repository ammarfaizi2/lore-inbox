Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWIDQDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWIDQDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 12:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWIDQDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 12:03:50 -0400
Received: from mx0.towertech.it ([213.215.222.73]:34722 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S964910AbWIDQDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 12:03:49 -0400
Date: Mon, 4 Sep 2006 15:58:47 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] RTC: more XSTP/VDET support for rtc-rs5c348 driver
Message-ID: <20060904155847.4b32539b@inspiron>
In-Reply-To: <20060904.222222.59464886.anemo@mba.ocn.ne.jp>
References: <20060904.222222.59464886.anemo@mba.ocn.ne.jp>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 22:22:22 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> If the chip detected "oscillator stop" condition, show an warning
> message.  And initialize it with the Epoch time instead of leaving it
> with unknown date/time.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

> diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
> index 0964d1d..2558906 100644
> --- a/drivers/rtc/rtc-rs5c348.c
> +++ b/drivers/rtc/rtc-rs5c348.c
> @@ -23,7 +23,7 @@ #include <linux/rtc.h>
>  #include <linux/workqueue.h>
>  #include <linux/spi/spi.h>
>  
> -#define DRV_VERSION "0.1"
> +#define DRV_VERSION "0.2"
>  
>  #define RS5C348_REG_SECS	0
>  #define RS5C348_REG_MINS	1
> @@ -175,8 +175,15 @@ static int __devinit rs5c348_probe(struc
>  		goto kfree_exit;
>  	if (ret & (RS5C348_BIT_XSTP | RS5C348_BIT_VDET)) {
>  		u8 buf[2];
> +		struct rtc_time tm;
>  		if (ret & RS5C348_BIT_VDET)
>  			dev_warn(&spi->dev, "voltage-low detected.\n");
> +		if (ret & RS5C348_BIT_XSTP)
> +			dev_warn(&spi->dev, "oscillator-stop detected.\n");
> +		rtc_time_to_tm(0, &tm);	/* 1970/1/1 */
> +		ret = rs5c348_rtc_set_time(&spi->dev, &tm);
> +		if (ret < 0)
> +			goto kfree_exit;
>  		buf[0] = RS5C348_CMD_W(RS5C348_REG_CTL2);
>  		buf[1] = 0;
>  		ret = spi_write_then_read(spi, buf, sizeof(buf), NULL, 0);


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

