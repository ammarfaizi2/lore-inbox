Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUCHBTJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbUCHBTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 20:19:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:24526 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262365AbUCHBTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 20:19:05 -0500
Subject: ppc/ppc64 and x86 vsyscalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078708647.5698.196.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Mar 2004 12:17:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulrich !

I've seen the various debates regarding the x86 vsyscalls.

I want to implement something similar for ppc, though the actual
syscalls covered will be differents.

The idea is that the kernel already has the necessary infrastructure
for precisely identifying each CPU model and doing various optimisations
based on which CPU we are running on.

We are planning on adding a set of per-CPU (model/familly)
implementation of some critical functions, that I would like to "share"
between the kernel and userland.

That include the atomic ops (some CPUs like embedde 4xx need additional
sync in there, while a sync would be a huge overhead on others) and
spinlocks, but also memory copy routines, and eventually cache
flush/invalidate functions (especially since some CPUs don't need them
at all) and possibly a userland implementation of gettimeofday.

The basic idea is to have a set of pages containing those functions
mapped in the top of the address space. The interest here is that it
would possibly allow to use the short absolute branch instructions
to get there.

However, the actual "form" of those is a bit difficult to decide on. The
problem is that just exposing a .so like x86 does is difficult. There
will be much more functions exposed (maybe around 20) and for each of
them, about 1 to 4 or 5 variations depending on the CPU we are running
on, but also depending on the current process beeing 32 or 64 bits.

They are all very simple leaf functions though. The "easy" way would
be to just have some kind of branch table code can "bal" to directly,
that or an exception-like design, which every function at an 0xn00
offset (with possible branch to some scratch space in the rare case
where a given implementation may overflow). The kernel could esily
"build" the pages based on which implementation is to be used on a
given CPU & process context.

However, the above makes things more difficult for userland, the big
problem as I was told by Alan Modra will be the lack of CFI informations
for stack unwinding on exceptions. But then, adding those for each
implementation makes the complexity of building those completely out
of control.

What do you think ? Any "smart" idea on how we could implement that
keeping the complexity of the kernel side reasonable without making
the userland side a nightmare ?

Regards,
Ben.


