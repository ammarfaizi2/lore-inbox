Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWC1SKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWC1SKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWC1SKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:10:31 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:24583 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932193AbWC1SK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:10:29 -0500
Date: Tue, 28 Mar 2006 11:11:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>, Andrew Morton <akpm@osdl.org>,
       LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81 & m41t85 chips to m41t00 driver
Message-ID: <20060328181111.GB14170@mag.az.mvista.com>
References: <440B4B6E.8080307@sh.cvut.cz> <zt2d4LqL.1141645514.2993990.khali@localhost> <20060307170107.GA5250@mag.az.mvista.com> <20060318001254.GA14079@mag.az.mvista.com> <20060323210856.f1bfd02b.khali@linux-fr.org> <20060323203843.GA18912@mag.az.mvista.com> <20060324012406.GE9560@mag.az.mvista.com> <20060326145840.5e578fa4.akpm@osdl.org> <20060328002625.GE21077@mag.az.mvista.com> <20060328175450.f207effa.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328175450.f207effa.khali@linux-fr.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Tue, Mar 28, 2006 at 05:54:50PM +0200, Jean Delvare wrote:
> Hi Mark,
> 
> Some more comments, sorry for being slow.

You're not slow at all.  No worries.

> >  drivers/i2c/chips/m41t00.c |  294 ++++++++++++++++++++++++++++++++++-----------
> >  include/linux/m41t00.h     |   50 +++++++
> 
> Who else is going to use this header file? It's rather rare to have a
> hardware-specific header file under include/linux.

The platform-specific code for any platform that uses that rtc will need
to include that header file so it can pass the platform data to the rtc
driver.  I have a patch for arch/ppc/platforms/katana.c but I haven't
submitted it b/c of the ppc->powerpc merge that's going on right now.
I will get it in there once I've moved the katana code into the merged tree.
There is a lot of work before that happens, though.

> > diff -Nurp linux-2.6.16-mm1-cleanup/drivers/i2c/chips/m41t00.c linux-2.6.16-mm1-newsupp/drivers/i2c/chips/m41t00.c
> > --- linux-2.6.16-mm1-cleanup/drivers/i2c/chips/m41t00.c	2006-03-27 16:00:35.000000000 -0700
> > +++ linux-2.6.16-mm1-newsupp/drivers/i2c/chips/m41t00.c	2006-03-27 16:49:35.000000000 -0700
> > (...)
> >  static unsigned short ignore[] = { I2C_CLIENT_END };
> > -static unsigned short normal_addr[] = { 0x68, I2C_CLIENT_END };
> > +static unsigned short normal_addr[] = { 0, I2C_CLIENT_END };
> 
> Bad idea. If no platform data is found, the driver will attempt to
> probe I2C address 0, which is a broadcast address. I can predict
> interesting results ;)
>
> So, if you don't want the driver to do anything in the absence of
> platform data, you should define normal_addr the following way:

If there is no platform data, m41t00_platform_probe() should return
-ENODEV and make m41t00_init() causing the driver to not become active.
I've tested that, actually, and it seems to work.

> static unsigned short normal_addr[] = { I2C_CLIENT_END, I2C_CLIENT_END };

Hrm, that's a good idea.  I'll do that, even though it shouldn't be
necessary.

> > +struct m41t00_chip_info {
> > +	u16	type;
> > +	u16	read_limit;
> > +	u8	sec;		/* Offsets for chip regs */
> > +	u8	min;
> > +	u8	hour;
> > +	u8	day;
> > +	u8	mon;
> > +	u8	year;
> > +	u8	alarm_mon;
> > +	u8	alarm_hour;
> > +	u8	sqw;
> > +	u32	sqw_freq;
> > +};
> 
> u16 is probably overkill for .type and .read_limit.

Yeah, probably.  I'll change them to u8.

