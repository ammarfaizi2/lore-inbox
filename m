Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVBOTIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVBOTIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVBOTIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:08:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:32228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261836AbVBOTII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:08:08 -0500
Date: Tue, 15 Feb 2005 11:08:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
In-Reply-To: <jebramy75q.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Feb 2005, Andreas Schwab wrote:
>
> Recent kernel are losing bytes on a pty. 

Great catch.

I think it may be a n_tty line discipline bug, brought on by the fact that
the PTY buffering is now 4kB rather than 2kB. 4kB is also the
N_TTY_BUF_SIZE, and if n_tty has some off-by-one error, that would explain 
it.

Does the problem go away if you change the default value of "chunk" (in 
drivers/char/tty_io.c:do_tty_write) from 4096 to 2048? If so, that means 
that the pty code has _claimed_ to have written 4kB, and only ever wrote 
4kB-1 bytes. That in turn implies that "ldisc.receive_room()" disagrees 
with "ldisc.receive_buf()".

		Linus
