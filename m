Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155272AbPFXCug>; Wed, 23 Jun 1999 22:50:36 -0400
Received: by vger.rutgers.edu id <S154914AbPFXCuX>; Wed, 23 Jun 1999 22:50:23 -0400
Received: from TED-W20.MIT.EDU ([18.70.0.166]:1748 "EHLO rsts-11.mit.edu") by vger.rutgers.edu with ESMTP id <S155240AbPFXCsx>; Wed, 23 Jun 1999 22:48:53 -0400
Date: Wed, 23 Jun 1999 22:48:27 -0400
Message-Id: <199906240248.WAA00879@rsts-11.mit.edu>
To: reiser@ceic.com
CC: reiser@ceic.com, wanderer@everywhere.net, torvalds@transmeta.com, jra@sgi.com, loic@ceic.com, reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
In-reply-to: <14192.49482.80569.440612@reiser.ceic.com> (message from Hans Reiser on Wed, 23 Jun 1999 13:39:16 +0000 (/etc/localtime))
Subject: Re: File systems are semantically impoverished compared to database and keyword systems: it is time to change!
From: tytso@mit.edu
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
References: <m10vnlI-003VuJC@reiser> <7kjbnb$glk$1@palladium.transmeta.com> <376E4201.595AD974@everywhere.net> <14190.26197.402660.718388@reiser.ceic.com> <199906221636.MAA00797@rsts-11.mit.edu> <14192.49482.80569.440612@reiser.ceic.com>
Sender: owner-linux-kernel@vger.rutgers.edu


So, here's a quick back-of-the-envelope design for a completely
user-space solution for folks who have been asking for multi-fork files.
It's not intended to be a completely polished design, but I believe it's
worth at least considering before rushing off and deciding that the only
way to do things is to extend Linux's filesystem semantics.

I write this up this because people have accused me of just being a
conservative "Dr. No" who always thinks their great new ideas are always
bad.  On the contrary, if application writers (especially office suite
application writers) are demanding certain sets of functionality, we
should take such requests seriously, and weigh the costs and benefits of
what they ask for.  It's just that I very strongly believe in trying to
offer a user-space solution first before resorting to making in-kernel
solutions.  Especially if they are hacks that will only work on Linux
systems!  (Using one's OS market share as a club against
interoperability is a despicable Microsoft tactic, and not one I want to
encourage.)


Requirements analysis
=====================

So, let's try this as an exercise.  Since no one has actually bothered
to write down a list of requirements before galloping off to a solution,
let me try to offer some:

1) "Common" file manipulations operations should treat an "application
logical bundle of data" (albod) as if it were a single file.  (Forgive
me for inventing a new acronym here, but "application logical bundle of
data" is too long to type each time, and I don't want to bias people's
thinking about how it is actually implemented.)

2) Applications should be able to quickly and efficiently manipulate
(read, modify, replace, delete, etc.) individual streams of data within
an albod.  This should be done without the file bloat and inefficiencies
found in MS Office 97 format files.

3) There should be standard file streams inside the albod whose
semantics and data format are standardized, so that programs such as
graphical file managers can determine basic information about an albod,
such as which icon to use, who created it, which application should be
invoked when the albod is activated, etc. quickly and easily.  (Using
file(1) on a data file to determine which application can interpret it
is considered barbaric.)

4) It should be easy to send these albod's across standard Internet
protocols using standard, commonly available tools (ftp, http, rcp, scp,
etc.).

Am I missing any other requirements?


Other solutions
===============

Now then, which approaches have been used to address this problem in the
past?  In the NTFS and the Macintosh, this was done by adding
specialized (but non-standard) semantics and new formats in the
filesystem.  This satisfied the first three requirements, but failed on
the last.

The NeXT used a directory containing individual files, which satisfied
requirements #2 and #3, but didn't satisfy #1 (except if you only used
their graphical file manager) and #4 (unless you explicitly tar'ed stuff
up first).

My proposed straw-man proposal
==============================

I now offer to you a design for a potential solution which is purely
implemented in userspace, and has the advantage that it will work across
all existing filesystems, include NFS, AFS, Coda, ext2, and doesn't
require any linux-specific kernel hacks (which is important, since last
time I checked, the GNOME and KDE folks weren't interested in solutions
that only worked on Linux).  The solution is a directory-based solution,
like NeXT, but tries to address the rest of the requirements.

