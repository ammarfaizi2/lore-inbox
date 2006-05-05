Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWEEUjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWEEUjV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWEEUjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:39:21 -0400
Received: from waste.org ([64.81.244.121]:5356 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751216AbWEEUjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:39:20 -0400
Date: Fri, 5 May 2006 15:34:37 -0500
From: Matt Mackall <mpm@selenic.com>
To: Theodore Tso <tytso@mit.edu>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060505203436.GW15445@waste.org>
References: <8.420169009@selenic.com> <65CF7F44-0452-4E94-8FC1-03B024BCCAE7@mac.com> <20060505172424.GV15445@waste.org> <20060505191127.GA16076@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505191127.GA16076@thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 03:11:27PM -0400, Theodore Tso wrote:
> On Fri, May 05, 2006 at 12:24:26PM -0500, Matt Mackall wrote:
> > I haven't seen such an analysis, scholarly or otherwise and my bias
> > here is to lean towards the paranoid.
> > 
> > Assuming a machine with no TSC and an otherwise quiescent ethernet
> > (hackers burning the midnight oil), I think most of the
> > hard-to-analyze bits above get pretty transparent.
> 
> As always, whether or not the packet arrival times could be guessable
> and/or controlled by an attacker really depends on your threat model.
> For someone who has an ethernet monitor attached directly to the
> segment right next to your computer, it's very likely that they would
> be successful in guessing the inputs into the entropy pool.  However,
> an attacker with physical access to your machine could probably do all
> sorts of other things, such as install a keyboard sniffer, etc.  
> 
> For a remote attacker, life gets much more difficult.  Each switch,
> router, and bridge effectively has a queue into which packets must
> flow through, and that is _not_ known to a remote attacker.  This is
> especially true today, when most people don't even use repeaters, but
> rather switches/bridges, which effectly make each ethernet connection
> to each host its own separate collision domain (indeed that term
> doesn't even apply for modern high-speed ethernets).
> 
> I've always thought the right answer is that whether or not network
> packet arrival times should be used as entropy input should be
> configurable, since depending on the environment, it might or might
> not be safe, and for some hosts (particularly diskless servers), the
> network might be the only source of entropy available to them.

Nonetheless, the current SA_SAMPLE_RANDOM scheme should go. A) it's in
the IRQ fast path B) most of its users are bogus which strongly
indicates it's a bad API.

Instead (if we want network entropy) we should add an
add_network_randomness call in some central location in the network
stack (probably right next to netpoll's RX hooks) and probably have it
compiled out by default.

-- 
Mathematics is the supreme nostalgia of our time.
