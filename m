Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUBUH5x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 02:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUBUH5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 02:57:53 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25759 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261157AbUBUH5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 02:57:51 -0500
Date: Sat, 21 Feb 2004 08:58:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tridge <tridge@samba.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040221075853.GA828@elte.hu>
References: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org> <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220184822.GA23460@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> perhaps using a simple 64-bit generation counter would be better.
> Samba would get a new syscall to get the sum of each generation
> counter down to the root dentry - a total validation of the pathname.
> If the counter matches with that in the userspace cache entry then no
> need to re-create the cache. Such generation counters would be usable
> for multiple file servers as well. Hm?

generation counters are problematic if they are not persistent. But
there's a pretty natural persistent 'generation counter' which could be
used for Samba's purpose: the mtime of the directory. The problem right
now is that it doesnt have enough resolution to be a true unique
generation counter. But having high-resolution mtime is a goal anyway.

XFS is one filesystem that has high-resolution mtime:

 typedef struct xfs_timestamp {
         __int32_t       t_sec;          /* timestamp seconds */
         __int32_t       t_nsec;         /* timestamp nanoseconds */
 } xfs_timestamp_t;

monotonity is important: two successive directory operations to not be
possible within the same nanosecond. This is not possible with current
hardware - but how about future hardware? Can we make an assumption like
this?

hardware that has no high-resolution clock can be supported too: by
forcing mtime to be monotonic: if current time <= last_mtime, then
last_mtime++.

so there's only one new syscall necessary for Samba to validate its name
cache:

	sys_get_path_timestamp(char *path, struct timeval *tv);

this returns the _largest_ (youngest) timestamp out of the dentry chain
down to the root dentry. This is in essence the 'age' of the whole path,
with all components taken into account. If any directory along the path
is renamed, the age changes automatically.

filesystems that dont have 64-bit, monotonic timestamps will return
-ENOSYS. This should include even XFS at the moment, because the
timestamp is not guaranteed to be monotonic.

if any path component down the tree doesnt support monotonic timestamps,
then -ENOSYS is returned. (In mixed-type filesystem installations
chroot() can be used to limit Samba's root to a monotonic timestamp
capable filesystem.)

there's at least one problem with this approach:

- the 'age' of a path changes more often than what Samba's caching needs 
  are: e.g. it changes if any directory within the path is written to.

but this is not a big problem i believe - the fastpath is preserved and
a mechanism is presented to validate the cache with a single syscall. 

any other problems with this concept?

	Ingo
