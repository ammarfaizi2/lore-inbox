Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVACTMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVACTMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVACTKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:10:09 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:41228 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261522AbVACTJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:09:05 -0500
Date: Mon, 3 Jan 2005 20:10:56 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: Ticket #1851 - PATCH for adm1026.c, kernel 2.6.10-bk6
Message-Id: <20050103201056.3c55e330.khali@linux-fr.org>
In-Reply-To: <20050103194355.GA11979@penguincomputing.com>
References: <41D5D075.4000200@paradyne.com>
	<20050101001205.6b2a44d3.khali@linux-fr.org>
	<20050103194355.GA11979@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

> Sorry for the slow response.  Real World vacation time intervened.

Don't be sorry :)

> Yes, I confirmed the reported problem.  The patch below should fix
> it... It should also fix any other values-not-initialized-
> to-hardware-defaults  issues.
> (...)
> --- linux-2.6.10/drivers/i2c/chips/adm1026.c.orig	2005-01-02 15:21:58.000000000 -0800
> +++ linux-2.6.10/drivers/i2c/chips/adm1026.c	2005-01-02 16:09:52.000000000 -0800
> @@ -1752,6 +1752,10 @@ int adm1026_detect(struct i2c_adapter *a
>  	device_create_file(&new_client->dev,
>  	&dev_attr_temp2_auto_point2_pwm);
>  	device_create_file(&new_client->dev,
>  	&dev_attr_temp3_auto_point2_pwm);
>  	device_create_file(&new_client->dev, &dev_attr_analog_out);
> +
> +	/* Make sure hardware defaults are read into data structure */
> +	adm1026_update_device(&new_client->dev);
> +
>  	return 0;

Mmm, I don't like this fix.

For one thing, it still leaves some room for someone to call a sysfs
callback function before the values are all intialized (because you
create the sysfs files interface first, then intialize all the values).

For another, this change will significantly increase the driver loading
time. Just check it! SMBus is slow and the ADM1026 has a lot of
registers.

The issue was already discussed on the sensors mailing-list (because the
adm1026 is not the first affected driver, although others were not
subject to division by zero). I think I remember Mark Hoffman was
actually in favor of what you suggest [1], but I would like to see this
avoided if possible.

[1] http://archives.andrew.net.au/lm-sensors/msg26017.html

Alternatives I can think of are:

1* Only intialize the few values that actually can be needed before
the update function was ever called.

2* Call the update function from the write sysfs callback functions
where needed.

All drivers implement 1* (except those which are truly broken maybe) so
far IIRC. I guess that the best choice probably depends on how much
registers have to be read, and how hard it is to read them (because this
is code duplication). That said, the relevant code could be moved to a
separate function, called by both the detect/init and update functions,
so that no slowdown occurs (except for the extra function call, but
that's nothing compared to the SMBus slowness) and the code is still not
duplicated.

-- 
Jean Delvare
http://khali.linux-fr.org/
