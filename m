Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVFVEZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVFVEZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 00:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVFVEZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 00:25:49 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:19465 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262624AbVFVEZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 00:25:26 -0400
Message-ID: <42B8E834.5030809@slaphack.com>
Date: Tue, 21 Jun 2005 23:25:24 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com>
In-Reply-To: <42B8BB5E.8090008@pobox.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
> Hans Reiser wrote:
> 
>> Christoph,
>>
>> Reiser4 users love the plugin concept, and all audiences which have
>> listened to a presentation on plugins have been quite positive about
>> it.  Many users think it is the best thing about reiser4.  Can you
>> articulate why you are opposed to plugins in more detail?  Perhaps you
>> are simply not as familiar with it as the audiences I have presented
>> to.  Perhaps persons on our mailing list can comment.....
>>
>> In particular, what is wrong with having a plugin id associated with
>> every file, storing the pluginid on disk in permanent storage in the
>> stat data, and having that plugin id define the set of methods that
>> implement the vfs operations associated with a particular file, rather
>> than defining VFS methods only at filesystem granularity?
> 
> 
> You're basically implementing another VFS layer inside of reiser4, which
> is a big layering violation.

There's been sloppy code in the kernel before.  I remember one bit in
particular which was commented "Fuck me gently with a chainsaw."  If I
remember correctly, this had all of the PCI ids and the names and
manufacturers of the corresponding devices -- in a data structure -- in
C source code.  It was something like one massive array definition, or
maybe it was a structure.  I don't remember exactly, but...

The point is, this was in the kernel for quite awhile, and it was so
ugly that someone would rather be fucked with a chainsaw.  If something
that bad can make it in the kernel and stay for awhile because it
worked, and no one wanted to replace it -- nowdays, that database is
kept in userland as some nice text format -- then I vote for putting
Reiser4 in the kernel now, and ironing the sloppiness ("violation") out
later.  It runs now.

> This sort of feature should -not- be done at the low-level filesystem
> level.

I agree there, too.  In fact, some people have suggested that all
"legacy" (read: non-reiser) filesystems should be implemented as Reiser4
plugins, effectively killing VFS.*

So, Reiser4 may eventually take over VFS and be the only Linux
filesystem, but if so, it will have to do it much more slowly.  Take the
good ideas -- things like plugins -- and make them at least look like
incremental updates to the current VFS, and make them available to all
filesystems.

Eventually, this would result in a full merge of Reiser and Linux, such
that the only thing left of "Reiser4" are a few plugins -- things like
storage plugins and maybe some more exotic things like fibration that I
don't really understand.

> What happens if people decide plugins are a good idea, and they want
> them in ext3?  We need massive surgery to extract the guts from reiser4.

And here is the crucial point.  Reiser4 is usable and useful NOW, not
after it has undergone massive surgery, and Namesys is bankrupt, and
users have given up and moved on to XFS.  But the massive surgery should
happen eventually, partly to make all filesystems better (see below),
and partly to make the transition easier and more palatable for those
who don't work for Namesys.





* Imagine ext3 as a storage-level plugin for reiser4.  You get one
benefit immediately -- lazy allocation.  Lazy allocation is nice both
for fragmentation and for busy systems writing and nuking a lot of
temporary files.  Imagine a file which is written and then deleted
before it hits disk -- it should never touch the disk, regardless of the
underlying storage layout.

Other benefits are subtler but inevitable.  Right now, it would be an
understatement to say that there's duplication of effort between ext3,
xfs, and reiser4.  And yet, I don't think there are many core design
decisions that influence my decision as to which I pick up.  I just want
it to be fast, stable, and have a stable on-disk format so I don't have
to reformat too often.  I honestly don't care about how XFS is
segmenting the disk, or Reiser4 packs really well, or ext3 can be read
as ext2 and flushes to disk every five seconds.  These are the kinds of
things which should be set to sane defaults, tunable for enterprise
users, but are not really enough to warrant completely separate code bases.

I would imagine that it wouldn't be too long after this before an
uber-fs rose, something which combined enough of the strong points of
all the existing Linux filesystems that no one would use anything else.
 But, Linux still needs support for FAT32, ISO9660, UDF, and all the
other filesystems which won't go away as easily as XFS and ext3, and it
would be nice if these could all share as much code as possible.


I don't know if storage plugins really work that way, but they should.

I think.  I don't work here.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrjoNHgHNmZLgCUhAQIYYw/7BWZ0gVvy0ln5tRo405yUoRHJ/jVFBGyP
5pQ610ECMZORVWRO1qP/NXbvGZwDjEggM5iIeahsGqnBWzNGDsB6RslMUZAxzCYy
iAovi0881zoARf3dmhKrDgbGkvNLPTx+/ypa20oRcHLnyI+NAjerUxNuvGc79PJn
Ybm9JhX6tQsqGIKjZye9uNDHCifLqzA1gdxucPwWo9sz4ymzM9FgsMGvb+IxrU50
2a2G2K6AHcH+nkomEHw3xgY3PmUZUy0s2hQDSkJx6dCido7fGZwwykaSXm4IZs9s
xZqBxKx32G/LDnDV3W8gpj8ZisUE+58kefRbIjo4Ml6IzgXvQqpRjaQOuz8JoKDX
9KUV43tcZkPpK+neIYPQYpXCrdMQqB5+ISpbNKuz/Z/abkcVw1042sy0EKM+/VnD
n3Jr7PpSyk0lfCyADr+33qnqPQRFq02gQTohg9FheoMthhV01aaeGW5ExmTM/Wwa
6Dmv/qnn2oNImi+Ebz5u3Lbnz7lL3MVpRL4aoMmEOVUB3xhehnxesf//yacBmwj9
M/3KVae9epwX4K6yi8qQXzH4160IBFHpWUxBLc9LnOZlHQuZ+Fz3BIrbKQBvmaHT
7lrwi0Os6TmiBGMSFd6OUWHcYs4p97aMw30NG33fCL6e8X6oNVFwwnJXZpBPN1Mr
+lrsVAywKEI=
=rHdK
-----END PGP SIGNATURE-----
