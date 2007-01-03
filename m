Return-Path: <linux-kernel-owner+w=401wt.eu-S932174AbXACXM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbXACXM2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbXACXM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:12:28 -0500
Received: from dmgw.movial.fi ([62.236.91.5]:33840 "EHLO dmgw.movial.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932174AbXACXM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:12:26 -0500
X-Greylist: delayed 1238 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 18:12:25 EST
Message-ID: <42235.80.222.56.248.1167864702.squirrel@webmail.movial.fi>
In-Reply-To: <200701021907.25701.david-b@pacbell.net>
References: <200612081859.42995.david-b@pacbell.net>
    <42003.80.222.56.248.1165875783.squirrel@webmail.movial.fi>
    <200612120030.44554.david-b@pacbell.net>
    <200701021907.25701.david-b@pacbell.net>
Date: Thu, 4 Jan 2007 00:51:42 +0200 (EET)
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates:  more chips, alarm,
      12hr mode, etc
From: "Voipio Riku" <Riku.Voipio@movial.fi>
To: "David Brownell" <david-b@pacbell.net>
Cc: "Voipio Riku" <riku.voipio@movial.fi>, rtc-linux@googlegroups.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Alessandro Zummo" <alessandro.zummo@towertech.it>,
       dan.j.williams@intel.com, i2c@lm-sensors.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> Yes, the patch you sent (switching to "method 3" to work around the
> evident bug in the i2c-ixp3xx driver) works on the platform I was
> using too (after unrelated tweaks).

> Here's an updated patch, using "method 3".  If it still behaves
> for you, it'd seem ready to merge...

Works fine, thanks! Unfortunately the i2c-ixp3xx issue has not advanced in
the meantime, so we still need the third method.

> ============	CUT HERE
> Update the rtc-rs5c372 driver:
>
>  Bugfixes:
>   - Handle RTCs which are configured to use 12-hour mode.
>   - Never report bogus/un-initialized times.
>   - Displaying "raw trim" requires not masking it first!
>   - Fix the and sysfs procfs display of crystal and trim data.
>
>  Features:
>   - Handle other RTCs in this family, notably rv5c386/rv5c387.
>   - Declare the other registers.
>   - Provide alarm get/set functionality.
>   - Handle AIE and UIE; but no IRQ handling yet.
>   - Warn if the clock needs to be set.
>
>  Cleanup:
>   - Shrink object by not including needless sysfs or procfs support
>   - We don't need no steenkin' forward declarations.  (Except one.)
>
> Until the I2C framework merges "new style" driver support, matching
> the driver model better, using rv5c chips or alarm IRQs requires a
> separate board-specific patch.  (And an IRQ handler, handing off labor
> through a work_struct...)
>
> This uses the "method 3" register reads, but notes that it's done
> to work around an evident i2c adapter driver bug, and the curious
> issue where the chip behavior disagrees with the chip docs.
>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>
> Index: g26/drivers/rtc/rtc-rs5c372.c
> ===================================================================
> --- g26.orig/drivers/rtc/rtc-rs5c372.c	2006-12-27 17:19:55.000000000 -0800
> +++ g26/drivers/rtc/rtc-rs5c372.c	2007-01-02 18:44:35.000000000 -0800
> @@ -1,5 +1,5 @@
>  /*
> - * An I2C driver for the Ricoh RS5C372 RTC
> + * An I2C driver for Ricoh RS5C372 and RV5C38[67] RTCs
>   *
>   * Copyright (C) 2005 Pavel Mironchik <pmironchik@optifacio.net>
>   * Copyright (C) 2006 Tower Technologies
> @@ -13,7 +13,7 @@
>  #include <linux/rtc.h>
>  #include <linux/bcd.h>
>
> -#define DRV_VERSION "0.3"
> +#define DRV_VERSION "0.4"
>
>  /* Addresses to scan */
>  static unsigned short normal_i2c[] = { /* 0x32,*/ I2C_CLIENT_END };
> @@ -21,6 +21,13 @@ static unsigned short normal_i2c[] = { /
>  /* Insmod parameters */
>  I2C_CLIENT_INSMOD;
>
> +
> +/*
> + * Ricoh has a family of I2C based RTCs, which differ only slightly from
> + * each other.  Differences center on pinout (e.g. how many interrupts,
> + * output clock, etc) and how the control registers are used.  The '372
> + * is significant only because that's the one this driver first
> supported.
> + */
>  #define RS5C372_REG_SECS	0
>  #define RS5C372_REG_MINS	1
>  #define RS5C372_REG_HOURS	2
> @@ -29,59 +36,142 @@ I2C_CLIENT_INSMOD;
>  #define RS5C372_REG_MONTH	5
>  #define RS5C372_REG_YEAR	6
>  #define RS5C372_REG_TRIM	7
> +#	define RS5C372_TRIM_XSL		0x80
> +#	define RS5C372_TRIM_MASK	0x7F
>
> -#define RS5C372_TRIM_XSL	0x80
> -#define RS5C372_TRIM_MASK	0x7F
> -
> -#define RS5C372_REG_BASE	0
> -
> -static int rs5c372_attach(struct i2c_adapter *adapter);
> -static int rs5c372_detach(struct i2c_client *client);
> -static int rs5c372_probe(struct i2c_adapter *adapter, int address, int
> kind);
> +#define RS5C_REG_ALARM_A_MIN	8			/* or ALARM_W */
> +#define RS5C_REG_ALARM_A_HOURS	9
> +#define RS5C_REG_ALARM_A_WDAY	10
> +
> +#define RS5C_REG_ALARM_B_MIN	11			/* or ALARM_D */
> +#define RS5C_REG_ALARM_B_HOURS	12
> +#define RS5C_REG_ALARM_B_WDAY	13			/* (ALARM_B only) */
> +
> +#define RS5C_REG_CTRL1		14
> +#	define RS5C_CTRL1_AALE		(1 << 7)	/* or WALE */
> +#	define RS5C_CTRL1_BALE		(1 << 6)	/* or DALE */
> +#	define RV5C387_CTRL1_24		(1 << 5)
> +#	define RS5C372A_CTRL1_SL1	(1 << 5)
> +#	define RS5C_CTRL1_CT_MASK	(7 << 0)
> +#	define RS5C_CTRL1_CT0		(0 << 0)	/* no periodic irq */
> +#	define RS5C_CTRL1_CT4		(4 << 0)	/* 1 Hz level irq */
> +#define RS5C_REG_CTRL2		15
> +#	define RS5C372_CTRL2_24		(1 << 5)
> +#	define RS5C_CTRL2_XSTP		(1 << 4)
> +#	define RS5C_CTRL2_CTFG		(1 << 2)
> +#	define RS5C_CTRL2_AAFG		(1 << 1)	/* or WAFG */
> +#	define RS5C_CTRL2_BAFG		(1 << 0)	/* or DAFG */
> +
> +
> +/* to read (style 1) or write registers starting at R */
> +#define RS5C_ADDR(R)		(((R) << 4) | 0)
> +
> +
> +enum rtc_type {
> +	rtc_undef = 0,
> +	rtc_rs5c372a,
> +	rtc_rs5c372b,
> +	rtc_rv5c386,
> +	rtc_rv5c387a,
> +};
>
> +/* REVISIT:  this assumes that:
> + *  - we're in the 21st century, so it's safe to ignore the century
> + *    bit for rv5c38[67] (REG_MONTH bit 7);
> + *  - we should use ALARM_A not ALARM_B (may be wrong on some boards)
> + */
>  struct rs5c372 {
> -	u8 reg_addr;
> -	u8 regs[17];
> -	struct i2c_msg msg[1];
> -	struct i2c_client client;
> -	struct rtc_device *rtc;
> -};
> +	struct i2c_client	*client;
> +	struct rtc_device	*rtc;
> +	enum rtc_type		type;
> +	unsigned		time24:1;
> +	unsigned		has_irq:1;
> +	char			buf[17];
> +	char			*regs;
>
> -static struct i2c_driver rs5c372_driver = {
> -	.driver		= {
> -		.name	= "rs5c372",
> -	},
> -	.attach_adapter	= &rs5c372_attach,
> -	.detach_client	= &rs5c372_detach,
> +	/* on conversion to a "new style" i2c driver, this vanishes */
> +	struct i2c_client	dev;
>  };
>
> -static int rs5c372_get_datetime(struct i2c_client *client, struct
> rtc_time *tm)
> +static int rs5c_get_regs(struct rs5c372 *rs5c)
>  {
> -
> -	struct rs5c372 *rs5c372 = i2c_get_clientdata(client);
> -	u8 *buf = &(rs5c372->regs[1]);
> -
> -	/* this implements the 3rd reading method, according
> -	 * to the datasheet. rs5c372 defaults to internal
> -	 * address 0xF, so 0x0 is in regs[1]
> +	struct i2c_client	*client = rs5c->client;
> +	struct i2c_msg		msgs[] = {
> +		{ client->addr, I2C_M_RD, sizeof rs5c->buf, rs5c->buf },
> +	};
> +
> +	/* This implements the third reading method from the datasheet, using
> +	 * an internal address that's reset after each transaction (by STOP)
> +	 * to 0x0f ... so we read extra registers, and skip the first one.
> +	 *
> +	 * The first method doesn't work with the iop3xx adapter driver, on at
> +	 * least 80219 chips; this works around that bug.
>  	 */
> -
> -	if ((i2c_transfer(client->adapter, rs5c372->msg, 1)) != 1) {
> -		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
> +	if ((i2c_transfer(client->adapter, msgs, 1)) != 1) {
> +		pr_debug("%s: can't read registers\n", rs5c->rtc->name);
>  		return -EIO;
>  	}
>
> -	tm->tm_sec = BCD2BIN(buf[RS5C372_REG_SECS] & 0x7f);
> -	tm->tm_min = BCD2BIN(buf[RS5C372_REG_MINS] & 0x7f);
> -	tm->tm_hour = BCD2BIN(buf[RS5C372_REG_HOURS] & 0x3f);
> -	tm->tm_wday = BCD2BIN(buf[RS5C372_REG_WDAY] & 0x07);
> -	tm->tm_mday = BCD2BIN(buf[RS5C372_REG_DAY] & 0x3f);
> +	dev_dbg(&client->dev,
> +		"%02x %02x %02x (%02x) %02x %02x %02x (%02x), "
> +		"%02x %02x %02x, %02x %02x %02x; %02x %02x\n",
> +		rs5c->regs[0],  rs5c->regs[1],  rs5c->regs[2],  rs5c->regs[3],
> +		rs5c->regs[4],  rs5c->regs[5],  rs5c->regs[6],  rs5c->regs[7],
> +		rs5c->regs[8],  rs5c->regs[9],  rs5c->regs[10], rs5c->regs[11],
> +		rs5c->regs[12], rs5c->regs[13], rs5c->regs[14], rs5c->regs[15]);
> +
> +	return 0;
> +}
> +
> +static unsigned rs5c_reg2hr(struct rs5c372 *rs5c, unsigned reg)
> +{
> +	unsigned	hour;
> +
> +	if (rs5c->time24)
> +		return BCD2BIN(reg & 0x3f);
> +
> +	hour = BCD2BIN(reg & 0x1f);
> +	if (hour == 12)
> +		hour = 0;
> +	if (reg & 0x20)
> +		hour += 12;
> +	return hour;
> +}
> +
> +static unsigned rs5c_hr2reg(struct rs5c372 *rs5c, unsigned hour)
> +{
> +	if (rs5c->time24)
> +		return BIN2BCD(hour);
> +
> +	if (hour > 12)
> +		return 0x20 | BIN2BCD(hour - 12);
> +	if (hour == 12)
> +		return 0x20 | BIN2BCD(12);
> +	if (hour == 0)
> +		return BIN2BCD(12);
> +	return BIN2BCD(hour);
> +}
> +
> +static int rs5c372_get_datetime(struct i2c_client *client, struct
> rtc_time *tm)
> +{
> +	struct rs5c372	*rs5c = i2c_get_clientdata(client);
> +	int		status = rs5c_get_regs(rs5c);
> +
> +	if (status < 0)
> +		return status;
> +
> +	tm->tm_sec = BCD2BIN(rs5c->regs[RS5C372_REG_SECS] & 0x7f);
> +	tm->tm_min = BCD2BIN(rs5c->regs[RS5C372_REG_MINS] & 0x7f);
> +	tm->tm_hour = rs5c_reg2hr(rs5c, rs5c->regs[RS5C372_REG_HOURS]);
> +
> +	tm->tm_wday = BCD2BIN(rs5c->regs[RS5C372_REG_WDAY] & 0x07);
> +	tm->tm_mday = BCD2BIN(rs5c->regs[RS5C372_REG_DAY] & 0x3f);
>
>  	/* tm->tm_mon is zero-based */
> -	tm->tm_mon = BCD2BIN(buf[RS5C372_REG_MONTH] & 0x1f) - 1;
> +	tm->tm_mon = BCD2BIN(rs5c->regs[RS5C372_REG_MONTH] & 0x1f) - 1;
>
>  	/* year is 1900 + tm->tm_year */
> -	tm->tm_year = BCD2BIN(buf[RS5C372_REG_YEAR]) + 100;
> +	tm->tm_year = BCD2BIN(rs5c->regs[RS5C372_REG_YEAR]) + 100;
>
>  	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
>  		"mday=%d, mon=%d, year=%d, wday=%d\n",
> @@ -89,22 +179,25 @@ static int rs5c372_get_datetime(struct i
>  		tm->tm_sec, tm->tm_min, tm->tm_hour,
>  		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
>
> -	return 0;
> +	/* rtc might need initialization */
> +	return rtc_valid_tm(tm);
>  }
>
>  static int rs5c372_set_datetime(struct i2c_client *client, struct
> rtc_time *tm)
>  {
> -	unsigned char buf[8] = { RS5C372_REG_BASE };
> +	struct rs5c372	*rs5c = i2c_get_clientdata(client);
> +	unsigned char	buf[8];
>
> -	dev_dbg(&client->dev,
> -		"%s: secs=%d, mins=%d, hours=%d "
> +	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d "
>  		"mday=%d, mon=%d, year=%d, wday=%d\n",
> -		__FUNCTION__, tm->tm_sec, tm->tm_min, tm->tm_hour,
> +		__FUNCTION__,
> +		tm->tm_sec, tm->tm_min, tm->tm_hour,
>  		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
>
> +	buf[0] = RS5C_ADDR(RS5C372_REG_SECS);
>  	buf[1] = BIN2BCD(tm->tm_sec);
>  	buf[2] = BIN2BCD(tm->tm_min);
> -	buf[3] = BIN2BCD(tm->tm_hour);
> +	buf[3] = rs5c_hr2reg(rs5c, tm->tm_hour);
>  	buf[4] = BIN2BCD(tm->tm_wday);
>  	buf[5] = BIN2BCD(tm->tm_mday);
>  	buf[6] = BIN2BCD(tm->tm_mon + 1);
> @@ -118,21 +211,43 @@ static int rs5c372_set_datetime(struct i
>  	return 0;
>  }
>
> +#if defined(CONFIG_RTC_INTF_PROC) || defined(CONFIG_RTC_INTF_PROC_MODULE)
> +#define	NEED_TRIM
> +#endif
> +
> +#if defined(CONFIG_RTC_INTF_SYSFS) ||
> defined(CONFIG_RTC_INTF_SYSFS_MODULE)
> +#define	NEED_TRIM
> +#endif
> +
> +#ifdef	NEED_TRIM
>  static int rs5c372_get_trim(struct i2c_client *client, int *osc, int
> *trim)
>  {
>  	struct rs5c372 *rs5c372 = i2c_get_clientdata(client);
> -	u8 tmp = rs5c372->regs[RS5C372_REG_TRIM + 1];
> +	u8 tmp = rs5c372->regs[RS5C372_REG_TRIM];
>
>  	if (osc)
>  		*osc = (tmp & RS5C372_TRIM_XSL) ? 32000 : 32768;
>
>  	if (trim) {
> -		*trim = tmp & RS5C372_TRIM_MASK;
> -		dev_dbg(&client->dev, "%s: raw trim=%x\n", __FUNCTION__, *trim);
> +		dev_dbg(&client->dev, "%s: raw trim=%x\n", __FUNCTION__, tmp);
> +		tmp &= RS5C372_TRIM_MASK;
> +		if (tmp & 0x3e) {
> +			int t = tmp & 0x3f;
> +
> +			if (tmp & 0x40)
> +				t = (~t | (s8)0xc0) + 1;
> +			else
> +				t = t - 1;
> +
> +			tmp = t * 2;
> +		} else
> +			tmp = 0;
> +		*trim = tmp;
>  	}
>
>  	return 0;
>  }
> +#endif
>
>  static int rs5c372_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> @@ -144,25 +259,190 @@ static int rs5c372_rtc_set_time(struct d
>  	return rs5c372_set_datetime(to_i2c_client(dev), tm);
>  }
>
> +#if defined(CONFIG_RTC_INTF_DEV) || defined(CONFIG_RTC_INTF_DEV_MODULE)
> +
> +static int
> +rs5c_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +	struct i2c_client	*client = to_i2c_client(dev);
> +	struct rs5c372		*rs5c = i2c_get_clientdata(client);
> +	unsigned char		buf[2];
> +	int			status;
> +
> +	buf[1] = rs5c->regs[RS5C_REG_CTRL1];
> +	switch (cmd) {
> +	case RTC_UIE_OFF:
> +	case RTC_UIE_ON:
> +		/* some 327a modes use a different IRQ pin for 1Hz irqs */
> +		if (rs5c->type == rtc_rs5c372a
> +				&& (buf[1] & RS5C372A_CTRL1_SL1))
> +			return -ENOIOCTLCMD;
> +	case RTC_AIE_OFF:
> +	case RTC_AIE_ON:
> +		/* these irq management calls only make sense for chips
> +		 * which are wired up to an IRQ.
> +		 */
> +		if (!rs5c->has_irq)
> +			return -ENOIOCTLCMD;
> +		break;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +
> +	status = rs5c_get_regs(rs5c);
> +	if (status < 0)
> +		return status;
> +
> +	buf[0] = RS5C_ADDR(RS5C_REG_CTRL1);
> +	switch (cmd) {
> +	case RTC_AIE_OFF:	/* alarm off */
> +		buf[1] &= ~RS5C_CTRL1_AALE;
> +		break;
> +	case RTC_AIE_ON:	/* alarm on */
> +		buf[1] |= RS5C_CTRL1_AALE;
> +		break;
> +	case RTC_UIE_OFF:	/* update off */
> +		buf[1] &= ~RS5C_CTRL1_CT_MASK;
> +		break;
> +	case RTC_UIE_ON:	/* update on */
> +		buf[1] &= ~RS5C_CTRL1_CT_MASK;
> +		buf[1] |= RS5C_CTRL1_CT4;
> +		break;
> +	}
> +	if ((i2c_master_send(client, buf, 2)) != 2) {
> +		printk(KERN_WARNING "%s: can't update alarm\n",
> +			rs5c->rtc->name);
> +		status = -EIO;
> +	} else
> +		rs5c->regs[RS5C_REG_CTRL1] = buf[1];
> +	return status;
> +}
> +
> +#else
> +#define	rs5c_rtc_ioctl	NULL
> +#endif
> +
> +
> +/* NOTE:  Since RTC_WKALM_{RD,SET} were originally defined for EFI,
> + * which only exposes a polled programming interface; and since
> + * these calls map directly to those EFI requests; we don't demand
> + * we have an IRQ for this chip when we go through this API.
> + *
> + * The older x86_pc derived RTC_ALM_{READ,SET} calls require irqs
> + * though, managed through RTC_AIE_{ON,OFF} requests.
> + */
> +
> +static int rs5c_read_alarm(struct device *dev, struct rtc_wkalrm *t)
> +{
> +	struct i2c_client	*client = to_i2c_client(dev);
> +	struct rs5c372		*rs5c = i2c_get_clientdata(client);
> +	int			status;
> +
> +	status = rs5c_get_regs(rs5c);
> +	if (status < 0)
> +		return status;
> +
> +	/* report alarm time */
> +	t->time.tm_sec = 0;
> +	t->time.tm_min = BCD2BIN(rs5c->regs[RS5C_REG_ALARM_A_MIN] & 0x7f);
> +	t->time.tm_hour = rs5c_reg2hr(rs5c, rs5c->regs[RS5C_REG_ALARM_A_HOURS]);
> +	t->time.tm_mday = -1;
> +	t->time.tm_mon = -1;
> +	t->time.tm_year = -1;
> +	t->time.tm_wday = -1;
> +	t->time.tm_yday = -1;
> +	t->time.tm_isdst = -1;
> +
> +	/* ... and status */
> +	t->enabled = !!(rs5c->regs[RS5C_REG_CTRL1] & RS5C_CTRL1_AALE);
> +	t->pending = !!(rs5c->regs[RS5C_REG_CTRL2] & RS5C_CTRL2_AAFG);
> +
> +	return 0;
> +}
> +
> +static int rs5c_set_alarm(struct device *dev, struct rtc_wkalrm *t)
> +{
> +	struct i2c_client	*client = to_i2c_client(dev);
> +	struct rs5c372		*rs5c = i2c_get_clientdata(client);
> +	int			status;
> +	unsigned char		buf[4];
> +
> +	/* only handle up to 24 hours in the future, like RTC_ALM_SET */
> +	if (t->time.tm_mday != -1
> +			|| t->time.tm_mon != -1
> +			|| t->time.tm_year != -1)
> +		return -EINVAL;
> +
> +	/* REVISIT: round up tm_sec */
> +
> +	/* if needed, disable irq (clears pending status) */
> +	status = rs5c_get_regs(rs5c);
> +	if (status < 0)
> +		return status;
> +	if (rs5c->regs[RS5C_REG_CTRL1] & RS5C_CTRL1_AALE) {
> +		buf[0] = RS5C_ADDR(RS5C_REG_CTRL1);
> +		buf[1] = rs5c->regs[RS5C_REG_CTRL1] & ~RS5C_CTRL1_AALE;
> +		if (i2c_master_send(client, buf, 2) != 2) {
> +			pr_debug("%s: can't disable alarm\n", rs5c->rtc->name);
> +			return -EIO;
> +		}
> +		rs5c->regs[RS5C_REG_CTRL1] = buf[1];
> +	}
> +
> +	/* set alarm */
> +	buf[0] = RS5C_ADDR(RS5C_REG_ALARM_A_MIN);
> +	buf[1] = BIN2BCD(t->time.tm_min);
> +	buf[2] = rs5c_hr2reg(rs5c, t->time.tm_hour);
> +	buf[3] = 0x7f;	/* any/all days */
> +	if ((i2c_master_send(client, buf, 4)) != 4) {
> +		pr_debug("%s: can't set alarm time\n", rs5c->rtc->name);
> +		return -EIO;
> +	}
> +
> +	/* ... and maybe enable its irq */
> +	if (t->enabled) {
> +		buf[0] = RS5C_ADDR(RS5C_REG_CTRL1);
> +		buf[1] = rs5c->regs[RS5C_REG_CTRL1] | RS5C_CTRL1_AALE;
> +		if ((i2c_master_send(client, buf, 2)) != 2)
> +			printk(KERN_WARNING "%s: can't enable alarm\n",
> +				rs5c->rtc->name);
> +		rs5c->regs[RS5C_REG_CTRL1] = buf[1];
> +	}
> +
> +	return 0;
> +}
> +
> +#if defined(CONFIG_RTC_INTF_PROC) || defined(CONFIG_RTC_INTF_PROC_MODULE)
> +
>  static int rs5c372_rtc_proc(struct device *dev, struct seq_file *seq)
>  {
>  	int err, osc, trim;
>
>  	err = rs5c372_get_trim(to_i2c_client(dev), &osc, &trim);
>  	if (err == 0) {
> -		seq_printf(seq, "%d.%03d KHz\n", osc / 1000, osc % 1000);
> -		seq_printf(seq, "trim\t: %d\n", trim);
> +		seq_printf(seq, "crystal\t\t: %d.%03d KHz\n",
> +				osc / 1000, osc % 1000);
> +		seq_printf(seq, "trim\t\t: %d\n", trim);
>  	}
>
>  	return 0;
>  }
>
> +#else
> +#define	rs5c372_rtc_proc	NULL
> +#endif
> +
>  static const struct rtc_class_ops rs5c372_rtc_ops = {
>  	.proc		= rs5c372_rtc_proc,
> +	.ioctl		= rs5c_rtc_ioctl,
>  	.read_time	= rs5c372_rtc_read_time,
>  	.set_time	= rs5c372_rtc_set_time,
> +	.read_alarm	= rs5c_read_alarm,
> +	.set_alarm	= rs5c_set_alarm,
>  };
>
> +#if defined(CONFIG_RTC_INTF_SYSFS) ||
> defined(CONFIG_RTC_INTF_SYSFS_MODULE)
> +
>  static ssize_t rs5c372_sysfs_show_trim(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -172,7 +452,7 @@ static ssize_t rs5c372_sysfs_show_trim(s
>  	if (err)
>  		return err;
>
> -	return sprintf(buf, "0x%2x\n", trim);
> +	return sprintf(buf, "%d\n", trim);
>  }
>  static DEVICE_ATTR(trim, S_IRUGO, rs5c372_sysfs_show_trim, NULL);
>
> @@ -189,16 +469,35 @@ static ssize_t rs5c372_sysfs_show_osc(st
>  }
>  static DEVICE_ATTR(osc, S_IRUGO, rs5c372_sysfs_show_osc, NULL);
>
> -static int rs5c372_attach(struct i2c_adapter *adapter)
> +static int rs5c_sysfs_register(struct device *dev)
>  {
> -	return i2c_probe(adapter, &addr_data, rs5c372_probe);
> +	int err;
> +
> +	err = device_create_file(dev, &dev_attr_trim);
> +	if (err)
> +		return err;
> +	err = device_create_file(dev, &dev_attr_osc);
> +	if (err)
> +		device_remove_file(dev, &dev_attr_trim);
> +
> +	return err;
> +}
> +
> +#else
> +static int rs5c_sysfs_register(struct device *dev)
> +{
> +	return 0;
>  }
> +#endif	/* SYSFS */
> +
> +static struct i2c_driver rs5c372_driver;
>
>  static int rs5c372_probe(struct i2c_adapter *adapter, int address, int
> kind)
>  {
>  	int err = 0;
>  	struct i2c_client *client;
>  	struct rs5c372 *rs5c372;
> +	struct rtc_time tm;
>
>  	dev_dbg(adapter->class_dev.dev, "%s\n", __FUNCTION__);
>
> @@ -211,7 +510,15 @@ static int rs5c372_probe(struct i2c_adap
>  		err = -ENOMEM;
>  		goto exit;
>  	}
> -	client = &rs5c372->client;
> +
> +	/* we read registers 0x0f then 0x00-0x0f; skip the first one */
> +	rs5c372->regs=&rs5c372->buf[1];
> +
> +	/* On conversion to a "new style" i2c driver, we'll be handed
> +	 * the i2c_client (we won't create it)
> +	 */
> +	client = &rs5c372->dev;
> +	rs5c372->client = client;
>
>  	/* I2C client */
>  	client->addr = address;
> @@ -222,16 +529,99 @@ static int rs5c372_probe(struct i2c_adap
>
>  	i2c_set_clientdata(client, rs5c372);
>
> -	rs5c372->msg[0].addr = address;
> -	rs5c372->msg[0].flags = I2C_M_RD;
> -	rs5c372->msg[0].len = sizeof(rs5c372->regs);
> -	rs5c372->msg[0].buf = rs5c372->regs;
> -
>  	/* Inform the i2c layer */
>  	if ((err = i2c_attach_client(client)))
>  		goto exit_kfree;
>
> -	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
> +	err = rs5c_get_regs(rs5c372);
> +	if (err < 0)
> +		goto exit_detach;
> +
> +	/* For "new style" drivers, irq is in i2c_client and chip type
> +	 * info comes from i2c_client.dev.platform_data.  Meanwhile:
> +	 *
> +	 * STICK BOARD-SPECIFIC SETUP CODE RIGHT HERE
> +	 */
> +	if (rs5c372->type == rtc_undef) {
> +		rs5c372->type = rtc_rs5c372b;
> +		dev_warn(&client->dev, "assuming rs5c372b\n");
> +	}
> +
> +	/* clock may be set for am/pm or 24 hr time */
> +	switch (rs5c372->type) {
> +	case rtc_rs5c372a:
> +	case rtc_rs5c372b:
> +		/* alarm uses ALARM_A; and nINTRA on 372a, nINTR on 372b.
> +		 * so does periodic irq, except some 327a modes.
> +		 */
> +		if (rs5c372->regs[RS5C_REG_CTRL2] & RS5C372_CTRL2_24)
> +			rs5c372->time24 = 1;
> +		break;
> +	case rtc_rv5c386:
> +	case rtc_rv5c387a:
> +		if (rs5c372->regs[RS5C_REG_CTRL1] & RV5C387_CTRL1_24)
> +			rs5c372->time24 = 1;
> +		/* alarm uses ALARM_W; and nINTRB for alarm and periodic
> +		 * irq, on both 386 and 387
> +		 */
> +		break;
> +	default:
> +		dev_err(&client->dev, "unknown RTC type\n");
> +		goto exit_detach;
> +	}
> +
> +	/* if the oscillator lost power and no other software (like
> +	 * the bootloader) set it up, do it here.
> +	 */
> +	if (rs5c372->regs[RS5C_REG_CTRL2] & RS5C_CTRL2_XSTP) {
> +		unsigned char buf[3];
> +
> +		rs5c372->regs[RS5C_REG_CTRL2] &= ~RS5C_CTRL2_XSTP;
> +
> +		buf[0] = RS5C_ADDR(RS5C_REG_CTRL1);
> +		buf[1] = rs5c372->regs[RS5C_REG_CTRL1];
> +		buf[2] = rs5c372->regs[RS5C_REG_CTRL2];
> +
> +		/* use 24hr mode */
> +		switch (rs5c372->type) {
> +		case rtc_rs5c372a:
> +		case rtc_rs5c372b:
> +			buf[2] |= RS5C372_CTRL2_24;
> +			rs5c372->time24 = 1;
> +			break;
> +		case rtc_rv5c386:
> +		case rtc_rv5c387a:
> +			buf[1] |= RV5C387_CTRL1_24;
> +			rs5c372->time24 = 1;
> +			break;
> +		default:
> +			/* impossible */
> +			break;
> +		}
> +
> +		if ((i2c_master_send(client, buf, 3)) != 3) {
> +			dev_err(&client->dev, "setup error\n");
> +			goto exit_detach;
> +		}
> +		rs5c372->regs[RS5C_REG_CTRL1] = buf[1];
> +		rs5c372->regs[RS5C_REG_CTRL2] = buf[2];
> +	}
> +
> +	if (rs5c372_get_datetime(client, &tm) < 0)
> +		dev_warn(&client->dev, "clock needs to be set\n");
> +
> +	dev_info(&client->dev, "%s found, %s, driver version " DRV_VERSION "\n",
> +			({ char *s; switch (rs5c372->type) {
> +			case rtc_rs5c372a:	s = "rs5c372a"; break;
> +			case rtc_rs5c372b:	s = "rs5c372b"; break;
> +			case rtc_rv5c386:	s = "rv5c386"; break;
> +			case rtc_rv5c387a:	s = "rv5c387a"; break;
> +			default:		s = "chip"; break;
> +			}; s;}),
> +			rs5c372->time24 ? "24hr" : "am/pm"
> +			);
> +
> +	/* FIXME when client->irq exists, use it to register alarm irq */
>
>  	rs5c372->rtc = rtc_device_register(rs5c372_driver.driver.name,
>  				&client->dev, &rs5c372_rtc_ops, THIS_MODULE);
> @@ -241,18 +631,12 @@ static int rs5c372_probe(struct i2c_adap
>  		goto exit_detach;
>  	}
>
> -	err = device_create_file(&client->dev, &dev_attr_trim);
> +	err = rs5c_sysfs_register(&client->dev);
>  	if (err)
>  		goto exit_devreg;
> -	err = device_create_file(&client->dev, &dev_attr_osc);
> -	if (err)
> -		goto exit_trim;
>
>  	return 0;
>
> -exit_trim:
> -	device_remove_file(&client->dev, &dev_attr_trim);
> -
>  exit_devreg:
>  	rtc_device_unregister(rs5c372->rtc);
>
> @@ -266,6 +650,11 @@ exit:
>  	return err;
>  }
>
> +static int rs5c372_attach(struct i2c_adapter *adapter)
> +{
> +	return i2c_probe(adapter, &addr_data, rs5c372_probe);
> +}
> +
>  static int rs5c372_detach(struct i2c_client *client)
>  {
>  	int err;
> @@ -274,6 +663,8 @@ static int rs5c372_detach(struct i2c_cli
>  	if (rs5c372->rtc)
>  		rtc_device_unregister(rs5c372->rtc);
>
> +	/* REVISIT properly destroy the sysfs files ... */
> +
>  	if ((err = i2c_detach_client(client)))
>  		return err;
>
> @@ -281,6 +672,14 @@ static int rs5c372_detach(struct i2c_cli
>  	return 0;
>  }
>
> +static struct i2c_driver rs5c372_driver = {
> +	.driver		= {
> +		.name	= "rtc-rs5c372",
> +	},
> +	.attach_adapter	= &rs5c372_attach,
> +	.detach_client	= &rs5c372_detach,
> +};
> +
>  static __init int rs5c372_init(void)
>  {
>  	return i2c_add_driver(&rs5c372_driver);
>

