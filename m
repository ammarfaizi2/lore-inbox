Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268526AbRGYAuV>; Tue, 24 Jul 2001 20:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268527AbRGYAuN>; Tue, 24 Jul 2001 20:50:13 -0400
Received: from chmls20.mediaone.net ([24.147.1.156]:32231 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S268526AbRGYAuC>; Tue, 24 Jul 2001 20:50:02 -0400
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Tue, 24 Jul 2001 20:39:53 -0400
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        martizab@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
Message-ID: <20010724203953.C27771@pimlott.ne.mediaone.net>
Mail-Followup-To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>,
	linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
	martizab@libertsurf.fr, rusty@rustcorp.com.au
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr> <20010724090704.A27771@pimlott.ne.mediaone.net> <3B5DACDA.69D0B81A@wanadoo.fr> <20010724150535.B27771@pimlott.ne.mediaone.net> <3B5E0171.A40386CC@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B5E0171.A40386CC@wanadoo.fr>; from jerome.de-vivie@wanadoo.fr on Wed, Jul 25, 2001 at 01:14:57AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

[ This will probably be my last message to include linux lists; tell
me if you want a Cc: ]

On Wed, Jul 25, 2001 at 01:14:57AM +0200, Jerome de Vivie wrote:
> Andrew Pimlott a ecrit :
> > So you're saying if I have a file on my UFL, there's no way anyone
> > else can see it unless I copy it to another filesystem?
> 
> Yes, that's exactly what i want: a working file must be private unless
> the developper as decide to share it . An individual developper is not
> impacted by external changes (like with the "LATEST" rule in clearcase)
> and doesn't interact with other developpers. That's very important in
> SCM !

Of course, there must be isolation, I'm just saying you picked the
wrong level at which to do it.  In ClearCase, I have a view that
only I usually work on, but I can still ask some other developer to
look at the changes I'm making.

> > > > If I have to check in all files at once, it is even more important
> > > > that I be able to have multiple "views".  What if, in the middle of
> > > > a big change, I make a small fix that I want to check in
> > > > independently?
> > >
> > > It's impossible. If you want to go back, you have to put a label on
> > > each step you want and, set the $CONFIGURATION to this label.
> > 
> > Again, this seems exceedingly restrictive.
> 
> Regression is exactly what we try to avoid when we work under SCM. What
> is done is done. If you really want, you can labelize after each write 
> but your must NOT modify the past !

I must not have been clear.  What I'm saying is that your scheme
makes it impossible for one user to have multiple independent
working branches at the same time.  In ClearCase, I can have one
view for my big project that I won't check in (or at least, won't
merge into a common branch) for a month, but another view on which I
make bug fixes that should go quickly into the mainstream.

> Ok, now i am more oriented throw a userspace SCM. Perhaps i will use a
> naming convention a la clearcase (ie: filename@@label ) and, with this
> namespace, you will be able to use all your favourite UNIX tools.

Cool!  Of course, now you have non-standard filesystem semantics; I
don't mind, but I don't know about the VFS guys :-)  BTW, in
ClearCase, it's filename@@/label, and filename@@ is a directory that
you can chdir into (but that doesn't show up in directory listings).

> > I said, compared to CVS, not ClearCase!  The analog in CVS is
> > - cvs checkout
> > - cvs update
> >
> > The only advantages your have are 1) you don't have to specify the
> > repository/modules and 2) you're faster.
> 
> CVS deals with versionning and not configuration management, so you
> can't compare them.

Oh, come on.  "Configuration management" is at most a thin layer
over version control (and at least a fancy term for the same thing).
At least, according to any definition I've ever seen.  What
definition do you use?  Anyway, ClearCase is certainly no more
"configuration management" than CVS.  If you're talking about
"change set" stuff (ie, Rational's "Unified Change Management"),
then compare to "something like CVS, except that works in change
sets".

What specifically is not comparible in my example?  If I had added
"cvs tag", would that be better?

> > Also, you have left out at least one important step.  Say I set
> > CONFIGURATION=A, do my work, and label it with B.  How do other
> > developers know to switch to B?   
> 
> Labels are public and i hope there are meeting organized between
> developpers !

Put it this way:  In your scheme, every checkin implicitly and
automatically creates a branch (right?).  So there is significant
branch management to do, and you haven't given any hints as to how
to do it, which makes me skeptical, especially since branches aren't
first-class objects.  But maybe an example would help me.

Here is another issue: say A and B are labels, and I set
CONFIGURATION=A and change file a.  Now, I set CONFIGURATION=B,
change file b, and try to create a new label.  Presumably this
should fail, but how exactly?  I think this will be hard to do
cleanly at the kernel level.  In order to get reasonably
diagnostics, you'll need user-space tools that can do all the same
logic, which suggests that this should all be user-space to begin
with.

> > If you say your system is not intended for concurrent development, I
> > think it is not worth doing.  And from what I can see, you're
> > building in restrictions that would make concurrent development
> > hard.
> 
> ??????????????????????????
> ? Where have I said this ?
> ??????????????????????????

Of course, you haven't said this, but I think you've created design
limitations that imply it.  Things like views only visible to one
user; one user can have only one view; can't have one command access
multiple versions (fixed with "version-extended" names); and the
branching issue I mentioned; all make it seem unsuitable for
large-scale development.

I hope you can change this impression!

Andrew
