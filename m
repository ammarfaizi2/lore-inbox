Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269142AbUINFc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269142AbUINFc3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUINFc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:32:29 -0400
Received: from holomorphy.com ([207.189.100.168]:9617 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269142AbUINFc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:32:26 -0400
Date: Mon, 13 Sep 2004 22:32:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, raybry@sgi.com, jbarnes@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914053218.GB9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com> <20040913220507.1a269816.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913220507.1a269816.davem@davemloft.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 10:05:07PM -0700, David S. Miller wrote:
> William, any reason not to fully per-cpu the profile buffer
> and then only traverse the array when the user attempts to
> capture the counters?
> Then we can undo the atomics altogether, as well as the cacheline
> traffic, for the extremely common case.
> Are there space concerns?

This was my original approach (modulo eliminating the global buffer
and the atomic operations), but space concerns stymied it, as the
profile buffer can be several megabytes large. It would likely perform
better in general if admissible, for whatever value performance is
considered to have.

There is also an unusual facet to this; the TLB overhead of a loop like:
	for (i = 0; i < prof_len; ++i) {
		for_each_online_cpu(cpu)
			global_buf[i] += per_cpu(cpu_prof_buffer, cpu)[i];
	}
is very large and caused "effective nontermination", otherwise known as
"exhausting the user's patience", on SGI's systems after about half an
hour. So some TLB overhead amortization is necessary for this to be
feasible. I suspect iterating over pages of the profile buffer and
storing intermediate results for a page full of profile buffer hits
in a buffer page may suffice though I've not tried it.


-- wli
