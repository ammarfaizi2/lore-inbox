Return-Path: <linux-kernel-owner+w=401wt.eu-S1756678AbWLJClQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678AbWLJClQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 21:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759618AbWLJClQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 21:41:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50785 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756678AbWLJClQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 21:41:16 -0500
Date: Sat, 9 Dec 2006 18:34:09 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Erik Jacobson <erikj@sgi.com>
Cc: guillaume.thouvenin@bull.net, matthltc@us.ibm.com,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
Message-Id: <20061209183409.67b54d01.zaitcev@redhat.com>
In-Reply-To: <20061209210913.GA15159@sgi.com>
References: <20061207232213.GA29340@sgi.com>
	<20061208192027.18a1e708.zaitcev@redhat.com>
	<20061209210913.GA15159@sgi.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Dec 2006 15:09:13 -0600, Erik Jacobson <erikj@sgi.com> wrote:

> > Please try to declare u64 timestamp_ns, then copy it into the *ev
> > instead of copying whole *ev. This ought to fix the problem if
> > buffer[] ends aligned to 32 bits or better.
> 
> So I took this suggestion for a spin and met with the same result.
> The unaligned access messages are still produced.

I see. And I see you went a few steps forward with dignosing it:

> dbg fork after timespec_to_ns call, b4 memcpy
> kernel unaligned access to 0xe000003076b6fbe4, ip=0xa0000001004f1480
> dbg fork after memcpy, b4 other ev settings...

> a0000001004f1470 <proc_fork_connector+0x1f0> [MMI]       ld8 r40=[r14]
> a0000001004f1476 <proc_fork_connector+0x1f6>             ld8 r38=[r38]
> a0000001004f147c <proc_fork_connector+0x1fc>             nop.i 0x0;;
> a0000001004f1480 <proc_fork_connector+0x200> [MIB]       st8 [r39]=r40
> a0000001004f1486 <proc_fork_connector+0x206>             nop.i 0x0
> a0000001004f148c <proc_fork_connector+0x20c>             br.call.sptk.many b0=a0000001000a36c0 <printk>;;

It seems rather strange that memcpy gets optimized this way. I could
not have foreseen it. Still, it was worth a try, even if putting 32
extra bytes on stack and running memcpy on them does not seem too
onerous, for a fork(). Thanks for doing it, and let's go with your
original patch then... if Matt Helsley does not mind.

Thank you,
-- Pete

P.S. This syntax seems to cry for being expressed in diff -u:

>    ktime_get_ts(&ts); /* get high res monotonic timestamp */
>    //ev->timestamp_ns = timespec_to_ns(&ts); removed
>    printk("dbg fork before timestamp_to_ns call\n");
>    timestamp_ns = timespec_to_ns(&ts); //added
>    printk("dbg fork after timespec_to_ns call, b4 memcpy\n");
>    memcpy(&ev->timestamp_ns, &timestamp_ns, sizeof(ev->timestamp_ns)); //added
>    printk("dbg fork after memcpy, b4 other ev settings...\n");

