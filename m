Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbQLBOar>; Sat, 2 Dec 2000 09:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbQLBOai>; Sat, 2 Dec 2000 09:30:38 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:29894 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129434AbQLBOaU>; Sat, 2 Dec 2000 09:30:20 -0500
Message-ID: <3A29008E.F05E5C95@uow.edu.au>
Date: Sun, 03 Dec 2000 01:00:46 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au>,
			<3A26C82D.26267202@uow.edu.au>; from andrewm@uow.edu.au on Fri, Dec 01, 2000 at 08:35:41AM +1100 <20001201141659.A4562@redhat.com> <3A2873A1.3EFEA29@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> "Stephen C. Tweedie" wrote:
> >
> > Hi,
> >
> > On Fri, Dec 01, 2000 at 08:35:41AM +1100, Andrew Morton wrote:
> > >
> > > I bet this'll catch it:
> > >
> > >  static __inline__ void list_del(struct list_head *entry)
> > >  {
> > >       __list_del(entry->prev, entry->next);
> > > +     entry->next = entry->prev = 0;
> > >  }
> >
> > No, because the buffer hash list is never referenced unless
> > buffer->b_inode is non-null, so we can't ever do a double-list_del on
> > the buffer.
> >
> > The patch below should fix it.  It has been sent to Linus.  The
> > important part is the first hunk of the inode.c diff.
> 
> Testing test11-pre3 with your inode.c patch and the above list_del
> patch.  x86 dual processor, IDE.  Same workload as before, except
> I cut out misc001 (and the machine recovered almost immediately
> when I killed everything!  Need more testing to characterise this).
> 
> kernel BUG at inode.c:83!  The trace is below.  Now, this was
> probably triggered by my list_del change.  If so it means
> that we're doing a list_empty() test on a list_head which
> has actually been deleted from a list.  So it's possibly the
> actual assertion in destroy_inode() which is a little bogus.
> 
> But the wierd thing is that this BUG only hit a single time,
> after three hours of intensive testing.  If my theory is
> right, the BUG should hit every time.   Will investigate further...
> 

It appears that this problem is not fixed.

My destroy_inode() is now

static void destroy_inode(struct inode *inode)
{
        if (!list_empty(&inode->i_dirty_buffers)) {
                printk("&inode->i_dirty_buffers=0x%p\n", &inode->i_dirty_buffers);
                printk("next=0x%p\n", inode->i_dirty_buffers.next);
                printk("prev=0x%p\n", inode->i_dirty_buffers.prev);
                BUG();
        }
        kmem_cache_free(inode_cachep, (inode));
}

After 45 minutes of running the previously described tests:

Dec  2 16:14:30 mnm kernel: &inode->i_dirty_buffers=0xcfe16878
Dec  2 16:14:30 mnm kernel: next=0xc16f3678
Dec  2 16:14:30 mnm kernel: prev=0xc16f3678
Dec  2 16:14:30 mnm kernel: kernel BUG at inode.c:86!

We're throwing away an inode which has live data on its
dirty buffers list.

This is 2.4.0-test11-pre3 + list_del patch + sct's inode
patch (buffer.c, inode.c).  x86 dual processor.  gcc 2.91.66.
I rediffed my tree.  No rogue patches.

It's not an SMP thing - the address patterns match up with the
previously reported uniprocessor corruption.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
