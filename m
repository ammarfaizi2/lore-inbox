Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVAMCws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVAMCws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 21:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVAMCws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 21:52:48 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:48567 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261316AbVAMCwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 21:52:19 -0500
Date: Wed, 12 Jan 2005 18:51:57 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, gregkh@us.ibm.com,
       tytso@us.ibm.com, suparna@in.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050113025157.GA2849@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050107010119.GS1292@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107010119.GS1292@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 05:01:19PM -0800, Paul E. McKenney wrote:
> On Thu, Jan 06, 2005 at 09:24:17PM +0000, Al Viro wrote:
> > "Use recursive bindings instead of trying to take over the entire mount tree
> > and mirroring it within your fs code.  And do that explicitly from userland".
> 
> Thank you for the pointer!  By this, you mean do mount operations in
> conjunction with namespaces, right?
> 
> I will follow up with more detail as I learn more.  The current issue
> seems to be with removeable devices.  Their users want to be accessing
> a particular version, but still see a memory stick that was subsequently
> mounted outside of the view.  Straightforward use of mounts and namespaces
> would prevent the memory stick from being visible to users that were
> already in view.

OK, after much thrashing, here is what the ClearCase users need.
Sorry for the length -- the first few paragraphs gives the flavor of
it and the rest goes into more detail with examples.

Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

ClearCase provides a filesystem view of revision-control repositories.
ClearCase users can specify the desired revision directly in the pathname
("view extended naming", for example "/views/v1.1/vob/foo/bar.c")
or they can associate a particular revision with a process and its
descendants ("setview context naming", for example "/vob/foo/bar.c").
Specifying the revision in the pathname is useful for diffing and such,
and associating a revision with a process is useful for builds and
testing using standard tools, sort of like chroot jails.

ClearCase users need the root filesystem to be overlaid on each view,
so that "/etc/passwd" and "/views/v1.1/etc/passwd" reference the same
file.

The current hope is that adding (a) shared and asymmetrically shared
subtrees between namespaces/locations in the same namespace, (b) stackable
LSM modules, and (c) dynamic recursive union mount would enable Linux
to provide this in a technically sound manner.  [But this is not clear
to me yet.]

More details on what ClearCase users want to see follow.

