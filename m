Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318635AbSHLCyS>; Sun, 11 Aug 2002 22:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318638AbSHLCyR>; Sun, 11 Aug 2002 22:54:17 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:60640 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S318635AbSHLCyP>; Sun, 11 Aug 2002 22:54:15 -0400
Message-Id: <200208120307.g7C37AuF000184@pool-141-150-241-241.delv.east.verizon.net>
Date: Sun, 11 Aug 2002 23:07:09 -0400
From: Skip Ford <skip.ford@verizon.net>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: ryan.flanigan@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
References: <200208120233.TAA16322@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208120233.TAA16322@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Aug 11, 2002 at 07:33:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
>
> 	I am also experiencing modules not working with CONFIG_PREEMPT
> set, and deactivating CONFIG_PREEMPT works around the problem for me too.
> 
[snip]
> 
> 	I already know that the error that trips insmod occurs at
> in modules.c, line 831, when qm_symbols gets an error from copy_to_user():
> 
>         for (; i < mod->nsyms ; ++i, ++s, vals += 2) {
>                 len = strlen(s->name)+1;
>                 if (len > bufsize)
>                         goto calc_space_needed;
> 
> here------>     if (copy_to_user(strings, s->name, len)
>                     || __put_user(s->value, vals+0)
>                     || __put_user(space, vals+1))
>                         return -EFAULT;
> 
>                 strings += len;
>                 bufsize -= len;
>                 space += len;
>         }
> 
> 	The values of strings and s->name are similar in 2.5.30+preempt
> (works) and 2.5.31+preempt (does not work).  strings is 0x08______, and
> s->name is 0xc0______.

If I back out this change to arch/i386/mm/fault.c then modules
successfully load.  I have no idea if backing it out causes other
problems though.

diff -Nru a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
--- a/arch/i386/mm/fault.c	Sat Aug 10 18:42:20 2002
+++ b/arch/i386/mm/fault.c	Sat Aug 10 18:42:20 2002
@@ -181,10 +181,10 @@
 	info.si_code = SEGV_MAPERR;
 
 	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
+	 * If we're in an interrupt, have no user context or are running in an
+	 * atomic region then we must not take the fault..
 	 */
-	if (in_interrupt() || !mm)
+	if (preempt_count() || !mm)
 		goto no_context;
 
 	down_read(&mm->mmap_sem);


-- 
Skip
