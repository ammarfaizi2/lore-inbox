Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267634AbUIAUKC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbUIAUKC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUIAUKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:10:01 -0400
Received: from mail.shareable.org ([81.29.64.88]:61641 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267605AbUIAUJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:09:27 -0400
Date: Wed, 1 Sep 2004 21:08:06 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Adrian Bunk <bunk@fs.tum.de>, Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4)
Message-ID: <20040901200806.GC31934@mail.shareable.org>
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408282314.i7SNErYv003270@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to explain why filesystem support for .tar.gz or other
"document container"-like formats is useful.  This does _not_ mean tar
in the kernel (I know someone who can't read will think that if I
don't say it isn't); it does mean hooks in the kernel for maintaining
coherency between different views and filesystem support for cacheing.

The vision I'm going for here is:

  1. OpenOffice and similar programs store compound documents in
     standard file formats, such as .tar.gz, compressed XML and such.

     Fs support can reduce CPU time handling these sorts of files, as
     I explain below, while still working with the standard file formats.

     With appropriate userspace support, programs can be written which
     have access to the capabilities on all platforms, but reduced CPU
     time occurs only on platforms with the fs support.

  2. Real-time indexing and local search engine tools.  This isn't
     just things like local Google; it's also your MP3 player scanning
     for titles & artists, your email program scanning for subject
     lines to display the summary fast, your blog server caching built
     pages, your programming environment scanning for tags, and your
     file transfer program scanning for shared deltas to reduce bandwidth.

     I won't explain how these work as it would make this mail too
     long.  It should be clear to anyone who thinks about it why the
     coherency mechanism is essential for real-time, and a consistent
     interface to container internals helps with performance.

Horst von Brand wrote:
> Jamie Lokier <jamie@shareable.org> said:
> > When a simple "cd" into .tar.gz or .iso is implemented properly, it
> > will have _no_ performance penalty after you have first looked in the
> > file, so long as it remains in the on-disk cache.  And, the filesystem
> > will manage that cache intelligently.
> 
> Nonsense. The .iso or .tar or whatever would have to be kept un-isoed or
> un-tarred in memory (or on disk cache) for this to be true, and that takes
> quite a long time. Each time you want to peek anew at linux/Makefile, the
> whole tarfile will have to be read and stored somewhere,

Wrong.  "So long as it remains in the on-disk cache" means each time
you peek at linux/Makefile, the tarfile is _not_ read.

For a tarfile it's slow the first time, and when it falls out of the
on-disk cache, otherwise, for component files you are using regularly
(even over a long time) it's as fast as reading a plain file.

You obviously know this, as you mentioned on-disk cache in the reply,
so I infer from the rest of your mail that what you're trying to say
is more about modifications than reading archives.  That it would be
silly to keep working data in .tar.gz files, because working inside
them regularly would be slow.

Which means you must be assuming, incorrectly, that these .tar.gz
files are really kept up to date on disk with every component file
modification.

Which is silly.  .tar.gz files are suitable for *transport* and
*archival*, not regular random access; it's almost rude of you to
suggest I didn't know that.

The proposal is that .tar.gz files (and others) are analysed on demand
and content cached on disk as it is read.  Then subsequent reads will
be as fast as if you had unpacked the archives by hand, manually using
the tar command.  This is obviously exactly the same as you do now,
with a small bit of added convenience.

The other part of the proposal is that when you modify a component,
the modifications are stored on disk in the same way as ordinary
files, using the regular high performance random access disk
structures.  Nothing is done to recreate the archive at this point; I
think this is where you misunderstood and thus flamed.

_If_ after modifying components, you then read the .tar.gz as a file,
then (and only then) is it recreated, taking in the worst case the
same time as running the tar command.

The _only_ times when that occurs are precisely those times when you
would have run the tar command manually: because you only read the
.tar.gz file when you need the flat file for some purpose, such as
attaching it to an email, transferring by FTP or HTTP, or reading it
into a program that needs it in that format.

If there is anything about that strategy that doesn't make sense, then
I suggest I have failed to explain it properly, and you're welcome to
demand a clearer explanation.

> the .tar format is optimized for compact storage, the on-disk format
> of a filesystem is optimized for fast access and modifiability.

Actually no, .tar is not compact at all.  It's also not optimised for
random read access, but after an index is build it is very fast for that.

.tar.gz is compact.  Although that is not especially fast for random
read access, you can build a "compression dictionary index" which
optimises random read access even in a .tar.gz, without ever unpacking
the whole thing.

Some formats like .iso, .zip and .jar are optimised for compact
storage _and_ fast random access.  They come with an index, and don't
need one to be built and cached.

