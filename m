Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUCaAXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbUCaAXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:23:19 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:48886 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262382AbUCaAXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:23:17 -0500
Date: Tue, 30 Mar 2004 16:22:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>, hari@in.ibm.com
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-ID: <187940000.1080692555@flay>
In-Reply-To: <20040330151729.1bd0c5d0.rddunlap@osdl.org>
References: <006701c415a4$01df0770$d100000a@sbs2003.local><20040329162123.4c57734d.akpm@osdl.org><20040329162555.4227bc88.akpm@osdl.org><20040330132832.GA5552@in.ibm.com> <20040330151729.1bd0c5d0.rddunlap@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>| We faced this problem starting 2.6.3 while working on kexec. 
>| 
>| The problem is because we now initialize cpu_vm_mask for init_mm with 
>| CPU_MASK_ALL (from 2.6.3 onwards) which makes all bits in cpumask 1 (on SMP). 
>| Hence BUG_ON(!cpus_equal(cpumask,tmp) fails. The change to set
>| cpu_vm_mask to CPU_MASK_ALL was done to remove tlb flush optimizations 
>| for ppc64. 
>| 
>| I had posted a patch for this in the earlier thread. Reposting the same
>| here. This patch removes the assertion and uses "tmp" instead of cpumask. 
>| Otherwise, we will end up sending IPIs to offline CPUs as well.
>| 
>| Comments please.
> 
> I'll just say that kexec fails without this patch and works with
> it applied, so I'd like to see it merged.  If this patch isn't
> acceptable, let's find out why and try to make one that is.
> 
> Thanks for the patch, Hari.

>From discussions with Andy, it seems this still has the same race as before
just smaller. I don't see how we can fix this properly without having some
locking on cpu_online_map .... probably RCU as it's massively read-biased
and we don't want to pay a spinlock cost to read it.

M.

