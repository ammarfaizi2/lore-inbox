Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTEVPOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTEVPOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:14:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15639 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261936AbTEVPN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:13:59 -0400
Subject: [RFC 2.4] mmap+IO potential dangling IO in ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Cc: Stephen Tweedie <sct@redhat.com>, Andrew Morton <akpm@digeo.com>,
       "Marcelo W. Tosatti" <marcelo@conectiva.com.br>
Content-Type: multipart/mixed; boundary="=-JPGqIk1n2SCq2jnhSu6x"
Organization: 
Message-Id: <1053617219.2263.87.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 May 2003 16:26:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JPGqIk1n2SCq2jnhSu6x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I've been chasing a possible data corrupter in ext3.  Right now I can't
reproduce any visible corruption in 2.4.20-based kernels, but using a
test-harness device driver, I can definitely reproduce an IO scenario
which is a corruption opportunity when there is mmaped IO on pages which
extend beyond EOF on regular files.  At root is some unexpected
behaviour in block_write_full_page().

The scenario is:

        File is extended to a non-page-aligned size via truncate or
        normal writes.

        User mmaps the file and writes to the last (incomplete) page via
        the mmap.  
        
        VM starts writepage() on a page.  ext3_writepage calls into
        block_write_full_page (as usual), but unusually, this specific
        case does _NOT_ start the IO.  block_write_full_page drops down
        to __prepare_write() and __commit_write(), which leaves the
        buffers dirty but unlocked.

        Commit begins on the previous ext3 transaction, including the
        writepage

        File gets truncated or unlinked
        
        vmtruncate gets down to ext3_flushpage which calls journal_unmap
        to flush the IO.  The buffer_head can't be thrown away
        immediately, as it is still owned by the committing transaction.
        
        Commit now scans the transaction's asyncdata list (buffers
        committed to IO by writepage), waits for IO to complete. 
        However, it does not catch this dirty buffer, because
        block_write_full_page did not schedule the IO so the bh is not
        locked.  The ext3 synchronisation here assumes that writepage
        does in fact schedule IO.
        
We've now got a stray IO to a random block on disk.  As soon as the
commit completes, that block can be reallocated to another file.  Now,
*IF* the new file gets flushed to disk before the old IO has completed,
we've corrupted the contents on disk.

As I said, I can't see any actual data corruption on 2.4.20, but I've
been able to demonstrate the problem in theory there.  The "testdrive"
testing device driver is a loop.c extension which tracks all IOs on a
device and which can detect when multiple IOs are in flight for the same
disk block.  Using that, plus multiple instances of a test program which
performs mmap and O_SYNC IO on files at random, deleting the files after
each pass, I can see colliding IOs after about an hour or so.  I can
reproduce it much faster on some older kernels.  Current testdrive is at

        http://people.redhat.com/sct/patches/ext3-2.4/dev-20030314/50-debug/3004-testdrive.patch
        
and it patches against latest 2.4 bk with just one minor collision in a
Makefile.

So far, the I've only seen this happen with the combination of mmap at
non-page-aligned EOF, plus subsequent O_SYNC IO on a later file so that
the second use of the disk block can race against the first.  I'm
failing to see this manifest as user-space data corruption either
because caching effects hide the bad IO from user space, or because the
elevator is still submitting the two IOs in original order.  But either
way, this stray IO should not be getting through.

There's an easy workaround in ext3, attached: just clean the dirty bit
if we see an asyncdata (ie. writepage) buffer which has been freed.  I
suspect that the ideal solution may be to make block_write_full_page()
submit its IOs to disk even in the case where it falls through to
prepare/commit_write, but that's a bigger change in an area of the
kernel which is rarely hit and hence hard to test.

Cheers,
 Stephen



--=-JPGqIk1n2SCq2jnhSu6x
Content-Disposition: inline; filename=4201-ext3-freed-async.patch
Content-Type: text/plain; name=4201-ext3-freed-async.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- linux-2.4-ext3merge/fs/jbd/commit.c.=3DK0000=3D.orig
+++ linux-2.4-ext3merge/fs/jbd/commit.c
@@ -272,6 +272,11 @@ sync_datalist_empty:
 	 */
 	while ((jh =3D commit_transaction->t_async_datalist)) {
 		struct buffer_head *bh =3D jh2bh(jh);
+		if (__buffer_state(bh, Freed)) {
+			BUFFER_TRACE(bh, "Cleaning freed buffer");
+			clear_bit(BH_Freed, &bh->b_state);
+			clear_bit(BH_Dirty, &bh->b_state);
+		}
 		if (buffer_locked(bh)) {
 			spin_unlock(&journal_datalist_lock);
 			unlock_journal(journal);

--=-JPGqIk1n2SCq2jnhSu6x--
