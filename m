Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSITQ1w>; Fri, 20 Sep 2002 12:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSITQ1v>; Fri, 20 Sep 2002 12:27:51 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:10 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S261855AbSITQ1u>;
	Fri, 20 Sep 2002 12:27:50 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15755.19895.544309.44729@laputa.namesys.com>
Date: Fri, 20 Sep 2002 20:32:55 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: locking rules for ->dirty_inode()
In-Reply-To: <3D8B4421.59392B30@digeo.com>
References: <15755.14336.739277.700462@laputa.namesys.com>
	<3D8B4421.59392B30@digeo.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov wrote:
 > > 
 > > Hello,
 > > 
 > > Documentation/filesystems/Locking states that all super operations may
 > > block, but __set_page_dirty_buffers() calls
 > > 
 > >    __mark_inode_dirty()->s_op->dirty_inode()
 > > 
 > > under mapping->private_lock spin lock. This seems strange, because file
 > > systems' ->dirty_inode() assume that they are allowed to block. For
 > > example, ext3_dirty_inode() allocates memory in
 > > 
 > >    ext3_journal_start()->journal_start()->new_handle()->...
 > > 
 > 
 > OK, thanks.
 > 
 > mapping->private_lock is taken there to pin page->buffers()
 > (Can't lock the page because set_page_dirty is called under
 > page_table_lock, and other locks).
 > 
 > I'm sure we can just move the spin_unlock up to above the
 > TestSetPageDirty(), but I need to zenuflect for a while over
 > why I did it that way.
 > 
 > It's necessary to expose buffer-dirtiness and page-dirtiness
 > to the rest of the world in the correct order.  If we set the
 > page dirty and then the buffers, there is a window in which writeback
 > could find the dirty page, try to write it, discover clean buffers
 > and mark the page clean.  We would end up with a !PageDirty page,
 > on mapping->clean_pages, with dirty buffers.  It would never be
 > written.
 > 
 > Yup.  We can move that spin_unlock up ten lines.

Actually, I came over this while trying to describe lock ordering in
reiser4 after I just started integrating other kernel locks there. I
wonder, has somebody already done this, writing up kernel lock
hierarchy, that is?

Nikita.
