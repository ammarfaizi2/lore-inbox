Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271876AbRIDCAw>; Mon, 3 Sep 2001 22:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271877AbRIDCAm>; Mon, 3 Sep 2001 22:00:42 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:39685 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S271876AbRIDCAe>;
	Mon, 3 Sep 2001 22:00:34 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15252.13330.652765.959658@cargo.ozlabs.ibm.com>
Date: Tue, 4 Sep 2001 11:53:22 +1000 (EST)
To: Richard Henderson <rth@twiddle.net>
Cc: David Mosberger <davidm@hpl.hp.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] avoid unnecessary cache flushes
In-Reply-To: <20010903134125.B16069@twiddle.net>
In-Reply-To: <15247.29338.3671.548678@cargo.ozlabs.ibm.com>
	<20010903131436.A16069@twiddle.net>
	<15251.59286.154267.431231@napali.hpl.hp.com>
	<20010903134125.B16069@twiddle.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson writes:

> You can get a missed flush from
> 
> 	bit == 0
> 	flush cache
> 
> 				modify page
> 				bit = 0
> 
> 	bit = 1
> 
> unless this is protected from some outer lock of which 
> I am not aware.

The page is question is one which is mapped (is being mapped) into a
process's address space with execute permission.  If the page is part
of the page cache for a file, then I would have thought that attempts
to write to the page would return an ETXTBSY error.  If the page is a
private page (private COW or anonymous page) then I don't see where
the kernel would be modifying the page.  If it is already mapped into
another process's address space with a shared writable mapping, and
that process is writing to the page, then it is up to the user-level
stuff to do the necessary cache-flushing.

So I think it's OK at the moment, but I agree it does look like a race
waiting to happen.

For alpha, the thing that my patch does that might hurt is the change
from flush_icache_page to flush_icache_range in kernel/ptrace.c.  Any
comment on that?

Paul.

