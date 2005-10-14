Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVJNNMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVJNNMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 09:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVJNNMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 09:12:35 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:456 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750740AbVJNNMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 09:12:35 -0400
Date: Fri, 14 Oct 2005 15:12:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.14-rc4-rt1
Message-ID: <20051014131250.GA25466@elte.hu>
References: <20051011111454.GA15504@elte.hu> <1129135337.21743.11.camel@localhost.localdomain> <20051014062212.GA30874@elte.hu> <p73r7aos9ox.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73r7aos9ox.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > > I am getting similar segfault on boot problem on 2.6.14-rc4-rt1 on my 
> > > x86-64 box (with LATENCY_TRACE).
> > 
> > > INIT: version 2.86 booting
> > > hotplug[877]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
> > > 00007fffff8bee68 error 15
> > 
> > what does the ffffffff8010f588 RIP address map to? You can find out by 
> 
> It could be any kernel address that someone injected into user space.  
> Most likely some problem with the vsyscall page with either signal 
> handling or gettimeofday. vsyscall code is tricky to hack because you 
> cannot add any new functions there, just inlines, otherwise the code 
> won't end up the right section.

ah, indeed - i completely forgot about vsyscalls - they must not be 
traced. Badari, does the patch below help?

	Ingo

Index: linux/arch/x86_64/kernel/vsyscall.c
===================================================================
--- linux.orig/arch/x86_64/kernel/vsyscall.c
+++ linux/arch/x86_64/kernel/vsyscall.c
@@ -34,7 +34,7 @@
 #include <asm/errno.h>
 #include <asm/io.h>
 
-#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr)))
+#define __vsyscall(nr) __attribute__ ((unused,__section__(".vsyscall_" #nr))) notrace
 #define force_inline __attribute__((always_inline)) inline
 
 int __sysctl_vsyscall __section_sysctl_vsyscall = 1;
