Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319365AbSIMASD>; Thu, 12 Sep 2002 20:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319387AbSIMASD>; Thu, 12 Sep 2002 20:18:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13080 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S319365AbSIMASB>; Thu, 12 Sep 2002 20:18:01 -0400
Date: Fri, 13 Sep 2002 02:23:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Samuel Flory <sflory@rackable.com>
Cc: Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
Message-ID: <20020913002316.GG11605@dualathlon.random>
References: <20020911201602.A13655@pc9391.uni-regensburg.de> <1031768655.24629.23.camel@UberGeek.coremetrics.com> <20020911184111.GY17868@dualathlon.random> <3D81235B.6080809@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D81235B.6080809@rackable.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 04:29:31PM -0700, Samuel Flory wrote:
>  Your patch seem to solve only some  of the xfs issues for me.  Before 
> the patch my system hung when booting.  This only occured I  had xfs 
> compiled into the kernel.   After patching  things seemed fine, but 
> durning "dbench 32" the system locked.  Upon rebooting and attempting to 
> mount the filesystem I got this:
> XFS mounting filesystem md(9,2)
> Starting XFS recovery on filesystem: md(9,2) (dev: 9/2)
> kernel BUG at page_buf.c:578!
> <and so on>
> 
> PS- The results of ksymoops are attached.

that seems a bug in xfs, it BUG() if vmap fails, it must not BUG(), it
must return -ENOMEM to userspace instead, or it can try to recollect and
release some of the other vmalloced entries. Most probably you run into
an address space shortage, not a real ram shortage, so to workaround it
you can recompile with CONFIG_2G and it'll probably work, also dropping
the gap page in vmalloc may help workaround it (there's no config option
for it though). It could be also a vmap leak, maybe a missing vfree,
just some idea.


