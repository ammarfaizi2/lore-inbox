Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTEHOeZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 10:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTEHOeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 10:34:25 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:46892 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261568AbTEHOeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 10:34:24 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030507152856.2a71601d.akpm@digeo.com>
References: <1052323940.2360.7.camel@diemos>
	 <1052336482.2020.8.camel@diemos>  <20030507152856.2a71601d.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052405227.1995.2.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 May 2003 09:47:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 17:28, Andrew Morton wrote:
> Paul Fulghum <paulkf@microgate.com> wrote:
> >
> > 2.5.69
> > Latency 100-110usec (5x increase)
> > Spikes from 5-10 milliseconds
> > 
> Could be that some random piece of code forgot to reenable interrupts, and
> things stay that way until they get reenabled again by schedule() or
> syscall return.
> 
> One way of finding the culprit would be:
> 
> 	my_isr()
> 	{
> 		if (this interrupt is more than 5 milliseconds delayed)
> 			dump_stack();
> 	}
> 
> the stack dump will point up at the place where interrupts finally got
> enabled.

Here is what I got (latency spike in milliseconds):

synclinkscc is a driver I maintain, and that is
where I placed the stack_dump()

Call Trace:
 [<cc8bdf1a>] IsrStatusB+0x1fa/0x2c0 [synclinkscc]
 [<cc8c5b29>] +0xf4/0x5ab [synclinkscc]
 [<cc8c5fe0>] +0x0/0x14c8 [synclinkscc]
 [<cc8be575>] mgscc_interrupt+0xa5/0x1b0 [synclinkscc]
 [<cc8c5fe0>] +0x0/0x14c8 [synclinkscc]
 [<c010d5eb>] handle_IRQ_event+0x4b/0x120
 [<c010d89b>] do_IRQ+0x9b/0x110
 [<c010bc00>] common_interrupt+0x18/0x20
 [<c01255db>] do_softirq+0x6b/0xe0
 [<c010d8fb>] do_IRQ+0xfb/0x110
 [<c0108f90>] default_idle+0x0/0x40
 [<c010bc00>] common_interrupt+0x18/0x20
 [<c0108f90>] default_idle+0x0/0x40
 [<c0108fc0>] default_idle+0x30/0x40
 [<c010905a>] cpu_idle+0x4a/0x60
 [<c0105000>] rest_init+0x0/0x60
 [<c0456951>] start_kernel+0x181/0x1b0
 [<c0456500>] unknown_bootoption+0x0/0x110



-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


