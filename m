Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbVHSDVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVHSDVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 23:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVHSDVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 23:21:25 -0400
Received: from fsmlabs.com ([168.103.115.128]:24481 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751033AbVHSDVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 23:21:24 -0400
Date: Thu, 18 Aug 2005 21:27:40 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 !NUMA node_to_cpumask broken in early boot
In-Reply-To: <20050819030615.GH22993@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0508182116510.28588@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0508181919230.28588@montezuma.fsmlabs.com>
 <20050819021216.GF22993@wotan.suse.de> <Pine.LNX.4.61.0508182043310.28588@montezuma.fsmlabs.com>
 <20050819030615.GH22993@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005, Andi Kleen wrote:

> > Thanks for the feedback, ugly indeed, i was really trying to avoid adding 
> > a new API function or extra cpu_* variables. Ok, here is an 
> > early_node_to_cpumask instead.
> 
> Thinking about it again it's most likely broken with CPU hotplug anyways
> whatever you're doing. So how does your code handle adding new 
> CPUs?  If it does can the normal CPU bootup be handled in the 
> same way. Then this wouldn't be needed at all.

The code is populating IDTs before APs are online, so for a given set of 
processors i would want to install new IDT entries like so;

node_set_intr_gate()
{
	cpumask_t mask = node_to_cpumask(node);
	for_each_cpu_mask(cpu, mask)
		set_intr_gate(per_cpu_ptr(cpu_idt_table, cpu)....
	....
}

Which before resulted in only setting the IDT entry for the BSP.

During boot, i prepare all processor IDTs so they are always 
ready for processors coming online and should take care of hotplug cpu 
too. The only problem with normal bootup is that the node_to_cpumask is
unreliable.

	Zwane

