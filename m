Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266087AbSKFT6N>; Wed, 6 Nov 2002 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266090AbSKFT6N>; Wed, 6 Nov 2002 14:58:13 -0500
Received: from packet.digeo.com ([12.110.80.53]:29127 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266087AbSKFT6M>;
	Wed, 6 Nov 2002 14:58:12 -0500
Message-ID: <3DC975DC.77231191@digeo.com>
Date: Wed, 06 Nov 2002 12:04:44 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, jejb@steeleye.com,
       Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 2.5)
References: <3DC9719B.AC139E50@digeo.com> <121150000.1036615519@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 20:04:44.0113 (UTC) FILETIME=[BFB99410:01C285CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> Yes, this caused for me, a completely reliable boot time panic with 2.5.46.
> >> The problem is that per_cpu areas aren't initiallised until cpu_up is called,
> >> so a cpu cannot now take an interrupt before cpu_up is called.
> >
> > Rusty's da man on this, but I think the fix is to not turn on
> > the interrupts (at the APIC level) until cpu_up() has called
> > __cpu_up().  Look at cpu_up():
> >
> >         ret = notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
> >         if (ret == NOTIFY_BAD) {
> >                 printk("%s: attempt to bring up CPU %u failed\n",
> >                                 __FUNCTION__, cpu);
> >                 ret = -EINVAL;
> >                 goto out_notify;
> >         }
> >
> >         /* Arch-specific enabling code. */
> >         ret = __cpu_up(cpu);
> >
> > The softirq storage is initialised inside the CPU_UP_PREPARE call.
> > So we're ready for interrupts on that CPU when your architecture's
> > __cpu_up() is called.  And no sooner than this.
> 
> All interrupts, or just softints?
> 

I don't know.  This sequencing really needs to be thought about
and written down, else we'll just have an ongoing fiasco trying
to graft stuff onto it.

In this case I'd say "all interrupts".  The secondary really
should be 100% dormant until all CPU_UP_PREPARE callouts have
been run and have returned NOTIFY_OK.

At least, that's how I'd have designed it.
