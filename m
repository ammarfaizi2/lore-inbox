Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbUKEXSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbUKEXSM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUKEXRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:17:35 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:15505 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261261AbUKEXOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:14:25 -0500
Subject: Re: [RFC/PATCH 3/4] introduce cpu_add and cpu_remove
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Ashok Raj <ashok.raj@intel.com>
Cc: Nathan Lynch <nathanl@austin.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, rusty@rustcorp.com.au,
       Patrick Mochel <mochel@digitalimplant.org>,
       Anton Blanchard <anton@samba.org>
In-Reply-To: <20041104175755.B9271@unix-os.sc.intel.com>
References: <20041024094551.28808.28284.87316@biclops>
	 <20041024094613.28808.17748.71291@biclops>
	 <20041104175755.B9271@unix-os.sc.intel.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1099696458.16558.14.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Nov 2004 15:14:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 17:57, Ashok Raj wrote:
> On Sun, Oct 24, 2004 at 05:42:31AM -0400, Nathan Lynch wrote:
> > 
> > These functions safely update cpu_present_map (i.e. with the
> > cpucontrol semaphore held) and register or unregister the cpu device
> > as needed.  These are needed by systems which can add or remove cpus
> > from the system after boot (e.g. ppc64 and ia64), and are intended to
> > be called from the platform-specific code such as the ACPI or Open
> > Firmware layers.
> > 
> > Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
> > 
> > 
> > ---
> > 
> > 
> > +
> > +/*
> > + * Add a cpu to the system.  Return the number of the cpu added,
> > + * or NR_CPUS if no more slots available.
> > + */
> > +unsigned int cpu_add(void)
> > +{
> > +	unsigned int cpu = NR_CPUS;
> > +
> > +	lock_cpu_hotplug();
> > +
> > +	if (num_present_cpus() == num_possible_cpus())
> > +goto out;
> > +
> > +	for_each_cpu(cpu)
> > +		if (!cpu_present(cpu))
> > +			break;
> 
>      could we simplify this by
> 
>    cpus_compliment(cpu_compliment_map, cpu_present_map);
>    cpu = first_cpu(cpu_compliment_map);

Well, since for_each_cpu() is defined like this:
#define for_each_cpu(cpu)         for_each_cpu_mask((cpu), cpu_possible_map)

We could do:
cpus_andnot(new_cpu_map, cpu_possible_map, cpu_present_map);
cpu = first_cpu(new_cpu_map);

Or maybe even:
unsigned int cpu_add(void)
{
	unsigned int cpu = NR_CPUS;

	lock_cpu_hotplug();

	if (num_present_cpus() == num_possible_cpus())
		goto out;

	cpus_andnot(new_cpu_map, cpu_possible_map, cpu_present_map);
	for_each_cpu_mask(new_cpu_map)
		if (!register_cpu(cpu)) {
			cpu_set(cpu, cpu_present_map);
			goto out;
		}

	cpu = NR_CPUS;
out:
	unlock_cpu_hotplug();
	return cpu;
}

since we want to try all possible but !present CPUs until we exhaust
them all or find one to bring online.

Simply complimenting the cpu_present_map could easily return CPUs which
aren't 'present' and aren't even 'possible' since cpu_possible_map
doesn't necessarily equal 0xFFFFFFFF (or however many FF's for your
particular platform! ;)

And FWIW, I like where you're going with this, Nathan.  I wrote a lot of
the original system topology code for sysfs, most of which is thankfully
gone now! ;)  I had hoped to clean up some of the ickier stuff, but
haven't gotten around to it.

-Matt

