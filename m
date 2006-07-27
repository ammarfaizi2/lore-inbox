Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWG0GKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWG0GKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 02:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWG0GKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 02:10:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44729
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932518AbWG0GKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 02:10:36 -0400
Date: Wed, 26 Jul 2006 23:10:55 -0700 (PDT)
Message-Id: <20060726.231055.121220029.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060726062817.GA20636@2ka.mipt.ru>
References: <44C66FC9.3050402@redhat.com>
	<20060725.150122.49854414.davem@davemloft.net>
	<20060726062817.GA20636@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Wed, 26 Jul 2006 10:28:17 +0400

> I have not created additional DMA memory allocation methods, like
> Ulrich described in his article, so I handle it inside NAIO which
> has some overhead (I posted get_user_pages() sclability graph some
> time ago).

I've been thinking about this aspect, and I think it's very
interesting.  Let's be clear what the ramifications of this
are first.

Using the terminology of Network Algorithmics, this is an
instance of Principle 2, "Shift computation in time".

Instead of using get_user_pages() at AIO setup, we instead map the
thing to userspace later when the user wants it.  Pinning pages is a
pain because both user and kernel refer to the buffer at the same
time.  We get more flexibility when the user has to map the thing
explicitly.

I want us to think about how a user might want to use this.  What
I anticipate is that users will want to organize a pool of AIO
buffers for themselves using this DMA interface.  So the events
they are truly interested in are of a finer granularity than you
might expect.  They want to know when pieces of a buffer are
available for reuse.

And here is the core dilemma.

If you make the event granularity too coarse, a larger AIO buffer
pool is necessary.  If you make the event granuliary too fine,
event processing begins to dominate, and costs too much.  This is
true even for something as light weight as kevent.
