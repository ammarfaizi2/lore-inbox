Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVAXTQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVAXTQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAXTPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:15:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:58263 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261578AbVAXTOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:14:33 -0500
Subject: Re: kernel oops!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, ierdnah <ierdnah@go.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501240935470.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>
	 <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
	 <20050123161512.149cc9de.vsu@altlinux.ru>
	 <Pine.LNX.4.58.0501230956100.4191@ppc970.osdl.org>
	 <1106509705.6154.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501240935470.4191@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106590169.9611.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 18:09:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-24 at 17:58, Linus Torvalds wrote:
> On Mon, 24 Jan 2005, Alan Cox wrote:
> While doing that, I did notice that all the other tty ops do take the 
> kernel lock still - both read() and write() do. I wonder if we should just 
> make poll() consistent, regardless of other issues (obviously, the nicest 
> way to make it consistent would be to remove the kernel lock from the 
> read/write paths, but I assume nobody wants to go through the locking).

The lock is needed for the console at least and for some driver level
bits.

> And I don't think it can be vhangup - that wouldn't clear the
> chars_in_buffer function pointer (it might change it to the 
> n_tty_chars_in_buffer or something by resetting to N_TTY).

True - that would need an ldisc.close and the vhangup no longer does
that.

> So another potential fix is to just make all tty line disciplines always 
> have a valid "chars_in_buffer" pointer. We could even do automatically in 
> "tty_set_operations()", ie just do a

Not really. I'm in n_tty ->chars_in_buffer and the race occurs -> I'm
dead
as I'm already running the wrong chars_in_buffer function on CPU #0 when
CPU #1
comes along and flips ldisc. Holding the right locks matters here. We
also
need both locks holding really for tty/pty pairs because pty_write wants
to
output to the ldisc of the other side. Treating no ldisc as no
characters
seems very sane however and is easy to code up - if the ldisc_get fails
we
can sleep on the ldisc level wait queue then retry. Ugly enough to want
to
hide the contents in tty_io.c but doable. (When I get time - likely to
be 
a couple of weeks if nobody does it first)

Alan

