Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUIHMh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUIHMh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUIHMgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:36:45 -0400
Received: from unthought.net ([212.97.129.88]:16834 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262837AbUIHMfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:35:25 -0400
Date: Wed, 8 Sep 2004 14:35:24 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: Major XFS problems...
Message-ID: <20040908123524.GZ390@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear List,

This is the scenario; two high performance NFS file servers needed;
quota support is a must, and so far it seems that we are out of luck :*(

Suggestions and help would be very welcome.

We don't care much about which filesystem to use - so far we use XFS
because of the need for (journalled) quota.
*) ext2 - no-go, because of lack of journal
*) ext3 - no-go, because quota isn't journalled
*) JFS - no-go, because of lack of quota
*) reiserfs - no-go, because of lack of quota
*) XFS seems to be the *only* viable filesystem in this scenario - if
   anyone has alternative suggestions, we'd like to hear about it.

Oh, and Hans, I don't think we can fund your quota implementation right
now - no hard feelings ;)

History of these projects:

The first server, an IBM 345 with external SCSI enclosure and hardware
RAID, quickly triggered bugs in XFS under heavy usage:

First XFS bug:
---------------
http://oss.sgi.com/bugzilla/show_bug.cgi?id=309

Submitted in februrary this year - requires server reboot, NFS clients
will then re-trigger the bug immediately after the NFS server is started
again.  Clearly not a pleasent problem.

A fairly simple patch is available, which solves the problem in the most
common cases.  This simple patch has *not*yet* been included in 2.6.8.1.

A lot of people are seeing this - the SGI bugzilla is evidence of this,
so is google.

Second XFS bug:
---------------
Also causes the 'kernel BUG at fs/xfs/support/debug.c:106' message to be
printed. This bug is not solved by applying the simple patch to the
first problem.

How well known this problem is, I don't know - I can get more details on
this if anyone is actually interested in working on fixing XFS.

Third XFS bug:
--------------
XFS causes lowmem oom, triggering the OOM killer. Reported by
as@cohaesio.com on the 18th of august.

On the 24th of august, William Lee Irwin gives some suggestions and
mentions  "xfs has some known bad slab behavior."

So, it's normal to OOM the lowmem with XFS? Again, more info can be
presented if anyone cares about fixing this.

Stability on large filesystems:
-------------------------------
On a 600+G filesystem with some 17M files, we are currently unable to
run a backup of the filesystem.

Some 4-8 hours after the backup has started, the dreaded 'debug.c:106'
message will appear (at some random place thru the filesystem - it is
not a consistent error in one specific location in the filesystem), and
the server will need a reboot.

Obviously, running very large busy filesystems while being unable to
back them up, is not a very pleasent thing to do...


Second server:

On a somewhat smaller server, I recently migrated to XFS (beliving the
most basic problems had been ironed out).  It took me about a day to
trigger the 'debug.c:106' error message from XFS, on vanilla 2.6.8.1.

After applying the simple fix (the fix for the first XFS problem as
described above), I haven't had problems with this particular server
since - but it is clearly serving fewer clients with fewer disks and a
lot less storage and traffic.

While the small server seems to be running well now, the large one has
an average uptime of about one day (!)   Backups will crash it reliably,
when XFS doesn't OOM the box at random.

A little info on the hardware:
 Big server             Small server
---------------------- -----------------------
Intel Xeon              Dual Athlon MP
7 external SCSI disks   4 internal IDE disks
IBM hardware RAID       Software RAID-1 + LVM
600+ GB XFS             ~150 GB XFS
17+ M files             ~1 M files

Both primarily serve NFS to a bunch of clients. Both run vanilla 2.6.8.1
plus the aforementioned patch for the first XFS problem we encountered.

<frustrated_admin mode="on">

Does anyone actually use XFS for serious file-serving?  (yes, I run it
on my desktop at home and I don't have problems there - such reports are
not really relevant).

Is anyone actually maintaining/bugfixing XFS?  Yes, I know the
MAINTAINERS file, but I am a little bit confused here - seeing that
trivial-to-trigger bugs that crash the system and have simple fixes,
have not been fixed in current mainline kernels.

If XFS is a no-go because of lack of support, is there any realistic
alternatives under Linux (taking our need for quota into account) ?

And finally, if Linux is simply a no-go for high performance file
serving, what other suggestions might people have?  NetApp?

</>

Thank you very much,

-- 

 / jakob

