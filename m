Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbULaT4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbULaT4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 14:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbULaT4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 14:56:06 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:59780 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262149AbULaTzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 14:55:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WxpWlFxhoIsSzZqzfrVEXvE8miiOJoqIWo2ea9TSVB0ag4nfyhIibWnL9Tbm9wijBvFoo21V7aN28Otcu78nxLtM8KhjEIV/hp54KSlQfouDAQW5BFoKy4rQc4re+EWkxo3NaYPpEC+PCAa0EfM5+R5DPlDDQbuRSbq2S3CpRFw=
Message-ID: <530468570412311155738390de@mail.gmail.com>
Date: Fri, 31 Dec 2004 12:55:52 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Davide Libenzi <davidel@xmailserver.org>, Andi Kleen <ak@muc.de>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0412310921050.2280@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
	 <53046857041230112742acccbe@mail.gmail.com>
	 <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
	 <m1mzvvjs3k.fsf@muc.de>
	 <Pine.LNX.4.58.0412301628580.2280@ppc970.osdl.org>
	 <20041231123538.GA18209@muc.de>
	 <Pine.LNX.4.58.0412310654280.10484@bigblue.dev.mdolabs.com>
	 <Pine.LNX.4.58.0412310921050.2280@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004 09:30:04 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Fri, 31 Dec 2004, Davide Libenzi wrote:
> >
> > I don't think that the Wine problem resolution is due to the POPF
> > instruction handling. Basically Linus patch does a nice cleanup plus POPF
> > handling, so maybe the patch can be split.
> 
> The popf part is very nice in that it allows you to single-step and debug
> this thing.
> 
> The fact is, I can't debug Wine. The code-base is just too alien for me,
> so to debug this thing I needed to come up with a silly example of TF
> usage, and try to debug _that_ instead as if it were something unknown (ie
> debugging by knowing what the program does is a no-no, since that would
> have defeated the whole exercise).
> 
> And handlign "popf" correctly really was the only sane way to debug it,
> anything else would never have worked in a real-life debugging situation.
> It's easy enough to say "well, just do it by hand", but that's not
> practical when you debug with "si 1000" to try to pinpoint the behaviour a
> bit.
> 
> And clearly my debuggability exercise seem to have worked, since the end
> result apparently ended up doing the right thing for Wine.


I honestly think there may have been no other way.  There was a reason
why I was very vague at first.  I could not pin-point an exact
location of failure.  Just grepping a good log shows over 500,000
calls to RaiseException.  trap_handler ran over 300,000 times and as
many TF clears.  My brother told me to set watches or break points to
see if I could find something wrong, but I simply told him there is
too much going on.  The only thing I could think that can be done is
to mentally find debugging scenarios and hope to find where it could
be breaking.  But the only people that could have thought of a
scenario are people that know linux well enough what the kernel is
doing in the first place.



> 
> This is why debuggability is important. I realize that people may think
> I'm inconsistent (since I abhor kernel debuggers), but while _I_ abhor
> debuggers, I also think that the primary objective of an operating system
> is to make easy things easy, and hard things possible, so while I don't
> much like debuggers, I consider it a fundamental failure if the kernel
> doesn't have proper support for them.


I think that copy protection routines are particually nasty.  They
purposely make debugging hard (again see above, no sane program would
be like that).   And the program's reason for failing is not the
reason at all -- "please insert disc" -- the disc is already in there!
 So they don't say the real reason why it failed, leaving the user
totally hopelessly lost on what they should do.  It's really hard to
file a bug report on that alone!  Had I not placed my guess on ptrace
early on, this problem may have gone undiscovered for a long time.  I
have checked transgaming and they seem to be not aware about this, but
it would have been a rude awakening for them when they find that when
most distros had updated to 2.6.9, that all the SecuRom protected
games silently broke, and they would have had a heck of a time
debugging them to find the reason, I'm sure, even with the specs on
it!  Though who knows if cedega is affected because their code-base is
diverging, and I'm sure their copy protection support is very
different.


> 
> So I think it's worth splitting out the "popf" part of the patch, but even
> if that one doesn't actually matter for Warcraft, I'd put it in just so
> that we have a state where we're _supposed_ to be able to debug things
> with TF in them. Just having the mental expectation that things like that
> should work is important - otherwise we'll eventually end up having some
> other subtle problem with TF handling.
> 
>                         Linus
> 
> 


Sure.  I've tried the game and it doesn't require is_at_popf().  I
thought it did because I thought it was required for handling TF
correctly, but maybe this is another scenario.  I think it's a good
idea to keep it in too.  I actually don't care about debugging the
copy protection, I just want correct behavoir.  If doing all this has
pointed out these other issues too, then it's all well worth it,
because next time it will be /easier/ and we won't have subtle
problems.

Jesse
