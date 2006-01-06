Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWAFA5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWAFA5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWAFA5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:57:52 -0500
Received: from smtp-out.google.com ([216.239.45.12]:18128 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932138AbWAFA5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:57:51 -0500
Message-ID: <43BDBFE5.5020405@mbligh.org>
Date: Thu, 05 Jan 2006 16:55:01 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
References: <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060105233049.GA3441@elte.hu> <43BDB381.6020701@mbligh.org> <20060106004050.GA18727@elte.hu>
In-Reply-To: <20060106004050.GA18727@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> these 30 functions involve roughly 10-15 .o files, so we've got 2-3 
> functions per .o file only. And that's typical for VFS, IO, networking 
> and lots of other syscall types. So if the full kernel image is 3MB, and 
> we've got 30 functions totalling to 3000 bytes, they are spread out in 
> 10-15 groups right now - creating 10-15 split icache lines. (in reality 
> we have in excess of 20 split icache-lines, due to weak cohesion even 
> within .o files) With 64-byte lines that's 320-480 bytes 'lost' due to 
> fragmentation alone, with 128-byte lines it's 640-960 bytes - which is 
> 10%-21% in the 64-byte case, and 21%-42% in the 128-byte case. I.e. the 
> icache bloat just due to the placement is quite significant. Adding 
> .o-level fragmentation plus inter-function inactive code to the mix can 
> easily baloon this even higher. Plus the current method of doing 
> unlikely() means the unlikely instructions are near the end of the 
> function - so they still 'spread apart' the footprint and thus have a 
> nontrivial icache cost.

mmm. will take me a little time to digest that.

But we were just discussing here ... wouldn't it be worth moving 
"unlikely" sections of code completely out of line? If they were calls 
to separate functions, all this optimisation stuff could just work at a 
function level, and would be pretty trivial to do?

ie instead of:

if (unlikely(conditon)) {
	do;
	some;
	stuff;
	BUG();
	error();
	oh_dear();
}


we'd have


if (unlikely(conditon)) {
	call_oh_shit();
}

__rarely_called void call_oh_shit()
{
	do;
	some;
	stuff;
	BUG();
	error();
	oh_dear();
}

depends how long they are, I suppose. Moving that out of line would seem 
to make more difference to icache footprint to me than just cacheline 
packing functions.

M.
