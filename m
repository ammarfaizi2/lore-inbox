Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbUBPVo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265904AbUBPVo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:44:26 -0500
Received: from mail.shareable.org ([81.29.64.88]:25476 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265899AbUBPVoX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:44:23 -0500
Date: Mon, 16 Feb 2004 21:44:21 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Eduard Bloch <edi@gmx.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040216214421.GA18853@mail.shareable.org>
References: <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de> <20040215010150.GA3611@mail.shareable.org> <20040216140338.GA2927@zombie.inka.de> <20040216142807.GB16658@mail.shareable.org> <20040216192228.GC15087@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040216192228.GC15087@zombie.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch wrote:
> TERM specifies the general capabilities of the terminal. It does
> _not_ tell the application inside which FONT encoding is used, nor
> whether it is compatible with multibyte input.

It should - especially the multibyte encoding.

The font is irrelevant; our trouble here is *character encoding* which
has nothing to do with fonts.  Please don't use the incorrect term as
there is widespread confusion over it already.

That isn't just about which glyph is displayed in response to each
byte.  UTF-8 affects terminal escape sequence parsing, and also the
relationship between number of non-control bytes transmitted and the
distance moved by the cursor.

If I write a UTF-8 string to a VT220-like terminal (such as xterm
approximates), some text characters are interpreted as terminal
commands.  (Hint: 0x9b (which can occur in UTF-8 text) is equivalent
to 0x1c 0x5b, the control sequence introducer; there are others too).

When you edit a line with the unix terminal line editor, when you type
DEL, it writes BACKSPACE-SPACE-BACKSPACE and removes one byte from the
input.  That utterly fails to do the right thing on UTF-8 terminals.
For example, run the command "cat" by itself, then type "£££", then
hit DEL twice - it will show one pound sterling sign.  Press enter,
and cat will echo the line containing _two_ pound sterling signs.

No setting of LANG or TERM makes that behave correctly.

So, do you think the kernel's line editor should be locale-aware too? :)

> > It is wrong that LANG must have a different value depending on whether
> > I log in using a DEC VT100 or a Gnome Terminal, even though I wish to
> > see exactly the same language, dialect, messages, number formats,
> > currency formats, dates and times.

NB: It's wrong because LANG should be for terminal-independent locale
properties, such as which languages I want to use and how I want text
files stored.

If I log into a remote machine, I want characters displayed according
to the local terminal's requirements, but I want text files and
filenames to use the remote machine's locale, naturally.

> Nonsense, sorry. How should your application know how to encode its
> output?

Increasingly I'm thinking UTF-8-ness should be a terminal capability,
like ocrnl.  The kernel's own line editor needs to know this property
anyway, and it would really help with moving filenames and everything
else over to UTF-8 - with no change to the simple unix programs such
as the shell utilities.

> > It is especially wrong that libraries which should be
> > locale-independent - such as curses, slang and readline - must
> > read the LANG variable in addition to TERM.
> 
> See above. Especially since different chars are used to draw graphical
> characters (lines, boxes, ...), they _must_ know which font encoding
> they have to expect.

See "acsc" in the terminfo(5) database.  Line & box drawing characters
have been treated as a terminal capability for a long time.  Case made :)

-- Jamie
