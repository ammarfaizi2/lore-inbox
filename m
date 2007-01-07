Return-Path: <linux-kernel-owner+w=401wt.eu-S932603AbXAGQ2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbXAGQ2w (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbXAGQ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:28:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55848 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbXAGQ2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:28:51 -0500
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20070107153833.GA21133@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
	 <1168182838.14763.24.camel@shinybook.infradead.org>
	 <20070107153833.GA21133@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jan 2007 00:29:05 +0800
Message-Id: <1168187346.14763.70.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 15:38 +0000, Russell King wrote:
> On Sun, Jan 07, 2007 at 11:13:57PM +0800, David Woodhouse wrote:
> > On Sun, 2007-01-07 at 14:06 +0100, Tilman Schmidt wrote:
> > > Russell King schrieb:
> > > > Welcome to the mess which the UTF-8 charset creates.
> > 
> > Utter bollocks.
> 
> Wrong.  The problem is partly caused by not everything understanding
> multi-byte character encodings, 

No, that's a different problem; not the one you were referring to above.
And it's a problem which is rapidly diminishing, too.

> and text files containing absolutely
> _no_ information about their character encodings.

That's a real problem, yes -- but it was a problem long before UTF-8 was
added to the collection of character sets in use. Even within the UK, we
had to choose between ISO8859-1 and ISO8859-15.

> When a text file is stored on disk, there's no way to tell what
> character set the characters in that file belong to.  As a result,
> ISO-8859-1 folk assume that all text files are ISO-8859-1 encoded.
> UTF-8 folk assume all text files are UTF-8 encoded.  This leads to
> utter confusion.

Only if you are making different assumptions about the _same_ set of
files, on the _same_ system. But that would be silly.

If I suddenly "assume" that my laptop has a Dvorak keyboard layout
despite that blatantly not being true, I'll get the same kind of
confusion. That isn't Dvorak's fault, either.

If, on the other hand, I have one system which is entirely ISO8859-1 and
a separate system which is entirely UTF-8, each of those are _fine_ and
unconfusing. Obviously I have to make sure files are properly labelled
and converted in transport between different systems -- but that's
nothing new.

> To see what I mean, try the following:
> 
> $ git log | head -n 1000 > o
> $ file -i o
> o: text/x-c; charset=iso-8859-1
> 
> According to that, the charset of the 'git log' output (which on that
> test included Leonard's entry) is iso-8859-1, and by that Linus' mailer
> was right to include it as ISO-8859-1.

Yes. When you stored it on disk, the character set information was lost.
If you were running a mixed-charset system then attempting to recreating
the lost information with heuristics and assumptions is obviously going
to be problematic.

Actually, because UTF-8 allows me to run a system which is purely based
on a single character set, I get better results when I try the same
trick:
	shinybook /shiny/git/mtd-2.6 $ git log | head -n 1000 > o
	shinybook /shiny/git/mtd-2.6 $ file -i o
	o: text/plain; charset=utf-8

Again, the problem of labelling isn't at all new to UTF-8. The only
thing that's new with UTF-8 is that it's now actually _practical_ to
have a system which only uses one character set throughout, and which
thus _can_ get its 'guess' right when you don't bother to label
everything.

> In reality, the output from git log contains an ad-hoc collection of
> character sets making its interpretation under any one character set
> incorrect.

No, the contents of the git log ought to be UTF-8, unless people have
been misusing it. Git stores its text in UTF-8 (by default), and is
capable of converting to and from legacy character sets on input
(git-commit) and output (git-log).

(Obviously, that's likely to be lossy if you convert it to any given
legacy character set, because ∀ legacy character set, ∃ characters
within UTF-8 that aren't in that legacy character set.)
 
> > Far from being the cause of the problem, UTF-8 actually offers the
> > chance of a _solution_. Because once the Luddites catch up, it'll
> > largely eliminate the need for using the multitude of legacy character
> > sets and converting between them -- and the problem of mislabelling will
> > fairly much go away.
> 
> In other words, the UTF-8 luddites require the entire Internet to
> upgrade to UTF-8 for UTF-8 to work properly.

Not at all. The problems arise when character set information is lost,
which can happen at any point during the flow of information.

Anything we can do to reduce the likelihood of charset information being
lost is an overall improvement. We already demonstrated an example
(git-log > o; file -i o) of a case where a _consistent_ system gets it
right, while an inconsistent system introduces an error.

If any individual system processes all text in a single character set,
then that system is no longer a likely source of corruption due to
labelling errors. And because UTF-8 fully covers the set of characters
which can be represented in the legacy character sets, it allows us to
deploy systems which do just that.

> I _regularly_ struggle with idiotic programs that assume that the world
> is UTF-8 and nothing else. 

I don't think I've encountered such a program in my distribution of
choice. If I had, I would have filed a bug. Making assumptions about
character sets, outside of the locally-controlled environment, is
invalid. That's been true since the first 8-bit character sets, if not
longer.

> So, in short, UTF-8 is all fine and dandy if your _entire_ universe
> is UTF-8 enabled.  If you're operating in a mixed charset environment
> it's one bloody big pain in the butt.

A mixed charset environment was _already_ a pain in the butt, because
almost nobody got labelling right. It's wrong to blame that on UTF-8.

-- 
dwmw2

