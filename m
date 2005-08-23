Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVHWPXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVHWPXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVHWPXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:23:35 -0400
Received: from mail.shareable.org ([81.29.64.88]:53688 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S932203AbVHWPXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:23:34 -0400
Date: Tue, 23 Aug 2005 16:23:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Asser =?iso-8859-1?Q?Fem=F8?= <asser@diku.dk>
Cc: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: dnotify/inotify and vfs questions
Message-ID: <20050823152331.GA10486@mail.shareable.org>
References: <20050823130023.GB8305@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050823130023.GB8305@diku.dk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asser Femø wrote:
> According to the fcntl manual you can cancel a notification by doing
> fcntl(fd, F_NOTIFY, 0) (ie. sending 0 as the notification mask), but
> looking in the kernel code fcntl_dirnotify() immediately calls
> dnotify_flush() with neither telling the vfs module about it. Is there a
> reason for this?  Otherwise I'd propose calling
> filp->f_op->dir_notify(filp, 0) at some point in this scenario.
> 
> Regarding inotify, inotify_add_watch doesn't seem to pass on the request
> either, which works fine for local filesystem operations as they call
> fsnotify_* functions every time, but that isn't really feasible for
> filesystems like cifs because we'd have to request change notification
> on everything. Is there plans for implementing a mechanism to let vfs
> modules get watch requests too?

On a related note:

dnotify and inotify on local filesystems appear to be synchronous, in
the following rather useful sense:

If you have previously registered for inotify/dnotify events that will
catch a change to a file, and called stat() on the file, then the
following operation:

    <receive some request>...
    stat_info = stat(file)

may be replaced in userspace code with:

    <receive some request>...
    if (any_dnotify_or_inotify_events_pending) {
        read_dnotify_or_inotify_events();
        if (any_events_related_to(file)) {
            store_in_userspace_stat_cache(file, stat(file));
        }
    }
    stat_info = lookup_userspace_stat_cache(file);

Now that's a silly way to save one system call in the fast path by itself.

But when the stat_info is a prerequisite for validating cached data --
such as the contents of a file parsed into a data structure -- it can
save a lot of system calls and logical work.

For example, an Apache-style path walk which checks for .htaccess, or
a Samba-style path walk which is checking for unsafe symbolic links,
can be reduced from say 20 system calls to zero using this method.

Pre-compiled or pre-parsed programs/scripts/templates/config-files
where all the source files used are prerequisites for invalidating a
cached compiled form, reduces from say 40 system calls to stat() all
the source files, to zero....  that's quite a saving.

It's not just reducing system calls.  The logical tests in userspace
are also skipped, if coded properly, facilitating very quick decisions
about things that depend on files which mostly don't change.
(Cascading structured cache prerequisites...mmm).

Remote dnotify/inotify doesn't _necessarily_ have this synchronous
property.  It may do in some cases, depending on the implementation
(this is subtle...).

So, it would be nice if there was a way to query this... rather than
the tedious method of testing the filesystem type and having a table
of "known local filesystem types" where it's safe to depend on this
property.  Alternatively, a way to specify at dnotify/inotify creation
type that synchronous notifications are required, and have the request
rejected if those can't be provided.

-- Jamie


