Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266053AbSKFTn4>; Wed, 6 Nov 2002 14:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266055AbSKFTn4>; Wed, 6 Nov 2002 14:43:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49803 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266053AbSKFTny>;
	Wed, 6 Nov 2002 14:43:54 -0500
Date: Wed, 06 Nov 2002 12:45:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>,
       "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, jejb@steeleye.com,
       Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 2.5)
Message-ID: <121150000.1036615519@flay>
In-Reply-To: <3DC9719B.AC139E50@digeo.com>
References: Message from "Martin J. Bligh" <Martin.Bligh@us.ibm.com>    of "Wed, 06 Nov 2002 12:11:09 PST." <116630000.1036613469@flay> <200211061932.gA6JWKa03782@localhost.localdomain> <3DC9719B.AC139E50@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yes, this caused for me, a completely reliable boot time panic with 2.5.46.
>> The problem is that per_cpu areas aren't initiallised until cpu_up is called,
>> so a cpu cannot now take an interrupt before cpu_up is called.
> 
> Rusty's da man on this, but I think the fix is to not turn on
> the interrupts (at the APIC level) until cpu_up() has called
> __cpu_up().  Look at cpu_up():
> 
>         ret = notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
>         if (ret == NOTIFY_BAD) {
>                 printk("%s: attempt to bring up CPU %u failed\n",
>                                 __FUNCTION__, cpu);
>                 ret = -EINVAL;
>                 goto out_notify;
>         }
> 
>         /* Arch-specific enabling code. */
>         ret = __cpu_up(cpu);
> 
> The softirq storage is initialised inside the CPU_UP_PREPARE call.
> So we're ready for interrupts on that CPU when your architecture's
> __cpu_up() is called.  And no sooner than this.

All interrupts, or just softints?

M.


