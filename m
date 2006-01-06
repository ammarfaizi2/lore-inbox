Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752328AbWAFAuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbWAFAuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbWAFAuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:50:07 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:45764 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1752326AbWAFAuF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:50:05 -0500
Date: Thu, 5 Jan 2006 16:50:04 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060106005004.GC84622@gaz.sfgoth.com>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 05 Jan 2006 16:50:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Oh, but validatign things like "likely()" and "unlikely()" branch hints 
> might be a noticeably bigger issue. 

I think the issues are somewhat intertwined.

For instance, assume you have code like:

	if (some_function(skb)) {
		blah();
		printk(KERN_WARN "bad packet...\n");
	} else {
		process_skb(skb);
	}

Now just by annotating printk() as "rare" then gcc should be able to guess
that the "if" is unlikely() without explicitly marking it as such since
one of its paths calls a rare function and the other does not.  If instead
both paths called rare functions then the compiler could decide that the
whole block is probably "rare" and optimize accordingly.

I haven't looked at gcc 4.1 yet so I don't know how sophisticated its "rare"
promotion rules are yet but this is certainly the kind of thing the compiler
should be able to handle.

So basically better inter-functional locality hints should also help
intra-functional locality.

[from another message]
> We don't have likely()/unlikely() that often, and at least in my case it's
> partly because the syntax is a pain (it would probably have been better to
> include the "if ()" part in the syntax - the millions of parenthesis just
> drive me wild).

I actually did that in a project once (an "unlikely_if()" macro)  It was
not a good idea.  The problem is that every syntax-highlighter knows that
"if" is a keyword but you'd have to teach it about "unlikely_if".  It was
surprising how visually jarring having different pretty-printing for
different types of "if" statements was.  "if (unlikely())" looks much
cleaner in comparison.

-Mitch
