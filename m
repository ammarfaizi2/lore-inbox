Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLCWMZ>; Sun, 3 Dec 2000 17:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLCWMQ>; Sun, 3 Dec 2000 17:12:16 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:21397 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129248AbQLCWMN>; Sun, 3 Dec 2000 17:12:13 -0500
Message-ID: <3A2ABEC5.97AF9C61@uow.edu.au>
Date: Mon, 04 Dec 2000 08:44:37 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>, Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Jonathan Hudson <jonathan@daria.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <3A29008E.F05E5C95@uow.edu.au> <Pine.GSO.4.21.0012021015310.28923-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 3 Dec 2000, Andrew Morton wrote:
> 
> > It appears that this problem is not fixed.
> 
> Sure, it isn't. Place where the shit hits the fan: fs/buffer.c::unmap_buffer().
> Add the call of remove_inode_queue(bh) there and see if it helps. I.e.
> 
> ed fs/buffer.c <<EOF
> /unmap_buffer/
> /}/i
>                 remove_inode_queue(bh);
> .
> wq
> EOF
> 

Sorry, it's still failing.  It took three hours.

&inode->i_dirty_buffers=0xca9e63f8
next=0xc30a2598
prev=0xc30a2598
kernel BUG at inode.c:86!                                                               

The ksymoops output is here, as is my current diff wrt test12-pre3.

ksymoops 0.7c on i686 2.4.0-test12-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12-pre3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
Dec  4 01:56:02 mnm kernel: EIP:    0010:[<c0145758>]
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  4 01:56:02 mnm kernel: EFLAGS: 00010282
Dec  4 01:56:02 mnm kernel: eax: 0000001a   ebx: ca9e63e0   ecx: 00000001   edx: 00000000
Dec  4 01:56:02 mnm kernel: esi: c025b8a0   edi: cfbcb040   ebp: ce2b0260   esp: ced4df3c
Dec  4 01:56:02 mnm kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 01:56:02 mnm kernel: Process lat_fs (pid: 17559, stackpage=ced4d000)                                         Dec  4 01:56:02 mnm kernel: Stack: c021b845 c021b939 00000056 ca9e63e0 c0146966 ca9e63e0 ce2b0260 ca9e63e0
Dec  4 01:56:02 mnm kernel: Call Trace: [<c021b845>] [<c021b939>] [<c0146966>] [<c01450b6>] [<c013de6d>] [<c013df45>] [<c0108fdf>]
Dec  4 01:56:02 mnm kernel: Code: 0f 0b 83 c4 0c 8d 76 00 53 a1 10 d1 2a c0 50 e8 80 3d fe ff

>>EIP; c0145758 <destroy_inode+48/64>   <=====
Trace; c021b845 <tvecs+5a3d/1a418>
Trace; c021b939 <tvecs+5b31/1a418>
Trace; c0146966 <iput+18e/194>
Trace; c01450b6 <d_delete+66/ac>
Trace; c013de6d <vfs_unlink+18d/1c0>
Trace; c013df45 <sys_unlink+a5/118>
Trace; c0108fdf <system_call+33/38>
Code;  c0145758 <destroy_inode+48/64>
00000000 <_EIP>:
Code;  c0145758 <destroy_inode+48/64>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014575a <destroy_inode+4a/64>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c014575d <destroy_inode+4d/64>
   5:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0145760 <destroy_inode+50/64>
   8:   53                        push   %ebx
Code;  c0145761 <destroy_inode+51/64>
   9:   a1 10 d1 2a c0            mov    0xc02ad110,%eax
Code;  c0145766 <destroy_inode+56/64>
   e:   50                        push   %eax
Code;  c0145767 <destroy_inode+57/64>
   f:   e8 80 3d fe ff            call   fffe3d94 <_EIP+0xfffe3d94> c01294ec <kmem_cache_free+0/7c>


1 warning issued.  Results may not be reliable.




--- linux-2.4.0-test12-pre3/include/linux/list.h	Fri Aug 11 19:06:12 2000
+++ linux-akpm/include/linux/list.h	Fri Dec  1 17:31:35 2000
@@ -90,6 +90,7 @@
 static __inline__ void list_del(struct list_head *entry)
 {
 	__list_del(entry->prev, entry->next);
+	entry->next = entry->prev = 0;
 }
 
 /**
--- linux-2.4.0-test12-pre3/fs/buffer.c	Wed Nov 29 18:23:19 2000
+++ linux-akpm/fs/buffer.c	Sun Dec  3 22:36:18 2000
@@ -871,10 +871,11 @@
 		else {
 			bh->b_inode = &tmp;
 			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
-			atomic_inc(&bh->b_count);
 			if (buffer_dirty(bh)) {
+				atomic_inc(&bh->b_count);
 				spin_unlock(&lru_list_lock);
 				ll_rw_block(WRITE, 1, &bh);
+				brelse(bh);
 				spin_lock(&lru_list_lock);
 			}
 		}
@@ -883,6 +884,7 @@
 	while (!list_empty(&tmp.i_dirty_buffers)) {
 		bh = BH_ENTRY(tmp.i_dirty_buffers.prev);
 		remove_inode_queue(bh);
+		atomic_inc(&bh->b_count);
 		spin_unlock(&lru_list_lock);
 		wait_on_buffer(bh);
 		if (!buffer_uptodate(bh))
@@ -929,9 +931,9 @@
 			atomic_inc(&bh->b_count);
 			spin_unlock(&lru_list_lock);
 			wait_on_buffer(bh);
-			brelse(bh);
 			if (!buffer_uptodate(bh))
 				err = -EIO;
+			brelse(bh);
 			spin_lock(&lru_list_lock);
 			goto repeat;
 		}
@@ -1459,6 +1461,9 @@
 		clear_bit(BH_Mapped, &bh->b_state);
 		clear_bit(BH_Req, &bh->b_state);
 		clear_bit(BH_New, &bh->b_state);
+		spin_lock(&lru_list_lock);
+		remove_inode_queue(bh);
+		spin_unlock(&lru_list_lock);
 	}
 }
 
--- linux-2.4.0-test12-pre3/fs/inode.c	Wed Nov 29 18:23:19 2000
+++ linux-akpm/fs/inode.c	Sat Dec  2 15:34:51 2000
@@ -77,7 +77,17 @@
 
 #define alloc_inode() \
 	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL))
-#define destroy_inode(inode) kmem_cache_free(inode_cachep, (inode))
+static void destroy_inode(struct inode *inode) 
+{
+	if (!list_empty(&inode->i_dirty_buffers)) {
+		printk("&inode->i_dirty_buffers=0x%p\n", &inode->i_dirty_buffers);
+		printk("next=0x%p\n", inode->i_dirty_buffers.next);
+		printk("prev=0x%p\n", inode->i_dirty_buffers.prev);
+		BUG();
+	}
+	kmem_cache_free(inode_cachep, (inode));
+}
+
 
 /*
  * These are initializations that only need to be done
@@ -348,6 +358,12 @@
  
 void clear_inode(struct inode *inode)
 {
+	if (!list_empty(&inode->i_dirty_buffers)) {
+		if (inode->i_nlink)
+			BUG();
+		invalidate_inode_buffers(inode);
+	}
+       
 	if (inode->i_data.nrpages)
 		BUG();
 	if (!(inode->i_state & I_FREEING))
@@ -407,6 +423,7 @@
 		inode = list_entry(tmp, struct inode, i_list);
 		if (inode->i_sb != sb)
 			continue;
+		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
 			list_del(&inode->i_hash);
 			INIT_LIST_HEAD(&inode->i_hash);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
