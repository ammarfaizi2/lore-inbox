Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRDXWAX>; Tue, 24 Apr 2001 18:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRDXWAP>; Tue, 24 Apr 2001 18:00:15 -0400
Received: from mons.uio.no ([129.240.130.14]:41674 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S131563AbRDXWAD>;
	Tue, 24 Apr 2001 18:00:03 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104232241130.4968-100000@weyl.math.psu.edu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 24 Apr 2001 23:59:55 +0200
In-Reply-To: Alexander Viro's message of "Mon, 23 Apr 2001 22:53:15 -0400 (EDT)"
Message-ID: <shszod6j6w4.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alexander Viro <viro@math.psu.edu> writes:

     > On Mon, 23 Apr 2001, Jan Harkes wrote:

    >> On Mon, Apr 23, 2001 at 10:45:05PM +0200, Ingo Oeser wrote:

    >> > BTW: Is it still less than one page? Then it doesn't make me
    >> >    nervous. Why? Guess what granularity we allocate at, if we
    >> >    just store pointers instead of the inode.u. Or do you like
    >> >    every FS creating his own slab cache?

     > Oh, for crying out loud. All it takes is half an hour per
     > filesystem.  Here - completely untested patch that does it for
     > NFS. Took about that long. Absolutely straightforward, very
     > easy to verify correctness.

     > Some stuff may need tweaking, but not much (e.g. some functions
     > should take nfs_inode_info instead of inodes, etc.). From the
     > look of flushd cache it seems that we would be better off with
     > cyclic lists instead of single-linked ones for the hash, but I
     > didn't look deep enough.

     > So consider the patch below as proof-of-concept. Enjoy:

Hi Al,

  I believe your patch introduces a race for the NFS case. The problem
lies in the fact that nfs_find_actor() needs to read several of the
fields from nfs_inode_info. By adding an allocation after the inode
has been hashed, you are creating a window during which the inode can
be found by find_inode(), but during which you aren't even guaranteed
that the nfs_inode_info exists let alone that it's been initialized
by nfs_fill_inode().

One solution could be to have find_inode sleep on encountering a
locked inode. It would have to be something along the lines of

static struct inode * find_inode(struct super_block * sb, unsigned long ino, struct list_head *head, find_inode_t find_actor, void *opaque)
{
        struct list_head *tmp;
        struct inode * inode;

        tmp = head;
        for (;;) {
                tmp = tmp->next;
                inode = NULL;
                if (tmp == head)
                        break;
                inode = list_entry(tmp, struct inode, i_hash);
                if (inode->i_ino != ino)
                        continue;
                if (inode->i_sb != sb)
                        continue;
                if (find_actor) {
                        if (inode->i_state & I_LOCK) {
                                spin_unlock(&inode_lock);
                                __wait_on_inode(inode);
                                spin_lock(&inode_lock);
                                tmp = head;
                                continue;
                        }
                        if (!find_actor(inode, ino, opaque))
                                continue;
                }
                break;
        }
        return inode;
}


Cheers,
   Trond
