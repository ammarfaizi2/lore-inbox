Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUIPRki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUIPRki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUIPRk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:40:27 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:45719 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268565AbUIPRjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:39:49 -0400
Date: Thu, 16 Sep 2004 19:38:21 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Utz Lehmann <lkml@de.tecosim.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] flexmmap: optimise mmap_base gap for hard limited stack
Message-ID: <20040916173821.GG15426@dualathlon.random>
References: <20040916165613.GA10825@de.tecosim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916165613.GA10825@de.tecosim.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 06:56:13PM +0200, Utz Lehmann wrote:
> Hi
> 
> With the flexmmap memory layout there is at least a 128 MB gap between
> mmap_base and TASK_SIZE. I think this is for the case that a running process
> can expand it's stack soft rlimit.
> 
> If there is a hard limit for the stack this minium gap is just a waste of
> space. This patch reduce the gap to the hard limit + 1 MB hole. If a process
> has a 8192 KB hard limit it have additional 119 MB space available over the
> current behavior.
> 
> And the current implemention has a problem. If the stack soft limit is
> 128+ MB there is no hole between the stack and mmap_base. If there is a
> mapping at mmap_base stack overflows are not detected. The patch made a
> 1MB hole between them.

I developed a sysctl several years ago in all my 2.2 and 2.4 kernels
including all 2.2 and 2.4 SUSE kernels that major software vendors
requires for safety of their apps. IIRC I tried to merge it once but I
failed (got not applied to mainline). Now I'v just got another bugzilla
open about the lack of the sysctl and the major app is now again not
foolproof. A fixed number won't work, so I have to drop such a fixed GAP
anyways and rewrite it by forward porting my patch.

The sysctl in question is /proc/sys/vm/heap-stack-gap, so I recommend to
drop all those fixed GAP sizes and implement this instead:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa3/00_silent-stack-overflow-20

If you reinvet the wheel and you prefer not to share the above code to
make a sysctl, at least make sure to use the name "heap-stack-gap" to
avoid any pointless incompatibility.
