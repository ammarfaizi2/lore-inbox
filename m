Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUAaWwn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 17:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUAaWwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 17:52:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:25254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265171AbUAaWwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 17:52:41 -0500
Date: Sat, 31 Jan 2004 14:52:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: NTPL: waitpid() doesn't return?
In-Reply-To: <20040131211109.GC2160@kiste>
Message-ID: <Pine.LNX.4.58.0401311441490.2033@home.osdl.org>
References: <20040131104606.GA25534@kiste> <Pine.LNX.4.58.0401311052180.2105@home.osdl.org>
 <20040131200050.GA2160@kiste> <Pine.LNX.4.58.0401311223110.2105@home.osdl.org>
 <20040131211109.GC2160@kiste>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 31 Jan 2004, Matthias Urlichs wrote:
>
> So there's definitely something fishy going on here.

Yes. Especially as the actual clone() we're waiting for was this 
one:

31342 clone( <unfinished ...>
31342 <... clone resumed> child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x416dbc18) = 31346

which wasn't the detached one at all. I looked at the wrong clone().

> Besides, bert's test program exhibits exactly the same clone()
> arguments, yet it works ...

[ twilight zone music ]

Anyway. It's interesting to see who gets the SIGCHLD (which is why I 
looked at the wrong clone) - that goes to 31340:

	31346 exit_group(0)                     = ?
	31340 --- SIGCHLD (Child exited) @ 0 (0) ---
	31342 waitpid(31346,  <unfinished ...>

which is just because we send a thread-group signal, so the signal isn't 
actually necessarily directed toward the "real parent".

But the real parent _should_ have been woken up by __wake_up_parent().  
And I don't see why that wouldn't happen.

		Linus
