Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTK1QCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTK1QCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:02:46 -0500
Received: from seconix.com ([213.193.144.104]:48108 "EHLO seconix.com")
	by vger.kernel.org with ESMTP id S262540AbTK1QCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:02:44 -0500
Subject: Re: [ACPI] If your ACPI-enabled machine does clean shutdown
	randomly...
From: Damien Sandras <dsandras@seconix.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031128145249.GA563@elf.ucw.cz>
References: <20031128145249.GA563@elf.ucw.cz>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1070035371.1055.13.camel@golgoth01>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 28 Nov 2003 17:02:51 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven 28/11/2003 à 15:52, Pavel Machek a écrit :
> ...then you probably need this one. (One notebook I have here
> certainly needs it).
> 
> It seems that acpi likes to report completely bogus value from time to
> time...
> 

The problem with that patch is that it is filling the logs, but it is
certainly better than shutting the machine down without warning. I had
that problem and it took me a few minutes to figure out that it was
ACPI.

However, I didn't have that problem with kernel 2.6.0 test 9, it
appeared with 2.6.0 test 10 and test 11. I have mailed the list to see
if there was no patch I could reverse to determine where the problem
was, but I got no reaction, so I guess I will have to live with it ;)


> 								Pavel
> 
> --- clean/drivers/acpi/thermal.c	2003-07-27 22:31:09.000000000 +0200
> +++ linux/drivers/acpi/thermal.c	2003-11-25 22:27:11.000000000 +0100
> @@ -456,6 +459,10 @@
>  	if (!tz || !tz->trips.critical.flags.valid)
>  		return_VALUE(-EINVAL);
>  
> +	if (KELVIN_TO_CELSIUS(tz->temperature) >= 200) {
> +		printk(KERN_ALERT "Are you running CPU or nuclear power plant? ACPI claims CPU temp is %d C. Ignoring.\n", KELVIN_TO_CELSIUS(tz->temperature));
> +		return_VALUE(0);
> +	}
>  	if (tz->temperature >= tz->trips.critical.temperature) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Critical trip point\n"));
>  		tz->trips.critical.flags.enabled = 1;
> @@ -467,6 +474,7 @@
>  	if (result)
>  		return_VALUE(result);
>  
> +	printk(KERN_EMERG "Critical temperature reached (%d C), shutting down.\n", tz->temperature);
>  	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL, tz->trips.critical.flags.enabled);
>  
>  	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
-- 
Damien Sandras <dsandras@seconix.com>

