Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263310AbSITR2A>; Fri, 20 Sep 2002 13:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263320AbSITR15>; Fri, 20 Sep 2002 13:27:57 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:31498 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S263310AbSITR1s>; Fri, 20 Sep 2002 13:27:48 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15755.23491.712588.305582@laputa.namesys.com>
Date: Fri, 20 Sep 2002 21:32:51 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: locking rules for ->dirty_inode()
In-Reply-To: <3D8B5111.A318D63D@digeo.com>
References: <3D8B4421.59392B30@digeo.com>
	<15755.19895.544309.44729@laputa.namesys.com>
	<3D8B5111.A318D63D@digeo.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Microsoft: Making the world a better place... for Microsoft.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov wrote:
 > > 
 > > ...
 > > Actually, I came over this while trying to describe lock ordering in
 > > reiser4 after I just started integrating other kernel locks there. I
 > > wonder, has somebody already done this, writing up kernel lock
 > > hierarchy, that is?
 > > 
 > 
 > I've been keeping the comment at the top of filemap.c uptodate when
 > I discover things.  It got smaller a while ago when certain rude
 > locks were spoken to.
 > 
 > Really, this form of representation isn't rich enough, but the
 > format certainly provides enough info to know when you might be
 > taking locks in the wrong order, and it tells you where to look
 > to see them being taken.
 > 
 > The problem with the format is that locks are only mentioned once,
 > and it can't describe the whole graph.  Maybe it needs something
 > like:
 > 
 > 
 >  *  ->i_shared_lock             (vmtruncate)
 >  *    ->private_lock            (__free_pte->__set_page_dirty_buffers)
 >  *      ->swap_list_lock
 >  *        ->swap_device_lock    (exclusive_swap_page, others)
 >  *          ->mapping->page_lock
 >  *      ->inode_lock            (__mark_inode_dirty)
 >  *        ->sb_lock             (fs/fs-writeback.c)
 > +*  ->i_shared_lock
 > +*    ->page_table_lock         (lots of places)
 >  */
 > 
 > Don't know.  Maybe someone somewhere has developed a notation
 > for this?   How are you doing it?

I am doing it roughly in the same way: in a similar diagram where each lock is
mentioned exactly once, locks can be acquired from the left to the
right. Locks on the same indentation level are unordered and cannot be held at
the same time. This is enough to express lock *ordering*, whenever it
exists. For example, you diagram above gives:

->i_shared_lock             (vmtruncate)
  ->private_lock            (__free_pte->__set_page_dirty_buffers)
    ->swap_list_lock
      ->swap_device_lock    (exclusive_swap_page, others)
        ->mapping->page_lock
    ->inode_lock            (__mark_inode_dirty)
      ->sb_lock             (fs/fs-writeback.c)
  ->page_table_lock         (lots of places)

And it means that neither ->private_lock and ->page_table_lock nor
->swap_list_lock and ->inode_lock cannot be held at the same time.

As you mentioned (if I understood correctly) this is insufficient to
express where locks are taken and, more generally, how the lock graph is
embedded into the call graph. But lock ordering itself is quite useful. 

For example, in reiser4 we have SPIN_LOCK_FUNCTIONS() macro. If one has

typedef struct txn_handle {
  ...
  spinlock_t   guard;
  ...
} txn_handle;

then SPIN_LOCK_FUNCTIONS(txn_handle, guard) will generate functions like

spin_lock_txn_handle();
spin_unlock_txn_handle();
spin_trylock_txn_handle(); etc.

In debugging mode, these functions (aside from manipulating locks)
modify special per-thread counters. This allows one to specify lock
ordering constraints. Each spin_lock_foo() function checks
spin_ordering_pred_foo() macro before taking lock. This was really
helpful during early debugging.

Nikita.
