Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWA1AAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWA1AAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422713AbWA1AAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:00:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422715AbWA1AAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:00:53 -0500
Subject: Re: iommu_alloc failure and panic
From: Mark Haverkamp <markh@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060127234853.GA17018@krispykreme>
References: <1138381060.11796.22.camel@markh3.pdx.osdl.net>
	 <20060127234853.GA17018@krispykreme>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 16:00:47 -0800
Message-Id: <1138406447.11796.32.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 10:48 +1100, Anton Blanchard wrote:
> Hi,
> 
> > I have been testing large numbers of storage devices.  I have 16000 scsi
> > LUNs configured.  (4000 fiberchannel LUNS seen 4 times).  They are
> > configured as 4000 multipath devices using device mapper.  I have 100 of
> > those devices configured as a logical volume using LVM2.  Once I start
> > bonnie++ using one of those logical volumes I start seeing iommu_alloc
> > failures and then a panic.  I don't have this issue when accessing the
> > individual devices or the individual multipath devices.  Only when
> > conglomerated into a logical volume.
> > 
> > Here is the syslog output:
> > 
> > Jan 26 14:56:41 linux kernel: iommu_alloc failed, tbl c00000000263c480 vaddr c0000000d7967000 npages 10
> 
> This stuff should be OK since the lpfc driver should handle the iommu
> filling up. Im guessing since you have so many LUNs you can get a whole
> lot of outstanding IO, enough to fill up the TCE table.
> 
> > DAR: C000000600711710
> 
> > NIP [C00000000000F7D0] .validate_sp+0x30/0xc0
> > LR [C00000000000FA2C] .show_stack+0xec/0x1d0
> > Call Trace:
> > [C0000000076DBBC0] [C00000000000FA18] .show_stack+0xd8/0x1d0 (unreliable)
> > [C0000000076DBC60] [C000000000433838] .schedule+0xd78/0xfb0
> > [C0000000076DBDE0] [C000000000079FC0] .worker_thread+0x1b0/0x1c0
> 
> This is interesting, an oops in validate_sp which is a pretty boring
> function. We have seen this in the past when you overflow your kernel
> stack. The bottom of the kernel stack contains the threadinfo struct and
> in that we have the task_cpu() data.
> 
> When we overflow the stack and overwrite the threadinfo we end up with 
> a crazy number for task_cpu() and then oops when doing 
> hardirq_ctx[task_cpu(p)]. Can you turn on DEBUG_STACKOVERFLOW and
> DEBUG_STACK_USAGE and see if you get any stack overflow warnings? 

It looks like they are already on:

CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y

> The
> second option will also allow you to do sysrq t and dump the most stack
> each process has used at that point.

The machine is frozen after the panic. 


Mark.


> 
> Anton
-- 
Mark Haverkamp <markh@osdl.org>

