Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUFNOLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUFNOLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263154AbUFNOLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:11:41 -0400
Received: from salzburg.nitnet.com.br ([200.157.204.105]:28886 "EHLO
	nat.cesarb.net") by vger.kernel.org with ESMTP id S263040AbUFNOLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:11:18 -0400
Date: Mon, 14 Jun 2004 10:46:52 -0300
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040614134652.GA1961@flower.home.cesarb.net>
References: <20040612011129.GD1967@flower.home.cesarb.net> <20040614095529.GA11563@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614095529.GA11563@infradead.org>
User-Agent: Mutt/1.5.6+20040523i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 10:55:29AM +0100, Christoph Hellwig wrote:
> On Fri, Jun 11, 2004 at 10:11:29PM -0300, Cesar Eduardo Barros wrote:
> > (not subscribed to lkml, please CC: me on replies)
> > 
> > This patch adds support for the O_NOATIME open flag (GNU extension):
> > 
> > int O_NOATIME  	Macro
> >   If this bit is set, read will not update the access time of the file.
> >   See File Times. This is used by programs that do backups, so that
> >   backing a file up does not count as reading it. Only the owner of the
> >   file or the superuser may use this bit.
> > 
> > It is useful if you want to do something with the file atime (for
> > instance, moving files that have not been accessed in a while to
> > somewhere else, or something like Debian's popularity-contest) but you
> > also want to read all files periodically (for instance, tripwire or
> > debsums).
> > 
> > Currently, the program that reads all files periodically has to use
> > utimes, which can race with the atime update:
> 
> Any chance we could change the flag to also not update mtime and ctime
> for updates on a fd opened with it (and renaming it to O_INVISIBLE for
> example).  That's needed for your above moving infrequently used files
> away scenario (aka a HSM)

I don't see why preserving the mtime and ctime would be necessary, since
to move a file away you either don't touch it (using rename) or only
read and unlink it (to write to a tape or other filesystem, and you can
save the atime and mtime while doing it). So O_NOATIME is enough for
both behaviours.

Besides, O_NOATIME is most important not for the program that's moving
the files elsewhere, but for these checksum-the-world utilities that
read every single file they can see, and in the process manage to
destroy the usefulness of the atime, or backup programs that also read
everything they can touch. Both currently have to use utimes after
reading the whole file to restore the atime it had when they began
reading, which can take a long time if the file is huge (but note that
the mtime doesn't change since they are all reading, not writing).

The ctime changing is not a problem, since programs that want to move
infrequently used files away will use only the atime and mtime to make
their decisions, not the ctime. Also, wouldn't not changing the atime
make the ctime not change too, since nothing in the inode has changed?

O_NOATIME would also be useful for things like tar --atime-preserve,
cpio --reset-access-time, star -atime, pax -t, and others.

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
