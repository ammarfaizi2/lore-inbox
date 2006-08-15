Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965365AbWHOK0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965365AbWHOK0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbWHOK0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:26:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:43631 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965365AbWHOK0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:26:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Um73cM5OoDhcqN9wpA4FbCvpwN9ZXqN6S+ii7Tug6IDkuqpqLX8z8D2t7VVdfiRBQv/u0ncycTt7Zu70GhXKarBycye9S1MbSJXdtspjmt7T4W4h0k0L2xCmtu54ClRE4xxM17beZ8AdXEr5b7xC9ukS1V014VR0RtSyqCuBXUk=
Message-ID: <44E1A15A.7030105@gmail.com>
Date: Tue, 15 Aug 2006 12:26:11 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] rtc-s3c.c: fix time setting checks
References: <20060815092429.GA13940@home.fluff.org>
In-Reply-To: <20060815092429.GA13940@home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks wrote:
> Fix the checking of the range for the year when
> setting time with the S3C24XX RTC driver
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> diff -urpN -X ../dontdiff linux-2.6.18-rc4-all1/drivers/rtc/rtc-s3c.c linux-2.6.18-rc4-all2/drivers/rtc/rtc-s3c.c
> --- linux-2.6.18-rc4-all1/drivers/rtc/rtc-s3c.c	2006-08-14 09:04:57.000000000 +0100
> +++ linux-2.6.18-rc4-all2/drivers/rtc/rtc-s3c.c	2006-08-14 09:59:47.000000000 +0100
> @@ -11,6 +11,8 @@
>   * S3C2410/S3C2440/S3C24XX Internal RTC Driver
>  */
>  
> +//B#define DEBUG
> +

But what's this?

>  #include <linux/module.h>
>  #include <linux/fs.h>
>  #include <linux/string.h>
> @@ -153,24 +155,25 @@ static int s3c_rtc_gettime(struct device
>  static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
>  {
>  	void __iomem *base = s3c_rtc_base;
> +	int year = tm->tm_year - 100;
> +
> +	pr_debug("set time %02d.%02d.%02d %02d/%02d/%02d\n",
> +		 tm->tm_year, tm->tm_mon, tm->tm_mday,
> +		 tm->tm_hour, tm->tm_min, tm->tm_sec);
>  
> -	/* the rtc gets round the y2k problem by just not supporting it */
> +	/* we get around y2k by simply not supporting it */
>  
> -	if (tm->tm_year > 100) {
> +	if (year < 0 || year >= 100) {
>  		dev_err(dev, "rtc only supports 100 years\n");
>  		return -EINVAL;
>  	}
>  
> -	pr_debug("set time %02d.%02d.%02d %02d/%02d/%02d\n",
> -		 tm->tm_year, tm->tm_mon, tm->tm_mday,
> -		 tm->tm_hour, tm->tm_min, tm->tm_sec);
> -
>  	writeb(BIN2BCD(tm->tm_sec),  base + S3C2410_RTCSEC);
>  	writeb(BIN2BCD(tm->tm_min),  base + S3C2410_RTCMIN);
>  	writeb(BIN2BCD(tm->tm_hour), base + S3C2410_RTCHOUR);
>  	writeb(BIN2BCD(tm->tm_mday), base + S3C2410_RTCDATE);
>  	writeb(BIN2BCD(tm->tm_mon + 1), base + S3C2410_RTCMON);
> -	writeb(BIN2BCD(tm->tm_year - 100), base + S3C2410_RTCYEAR);
> +	writeb(BIN2BCD(year), base + S3C2410_RTCYEAR);
>  
>  	return 0;
>  }

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
