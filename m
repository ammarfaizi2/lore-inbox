Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263940AbTH1MSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTH1MSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:18:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:135 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263940AbTH1MSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:18:32 -0400
Date: Thu, 28 Aug 2003 13:18:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: Timo Sirainen <tss@iki.fi>, David Schwartz <davids@webmaster.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828121823.GB6800@mail.jlokier.co.uk>
References: <1062066411.1451.319.camel@hurina> <Pine.LNX.4.44.0308280425380.14580-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308280425380.14580-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagendra Singh Tomar wrote:
> > Or what about: write("12"), fsync(), write("12")? Is it still possible
> > for read() to return "1x1x"?
>
> Th read will still read both "12"s from the cache (in very high possibility).

That is a terrible assumption.

On all the Linux architures, even single CPUs, with no fancy memory
ordering, even 386, Pentiums etc., it is possible for read() to return
"1x1x".

Like this: the write() is preempted (see CONFIG_PREEMPT) after writing
one "1" byte, the read() runs, reads "1x" and is then preempted back
to the writer, which writes "2", calls fsync(), writes "1" and is then
preempted back to the reader, which continues and reads its second
"1x".

Interrupts caused by network packets arriving at just the wrong moment
can trigger that sort of thing.

> Even if the page caches are stolen (due to mem shortage) the kernel
> file cachecing will ensure that you get consistent data.

The kernel does not provide synchronisation between read() and write()
data transfers, and it does not always use atomic 32-bit reads and
writes either.

-- Jamie
