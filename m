Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273739AbRIXCR3>; Sun, 23 Sep 2001 22:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273741AbRIXCRU>; Sun, 23 Sep 2001 22:17:20 -0400
Received: from fysh.org ([212.47.68.126]:64519 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S273739AbRIXCRJ>;
	Sun, 23 Sep 2001 22:17:09 -0400
From: zefram@fysh.org
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] tty canonical mode: nicer erase behaviour
In-Reply-To: <E15lJDP-0000qe-00@the-village.bc.nu>
Message-Id: <E15lLJL-0003lF-00@bowl.fysh.org>
Date: Mon, 24 Sep 2001 03:17:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>Which is why they have termcap, terminfo, and x keyboard maps. The kernel
>is not there to cover up for usermode programmers inability to get
>things right.

Aha, I believe I now see a substantive difference of opinion.  You argue
that the tty line discipline depends on being configured for the terminal
by usermode code, and that it should remain so, whereas I am proposing
that it adopt a strategy with some additional logic so that it doesn't
require usermode configuration.  Please correct me if this is not a
fair representation of your position.  I'm now going to switch from
correcting inaccurate statements to an attempt to persuade you on this
underlying disagreement.

Most of the tty's control characters are perfectly simple user choices.
The user can sensibly choose to use ^R or ^L to invoke the REPRINT
function, or indeed not to have any such control character, and such
choices can be executed by a very simple invocation of stty.  This kind
of choice is not affected by what terminal the user is using, because the
^R or whatever keystroke is just the same on any terminal.  This kind
of choice extends to the ERASE character, provided that the user is
picking something like the traditional #.  But uniquely among the tty
control characters, the most commonly desired setting for ERASE is not
a particular character, but rather "whatever my backspace key sends".

Theoretically, a user could set up the ERASE key to whatever their
backspace key sends by doing "stty erase $(echotc kd)".  In practice this
doesn't work nearly as well as it should -- it relies on having echotc,
and on the terminfo database being sufficiently complete and accurate
for the current terminal, which is made particularly difficult by things
like the xterm variations previously mentioned.  It is true that this
is principally a usermode problem, and indeed I would like to see the
usermode improvements that would make this a viable solution.

However, this usermode approach, of using terminfo, seems out of
character with the tty canonical mode code.  In every other aspect, it is
terminal-independent.  For output, the only control characters it uses are
^G, ^M, ^J and ^H, which behave the same way on pretty much any terminal.
(Actually, because of this policy of using only terminal-independent
control characters, backspacing past a line wrap doesn't display
correctly on most terminals.)  For input, with the default control
character settings, the only special keys used are Return and Backspace.

When handling the Return key, under default settings, the tty line
discipline accepts both ^M and ^J as indicating the end of the line.
(Actually, internally it translates ^M to ^J.)  This allows for some
variation in terminal behaviour and in translations that might occur
before the input gets to the tty.  The internal translation can be turned
off or modified, but the particular characters that can be accepted are
hardcoded, and the default behaviour is to accept both.

What I propose is that this manner of handling the Return key -- accepting
both possible characters that can result from the key, without requiring
usermode configuration to tell it which one to use -- be extended to the
Backspace key when used for its normal function.  (Obviously the mechanism
is a little different, since the ERASE character is more configurable than
the end-of-line character.)  By doing this, the tty line discipline code
would become fully terminal-independent under its default settings, which
seems a worthwhile goal for a program that is so nearly there already.

I accept that we have here an issue about which reasonable people can
disagree, and so if the disagreement now persists then I don't intend
to pursue it much further in this forum.

-zefram
