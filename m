Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289815AbSBSUZI>; Tue, 19 Feb 2002 15:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289829AbSBSUYG>; Tue, 19 Feb 2002 15:24:06 -0500
Received: from zok.sgi.com ([204.94.215.101]:6310 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S289823AbSBSUXS>;
	Tue, 19 Feb 2002 15:23:18 -0500
Date: Tue, 19 Feb 2002 12:23:10 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Dan Maas <dmaas@dcine.com>
Cc: David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Collins <bcollins@debian.org>
Subject: Re: readl/writel and memory barriers
Message-ID: <20020219122310.A1510182@sgi.com>
Mail-Followup-To: Dan Maas <dmaas@dcine.com>,
	David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ben Collins <bcollins@debian.org>
In-Reply-To: <092401c1b8e7$1d190660$1a01a8c0@allyourbase> <15474.34580.625864.963930@napali.hpl.hp.com> <20020219103506.A1511175@sgi.com> <0a5301c1b981$a921f820$1a01a8c0@allyourbase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5301c1b981$a921f820$1a01a8c0@allyourbase>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 03:11:45PM -0500, Dan Maas wrote:
> I have a hunch that many drivers will break if you change the semantics of
> readX/writeX from in-order to out-of-order - lots of drivers are only
> developed & tested on x86, which completely hides the issue...

Fortunately, I don't think things are quite that bad.  As David
pointed out, on ia64 the readX/writeX stuff is ordered coming out of
the CPU, so if you're in a spinlock protected region, for example, all
the reads/writes you do will occur in order.  The problem that I'm
trying to solve is that on some platforms, I/O space references won't
necessarily occur in order if they come from different CPUs.  E.g.
after you do some I/O and drop a spinlock, another CPU may pick it up
and start doing some I/O that *may* get intermixed with the I/O from
the previous holder of the spinlock unless you explicity barrier said
I/O.

Any ideas on how to address this issue?  I was thinking of either
introducing an I/O space barrier (currently called mmiob() in the 2.5
ia64 patch) or taking the performance hit in mb, rmb, and wmb, as well
as readX/writeX to ensure proper ordering.  Or, as I mentioned in
another mail, we could have a special io_spin_unlock routine that does
the barrier for you.  Comments?

Thanks,
Jesse
