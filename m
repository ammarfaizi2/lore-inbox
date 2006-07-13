Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWGMBQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWGMBQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 21:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWGMBQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 21:16:09 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:15523
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932470AbWGMBQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 21:16:08 -0400
Date: Thu, 13 Jul 2006 03:16:58 +0200
From: andrea@cpushare.com
To: Ingo Molnar <mingo@elte.hu>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713011658.GB9102@opteron.random>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712211358.GA10811@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712211358.GA10811@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this thread is not worth reading but since you tell me that I
am affected by NIH syndrome...

On Wed, Jul 12, 2006 at 11:13:58PM +0200, Ingo Molnar wrote:
> But he chose not to do so - and that has nothing to do with being unable 
> to improve ptrace - it evidently is improvable. So i see SECCOMP being 
> the result of the NIH syndrome.

	http://www.cpushare.com/hypermail/cpushare-discuss/06/01/0086.html

	"so if you walk this thought-experiment a bit, you'll quickly arrive to a 
	virtual machine that is actually pretty useful already, and is fully 
	provable. You should not dismiss this as "I dont trust it because it's 
	at ring 0", unless you can show some fatal flaw in my thinking."

In short a few months ago you told me that instead of using SECCOMP I
should filter and run the resulting filtered (but originally
untrusted) bytecode in ring0 inside the kernel without any memory
protection, because your filter was a lot more than the "int 0x80
checks plus jump offsets checks" (that Alan just mentioned), you
suggested a sort of kernel virtual machine that you just invented that
would verify where the bytecode could touch the ram. So the first bug
in this hugely complicated (and IMHO nearly impossible to implement
filter due the lack of memory protection) gives the attacker ring0
privilege because it all runs inside the kernel...

If it's you, inventing it the huge complicated insecure and probably
impossible to realize virtual machine in the kernel, it's ok. While if
it's me, I should be using ptrace instead of the simpler and much more
secure seccomp. If the above is not NIH syndrome I don't know what
that is.

About your first claim, as far as I'm concerned, if I use seccomp or
ptrace it doesn't change anything at all for me. It only changes for
the *users* because if I use ptrace they'll be less secure.

If not obvious yet the reasons of seccomp are multiple.

1) gdb (all buyers of the CPU resources will need a way to debug their
   own bytecode by running the sell client on their own machine, if
   something goes wrong). If seccomp will be used by others to do
   secure decompression, the fact gdb will keep working will be
   welcome for the same reason.
2) strace (I used it quite a lot of times to debug problems in seccomp
   bytecode myself already, it has been a fundamental debugging tool
   as usual)
3) not being susceptible to the newest ptrace addition of the day (you
   just mentioned a ptrace rework with the utrace framework).
4) I didn't want to require an userland knowledge of kernel details
   like syscall numbers and signal details for all archs (the signal
   part could even go out of sync with the kernel).
5) being simple, so less likely to be buggy. ptrace security is
   extremely complex, just the case where the ptracer tasks gets
   killed and the ptraced tasks must be synchronously sigkilled too is
   a controlled race in itself (that again could break after the
   frequent ptrace reworks you just mentioned and since it's a race
   condition it may go unnoticed for a while).
6) Ptrace is generally not being used for critical security features,
   it's primarly a debugging kludge, and others (including my ex. prof) are
   using it for virtualization similar in UML. But they're not running
   untrusted bytecode inside UML or in their virtualization software.
   No major outbreak would happen if ptrace suddenly breaks after one
   of the frequent reworks that you just mentioned.
