Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUASSV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUASSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:21:58 -0500
Received: from palrel11.hp.com ([156.153.255.246]:2178 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262580AbUASSRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:17:10 -0500
Date: Mon, 19 Jan 2004 10:18:08 -0800
From: Grant Grundler <iod00d@hp.com>
To: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeremy@sgi.com
Subject: Re: [PATCH] readX_relaxed interface
Message-ID: <20040119181808.GA4225@cup.hp.com>
References: <20040115204913.GA8172@sgi.com> <20040116003224.GF23253@kroah.com> <20040116050059.GA13222@cup.hp.com> <023b01c3de6f$10276820$2987110a@lsd.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <023b01c3de6f$10276820$2987110a@lsd.css.fujitsu.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 06:31:42PM +0900, Hironobu Ishii wrote:
> But, when the read thread continues without noticing the error
> (before the error is asynchronously notified),

I wasn't suggesting asynchonous notification.

> the thread runs based on wrong data and may panic.

So far I've been assuming resources/IO requests can be cleaned up
more easily in a shared code path. I was assuming the readb() would 
call the "cleanup" and then return a "harmless" value (eg. 0 or -1)
that was provided by the driver before hand. I'm more worried
about the code that evaluates the readb() return value than
synchronous notification or cleaning up resources.

Having unique error recovery code after each PIO read did work
but it was not an elegant solution. It was a problem of too much
"unused" code interferring with the regular code path. And it
didn't distinguish sufficiently between code to handle "platform"
errors (failure to talk to a card) vs card errors (card
failed an IO).

I guess I'd need to modify one driver using my proposal
instead of assuming it doesn't matter wether the recovery code
lives immediately after the PIO read or in some common routine.
Problem is I have other issues to deal with right now
even though I've made clear to my management "HW error recovery"
is required for higher levels of availability with linux.

> So I think PIO read error must be notified synchronously.

I agree.

> On the other hand, PIO write error can be notified asynchronously,
> because software does not use it.

yes.

thanks,
grant
