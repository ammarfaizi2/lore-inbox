Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWBUWMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWBUWMF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWBUWME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:12:04 -0500
Received: from isilmar.linta.de ([213.239.214.66]:53154 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932359AbWBUWMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:12:03 -0500
Date: Tue, 21 Feb 2006 23:12:01 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH] cpufrequency change on AC-Adapter Event
Message-ID: <20060221221201.GA26858@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Ogrisegg <tom-lkml@lkml.fnord.at>,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
References: <20060221213742.GC26413@rescue.iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221213742.GC26413@rescue.iwoars.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 10:37:42PM +0100, Thomas Ogrisegg wrote:
> Problem Description:
> Whenever the status of the AC-Adapter on my laptop changes, the CPU
> frequency automatically changes as well. For example, if the AC adapter
> is online my CPU has the highest frequency (3,06 GHz). When the adapter
> is unplugged, the frequency automatically decreases to 1,6 GHz. However,
> currently the Kernel simply doesn't notice. It looks like the system is
> still running at 3,06 GHz (/proc/cpuinfo and
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq both show that),
> but it doesn't like a simple test program showed.
> 
> My patch solves this problem: Whenever the status of the AC Adapter
> changes, it calls 'cpufreq_reinit' which in turn reinits the CPUfreq
> driver.
> 
> This, of course, only works if the ACPI AC driver is compiled in.

Uh, no, this just wraps band-aid around the problem. First of all, not all
cpufreq drivers like to be left and re-initialized. Secondly, the timing
code might still not adapt to the new CPU frequency. And thirdly, we can
solve these issues if we call


> 
> Signed-off-by: Thomas Ogrisegg <tom-lkml@lkml.fnord.at>

> diff -uNr -X linux-2.6.15/Documentation/dontdiff linux-2.6.15/drivers/acpi/ac.c linux-2.6.15.4/drivers/acpi/ac.c
> --- linux-2.6.15/drivers/acpi/ac.c	2006-01-03 04:21:10.000000000 +0100
> +++ linux-2.6.15.4/drivers/acpi/ac.c	2006-02-19 17:50:20.000000000 +0100
> @@ -29,6 +29,7 @@
>  #include <linux/types.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> +#include <linux/cpufreq.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> @@ -213,6 +214,8 @@
>  		break;
>  	}
>  
> +	cpufreq_reinit();

	cpufreq_update_policy();

here instead. (untested, but should work)

Thanks,
	Dominik
