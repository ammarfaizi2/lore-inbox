Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWHDAR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWHDAR1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHDAR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:17:26 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:51843 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932373AbWHDARZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:17:25 -0400
Date: Thu, 3 Aug 2006 17:21:12 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, mgreer@mvista.com, a.zummo@towertech.it,
       khali@linux-fr.org, akpm@osdl.org, ab@mycable.de
Subject: Re: RTC: add RTC class interface to m41t00 driver
Message-ID: <20060804002112.GB9109@mag.az.mvista.com>
References: <20060804.002146.88700683.anemo@mba.ocn.ne.jp> <20060804.004259.48803564.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804.004259.48803564.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi,

Alexander Bigga <ab@mycable.de> has been working on moving this driver
over to [its proper place in] drivers/rtc.  Please sync up with him.

I've included him on the cc list so he can see your email.

Mark
--

On Fri, Aug 04, 2006 at 12:42:59AM +0900, Atsushi Nemoto wrote:
> On Fri, 04 Aug 2006 00:21:46 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > Hi.  I added new RTC class interface to existing m41t00 driver.  I
> > used CONFIG_GEN_RTC for traditional interface and CONFIG_RTC_CLASS for
> > new interface.  It should work with any platform not only for PPC32.
> 
> Oops, It can not compiled on archs which do not have asm/time.h.
> Revised.
> 
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index 87ee3ce..2cc48d2 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -103,7 +103,7 @@ config TPS65010
>  
>  config SENSORS_M41T00
>  	tristate "ST M41T00 RTC chip"
> -	depends on I2C && PPC32
> +	depends on I2C
>  	help
>  	  If you say yes here you get support for the ST M41T00 RTC chip.
>  
> diff --git a/drivers/i2c/chips/m41t00.c b/drivers/i2c/chips/m41t00.c
> index 2dd0a34..9c58f59 100644
> --- a/drivers/i2c/chips/m41t00.c
> +++ b/drivers/i2c/chips/m41t00.c
> @@ -10,7 +10,7 @@
>   */
>  /*
>   * This i2c client/driver wedges between the drivers/char/genrtc.c RTC
> - * interface and the SMBus interface of the i2c subsystem.
> + * (and/or RTC class) interface and the SMBus interface of the i2c subsystem.
>   */
>  
>  #include <linux/kernel.h>
> @@ -22,11 +22,12 @@ #include <linux/bcd.h>
>  #include <linux/workqueue.h>
>  #include <linux/platform_device.h>
>  #include <linux/m41t00.h>
> -#include <asm/time.h>
>  #include <asm/rtc.h>
>  
>  static struct i2c_driver m41t00_driver;
> +#if defined(CONFIG_GEN_RTC) && defined(CONFIG_GEN_RTC_MODULE)
>  static struct i2c_client *save_client;
> +#endif
>  
>  static unsigned short ignore[] = { I2C_CLIENT_END };
>  static unsigned short normal_addr[] = { I2C_CLIENT_END, I2C_CLIENT_END };
> @@ -96,8 +97,8 @@ static struct m41t00_chip_info m41t00_ch
>  };
>  static struct m41t00_chip_info *m41t00_chip;
>  
> -ulong
> -m41t00_get_rtc_time(void)
> +static int
> +m41t00_get_time(struct i2c_client *client, struct rtc_time *tm)
>  {
>  	s32 sec, min, hour, day, mon, year;
>  	s32 sec1, min1, hour1, day1, mon1, year1;
> @@ -105,13 +106,13 @@ m41t00_get_rtc_time(void)
>  	u8 buf[8], msgbuf[1] = { 0 }; /* offset into rtc's regs */
>  	struct i2c_msg msgs[] = {
>  		{
> -			.addr	= save_client->addr,
> +			.addr	= client->addr,
>  			.flags	= 0,
>  			.len	= 1,
>  			.buf	= msgbuf,
>  		},
>  		{
> -			.addr	= save_client->addr,
> +			.addr	= client->addr,
>  			.flags	= I2C_M_RD,
>  			.len	= 8,
>  			.buf	= buf,
> @@ -121,7 +122,7 @@ m41t00_get_rtc_time(void)
>  	sec = min = hour = day = mon = year = 0;
>  
>  	do {
> -		if (i2c_transfer(save_client->adapter, msgs, 2) < 0)
> +		if (i2c_transfer(client->adapter, msgs, 2) < 0)
>  			goto read_err;
>  
>  		sec1 = sec;
> @@ -146,61 +147,68 @@ m41t00_get_rtc_time(void)
>  			|| (year != year1)))
>  		goto read_err;
>  
> -	sec = BCD2BIN(sec);
> -	min = BCD2BIN(min);
> -	hour = BCD2BIN(hour);
> -	day = BCD2BIN(day);
> -	mon = BCD2BIN(mon);
> -	year = BCD2BIN(year);
> +	tm->tm_sec = BCD2BIN(sec);
> +	tm->tm_min = BCD2BIN(min);
> +	tm->tm_hour = BCD2BIN(hour);
> +	tm->tm_mday = BCD2BIN(day);
> +	tm->tm_mon = BCD2BIN(mon) - 1;
> +	tm->tm_year = BCD2BIN(year);
>  
> -	year += 1900;
> -	if (year < 1970)
> -		year += 100;
> +	if (tm->tm_year + 1900 < 1970)
> +		tm->tm_year += 100;
>  
> -	return mktime(year, mon, day, hour, min, sec);
> +	return 0;
>  
>  read_err:
> -	dev_err(&save_client->dev, "m41t00_get_rtc_time: Read error\n");
> -	return 0;
> +	dev_err(&client->dev, "m41t00_get_rtc_time: Read error\n");
> +	return -EIO;
>  }
> -EXPORT_SYMBOL_GPL(m41t00_get_rtc_time);
>  
> -static void
> -m41t00_set(void *arg)
> +#if defined(CONFIG_GEN_RTC) && defined(CONFIG_GEN_RTC_MODULE)
> +ulong
> +m41t00_get_rtc_time(void)
>  {
>  	struct rtc_time	tm;
> -	int nowtime = *(int *)arg;
> +
> +	if (m41t00_get_time(&save_client, &tm))
> +		return 0;
> +	return mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +		      tm.tm_hour, tm.tm_min, tm.tm_sec);
> +}
> +EXPORT_SYMBOL_GPL(m41t00_get_rtc_time);
> +#endif
> +
> +static int
> +m41t00_set_time(struct i2c_client *client, struct rtc_time *tm)
> +{
>  	s32 sec, min, hour, day, mon, year;
>  	u8 wbuf[9], *buf = &wbuf[1], msgbuf[1] = { 0 };
>  	struct i2c_msg msgs[] = {
>  		{
> -			.addr	= save_client->addr,
> +			.addr	= client->addr,
>  			.flags	= 0,
>  			.len	= 1,
>  			.buf	= msgbuf,
>  		},
>  		{
> -			.addr	= save_client->addr,
> +			.addr	= client->addr,
>  			.flags	= I2C_M_RD,
>  			.len	= 8,
>  			.buf	= buf,
>  		},
>  	};
>  
> -	to_tm(nowtime, &tm);
> -	tm.tm_year = (tm.tm_year - 1900) % 100;
> -
> -	sec = BIN2BCD(tm.tm_sec);
> -	min = BIN2BCD(tm.tm_min);
> -	hour = BIN2BCD(tm.tm_hour);
> -	day = BIN2BCD(tm.tm_mday);
> -	mon = BIN2BCD(tm.tm_mon);
> -	year = BIN2BCD(tm.tm_year);
> +	sec = BIN2BCD(tm->tm_sec);
> +	min = BIN2BCD(tm->tm_min);
> +	hour = BIN2BCD(tm->tm_hour);
> +	day = BIN2BCD(tm->tm_mday);
> +	mon = BIN2BCD(tm->tm_mon + 1);
> +	year = BIN2BCD(tm->tm_year % 100);
>  
>  	/* Read reg values into buf[0..7]/wbuf[1..8] */
> -	if (i2c_transfer(save_client->adapter, msgs, 2) < 0) {
> -		dev_err(&save_client->dev, "m41t00_set: Read error\n");
> -		return;
> +	if (i2c_transfer(client->adapter, msgs, 2) < 0) {
> +		dev_err(&client->dev, "m41t00_set: Read error\n");
> +		return -EIO;
>  	}
>  
>  	wbuf[0] = 0; /* offset into rtc's regs */
> @@ -210,8 +218,24 @@ m41t00_set(void *arg)
>  	buf[m41t00_chip->day] = (buf[m41t00_chip->day] & ~0x3f) | (day & 0x3f);
>  	buf[m41t00_chip->mon] = (buf[m41t00_chip->mon] & ~0x1f) | (mon & 0x1f);
>  
> -	if (i2c_master_send(save_client, wbuf, 9) < 0)
> -		dev_err(&save_client->dev, "m41t00_set: Write error\n");
> +	if (i2c_master_send(client, wbuf, 9) < 0) {
> +		dev_err(&client->dev, "m41t00_set: Write error\n");
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +#if defined(CONFIG_GEN_RTC) && defined(CONFIG_GEN_RTC_MODULE)
> +static void
> +m41t00_set(void *arg)
> +{
> +	struct rtc_time	tm;
> +	int nowtime = *(int *)arg;
> +
> +	to_tm(nowtime, &tm);
> +	tm.tm_year -= 1900;
> +	tm.tm_mon -= 1;
> +	m41t00_set_time(&save_client, &tm);
>  }
>  
>  static ulong new_time;
> @@ -231,6 +255,7 @@ m41t00_set_rtc_time(ulong nowtime)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(m41t00_set_rtc_time);
> +#endif
>  
>  /*
>   *****************************************************************************
> @@ -273,6 +298,23 @@ static struct platform_driver m41t00_pla
>  	},
>  };
>  
> +#if defined(CONFIG_RTC_CLASS) || defined(CONFIG_RTC_CLASS_MODULE)
> +static int m41t00_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	return m41t00_get_time(to_i2c_client(dev), tm);
> +}
> +
> +static int m41t00_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	return m41t00_set_time(to_i2c_client(dev), tm);
> +}
> +
> +static struct rtc_class_ops m41t00_rtc_ops = {
> +	.read_time	= m41t00_rtc_read_time,
> +	.set_time	= m41t00_rtc_set_time,
> +};
> +#endif
> +
>  /*
>   *****************************************************************************
>   *
> @@ -284,6 +326,9 @@ static int
>  m41t00_probe(struct i2c_adapter *adap, int addr, int kind)
>  {
>  	struct i2c_client *client;
> +#if defined(CONFIG_RTC_CLASS) || defined(CONFIG_RTC_CLASS_MODULE)
> +	struct rtc_device *rtc;
> +#endif
>  	int rc;
>  
>  	if (!i2c_check_functionality(adap, I2C_FUNC_I2C
> @@ -336,8 +381,21 @@ m41t00_probe(struct i2c_adapter *adap, i
>  				rc & ~0x80)) < 0)
>  			goto st_err;
>  
> +#if defined(CONFIG_RTC_CLASS) || defined(CONFIG_RTC_CLASS_MODULE)
> +	rtc = rtc_device_register(m41t00_driver.driver.name, &client->dev,
> +				  &m41t00_rtc_ops, THIS_MODULE);
> +
> +	if (IS_ERR(rtc)) {
> +		rc = PTR_ERR(rtc);
> +		goto attach_err;
> +	}
> +	i2c_set_clientdata(client, rtc);
> +#endif
> +
> +#if defined(CONFIG_GEN_RTC) && defined(CONFIG_GEN_RTC_MODULE)
>  	m41t00_wq = create_singlethread_workqueue(m41t00_chip->name);
>  	save_client = client;
> +#endif
>  	return 0;
>  
>  st_err:
> @@ -363,10 +421,17 @@ static int
>  m41t00_detach(struct i2c_client *client)
>  {
>  	int rc;
> +#if defined(CONFIG_RTC_CLASS) || defined(CONFIG_RTC_CLASS_MODULE)
> +	struct rtc_device *rtc = i2c_get_clientdata(client);
>  
> +	if (rtc)
> +		rtc_device_unregister(rtc);
> +#endif
>  	if ((rc = i2c_detach_client(client)) == 0) {
>  		kfree(client);
> +#if defined(CONFIG_GEN_RTC) && defined(CONFIG_GEN_RTC_MODULE)
>  		destroy_workqueue(m41t00_wq);
> +#endif
>  	}
>  	return rc;
>  }
