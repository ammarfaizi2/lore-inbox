Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWGCH36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWGCH36 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWGCH36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:29:58 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:53001 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750765AbWGCH35
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:29:57 -0400
Date: Mon, 3 Jul 2006 09:29:58 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, linux-kernel@killerfox.forkbomb.ch,
       benh@kernel.crashing.org, johannes@sipsolutions.net, stelian@popies.net,
       chainsaw@gentoo.org
Subject: Re: [RFC] Apple Motion Sensor driver
Message-Id: <20060703092958.8ca17e53.khali@linux-fr.org>
In-Reply-To: <20060702222649.GA13411@hansmi.ch>
References: <20060702222649.GA13411@hansmi.ch>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> Below you find the latest revision of my AMS driver. AMS stands for
> Apple Motion Sensor and it's included in the 2005 revisions of Apple
> iBooks and PowerBooks. The driver implements the PMU and I2C variants.
> MacBooks have another variant, which is not handled by this driver,
> mainly because it's totally different and I don't have access to a
> MacBook.
> 
> Some of the code is based on the I2C ams driver from Stelian Pop, whom
> I'd like to thank for his work.
> 
> HD parking is marked BROKEN as of now, because it'll need changes to the
> block, IDE and SCSI layers. The infrastructure works, tough (tested with
> my own HD parking code). That's why I left it in there.

I'd rather leave it out for now, and merge it when it has a chance to
work. Merging non-working code is confusing at best.

> I want this driver to be included in -mm as soon as possible, to get
> test feedback and to get it included in 2.6.19 (or maybe 2.6.18? Who
> knows. ;)). Thus I'd like to get your comments, suggestions, etc. on it.

2.6.19 at best.

> diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/Kconfig linux-2.6.17-git20/drivers/hwmon/Kconfig
> --- linux-2.6.17-git20.orig/drivers/hwmon/Kconfig	2006-07-02 21:49:19.000000000 +0200
> +++ linux-2.6.17-git20/drivers/hwmon/Kconfig	2006-07-02 22:20:22.000000000 +0200
> @@ -507,6 +507,42 @@ config SENSORS_HDAPS
>  	  Say Y here if you have an applicable laptop and want to experience
>  	  the awesome power of hdaps.
>  
> +config SENSORS_AMS
> +	tristate "Motion sensor driver"
> +	default y

No, not everyone has this device. We don't have a default for other
hardware monitoring drivers.

This should depend on HWMON, and probably EXPERIMENTAL too, until it
gets some wider testing.

Also please respect the alphabetical order.

> +	help
> +	  Support for the motion sensor included in PowerBooks.
> +
> +config SENSORS_AMS_PMU
> +	bool "PMU variant"
> +	depends on SENSORS_AMS && ADB_PMU
> +	default y
> +	help
> +	  PMU variant of motion sensor, found in late 2005 PowerBooks.
> +
> +config SENSORS_AMS_I2C
> +	bool "I2C variant"
> +	depends on SENSORS_AMS && I2C
> +	default y
> +	help
> +	  I2C variant of motion sensor, found in early 2005 PowerBooks and
> +	  iBooks.
> +
> +config SENSORS_AMS_MOUSE
> +	bool "Support for mouse mode with motion sensor"
> +	depends on SENSORS_AMS && INPUT
> +	help
> +	  Support for mouse emulation with motion sensor.
> +
> +config SENSORS_AMS_HDPARK
> +	bool "Park hard disk heads on freefall or shock"
> +	depends on SENSORS_AMS = y && BROKEN
> +	default y
> +	help
> +	  Park the internal hard disk's heads if a free fall or shock is
> +	  detected. This can help to prevent data loss in case of a
> +	  head crash, altough nobody can guarantee anything.
> +
>  config HWMON_DEBUG_CHIP
>  	bool "Hardware Monitoring Chip debugging messages"
>  	depends on HWMON
> diff -Nrup --exclude-from linux-exclude-from linux-2.6.17-git20.orig/drivers/hwmon/Makefile linux-2.6.17-git20/drivers/hwmon/Makefile
> --- linux-2.6.17-git20.orig/drivers/hwmon/Makefile	2006-07-02 21:49:19.000000000 +0200
> +++ linux-2.6.17-git20/drivers/hwmon/Makefile	2006-07-02 22:17:43.000000000 +0200
> @@ -49,6 +49,13 @@ obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
>  obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
>  obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
>  
> +ams-y					:= ams-core.o
> +ams-$(CONFIG_SENSORS_AMS_PMU)		+= ams-pmu.o
> +ams-$(CONFIG_SENSORS_AMS_I2C)		+= ams-i2c.o
> +ams-$(CONFIG_SENSORS_AMS_MOUSE)		+= ams-mouse.o
> +ams-$(CONFIG_SENSORS_AMS_HDPARK)	+= ams-hdpark.o
> +obj-$(CONFIG_SENSORS_AMS)		+= ams.o

If you are going to have many source files and a composite module,
please create your own subdirectory under drivers/hwmon and put all
your stuff here. The kernel build system is notoriously bad at handling
multiple composite modules within the same subdirectory.

I won't have the time to review such a big and complex driver within
several weeks, so people who want this driver in 2.6.19 will have to
review it by themselves.

Thanks,
-- 
Jean Delvare
