Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbSLKBBa>; Tue, 10 Dec 2002 20:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbSLKBBa>; Tue, 10 Dec 2002 20:01:30 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:51926 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S266933AbSLKBB2>; Tue, 10 Dec 2002 20:01:28 -0500
Date: Wed, 11 Dec 2002 01:10:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dave Hansen <haveblue@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix strange stack calculation for secondary cpus
In-Reply-To: <3DF655DF.1040507@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0212110048360.1821-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, Dave Hansen wrote:
> in arch/i386/kernel/smpboot.c:
> stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
> 
> This causes problems when I switch to 4k stacks?  What is supposed to 
> be going on here?  Why point esp into the middle of the stack?  If you 
> wanted to do that, why not just use PAGE_SIZE>>2?
> 
> In any case, I think THREAD_SIZE needs to be here instead of PAGE_SIZE.

Yes, it is weird: I wondered the same when we did our bigstack patch
for debugging 2.4 stack overflows.

The conclusion I came to was, it was trying to start the stack somewhere
that wouldn't clash with where it's set up for the trampoline at the top
of the stack area, see in particular initialize_secondary(): was choosing
somewhere arbitrarily far below that.

To avoid mysterious magic numbers, I chose instead to start it immediately
below that area i.e. set the top esp here to the bottom esp there.  That
worked fine for 2.4, I don't see why the same shouldn't work for 2.5.

Whereas with your patch, you might be overwriting that area.
So below I've munged your patch into what we found worked back then.

To be honest, I can't quite remember my way around that stuff now,
and my words above may make little sense!

Hugh

--- linux-2.5.50/arch/i386/kernel/smpboot.c.bad	Tue Dec 10 12:56:10 2002
+++ linux-2.5.50/arch/i386/kernel/smpboot.c	Tue Dec 10 12:56:55 2002
@@ -806,7 +806,7 @@
 
 	/* So we see what's up   */
 	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
-	stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle->thread_info);
+	stack_start.esp = (void *) idle->thread.esp;
 
 	/*
 	 * This grunge runs the startup process for

