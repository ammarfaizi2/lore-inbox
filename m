Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbVIIUqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbVIIUqI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbVIIUqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:46:08 -0400
Received: from fmr24.intel.com ([143.183.121.16]:27316 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030509AbVIIUqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:46:06 -0400
Date: Fri, 9 Sep 2005 13:45:03 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat mode
Message-ID: <20050909134503.A29351@unix-os.sc.intel.com>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net> <20050905231628.GA16476@muc.de> <20050906161215.B19592@unix-os.sc.intel.com> <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0509091003490.978@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Fri, Sep 09, 2005 at 10:07:28AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 10:07:28AM -0700, Zwane Mwaikambo wrote:
> On a slightly different topic, how come we're using physflat for hotplug 
> cpu?
> 
> -#ifndef CONFIG_CPU_HOTPLUG
>  		/* In the CPU hotplug case we cannot use broadcast mode
>  		   because that opens a race when a CPU is removed.
> -		   Stay at physflat mode in this case.
> -		   It is bad to do this unconditionally though. Once
> -		   we have ACPI platform support for CPU hotplug
> -		   we should detect hotplug capablity from ACPI tables and
> -		   only do this when really needed. -AK */
> +		   Stay at physflat mode in this case. - AK */
> +#ifdef CONFIG_HOTPLUG_CPU
>  		if (num_cpus <= 8)
>  			genapic = &apic_flat;

What you say was true before this patch, (Although now that you point out i 
realize the ifdef CONFIG_HOTPLUG_CPU is not required). 

Think Andi is fixing this in his next drop to -mm*

When physflat was introduced, it also  switched to use physflat mode for 
#cpus <=8 when hotplug is enabled, since it doesnt use shortcuts and 
so is also safer (although slower). 

http://marc.theaimsgroup.com/?l=linux-kernel&m=112317686712929&w=2

The link above made using genapic_flat safer by using the
flat_send_IPI_mask(), and hence i switched back to using
logical flat mode when #cpus <=8, since that a little more efficient than
the send_IPI_mask_sequence() used in physflat mode.

In general we need

flat_mode - #cpus <= 8 (Hotplug defined or not, so we use mask version 
                       for safety)

physflat or cluster_mode when #cpus >8.

If we choose physflat as default for #cpus <=8 (with hotplug) would make
IPI performance worse, since it would do one cpu at a time, and requires 2 
writes per cpu for each IPI v.s just 2 for a flat mode mask version of the API.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
