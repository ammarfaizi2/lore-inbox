Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVEXIyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVEXIyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVEXIyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:54:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1533 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261890AbVEXIxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:53:25 -0400
Date: Tue, 24 May 2005 14:23:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <ak@muc.de>, zwane@arm.linux.org.uk, discuss@x86-64.org,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       rusty@rustycorp.com.au
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050524085330.GB8279@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de> <20050523104046.B8692@unix-os.sc.intel.com> <20050524054617.GA5510@in.ibm.com> <20050523230106.A13839@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523230106.A13839@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 11:01:06PM -0700, Ashok Raj wrote:
> We do this today in x86_64 case when we setup this upcomming cpu in 
> cpu_online_map. But the issue is when we use ipi broadcast, its an ugly

I don't know of x86-64, but atleast on x86 ipi broadcast will send 
to _all_ CPUs present, right? I mean the h/w does not know of the offline
CPUs and will send to them also. This could lead to a problem for the offline 
CPUs when they come online and can take a spurious IPI (unless
there is support in h/w to clear pending IPI before doing STI).

> case when we dont know if the new cpu is receiving this as well, and 
> we dont have real control there.
> 
> i converted to use send_IPI_mask(cpu_online_map, CALL_FUNCTION_VECTOR)
> instead of the send_IPI_allbutself(CALL_FUNCTION_VECTOR) in 
> __smp_call_function(), apart from taking the call_lock before setting the
> bit in online_map.
> 
> Since Andi is concerned about tlb flush intr performance in the 8cpu and less
> case, iam planning temporarily use a startup cmd or choose this option 
> automatically if CONFIG_HOTPLUG_CPU is set for the time being, until we can 
> find a clean solution that satisfies everyone.


I think this should be the recommended approach (using send_IPI_mask if 
CONFIG_HOTPLUG_CPU is defined) unless h/w is intelligent enough 
that it avoids sending IPIs to offline CPUs or it supports clearing 
pending interrupts. 

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
