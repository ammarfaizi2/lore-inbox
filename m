Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269455AbRHCQTU>; Fri, 3 Aug 2001 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269464AbRHCQTD>; Fri, 3 Aug 2001 12:19:03 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43538 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269455AbRHCQSr>; Fri, 3 Aug 2001 12:18:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Date: Fri, 3 Aug 2001 18:24:13 +0200
X-Mailer: KMail [version 1.2]
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <01080317471707.01827@starship> <20010803165036.C12470@redhat.com>
In-Reply-To: <20010803165036.C12470@redhat.com>
MIME-Version: 1.0
Message-Id: <01080318241309.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 17:50, Stephen C. Tweedie wrote:
> Hi,
>
> On Fri, Aug 03, 2001 at 05:47:17PM +0200, Daniel Phillips wrote:
> > > As far as the fsync semantics are concerned. Yeah, they would be
> > > useful, but only to avoid one directory fsync call that will tell the
> > > kernel _exactly_ what the process wants instead of letting it figure it
> > > out by itself.
> >
> > No, it's not just that.  It's not enough to fsync just the parent, the
> > parent's parent may have been relinked and not comitted.  Also, the
> > kernel has the advantage of the locked chain of dcache entries
> > available to it.
>
> Not necessarily.  If the file has been hard-linked and then the
> original link removed, we don't have a valid dcache entry any more
> (and yes, this is a common construct for some applications --- it is
> often used to work around NFS atomicity problems.)

But in that case, the file was opened using the hard link, then the link
was deleted.  Fine.  The user is trying to tell us it's ok to lose the
linked file.  Whether or not it can be accessed through another path
is irrelevant.

> An MTA using such a construct and expecting fsync to do the right
> thing will *not* work if you follow the dcache chain on fsync as you
> propose here.

OK, this case where the walk to the root should fail is a "duh", and
exposes a corner case SUS didn't cover (at least not in the excerpts
I saw).  But this case is a userland race, the right thing to do is
just stop the walk.  This doesn't detract from the value of doing
the walk in the important case that the chain is intact.

> > We don't need all the paths, and not any specific path, just a path.
>
> Exactly, because fsync makes absolutely no gaurantees about the
> namespace.  So a lost+found path is quite sufficient.

Dunno, I think that's a statement that should be held up for further
scrutiny.

--
Daniel
