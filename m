Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWCMVBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWCMVBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWCMVBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:01:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31892 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932456AbWCMVBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:01:18 -0500
Message-ID: <4415DCDE.1080507@nc.rr.com>
Date: Mon, 13 Mar 2006 15:58:06 -0500
From: William Cohen <wcohen@nc.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       oprofile-list <oprofile-list@lists.sourceforge.net>
Subject: Re: [Perfctr-devel] 2.6.16-rc5 perfmon2 new code base + libpfm with
 Montecito support
References: <20060308155311.GD13168@frankl.hpl.hp.com> <4415BC45.1010601@nc.rr.com> <20060313185500.GB32683@frankl.hpl.hp.com> <4415C4E9.5070702@nc.rr.com> <20060313202554.GD32683@frankl.hpl.hp.com>
In-Reply-To: <20060313202554.GD32683@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Will,
> 
> On Mon, Mar 13, 2006 at 02:15:53PM -0500, William Cohen wrote:
> 
>>Yes, I have a similar patch for i386 in the kernel. I don't yet have 
>>modifications for opcontrol or ophelp.
> 
> 
> Your patch is very close to mine. I'll merge tthe two and will include
> it in my next version.
> 
> My understand of opcontrol is that is passes the information from ophelp
> to the kernel via /dev/oprofile. I don't know how it passes it to the oprofiled
> daemon.
> 
> The daemon should not be difficult to change. I hacked something quickly
> and got it up on pentium M. The only remaining problem is ophelp, I think.

Is new identifier cpu_type being created or is i386/pentium_m being used 
also for perfmon2? It could be inferred that perfmon2 is being used if 
the procesor is identified, but there are no number directories for the 
counters (/dev/oprofile/[0-9]+).

I looked over the code this afternoon to refresh my memory how it actual 
work (as opposed to how I thought it works).

ophelp uses oprofile/libop/op_cpu_type.c:op_get_cpu_type to read 
/dev/oprofile/cpu_type. Once ophelp obtains the cpu type the appropriate 
directory from /usr/share/oprofile for the events. This information is 
passed to oprofiled; you can see it with "opcontrol --start --verbose".

oprofile/daemon/opd_perfmon.c and opd_perfmon.h are the place that the 
performance monitoring hardware is set for perfmon. 
opd_perfmon.c:write_pmu() is currently hard coded for ia64. As you have 
seen, it doesn't use the libpfm to set up the performance monitoring 
hardware.

Looking over the code in the linux/arch/i386/oprofile the code for 
typing the processor is tied to the initialization of the performance 
monitoring hardware. Probably want to factor out cpu idenification code 
from oprofile native handling of the performance monitoring code. So the 
pseudo code is something like in 
linux/arch/i386/oprofile/init.c:oprofile_arch_init():

char *processor_id = identify_processer();
ret = op_perfmon_support(ops, processor_id);
if (ret < 0)
	ret = op_nmi_init(ops, processor_id);
if (ret < 0)
	ret = op_nmi_timer(ops, processor_id);
return ret;

-Will

