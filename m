Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSIZPy0>; Thu, 26 Sep 2002 11:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261336AbSIZPy0>; Thu, 26 Sep 2002 11:54:26 -0400
Received: from [217.167.51.129] ([217.167.51.129]:25585 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261332AbSIZPyZ>;
	Thu, 26 Sep 2002 11:54:25 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@transmeta.com>
Subject: [RFC] {read,write}s{b,w,l} or iobarrier_*()
Date: Thu, 26 Sep 2002 17:59:40 +0200
Message-Id: <20020926155941.3602@192.168.4.1>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Here I need people to agree so we decide once for all what
we want and move further (this has been discussed several
times already withotu agreement).

So, the "generic" problem is: reading/writing from/to a FIFO
that is larger than 8 bits wide on a big endian machine requires
more than just a loop of reads or writes. Those IO functions
are doing byteswap (and barriers on every call) while the FIFO
access wants typically to be not byteswapped nor have barriers
on every access.

For "PIO", we already provide the "s" functions {in,out}s{b,w,l}
that are implemented by every arch and provide drivers with a
good abstraction to use (see ide_insw/ide_outsw in 2.5 which
should just be a simple insw/outsw for normal interfaces for
example).

However, we don't provide a similar abstraction for MMIO.
Typical cases where we want this is MMIO versions of the
IDE iops (we probably want to provide generic impl of both
PIO and MMIO ones in ide-iops, not just PIO); some sound
cards, etc...

A driver needing that today will have to either use a loop
of {read,write}{b,w,l} and undo byteswapping (ugh), or try
to re-implement it using raw_{read,write}{b,w,l} and adding
proper iobarrier_* where needed. But the iobarrier functions
aren't provided by all archs which means ugly #ifdef salad,
and I hate having to put the burden of knowing everything
about barriers one each single driver maintainer.

So we have 2 solutions here (one of which I prefer, but I
still want the debate open here):

 - Have all archs provide {read,write}s{b,w,l} functions.
Those will hide all of the details of bytewapping & barriers
from the drivers and can be used as-is for things like IDE
MMIO iops.

 - Have all archs provide iobarrier_* functions. Here, drivers
would still have to re-implement the transfer loops with
raw_{read,write}{b,w,l} and do proper use of iobarrier_*.

Ben.


