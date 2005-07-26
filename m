Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVGZKqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVGZKqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVGZKqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:46:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:61352 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261670AbVGZKqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:46:34 -0400
Subject: Re: Linux tty layer hackery: Heads up and RFC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Underwood <basicmark@yahoo.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20050726095535.95521.qmail@web30308.mail.mud.yahoo.com>
References: <20050726095535.95521.qmail@web30308.mail.mud.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Jul 2005 12:11:31 +0100
Message-Id: <1122376291.2542.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-07-26 at 10:55 +0100, Mark Underwood wrote:
> What my driver would like to do is to handle its own
> input buffers. It would pass the buffer to the tty
> layer when it is full and the tty layer would pass the

In theory you can do that already, although the locking is a bit screwed
up for it. Actually all the tty locking is broken for rx I believe.
Everyone should be holding the tty read lock when updating flip buffers
but right now we don't

> buffer back once it has drained the data from it.
> The problem is that I don't always receive a block
> worth of characters so I also need to pass the tty
> layer a buffer (which I'm still DMAing into) with a
> count of how many chars there are in the buffer and a
> offset of where to start from.

You can do this now providing you don't do it blindly from IRQ context.

>From a workqueue do

	struct tty_ldisc *ld = tty_ldisc_ref(tty);
	int space;

	if(ld == NULL)	/* Bin/defer */
		return;
	space = ld->receive_room(tty);
	if(count > space) count = space;

	ld->receive_buf(tty, charbuf, flagbuf, count);


There is a corner case if TTY_DONT_FLIP is set where you should queue
but not all drivers do this and the DONT_FLIP hack 'has to die' 

