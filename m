Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVCPNIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVCPNIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 08:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVCPNIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 08:08:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27372 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262569AbVCPNIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 08:08:00 -0500
Date: Wed, 16 Mar 2005 13:07:59 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CON_BOOT
Message-ID: <20050316130759.GL21986@parcelfarce.linux.theplanet.co.uk>
References: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk> <20050315143711.4ae21d88.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315143711.4ae21d88.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 02:37:11PM -0800, Andrew Morton wrote:
> Matthew Wilcox <matthew@wil.cx> wrote:
> >
> > +	if (console_drivers && (console_drivers->flags & CON_BOOT)) {
> > +		unregister_console(console_drivers);
> > +		console->flags &= ~CON_PRINTBUFFER;
> > +	}
> > +
> 
> Should we support more than a single CON_BOOT-labelled driver?

I want to say yes.  But there's a can o' worms lurking under the surface.
Our goal is to get output from as early as possible, then have the real
console driver take over from the (boot|early) console in a completely
transparent way.

With just one console, this is straightforward.  The BOOT console gets
unregistered, the replacement console gets its PRINTBUFFER flag cleared,
everybody's happy.

With two (or more) consoles, it's a bit more tricky.  If there's only one
BOOT console and the corresponding real console gets registered first,
its PRINTBUFFER flag is cleared and it continues, then the second console
kicks in and doesn't get its PRINTBUFFER flag cleared.  Everything looks
pretty, we're all happy.  If the wrong console gets registered first,
we miss the start of the log on it, and the BOOT console gets the start
of the log printed twice.

If we allow two BOOT consoles, we guarantee that one of the consoles
will get double-printing, but neither will miss the start of the log.

To handle this properly, we'd have to be able to see which BOOT console
corresponds to the real console and deregister it.  I think it's doable
if we do something like:

 - Add an int (*takeover)(struct console *); to struct console
 - Replace the hunk above with:

	for (existing = console_drivers; existing; existing = existing->next) {
		if (existing->takeover && existing->takeover(console)) {
			unregister_console(existing);
			console->flags &= ~CON_PRINTBUFFER;
		}
	}

That puts the onus on the early console to be able to figure out
whether a registering console is its replacement or not; for the x86_64
early_printk, that'd be as simple as comparing the ->name against "ttyS"
or "tty".  It'll be a bit more tricky for PA-RISC, but would solve some
messiness that we could potentially have.  I think that's doable; want
me to try it?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
