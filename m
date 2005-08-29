Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVH2UdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVH2UdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbVH2UdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:33:04 -0400
Received: from fmr21.intel.com ([143.183.121.13]:6822 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751270AbVH2UdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:33:02 -0400
Date: Mon, 29 Aug 2005 11:03:57 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] acpi-cpufreq: Remove P-state read after a P-state write in normal path
Message-ID: <20050829110357.A14724@unix-os.sc.intel.com>
References: <20050826171052.B27226@unix-os.sc.intel.com> <20050828180941.GB28994@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050828180941.GB28994@isilmar.linta.de>; from linux@dominikbrodowski.net on Sun, Aug 28, 2005 at 08:09:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 at 08:09:41PM +0200, Dominik Brodowski wrote:
> Hi,
> 
> On Fri, Aug 26, 2005 at 05:10:52PM -0700, Venkatesh Pallipadi wrote:
> >  	/*
> > -	 * Then we read the 'status_register' and compare the value with the
> > -	 * target state's 'status' to make sure the transition was successful.
> > -	 * Note that we'll poll for up to 1ms (100 cycles of 10us) before
> > -	 * giving up.
> > +	 * Assume the write went through when acpi_pstate_strict is not used.
> > +	 * As read status_register is an expensive operation and there 
> > +	 * are no specific error cases where an IO port write will fail.
> >  	 */
> 
> Well, the IO port write itself might not fail, but the transition itself --
> and we're reading the _status_ register here, not the control register where
> we've written to. And 8.4.4.1 of ACPI-sepc 3.0 does specifically mention
> that transitions _can_ fail, so I think we should handle this possibility.

Yes. ACPI spec says transitions can fail. But, it doesn't fail often in 
practise. And even if it fails, I think, we should handle it without this 
read os STATUS register. The speedstep-centrino driver, which does similar
thing as acpi-cpufreq, does not do this status check after control MSR write.
We can skip the read of STATUS in cpi-cpufreq in a similar way. No?

I feel the overhead of doing the status read here is too high. As it uses SMM,
the latency for read of STATUS is almost same as write into CONTROL. If we 
think retaining the STATUS read is better, we should atleast double the 
transition time reported in _PSS to compensate for this extra overhead.

And reading the STATUS in a loop should go away. I don't see that it being 
mentioned in ACPI spec. The 1mS loop seems totally redundant.

Thanks,
Venki
