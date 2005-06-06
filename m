Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVFFXrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVFFXrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVFFXpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:45:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41856 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261738AbVFFXoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:44:23 -0400
Date: Mon, 6 Jun 2005 15:43:26 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       zwane@arm.linux.org.uk, vatsa@in.ibm.com, discuss@x86-64.org,
       rusty@rustycorp.com.au
Subject: Re: [patch 2/5] try2: x86_64: CPU hotplug support.
Message-ID: <20050606154325.A18480@unix-os.sc.intel.com>
References: <20050606191433.104273000@araj-em64t> <20050606192113.044405000@araj-em64t> <20050606151156.7b26167f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050606151156.7b26167f.akpm@osdl.org>; from akpm@osdl.org on Mon, Jun 06, 2005 at 03:11:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 03:11:56PM -0700, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> > Experimental CPU hotplug patch for x86_64
> 
> What does "experimental" mean?

Well, stictly since these sections are still under CONFIG_EXPERIMENTAL
in arch/x86_64/Kconfig. Evolving... ? 

> 
> > +
> > +	if (!keventd_up() || current_is_keventd())
> > +		work.func(work.data);
> > +	else {
> > +		schedule_work(&work);
> > +		wait_for_completion(&c_idle.done);
> > +	}
> 
> This shouldn't be diddling with workqueue internals.  Why is this code
> here?  If the workqueue API is inadequate then we should prefer to extend
> it rather than working around any shortcoming.

This has been around for ages.. even in ia64 code. For forking idle threads
we want to do them in clean state so we dont acquire state from threads
from where the cpu_up is being invoked. Hence we want them to start from
keventd() threads. But when system boot is happening, there is no keventd()
yet, hence we need to create them right away.

the other problem we ran into was ACPI code that handles physical cpu hotplug
also queues to keventd(), this becomes permanently blocking when called from
code already running in kevend(). 

> > +		Dprintk ("do_boot_cpu %d Already started\n", cpu);
> 
> Please try to adopt a consistent coding style.

I was actually trying to be consistent :-), rest of the debug code 
was under Dprintk() hence didnt want to use a new style. Not sure
what you need here exactly. Do you want to convert the rest of the code to 
not use Dprintk()? or just leave this with a printk? I dont have a 
particular preference here... i would rather leave it with Dprintk() as the
rest of the debug code.
> 
> Using printk("%s", __FUNCTION__); is preferred, as it will still work if
> someone later refactors this code into a new function.  (It can increase
> code size.  Or decrease it if the string gets shared.  But that's moot if
> the code is inside a normally-disabled macro like Dprintk.  Whatever that
> is.)
> 
> > +static void
> > +remove_siblinginfo(int cpu)
> 
> Unneeded newline here.

I can remove.. when iam inside the file, iam used to search for fn;s from 
start of line.. no biggie.. can revert.

Cheers,
ashok