These are not filesystem-like formats, obviously, but they are the
formats you need to pack and unpack when exchanging data with other
people.  That's the _only_ reason they're on your disk (virtually;
they may not really exist some of the time).

> Now go ahead and enlarge a file on your .iso/.tar a bit...it
> will take ages to rebuild the whole thing. There is a _reason_ why there
> are filesystems and archives, and they use different formats. If it weren't
> so, everybody and Aunt Tillie would just carry .ext3's around, and would
> wonder what the heck all this fuss is about.

If you enlarge a file in your .iso/.tar subdirectory a bit... nothing
happens.  Why would a smart programmer do anything so silly as rebuild
the archive at that point?

_If_ you subsequently read the .iso/.tar _file_, then and only then
does it rebuild.  Once, after lots of component writes.  The only time
you would ever do that is if you are specifically reading the archive
file, which means you actually want to use the repacked file at that
point, for example to FTP it somewhere or use as an email attachment.

If the filesystem does not do that on demand, then you would have run
the tar command manually at that point, precisely because that's a
point where you need the repacked archive.  So in case where the
filesystem repacks the archive, it takes exactly the same time as you
would have taken anyway; it's just automatic instead of manual.  (As a
handy side effect, the automatic method offers lower latency for
transmissions).

Now, why would we bother with all this?

I see three reasons: convenience, time efficiency, and storage efficiency.

Convenience is simply that it is handy to be able to look inside
archive files, in those situations where we _currently_ use them, without
having to manually untar when we need to, and without having to
remember to clean up old directories when we discover we aren't using
those often any more.  This is _not_ an argument for using .tar.gz
files in place of ordinary directories!  Convenience applies to doing
the things you do now.

Time efficiency has two angles.  A simple one is that accessing
.tar.gz contents through any kind of filesystem interface, even pure
userspace, can be faster than unpacking whole files, simply because
there are ways to decode parts without unpacking it all.

However, the main time efficiency that I see comes from the increasing
number of applications where the "Open" and "Save" operations store
data in *.gz files (e.g. OpenOffice compressed XML documents), or
*.tar.gz files (some compound document formats), or other things like
that.  (If you think about it, quite a lot of things are like that).

With these, every "Open" currently has to decompress and maybe unpack
an archive format.  Every "Save" currently has to pack and then
compress.  This is done so the user sees a single flat file containing
a complex document, but it is a waste of CPU time until the user
actually transports the flat file.

The lazy proposal, as described earlier in this mail, _removes_ these
decompression, unpacking, packing and compression CPU-intensive steps
when they are unnecessary.  The experience of a single file containing
a complex document is maintained, but the CPU time is reduced in many
typical operations.  "Open" gets faster after you first look at a
file, "Save" gets a lot faster for large documents, and the equivalent
of grep (or later, real-time local search engine) gets a lot faster
too.  There is no operation where CPU time is overall increased.

This is what I've meant throughout this thread, when I say containers:
document files of the kind used to hold text, figures, etc. that are
typically transported as a unit, and edited as a unit, but nonetheless
at the moment they're stored in somewhat CPU intensive formats, for
compactness.  That's fine for a 1 page letter, but think of the
OpenOffice 500-page book containing a large number of diagrams.

However, even simple programs that read & write compressed XML benefit.

The proposal allows that sort of thing to be handled more time
efficiently that it is today, and in a way that is very practical to use.

(It's unthinkable that OpenOffice and similar programs would have a
lot of code which stored data in a special way just for Linux, just
for these performance benefits which are otherwise user-invisible, but
it's thinkable that a general purpose userspace library which is
portable to all platforms could be written, which takes advantage of
the facility when it's available and does the equivalent of today's
"compress on save" when the filesystem facility isn't available).

Finally, storage efficiency comes from simply allowing the filesystem
and supporting tools to decide when it is best to store data in
unpacked, packed & compressed, both at the same time, or another
archival form.  The filesystem has comparativaly good knowledge of
which data to archive and when, but it can only maintain the illusion
if there's a mechanism to make archived forms and unpacked forms
coherent.

Now, I'm sure there is a way to implement this on top of a neat and
simple kernel feature involving weird bind mounts, leases, dnotifies
and FUSE.  But those kernel offering are quite a mess at the moment
and don't fit together in a way which can usefully create this effect.

Auto-mounting uservfs directories over file-as-directory, using
moveable bind mounts _nearly_ offers the kernel primitives we need to
build this in userspace and get the all the efficiencies.  But not quite.

(We could obviously do it all in userspace by putting _everything_ in
a userspace filesystem, but that would be silly as it would throw away
all of the performance of having a threaded filesystem in the kernel.
It might do as a proof of concept though).

-- Jamie
