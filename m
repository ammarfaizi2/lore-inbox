Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268316AbUIBReE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268316AbUIBReE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 13:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268749AbUIBReE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 13:34:04 -0400
Received: from mail.shareable.org ([81.29.64.88]:59082 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S268316AbUIBRdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 13:33:39 -0400
Date: Thu, 2 Sep 2004 18:32:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040902173214.GB24932@mail.shareable.org>
References: <20040901200806.GC31934@mail.shareable.org> <200409021407.i82E70hx004899@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409021407.i82E70hx004899@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> >                                               This does _not_ mean tar
> > in the kernel (I know someone who can't read will think that if I
> > don't say it isn't); it does mean hooks in the kernel for maintaining
> > coherency between different views and filesystem support for cacheing.
> 
> "Coherency" and "different views" implies atomic transactions,

Wrong.  They imply ordering.

> and being able to tell that an access to the file requieres updating
> random junk about it.

Correct.

> It requires being able to guess if it is worth updating now
> (given that the file might be modified a dozen times more before the junk
> being checked).

Wrong.  Lazy and deterministic are compatible.

> 
> > The vision I'm going for here is:
> > 
> >   1. OpenOffice and similar programs store compound documents in
> >      standard file formats, such as .tar.gz, compressed XML and such.
> 
> And they are doing fine AFAICS. Besides, they won't exactly jump on the
> possibility of leaving behind all other OSes on which they run to become a
> Linux-only format.

You replied before reading the rest of the mail again, didn't you?
The whole purpose of the idea is to work with formats which are _not_
Linux-only.

> >      Fs support can reduce CPU time handling these sorts of files, as
> >      I explain below, while still working with the standard file formats.
> 
> I don't buy this one. A tar.gz must be uncompressed and unpacked, and
> whatever you could save is surely dwarfed by those costs.

Didn't they explain what "lazy" means in your computer science class?
Google for "lazy evaluation".

In this context it means _unnecessary_ uncomressions and compressions,
i.e. repeated ones, or ones where you never really needed the
compressed form, are eliminated.  Necessary ones are of course done.

Those are things which are currently wasting your CPU because apps
cannot eliminate them: to do so implies synchronisation between
different apps running at different times.  Surprise surprise, that's
something filesystems and kernels are good for.

> >      With appropriate userspace support, programs can be written which
> >      have access to the capabilities on all platforms, but reduced CPU
> >      time occurs only on platforms with the fs support.
> 
> Userspace support isn't there on any of the platforms right now, if ever it
> will be a strange-Linux-installation thing for quite some time to come. Not
> exactly attractive for application writers.

Again, you have a strange vision of what userspace support means.  I
say it means a portable and simple library for accessing components
inside a compressed container file in a standard format.

Something I believe OpenOffice et al. already has - so to say it
doesn't exist is both incorrect and missing the point.  The point is
to change that library which already exists, so it uses the filesystem
facility when available.  And to make the library better in standalone
form, so that other tools which manipulate container-like formats are
inclined to work with it as plugins, instead of creating their own
interface as cli tools.

_At no point is portability an issue_ - that library is already
portable to everything - and it's certainly not a strange-Linux thing
nor meant to become one.


> >   2. Real-time indexing and local search engine tools.
> 
> Sure! Gimme the CPU power and disk throughput for that, pretty please. [No,
> I won't tell I have better use for those right now...]

You still haven't grasped the idea of an algorithm which is more
complex but reduces CPU time and disk throughput, have you?

*Today*, when I open Rhythmbox I have to wait 5 minutes while it wastes
my CPU power and disk throughput scanning all the files in my Music
directory.

The entire point of these indexing schemes is so that programs like
Rhythmbox will display the same data without having to scan the disk
for 5 minutes every time they start up.  That's a near infinite
_saving_ of CPU power and time.

If you don't see that I'm just going to have to suggest you google for
"cache" and learn a bit about them.

> >      This isn't
> >      just things like local Google; it's also your MP3 player scanning
> >      for titles & artists, your email program scanning for subject
> >      lines to display the summary fast, your blog server caching built
> >      pages, your programming environment scanning for tags, and your
> >      file transfer program scanning for shared deltas to reduce bandwidth.
> 
> With no description on how this is supposed to work, this is pure science
> fiction/wet dreams.

Sigh.  If you must continue to hurl your blunt instruments around,
here is a description.  I didn't want to write this becuase it is off
topic, and you insist on not understanding the basic of algorithm
complexity and CPU usage, so you'll probably not understand this
either, but I'll give it a go.

    1. Local Google (by which I mean a search engine on your local machine),
       Real-time (by which I mean the results are always up to date):

       Every file modified since last search is known to the query engine.
       This is a reality: BeOS does it; WinFS is expected to do it.

       We know that it's possible to update free text indexes with
       small amounts of known changes quickly, at the time of a query.

       Thus we have real-time local free text search engine, and other
       features like searching inside files and for file names.  The
       point is the real-time nature of it: the results you get
       correspond to exactly the contents of the filesystem at the time of
       the query (writes which occur _during_ a query are obviously
       not coherent with this, but writes which complete before the
       query, even immediately before, appear in the results).

       Note that file write timing need not be affected - all the work
       can happen during queries (although it is best to have a
       nightly re-index or whatever so that the delay at query times
       is kept moderate).

    2. MP3 player scanning artists & titles:

       Easy.  MP3 player does what it does, shows the extracted ID
       tags from all .mp3 files in your home directory.  They do this
       already!  The difference is that with fs coherency hooks, they
       can _store_ that ID information, retrieve it later without
       having to scan all the .mp3s again (see Rhythmbox earlier), and
       keep their lists updated on the screen as soon as any .mp3 is
       changed or even any new ones created anywhere.

       Technically it's a simpler subset of real-time queries in 1.

    3. Email program scanning for subject lines fast:

       See Evolution; the only difference is stat() on a thousand
       files won't be required, it'll be exposed through a standard
       query instead of an Evolution-only cache method so other mail
       programs may use it as well as shell commands, and you can
       pretend you have mbox instead of maildir (mbox is a container
       format...).

    4. Blog server caching built pages:

       It's a reality already, obviously.  The difference is it'll
       make sense to built the pages through an indexed query on files
       instead of a database, e.g. one file per article, and
       (independent of the first point) the process of building can
       keep track of all the prerequisite files and scripts and
       templates used to produce the page, and actually expect to
       know, _with coherent accuracy_, if any of those prerequisites
       is different the next time the page is needed.

       In other words, complex script-generated web pages, cached
       output, and with no overhead when serving each page to check
       prerequisites (i.e. no 100 stat() calls), because we know the
       filesystem would have told us if any prerequisite had changed
       prior to the moment we begin serving the cached output.

       You can do something close to this already with dnotify (if you
       ignore that it doesn't tell you about new hard links, which is
       a dnotify bug), although doing the query part is unrealistic
       with dnotify and stat() prerequisites unless the directory
       names are structured thoughtfully.

    5. Programming environment scanning for tags:

       By now this should be obvious.  No need to run "exuberant
       ctags" or whatever class-hierarchy-extraction and
       documentation-extraction program every so often after making
       changes, and yet your IDE's clickable list of tags and notes
       stays up to date with file modifications in real time.  I think
       some IDEs do this already with moderate size trees, using
       stat(), but it's not realistic when you have tens of thousands
       of source files.

    6. File transfer program scanning for shared deltas.

       This is nothing more than searching all files for common
       subsequences which match strong hashes which are expected to be
       common during file transfer operations.  E.g. the GPL header at
       the start of many source files would have one such hash.  A
       hash of every whole file is another one, along with the name of
       the file (it is a key which indicates a "likely to match the
       corresponding hash" condition), as is a hash of every aligned
       64k subsequence, or whatever is appropriate to reduce disk I/O.

       Having an index of these can speed up some file transfer
       protocols, in the manner of rsync but comparing among a large
       group of files instead of just two.  The point is that kind of
       protocol can be more efficient than rsync (sometimes
       dramatically so), but it's only a net gain to use that kind of
       algorithm if you have a handy _and reliable_ index of likely
       common subsequences and whole-file hashes, otherwise it uses
       far too much disk I/O to check the group.  The index needs
       filesystem coherency support, otherwise it is not reliable
       enough for this bandwidth optimisation.

> >      I won't explain how these work as it would make this mail too
> >      long.  It should be clear to anyone who thinks about it why the
> >      coherency mechanism is essential for real-time, and a consistent
> >      interface to container internals helps with performance.
> 
> Coherency is essential, but it isn't free. Far from it. The easiest way of
> getting coherency is having _one_ authoritative source. That way you don't
> need coherency, and don't pay for it. Anything in this class must by force
> be just hints, to be recomputed at a moment's notice. I.e., let the
> application who might use it check and recompute as needed.

(a) Without some kind of minimal hook, there is no way for the application
to check without re-reading all the files it has used for a
computation, starting at the moment where it's about to potentially
recompute the result.

Sometimes you can get away with stat() on the files (e.g. Evolution
and fontconfig do that), but often you can't because that's not
trustworthy enough (security checks, protocol optimisations,
transparent "as if I didn't cache anything" semantics), and sometimes
stat() calls are far too slow anyway (anything that involves a lot of files).

(The trustworthiness problem is likely to be solved, for some
applications, by an xattr or such which is guaranteed to be deleted or
changed when a file is modified.  That is really a very minimal hook,
but it is one).

(b) Even with all the misgivings of stat(), you can't realistically
update real time displays, e.g. the lists of artists & albums on the
screen in your MP3 player whenever you modify anything in your music
collection using another program.  At best, you have to expect the
display to not notice the change for a while (minutes in the mp3
case), or until you click an "Explicit Refresh" button.  Neither
should be necessary.


It's true that the simplest coherency is one authoratitive source
which you have to check all the time (although even that doesn't work
for some things).  But checking all the time does rule out, due to its
high algorithmic complexity, a lot of very interesting applications
and even some interesting simple unixish tools which you might like,
such as real-time "locate".

-- Jamie
