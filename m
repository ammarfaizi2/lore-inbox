Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTFFPBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTFFPBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:01:00 -0400
Received: from almesberger.net ([63.105.73.239]:4361 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261843AbTFFPA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:00:28 -0400
Date: Fri, 6 Jun 2003 12:13:39 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606121339.A3232@almesberger.net>
References: <200306061100.h56B08sG024506@ginger.cmf.nrl.navy.mil> <20030606.040410.54190551.davem@redhat.com> <20030606105753.A3275@almesberger.net> <20030606.070747.48395512.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.070747.48395512.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 07:07:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> If we move over to a more netdevice-based design for ATM,
> this will not longer be acceptable.

Why, what's wrong with that ? It's simple, efficient, and it works.

> Unregister of netdevices is %100 asynchronous, even if references
> remain (and even if the device is UP!), we close then rip the device
> out of the kernel.  As references go away we finally get to zero
> and thus can finally kfree() up the netdevice.

Well, that's similar in a synchronous design. Only that you make
sure that the removal is only attempted from a context that can
sleep. (That's one of the things the demons do. And no, I don't
think you want them in the kernel :-)

> This is a much better model than synchronizing everything, you tie
> your hands when you do it that way and it tends to lead to module
> unload deadlocks.

Hmm, last time I tried to ignore circular dependencies in
ansynchronous designs, they failed just as badly as in
synchronous designs :-)

There are certainly places where a synchronous design doesn't
make sense. But in the case of ATM device and VCC handling, you
already have all the synchronous code paths (because things are
initiated by user space), they're not very timing-critical, and
reuse before destruction has completed is unlikely.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
