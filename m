Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVBPEF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVBPEF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 23:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVBPEF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 23:05:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:54456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261976AbVBPEFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 23:05:09 -0500
Date: Tue, 15 Feb 2005 20:05:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
In-Reply-To: <Pine.LNX.4.61.0502160405410.15339@scrub.home>
Message-ID: <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
 <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
 <Pine.LNX.4.61.0502160405410.15339@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Feb 2005, Roman Zippel wrote:
> 
> The patch below seems to do the trick too.
> It seems the initial receive_room() call in pty_write() returns 
> N_TTY_BUF_SIZE and receive_buf() will happily drop the last byte.

Why have that "tty->icanon && !tty->canon_data" test in the first place, I 
wonder?  Isn't the "left" calculation always correct? That's really how 
many bytes free we have in the tty, that "canon_data" thing is just about 
how much of it is available for _reading_ as canon, no? (Ie "how many 
characters that have seen a finishing end-of-line"). So I don't see why 
that canon_data test is relevant to the question of filling the buffer.. 

In particular, afaikt, "canon_data" can be zero even if we _have_ 
characters in the queue (just not aany EOLN), so I'd expect your version 
to still return "N_TTY_BUF_SIZE-1" even though the queue can only actually 
take fewer characters..

So I'd still worry whether that added -1 actually fixes the bug, or just 
means that a off-by-one has to now be off-by-two to be noticeable.. (In 
contrast, changing the chunking to 2kB not only changes a "off-by-one" to 
a "off-by-2048", but more importantly is what we've tested for the last 
decade or so ;)

In fact, I _think_ that the whole 

	if (tty->icanon && !tty->canon_data)

test is about the fact that we _want_ the writer to start dropping 
characters at some point, since if we're in canon mode, we need to get a 
full line in the end, and if there is no EOLN to be had, then we _need_ to 
drop characters.

So I'd think that the n_tty_receive_room() function should look something 
like this:

	static int n_tty_receive_room(struct tty_struct *tty)
	{
		int left = N_TTY_BUF_SIZE - tty->read_cnt - 1;

		if (left <= 0)
			left = tty->icanon && !tty->canon_data;
		return left;
	}

which basically says: only accept as much data as we can fit in the
buffer, BUT if we can't really fit anything and we're in canon mode (but
haven't seen a newline yet), we need to allow the writer to continut to
trickle data (that we will discard) in the hopes of _eventually_ seeing an
EOLN.

Does that make sense to you? Maybe the "input full, but no canon_data" 
special case would be better handled in the read path, rather than the 
write path?

		Linus