First of all, we need some way of distinguishing an "albod" from a
normal directory.  This can either be done using a filesystem specific
flag, which is probably more efficient, but we would also like a
filesystem independent way of doing this.  So instead of (or perhaps in
addition to) using a filesystem-provided flag, let's posit a magic
dotfile in the directory which, if present, marks it has an albod
bundle.

Now let's assume that we have a hacked libc (or a system-wide
LD_PRELOAD) which intercepts the open system call.  If an application
does not declare itself (via some API call) to be albod knowledgeable,
an attempt to open and read the albod results in the user-mode library
emulation of open()/read() to return a tar-file-like flat-file
representation of the albod.  This allows cp, ftp, httpd, mimeencode,
etc. to be able to treat an albod as if it were a single "bag of bits".

If the application declares itself to be albod-aware, it can then treat
the albod as a directory hierarchy, and manipulate the various
subcomponents of the albod as named streams, just like NTFS5 allows ---
except that we can have hierarchical named streams, and not just a flat
namespace! 

How are albod's written?  Well, an albod-aware application simply writes
the appropriate component directories and files as if they were normal
Unix files (which in fact, they are).  If an non-albod-aware application
such as /bin/cp writes it, there are two design choices.  It's not clear
which one is better, so let me outline both of them.  One is to have the
user-mode library notice that it is a albod flat-file representation by
looking at its header, and then automatically unpacking it into its
directory format as it is writing it out.

The other design choice is to simply allow the albod to be written out
as a flat file, and when an albod-aware application tries to modify it,
only then does the albod-flat-file-package get exploded into its
directory-based form.  If the flat-file format is compressed (which
would be a great idea since applications would now get compression for
free) then only expanding an albod when it is necessary to read it will
save disk space for albod's which are only getting access occasionally
in read-only fashion.  


Problems with this approach
===========================

What are the downsides of this approach?  Since by default, a
non-albod-aware application gets the entire packaged albod as a single
flat-byte-stream representation, /bin/cp, etc. work fine.  This is great
if the albod contains some new application data format, such as a Word
or an Excel or a Powerpoint competitor, since the actual application
code which manipulates the application document is albod-aware.

However, if the albod contains a .gif, .mp3, etc. file, where the
already-existing applications that know how to process the .gif or .mp3
file aren't albod-aware (think: xv), then having open() return a
flat-file contents of the entire albod is the wrong behavior.  Instead,
you want to return the default data-fork contents in that case.  So what
we can do is to have a second magic .dotfile or flag which indicates
that for this albod, when it is opened and read, the default data file
should be returned instead of a flat-file representation of the albod.
The tradeoff for using this optional mode is that a naive /bin/cp or
Midnight Commander program which doesn't know about albod files won't
know how to copy or move the entire albod.  So an attempt to ftp or mail
this alternate form of the albod will just result in the data fork being
sent.  But if all of the application-specific data (i.e., the .gif or
the .au data) is in the default data fork, losing the other metadata
format might not be a disaster, and so this might be the approprach
tradeoff.  It depends on what extra metadata extensions GNOME or KDE
wants to store in the albod alongside the .gif or .mp3 data.


The other downside with this solution is that it is admittedly pretty
complex, and there are some subtle issues about how the LD_PRELOAD or
hacked libc routines should actually work in practice.  Some might even
say that it is a kludge.

On the other hand, is it really that much worse than having kernel-mode
"reparse points" that manipulaes application specific data in the
kernel?!?  I would argue that in contrast, having user-mode library
hacks may actually cleaner, although admittedly both solutions aren't
exactly pretty.   Perhaps someone can come up with a yet more cleaner
solution.   I hope so!!


Summary
=======

This is obviously not a fully fleshed out design proposal.  There are
obviously lots and lots of details that would need to be filled in
first, before this could be used as a set of functional specs which an
implementor could implement.  I won't even claim that this is the best
way to meet the stated requirements solely in user space.  Someone may
come up with a more clever user-space-only solution.

Rather, this was intended to serve as some food for thought, and a proof
by example there is a way to do this in user-mode, without requiring
Linux-specific filesystem hacks and extensions.  While it requires some
extra extensions to the libc, which might be considered kludgy, I
believe it is no worse than the Microsoft NTFS-style "reparse points"
suggestion which was offered to the kernel list in the last day or so.

							- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
