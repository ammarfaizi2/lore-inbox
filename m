Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUBVWBz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 17:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUBVWBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 17:01:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56200 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261761AbUBVWBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 17:01:51 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Alex Belits <abelits@phobos.illtel.denver.co.us>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
References: <20040217071448.GA8846@schmorp.de>
	<Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
	<20040217161111.GE8231@schmorp.de>
	<Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
	<20040217164651.GB23499@mail.shareable.org>
	<yw1xr7wtcz0n.fsf@ford.guide>
	<20040217205707.GF24311@mail.shareable.org>
	<Pine.LNX.4.58.0402171402460.23115@sm1420.belits.com>
	<20040217214733.GJ24311@mail.shareable.org>
	<m1vflzjfk5.fsf@ebiederm.dsl.xmission.com>
	<20040222162848.GC25664@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Feb 2004 14:53:09 -0700
In-Reply-To: <20040222162848.GC25664@mail.shareable.org>
Message-ID: <m1ad3akchm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > I guess my question is when do we know the information is going to
> > a terminal so we should translate it?
> 
> When a program is writing to a terminal device, then we know it's
> going to a terminal _or_ to a program which is pretending to be one
> (pseudo-terminal).  Either way, the behaviour should be the same
> 
> The "screen" program can be used to do translation, although it's a
> rather cumbersome way to go about it, and it has other effects which
> are annoying (at least one key is always designated for "screen" commands).

Right.  At this point I am not worried about temporary solutions.  I
want to pin down how things should be implemented.  So the user space
programs can be fixed.  Pardon me while I think aloud to frame the problem.

First it is worth noting that the existing practice is that ttys 
always use the character set encoding of the user.  Even X cut and
paste frequently abuses the iso8859-1 range, and instead uses the
native character set encoding instead of iso8825-1.

Now the work is how to get multiple locales to play nicely with each
other.  utf-8 and unicode are convenient for that as they preserve the
existing assumptions that terminals, filenames, and text files are
all using the same character set encoding, even when multiple locales
are involved.

So within one machine utf-8 solves the multiple locale problem.  The
problem has now moved to interoperability between machines.  Since
multiple machines have different upgrade cycles, and are in different
administrative domains everyone does not move to utf-8 at the same
time.

When we add the assertion that all I/O going through a terminal device
is in the native locale we break 8bit transparency.  This holds true
in some instances when both sides use the same character set encoding,
such as utf8.

There are some mitigating factors to this.  ssh already documents
pseudo tty's as potentially breaking 8 bit transparency.  And
applications that require ttys for stdin/stdout are most likely
interactive.  Interactive programs are either character based, or
broken.

Being an unclean channel for pipes will affect at least XMODEM,
YMODEM, and ZMODEM protocols, and possibly ppp.  These programs
already know how to avoid problem characters and because ascii is a
common subset of most character set encodings the effect should be no
worse than a line that is not 8 bit clean.

ssh at least has explict options to allocate or not allocate a
pseudo-tty so getting an 8 bit clean data path is not a problem with
ssh.

The rule ``All data that passing through a pseudo-tty is in the
character set encoding specified by the locale of the owner of the
tty'' seems both reasonable and no significant change from the current
status quo.


Now how does this get implemented?

On the wire between two machines I recommend passing unicode
characters.  Unicode guarantees no round trip loss for any of it's
member character sets, and it reduces everything to one set of
translation tables.

By convention glibc stores unicode values in wchar_t.  mbrstowc will
convert multibyte strings to internal wide characters, based on the
current locale. wctombs will do the opposite.  So going between
unicode and the character set encoding of the current locale is
straight forward.

How do we convert the applications?

There are only four cases I can think of where we connect to a remote
system with terminal semantics.
1) Directly connected serial terminals.
2) telnetd
3) rshd
4) sshd

To my knowledge all of their protocols just pass through characters
and are neutral.  So changing these feels like a protocol extension,
ouch!  Those are the programs that bridge multiple administrative
domains, and they do deal with pseudo ttys so they are where something
needs to happen, to support different character set encodings on
different machines. 

If everyone just switches over to using utf-8 even the above cases are
fine.  So if there is a reasonable expectation that everyone will
change to using utf-8 in the near future even those programs don't
need to change.

Given the delay in changing protocols I propose 2 simple programs.
sh-utf8 and utf8-tty.  The first runs a command converting stdout and
stderr from utf8 to the current locale, and converting stdin into
utf8.  The second creates a pseudo tty and relays to it's controlling
tty, assuming the controlling tty uses utf8 and it's tty uses the
current locale.

Looking around there already is a TTYConv program that seems to fill
this niche, except you must specify the character set encodings
manually.
http://bedroomlan.dyndns.org/~alexios/coding_ttyconv.html

Comments?


Eric
