Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVFTUgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVFTUgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVFTUdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:33:47 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:46528 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261570AbVFTUcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:32:47 -0400
Date: Mon, 20 Jun 2005 13:34:45 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Telemaque Ndizihiwe <telendiz@eircom.net>, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces two GOTO statements with one IF_ELSE statement in /fs/open.c
Message-ID: <20050620203445.GB84485@gaz.sfgoth.com>
References: <Pine.LNX.4.62.0506201834460.5008@localhost.localdomain> <Pine.LNX.4.61.0506201504440.5255@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506201504440.5255@chaos.analogic.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 20 Jun 2005 13:34:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Did you check and benchmark the resulting code? The goto statements
> are never because the kernel developers didn't know how to use
> other constructs, you know.
> 
> The goto statements are so that the normal path continues
> straight through the code while the exceptions take the jumps.

Yes, but I think in this case it's OK.  IS_ERR() already includes an
"unlikely()" marking so gcc *should* be able to do the right thing.
The goto is probably just a remnant from before unlikely() existed.
There are a lot of them - cleaning them up is a good thing.

That said, it'd probably be good to look at the generated assembly in each
case to make sure it still looks good.  That'd be a lot more useful than
trying to benchmark a tiny micro-optimizaiton in open()  It's generally
nearly impossible to benchmark these sorts of things anyway since when
you're running a simple benchmark the whole function will be in Icache and
the branch predictor history so it'll run the same speed either way.

The advantage to keeping the fast-path straight through is that you consume
the minimum number of lines in the Icache and the branch will get predicted
correctly even without history (since the first-level branch prediction
heuristic is always "branches backward are taken, branches forward are not")

-Mitch
