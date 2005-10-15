Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVJOPJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVJOPJY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 11:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVJOPJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 11:09:24 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9166 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751169AbVJOPJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 11:09:23 -0400
Date: Sat, 15 Oct 2005 17:09:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.14-rc4] i386: spinlock optimization
Message-ID: <20051015150948.GA10763@elte.hu>
References: <200510142128_MC3-1-ACAD-8CD3@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510142128_MC3-1-ACAD-8CD3@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> Parent CPU 1, child CPU 0, using old code for lock
> CPU clocks: 2066947815
> Parent CPU 1, child CPU 0, using new code for lock
> CPU clocks: 2818166922

> Parent CPU 1, child CPU 0, using old code for lock
> CPU clocks: 5635093038
> Parent CPU 1, child CPU 0, using new code for lock
> CPU clocks: 5250078921

your numbers show that for the first box, there's a 36% net slowdown 
resulting from the new code. On the other (older) box, there's a 7% 
speedup from the new code.

i ran the code on two newer boxes, 2.4 and 3.4 GHz Xeons, on two sibling 
CPUs sharing the same physical CPU and on two different CPUs as well:

HT non-siblings [Xeon 2.40GHz], 1% slowdown:

 Parent CPU 2, child CPU 0, using old code for lock
 CPU clocks: 6712771070
 Parent CPU 2, child CPU 0, using new code for lock
 CPU clocks: 6787556068

HT siblings [Xeon 2.40GHz], 14% speedup:

 Parent CPU 1, child CPU 0, using old code for lock
 CPU clocks: 3587124593
 Parent CPU 1, child CPU 0, using new code for lock
 CPU clocks: 3079647206

HT non-siblings [Xeon 3.40GHz], 3% speedup:

 Parent CPU 2, child CPU 0, using old code for lock
 CPU clocks: 8486900988
 Parent CPU 2, child CPU 0, using new code for lock
 CPU clocks: 8255818784

HT siblings [Xeon 3.40GHz], 1% slowdown:

 Parent CPU 3, child CPU 0, using old code for lock
 CPU clocks: 3684195488
 Parent CPU 3, child CPU 0, using new code for lock
 CPU clocks: 3739797320

but given that the code is a drastic slowdown on older boxes (and 
results in higher memory bus traffic, which may slow down other CPUs 
too, which effect isnt measured here), i dont think we should apply the 
patch, just yet - up until the point it becomes a clear winner on new 
CPUs.

(in fact the ping-pong effect should be worse if more than 2 CPUs 
contend for the spinlock.)

could someone run the tests on a dual-core box too?

	Ingo
