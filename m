Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUINFvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUINFvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUINFvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:51:44 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:61866
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269028AbUINFvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:51:41 -0400
Date: Mon, 13 Sep 2004 22:49:43 -0700
From: "David S. Miller" <davem@davemloft.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, raybry@sgi.com, jbarnes@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-Id: <20040913224943.04761a15.davem@davemloft.net>
In-Reply-To: <20040914053218.GB9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
	<20040914044748.GZ9106@holomorphy.com>
	<20040913220507.1a269816.davem@davemloft.net>
	<20040914053218.GB9106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 22:32:18 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> This was my original approach (modulo eliminating the global buffer
> and the atomic operations), but space concerns stymied it, as the
> profile buffer can be several megabytes large. It would likely perform
> better in general if admissible, for whatever value performance is
> considered to have.
> 
> There is also an unusual facet to this; the TLB overhead of a loop like:
> 	for (i = 0; i < prof_len; ++i) {
> 		for_each_online_cpu(cpu)
> 			global_buf[i] += per_cpu(cpu_prof_buffer, cpu)[i];
> 	}
> is very large and caused "effective nontermination", otherwise known as
> "exhausting the user's patience", on SGI's systems after about half an
> hour. So some TLB overhead amortization is necessary for this to be
> feasible. I suspect iterating over pages of the profile buffer and
> storing intermediate results for a page full of profile buffer hits
> in a buffer page may suffice though I've not tried it.

I bet that, like we found out about page tables on 64-bit, these
profile buffers are sparsely populated with hits.  So perhaps a
per-cpu bitmap that indicates regions that might have any hits
at all, allowing large amounts of skipping and thus amortizing the
scan cost.
