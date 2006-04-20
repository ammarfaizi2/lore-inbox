Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWDTPPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWDTPPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWDTPPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:15:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750976AbWDTPPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:15:08 -0400
Date: Thu, 20 Apr 2006 08:14:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Gerd Hoffmann <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU
In-Reply-To: <20060420052954.GA5524@elte.hu>
Message-ID: <Pine.LNX.4.64.0604200759400.3701@g5.osdl.org>
References: <20060419094630.GA14800@elte.hu> <20060420052954.GA5524@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Apr 2006, Ingo Molnar wrote:
> 
> but ... a more fundamental question is, where does the SMP-alternatives 
> code flush the icache? I dont think it's generally guaranteed on x86 
> CPUs that MESI updates to code get propagated into the icache of other 
> CPUs/cores.

It's guaranteed that the _caches_ get updated, but what isn't guaranteed 
is (a) when they do, in the absense of some synchronization primitive, 
anbd (b) that the prefetch queues do.

So you cannot rewrite code that some other CPU is executing, without some 
kind of locking (to make sure that it's not executing right then and 
there) and without having the other CPU do a serializing instruction 
(which the lock will normally generate, of course).

Now for the smp/up thing, we _should_ be safe, because the rewriting from 
UP back to SMP versions should happen before the other CPU even comes 
online (since we're the one bringing it up). And when we have more CPU's 
(and another CPU may be running), we've obviously already done it.

There must be another bug there somewhere. It's not about cache coherency.

(If it was, it would have more serious problems in the bootup sequence: 
think of just the trampoline that it generates to boot the second CPU, 
which is also written just before we actually tell the second CPU to boot 
up).

I can see two potential bugs:

 - we will do the alternatives_smp_switch(1) for each CPU that comes up, 
   even though we should do it only when we bring up the _first_ CPU 
   (which is obviously the second one - we never bring up the boot CPU).

   This should be ok, though. The subsequent calls should replace the code 
   with itself. I don't like writing to code even if it's writing with the 
   same contents, though.

   And this is not the issue you have, if you just have two cores (you 
   won't be bringing up a third CPU ;)

 - we simply save the smp info incorrectly, and don't bring it back 
   properly.

But cache coherency problems I don't believe in.

		Linus
