Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWHVAnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWHVAnJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWHVAnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:43:09 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:22601 "EHLO
	asav07.insightbb.com") by vger.kernel.org with ESMTP
	id S1751339AbWHVAnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:43:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAE7u6USBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error handling
Date: Mon, 21 Aug 2006 20:43:05 -0400
User-Agent: KMail/1.9.3
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, lm-sensors@lm-sensors.org,
       LKML <linux-kernel@vger.kernel.org>
References: <44E8C9AE.3060307@gmail.com> <20060821100416.4d356328.khali@linux-fr.org>
In-Reply-To: <20060821100416.4d356328.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608212043.06256.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 August 2006 04:04, Jean Delvare wrote:
> > --- linux-work-clean/drivers/hwmon/w83627hf.c	2006-08-20 22:02:40.000000000 +0200
> > +++ linux-work/drivers/hwmon/w83627hf.c	2006-08-20 22:27:14.000000000 +0200
> > @@ -513,9 +513,21 @@ static DEVICE_ATTR(in0_max, S_IRUGO | S_
> > 
> >  #define device_create_file_in(client, offset) \
> >  do { \
> > -device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> > -device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> > -device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> > +	if (err) {\
> > +		hwmon_device_unregister(data->class_dev); \
> > +		return err; \
> > +	} \
> > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> > +	if (err) {\
> > +		hwmon_device_unregister(data->class_dev); \
> > +		return err; \
> > +	} \
> > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> > +	if (err) {\
> > +		hwmon_device_unregister(data->class_dev); \
> > +		return err; \
> > +	} \
> >  } while (0)
> 
> _Never_ use "return" in a macro. It's way too confusing for whoever will
> read the code later.
>

Also I believe it is good practice to remove created attributes explicitely
instead of relying on sysfs to do the cleanup - I beliee Greg was going to
remove it from sysfs at some point of time... 

-- 
Dmitry
