Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVBVWLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVBVWLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVBVWLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:11:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:4041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261298AbVBVWKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:10:38 -0500
Date: Tue, 22 Feb 2005 14:10:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Olof Johansson <olof@austin.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, jamie@shareable.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
In-Reply-To: <1109108532.5411.149.camel@gaston>
Message-ID: <Pine.LNX.4.58.0502221359420.2378@ppc970.osdl.org>
References: <20050222190646.GA7079@austin.ibm.com> 
 <Pine.LNX.4.58.0502221123540.2378@ppc970.osdl.org>  <1109106969.5412.138.camel@gaston>
  <Pine.LNX.4.58.0502221330360.2378@ppc970.osdl.org> <1109108532.5411.149.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Feb 2005, Benjamin Herrenschmidt wrote:
> 
> Yours is probably the most efficient too. Note sure what is best for
> rwsems tho, there seem to be some interest preventing readers from
> starving writers for ever, this has been debated endlessly iirc,
> though I have no personal opinion there.

Yes, the starvation issue is potentially real. And thinking about it,
we've even had that in real life, with /proc and lots of page faults. So I
guess that's a strong argument for the fairness thing.

Oh, well. The reason I hate the rwsem behaviour is exactly because it
results in this very subtle class of deadlocks. This one case is certainly
solvable several ways, but do we have other issues somewhere else? Things
like kobject might be ripe with things like this. The mm semaphore tends
to be pretty well-behaved - and I'm not sure the same is true of the
kobject one.

Normal recursive deadlocks are wonderful - most of them show up
immediately, so assuming you just have enough coverage, you're fine. This
fairness-related deadlock requires a race to happen.

Maybe it would be sufficient to have a debugging version of rwsems that
just notice recursion?

		Linus
