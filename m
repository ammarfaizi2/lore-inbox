Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbVHPLcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbVHPLcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 07:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbVHPLcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 07:32:14 -0400
Received: from isilmar.linta.de ([213.239.214.66]:17615 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932640AbVHPLcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 07:32:14 -0400
Date: Tue, 16 Aug 2005 10:53:45 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Todd Poynor <tpoynor@mvista.com>
Cc: cpufreq@lists.linux.org.uk, Patrick Mochel <mochel@digitalimplant.org>,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: PowerOP 0/3: System power operating point management API
Message-ID: <20050816085345.GJ9150@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Todd Poynor <tpoynor@mvista.com>, cpufreq@lists.linux.org.uk,
	Patrick Mochel <mochel@digitalimplant.org>, linux-pm@lists.osdl.org,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com> <20050810100718.GC1945@elf.ucw.cz> <42FA796A.4080205@mvista.com> <20050809024907.GA25064@slurryseal.ddns.mvista.com> <Pine.LNX.4.50.0508091110430.19925-100000@monsoon.he.net> <42F963F6.60209@mvista.com> <20050809030000.GA25112@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FA796A.4080205@mvista.com> <42F963F6.60209@mvista.com> <20050809030000.GA25112@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The PowerOP infrastructure you suggest surely is one path to better runtime
power management in the Linux kernel. However, I don't like it at all in its
current implementation. Here are a few suggestions for improvements,
rewrites, and so on:

First, the table interface you suggest is ugly. If there's indeed the need for
such an abstraction, I'd favour something like

	struct powerop {
		struct list_head	powerop_values; /* linked list of powerop_values */
		...
	}

	struct powerop_value {
		unsigned long		value_cur;
		unsigned long		value_min;
		unsigned long		value_max;
		struct list_head	next;
		u16			type;
		struct powerop_value	*cross_dependency;
		struct powerop_driver	*driver;
	}

	#define POWEROP_TYPE_CPU_FREQUENCY		0x00000001
	#define POWEROP_TYPE_CPU_VOLTAGE		0x00000002
	#define POWEROP_TYPE_FRONT_SIDE_BUS_SPEED	0x00000004
	...
	#define POWEROP_TYPE_GPU_FREQUENCY	0x00010000
	...

and if CPU_VOLTAGE and CPU_FREQEUNCY can only be modified at the same time, (as
most cpufreq drivers require), type is 0x00000003.


Secondly, you do not adress the cross-relationships between operation points
correctly. If you change the CPU frequency, you may have to switch other
(memory, video) settings; you might even have to validate the frequency
settings for these or even additional reasons (thermal and battery reasons -
ACPI _PPC).

Thirdly, who is to decide on the power management settings? The first and
intuitive answer is the kernel. Therefore, kernel-space cpufreq governors
exist. Only under rare circumstances, you want full userspace control --
that's what the userspace cpufreq governor is for.

Foruthly, the code duplication which your implementation leads to is obvious
for the speedstep-centrino case. And in contrast to Pavel, I do not consider
it a "tiny cleanup".



I'd suggest that you try upgrading the cpufreq infrastructure to provide
full support for multiple types of POWEROPs:

a)	Setting of "policies"
	- New "min" or "max" values for all powerop_values are set, verified
	  by powerop lowlevel drivers, powerop governors and external
	  notifiers. E.g. if a new frequency min/max pair is required, the
	  voltage level gets a new min and max value as well --> you need to
	  handle recursion.
	- If necessary a new "powerop governor" is started.
	   - Each powerop governor specifies which POWEROPs it can handle
		- current cpufreq governors can handle CPU_FREQUENCY,
		  CPU_VOLTAGE and FRONT_SIDE_BUS_SPEED
		- an userspace fallback-governor always "handles" the
		  parameters no other governor handles

b)	Setting of "values"
	- Each governor can initiate transitions between the "min" and "max"
	  values for operationg points it aquired ownership for.
	- The new setting is notified to all other governors and to external
	  notifiers. If some entitiy decides it cannot live well with this
	  new setting, it breaks out. Note that this should not happen quite
	  often, as the "normal" verification takes place in a) above.
	  Nonetheless, if you want to break out CPU_VOLTAGE and CPU_FREQUENCY, you
	  need it. And as it makes life for the kernel so much more
	  difficult, I'm against doing so.
	- The low-level driver handling the powerop_value is called

Thanks,
	Dominik
