Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTB0Imh>; Thu, 27 Feb 2003 03:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTB0Imh>; Thu, 27 Feb 2003 03:42:37 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:55002 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261934AbTB0Imd>; Thu, 27 Feb 2003 03:42:33 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: filesystem access slowing system to a crawl
Date: Thu, 27 Feb 2003 09:51:35 +0100
User-Agent: KMail/1.4.3
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <20030219174940.GJ14633@x30.suse.de> <200302270017.36598.m.c.p@wolk-project.de>
In-Reply-To: <200302270017.36598.m.c.p@wolk-project.de>
MIME-Version: 1.0
Message-Id: <200302270949.47226.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ZXLYT8R01L7PC7N6QNVX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_ZXLYT8R01L7PC7N6QNVX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 27 February 2003 00:17, Marc-Christian Petersen wrote:

Hi again,

> Hi Marcelo,
> apply this, please!
Patch is by Andrea. I will send this every day once until I see the merge=
 in=20
-BK or a mail from you here on LKML why you don't take it!

P.S.: I see some bogus patches in -BK (now -pre5) which got merged. This =
patch
      exists since ages (inode-highmem-2), survived tons of testing and i=
t is
      a must!

I can only _repeat_ Andrea (I agree 100% with his statement):

------------------------------------------------------------------------
this is a pre kernel, it's meant to *test* stuff, if anything will go
wrong we're here ready to fix it immediatly. Sure, applying the patch of
the last minute to an -rc just before releasing the new official kernel
w/o any kind of testing was a bad idea, but we must not be too much
conservative either, especially like in these cases where we are fixing
bugs, I mean we can't delay bugfixes with the argument that they could
introduce new bugs, otherwise we can as well stop fixing bugs.

Also note that this stuff is being tested aggressively for a very long
time by lots of people, it's not a last minute patch like the xdr
highmem deadlock ;).
------------------------------------------------------------------------


regards!

>
> > On Wed, Feb 19, 2003 at 05:42:34PM +0100, Marc-Christian Petersen wro=
te:
> > > On Wednesday 05 February 2003 10:39, Andrew Morton wrote:
> > >
> > > Hi Andrew,
> > >
> > > > > Running just "find /" (or ls -R or tar on a large directory)
> > > > > locally slows the box down to absolute unresponsiveness - it ta=
kes
> > > > > minutes to just run ps and kill the find process. During that t=
ime,
> > > > > kupdated and kswapd gobble up all available CPU time.
> > > >
> > > > Could be that your "low memory" is filled up with inodes.  This w=
ould
> > > > only happen in these tests if you're using ext2, and there are a
> > > > *lot* of directories.
> > > > I've prepared a lineup of Andrea's VM patches at
> > > > It would be useful if you could apply 10_inode-highmem-2.patch an=
d
> > > > report back.  It applies to 2.4.19 as well, and should work OK th=
ere.
> > >
> > > is there any reason why this (inode-highmem-2) has never been submi=
tted
> > > for inclusion into mainline yet?
>
> Marcelo please include this:
> http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.=
4.21
>pre4aa3/10_inode-highmem-2 other fixes should be included too but they d=
on't
> apply cleanly yet unfortunately, I (or somebody else) should rediff the=
m
> against mainline.
--------------Boundary-00=_ZXLYT8R01L7PC7N6QNVX
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="inode-highmem-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="inode-highmem-2.patch"

diff -urNp 2.4.19pre9/fs/inode.c 2.4.19pre9aa2/fs/inode.c
--- 2.4.19pre9/fs/inode.c	Wed May 29 02:12:36 2002
+++ 2.4.19pre9aa2/fs/inode.c	Fri May 31 04:43:41 2002
@@ -665,35 +665,88 @@ void prune_icache(int goal)
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
-	int count;
+	int count, pass;
 	struct inode * inode;
 
-	spin_lock(&inode_lock);
+	count = pass = 0;
+	entry = &inode_unused;
 
