Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268534AbUILI5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268534AbUILI5a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 04:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUILI5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 04:57:30 -0400
Received: from holomorphy.com ([207.189.100.168]:10372 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268534AbUILI5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 04:57:21 -0400
Date: Sun, 12 Sep 2004 01:57:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040912085716.GI2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com> <4143D07E.3030408@yahoo.com.au> <20040912062703.GF2660@holomorphy.com> <4143E6C6.40908@yahoo.com.au> <20040912071948.GH2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912071948.GH2660@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 12:19:48AM -0700, William Lee Irwin III wrote:
> Sorry, 4*lg(NR_CPUS) is 64 when lg(NR_CPUS) = 16, or 65536 cpus. 512x
> Altixen would have 4*lg(512) = 4*9 = 36. The 4*lg(NR_CPUS) sizing was
> rather conservative on behalf of users of stack-allocated pagevecs.

And for the extra multiplications, that's a pagevec 296B in size, and
touching 36 page structure cachelines, or 2304B with a 64B cacheline,
4608B for a 128B cacheline, etc. and that even with a ridiculously
large number of cpus. A more involved batching factor may make
sense, though. e.g. 2**(2.5*sqrt(lg(NR_CPUS)) - 1) or some such to
get 4 -> 6, 9 -> 11, 16 -> 16, 25 -> 21, 36 -> 26, 49 -> 31, 64 -> 35,
81 -> 40, 100 -> 44, 121 -> 48, 144 -> 52, 169 -> 56, 196 -> 60,
225 -> 64, 256 -> 68, 289 -> 71, 324 -> 75, 361 -> 79, 400 -> 82,
441 -> 86, 484 -> 89, 529 -> 92, 576 -> 96, 625 -> 99, 676 -> 102,
729 -> 105, 784 -> 108, 841 -> 111, 900 -> 114, 961 -> 117, 1024 -> 120
etc., which looks like a fairly good tradeoff between growth with
NR_CPUS and various limits. I can approximate this well enough in the
preprocessor, but it would be somewhat more obscure than 4*lg(NR_CPUS)
(basically nest expansions of sufficiently rapidly convergent series
and use some functional relations to transform arguments into areas of
rapid convergence), but I suspect we should explore differentiating
between on-stack rapid-fire usage and longer-term amortization if we
must adapt so precisely rather than tuning a global PAGEVEC_SIZE to death.


-- wli
