Return-Path: <linux-kernel-owner+w=401wt.eu-S964910AbXABS2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbXABS2b (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbXABS2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:28:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39835 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964910AbXABS2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:28:30 -0500
Date: Tue, 2 Jan 2007 18:38:29 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       p.hardwick@option.com
Subject: Re: tty->low_latency + irq context
Message-ID: <20070102183829.10d861fc@localhost.localdomain>
In-Reply-To: <1167758231.5616.22.camel@basalt>
References: <45906820.10805@gmail.com>
	<1167758231.5616.22.camel@basalt>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with tty->low_latency set, but it doesn't AFAICS. One possibility for
> deadlock is if the tty->buf.lock spinlock is taken on behalf of a user
> process...

The case to watch out for is

	flip_buffer_push -> ldisc -> driver write of echo/^S/^Q

if you call flip_buffer_push while holding your own lock you may get in
a mess on the echo path.
 
>       * data is received, enough to completely fill the tty buffer
>       * tty_flip_buffer_push() schedules flush_to_ldisc()
>       * before flush_to_ldisc() runs, more data is received
>       * flush_to_ldisc() truncates the incoming data (look for
>         tty->receive_room)
> 
> I don't see how this is supposed to work in general.

For non fake tty hardware at real speeds it wasn't a problem under about
1Mbit. Current tty layer code just uses memory buffering based on kmalloc
and has a 64K limit instead. Works better SMP, scales better and we no
longer need to do stunts like the flip buffers to scrape 56Kbit on a
386SX16

Alan
