Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUCaBYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUCaBYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:24:43 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:29341 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261159AbUCaBYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:24:42 -0500
Date: Tue, 30 Mar 2004 17:24:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>
cc: rddunlap@osdl.org, hari@in.ibm.com, linux-kernel@vger.kernel.org,
       apw@shadowen.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <273320000.1080696246@flay>
In-Reply-To: <20040330171104.752104a9.akpm@osdl.org>
References: <006701c415a4$01df0770$d100000a@sbs2003.local><20040329162123.4c57734d.akpm@osdl.org><20040329162555.4227bc88.akpm@osdl.org><20040330132832.GA5552@in.ibm.com><20040330151729.1bd0c5d0.rddunlap@osdl.org><187940000.1080692555@flay><20040330163928.7cafae3d.akpm@osdl.org><270000000.1080694659@flay> <20040330171104.752104a9.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, March 30, 2004 17:11:04 -0800 Andrew Morton <akpm@osdl.org> wrote:

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>> I made a similar patch, but I don't see how we can really fix it without
>> providing locking on cpu_online_map.
> 
> Are we missing something here?
> 
> Why does, for example, smp_send_reschedule() not have the same problem? 
> Because we've gone around and correctly removed all references to the CPU
> from the scheduler data structures before offlining it.
> 
> But we're not doing that in the mm code, right?  Should we not be taking
> mmlist_lock and running around knocking this CPU out of everyone's
> cpu_vm_mask before offlining it?

I think we're assuming that we don't have to because the problem is fixed 
by the "cpus_and(tmp, cpumask, cpu_online_map)" in flush_tlb_others so we 
don't have to. Except it's racy, and doesn't work.

It would seem to me that your suggestion would fix it. But isn't locking
cpu_online_map both simpler and (most importantly) more generic? I can't 
imagine that we don't use this elsewhere ... suppose for instance we took 
a timer interrupt, causing a scheduler rebalance, and moved a process to 
an offline CPU at that point? Isn't any user of smp_call_function also racy?

Not locking it just seems fundamentally dangerous to me ... maybe I'm 
wrong though.

M.

