Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWJEIkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWJEIkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWJEIkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:40:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751335AbWJEIkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:40:00 -0400
Date: Thu, 5 Oct 2006 01:36:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: andrew.j.wade@gmail.com
Cc: tim.c.chen@linux.intel.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, leonid.i.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061005013635.e016bf2b.akpm@osdl.org>
In-Reply-To: <200610050417.39518.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <1159916644.8035.35.camel@localhost.localdomain>
	<200610041251.26166.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
	<20061004150631.65e8953f.akpm@osdl.org>
	<200610050417.39518.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 04:13:07 -0400
Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> (from earlier)
> > Perhaps the `static int __warn_once' is getting put in the same cacheline
> > as some frequently-modified thing.
> 
> hmm:
> 
> 00000460 l     O .data  00000044 task_exit_notifier
> 000004c0 l     O .data  0000002c task_free_notifier
> 000004ec l     O .data  00000004 warnlimit.15904
> 000004f0 l     O .data  00000004 firsttime.15774
> 000004f4 l     O .data  00000004 __warn_once.15180
> 000004f8 l     O .data  00000004 __warn_once.15174
> 000004fc l     O .data  00000004 __warn_once.15213
> 00000500 l     O .data  00000004 __warn_once.15207
> 00000504 l     O .data  00000004 __warn_once.15145
> 00000508 l     O .data  00000004 __warn_once.15309
> 0000050c l     O .data  00000004 __warn_once.15256
> 00000510 l     O .data  00000004 __warn_once.15250
> 000005a0 l     O .data  0000006c proc_iomem_operations
> (extracted from objdump -t kernel/built-in.o)


That all looks OK (by sheer luck).

Well.  What's the cache line size on that machine?  Every exit() will cause
a down_read() on task_exit_notifier's lock which might affect things.  And
I think you snipped the above list a bit short (depending on that line
size).


But still, we know that moving those things into __read_mostly didn't fix
it, yes?

