Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSLBP3h>; Mon, 2 Dec 2002 10:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264629AbSLBP3h>; Mon, 2 Dec 2002 10:29:37 -0500
Received: from pc-62-30-72-146-ed.blueyonder.co.uk ([62.30.72.146]:41856 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S264628AbSLBP3b>; Mon, 2 Dec 2002 10:29:31 -0500
Subject: Re: data corrupting bug in 2.4.20 ext3, data=journal
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       ext3 users list <ext3-users@redhat.com>
In-Reply-To: <1038831305.1852.102.camel@sisko.scot.redhat.com>
References: <3DE9C43D.61FF79C5@digeo.com>
	<3DEA0374.2040306@cyberone.com.au>  <3DEB08EE.CBA49BA@digeo.com> 
	<1038831305.1852.102.camel@sisko.scot.redhat.com>
Content-Type: multipart/mixed; boundary="=-4NEiODiUE2KHIPNoW1sJ"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 15:37:22 +0000
Message-Id: <1038843442.9666.221.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4NEiODiUE2KHIPNoW1sJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-12-02 at 12:15, Stephen C. Tweedie wrote:

> The problem is that ext3 is expecting that truncate_inode_pages() (and
> hence ext3_flushpage) is only called during a truncate.  That's what the
> function is named for, after all, and it's the hint we need to indicate
> that future writeback on the data we're discarding should be disabled
> (so that we don't get old data written on top of new data should the
> block get deallocated.)
> 
> But kill_supers() eventually calls truncate_inode_pages() too when we're
> doing the invalidate_inodes().

But we've already called fsync_super() at this point.  If that completes
synchronously, then the buffers will already be out of the journal and
queued for writeback when we get here, and clearing BH_JBDDirty won't
have any dire consequences.

Indeed, loading the ext3 module with "do_sync_supers=1" cures the
symptoms.

However, doing every superblock write synchronously is a non-starter, as
that requires a journal commit in the ext3 universe, and so this would
essentially force bdflush to serialise all of its filesystem flushes
(which is a real problem once you've got a significant number of
filesystems mounted.)  But the VFS simply doesn't have any clean way of
telling foo_write_super() whether the call needs to be completed
synchronously or asynchronously.

There *is* a totally unclean way, though.  kill_super() sets sb->s_root
to NULL before calling its final fsync_super(), and ext3 can easily
check that in ext3_write_super().  It's a nasty, messy dependency, but
should work for 2.4 at least.  For 2.5 we probably want to look at
passing an async flag down into the write_super.

The attached patch seems to fix things for me.

Cheers,
 Stephen


--=-4NEiODiUE2KHIPNoW1sJ
Content-Description: 
Content-Disposition: inline; filename=4201-umount-sync-super.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

--- linux-2.4-ext3merge/fs/ext3/super.c.=3DK0027=3D.orig	2002-12-02 15:35:1=
3.000000000 +0000
+++ linux-2.4-ext3merge/fs/ext3/super.c	2002-12-02 15:35:14.000000000 +0000
@@ -1640,7 +1640,12 @@
 	sb->s_dirt =3D 0;
 	target =3D log_start_commit(EXT3_SB(sb)->s_journal, NULL);
=20
-	if (do_sync_supers) {
+	/*
+	 * Tricky --- if we are unmounting, the write really does need
+	 * to be synchronous.  We can detect that by looking for NULL in
+	 * sb->s_root.
+	 */
+	if (do_sync_supers || !sb->s_root) {
 		unlock_super(sb);
 		log_wait_commit(EXT3_SB(sb)->s_journal, target);
 		lock_super(sb);

--=-4NEiODiUE2KHIPNoW1sJ--
