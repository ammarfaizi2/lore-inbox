Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUCJNsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 08:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbUCJNsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 08:48:32 -0500
Received: from poup.poupinou.org ([195.101.94.96]:17928 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S262606AbUCJNs0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 08:48:26 -0500
Date: Wed, 10 Mar 2004 14:48:11 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: patches@x86-64.org, davej@redhat.com,
       kernel list <linux-kernel@vger.kernel.org>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>
Subject: Re: powernow-k8 updates
Message-ID: <20040310134811.GD28592@poupinou.org>
References: <20040309214830.GA1240@elf.ucw.cz> <20040310110941.GC28592@poupinou.org> <20040310113246.GA4775@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20040310113246.GA4775@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.4i
From: Bruno Ducrot <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 10, 2004 at 12:32:46PM +0100, Pavel Machek wrote:
> > If that is not acceptable by AMD, then you have to contact ACPI SIG
> > at <http://www.acpi.info/> in order to change specs.
> 
> Notice that amd's powernow is done through acpi, but does not comply
> to the acpi specs. That should be okay; in such case its up to AMD to
> define how it behaves.

Yes, but then, I think that AMD shall contact ACPI SIG in order to
change specs, or even becoming member of ACPI SIG.

Note that currently drivers/acpi/processor.c do not check the
requirement to have the exact same number of pstates for each processor.
I don't think that nobody want to fix that btw ;)

> > For the last time, why on earth you still do not consider the ACPI
> > perflib.  Links to the cpufreq-developper mailing list with even a kind
> > of public access have been posted.  That will eliminate the following
> > functions amongst other things.  Look at drivers/acpi/processor.c
> 
> I see that file. It seems to be full of northbridge bugs workarounds,
> and seems to be handling processor C states. It handles powernow
> states on machines that do it through acpi. I do not see how I could
> use it, and I do not see how query_ac could disappear. It might be
> nice to use same processor/.../performance interface, but it is
> deprecated anyway. 
> 
> What do I miss?

ducrot@poupon:~/kernel/linux-2.6.4-bk-acpi> grep EXPORT drivers/acpi/processor.c
EXPORT_SYMBOL(acpi_processor_register_performance);
EXPORT_SYMBOL(acpi_processor_unregister_performance);
EXPORT_SYMBOL(acpi_processor_set_thermal_limit);

So all you need are acpi_processor_register_performance() and
acpi_processor_unregister_performance().  I'm pretty sure that those
functions are in 2.6.4-rc2.

If you want to play with those functions, you have to include
<acpi/processor.h>, and then you have to register a driver via:
acpi_processor_register_performance(&pr, cpu) where:
- cpu is the cpu id (point-of-view of Linux, not the acpi cpu id),
- pr is a struct acpi_processor_performance (defined in
  acpi/processor.h).

You will have then for free:
- configurations via the acpi_processor_performance structure,
- handling of the _PPC object, so that you don't have to care about
  changes for that in the driver.  That will be done via classic
  ACPI event notifications to the processor, via the limit interface
  writen in drivers/acpi/processor.c, and cpufreq notion of notifiers.

More, you do not have to worry about ACPI initialisation.  At that time,
the powernow-k8 acpi driver do not even check if ACPI is initialised, or
up and running, etc, like it is done in the sonypi driver for example.

If you want examples, there were posts for the centrino case, and for
the powernow-k7, in cpufreq mailing lists.

I used also that stupid module, an hack of an example provided by
Dominik, in order to write the support for the powernow-k7.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.

--OgqxwSJOaUobr8KG
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="test-powernow.c"

/*
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/cpufreq.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <asm/io.h>
#include <asm/delay.h>
#include <asm/uaccess.h>

#include <linux/acpi.h>
#include <acpi/processor.h>

struct acpi_processor_performance p;

union powernow_acpi_control_t {
	struct {
		unsigned long fid:5,
		vid:5,
		sgtc:20,
		res1:2;
	} bits;
	unsigned long val;
};

#define ACPI_PDC_REVISION_ID                   0x1
#define ACPI_PDC_CAPABILITY_ENHANCED_SPEEDSTEP 0x1

static int __init
acpi_cpufreq_init (void)
{
	unsigned int i;
	struct acpi_pct_register *r;
	union powernow_acpi_control_t pc;

	if (acpi_processor_register_performance(&p, 0))
		return -EIO;

	printk("number of states: %d\n", p.state_count);
	for (i=0; i< p.state_count; i++) {
		pc.val = (unsigned long) p.states[i].control;
		printk(KERN_INFO "powernow: %cP%d: %d MHz, %d mW, %d uS, control %08x, status %08x, vid: %02x fid: %02x SGTC: %d\n",
		       (i == p.state?'*':' '), i,
		       (u32) p.states[i].core_frequency,
		       (u32) p.states[i].power,
		       (u32) p.states[i].transition_latency,
		       (u32) p.states[i].control,
		       (u32) p.states[i].status,
		       pc.bits.vid,
		       pc.bits.fid,
		       pc.bits.sgtc);

	}

	printk("control_register:\n");
	r = &p.control_register;
	printk("%d %d %d %d %d %d %lld\n", r->descriptor, r->length, r->space_id,
	       r->bit_width, r->bit_offset, r->reserved, r->address);

	printk("status_register:\n");
	r = &p.status_register;
	printk("%d %d %d %d %d %d %lld\n", r->descriptor, r->length, r->space_id,
	       r->bit_width, r->bit_offset, r->reserved, r->address);

	acpi_processor_unregister_performance(&p, 0);

	return -ENODEV;
}


static void __exit
acpi_cpufreq_exit (void)
{
	return;
}


late_initcall(acpi_cpufreq_init);
module_exit(acpi_cpufreq_exit);

--OgqxwSJOaUobr8KG--
