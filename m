Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318344AbSGYF67>; Thu, 25 Jul 2002 01:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318343AbSGYF67>; Thu, 25 Jul 2002 01:58:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20485 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318344AbSGYF6z>; Thu, 25 Jul 2002 01:58:55 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux-2.5.28
Date: Thu, 25 Jul 2002 06:02:04 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aho48s$2ko$1@penguin.transmeta.com>
References: <20020724170752.A14089@bougret.hpl.hp.com>
X-Trace: palladium.transmeta.com 1027576908 27092 127.0.0.1 (25 Jul 2002 06:01:48 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 25 Jul 2002 06:01:48 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020724170752.A14089@bougret.hpl.hp.com>,
Jean Tourrilhes  <jt@bougret.hpl.hp.com> wrote:
>
>	IrDA is not going to get fixed soon. Over the time I've been
>fixing the IrDA stack, I've slowly fixed some of most dangerous
>locking problems, but fixing the remaining code will involve some
>serious re-work and is unfortunately not just about sprinking a few
>spinlocks there and there.

Actually, the way to emulate cli/sti behaviour is not to "sprinkle"
spinlocks, you can generally do it with _one_ spinlock per subsystem.

So the straightforward way to port away from cli/sti is to add one
spinlock which takes their place for that subsystem, and then get that
lock on entry to subsystem interrupts and timer events, and in all
places where there used to be a cli/sti. 

It gets a bit more complicated partly because you could nest cli/sti,
and you can't nest spinlocks, but on the whole none of it is "rocket
science". 

Of course, doing it _right_ (rather than try to just translate the
semantics of cli/sti fairly directly) can be a lot more work. But even a
straight translation improves on what used to be, since different
subsystems will now be independent, and since it is easier later on to
split the one lock up on a as-needed basis.

			Linus
