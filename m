Return-Path: <linux-kernel-owner+w=401wt.eu-S1750730AbWLKXwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWLKXwx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWLKXwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:52:53 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:40897 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbWLKXww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:52:52 -0500
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
From: Matt Helsley <matthltc@us.ibm.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Erik Jacobson <erikj@sgi.com>, guillaume.thouvenin@bull.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061209183409.67b54d01.zaitcev@redhat.com>
References: <20061207232213.GA29340@sgi.com>
	 <20061208192027.18a1e708.zaitcev@redhat.com>
	 <20061209210913.GA15159@sgi.com>
	 <20061209183409.67b54d01.zaitcev@redhat.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Mon, 11 Dec 2006 15:52:47 -0800
Message-Id: <1165881167.24721.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-09 at 18:34 -0800, Pete Zaitcev wrote:
> On Sat, 9 Dec 2006 15:09:13 -0600, Erik Jacobson <erikj@sgi.com> wrote:
> 
> > > Please try to declare u64 timestamp_ns, then copy it into the *ev
> > > instead of copying whole *ev. This ought to fix the problem if
> > > buffer[] ends aligned to 32 bits or better.
> >
> > So I took this suggestion for a spin and met with the same result.
> > The unaligned access messages are still produced.
> 
> I see. And I see you went a few steps forward with dignosing it:
> 
> > dbg fork after timespec_to_ns call, b4 memcpy
> > kernel unaligned access to 0xe000003076b6fbe4, ip=0xa0000001004f1480
> > dbg fork after memcpy, b4 other ev settings...
> 
> > a0000001004f1470 <proc_fork_connector+0x1f0> [MMI]       ld8 r40=[r14]
> > a0000001004f1476 <proc_fork_connector+0x1f6>             ld8 r38=[r38]
> > a0000001004f147c <proc_fork_connector+0x1fc>             nop.i 0x0;;
> > a0000001004f1480 <proc_fork_connector+0x200> [MIB]       st8 [r39]=r40
> > a0000001004f1486 <proc_fork_connector+0x206>             nop.i 0x0
> > a0000001004f148c <proc_fork_connector+0x20c>             br.call.sptk.many b0=a0000001000a36c0 <printk>;;

I'm not very familiar with ia64 asm but it looks like its loading and
storying 8 bytes at a time for the memcpy().

> It seems rather strange that memcpy gets optimized this way. I could
> not have foreseen it. Still, it was worth a try, even if putting 32
> extra bytes on stack and running memcpy on them does not seem too
> onerous, for a fork(). Thanks for doing it, and let's go with your
> original patch then... if Matt Helsley does not mind.

OK, I'll ack the original.

> Thank you,
> -- Pete

	I'm shocked memcpy() introduces 8-byte stores that violate architecture
alignment rules. Is there any chance this a bug in ia64's memcpy()
implementation? I've tried to read it but since I'm not familiar with
ia64 asm I can't make out significant parts of it in
arch/ia64/lib/memcpy.S.

<snip>

Cheers,
	-Matt Helsley

