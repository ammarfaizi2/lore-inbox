Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262926AbTCKNo7>; Tue, 11 Mar 2003 08:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262927AbTCKNo7>; Tue, 11 Mar 2003 08:44:59 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:10624 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S262926AbTCKNoz>;
	Tue, 11 Mar 2003 08:44:55 -0500
Date: Tue, 11 Mar 2003 14:58:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, mikulas@artax.karlin.mff.cuni.cz, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-ID: <20030311135831.GA1501@dualathlon.random>
References: <Pine.LNX.4.44.0302101723540.32095-100000@artax.karlin.mff.cuni.cz> <Pine.LNX.4.44.0302100846090.2127-100000@home.transmeta.com> <20030210124000.456318e7.akpm@digeo.com> <20030210211806.GA22275@dualathlon.random> <20030210134434.72a59aed.akpm@digeo.com> <20030210215940.GC22275@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210215940.GC22275@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 10:59:40PM +0100, Andrea Arcangeli wrote:
> On Mon, Feb 10, 2003 at 01:44:34PM -0800, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > On Mon, Feb 10, 2003 at 12:40:00PM -0800, Andrew Morton wrote:
> > > > 	void sync_dirty_buffer(struct buffer_head *bh)
> > > > 	{
> > > > 		lock_buffer(bh);
> > > > 		if (test_clear_buffer_dirty(bh)) {
> > > > 			get_bh(bh);
> > > > 			bh->b_end_io = end_buffer_io_sync;
> > > > 			submit_bh(WRITE, bh);
> > > > 		} else {
> > > > 			unlock_buffer(bh);
> > > > 		}
> > > > 	}
> > > 
> > > If you we don't take the lock around the mark_dirty_buffer as Linus
> > > suggested (to avoid serializing in the non-sync case), why don't you
> > > simply add lock_buffer() to ll_rw_block() as we suggested originally
> > 
> > That is undesirable for READA.
> 
> in 2.4 we killed READA some release ago becuse of races:
> 
> 		case READA:
> #if 0	/* bread() misinterprets failed READA attempts as IO errors on SMP */
> 			rw_ahead = 1;
> #endif
> 
> so I wasn't focusing on it.
> 
> > > and
> > > you #define sync_dirty_buffer as ll_rw_block+wait_on_buffer if you
> > > really want to make the cleanup?
> > 
> > Linux 2.4 tends to contain costly confusion between writeout for memory
> > cleansing and writeout for data integrity.
> > 
> > In 2.5 I have been trying to make it very clear and explicit that these are
> > fundamentally different things.
> 
> yes, and these are in the memory cleansing area (only the journal
> commits [and somehow the superblock again in journaling] needs to be
> writeouts for data integrity). Data doesn't need to provide data
> integrity either, userspace has to care about that.

I'm experimenting with the lock_buffer() in ll_rw_block for one month
(not only for the sync writes like in Andrew's patch, but for everything
including reads), and I believe this is what triggered a deadlocks on my
most stressed machine this night.

I attached below the best debug info I collected so far (I've the full
SYSRQ+T too of course but the below should make it easier to focus on
the right place).

I'm going to backout that patch
(http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre4aa3/00_ll_rw_block-sync-race-1)
until this issue is resolved.

One simple case where it could introduce a deadlock is if a locked
buffer visible to the rest of the fs/vm isn't immediatly inserted in the
I/O queue, if two tasks runs that code at the same time they can
deadlock against each other. Another possibility is that the journal is
running a ll_rw_block on a locked buffer not yet in the I/O queue, and
it pretends not to deadlock for whatever reason. In all cases I believe
this is an issue in ext3 that would better be fixed, but it isn't
necessairly a bug with the 00_ll_rw_block patch backed out. Note: it
maybe something else too in my tree that deadlocked the box, but I
really doubt it could be something else, also see the wait_on_buffer
from ll_rw_block in the first line that makes it quite obvious that the
new behaviour is happening during the deadlock.

any help from the ext3 developers and everybody involved in this thread
(the 2.0, 2.2, 2.4 fsync races) is welcome, thanks!

