Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUIPIjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUIPIjK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 04:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUIPIjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 04:39:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19907 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267856AbUIPIhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 04:37:39 -0400
Date: Thu, 16 Sep 2004 13:41:38 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hari@in.ibm.com, Rusty Russell <rusty@rustcorp.com.au>, suparna@in.ibm.com,
       fastboot@osdl.org, ebiederm@xmission.com, litke@us.ibm.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [Fastboot] Re: [PATCH][4/6]Register snapshotting before kexec boot
Message-ID: <20040916081138.GB4594@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com> <20040915125145.GB15450@in.ibm.com> <20040915125322.GC15450@in.ibm.com> <20040915125422.GD15450@in.ibm.com> <20040915125525.GE15450@in.ibm.com> <20040915142722.46088ad5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915142722.46088ad5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:27:22PM -0700, Andrew Morton wrote:
> Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
> > +void __crash_dump_stop_cpus(void)
> > +{
> > +	int i, cpu = smp_processor_id();
> > +	int other_cpus = num_online_cpus()-1;
> > +
> > +	if (other_cpus > 0) {
> > +		atomic_set(&waiting_for_dump_ipi, other_cpus);
> > +
> > +		for (i = 0; i < NR_CPUS; i++)
> > +			crash_dump_expect_ipi[i] = (i != cpu && cpu_online(i));
> > +
> > +		set_nmi_callback(crash_dump_nmi_callback);
> > +		/* Ensure the new callback function is set before sending
> > +		 * out the IPI
> > +		 */
> > +		wmb();
> > +
> > +		crash_dump_send_ipi();
> > +		while (atomic_read(&waiting_for_dump_ipi) > 0)
> > +			cpu_relax();
> > +
> > +		unset_nmi_callback();
> > +	} else {
> > +		local_irq_disable();
> > +		disable_local_APIC();
> > +		local_irq_enable();
> > +	}
> > +}
> 
> Is dodgy wrt CPU hotplug, but there's not a lot we can do about that
> in this context, I expect.  Which is a shame, given that CPU hotplug
> is a likely time at which to be taking a crashdump ;)

If Hari disables preemption during this entire section of code,
he should be safe from CPU hotplug, AFAICS. The stop machine
threads will never get to run on that CPU.

Thanks
Dipankar
