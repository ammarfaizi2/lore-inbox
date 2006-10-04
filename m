Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030419AbWJDAKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWJDAKh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWJDAKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:10:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030419AbWJDAKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:10:36 -0400
Date: Tue, 3 Oct 2006 17:07:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: tim.c.chen@linux.intel.com
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.ananiev@intel.com
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061003170705.6a75f4dd.akpm@osdl.org>
In-Reply-To: <1159916644.8035.35.camel@localhost.localdomain>
References: <1159916644.8035.35.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 16:04:04 -0700
Tim Chen <tim.c.chen@linux.intel.com> wrote:

> Hi Herbet,
> 
> The patch "Let WARN_ON/WARN_ON_ONCE return the condition"
> http://kernel.org/git/?
> p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=684f978347deb42d180373ac4c427f82ef963171
> 
> introduced 40% more 2nd level cache miss to tbench workload
> being run in a loop back mode on a Core 2 machine.  I think the
> introduction of the local variables to WARN_ON and WARN_ON_ONCE
> 
> typeof(x) __ret_warn_on = (x);
> typeof(condition) __ret_warn_once = (condition);
> 
> results in the extra cache misses.

I don't see why it should.

Perhaps the `static int __warn_once' is getting put in the same cacheline
as some frequently-modified thing.   Perhaps try marking that as __read_mostly?

>  In our test workload profile, we see
> heavily used functions like do_softirq and local_bh_enable 
> takes a lot longer to execute.  
> 
> The modification below helps fix the problem.  I made a slight
> modification to sched.c to get around a gcc bug.
> 
> Signed-off-by: Tim Chen <tim.c.chen@intel.com>
> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
> index a525089..05ed388 100644
> --- a/include/asm-generic/bug.h
> +++ b/include/asm-generic/bug.h
> @@ -17,13 +17,12 @@ #endif
>  
>  #ifndef HAVE_ARCH_WARN_ON
>  #define WARN_ON(condition)
> ({                                          \
> -       typeof(condition) __ret_warn_on =
> (condition);                  \
> -       if (unlikely(__ret_warn_on))
> {                                  \
> +       if (unlikely(condition))
> {                                      \
>                 printk("BUG: warning at %s:%d/%s()\n",
> __FILE__,        \

Your patch is extremely wordwrapped.
