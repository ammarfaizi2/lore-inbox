Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUG1Af2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUG1Af2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 20:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266744AbUG1Af2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 20:35:28 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:18375 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S266741AbUG1AfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 20:35:20 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention 
In-reply-to: Your message of "Tue, 27 Jul 2004 17:14:15 MST."
             <20040728001415.GI2334@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Jul 2004 10:35:08 +1000
Message-ID: <21964.1090974908@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 17:14:15 -0700, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>On Tue, 27 Jul 2004, Andi Kleen wrote:
>>>> This will likely increase code size. Do you have numbers by how
>>>> much? And is it really worth it?
>
>Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>>>  Yes there is a growth;
>>>     text    data     bss     dec     hex filename
>>>  3655358 1340511  486128 5481997  53a60d vmlinux-after
>>>  3648445 1340511  486128 5475084  538b0c vmlinux-before
>
>On Tue, Jul 27, 2004 at 12:01:25PM -0700, Andrew Morton wrote:
>> The growth is all in the out-of-line section, so there should be no
>> significant additional icache pressure.
>
>There are also flash and similar absolute space footprints to consider.
>Experiments seem to suggest that consolidating the lock sections and
>other spinlock code can reduce kernel image size by as much as 220KB on
>ia32 with no performance impact (rigorous benchmarks still in progress).

I consolidated the spinlock contention path to a single routine on
ia64, with big space savings.  The problem with the ia64 consolidation
was backtracing through a contended lock; the ia64 unwind API is not
designed for code that is shared between multiple code paths but uses
non-standard entry and exit conventions.  In the end, David Mosberger
did a patch to gcc to do lightweight calls to the out of line
contention code, just to get reliable backtraces.

kdb has workarounds for backtracing through ia64 contended locks when
the kernel is built with older versions of gcc.  gdb (and hence kgdb)
has no idea about the special out of line code.  Mind you, the same is
true right now with the out of line i386 code, you need special
heuristics to backtrace the existing spinlock code reliably.  That will
only get worse with Zwane's patch, interrupts can now occur in the out
of line code.

Are you are planning to consolidate the out of line code for i386?  Is
there a patch (even work in progress) so I can start thinking about
doing reliable backtraces?

