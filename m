Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVBPOnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVBPOnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVBPOmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:42:36 -0500
Received: from thunk.org ([69.25.196.29]:5522 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262029AbVBPOmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:42:13 -0500
Date: Wed, 16 Feb 2005 09:42:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
Message-ID: <20050216144203.GB7767@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org> <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org> <Pine.LNX.4.61.0502160405410.15339@scrub.home> <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 08:05:05PM -0800, Linus Torvalds wrote:
> Why have that "tty->icanon && !tty->canon_data" test in the first place, I 
> wonder?  Isn't the "left" calculation always correct? That's really how 
> many bytes free we have in the tty, that "canon_data" thing is just about 
> how much of it is available for _reading_ as canon, no? (Ie "how many 
> characters that have seen a finishing end-of-line"). So I don't see why 
> that canon_data test is relevant to the question of filling the buffer..

The comment above the test explains why that test is there in
n_tty_receive_room.  If that test isn't there, and we are doing input
canonicalization, when the buffer gets full, the low-level driver will
either flow control the source (so the ERASE or EOLN characters won't
get sent through) or the low-level driver will drop the characters
(and the line discpline will never see the ERASE or EOLN characters).  

So the idea behind this code was to lie to the low-level driver, so
that the line discpline would always get the characters, and then the
line discpline could process ERASE, WERASE, KILL, or EOL, and drop the
rest on the floor.  At least, that was the basic idea.  Yes, it was a
kludge; no I'm not particularly proud of it.

The whole structure badly needs to be ripped apart and rewritten, but
unfortunately few employers seem to be willing to dedicate their
hackers' time to Do This Right.  Sigh....

						- Ted
