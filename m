Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLAB3E>; Thu, 30 Nov 2000 20:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbQLAB2y>; Thu, 30 Nov 2000 20:28:54 -0500
Received: from smtprch2.nortelnetworks.com ([192.135.215.15]:17300 "EHLO
	smtprch2.nortel.com") by vger.kernel.org with ESMTP
	id <S129257AbQLAB2h>; Thu, 30 Nov 2000 20:28:37 -0500
Message-ID: <3A26F77B.2800C58D@asiapacificm01.nt.com>
Date: Fri, 01 Dec 2000 00:57:31 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
Organization: Nortel Networks, Wollongong Australia
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.16pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> I bet this'll catch it:
> 
> --- include/linux/list.h.orig   Fri Dec  1 08:33:36 2000
> +++ include/linux/list.h        Fri Dec  1 08:33:55 2000
> @@ -90,6 +90,7 @@
>  static __inline__ void list_del(struct list_head *entry)
>  {
>         __list_del(entry->prev, entry->next);
> +       entry->next = entry->prev = 0;
>  }
> 
>  /**
> 
> First person to send a ksymoops trace gets a cookie.

mmmm... choc-chip.

With the above patch applied the machine crashed after an hour. Crashed
a second time during the e2fsck.  gdb backtrace:

(gdb) l *0xc01755d4 
0xc01755d4 is in __make_request (ll_rw_blk.c:744).
739		 * skip first entry, for devices with active queue head
740		 */
741		if (q->head_active && !q->plugged)
742			head = head->next;
743	
744		if (list_empty(head)) {
745			q->plug_device_fn(q, bh->b_rdev); /* is atomic */
746			goto get_rq;
747		}
748	
(gdb)  l *0xc0175c3d 
0xc0175c3d is in generic_make_request (ll_rw_blk.c:882).
877				buffer_IO_error(bh);
878				break;
879			}
880	
881		}
882		while (q->make_request_fn(q, rw, bh));
883	}
884	
885	/* This function can be used to request a number of buffers from a block
886	   device. Currently the only restriction is that all buffers must belong to
(gdb) l *0xc0175da1 
0xc0175da1 is in ll_rw_block (ll_rw_blk.c:924).
919			printk(KERN_NOTICE "Can't write to read-only device %s\n",
920			       kdevname(bhs[0]->b_dev));
921			goto sorry;
922		}
923	
924		for (i = 0; i < nr; i++) {
925			bh = bhs[i];
926	
927			/* Only one thread can actually submit the I/O. */
928			if (test_and_set_bit(BH_Lock, &bh->b_state))
(gdb)  l *0xc01309e9
0xc01309e9 is in sync_buffers (/uhome/morton/akpm/linux/include/asm/atomic.h:65).
60			:"=m" (v->counter)
61			:"m" (v->counter));
62	}
63	
64	static __inline__ void atomic_dec(atomic_t *v)
65	{
66		__asm__ __volatile__(
67			LOCK "decl %0"
68			:"=m" (v->counter)
69			:"m" (v->counter));
(gdb) l *0xc0130af7     
0xc0130af7 is in fsync_dev (/uhome/morton/akpm/linux/include/asm/current.h:9).
4	struct task_struct;
5	
6	static inline struct task_struct * get_current(void)
7	{
8		struct task_struct *current;
9		__asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
10		return current;
11	 }
12	 
13	#define current get_current()
(gdb) l *0xc0137339  
0xc0137339 is in block_fsync (block_dev.c:353).
348	 *	since the vma has no handle.
349	 */
350	 
351	static int block_fsync(struct file *filp, struct dentry *dentry, int datasync)
352	{
353		return fsync_dev(dentry->d_inode->i_rdev);
354	}
355	
356	/*
357	 * bdev cache handling - shamelessly stolen from inode.c
(gdb) l *0xc0130c76  
0xc0130c76 is in sys_fsync (buffer.c:373).
368		if (!file->f_op || !file->f_op->fsync)
369			goto out_putf;
370	
371		/* We need to protect against concurrent writers.. */
372		down(&inode->i_sem);
373		err = file->f_op->fsync(file, dentry, 0);
374		up(&inode->i_sem);
375	
376	out_putf:
377		fput(file);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
