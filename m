Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUIOVb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUIOVb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUIOV3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:29:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:681 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267537AbUIOVXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:23:44 -0400
Date: Wed, 15 Sep 2004 14:27:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: hari@in.ibm.com, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, suparna@in.ibm.com,
       mbligh@aracnet.com, ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][4/6]Register snapshotting before kexec boot
Message-Id: <20040915142722.46088ad5.akpm@osdl.org>
In-Reply-To: <20040915125525.GE15450@in.ibm.com>
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
	<20040915125422.GD15450@in.ibm.com>
	<20040915125525.GE15450@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
>
> +void __crash_dump_stop_cpus(void)
> +{
> +	int i, cpu = smp_processor_id();
> +	int other_cpus = num_online_cpus()-1;
> +
> +	if (other_cpus > 0) {
> +		atomic_set(&waiting_for_dump_ipi, other_cpus);
> +
> +		for (i = 0; i < NR_CPUS; i++)
> +			crash_dump_expect_ipi[i] = (i != cpu && cpu_online(i));
> +
> +		set_nmi_callback(crash_dump_nmi_callback);
> +		/* Ensure the new callback function is set before sending
> +		 * out the IPI
> +		 */
> +		wmb();
> +
> +		crash_dump_send_ipi();
> +		while (atomic_read(&waiting_for_dump_ipi) > 0)
> +			cpu_relax();
> +
> +		unset_nmi_callback();
> +	} else {
> +		local_irq_disable();
> +		disable_local_APIC();
> +		local_irq_enable();
> +	}
> +}

Is dodgy wrt CPU hotplug, but there's not a lot we can do about that
in this context, I expect.  Which is a shame, given that CPU hotplug
is a likely time at which to be taking a crashdump ;)

Rusty, you may like to review these patches...
