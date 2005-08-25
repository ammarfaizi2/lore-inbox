Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVHYWMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVHYWMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVHYWMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:12:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8699 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964935AbVHYWMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:12:42 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050825215451.GA7479@elte.hu>
References: <20050825062651.GA26781@elte.hu>
	 <1125006373.10901.11.camel@dhcp153.mvista.com>
	 <20050825215451.GA7479@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 25 Aug 2005 15:11:25 -0700
Message-Id: <1125007885.14592.2.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 23:54 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > @@ -257,6 +257,7 @@ void check_preempt_wakeup(struct task_st
> >  	 * hangs and race conditions.
> >  	 */
> >  	if (!preempt_count() &&
> > +		!__raw_irqs_disabled() &&
> >  		p->prio < current->prio &&
> >  		rt_task(p) &&
> >  		(current->rcu_read_lock_nesting != 0 ||
> 
> did you get a false positive? If yes, in what code/driver?


Yes, one was in trigger_softirqs() , the other in init_sd . Both traces
below.

BUG: swapper/1, possible wake_up race on softirq-scsi/3/31

Call Trace:<ffffffff80121ade>{wake_up_process+17} <ffffffff8012ddec>{trigger_softirqs+76}
       <ffffffff80379fed>{__scsi_done+101} <ffffffff803e55b4>{ata_scsi_rbuf_fill+114}
       <ffffffff80379fff>{scsi_done+0} <ffffffff803e5e0e>{ata_scsi_simulate+320}
       <ffffffff80379fff>{scsi_done+0} <ffffffff803e5f08>{ata_scsi_queuecmd+228}
       <ffffffff8037a1ff>{scsi_dispatch_cmd+488} <ffffffff8037f7d3>{scsi_request_fn+1046}
       <ffffffff8031c9b7>{blk_insert_request+156} <ffffffff8037e23f>{scsi_insert_special_req+51}
       <ffffffff8037e513>{scsi_wait_req+339} <ffffffff8037fae7>{__scsi_mode_sense+228}
       <ffffffff803e8f63>{sd_revalidate_disk+3037} <ffffffff80143953>{add_preempt_count_ti+35}
       <ffffffff80143442>{atomic_dec_and_spin_lock+52} <ffffffff801a9fc2>{rescan_partitions+133}
       <ffffffff8017729b>{do_open+672} <ffffffff80176fc2>{blkdev_get+161}

BUG: swapper/1, possible wake_up race on softirq-scsi/1/15

Call Trace:<ffffffff80121ade>{wake_up_p   <ffffffff8031581d>{driver_register+91} <ffffffff80834e5b>{init_sd+31}
       <ffffffff8010b24f>{init+503} <ffffffff8010e93e>{child_rip+8}
       <ffffffff8010b058>{init+0} <ffffffff8010e936>{child_rip+0}


