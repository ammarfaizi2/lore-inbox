Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWAEX7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWAEX7p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWAEX67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:58:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:23259 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932287AbWAEX6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:58:54 -0500
Date: Fri, 6 Jan 2006 00:58:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060105235808.GA12605@elte.hu>
References: <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <20060105213442.GM3356@waste.org> <Pine.LNX.4.64.0601051402550.3169@g5.osdl.org> <20060105223656.GP3356@waste.org> <20060105225513.GA1570@elte.hu> <20060105231150.GR3356@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105231150.GR3356@waste.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> > so i think the two concepts could nicely co-exist: in-source annotations 
> > help us maintain the popularity list, -ffunction-sections allows us to 
> > reorder at link time. In fact such a kernel could be shipped in 
> > 'unlinked' state, and could be relinked based on per-system profiling 
> > data. As long as we have KALLSYMS, it's not even a big debuggability 
> > issue.
> 
> I'm still not sure about in-source annotations for popularity. My 
> suspicion is that it's just too workload-dependent, and a given 
> author's workload will likely be biased towards their code.

in-source annotations can do more:

- inlines could be driven by profile data: if a function is used in a 
  hot path and it's used only once, it makes sense to inline that 
  function into that hot path - because the kernel size increase will be 
  in the cold portion.

- we could drive the likely/unlikely annotations via profiling data.

OTOH i think that _most_ of the benefit (80% :-) could be achieved via 
the much simpler (and more robust) link-time-reordering solution. It is 
also alot less intrusive, and can still be presented in some plain-text 
format that can be distributed along the upstream kernel:

	linux/profiles/webserver.list
	linux/profiles/database-server.list
	linux/profiles/desktop.list
	linux/profiles/beowulf-node.list

and users could pick their profile at build time / relink time. There is 
no binary compatibility problem with such plaintext lists - they dont 
have to be fully complete, nor do they have to be fully accurate - they 
dont impact correctness in any way. In fact profiles could merge all 
architectures into one file, so they would be pretty generic as well.

	Ingo
