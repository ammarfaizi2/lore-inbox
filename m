Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbTLHRjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265498AbTLHRjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:39:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:1771 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265500AbTLHRi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:38:57 -0500
Date: Mon, 8 Dec 2003 09:38:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <br27v2$fdh$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.58.0312080927510.13236@home.osdl.org>
References: <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>
 <br27v2$fdh$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, bill davidsen wrote:

> In article <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>,
> Linus Torvalds  <torvalds@osdl.org> wrote:
> |
> | And you liked the fact that you were supposed to write "dev=0,0,0" or
> | something strange like that? What a piece of crap it was.
>
>   Actually, dev=0,0,0 or dev=/dev/hdc are neither particularly portable;
> each can be something else on another machine. At least /dev/sr0 (or
> scd0 if you go to that church) are a bit less likely to change.

Actually, the sane thing to do is to use "/dev/cdrom", which is likely to
be right, and if it isn't, you can always fix it (and you can fix it
_dynamically_ with something like "udev" - so it will do the right thing
even if your cdrom happens to be hot-pluggable).

The only time that ends up being confusing is if you have multiple CD-roms
(which used to be common - DVD reader and CD writer - but is going away
again on "normal" machines due to combo drives). And then you really
actually care about position, so then you are likely happy to go back to
"/dev/hdc" or "/dev/usb-cdrom" or something like that to specify _which_
CD-RW you're talking about.

>   If I were going to do that at all, I would have used controller, bus,
> device, LUN notation, (0,0,0,0) and been done with it.

Well, even that isn't enough.

What's the format for iSCSI? What's the format for buses that are
hierarchical? The thing is, naming is _hard_, and the only way to name
things in a generic manner is:
 - allow multiple levels (ie not a fixed "always 3/4 levels" format)
 - don't use numbers (part of the name might be a hostname or whatever).

Which means that you have to have names that are (a) hierarchical and (b)
strings as the individual path components.

In addition, you clearly _do_ want to have the "simplified" form (aka
the "just point me to the 'cdrom', dammit!" format). Because quite
frankly, the regular user that doesn't care, doesn't really want to know
how his (single) CD-ROM is connected, and if he has to look it up he'll
have all the right in the world to say "This computer is _stupid_".

And guess what you end up with if you have these requirements? A
filesystem. No, "/dev/cdrom" and "/dev/iscsi/cdrom.work.com/cd5" aren't
the _only_ ways of naming things, but they are clear, and they are
sufficient.

And "0,0,0,0" fails _both_ of these obvious requirements. It's neither
clear _nor_ sufficient.

			Linus
