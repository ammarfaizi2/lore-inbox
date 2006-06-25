Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWFYK0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWFYK0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWFYK0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 06:26:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5284 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932230AbWFYK0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 06:26:23 -0400
Date: Sun, 25 Jun 2006 03:22:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org, sekharan@us.ibm.com,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.17-mm2
Message-Id: <20060625032243.fcce9e2e.akpm@osdl.org>
In-Reply-To: <200606251051.55355.rjw@sisk.pl>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<20060624172014.GB26273@redhat.com>
	<20060624143440.0931b4f1.akpm@osdl.org>
	<200606251051.55355.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 10:51:55 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > 
> > 
> > My guess would be that cpufreq_register_driver() is being called after it
> > has been unloaded from the kernel.
> > 
> > Do you have CONFIG_CPU_FREQ=y?
> 
> Yes.
> 
> > Does removal of the __cpuinit from cpufreq_register_driver() fix it (or
> > move the crash elsewhere)?
> 
> Yes (makes it go away).

Well it would appear that the new __cpuinit on cpufreq_register_driver() is
causing the problem, although I'm surprised that you don't have
CONFIG_HOTPLUG_CPU set, if it's a swsusp requirement??

> > Do you get any section mismatch warnings at build-time?
> 
> Only this one:
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0x1164) and 'acpi_processor_power_exit'
> 

That's a false-positive - the code in there is, I think, OK:

	static int first_run;

	...

	if (!first_run) {
		dmi_check_system(processor_power_dmi_table);
		...
		first_run++;
	}

The warning is about the reference to processor_power_dmi_table.  But as
long as the first call to acpi_processor_power_init() happens prior to
free_initmem(), we won't actually try to touch the unloaded memory.

It's fragile and nasty though - it'd be nice to sort it out.


Anyway.  It's regrettable that the new section-checking code didn't
complain about the bug.  It looks like this is because the call to
cpufreq_register_driver() happened at modprobe-time, and we don't check for
that.  Which is rather bad.

Sam, would it be possible to check for references from modules into
statically-linked __init code?  It's always wrong...

Rusty/Randy/whoever looks after modules: it also seems wrong that it's
possible to load a module which refers to now-unloaded symbols.  In fact,
it's surprising - sorry if I'm misinterpreting this.  If I'm not, it should
be pretty easy to barf if a module is trying to get at symbols which lie
between __init_begin and __init_end?

Chandra, this is scary stuff.  I'll tempdrop those patches until we can get
the kbuild/modprobe infrastructure in place which will allow us to fully
check your sectioning changes at depmod/modprobe time.

<thinks>

Actually, it should still be possible to do this - simply do a `make
allyesconfig; make' with the patches unapplied, then do it with the patches
applied and then look for the differences in the warnings.

Need to do this with various combinations of CONFIG_MODULES,
CONFIG_HOTPLUG, CONFIG_HOTPLUG_CPU, CONFIG_MEMORY_HOTPLUG,
CONFIG_ACPI_HOTPLUG_MEMORY and CONFIG_ACPI_HOTPLUG_MEMORY_MODULE.
