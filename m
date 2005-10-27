Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVJ0C2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVJ0C2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 22:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVJ0C2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 22:28:40 -0400
Received: from fmr22.intel.com ([143.183.121.14]:1953 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751276AbVJ0C2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 22:28:40 -0400
Message-Id: <200510270228.j9R2SWg27777@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Weird schedule delay time for cache_reap()
Date: Wed, 26 Oct 2005 19:28:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXaniAXcF1hmKLkTk6eyuWxXlMDEw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't convince myself that the 2nd argument in schedule_delayed_work
called from cache_reap() function make any sense:


static void cache_reap(void *unused)
{ ...

        check_irq_on();
        up(&cache_chain_sem);
        drain_remote_pages();
        /* Setup the next iteration */
        schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC + smp_processor_id());
}


Suppose one have a lucky 1024-processor big iron numa box,
cpu0 will do cache_reap every 2 sec (REAPTIMEOUT_CPUC = 2*HZ).
cpu512 will do cache_reap every 4 sec,
cpu1023 will do cache_reap every 6 sec.

Is the skew intentional on different CPU?  Why different interval for
different cpu#?

- Ken

