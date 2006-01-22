Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWAVJbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWAVJbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 04:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWAVJbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 04:31:55 -0500
Received: from thunk.org ([69.25.196.29]:2243 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932256AbWAVJbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 04:31:55 -0500
Date: Sun, 22 Jan 2006 04:31:44 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060122093144.GA7127@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <43D3295E.8040702@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D3295E.8040702@comcast.net>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 01:42:38AM -0500, John Richard Moser wrote:
> Soft Update appears to have the advantage of not needing multiple
> writes.  There's no need for journal flushing and then disk flushing;
> you just flush the meta-data.  

Not quite true; there are cases where Soft Update will have to do
multiple writes, when a particular block containing meta-data has
multiple changes in it that have to be committed to the filesystem at
different times in order to maintain consistency; this is particularly
true when a block is part of the inode table, for example.  When this
happens, the soft update machinery has to allocate memory for a block
and then undo changes to that block which come from transactions that
are not yet ready to be written to disk yet.

In general, though, it is true that Soft Updates can result in fewer
disk writes compared to filesystems that utilizing traditional
journaling approaches, and this might even be noticeable if your
workload is heavily skewed towards metadata updates.  (This is mainly
true in benchmarks that are horrendously disconneted to the real
world, such as dbench.)

One major downside with Soft Updates that you haven't mentioned in
your note, is that the amount of complexity it adds to the filesystem
is tremendous; the filesystem has to keep track of a very complex
state machinery, with knowledge of about the ordering constraints of
each change to the filesystem and how to "back out" parts of the
change when that becomes necessary.

Whenever you want to extend a filesystem to add some new feature, such
as online resizing, for example, it's not enough to just add that
feature; you also have to modify the black magic which is the Soft
Updates machinery.  This significantly increases the difficulty to add
new features to a filesystem, and can add as a roadblock to people
wanting to add new features.  I can't say for sure that this is why

BSD UFS doesn't have online resizing yet; and while I can't
conclusively blame the lack of this feature on Soft Updates, it is
clear that adding this and other features is much more difficult when
you are dealing with soft update code.

> Also, soft update systems mount instantly, because there's no
> journal to play back, and the file system is always consistent.  

This is only true if you don't care about recovering lost data blocks.
Fixing this requires that you run the equivalent of fsck on the
filesystem.  If you do, then it is major difference in performance.
Even if you can do the fsck scan on-line, it will greatly slow down
normal operations while recovering from a system crash, and the
slowdown associated with doing a journal replay is far smaller in
comparison.

> Unfortunately, journaling uses a chunk of space.  Imagine a journal on a
> USB flash stick of 128M; a typical ReiserFS journal is 32 megabytes!
> Sure it could be done in 8 or 4 or so; or (in one of my file system
> designs) a static 16KiB block could reference dynamicly allocated
> journal space, allowing the system to sacrifice performance and shrink
> the journal when more space is needed.  Either way, slow media like
> floppies will suffer, HARD; and flash devices will see a lot of
> write/erase all over the journal area, causing wear on that spot.

If you are using flash, use a filesystem which is optimized for flash,
such as JFFS2.  Otherwise, note that in most cases disk space is
nearly free, so allocating even 128 megs for the journal is chump
change when you're talking about a 200GB or larger hard drive.

Also note that if you have to use slow media, one of the things which
you can do is use a separate (fast) device for your journal; there is
no rule which says the journal has to be on the slow device.  

						- Ted