-	count = 0;
-	entry = inode_unused.prev;
-	while (entry != &inode_unused)
-	{
-		struct list_head *tmp = entry;
+	spin_lock(&inode_lock);
+	while (goal && pass++ < 2) {
+		entry = inode_unused.prev;
+		while (entry != &inode_unused)
+		{
+			struct list_head *tmp = entry;
 
-		entry = entry->prev;
-		inode = INODE(tmp);
-		if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
-			continue;
-		if (!CAN_UNUSE(inode))
-			continue;
-		if (atomic_read(&inode->i_count))
-			continue;
-		list_del(tmp);
-		list_del(&inode->i_hash);
-		INIT_LIST_HEAD(&inode->i_hash);
-		list_add(tmp, freeable);
-		inode->i_state |= I_FREEING;
-		count++;
-		if (!--goal)
-			break;
+			entry = entry->prev;
+			inode = INODE(tmp);
+			if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
+				continue;
+			if (atomic_read(&inode->i_count))
+				continue;
+			if (pass == 2 && !inode->i_state && !CAN_UNUSE(inode)) {
+				if (inode_has_buffers(inode))
+					/*
+					 * If the inode has dirty buffers
+					 * pending, start flushing out bdflush.ndirty
+					 * worth of data even if there's no dirty-memory
+					 * pressure. Do nothing else in this
+					 * case, until all dirty buffers are gone
+					 * we can do nothing about the inode other than
+					 * to keep flushing dirty stuff. We could also
+					 * flush only the dirty buffers in the inode
+					 * but there's no API to do it asynchronously
+					 * and this simpler approch to deal with the
+					 * dirty payload shouldn't make much difference
+					 * in practice. Also keep in mind if somebody
+					 * keeps overwriting data in a flood we'd
+					 * never manage to drop the inode anyways,
+					 * and we really shouldn't do that because
+					 * it's an heavily used one.
+					 */
+					wakeup_bdflush();
+				else if (inode->i_data.nrpages)
+					/*
+					 * If we're here it means the only reason
+					 * we cannot drop the inode is that its
+					 * due its pagecache so go ahead and trim it
+					 * hard. If it doesn't go away it means
+					 * they're dirty or dirty/pinned pages ala
+					 * ramfs.
+					 *
+					 * invalidate_inode_pages() is a non
+					 * blocking operation but we introduce
+					 * a dependency order between the
+					 * inode_lock and the pagemap_lru_lock,
+					 * the inode_lock must always be taken
+					 * first from now on.
+					 */
+					invalidate_inode_pages(inode);
+			}
+			if (!CAN_UNUSE(inode))
+				continue;
+			list_del(tmp);
+			list_del(&inode->i_hash);
+			INIT_LIST_HEAD(&inode->i_hash);
+			list_add(tmp, freeable);
+			inode->i_state |= I_FREEING;
+			count++;
+			if (!--goal)
+				break;
+		}
 	}
 	inodes_stat.nr_unused -= count;
+
+	/*
+	 * the unused list is hardly an LRU so it makes
+	 * more sense to rotate it so we don't bang
+	 * always on the same inodes in case they're
+	 * unfreeable for whatever reason.
+	 */
+	if (entry != &inode_unused) {
+		list_del(&inode_unused);
+		list_add(&inode_unused, entry);
+	}
 	spin_unlock(&inode_lock);
 
 	dispose_list(freeable);
diff -urNp 2.4.19pre9/mm/filemap.c 2.4.19pre9aa2/mm/filemap.c
--- 2.4.19pre9/mm/filemap.c	Wed May 29 02:12:46 2002
+++ 2.4.19pre9aa2/mm/filemap.c	Fri May 31 04:44:29 2002
@@ -194,7 +194,7 @@ void invalidate_inode_pages(struct inode
 		if (TryLockPage(page))
 			continue;
 
-		if (page->buffers && !try_to_free_buffers(page, 0))
+		if (page->buffers && !try_to_release_page(page, 0))
 			goto unlock;
 
 		if (page_count(page) != 1)

--------------Boundary-00=_ZXLYT8R01L7PC7N6QNVX--

