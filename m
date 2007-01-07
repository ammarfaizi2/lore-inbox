Return-Path: <linux-kernel-owner+w=401wt.eu-S932614AbXAGRHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbXAGRHJ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 12:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbXAGRHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 12:07:09 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4637 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbXAGRHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 12:07:07 -0500
Date: Sun, 7 Jan 2007 17:06:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-ID: <20070107170656.GC21133@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Tilman Schmidt <tilman@imap.cc>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc> <1168182838.14763.24.camel@shinybook.infradead.org> <20070107153833.GA21133@flint.arm.linux.org.uk> <1168187346.14763.70.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168187346.14763.70.camel@shinybook.infradead.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 12:29:05AM +0800, David Woodhouse wrote:
> On Sun, 2007-01-07 at 15:38 +0000, Russell King wrote:
> > When a text file is stored on disk, there's no way to tell what
> > character set the characters in that file belong to.  As a result,
> > ISO-8859-1 folk assume that all text files are ISO-8859-1 encoded.
> > UTF-8 folk assume all text files are UTF-8 encoded.  This leads to
> > utter confusion.
> 
> Only if you are making different assumptions about the _same_ set of
> files, on the _same_ system. But that would be silly.

$ git log | head -n 1000 | tail -n 200 > o
$ file -i o
o: text/plain; charset=us-ascii
$ git log | head -n 1000 | tail -n 300 > o
$ file -i o
o: text/plain; charset=us-ascii
$ git log | head -n 1000 | tail -n 400 > o
$ file -i o
o: text/plain; charset=utf-8

(and you know what charset the file is thought to have with all 1000
lines in it.)

All on a system with LANG set to en_GB (iow ISO-8859-1).

> > To see what I mean, try the following:
> > 
> > $ git log | head -n 1000 > o
> > $ file -i o
> > o: text/x-c; charset=iso-8859-1
> > 
> > According to that, the charset of the 'git log' output (which on that
> > test included Leonard's entry) is iso-8859-1, and by that Linus' mailer
> > was right to include it as ISO-8859-1.
> 
> Yes. When you stored it on disk, the character set information was lost.

The same thing actually happens when I look at it via:

  $ git log | head -n 1000 | less

but in this case the output is always interpreted by the terminal to be
in its character set.

> If you were running a mixed-charset system then attempting to recreating
> the lost information with heuristics and assumptions is obviously going
> to be problematic.

I'm not - I'm running a pure ISO-8859-1 system:

$ echo $LANG
en_GB
$ locale -k LC_CTYPE | grep charmap
charmap="ISO-8859-1"

> Actually, because UTF-8 allows me to run a system which is purely based
> on a single character set, I get better results when I try the same
> trick:
> 	shinybook /shiny/git/mtd-2.6 $ git log | head -n 1000 > o
> 	shinybook /shiny/git/mtd-2.6 $ file -i o
> 	o: text/plain; charset=utf-8

$ LANG=en_GB.UTF-8 locale -k LC_CTYPE | grep charmap
charmap="UTF-8"
$ LANG=en_GB.UTF-8 git log | head -n 1000 > o
$ LANG=en_GB.UTF-8 file -i o
o: text/x-c; charset=iso-8859-1
$ git version
git version 1.4.4.2

Looks like the output is iso-8859-1 even with UTF-8!

> > In reality, the output from git log contains an ad-hoc collection of
> > character sets making its interpretation under any one character set
> > incorrect.
> 
> No, the contents of the git log ought to be UTF-8, unless people have
> been misusing it. Git stores its text in UTF-8 (by default), and is
> capable of converting to and from legacy character sets on input
> (git-commit) and output (git-log).

Git may store its text internally in UTF-8 (I don't know but I have no
evidence to suggest it does - in fact I have some evidence in this test
that it doesn't care about charsets.)  git log output on a non-UTF-8
system certainly is not in the hosts character set.  For example:

$ LANG=en_GB.UTF-8 git log | head -n 1000 > o
$ LANG=en_GB git log | head -n 1000 > o2
$ diff -u o o2

That includes the UTF-8 encoded part of Leonard name.  It also includes
Rafa? Bilski's name which is non-UTF-8 encoded.

So, in both cases, exactly the same output bytestream was created
independent of the character set _actually_ being used, which both
includes untranslated UTF-8 and non-UTF-8 sequences.

There is obviously no character set translation going on with the output.
So we can add 'git' to my list of charset-broken programs.

Also, since we have recent data in the git repository which is non-UTF-8
as well, it is clear that there is no character set translation going on
at input time either.

Looking at the git-commit script, there appears to be no character set
conversion going on in there either.

So, I think you'll find that the contents of git _is_ an ad-hoc collection
of character sets which people happen to have in use on their machines.

> > So, in short, UTF-8 is all fine and dandy if your _entire_ universe
> > is UTF-8 enabled.  If you're operating in a mixed charset environment
> > it's one bloody big pain in the butt.
> 
> A mixed charset environment was _already_ a pain in the butt, because
> almost nobody got labelling right. It's wrong to blame that on UTF-8.

I'm not talking about a mixed charset environment.  I'm talking about
non-UTF-8 single charset environments being broken by programs which
universally think the universe is UTF-8 only.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
