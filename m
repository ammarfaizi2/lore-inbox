Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWCMVZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWCMVZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWCMVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:25:36 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:22942 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1750705AbWCMVZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:25:35 -0500
Date: Mon, 13 Mar 2006 13:21:21 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: William Cohen <wcohen@nc.rr.com>
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       oprofile-list <oprofile-list@lists.sourceforge.net>
Subject: Re: [Perfctr-devel] 2.6.16-rc5 perfmon2 new code base + libpfm with Montecito support
Message-ID: <20060313212121.GH32683@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060308155311.GD13168@frankl.hpl.hp.com> <4415BC45.1010601@nc.rr.com> <20060313185500.GB32683@frankl.hpl.hp.com> <4415C4E9.5070702@nc.rr.com> <20060313202554.GD32683@frankl.hpl.hp.com> <4415DCDE.1080507@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4415DCDE.1080507@nc.rr.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will,

On Mon, Mar 13, 2006 at 03:58:06PM -0500, William Cohen wrote:
> 
> Is new identifier cpu_type being created or is i386/pentium_m being used 
> also for perfmon2? It could be inferred that perfmon2 is being used if 
> the procesor is identified, but there are no number directories for the 
> counters (/dev/oprofile/[0-9]+).
> 
Existing OProfile codes treats pentium M as i386/piii as it should more or less.

> I looked over the code this afternoon to refresh my memory how it actual 
> work (as opposed to how I thought it works).
> 
> ophelp uses oprofile/libop/op_cpu_type.c:op_get_cpu_type to read 
> /dev/oprofile/cpu_type. Once ophelp obtains the cpu type the appropriate 
> directory from /usr/share/oprofile for the events. This information is 
> passed to oprofiled; you can see it with "opcontrol --start --verbose".
> 
In the quick hack I did over the week-end, I followed what John had done
for IA-64. In other words, I also have a get_cpu() routine for i386 and
I basically did a cut&paste of what was in nmi_int.c. As such,
/dev/oprofile/cpu_type is preserved to avoid confusing ophelp.

> oprofile/daemon/opd_perfmon.c and opd_perfmon.h are the place that the 
> performance monitoring hardware is set for perfmon. 
> opd_perfmon.c:write_pmu() is currently hard coded for ia64. As you have 
> seen, it doesn't use the libpfm to set up the performance monitoring 
> hardware.

Libpfm is really a helper library and is not required to use the kernel
interface. However, there is a bit of an anomaly in libpfm at the moment.
The library also includes the kernel header files and perfmon2 syscall stubs.
Both would eventually be found in libc.  As such, for the time being, some
applications may choose to link against libpfm, just for the stubs. The current
oprofiled does not do this and has every perfmon.h definitions it needs hardcoded
(syscalls stubs are also recreated).

> 
> Looking over the code in the linux/arch/i386/oprofile the code for 
> typing the processor is tied to the initialization of the performance 
> monitoring hardware. Probably want to factor out cpu idenification code 
> from oprofile native handling of the performance monitoring code. So the 
> pseudo code is something like in 
> linux/arch/i386/oprofile/init.c:oprofile_arch_init():
> 
> char *processor_id = identify_processer();
> ret = op_perfmon_support(ops, processor_id);
> if (ret < 0)
> 	ret = op_nmi_init(ops, processor_id);
> if (ret < 0)
> 	ret = op_nmi_timer(ops, processor_id);
> return ret;
> 
Yes that could be a possibility. That implies that there may be
situations where perfmon does not support a processor that is
somehow supported by OProfile. I suspect this could be the case
for very old CPUs.

-- 
-Stephane
