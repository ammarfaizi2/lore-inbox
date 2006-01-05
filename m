Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWAEQ7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWAEQ7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbWAEQ7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:59:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44259 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751004AbWAEQ7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:59:47 -0500
Date: Thu, 5 Jan 2006 08:55:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: Arjan van de Ven <arjan@infradead.org>, Martin Bligh <mbligh@mbligh.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Matt Mackall <mpm@selenic.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
In-Reply-To: <20060105143048.GT22293@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.64.0601050848580.3169@g5.osdl.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org>
 <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105143048.GT22293@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Jakub Jelinek wrote:
> > 
> > I wonder if gcc can be convinced to put all unlikely() code sections
> > into a .text.rare as well, that'd be really cool.
> 
> gcc 4.1 calls them .text.unlikely and you need to use
> -freorder-blocks-and-partition
> switch.  But I haven't been able to reproduce it on a short testcase I
> cooked up, so maybe it is broken ATM (it put the whole function into
> .text rather than the expected part into .text.unlikely and left
> empty .text.unlikely).

If it causes the conditional jump to become a long one instead of a byte 
offset one, it's actually a pessimisation for no gain (yes, it might give 
better cache density _if_ the function that is linked after the current 
one is cache-dense with the function in question and _if_ the unlikely 
sequence is really really unlikely, but that's two fairly big ifs).

So I'm not at all convinced of the feature (or maybe gcc actually does the 
right thing, and the reason you can't reproduce it is because gcc is being 
understandably reluctant to use the other section).

Basically, there's "biased one way", "unlikely", and there's "practically 
never happens". And even the "practically never" case will probably be 
better off with the unlikely case close-by, if it means that the likely 
case can use a short branch.

			Linus