> > +static struct m41t00_chip_info m41t00_chip_info_tbl[] = {
> > +	{ M41T00_TYPE_M41T00, 5, 0, 1, 2, 4, 5, 6, 0, 0, 0, 0 },
> > +	{ M41T00_TYPE_M41T81, 1, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
> > +	{ M41T00_TYPE_M41T85, 1, 1, 2, 3, 5, 6, 7, 0xa, 0xc, 0x13, 0 },
> > +};
> 
> C99-style initialization, please? It'll take much more lines, granted,
> but is also way more robust to future changes, and will be more
> readable too.

Well, the struct is right there so I figured the chances of changing the
struct and not seeing that the compile-time init code needs to be
changed too was small.  I guess its better to be safe than sorry and it
does make it more readable so I'll change it.

> May I ask why you define separate types for the M41T81 and the M41T85,
> when you handle both exactly the same way?

The only reason is so that its obvious that both the t81 and t85 are
supported.  If I make it M41T81 only then I can easily see someone
grep'ing around looking for M41T85, not finding it, and writing their
own driver.  I don't see any harm in having both, do you?

> > +		sec = buf[m41t00_chip->sec] & 0x7f;
> > +		min = buf[m41t00_chip->min] & 0x7f;
> > +		hour = buf[m41t00_chip->hour] & 0x3f;
> > +		day = buf[m41t00_chip->day] & 0x3f;
> > +		mon = buf[m41t00_chip->mon] & 0x1f;
> > +		year = buf[m41t00_chip->year] & 0xff;
> 
> The year masking is a no-op, you could omit it.

Yes.

> > @@ -169,24 +246,100 @@ m41t00_probe(struct i2c_adapter *adap, i
> >  {
> >  	struct i2c_client *client;
> >  	int rc;
> > +	u8 rbuf[1], wbuf[2], msgbuf[1] = { 0 }; /* offset into rtc's regs */
> > +	struct i2c_msg msgs[] = {
> > +		{
> > +			.addr	= 0,
> > +			.flags	= 0,
> > +			.len	= 1,
> > +			.buf	= msgbuf,
> > +		},
> > +		{
> > +			.addr	= 0,
> > +			.flags	= I2C_M_RD,
> > +			.len	= 1,
> > +			.buf	= rbuf,
> > +		},
> > +	};
> 
> Why don't you initialize both .addr right away?

Actually, I already init the .addr field right away so I'll remove them
from them from the code above.

> >  
> >  	client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
> >  	if (!client)
> >  		return -ENOMEM;
> >  
> > -	strlcpy(client->name, M41T00_DRV_NAME, I2C_NAME_SIZE);
> > +	strlcpy(client->name, m41t00_driver.driver.name, I2C_NAME_SIZE);
> 
> The driver name may not be suitable here, the client name should
> instead reflect what chip it is.

Ah, good one.

> > +	if (m41t00_chip->type != M41T00_TYPE_M41T00) {
> > +		/* If asked, set SQW frequency & enable */
> > +		if (m41t00_chip->sqw_freq) {
> > +			msgbuf[0] = m41t00_chip->alarm_mon;
> > +			if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
> > +				goto sqw_err;
> 
> You did not check whether the adapter you are attaching to supports this
> kind of transaction! You need to call i2c_check_functionality, see how
> other i2c chip drivers (for example ds1337) are doing. For i2c_transfer
> and i2c_master_send, you want to check for I2C_FUNC_I2C.

Okay.

> > +
> > +			wbuf[0] = m41t00_chip->alarm_mon;
> > +			wbuf[1] = rbuf[0] & ~0x40;
> > +			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> > +				goto sqw_err;
> > +
> > +			wbuf[0] = m41t00_chip->sqw;
> > +			wbuf[1] = m41t00_chip->sqw_freq;
> > +			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> > +				goto sqw_err;
> > +
> > +			wbuf[0] = m41t00_chip->alarm_mon;
> > +			wbuf[1] = rbuf[0] | 0x40;
> > +			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> > +				goto sqw_err;
> > +		}
> > +
> > +		/* Make sure HT (Halt Update) bit is cleared */
> > +		msgbuf[0] = m41t00_chip->alarm_hour;
> > +		if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
> > +			goto ht_err;
> > +
> > +		if (rbuf[0] & 0x40) {
> > +			wbuf[0] = m41t00_chip->alarm_hour;
> > +			wbuf[1] = rbuf[0] & ~0x40;
> > +			if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> > +				goto ht_err;
> > +		}
> > +	}
> > +
> > +	/* Make sure ST (stop) bit is cleared */
> > +	msgbuf[0] = m41t00_chip->sec;
> > +	if ((rc = i2c_transfer(client->adapter, msgs, 2)) < 0)
> > +		goto st_err;
> > +
> > +	if (rbuf[0] & 0x80) {
> > +		wbuf[0] = m41t00_chip->sec;
> > +		wbuf[1] = rbuf[0] & ~0x80;
> > +		if ((rc = i2c_master_send(client, wbuf, 2)) < 0)
> > +			goto st_err;
> >  	}
> 
> What you do here are basically SMBus Read Byte and SMBus Write Byte
> transactions. The code would be much more simple if you were using the
> i2c_smbus_read_byte_data and i2c_smbus_write_byte_data functions, which
> take care of all the technical details.

That's true but I assumed that since I was using i2c_transfer
earlier, I should use it here.  Is that a bad assumption?
I do see that ds1337.c uses both types.

> > +st_err:
> > +	dev_err(&client->dev, "m41t00_probe: Can't clear ST bit\n");
> > +	goto attach_err;
> > +ht_err:
> > +	dev_err(&client->dev, "m41t00_probe: Can't clear HT bit\n");
> > +	goto attach_err;
> > +sqw_err:
> > +	dev_err(&client->dev, "m41t00_probe: Can't set SQW Frequency\n");
> > +attach_err:
> > +	kfree(client);
> > +	return rc;
> >  }
> 
> Mrghh, this isn't exactly elegant... You should be able to make it
> better if you switch to i2c_smbus_read/write_byte_data as suggested.

Yep.

> > diff -Nurp linux-2.6.16-mm1-cleanup/include/linux/m41t00.h linux-2.6.16-mm1-newsupp/include/linux/m41t00.h
> > --- linux-2.6.16-mm1-cleanup/include/linux/m41t00.h	1969-12-31 17:00:00.000000000 -0700
> > +++ linux-2.6.16-mm1-newsupp/include/linux/m41t00.h	2006-03-27 16:25:51.000000000 -0700
> > @@ -0,0 +1,50 @@
> > +/*
> > + * Definitions for the ST M41T00 family of i2c rtc chips.
> > + *
> > + * Author: Mark A. Greer <mgreer@mvista.com>
> > + *
> > + * 2005 (c) MontaVista Software, Inc. This file is licensed under
> 
> We're in year 2006 now :)

Yes, but my understanding is that I should leave the 2005 there b/c that
file was already copyrighted with that year.  I could do a "2005, 2006"
if you like.

> > + * the terms of the GNU General Public License version 2. This program
> > + * is licensed "as is" without any warranty of any kind, whether express
> > + * or implied.
> > + */
> > +
> > +#ifndef _M41T00_H
> > +#define _M41T00_H
> > +
> > +#define	M41T00_DRV_NAME		"m41t00"
> 
> Why do you need to export this?

Because the code that passes the platform_data needs to put that name
in the data so that the driver can find it.  That's the value that the
driver uses to search for its platform_data.  I'll attach the patch to
the platform code that I used to test it so you can see what I mean.
Its at the end of this email.

> > +#define	M41T00_I2C_ADDR		0x68
> 
> Not used anywhere?

Yes, in the platform code.

> > +#define	M41T00_TYPE_M41T00	0
> > +#define	M41T00_TYPE_M41T81	81
> > +#define	M41T00_TYPE_M41T85	85
> 
> The i2c core has a facility for drivers supporting several types of
> devices. Check for I2C_CLIENT_INSMOD_3() in your case. The advantage if
> you go that way is that chip types can be set from userspace through
> module parameters, which may be convenient for testing when adding
> support for new platforms.

Okay, I'll take a look.

> > +/* SQW output disabled, this is default value by power on*/
> > +#define SQW_FREQ_DISABLE	(0)
> > +
> > +#define SQW_FREQ_32KHZ	(1<<4)		/* 32.768 KHz */
> > +#define SQW_FREQ_8KHZ	(2<<4)		/* 8.192 KHz */
> > +#define SQW_FREQ_4KHZ	(3<<4)		/* 4.096 KHz */
> > +#define SQW_FREQ_2KHZ	(4<<4)		/* 2.048 KHz */
> > +#define SQW_FREQ_1KHZ	(5<<4)		/* 1.024 KHz */
> > +#define SQW_FREQ_512HZ	(6<<4)		/* 512 Hz */
> > +#define SQW_FREQ_256HZ	(7<<4)		/* 256 Hz */
> > +#define SQW_FREQ_128HZ	(8<<4)		/* 128 Hz */
> > +#define SQW_FREQ_64HZ	(9<<4)		/* 64 Hz */
> > +#define SQW_FREQ_32HZ	(10<<4)		/* 32 Hz */
> > +#define SQW_FREQ_16HZ	(11<<4)		/* 16 Hz */
> > +#define SQW_FREQ_8HZ	(12<<4)		/* 8 Hz */
> > +#define SQW_FREQ_4HZ	(13<<4)		/* 4 Hz */
> > +#define SQW_FREQ_2HZ	(14<<4)		/* 2 Hz */
> > +#define SQW_FREQ_1HZ	(15<<4)		/* 1 Hz */
> 
> Not used anywhere either?

Platform code can pass one of these values into the driver via
platform_data (if its a t81 or t85, not needed for the t00).

> > +extern ulong m41t00_get_rtc_time(void);
> > +extern int m41t00_set_rtc_time(ulong nowtime);
> 
> Hopefully you won't have to export these anymore after you move to the
> new RTC subsystem. But that's a different story. In the meantime,
> shouldn't you have EXPORT_SYMBOL_GPL() for these functions? Else
> compiling m41t00 as a module won't work.

Good point.  Will fix.

Below is the katana patch.  Basically, it adds the platform_data
required for the m41t00 rtc which the m41t00 driver later takes out.
Note that the m41t00 doesn't need the sqw_freq value so you won't see
it being set in this patch.

I did have a couple questions above so I'll wait for your response
and then make a new patch.

Thanks for your time, Jean.

Mark
---

diff -Nurp linux-2.6.16-mm1-cleanup/arch/ppc/platforms/katana.c linux-2.6.16-mm1-newsupp/arch/ppc/platforms/katana.c
--- linux-2.6.16-mm1-cleanup/arch/ppc/platforms/katana.c	2006-03-23 16:15:22.000000000 -0700
+++ linux-2.6.16-mm1-newsupp/arch/ppc/platforms/katana.c	2006-03-23 17:37:46.000000000 -0700
@@ -28,6 +28,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mv643xx.h>
 #include <linux/platform_device.h>
+#include <linux/m41t00.h>
 #ifdef CONFIG_BOOTIMG
 #include <linux/bootimg.h>
 #endif
@@ -843,8 +844,31 @@ katana_find_end_of_memory(void)
 }
 
 #if defined(CONFIG_I2C_MV64XXX) && defined(CONFIG_SENSORS_M41T00)
-extern ulong	m41t00_get_rtc_time(void);
-extern int	m41t00_set_rtc_time(ulong);
+static struct m41t00_platform_data katana_m41t00_pdata = {
+	.type = M41T00_TYPE_M41T00,
+	.i2c_addr = M41T00_I2C_ADDR,
+};
+
+static struct platform_device katana_m41t00_pdev = {
+	.name		= M41T00_DRV_NAME,
+	.id		= 0,
+	.num_resources	= 0,
+	.dev = {
+		.platform_data = &katana_m41t00_pdata,
+	},
+};
+
+static int __init
+katana_add_pdata(void)
+{
+	int rc;
+
+	if ((rc = platform_device_register(&katana_m41t00_pdev)))
+		platform_device_unregister(&katana_m41t00_pdev);
+
+	return rc;
+}
+arch_initcall(katana_add_pdata);
 
 static int __init
 katana_rtc_hookup(void)
