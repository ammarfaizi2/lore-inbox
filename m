Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVAXSCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVAXSCB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVAXR7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:59:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:1153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261562AbVAXR6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:58:31 -0500
Date: Mon, 24 Jan 2005 09:58:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Sergey Vlasov <vsu@altlinux.ru>, ierdnah <ierdnah@go.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel oops!
In-Reply-To: <1106509705.6154.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501240935470.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>  <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
  <20050123161512.149cc9de.vsu@altlinux.ru>  <Pine.LNX.4.58.0501230956100.4191@ppc970.osdl.org>
 <1106509705.6154.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 24 Jan 2005, Alan Cox wrote:
> 
> Almost every user of tty_ldisc_ref_* doesn't need to lock two objects and
> the code at that layer has no knowledge of pty/tty pairs.

Hmm.. It looks different to me - almost all users of the xxx_ref_wait() 
that act on pty's _do_ seem to use tty->link->ldisc.*()". The one counter- 
example seems to be pty_set_termios().

But I only did a quick grep in drivers/char, so there might be other users 
out there I didn't even think of.

While doing that, I did notice that all the other tty ops do take the 
kernel lock still - both read() and write() do. I wonder if we should just 
make poll() consistent, regardless of other issues (obviously, the nicest 
way to make it consistent would be to remove the kernel lock from the 
read/write paths, but I assume nobody wants to go through the locking).

> I'm dubious this is the actual bug although vhangup on a pty might
> trigger it I guess.

ierdnah - can you verify whether either of my silly patches seems to have 
made any difference? 

And I don't think it can be vhangup - that wouldn't clear the
chars_in_buffer function pointer (it might change it to the 
n_tty_chars_in_buffer or something by resetting to N_TTY).

I'd assume that it's when the other end is changed to using the
"ppp_[sync_]ldisc", both of which do actually have a NULL
"chars_in_buffer". (Alternatively, maybe "chars_in_buffer" isn't actually
NULL at all - the backtrace might be confused by either some really
strange memory corruption or a tail-call to a NULL function pointer by
some other line discipline thing, although quite frankly I think that 
sounds extremely unlikely).

So another potential fix is to just make all tty line disciplines always 
have a valid "chars_in_buffer" pointer. We could even do automatically in 
"tty_set_operations()", ie just do a

	driver->chars_in_buffer = op->chars_in_buffer ? : default_chars_in_buffer;

(where the default just returns zero) thing or something.

That would even speed up the normal cases (no need to test the pointer for 
NULL).

		Linus



