Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUC3ATQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUC3ATP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:19:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:23975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263309AbUC3ATM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:19:12 -0500
Date: Mon, 29 Mar 2004 16:21:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-Id: <20040329162123.4c57734d.akpm@osdl.org>
In-Reply-To: <006701c415a4$01df0770$d100000a@sbs2003.local>
References: <006701c415a4$01df0770$d100000a@sbs2003.local>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> The bug is on "BUG_ON(!cpus_equal(cpumask, tmp));" in flush_tlb_others
> This was from 2.6.1-rc1-mjb1, and seems to be a race on shutdown
> (prints after "Power Down"), but I've no reason to believe it's specific
> to the patchset I have - it's not an area I'm touching, I think.
> 
> I presume we've got a race between taking CPUs offline and the 
> tlbflush code ... tlb_flush_mm reads the value from mm->cpu_vm_mask,
> and then presumably some other cpu changes cpu_online_map before it
> gets to calling flush_tlb_others ... does that sound about right?

Looks like it, yes.  I don't think there's a sane way of fixing that - we'd
need the flush_tlb_others() caller to hold some lock which keeps the cpu
add/remove code away.

I'd propose removing the assertion?
