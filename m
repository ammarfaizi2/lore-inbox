Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269462AbUIZBBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269462AbUIZBBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 21:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269467AbUIZBBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 21:01:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:26243 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269462AbUIZBBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 21:01:00 -0400
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all
	set_pte must be written in asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Rik van Riel <riel@redhat.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040926004608.GS3309@dualathlon.random>
References: <20040926002037.GP3309@dualathlon.random>
	 <Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com>
	 <20040926004608.GS3309@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096160383.18233.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 26 Sep 2004 10:59:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 10:46, Andrea Arcangeli wrote:

> As far as the C language is concerned that *ptep = something can be
> implemented with 8 writes of 1 byte each (or alternatively with an
> assembler instruction that may make the written data visible not
> atomically to other cpus, despite it was written with a single opcode,
> similarly to what happens if you use incl without the lock prefix). I'm
> not saying such instruction exists in ppc64, but the compiler is
> definitely allowed to break the above. You can blame on the compiler to
> be inefficient, but you can't blame on the compiler for the security
> hazard it would generate. Only the kernel would be to blame if for
> whatever reason a gcc version would be underoptimized.

BTW, for your reading pleasure :)

#define atomic_set(v,i)		(((v)->counter) = (i))

(asm-i386/atomic.h)

And that's really far from beeing the 2 only cases where the kernel _relies_
on a write of a simple type like int or long to an aligned location to be
atomic. Almost all drivers manipulating DMA descriptors do that, jiffies
is a good example too afaik, and more and more and more ... so if the
compiler is breaking that up, I think the set_pte race is the least of
our problems :)

Ben.