(of course the vfs down shouldn't matter, the wait_on_buffers are
interesting here, but since they were in D state I didn't cut them out)

mutt          D 00000292     0 14627  24890                     (NOTLB)
Call Trace:    [__wait_on_buffer+86/144] [ext3_free_inode+391/1248] [ll_rw_block+309/464] [ext3_find_entry+828/864] [ext3_lookup+65/208]
  [lookup_hash+194/288] [sys_unlink+139/288] [system_call+51/56]
tee           D ECD560C0     0   111  11445                 110 (NOTLB)
Call Trace:    [journal_dirty_metadata+420/608] [__wait_on_buffer+86/144] [__cleanup_transaction+362/368] [journal_cancel_revoke+91/448] [log_do_checkpoint+299/448]
  [n_tty_receive_buf+400/1808] [journal_dirty_metadata+420/608] [n_tty_receive_buf+400/1808] [journal_dirty_metadata+420/608] [ext3_do_update_inode+375/992] [__jbd_kmalloc+35/176]
  [log_wait_for_space+130/144] [start_this_handle+191/864] [new_handle+75/112] [journal_start+165/208] [ext3_prepare_write+567/576] [write_chan+335/512]
  [generic_file_write_nolock+1023/2032] [pipe_wait+125/160] [generic_file_write+77/112] [ext3_file_write+57/224] [sys_write+163/336] [system_call+51/56]
python        D 00000180     0 21334    112 21336   21335       (NOTLB)
Call Trace:    [start_request+409/544] [__down+105/192] [__down_failed+8/12] [.text.lock.checkpoint+15/173] [start_this_handle+191/864]
  [new_handle+75/112] [journal_start+165/208] [ext3_lookup+0/208] [ext3_create+300/320] [vfs_create+153/304] [open_namei+1301/1456]
  [filp_open+62/112] [sys_open+83/192] [system_call+51/56]
python        D E2EB302C  2388 21335    112 21337         21334 (NOTLB)
Call Trace:    [dput+33/320] [__down+105/192] [__down_failed+8/12] [.text.lock.namei+265/988] [filp_open+62/112]
  [sys_open+83/192] [system_call+51/56]
procmail      D E51AC016     0 21378      1               19102 (NOTLB)
Call Trace:    [dput+33/320] [__down+105/192] [__down_failed+8/12] [.text.lock.namei+265/988] [filp_open+62/112]
  [sys_open+83/192] [system_call+51/56]
python        D C01186FF     0 21470    107         21471       (NOTLB)
Call Trace:    [do_page_fault+463/1530] [__down+105/192] [__jbd_kmalloc+35/176] [__down_failed+8/12] [.text.lock.checkpoint+15/173]
  [start_this_handle+191/864] [new_handle+75/112] [journal_start+165/208] [do_wp_page+416/1088] [ext3_dirty_inode+336/368] [__mark_inode_dirty+195/208]
  [update_inode_times+39/64] [generic_file_write_nolock+630/2032] [generic_file_write+77/112] [ext3_file_write+57/224] [sys_write+163/336] [system_call+51/56]
python        D C01186FF     0 21471    107               21470 (NOTLB)
Call Trace:    [do_page_fault+463/1530] [__down+105/192] [__jbd_kmalloc+35/176] [__down_failed+8/12] [.text.lock.checkpoint+15/173]
  [start_this_handle+191/864] [new_handle+75/112] [journal_start+165/208] [do_wp_page+416/1088] [ext3_dirty_inode+336/368] [__mark_inode_dirty+195/208]
  [update_inode_times+39/64] [generic_file_write_nolock+630/2032] [generic_file_write+77/112] [ext3_file_write+57/224] [sys_write+163/336] [system_call+51/56]
python        D 000001E0     0 21732  21731                     (NOTLB)
Call Trace:    [bread+32/160] [__down+105/192] [__jbd_kmalloc+35/176] [__down_failed+8/12] [.text.lock.checkpoint+15/173]
  [start_this_handle+191/864] [new_handle+75/112] [journal_start+165/208] [dput+33/320] [ext3_unlink+440/448] [vfs_unlink+233/480]
  [sys_unlink+183/288] [system_call+51/56]
procmail      D D0E13016     0 21914  21913                     (NOTLB)
Call Trace:    [dput+33/320] [__down+105/192] [__down_failed+8/12] [.text.lock.namei+265/988] [filp_open+62/112]
  [sys_open+83/192] [system_call+51/56]
procmail      D E39F3016     0 21999  21998                     (NOTLB)
Call Trace:    [dput+33/320] [__down+105/192] [__down_failed+8/12] [.text.lock.namei+265/988] [filp_open+62/112]
  [sys_open+83/192] [system_call+51/56]

Andrea
