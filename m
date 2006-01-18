Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWARL16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWARL16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWARL16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:27:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030227AbWARL15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:27:57 -0500
Date: Wed, 18 Jan 2006 03:27:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.16-rc1-mm1
Message-Id: <20060118032716.7f0d9b6a.akpm@osdl.org>
In-Reply-To: <43CE2210.60509@reub.net>
References: <20060118005053.118f1abc.akpm@osdl.org>
	<43CE2210.60509@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> My box came up first time lucky on this release, but I got a new oops:
> 
>  NET: Registered protocol family 1
>  NET: Registered protocol family 17
>  BUG: swapper/1, active lock [b19e6428(b19e6400-b19e6600)] freed!
>    [<b01040d1>] show_trace+0xd/0xf
>    [<b0104172>] dump_stack+0x17/0x19
>    [<b0131c6d>] mutex_debug_check_no_locks_freed+0xff/0x18e
>    [<b01544b3>] kfree+0x34/0x6a
>    [<b02a6109>] cpufreq_add_dev+0x127/0x379
>    [<b023abcb>] sysdev_driver_register+0x70/0xb0
>    [<b02a67df>] cpufreq_register_driver+0x68/0xfe
>    [<b03cc19d>] acpi_cpufreq_init+0xd/0xf
>    [<b01003cc>] init+0xff/0x325
>    [<b0100d25>] kernel_thread_helper+0x5/0xb
>    [b19e6428] {cpufreq_add_dev}
>  .. held by:           swapper:    1 [efe14ab0, 115]
>  ... acquired at:               cpufreq_add_dev+0x9d/0x379
>  p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available

Well yes, that code is kfree()ing a locked mutex.  It's somewhat weird to
take a lock on a still-private object but whatever.  The code's legal
enough.


--- devel/drivers/cpufreq/cpufreq.c~cpufreq-mutex-locking-fix	2006-01-18 03:25:33.000000000 -0800
+++ devel-akpm/drivers/cpufreq/cpufreq.c	2006-01-18 03:25:55.000000000 -0800
@@ -674,6 +674,7 @@ err_out_driver_exit:
 		cpufreq_driver->exit(policy);
 
 err_out:
+	mutex_unlock(&policy->lock);
 	kfree(policy);
 
 nomem_out:
_

