Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUHJO2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUHJO2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUHJO2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:28:39 -0400
Received: from digitalimplant.org ([64.62.235.95]:51076 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S265124AbUHJO2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:28:34 -0400
Date: Tue, 10 Aug 2004 07:28:26 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <20040810100751.GC9034@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.50.0408100700460.13807-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
 <1092098425.14102.69.camel@gaston> <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
 <20040810100751.GC9034@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, Pavel Machek wrote:

> Can you explain why this class-based quiescing is good idea? It seems
> to me that "quiesce this tree" is pretty much same as "suspend this
> tree", and can be handled in the same way.
>
> Nigel wanted to do class-based quiescing, but if we make quiescing
> fast enough, it should be okay to do whole tree, always. (And I
> believe quiescing *can* be fast enough).

It has nothing to do with speed and everything to do with domains of
responsibility. Each device belongs to 1 device class.  That class and the
assoicated class device represent the functional interface(s) to the
physical device. While the physical device controls physical attributes,
like actual I/O and power states, the class controls the logical
interface.

When we quiesce/stop a device, we need to make sure that the device is
going to either finish or cancel its current I/O transactions. If we do
that at a hardware, the higher levels may think the device has gone awry
and completely disable it. If we do it at a higher level, we can make
sure that the request is gracefully delayed. We can also make sure that
there are no new connnections to the device in a saner manner (by simply
removing the class device from the list of advertised interfaces), rather
than adding logic to every low-level driver to stop/restart I/O.

Plus, and not that I'm a feature-monger, the code is useful in other
cases. To throw a buzzword, it's the same as effectively 'taking the
device offline', since it implies the hardware is claimed by a driver but
not accepting connections and effectively idle.

AFAICT, it should also provide a necessary piece of infrastructure for
some upcoming resource management patches (from Adam Belay) that rely on
userspace being able to disable/enable a device, change its resources, and
restart it (ideally with transparency).

And, if it turns out to be too hard, then we can rethink it and start
over. :)


	Pat
