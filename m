Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUIPRmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUIPRmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268581AbUIPRlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:41:08 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:21361 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268297AbUIPRiO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:38:14 -0400
Subject: Re: PATCH: tty drivers take two
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916164550.GA20766@devserv.devel.redhat.com>
References: <20040916143057.GA15163@devserv.devel.redhat.com>
	 <1095347152.2006.17.camel@deimos.microgate.com>
	 <20040916164550.GA20766@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095356269.2772.22.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Sep 2004 12:37:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 11:45, Alan Cox wrote:
> I was looking at that but some of them do the wakeup before and
> some after and I've not had time to figure out if the order ever
> matters

I don't see the order mattering as far as breaking things,
but might matter a little for performance.
(depending on the particular ldisc implementation)

wake_up_interruptible(&tty->write_wait) should
come after the ldisc write_wakeup (as is done in tty_io.c)
so that send data buffered by the ldisc
can be sent to the driver before trying to process
more send data from a sleeping user context.

The various serial drivers make the two calls for
the same reason: the driver has become capable of
accepting more data. That the drivers make the
calls in different order points back to the
order not mattering for strictly functional purposes.

*BUT*

You made a statement about reworking tty locking
one step at a time, and concentrating on the ldisc
locking first.

In that light, it might be better to factor out the
wake_up_interruptible(&tty->write_wait) calls
after the ldisc locking is complete and integrated.

-- 
Paul Fulghum
paulkf@microgate.com

