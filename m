Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263413AbUEKTMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbUEKTMB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUEKTMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:12:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:43980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263413AbUEKTLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:11:52 -0400
Date: Tue, 11 May 2004 12:11:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Geoff Gustafson" <geoff@linux.jf.intel.com>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] [PATCH] Performance of del_timer_sync
Message-Id: <20040511121126.73f5fdeb.akpm@osdl.org>
In-Reply-To: <00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com>
References: <409FFF3B.3090506@linux.intel.com>
	<20040511004551.7c7af44d.akpm@osdl.org>
	<00c001c43786$f1805000$ff0da8c0@amr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Geoff Gustafson" <geoff@linux.jf.intel.com> wrote:
>
> Andrew Morton wrote:
> > Geoff Gustafson <geoff@linux.jf.intel.com> wrote:
> >> 
> >> I started this patch based on profiling an enterprise database
> >>  application on a 32p IA64 NUMA machine, where del_timer_sync was
> >>  one of the top few functions taking CPU time in the kernel.
> > 
> > Do you know where it's being called from?
> 
> OK, the main sources were:
> 
> sys_semtimedop() -> schedule_timeout()
> 
> sys_io_getevents() -> read_events() -> clear_timeout()
> 

OK, thanks.  schedule_timeout()!  Ow.

Ingo, why is this not sufficient?


diff -puN kernel/timer.c~a kernel/timer.c
--- 25/kernel/timer.c~a	2004-05-11 12:10:28.695557600 -0700
+++ 25-akpm/kernel/timer.c	2004-05-11 12:10:42.820410296 -0700
@@ -331,6 +331,8 @@ int del_timer_sync(struct timer_list *ti
 
 del_again:
 	ret += del_timer(timer);
+	if (!ret)
+		return 0;
 
 	for_each_cpu(i) {
 		base = &per_cpu(tvec_bases, i);

_

