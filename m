Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWHCRRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWHCRRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWHCRRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:17:44 -0400
Received: from thunk.org ([69.25.196.29]:6047 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932585AbWHCRRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:17:43 -0400
Date: Thu, 3 Aug 2006 13:17:31 -0400
From: Theodore Tso <tytso@mit.edu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net, mchan@broadcom.com
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060803171731.GE20603@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Daniel Walker <dwalker@mvista.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, mchan@broadcom.com
References: <20060803075704.GC27835@thunk.org> <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au> <20060803163204.GB20603@thunk.org> <1154623598.19547.52.camel@c-67-188-28-158.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154623598.19547.52.camel@c-67-188-28-158.hsd1.ca.comcast.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 09:46:37AM -0700, Daniel Walker wrote:
> There is some form of priority inheritance on the timer softirq. It said
> in the patch header that the right fix was for the timer softirq to
> change priorities. Which Real Time patch are you using? Or is the
> current system not sufficient ?

We're using a someone older version of the CONFIG_PREEMPT_RT patches
(2.6.16-rt22, with various bug fixes pulled up to what we are
running.)

There is priority inheritance on the hrtimers, but not on normal
timers, and conversations with Thomas and Stephen at OLS indicated
this is on the wishlist, but it has not happened yet.  As I mentioned
in the patch comments, I looked at hacking hrtimers into the tg3
driver code, but (a) the hrtimers code assume that the priority
inheritance happens when a process is associated with the hrtimer and
the process is a high priority process, and (b) the hrtimers code
aren't exported for use by modules.  So I went with a very quick hack,
since we have a hard code freeze for a customer deliverable.

In the long term, we're going to need something a bit more
sophisticated than what we have in the hrtimers code, since not all
code which requests timers are necessarily associated with a process.
The tg3_timer() code, for example, is trigger by the device driver but
isn't associated with a process for boosting purposes, and creating a
process just so that tg3_timer() can be boosted seems like the Wrong
Thing.    

In addition, the timer wheel code has a *large* number of timers that
get added and then removed without ever getting expired by the TCP
networking code, and I'm not at all convinced that the technique used
for doing prio boosting for the hrtimers will scale to what is needed
for normal timers.

						- Ted




