Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbTJJPOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTJJPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:14:46 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50059 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262938AbTJJPOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:14:44 -0400
Date: Fri, 10 Oct 2003 16:12:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: William Lee Irwin III <wli@holomorphy.com>, G?bor L?n?rt <lgb@lgb.hu>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010151231.GD28795@mail.shareable.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu> <20031010144723.GC727@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010144723.GC727@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> You need at least enough warning to get out of critical sections (e.g.
> holding a spinlock) and dump registers out to memory. i.e. as long as it
> takes to schedule out whatever's currently running on the thing.
> 
> ... and unless you want to start enforcing realtime bounds, the answer
> to "how long do you have to give the kernel to do it?" is "forever".
> In practice, it won't take forever, but no finite time is enforcible.

You can create a very peculiar scheduling state to make even
spinlocked sections multi-task, so the CPU can be released in a finite
time and quickly - about as quickly as taking an NMI and broadcasting
the critical IPIs to tell other CPUs to take over.

The peculiar state is restored to normal as soon as the number
of concurrent critical sections no longer exceeds the number of real CPUs.

Come to think of it, this would be an excellent HA mechanism: CPU or
node detects hardware fault, raises NMI which saves the CPU registers,
does the IPIs and then immediately disables the CPU.  That's _it_.

The peculiar scheduling state obviously slows down the code which is
unlucky enough to be caught in a critical section when a CPU is
removed, so if there is _timing_ critical code it will be affected,
but that is a similar problem to speedstep etc.

-- Jamie
