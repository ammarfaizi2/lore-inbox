Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbSKFTkT>; Wed, 6 Nov 2002 14:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266023AbSKFTkT>; Wed, 6 Nov 2002 14:40:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:14534 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266020AbSKFTkQ>;
	Wed, 6 Nov 2002 14:40:16 -0500
Message-ID: <3DC9719B.AC139E50@digeo.com>
Date: Wed, 06 Nov 2002 11:46:35 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, jejb@steeleye.com,
       Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 2.5)
References: Message from "Martin J. Bligh" <Martin.Bligh@us.ibm.com> 
	   of "Wed, 06 Nov 2002 12:11:09 PST." <116630000.1036613469@flay> <200211061932.gA6JWKa03782@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 19:46:35.0767 (UTC) FILETIME=[37052870:01C285CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.E.J. Bottomley" wrote:
> 
> Martin.Bligh@us.ibm.com said:
> > Conversations on IRC revealed that jejb has hit the same thing on
> > voyager ... as I understood him, he felt the cause was the CPU was
> > taking an interrupt before cpu_up was called, and the interrupt was
> > going back through a non existent tasklet structure (tasklets now
> > have per_cpu areas which are allocated as the cpu comes up) I'll let
> > him discuss what he did to fix that, but the ensuing discussion made
> > me think that taking this out to a wider audience for an appropriate
> > long-term solution would be prudent.
> 
> Yes, this caused for me, a completely reliable boot time panic with 2.5.46.
> The problem is that per_cpu areas aren't initiallised until cpu_up is called,
> so a cpu cannot now take an interrupt before cpu_up is called.

Rusty's da man on this, but I think the fix is to not turn on
the interrupts (at the APIC level) until cpu_up() has called
__cpu_up().  Look at cpu_up():

        ret = notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
        if (ret == NOTIFY_BAD) {
                printk("%s: attempt to bring up CPU %u failed\n",
                                __FUNCTION__, cpu);
                ret = -EINVAL;
                goto out_notify;
        }

        /* Arch-specific enabling code. */
        ret = __cpu_up(cpu);

The softirq storage is initialised inside the CPU_UP_PREPARE call.
So we're ready for interrupts on that CPU when your architecture's
__cpu_up() is called.  And no sooner than this.
