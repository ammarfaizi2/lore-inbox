Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVBRQdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVBRQdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVBRQcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:32:39 -0500
Received: from thunk.org ([69.25.196.29]:57791 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261402AbVBRQcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:32:24 -0500
Date: Fri, 18 Feb 2005 11:32:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
Message-ID: <20050218163218.GB5839@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <jebramy75q.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org> <je1xbhy3ap.fsf@sykes.suse.de> <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org> <Pine.LNX.4.61.0502160405410.15339@scrub.home> <Pine.LNX.4.58.0502151942530.2383@ppc970.osdl.org> <20050216144203.GB7767@thunk.org> <Pine.LNX.4.58.0502160802510.2383@ppc970.osdl.org> <20050217044444.GA6115@thunk.org> <Pine.LNX.4.58.0502170744160.2383@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502170744160.2383@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 07:45:56AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 16 Feb 2005, Theodore Ts'o wrote:
> > 
> > Yes, but then when the buffer is full, and we return the "we'll take
> > anything" return value, the code that was getting confused with the
> > "incorrect" receive_room value will still be getting confused....
> 
> But that's fine - at that point we're literally _supposed_ to drop 
> characters: we have to, in order to see the EOLN.
> 
> But we're only supposed to drop characters IFF:
>  - the buffer is full
>  - we are in canon mode
>  - we _still_ haven't seen a single EOLN in the whole buffer

Sure, but in that case, if we return "no worries, we have plenty of
memory", then we're opening ourselves up to the memory overrun problem
that was the original issue in the first place.  I suspect that the
underlying problem is that somewhere in the tty layer there is code
that is using receive_room() as permission to simply push that many
characters into the receive queue, instead of using that function as
an hint of how many characters would be profitable to feed into the
line discpline.

						- Ted
