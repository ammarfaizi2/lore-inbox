Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVBIUEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVBIUEM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVBIUEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:04:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:22481 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261908AbVBIUDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:03:43 -0500
Date: Wed, 9 Feb 2005 21:03:30 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Jirka Bohac <jbohac@suse.cz>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       lkml <linux-kernel@vger.kernel.org>, vojtech@suse.cz, roman@augan.com,
       hch@nl.linux.org
Subject: Re: [rfc] keytables - the new keycode->keysym mapping
Message-ID: <20050209200330.GB15005@apps.cwi.nl>
References: <20050209132654.GB8343@dwarf.suse.cz> <20050209152740.GD12100@apps.cwi.nl> <20050209171921.GB11359@dwarf.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050209171921.GB11359@dwarf.suse.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 06:19:21PM +0100, Jirka Bohac wrote:

> There are presently two ways around this, neither of them good enough
> 1) assigning one of the other modifier keysyms to the CapsLock key 
>    -- the LED will not work

True.

> But by adding two modifiers to almost every keyboard map, you would
> increase the space occupied by the keymaps four times. ... erm ... eight
> times, because there is also this "applkey" (application keypad) flag,
> that will be needed as another modifier.

But keymaps are allocated dynamically.
Any number of new modifiers does not cost anything until
one actually uses some particular modifier combination.

New modifiers are not expensive at all.

> - the proposed keyboard map file format is IMHO much much nicer

Keymap files live in user space. The layout of a keymap file
has no bearing on the kernel implementation of keymaps.

We want a map (keystroke,current_modifiers) -> keycode.
The present kernel code organizes things in maps, one for
each modifier combination that people want to use.
You want to organize things per keystroke.

I see no great advantages. Many small arrays allocated
by kmalloc() leads to more overhead - probably your version
would lead to larger memory usage, but I have not checked.
It looks like your code is larger.
It also looks like your code is slower, with a loop instead of
a table lookup.

(Not that those things are very important, but I do not see
significant advantages for your setup. Maybe you have numbers?)

Of more interest are the added features.

You come with a single big patch, but some parts are independent.

For example, I see

+struct kbdiacruc {
+       unsigned char diacr, base;
+       unsigned int result;    /* UCS */
+};

Ten years ago we made the mistake of being too careful with memory.
Today it is a very bad idea to introduce new ioctls that act on
8-bit quantities. These must all be int's.

An ioctl somewhat in this style has been proposed several times,
and I have no serious objections. If you want it, separate it out
and make it a patch on its own.

Andries
