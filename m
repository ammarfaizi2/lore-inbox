Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUC3AXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUC3AXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:23:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:38570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263307AbUC3AXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:23:44 -0500
Date: Mon, 29 Mar 2004 16:25:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-Id: <20040329162555.4227bc88.akpm@osdl.org>
In-Reply-To: <20040329162123.4c57734d.akpm@osdl.org>
References: <006701c415a4$01df0770$d100000a@sbs2003.local>
	<20040329162123.4c57734d.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> >
> > The bug is on "BUG_ON(!cpus_equal(cpumask, tmp));" in flush_tlb_others
> > This was from 2.6.1-rc1-mjb1, and seems to be a race on shutdown
> > (prints after "Power Down"), but I've no reason to believe it's specific
> > to the patchset I have - it's not an area I'm touching, I think.
> > 
> > I presume we've got a race between taking CPUs offline and the 
> > tlbflush code ... tlb_flush_mm reads the value from mm->cpu_vm_mask,
> > and then presumably some other cpu changes cpu_online_map before it
> > gets to calling flush_tlb_others ... does that sound about right?
> 
> Looks like it, yes.  I don't think there's a sane way of fixing that - we'd
> need the flush_tlb_others() caller to hold some lock which keeps the cpu
> add/remove code away.
> 
> I'd propose removing the assertion?

If the going-away CPU can still take IPIs we're OK, I think.  If it cannot,
we have a problem.  Can you do a s/BUG_ON/WARN_ON/ and run with that for a
while?  Check that the warnings come out and the machine doesn't go crump?

