Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUIGPhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUIGPhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUIGPeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:34:23 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:18061 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268206AbUIGPc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:32:26 -0400
Message-Id: <200409071530.i87FUCP1003927@laptop11.inf.utfsm.cl>
To: Spam <spam@tnonline.net>
cc: Christer Weinigel <christer@weinigel.se>,
       David Masover <ninja@slaphack.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4 
In-Reply-To: Message from Spam <spam@tnonline.net> 
   of "Tue, 07 Sep 2004 14:33:46 +0200." <1183150024.20040907143346@tnonline.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 07 Sep 2004 11:30:12 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> said:
> Christer Weinigel <christer@weinigel.se> said:

[...]

> > Could you please try summarize a few of the arguments that you find
> > especially compelling?  This thread has gotten very confused since
> > there are a bunch of different subjects all being intermixed here.

>   Indeed. We are discussion changes to the heart of Linux. It is bound
>   to get a little heated :/

True. But without any specific applications, just "this would be nice to
have", the discussion can't go forward.

> > What are we discussing?

> > 1. Do we want support for named streams?
> 
> >    I belive the answer is yes, since both NTFS and HFS (that's the
> >    MacOS filesystem, isn't it?) supports streams we want Linux to
> >    support this if possible.
> 
> >    Anyone disagreeing?
> 
>      No :)

There are many people around here who disagree (that is precisely the heart
of the discussion). I for one don't think Linux has to get $RANDOM_FEATURE
just because $SOME_OTHER_OS has got it. Either the feature stands on its
own _in the context of POSIX/Unix/Linux_ (possibly as an extension or
modification of said standards) or it isn't worth it.

> > 2. How do we want to expose named streams?
> 
> >    One suggestion is file-as-directory in some form.

Which is broken, as it forbids hard links to files.

It also has quite interesting issues with moving streams around among
containers, or renaming them. How would you handle permissions on streams
inside containers? Links to streams? What happens if the principal stream
is deleted? Renamed? Moved into another container?

Now you have 3 principal types of objects: Directories, containers (files
with streams), and files (no streams). What is the essential difference
between containers and directories? Same for containers vs plain files? If
none, containers are just complicating stuff, and should not exist at all.

If you add streams to directories, you get 4 types. Again, tell what the
exact differences are, and what each one can do none of the others can.

In the preceding two exercises, it is not enough to show something that
would be dificult or messy to do with what we have now, it must also be
some operation(s) that are natural and common enough to warrant the extra
complexity (in kernel, in applications, in wetware). Consider support in
form of existing or to-be-written tools for the task. What of all this can
the GUI hide from (or fake for) the unsuspecting end-user?

Also, there have been suggestions of cached data in streams (like thumbnail
version of graphic file, contents listing of archive, ...), where losing
the stream is of no real consecuence (except performance). There have also
been requests for metadata that can't be recovered from the file (author,
comments on the file, older versions of the file (i.e., some form of file
version control), permissions). And finally there have been requests for
structured contents manipulable in other forms (f.ex. .tar.bz2 file in
unpacked form, where you can directly read or even modify the contents).
Some suggestions go for a limited number of small(ish), even standardized,
extra streams with no further structure, others ask for full directories
under streams (which could even be much larger than the principal stream,
like the tar.bz2 case). And there is the possibility of recursive
application: If you want to be consecuent, the files under a .tar.bz2
should again be able to be .tar.bz2'es with their own streams, or files
with streams in them.

What permissions should apply to streams? The ones of the file (i.e., I can
see the icon stream of a file I can't read), or extra permissions (i.e.,
icon is writable to me (so I can adjust it to taste) but I can't write to
the file; now I can screw up the icon for everybody...). Streams on a
per-user basis (i.e., icon stream for each user)?

We need to sort out exactly how far it makes sense to go, by showing
concrete, down to earth uses for whatever substructure we want. Then show
the effect can't be easily gotten through tools for power users or faking
it for unsuspecting users via GUI, and that overall the complexity and
performance cost is less than the win. Note that the success of the Unix
way is in large part due to its use of few, simple concepts that can be
combined endlessly; and tools following the same strategy. Adding extra
concepts that current tools can't naturally handle has to be considered
with extreme care.

[-- much snippage --]

> > The suggested problems of not getting an up to date query response can
> > be handled by just asking the daemon "are you done with indexing yet".
> > The design of such a daemon and the support it needs from the kernel
> > can definitely be discussed.  But to put the indexer itself in the
> > kernel sounds like a bad idea.  Even adding an API to query the
> > indexer into the kernel sounds pointless, why do that instead of just
> > opening a Unix socket to the indexer and asking it directly?

>   I think that we do not need a indexer with Reiser4 anyway. It is
>   already a database that could be queried directly. There shouldn't
>   be any need to build a database on top of Reiser4 (like the
>   updatedb) that holds the same information already existing in
>   Reiser4.

Indexing/general queries of the filesystem are _hard_ (you need a complete
database behind it for this, plus handling transactions for full
functionality). Applications who _really_ need this use DBMSes, and are
prepared to pay the ensuing cost. They are far in between, in any case.

Besides, this is completely orthogonal to the streams discussion.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
