Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUBOBB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 20:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUBOBB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 20:01:56 -0500
Received: from mail.shareable.org ([81.29.64.88]:29571 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263742AbUBOBBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 20:01:52 -0500
Date: Sun, 15 Feb 2004 01:01:50 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Eduard Bloch <edi@gmx.de>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040215010150.GA3611@mail.shareable.org>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <20040213032305.GH25499@mail.shareable.org> <20040214150934.GA5023@zombie.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040214150934.GA5023@zombie.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch wrote:
> > If I create a file using a shell command, what I get depends on which
> > terminal I used to create it.  If I am using a terminal which displays
> > UTF-8 but ssh to another machine, the other machine assumes the
> > terminal is displaying iso-8859-1 even though the other machine's
> > default locale is UTF-8.  And so on.
> 
> Then you have something wrong in the shell configuration of the remote
> machine. I do not see any problems in having a ssh shell opened from a
> UTF-8 terminal to a machine where the shell environment is also
> configured to use UTF-8 environment.

Of course that's fine.  What goes wrong is when you connect to that
same machine from another terminal which is not UTF-8.

There are in fact two different problems, and you have ignored them both :)

Firstly, "ls", editors, filenames:

   The shell configuration is irrelevant.  If I create a file name
   like "£100.txt" (that's POUND followed by "100.txt") when I'm
   connected from a UTF-8 terminal, it creates a filename encoded in
   UTF-8 and displays it fine.

   If I then log in to the same machine from another terminal which
   displays latin1, then "ls" will _not_ display the name correctly
   _regardless_ of shell or locale configuration.

   If I then create a file called "£100.txt" (same name) using the
   terminal which displays latin1, it creates a filename encoded in
   latin1.

   When I log in using the UTF-8 terminal, "ls" won't display the
   second name as it was entered.  Neither will GNOME or KDE.

   Unfortunately, to be compatible with shell utilities, programs like
   Mutt and Emacs which _are_ aware of the display and input encodings
   will use the current terminal's encoding when accessing the
   filesystem.  So even those programs create file names with the
   wrong encoding, if you log in from the wrong kind of terminal.

   When I open a file in Emacs, and the file contains UTF-8, that
   displays just fine on either kind of terminal (provided the terminal
   can display the characters).  But Emacs, and many other programs,
   will display the wrong file _names_ when logged in from the wrong
   kind of terminal.


Secondly, message locale and the shell:

   There is no mechanism for SSH to convey which character encoding
   the remote machine must use for displaying and inputting text, yet
   client terminals come in different flavours.  That is the problem.

   (On my laptop, for example, which is a standard RH9, Gnome terminal
   windows are UTF-8 but console is latin1).  These are both fine
   locally.  There is no configuration on a remote machine which is right
   for both of them, though.)

   I think this is because the character encoding used by the terminal
   should be in the TERM environment variable, but it is in LANG instead.

> The only problem that may appear if you deliberatedly configured the
> user environment on the other side for latin1, then you would have to
> fix it in some way. Eg. configuring LANG depending on SSH* variables in
> .bashrc.

No.  If I have a plain shell with no configuration at all, then
both charset-aware programs like Mutt and Emacs, and
non-charset-aware code like filename display from "ls" do _not_
automatically display filenames properly on both kinds of client
terminal.

In the former case it is because SSH does not automatically convey
the appropriate setting for LANG, which (rather dubiously) includes
whether to use UTF-8 for display.

In the latter case, "ls" and such, there is nothing SSH can do.

(And that's what makes this relevant to linux-kernel - "ls" has no
way to display names correctly on both terminal types precisely
because it does not have any information about the character
encoding of the filenames returned by readdir()).

The result of all this is that everything works fine as long as you
only log in from the kind of terminal which matches the remote machine.

Unfortunately, while the modern GUIs all use UTF-8 (this is a good
thing in the long run), both the default Linux console, and most
non-Linux terminals, do not use UTF-8.

Therefore file names are generally created and displayed in UTF-8 when
using any of the modern GUIs, including GUI terminals, but file names
are generally created and displayed in a locale-specific encoding
(usually iso-8859-1) when using any console, external terminal, or ssh
from an older client.


Btw, as a practical matter, it took me about a year before I figured
out how to enter a "£" (POUND) symbol into a message being edited with
Mutt and Emacs on a remote server.  Until I learned to explicitly set
"LANG=en_GB.utf8" on the remote server when I logged in from GNOME
Terminal (it was a RH9 box which by default set LANG=en_GB, which is
_correct_ for most clients), typing "£" just didn't enter anything.


Third problem (a straightforward Linux bug):

   I just did unicode_start on the console, which turns on UTF-8 for
   that virtual terminal - for display and for keyboard input.

   Then I did unicode_stop.  Guess what: it put the display back in
   iso-8859-1 for that virtual terminal, but the keyboard remained stuck
   in UTF-8 for _all_ virtual terminals.  Once in that state, I had
   difficulty typing the pound sign which appears earlier in this
   message, and in fact I don't know how to restore the console without
   rebooting the client machine.  "reset" doesn't work; using a
   different virtual terminal doesn't work.

-- Jamie
