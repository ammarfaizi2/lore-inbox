Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274405AbRJAB0m>; Sun, 30 Sep 2001 21:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274424AbRJAB0d>; Sun, 30 Sep 2001 21:26:33 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:20138 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S274405AbRJAB0T>;
	Sun, 30 Sep 2001 21:26:19 -0400
Date: Mon, 1 Oct 2001 03:26:27 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: foner-reiserfs@media.mit.edu
Cc: sct@redhat.com, Nikita@Namesys.COM, Mason@Suse.COM,
        linux-kernel@vger.kernel.org, reiserfs-list@Namesys.COM
Subject: Re: [reiserfs-list] ReiserFS data corruption in very simple configuration
Message-ID: <20011001032627.A9991@schmorp.de>
Mail-Followup-To: foner-reiserfs@media.mit.edu, sct@redhat.com,
	Nikita@Namesys.COM, Mason@Suse.COM, linux-kernel@vger.kernel.org,
	reiserfs-list@Namesys.COM
In-Reply-To: <20010929145229.C26231@schmorp.de> <200110010100.VAA07189@out-of-band.media.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200110010100.VAA07189@out-of-band.media.mit.edu>
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2001 at 09:00:49PM -0400, foner-reiserfs@media.mit.edu wrote:
> extending a file, the metadata is written -last-, e.g., file blocks
> are allocated, file data is written, and -then- metadata is written.

this is almost impossible to achieve with existing hardware (witness the
many discussions about disk caching for example), and, without journaling,
might even be slow.

> of wtmp had data from the -previous- copy of XFree86.0.log that had
> been freed (because it was unlinked when the next copy was written)
> but which had not actually had the wtmp data written to it yet

It's easily possible, but it could also be a bug. Let's the reiserfs authors
decide.

However, if it is indeed "a bug" then fixing it would only lower the
frequency of occurance.

Only ext3 (some modes) + turning off your harddisk's cache can ensure
this, at the moment.

> to have that logfile in it (instead of zero bytes).  Is this what
> you're talking about when you say "*old* data"?  I think so, and that
> seems to match your comment below about file tails moving around
> rapidly.

appending to logfiles will result in a lot of movement. with other,
strictly block-based filesystems this occurs relatively frequent, and data
will not usually move around. with reiserfs tail movement is frequent.

> Wouldn't it make more sense to commit metadata to disk -after- the
> data blocks are written?

The problem is that there is currently no easy way to achieve that.

> file simply looks like the data was never added.  If the metadata is
> written -first-, the file can scoop up random trash from elsewhere in

Also, this is not a matter of metadata first or last. Sometimes you need
metadata first, sometimes you need it last. And in many cases, "metadata"
does not need to change, while data still changes.

> the filesystem.  I contend that this is -much- worse, because it can
> render a previously-good file completely unparseable by tools that
> expect that -all- of the file is in a particular syntax.

It depends - with ext2 you frequently have garbled files, too. Basically, if
you write to a file and turn off the power the outcome is unexpected, and
will always be (unless you are ready to take the big speed hit).

> Unfortunately, this behavior meant that X -did- fall over, because my
> XF86Config file was trashed by being scrambled---I'd recently written
> out a new version, after all---and the trashed copy no longer made any

But the same thing can and does happen with ext2, depending on your editor
and your timing. It is not a reiserfs thing.

> But if you write the metadata first, you foil this attempt to be safe,
> because you might have this sequence at the actual disk:  [magnetic
> oxide updated w/rename][start updating magnetic oxide with tempfile
> data][power failure or reset]---ooops! original file gone, new file
> doesn't have its data yet, so sorry, thanks for playing.

Of course. If you want data to hit the disk, you have to use fsync. This
does work with reiserfs and will ensure that the data hits the disk. If
you don't do this then bad things might happen.

> By writing metadata first, it seems that reiserfs violates the
> idempotence of many filesystem operations, and does exactly the
> opposite of what "journalling" implies to anyone who understands
> databases, namely that either the operation completes entirely, or it
> is completely undone.

You are confusing databases with filesystems, however. Most journaling
filesystems work that way. Some (like ext3) are nice enough to let you
choose.

> journal the metadata, but how does this help when what it's essentially
> doing is trashing the -data- in unexpected ways exactly when such
> journalling is supposed to help, namely across a machine failure?

But ext2 works in the same way. It does happen more often with reiserfs
(especially with tails), but ignoring the problem for ext2 doesn't make it
right. If applications don't work reliably with reisrefs, they don't work
reliably with ext2. If you want reliability then mount synchronous.

> This seems like such an elementary design defect that I'm at a loss
> to understand why it's there.

About every filesystem does have this "elementary design defect". If you
want data to hit the disk, sync it. Its that simple.

> There -must- be some excellent reason,
> right?  But what?  And if not, can it be fixed?

Speed is an excellent reason. The fix is to tell the kernel to write the
data out to the platters.

Anyway, this is a good time to review the various discussions on the
reiserfs list and the kernel list on how to teach the kernel (if it is
possible) to implement loose write-ordering.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
