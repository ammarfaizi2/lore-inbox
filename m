Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbVIBOaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbVIBOaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVIBOaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:30:21 -0400
Received: from mailfe09.tele2.se ([212.247.155.1]:28875 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1030419AbVIBOaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:30:21 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Fri, 2 Sep 2005 16:30:12 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.13-mm1
Message-ID: <20050902143012.GA18532@localhost.localdomain>
References: <20050901035542.1c621af6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901035542.1c621af6.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 03:55:42AM -0700 Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> 

i386-boottime-for_each_cpu-broken.patch
i386-boottime-for_each_cpu-broken-fix.patch

The SMP version of __alloc_percpu checks the cpu_possible_map
before allocating memory for a certain cpu. With the above patches
the BSP cpuid is never set in cpu_possible_map which breaks CONFIG_SMP
on uniprocessor machines (as soon as someone tries to dereference
something allocated via __alloc_percpu, which in fact is never allocated
since the cpu is not set in cpu_possible_map).

The below fixes this, I'm not entirely sure about the voyager
part, should the cpu_possible_map really be CPU_MASK_ALL to begin
with there, Zwane?

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: mm/arch/i386/kernel/smpboot.c
===================================================================
--- mm.orig/arch/i386/kernel/smpboot.c	2005-09-02 15:28:20.000000000 +0200
+++ mm/arch/i386/kernel/smpboot.c	2005-09-02 16:16:46.000000000 +0200
@@ -1265,6 +1265,7 @@
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
 	cpu_set(smp_processor_id(), cpu_present_map);
+	cpu_set(smp_processor_id(), cpu_possible_map);
 	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 }
 
Index: mm/arch/i386/mach-voyager/voyager_smp.c
===================================================================
--- mm.orig/arch/i386/mach-voyager/voyager_smp.c	2005-09-02 15:28:20.000000000 +0200
+++ mm/arch/i386/mach-voyager/voyager_smp.c	2005-09-02 16:17:29.000000000 +0200
@@ -1910,6 +1910,7 @@
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_callout_map);
+	cpu_set(smp_processor_id(), cpu_possible_map);
 }
 
 int __devinit