1.	"View extended naming", where the revision is specified by
	the pathname.

	a.	Users explicitly specify that they want to see a specific
		revision (e.g., v1.1) using the ClearCase "startview"
		command.  This revision is then visible to all processes.

	b.	The pathname fully specifies the revision and file, e.g.,
		"/views/v1.1/vob/foo/bar.c", where the "startview"
		command has initialized an MVFS view of the v1.1 version on
		"/views/v1.1/vob/foo".  ("vob" stands for "versioned object
		base".)

	c.	Note that the entire filesystem is also visible within
		the view, so that /etc/passwd" is an synonym for
		"/views/v1.1/etc/passwd".  This can be thought of
		as (currently mythical) "dynamic union mount rbind".
		See #4 below for more detail.

2.	"Setview context naming", where revision is -not- specified
	by the pathname.

	a.	A particular process designates a particular revision
		(e.g., "v1.1") using a ClearCase "setview" command.
		This designation applies to both the process and its
		future descendants (any descendants already created are
		unaffected.  The "setview" command does an implicit
		"startview" if needed.

	b.	That process and any of its descendants will then see the
		specified revision via "/vob/foo/bar.c", where an
		MVFS filesystem has been mounted on "/vob/foo".

	c.	Changes made via the "setview context naming" paths
		are visible in "view extended naming" paths, with
		the same restrictions as called out in #1c above.

	d.	A given process can mix and match "view extended naming"
		and "setview context naming" references, so that
		both "/views/v1.1/vob/foo/bar.c" and "/vob/foo/bar.c"
		may be used to refer to the same file, but in that case
		"/views/v1.2/vob/foo/bar.c" might reference a different
		file.  These synonyms for the same file need to have the
		properties of the mythical "dynamic union mount rbind"
		described in #4 below.

3.	ClearCase users are -not- permitted to mount over a file or
	directory within an MVFS filesystem.  Therefore, if a user
	mounts a memory stick over (say) "/vob/foo/mnt", the results
	are undefined.

4.	ClearCase users need to be able to access multiple repositories
	simultaneously (e.g., for related projects).  So there might
	be a "/vob/foo" and "/vob/oof" project visible simultaneously.

	There are some specialized but important testing situations
	that require separate top-level directories, e.g., "/vob"
	and "/tmp/vobtest".

5.	The ClearCase users need the mythical "dynamic union mount rbind"
	to set things up so that any access to a non-MVFS file made from
	within a view gives the same results as a direct access to that
	file would give if no MVFS filesystems were mounted.  For example,
	any access to "/views/v1.1/etc/passwd" must give exactly the same
	results as the same access to "/etc/passwd" would if there were
	no MVFS filesystems mounted.

	The "dynamic union mount rbind" therefore needs to have the
	following properties:

	a.	The underlying inodes retain the same link count
		no matter how many ClearCase views they are
		accessible from.  So, if the link count of /etc/passwd
		is initially 1, it remains 1 even though it is
		accessible via "/etc/passwd", "/views/v1.1/etc/passwd",
		"/views/v1.2/etc/passwd", and so on.  Similarly,
		if the link count of foo/bar.c in the v1.1 revision
		is initially 1, it remains 1 even when it is
		accessible both via "/vob/foo/bar.c" and
		"/views/v1.1/vob/foo/bar.c".

		Hard-link tricks break user scripts and programs.

	b.	The types of the underlying files remain the same
		regardless of how many views they are visible in
		and regardless of how they are accessed.  So, if
		/etc/passwd is a normal file, it will appear to be
		a normal file when accessed via "/etc/passwd",
		"/views/v1.1/etc/passwd", "/views/v1.2/etc/passwd",
		and so on.  Similarly, if foo/bar.c is a normal file,
		is will appear to be a normal file when accessed
		via "/vob/foo/bar.c" and "/views/v1.1/vob/foo/bar.c".

		Symbolic-link tricks break user scripts and Makefiles.

	c.	The types of the underlying filesystem remain the
		same regardless of which view is used.  This is 
		required by user scripts that use things like "df -k".

	d.	Any changes to any non-MVFS filesystem are immediately
		visible in the view.  Some examples:

		i.	A mount in the root filesystem, e.g.,

				mount /dev/cdrom /mnt/cdrom

			must result in the CDROM being visible in both
			"/mnt/cdrom" and in "/views/v1.1/mnt/cdrom".
			Ditto for NFS mounts and automounting.

			In this case "immediately" means "before the
			mount command's process exits".  This need for
			immediacy applies both to explicit mounts and
			to autofs-induced mounts.  Ditto for unmounts.

		ii.	Dynamic filesystems such as /proc must
			exhibit their dynamic nature whether accessed
			via "/proc", "/views/v1.1/proc", or
			"/views/v1.2/proc".

			Again, changes must be immediately visible in
			all views, where "immediately" means that there
			should be no "time warps".  For example, any
			monotonic counters must be seen as monotonic,
			despite successive reads happening from different
			views.

	e.	Any changes made via "view extended naming" or via
		"setview context naming" are visible in the other
		view.  For example, the file created by

			touch /vob/foo/bar.c.new

		would also be immediately visible as
		"/views/v1.1/vob/foo/bar.c.new" and vice versa.

	f.	Symbolic links from inside an MVFS filesystem act as
		expected, with the expected advice that views use
		relative rather than absolute symlinks for targets
		within the view.

		However, absolute symbolic links from inside an MVFS
		filesystem to files that are outside an MVFS filesystem
		work as expected.