> 
> Andrea Arcangeli wrote:
> 
> >was a collision between new xfs and new scheduler, you can use this fix
> >in the meantime:
> >
> >--- 2.4.20pre5aa3/fs/xfs/pagebuf/page_buf.c.~1~	Wed Sep 11 05:17:46 
> >2002
> >+++ 2.4.20pre5aa3/fs/xfs/pagebuf/page_buf.c	Wed Sep 11 06:00:35 2002
> >@@ -2055,9 +2055,9 @@ pagebuf_iodone_daemon(
> >	spin_unlock_irq(&current->sigmask_lock);
> >
> >	/* Migrate to the right CPU */
> >-	current->cpus_allowed = 1UL << cpu;
> >-	while (smp_processor_id() != cpu)
> >-		schedule();
> >+	set_cpus_allowed(current, 1UL << cpu);
> >+	if (cpu() != cpu)
> >+		BUG();
> >
> >	sprintf(current->comm, "pagebuf_io_CPU%d", bind_cpu);
> >	INIT_LIST_HEAD(&pagebuf_iodone_tq[cpu]);
> >
> >also remeber to apply the O_DIRECT fixes for reiserfs and ext3 (that
> >were left over after merging the new nfs stuff). all will be fixed in
> >next -aa of course.
> >
> >--- 2.4.19pre3aa1/fs/reiserfs/inode.c.~1~	Tue Mar 12 00:07:18 2002
> >+++ 2.4.19pre3aa1/fs/reiserfs/inode.c	Tue Mar 12 01:24:21 2002
> >@@ -2161,10 +2161,11 @@
> >	}
> >}
> >
> >-static int reiserfs_direct_io(int rw, struct inode *inode, 
> >+static int reiserfs_direct_io(int rw, struct file * filp,
> >                              struct kiobuf *iobuf, unsigned long blocknr,
> >			      int blocksize) 
> >{
> >+    struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
> >    return generic_direct_IO(rw, inode, iobuf, blocknr, blocksize,
> >                             reiserfs_get_block_direct_io) ;
> >}
> >--- 2.4.20pre5aa2/fs/ext3/inode.c.~1~	Mon Sep  9 02:38:08 2002
> >+++ 2.4.20pre5aa2/fs/ext3/inode.c	Tue Sep 10 05:22:18 2002
> >@@ -1385,9 +1385,10 @@ static int ext3_releasepage(struct page 
> >}
> >
> >static int
> >-ext3_direct_IO(int rw, struct inode *inode, struct kiobuf *iobuf,
> >+ext3_direct_IO(int rw, struct file * filp, struct kiobuf *iobuf,
> >		unsigned long blocknr, int blocksize)
> >{
> >+	struct inode * inode = filp->f_dentry->d_inode->i_mapping->host;
> >	struct ext3_inode_info *ei = EXT3_I(inode);
> >	handle_t *handle = NULL;
> >	int ret;
> >
> >Andrea
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> > 
> >
> 

> ksymoops 2.4.5 on i686 2.4.20-pre5aa2-fixed-xfs.  Options used
>      -V (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.20-pre5aa2-fixed-xfs/ (default)
>      -m /boot/System.map-2.4.20-pre5aa2-fixed-xfs (default)
> 
> kernel BUG at page_buf.c:578!
> invalid operand: 0000 2.4.20-pre5aa2-fixed-xfs #4 SMP Thu Sep 12 11:51:40 PDT 2002
> CPU:    1
> EIP:    0010:[<c0208592>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: 00000001   ecx: 00000001   edx: 00000000
> esi: c5e15a04   edi: c5e15980   ebp: 00000002   esp: c5c19a58
> ds: 0018   es: 0018   ss: 0018
> Process mount (pid: 805, stackpage=c5c19000)
> Stack: c5c18000 00001000 00000000 00000001 00000000 00000005 000001f0 00000002 
>        c5e15980 c5e15980 00002205 c5e20540 c02089c8 c5e15980 c5c117b4 00002205 
>        13005f90 00000000 c5912d40 13005f90 00000000 c01f4d2d c5912d40 13005f90 
> Call Trace:    [<c02089c8>] [<c01f4d2d>] [<c01f45e1>] [<c01f463a>] [<c01f58b2>]
>   [<c01f59f6>] [<c01f5b5a>] [<c01f6744>] [<c01f6c74>] [<c01f6cc4>] [<c01f6e45>]
>   [<c01efde7>] [<c01f861c>] [<c01f776b>] [<c01f77b0>] [<c01ff894>] [<c01ff97b>]
>   [<c0212ce6>] [<c0148c81>] [<c0148e9c>] [<c014dfb8>] [<c015c145>] [<c015c43b>]
>   [<c015c29c>] [<c015c904>] [<c0108d9b>]
> Code: 0f 0b 42 02 95 ab 35 c0 0f b7 47 7c 81 4f 08 04 00 00 01 8d 
> 
> 
> >>EIP; c0208592 <_pagebuf_lookup_pages+2a2/2f0>   <=====
> 
> >>esi; c5e15a04 <END_OF_CODE+7abc1/????>
> >>edi; c5e15980 <END_OF_CODE+7ab3d/????>
> >>esp; c5c19a58 <[ip_tables].data.end+116159/294761>
> 
> Trace; c02089c8 <pagebuf_get+98/120>
> Trace; c01f4d2d <xlog_recover_do_buffer_trans+fd/230>
> Trace; c01f45e1 <xlog_recover_insert_item_frontq+11/20>
> Trace; c01f463a <xlog_recover_reorder_trans+4a/90>
> Trace; c01f58b2 <xlog_recover_do_trans+52/100>
> Trace; c01f59f6 <xlog_recover_commit_trans+26/40>
> Trace; c01f5b5a <xlog_recover_process_data+12a/1d0>
> Trace; c01f6744 <xlog_do_recovery_pass+354/800>
> Trace; c01f6c74 <xlog_do_log_recovery+84/b0>
> Trace; c01f6cc4 <xlog_do_recover+24/110>
> Trace; c01f6e45 <xlog_recover+95/c0>
> Trace; c01efde7 <xfs_log_mount+77/b0>
> Trace; c01f861c <xfs_mountfs+a7c/fe0>
> Trace; c01f776b <xfs_readsb+3b/c0>
> Trace; c01f77b0 <xfs_readsb+80/c0>
> Trace; c01ff894 <xfs_cmountfs+574/610>
> Trace; c01ff97b <xfs_mount+4b/60>
> Trace; c0212ce6 <linvfs_read_super+f6/240>
> Trace; c0148c81 <get_sb_bdev+1b1/230>
> Trace; c0148e9c <do_kern_mount+5c/120>
> Trace; c014dfb8 <link_path_walk+918/a20>
> Trace; c015c145 <do_add_mount+75/180>
> Trace; c015c43b <do_mount+14b/170>
> Trace; c015c29c <copy_mount_options+4c/a0>
> Trace; c015c904 <sys_mount+a4/100>
> Trace; c0108d9b <system_call+33/38>
> 
> Code;  c0208592 <_pagebuf_lookup_pages+2a2/2f0>
> 00000000 <_EIP>:
> Code;  c0208592 <_pagebuf_lookup_pages+2a2/2f0>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0208594 <_pagebuf_lookup_pages+2a4/2f0>
>    2:   42                        inc    %edx
> Code;  c0208595 <_pagebuf_lookup_pages+2a5/2f0>
>    3:   02 95 ab 35 c0 0f         add    0xfc035ab(%ebp),%dl
> Code;  c020859b <_pagebuf_lookup_pages+2ab/2f0>
>    9:   b7 47                     mov    $0x47,%bh
> Code;  c020859d <_pagebuf_lookup_pages+2ad/2f0>
>    b:   7c 81                     jl     ffffff8e <_EIP+0xffffff8e>
> Code;  c020859f <_pagebuf_lookup_pages+2af/2f0>
>    d:   4f                        dec    %edi
> Code;  c02085a0 <_pagebuf_lookup_pages+2b0/2f0>
>    e:   08 04 00                  or     %al,(%eax,%eax,1)
> Code;  c02085a3 <_pagebuf_lookup_pages+2b3/2f0>
>   11:   00 01                     add    %al,(%ecx)
> Code;  c02085a5 <_pagebuf_lookup_pages+2b5/2f0>
>   13:   8d 00                     lea    (%eax),%eax
> 



Andrea
