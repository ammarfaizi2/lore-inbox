Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266177AbUGPCNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUGPCNu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 22:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUGPCNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 22:13:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:16814 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266177AbUGPCNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 22:13:49 -0400
Subject: sched domains bringup race?
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Matthew C. Dobson [imap]" <colpatch@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1089944026.32312.47.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Jul 2004 19:13:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep getting oopses for the non-boot CPU in find_busiest_group(). 
This occurs the first time that the CPU goes idle.  Those groups are set
up in sched_init_smp(), which is called after smp_init():

static int init(void * unused)
{
	...
        fixup_cpu_present_map();
        smp_init();
        sched_init_smp();

But, the idle threads for the secondary CPUs are initialized in
smp_init().  So, what happens when a CPU tries to schedule (using sched
domains) before sched_init_smp() completes?  I think it goes boom! :)

Anyway, I was thinking that we should just hold the runqueue lock on the
non-boot CPUs until the sched domain init code is done.  Does that sound
feasible?

-- Dave

