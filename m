Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVEXLsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVEXLsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVEXLsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 07:48:21 -0400
Received: from colin.muc.de ([193.149.48.1]:24077 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261996AbVEXLsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 07:48:13 -0400
Date: 24 May 2005 13:48:12 +0200
Date: Tue, 24 May 2005 13:48:12 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org, rusty@rustycorp.com.au, vatsa@in.ibm.com
Subject: Re: [discuss] Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050524114812.GA86233@muc.de>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de> <20050523095450.A8193@unix-os.sc.intel.com> <20050523171212.GF39821@muc.de> <20050523104046.B8692@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523104046.B8692@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 10:40:46AM -0700, Ashok Raj wrote:
> On Mon, May 23, 2005 at 07:12:12PM +0200, Andi Kleen wrote:
> > > The only other workable alternate would be to use the stop_machine() 
> > > like thing which we use to automically update cpu_online_map. This means we 
> > > execute a high priority thread on all cpus, bringing the system to knees before
> > 
> > That is not nice agreed.
> > 
> > > just adding a new cpu. On very large systems this will definitly be 
> > > visible.
> > 
> > I still dont quite get it why it is not enough to keep interrupts
> > off until the CPU enters idle. Currently we enable them shortly
> > in the middle of the initialization (whcih is already dangerous
> > because interrupts can see half initialized state like out of date TSC),
> > but I hope to get rid of that soon too. With the full startup
> > in CLI would you problems be gone?
> > 
> 
> I think so, if we can ensure none is delivered to the partially up cpu
> we probably are covered.

You mean not delivered to its APIC or not delivered as an visible
interrupt in the instruction stream?

The later can be ensured, the first not. I guess if the first is a problem
you could add a function to ack all pending interrupts after initial sti.

e.g. we can assume the CPU will deliver everything pending after two
instruction after the sti and when there are interrupts left in the APIC 
you can ack them. But why would they not be raised as real interruptions
at this point anyways?


> Iam not a 100% sure about above either, if the smp_call_function 
> is started with 3 cpus initially, and 1 just came up, the counts in 
> the smp_call data struct could be set to 3 as a result of the new cpu 
> received this broadcast as well, and we might quit earlier in the wait.

In the worst case a smp_call_function would be delayed for the whole
boot up time of a new CPU which should be quite bounded. The longest
delay in there is probably the bogomips calibrate, but I believe
Venkatesh recently sped that up greatly anyways so it should not be 
an issue anymore. If the delay is < 1s that is probably tolerable.

Or do I miss some shade of the problem you are worried about?

-Andi
