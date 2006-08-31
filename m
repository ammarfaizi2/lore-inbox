Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWHaTFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWHaTFm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 15:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWHaTFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 15:05:42 -0400
Received: from gw.goop.org ([64.81.55.164]:18865 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932109AbWHaTFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 15:05:41 -0400
Message-ID: <44F73302.9000800@goop.org>
Date: Thu, 31 Aug 2006 12:05:38 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>,
       Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: SMP GDT setup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on a set of patches to implement per-processor data 
areas for i386, and changes to current and smp_processor_id() to take 
advantage of the PDA.  The implementation relies on the per-CPU GDT to 
set up a descriptor to the PDA memory, and then point %gs at that memory 
within the kernel.  In other words, very similar to the x86-64 PDA 
implementation.  (Posted to lkml yesterday, "Implement per-processor 
data areas for i386." and followups.)

This works well, but there is a window early in CPU bringup where the 
PDA has not been set up, and so smp_processor_id() and current are not 
usable.  For now, I'm defining early_* versions of these operations, 
which fall back to using the thread_info structure.  For the boot CPU, 
I'm currently setting up an early boot-time PDA corresponding to the 
boot-time GDT, which is replaced in cpu_init().

For secondary CPUs, I'm currently allocating the GDT and PDA on the boot 
CPU before bringing up the secondary, so I can avoid doing allocation 
before setting up the PDA (since the allocation code uses current). It 
would be nice to have the PDA set up much earlier so that this is not an 
issue.  Almost all the work can be done in advance before bringing up 
the secondary, and then head.S can simply lgdt its GDT and set %gs 
before even hitting C code, so that smp_processor_id and current will 
always work in C code.

I was thinking about how to go about doing this, and from looking over 
the history of common/cpu.c, it seems that my contemplated changes (use 
a static GDT and PDA for the boot CPU; use a simple cpu-id indexed array 
for other CPU GDT descrpitors and PDAs rather than using percpu()) would 
substantially revert your changes from 25 Feb 2006: "x86: fix broken SMP 
boot sequence", change 2b932f6cf052920fb3a6281499e08209b08f5086.

So, I'm wondering if you have any thoughts or suggestions for how I 
might go about doing this?

Thanks,
    J
