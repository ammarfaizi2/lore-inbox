Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbUJYMka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbUJYMka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUJYMk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:40:29 -0400
Received: from THUNK.ORG ([69.25.196.29]:45478 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261781AbUJYMhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:37:32 -0400
Date: Mon, 25 Oct 2004 08:37:23 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Timo Sirainen <tss@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
Message-ID: <20041025123722.GA5107@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Timo Sirainen <tss@iki.fi>,
	linux-kernel@vger.kernel.org
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 04:21:57AM +0300, Timo Sirainen wrote:
> I'd have thought this had already been asked many times before, but 
> google didn't show me anything.
> 
> My problem is that mails in a large maildir get temporarily lost. This 
> happens because readdir() never returns a file which was just rename()d 
> by another process. Either new or the old name would have been fine, 
> but it's not returned at all.
> 
> Is there a chance this could get fixed? Every OS/filesystem I've tested 
> so far has had the same problem, so I'll have to implement some extra 
> locking anyway (so much for maildir being lockless), but it would be 
> nice to have at least one OS where it works without the extra locking 
> overhead.

In some cases it won't even just get lost, but the old and new name
can both be returned.  For example, if you assume the use of a simple
non-tree, linked-list implementation of a directory, such can be found
in Solaris's ufs, BSD 4.3's FFS, Linux's ext2 and minix filesystems,
and many others, and you have a fully tightly packed directory (i.e.,
no gaps), with the directory entry "foo" at the beginning of the file,
and readdir() has already returned the first "foo" entry when some
other application renames it "Supercalifragilisticexpialidocious", the
new name will not fit in the old name's directory location, so it will
be placed at the end of the directory --- where it will be returned by
readdir() a second time.

This is not a bug; the POSIX specification explicitly allows this
behavior.  If a filename is renamed during a readdir() session of a
directory, it is undefined where that neither, either, or both of the
new and old filenames will be returned.

And that's because there's no good way to do this without trashing the
performance of the system, especially when most applications don't
care.  (Do you really want your entire system running significantly
slower, penalizing all other applications on your system, just because
of one stupid/badly-written application?)  In order to do this, the
kernel would have to atomically snapshot the directory --- even one
which might be several megabytes in length, and store a copy of it in
memory, while the application calls readdir().  Several processes
could perform a denial-of-service attack by starting to call
readdir(), and then stopping.  This would end up locking up huge
amounts of non-pageable system memory, and cause the system to come
down in a hurry.

							- Ted
