Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291041AbSCEWQP>; Tue, 5 Mar 2002 17:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291247AbSCEWQF>; Tue, 5 Mar 2002 17:16:05 -0500
Received: from mms1.broadcom.com ([63.70.210.58]:39441 "HELO mms1.broadcom.com")
	by vger.kernel.org with SMTP id <S291041AbSCEWPz>;
	Tue, 5 Mar 2002 17:15:55 -0500
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Message-ID: <3C854399.2BE48DF2@broadcom.com>
Date: Tue, 05 Mar 2002 14:15:53 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel@vger.kernel.org, linux-mips@oss.sgi.com
Subject: Re: init_idle reaped before final call
In-Reply-To: <3C8522EA.2A00E880@broadcom.com> <292270000.1015365429@flay>
X-WSS-ID: 109B9C0F2713232-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> > I'm working with a (approximately) 2.4.17 kernel from the mips-linux
> > tree (oss.sgi.com).
> >
> > I'd like to propose removing the "__init" designation from init_idle in
> > kernel/sched.c, since this is called from rest_init via cpu_idle.
> > Notice that rest_init isn't in an init section, and explicitly mentions
> > that it's avoiding a race with free_initmem.  In my kernel (an SMP
> > kernel running on a system with only 1 available CPU), cpu_idle isn't
> > getting called until after free_initmem().
> >
> > My CPU is MIPS, but it looks like x86 could experience the same problem.
> 
> I fixed something in this area for x86, looks like the same code path
> for MIPS unless I'm misreading.
> 
> smp_init spins waiting on wait_init_idle until every cpu has done
> init_idle. rest_init() isn't called until smp_init returns, so I'm not sure
> how you could hit this (possibly there's a minute window after init_idle
> clears the bit, but before it returns?).

This synchronization doesn't help: cpu0 (even in the multi-cpu case)
calls init_idle twice -- once from smp_init (through smp_boot_cpus), and
then again from cpu_idle.  In my failing case (CONFIG_SMP=y, but only 1
cpu in the system) the second call, the one from cpu_idle, doesn't
happen until long after the init kernel thread has been running and has
freed the initmem.

Maybe a better fix is to avoid this double calling of init_idle for the
"master" CPU?  From my reading the code, x86 seems to behave the same.

Kip

