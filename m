Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTFOOWR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTFOOWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:22:17 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:41990 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262262AbTFOOWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:22:16 -0400
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a
	misalignment
From: James Bottomley <James.Bottomley@steeleye.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1055657946.6481.6.camel@rth.ninka.net>
References: <1055221067.11728.14.camel@mulgrave> 
	<1055657946.6481.6.camel@rth.ninka.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Jun 2003 09:35:52 -0500
Message-Id: <1055687753.10803.28.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-15 at 01:19, David S. Miller wrote:
> On Mon, 2003-06-09 at 21:57, James Bottomley wrote:
> > The problem seems to be that the new struct sock_common ends with a
> > pointer and an atomic_t (which is an int on parisc), so the compiler
> > adds an extra four bytes of padding where none previously existed in
> > struct tcp_tw_bucket, so the __u64 ptr tricks with tw_daddr fail.
> 
> I'm fixing this, but why does it "fail"?  You should get unaligned
> traps which get fixed up by the trap handler.

Well, it's an architecture thing, I suppose.  Unaligned access traps are
pretty expensive on the parisc, so we don't actually handle them when
they're from the kernel, we panic instead (and expect the problem code
to be fixed).

In this case, our rather crappy kernel tool chain gcc generated the
instruction

ldd 52(%r1),%r4

Which is actually illegal assembly (displacements greater than 16 must
be multiples of 8 for the load double word instruction).  So I couldn't
even compile the code.

> If that isn't happening, lots of things in the networking should
> break on you.

If the gcc is told that the structure won't be aligned, it generates
non-alignment faulting instructions to access it, so no, we don't see
any misalignment faults in the networking layer.

James


