Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbQLDNwb>; Mon, 4 Dec 2000 08:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130218AbQLDNwW>; Mon, 4 Dec 2000 08:52:22 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:55295 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130187AbQLDNwJ>; Mon, 4 Dec 2000 08:52:09 -0500
Message-ID: <3A2B9B39.AA240475@uow.edu.au>
Date: Tue, 05 Dec 2000 00:25:13 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks  Re: test12-pre4
In-Reply-To: <Pine.LNX.4.10.10012031828170.22914-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012040054400.5055-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 3 Dec 2000, Linus Torvalds wrote:
> 
> >
> > Synching up with Alan and various other stuff. The most important one
> > being the fix to the inode dirty block list.
> 
> It doesn't solve the problem. If you unlink a file with dirty metadata
> you have a nice chance to hit the BUG() in inode.c:83. I hope that patch
> below closes all remaining holes. See analysis in previous posting
> (basically, bforget() is not enough when we free the block; bh should
> be removed from the inode's list regardless of the ->b_count).

It's still happening.

The good news is that I have a machine which does it within 15-30
minutes.  The only interesting difference is that is has 64 megs
of RAM (all the others are 256) and its IDE system is a lot slower.

I removed the UnlockPage() at line 623 of vmscan.c because that's
causing assertion failures at swap.c:271.

I changed destroy_inode() thusly:

static void destroy_inode(struct inode *inode)
{
        if (!list_empty(&inode->i_dirty_buffers)) {
                struct task_struct *tsk;

                printk("&inode->i_dirty_buffers=0x%p\n", &inode->i_dirty_buffers);
                printk("next=0x%p\n", inode->i_dirty_buffers.next);
                printk("prev=0x%p\n", inode->i_dirty_buffers.prev);

                read_lock(&tasklist_lock);
                for_each_task(tsk) {
                        printk("[%s]\n", tsk->comm);
                        show_stack(tsk->thread.esp);
                        printk("\n\n");
                }
                read_unlock(&tasklist_lock);

                BUG();
        }
        kmem_cache_free(inode_cachep, (inode));
}

So we get a full task dump.  Otherwise this is vanilla test12-pre4 plus
your bforget_inode() patch.  SMP kernel on UP hardware, so this is a
good snapshot of system state.

First the BUG trace:

&inode->i_dirty_buffers=0xc1cc6c98
next=0xc03e9a78
prev=0xc03e9a78

Trace; c021b8c5 <tvecs+5a3d/1a358>
Trace; c021b9c2 <tvecs+5b3a/1a358>
Trace; c0146a86 <iput+18e/194>
Trace; c01451a6 <d_delete+66/ac>
Trace; c013df5d <vfs_unlink+18d/1c0>
Trace; c013e035 <sys_unlink+a5/118>
Trace; c0108fdf <system_call+33/38>

That's the same as before. Now some other interesting tasks.
The fourth dbench may be interesting?  And look at what
kswapd is doing.


[dbench]
Trace; c012bf9b <wakeup_kswapd+b3/d0>
Trace; c012cc9e <__alloc_pages+246/2f8>
Trace; c012671c <generic_file_write+270/454>
Trace; c0144589 <dput+19/174>
Trace; c013092a <sys_write+8e/c4>

[dbench]
Trace; c012bf9b <wakeup_kswapd+b3/d0>
Trace; c012cc9e <__alloc_pages+246/2f8>
Trace; c012671c <generic_file_write+270/454>
Trace; c0144589 <dput+19/174>
Trace; c013092a <sys_write+8e/c4>

[dbench]
Trace; c01c1557 <vgacon_cursor+1df/1e8>
Trace; c018a34e <set_cursor+6e/80>
Trace; c0118851 <printk+1a1/1b0>
Trace; c0118851 <printk+1a1/1b0>
Trace; c4800000 <_end+44e2e4c/10503eac>
Trace; c0109324 <show_stack+d4/e8>
Trace; c020c2c3 <stext_lock+759f/843c>
Trace; c020c2c3 <stext_lock+759f/843c>
Trace; c0145875 <destroy_inode+75/c4>
Trace; c021b9b9 <tvecs+5b31/1a358>
Trace; c0146a86 <iput+18e/194>
Trace; c01451a6 <d_delete+66/ac>
Trace; c013df5d <vfs_unlink+18d/1c0>
Trace; c010002b <startup_32+2b/cb>

(This is `current')

[dbench]
Trace; c01317fd <__wait_on_buffer+4d/e0>
Trace; c0132cd9 <bread+45/70>
Trace; c0156d6c <ext2_read_inode+104/3ec>
Trace; c01465a8 <get_new_inode+cc/178>
Trace; c014685d <iget4+f5/100>


[kupdate]
Trace; c01156ea <schedule_timeout+7a/9c>
Trace; c0115614 <process_timeout+0/5c>
Trace; c0135304 <kupdate+a4/110>
Trace; c01074c3 <kernel_thread+23/30>

[bdflush]
Trace; c0135255 <bdflush+135/140>
Trace; c01074c3 <kernel_thread+23/30>

[kreclaimd]
Trace; c0116209 <interruptible_sleep_on+4d/80>
Trace; c012c03f <kreclaimd+5b/dc>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01074c3 <kernel_thread+23/30>

[kswapd]
Trace; c01317fd <__wait_on_buffer+4d/e0>
Trace; c0132cd9 <bread+45/70>
Trace; c0157180 <ext2_update_inode+12c/408>
Trace; c015748e <ext2_write_inode+32/6c>
Trace; c0145d59 <sync_all_inodes+11d/168>
Trace; c0146221 <prune_icache+31/124>
Trace; c0146335 <shrink_icache_memory+21/30>
Trace; c012bd3b <do_try_to_free_pages+5b/88>
Trace; c0217b71 <tvecs+1ce9/1a358>
Trace; c012bdf6 <kswapd+8e/180>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01074c3 <kernel_thread+23/30>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
