Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVAaUEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVAaUEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 15:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVAaUEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 15:04:08 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:2053 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261344AbVAaUDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 15:03:01 -0500
Date: Mon, 31 Jan 2005 21:03:19 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@Stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][I2C] ST M41T00 I2C RTC chip driver
Message-Id: <20050131210319.44a69d49.khali@linux-fr.org>
In-Reply-To: <41FE7368.1000307@mvista.com>
References: <41FE7368.1000307@mvista.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> This patch adds support for the ST M41T00 RTC chip.

As for your other driver, I lack the device-specific knowledge to
comment on the functionality, but still have some technical comments on
the code itself:

> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-m41t00.

It'll actually be called m41t00, according to the Makefile.

> +struct m41t00_data {
> +	struct i2c_client client;
> +};

You don't have to do that. Including the i2c_client stucture in the data
structure is a trick which let us get both allocated with a single
kmalloc (and freed with a single kfree) while still respecting the
arch-dependent alignment requirements. If you have no private data to
carry around, you can do the kmalloc on the i2c_client structure
directly, and have client->data point to NULL (which it actually already
does thanks to memset). This will save some code in both the detection
and the detach functions.

However, if you know that, in a future update of this driver, you *will*
have to store client-private data, then I guess you can keep it this way.

> +	i2c_detach_client(client);

This one supposedly can fail.

> +	.name		= "M41T00",

No caps in name please (will be used in sysfs).

> +static int __devinit
> +m41t00_init(void)
> +{
> +	return i2c_add_driver(&m41t00_driver);
> +}
> 
> +static void __devexit
> +m41t00_exit(void)
> +{
> +	i2c_del_driver(&m41t00_driver);
> +	return;
> +}

Should be __init and __exit, respectively, unless I am mistaken. And the
last return is usless.

I'm also suspicious about the other __devexit and __devinit you used. No
other i2c chip drivers has them.

Thanks,
-- 
Jean Delvare
