Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWAFJBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWAFJBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWAFJBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:01:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:7585 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932185AbWAFJBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:01:38 -0500
Date: Fri, 6 Jan 2006 09:59:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060106085920.GI3339@elf.ucw.cz>
References: <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060105230849.GN2095@elf.ucw.cz> <20060105234629.GA7298@isilmar.linta.de> <20060105235838.GC3339@elf.ucw.cz> <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net> <20060106001252.GE3339@elf.ucw.cz> <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 17:37:30, Patrick Mochel wrote:
> 
> 
> On Fri, 6 Jan 2006, Pavel Machek wrote:
> 
> > On Ät 05-01-06 16:04:07, Patrick Mochel wrote:
> 
> > > A better point, and one that would actually be useful, would be to remove
> > > the file altogether. Let Dominik export a power file, with complete
> > > control over the values, for each pcmcia device. Then you never have to
> > > worry about breaking PCMCIA again.
> >
> > Fine with me.
> 
> ACK, you beat me to it.
> 
> And, appended is a patch to export PM controls for PCI devices. The file
> "pm_possible_states" exports the states a device supports, and "pm_state"
> exports the current state (and provides the interface for entering a
> state).
> 
> Eventually, some drivers will want to fix up those values so that it can
> mask of states that it doesn't support, as well as offer possible device-
> specific states.
> 
> What's interesting is that with this patch, I can see that two more
> devices on my system support D1 and D2 -- the cardbus controllers, which
> are actually bridges whose PM capabilities aren't exported via
lspci.

> +static ssize_t pm_possible_states_show(struct device * d,
> +				       struct device_attribute * a,
> +				       char * buffer)
> +{
> +	struct pci_dev * dev = to_pci_dev(d);
> +	char * s = buffer;
> +
> +	s += sprintf(s, "d0");
> +	if (dev->poss_states[PCI_D1])
> +		s += sprintf(s, " d1");
> +	if (dev->poss_states[PCI_D2])
> +		s += sprintf(s, " d2");
> +	if (dev->poss_states[PCI_D3hot])
> +		s += sprintf(s, " d3");

Could we use same states as rest of code, i.e. "D2" instead of "d2"
and "D3hot" instead of "d3"?

> +static ssize_t pm_state_show(struct device * d, struct device_attribute * a,
> +			     char * buffer)

Please no space between "struct foo *" and "d".

> +	if (state == dev->current_state)
> +		return 0;
> +
> +	if (dev->poss_states[state])
> +		ret = pci_set_power_state(dev, state);

So you just set the PCI power, without any coordination with driver?
How can this work?

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -106,6 +106,7 @@ struct pci_dev {
>  					   this if your device has broken DMA
>  					   or supports 64-bit transfers.  */
> 
> +	u32		poss_states[4];

It is boolean... Can we have int instead of u32?

								Pavel

-- 
Thanks, Sharp!
