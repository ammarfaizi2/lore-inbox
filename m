Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVDHRTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVDHRTK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbVDHRTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:19:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30122 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262883AbVDHRPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:15:46 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc2-V0.7.44-00
From: Lee Revell <rlrevell@joe-job.com>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <39754.192.168.1.5.1112973759.squirrel@www.rncbc.org>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <46802.192.168.1.5.1112727980.squirrel@www.rncbc.org>
	 <1112729762.5147.62.camel@localhost.localdomain>
	 <39754.192.168.1.5.1112973759.squirrel@www.rncbc.org>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 13:15:41 -0400
Message-Id: <1112980542.10271.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 16:22 +0100, Rui Nuno Capela wrote:
> > Our first victim!! :-)
> >
> 
> No kidding!?
> 

V0.7.44-02 does not even compile for me.  It appears to be full of merge
errors.

I get these errors with "make oldconfig":

  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -o arch/i386/Kconfig
lib/Kconfig.RT:160:warning: choice values currently only support a single prompt
lib/Kconfig.RT:173:warning: choice values currently only support a single prompt
lib/Kconfig.RT:190:warning: choice values currently only support a single prompt
lib/Kconfig.RT:211:warning: choice values currently only support a single prompt
lib/Kconfig.RT:7:warning: choice values currently only support a single prompt
lib/Kconfig.RT:20:warning: choice values currently only support a single prompt
lib/Kconfig.RT:37:warning: choice values currently only support a single prompt
lib/Kconfig.RT:58:warning: choice values currently only support a single prompt
#
# using defaults found in .config

Then, looks like mcount-wrapper.S is two copies of the same file.  To
have any chance of building this patch was required:

--- arch/i386/kernel/mcount-wrapper.S~	2005-04-07 19:02:33.000000000 -0400
+++ arch/i386/kernel/mcount-wrapper.S	2005-04-07 19:52:24.000000000 -0400
@@ -25,30 +25,3 @@
 out:
 	ret
 
-/*
- *  linux/arch/i386/mcount-wrapper.S
- *
- *  Copyright (C) 2004 Ingo Molnar
- */
-
-.globl mcount
-mcount:
-
-	cmpl $0, mcount_enabled
-	jz out
-
-	push %ebp
-	mov %esp, %ebp
-	pushl %eax
-	pushl %ecx
-	pushl %edx
-
-	call __mcount
-
-	popl %edx
-	popl %ecx
-	popl %eax
-	popl %ebp
-out:
-	ret
-

And it still bombs out here.  This is where I gave up:

  CC      kernel/rt.o
kernel/rt.c:1931: error: redefinition of `pi_lock'
kernel/rt.c:55: error: `pi_lock' previously defined here
kernel/rt.c:2037: error: redefinition of `zap_rt_locks'
kernel/rt.c:161: error: `zap_rt_locks' previously defined here
kernel/rt.c:2382: error: redefinition of `check_pi_list_present'
kernel/rt.c:555: error: `check_pi_list_present' previously defined here
kernel/rt.c:2387: error: redefinition of `check_pi_list_empty'
kernel/rt.c:560: error: `check_pi_list_empty' previously defined here
kernel/rt.c:2398: error: redefinition of `change_owner'
kernel/rt.c:571: error: `change_owner' previously defined here
kernel/rt.c:2420: error: redefinition of `pi_setprio'
kernel/rt.c:593: error: `pi_setprio' previously defined here

[etc]

Lee



