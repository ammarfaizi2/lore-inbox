Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUJBAqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUJBAqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUJBAqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:46:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:42121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266905AbUJBAqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:46:17 -0400
Date: Fri, 1 Oct 2004 17:44:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
Message-Id: <20041001174400.2482186a.akpm@osdl.org>
In-Reply-To: <1096676374.12861.91.camel@dyn318077bld.beaverton.ibm.com>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
	<20041001120926.4d6f58d5.akpm@osdl.org>
	<1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
	<20041001145536.182dada9.akpm@osdl.org>
	<1096672002.12861.84.camel@dyn318077bld.beaverton.ibm.com>
	<20041001164938.3231482e.akpm@osdl.org>
	<1096676374.12861.91.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> 
>  On Fri, 2004-10-01 at 16:49, Andrew Morton wrote:
>  > Badari Pulavarty <pbadari@us.ibm.com> wrote:
>  > >
>  > > Here is the full sysrq-t output.
>  > 
>  > What's this guy up to?
>  ...
>  > 
>  > Something is seriously screwed up if it's stuck in try_to_wake_up().  Tried
>  > generating a few extra traces?
>  > 
>  > Then again, maybe we're missing an up_read() somewhere.  hrm, I'll check.
>  > 
> 
>  It reproduced again. I think this is the one causing all the troubles..
> 
>  db2fmcd       D ffffffff80132e2a     0 10854   7636                    
>  (NOTLB)
>  00000101bae85ef8 0000000000000002 0000020800000018 00000101d9ddd550
>         0000000100000084 000001016d490e20 000001016d491158
>  00000101d9ddd550
>         0000000000000206 ffffffff801353cb
>  Call Trace:<ffffffff801353cb>{try_to_wake_up+971}
>  <ffffffff804455f0>{__down_write+128}
>         <ffffffff80125e6f>{sys32_mmap+143}
>  <ffffffff80124af1>{ia32_sysret+0}
> 
>  when I tried looking at /proc/10854 - it hung.

OK, so maybe that CPU is spinning in try_to_wake_up().  Can you tell if one
CPU is busy when this happens?

Or you could try Peter's suggestion:

--- 25/kernel/sched.c~a	2004-10-01 17:43:32.500700488 -0700
+++ 25-akpm/kernel/sched.c	2004-10-01 17:43:34.754357880 -0700
@@ -1606,7 +1606,7 @@ out_set_cpu:
 		task_rq_unlock(rql, &flags);
 		/* might preempt at this point */
 		rql = task_rq_lock(p, &flags);
-		adjust_sched_timestamp(p, old_rq);
+//		adjust_sched_timestamp(p, old_rq);
 		old_state = p->state;
 		if (!(old_state & state))
 			goto out;
_

