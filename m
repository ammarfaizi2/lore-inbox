Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUHOJnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUHOJnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 05:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUHOJnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 05:43:16 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:24192 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S266568AbUHOJm6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 05:42:58 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 15 Aug 2004 05:42:55 -0400
User-Agent: KMail/1.6.82
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150009.45034.gene.heskett@verizon.net> <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408150542.55953.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.53.77] at Sun, 15 Aug 2004 04:42:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 04:48, viro@parcelfarce.linux.theplanet.co.uk wrote:
>On Sun, Aug 15, 2004 at 12:09:44AM -0400, Gene Heskett wrote:
>> The only thing I've noted in the slabinfo reports is the
>> ext3_cache was well into 6 digits in kilobytes.  Now its only
>> 15,000 of its normal units (whatever they are) after the reboot.
>
>What did dcache numbers look like at that time?

IIRC the last time I checked before it locked up, dcache was 
in the 57xxx kilobytes area.

Right now, after about 5 6 hours uptime, that line in raw format
is:dentry_cache      731159 772632
and:ext3_inode_cache  1024365 1055817

Now, this mornings logwatch told me I should go look at the 
logs again, and I found this had occurred several hours earlier:
-----------
Aug 14 18:53:24 coyote kernel: Unable to handle kernel paging request at virtual address 0058af03
Aug 14 18:53:24 coyote kernel:  printing eip:
Aug 14 18:53:24 coyote kernel: c01648bc
Aug 14 18:53:24 coyote kernel: *pde = 00000000
Aug 14 18:53:24 coyote kernel: Oops: 0002 [#1]
Aug 14 18:53:24 coyote kernel: PREEMPT
Aug 14 18:53:24 coyote kernel: Modules linked in: tuner tvaudio bttv video_buf btcx_risc eeprom snd_seq_oss snd_seq
_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_bt87x snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_allo
c snd_mpu401_uart snd_rawmidi snd_seq_device snd forcedeth sg
Aug 14 18:53:24 coyote kernel: CPU:    0
Aug 14 18:53:24 coyote kernel: EIP:    0060:[<c01648bc>]    Not tainted
Aug 14 18:53:24 coyote kernel: EFLAGS: 00010202   (2.6.8-rc4)
Aug 14 18:53:24 coyote kernel: EIP is at dispose_list+0x1c/0xa0
Aug 14 18:53:24 coyote kernel: eax: 0058aeff   ebx: ddfc9140   ecx: ddfc9148   edx: c198bef0
Aug 14 18:53:24 coyote kernel: esi: c198bef0   edi: 00000075   ebp: c198bed8   esp: c198bec0
Aug 14 18:53:24 coyote kernel: ds: 007b   es: 007b   ss: 0068
Aug 14 18:53:24 coyote kernel: Process kswapd0 (pid: 66, threadinfo=c198b000 task=c1978050)
Aug 14 18:53:24 coyote kernel: Stack: ddfc92e0 c198bec4 c198bec4 c198b000 cb2be2a0 00000080 c198bf04 c0164c37
Aug 14 18:53:24 coyote kernel:        c198bef0 c198b000 00000000 00000080 ddfc9148 cdf9b668 00000080 00000000
Aug 14 18:53:24 coyote kernel:        c198b000 c198bf10 c0164daf 00000080 c198bf44 c0139fd4 00000080 000000d0
Aug 14 18:53:24 coyote kernel: Call Trace:
Aug 14 18:53:24 coyote kernel:  [<c010476f>] show_stack+0x7f/0xa0
Aug 14 18:53:25 coyote kernel:  [<c0104908>] show_registers+0x158/0x1b0
Aug 14 18:53:25 coyote kernel:  [<c0104a89>] die+0x89/0x100
Aug 14 18:53:25 coyote kernel:  [<c0111725>] do_page_fault+0x1f5/0x553
Aug 14 18:53:25 coyote kernel:  [<c01043d9>] error_code+0x2d/0x38
Aug 14 18:53:25 coyote kernel:  [<c0164c37>] prune_icache+0xb7/0x1f0
Aug 14 18:53:25 coyote kernel:  [<c0164daf>] shrink_icache_memory+0x3f/0x50
Aug 14 18:53:25 coyote kernel:  [<c0139fd4>] shrink_slab+0x134/0x170
Aug 14 18:53:25 coyote kernel:  [<c013b25d>] balance_pgdat+0x1ad/0x1f0
Aug 14 18:53:25 coyote kernel:  [<c013b35f>] kswapd+0xbf/0xd0
Aug 14 18:53:25 coyote kernel:  [<c0102471>] kernel_thread_helper+0x5/0x14
Aug 14 18:53:25 coyote kernel: Code: 89 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 8b 83
-----------------
which was about 5 hours before the lockup.

>Anyway, we could try the patch below and see what shows in
> /proc/fs/ext3 with it [NOTE: patch is completely untested].  It
> should show major:minor:inumber:mode
>for all currently allocated ext3 inodes.  It won't be 100% accurate
> (we can miss some entries/get some twice if cache shrinks or grows
> at the time), but if the leak is so massive, we ought to see a
> *lot* of duplicates in there.  Seeing what kind of inodes really
> leaks could narrow the things down.
>
>See if cat /proc/fs/ext3 | sort | uniq -c | sort -nr gives anything
> interesting when leak happens (and check it right after boot to see
> if it works at all and doesn't oops, obviously ;-)
>
>diff -urN RC8-current/fs/ext3/super.c RC8-leak/fs/ext3/super.c
>--- RC8-current/fs/ext3/super.c	Sat Aug 14 05:35:37 2004
>+++ RC8-leak/fs/ext3/super.c	Sun Aug 15 04:41:09 2004
>@@ -35,6 +35,8 @@
> #include <linux/mount.h>
> #include <linux/namei.h>
> #include <linux/quotaops.h>
>+#include <linux/proc_fs.h>
>+#include <linux/seq_file.h>
> #include <asm/uaccess.h>
> #include "xattr.h"
> #include "acl.h"
>@@ -438,6 +440,9 @@
>
> static kmem_cache_t *ext3_inode_cachep;
>
>+static LIST_HEAD(ext3_list);
>+static spinlock_t ext3_list_lock = SPIN_LOCK_UNLOCKED;
>+
> /*
>  * Called inside transaction, so use GFP_NOFS
>  */
>@@ -453,11 +458,17 @@
> 	ei->i_default_acl = EXT3_ACL_NOT_CACHED;
> #endif
> 	ei->vfs_inode.i_version = 1;
>+	spin_lock(&ext3_list_lock);
>+	list_add(&ei->list, &ext3_list);
>+	spin_unlock(&ext3_list_lock);
> 	return &ei->vfs_inode;
> }
>
> static void ext3_destroy_inode(struct inode *inode)
> {
>+	spin_lock(&ext3_list_lock);
>+	list_del_init(&EXT3_I(inode)->list);
>+	spin_unlock(&ext3_list_lock);
> 	kmem_cache_free(ext3_inode_cachep, EXT3_I(inode));
> }
>
>@@ -475,20 +486,82 @@
> 		inode_init_once(&ei->vfs_inode);
> 	}
> }
>+
>+static void *ext3_cache_start(struct seq_file *m, loff_t *pos)
>+{
>+	struct list_head *p;
>+	loff_t l = *pos;
>+
>+	spin_lock(&ext3_list_lock);
>+	list_for_each(p, &ext3_list)
>+		if (!l--)
>+			return list_entry(p, struct ext3_inode_info, list);
>+	return NULL;
>+}
>+
>+static void *ext3_cache_next(struct seq_file *m, void *v, loff_t
> *pos) +{
>+	struct list_head *p = ((struct ext3_inode_info *)v)->list.next;
>+	(*pos)++;
>+	return p==&ext3_list ? NULL : list_entry(p, struct
> ext3_inode_info, list); +}
>+
>+static void ext3_cache_stop(struct seq_file *m, void *v)
>+{
>+	spin_unlock(&ext3_list_lock);
>+}
>+
>+static int ext3_cache_show(struct seq_file *m, void *v)
>+{
>+	struct ext3_inode_info *ei = v;
>+	struct inode *inode = &ei->vfs_inode;
>+	seq_printf(m, "%d:%d:%lu:%o",
>+		MAJOR(inode->i_sb->s_dev),
>+		MINOR(inode->i_sb->s_dev),
>+		inode->i_ino,
>+		inode->i_mode);
>+	return 0;
>+}
>+
>+static struct seq_operations ext3_cache_op = {
>+	.start	= ext3_cache_start,
>+	.next	= ext3_cache_next,
>+	.stop	= ext3_cache_stop,
>+	.show	= ext3_cache_show
>+};
>+
>+static int ext3_cache_open(struct inode *inode, struct file *file)
>+{
>+	return seq_open(file, &ext3_cache_op);
>+}
>+
>+static struct file_operations ext3_cache_operations = {
>+	.open		= ext3_cache_open,
>+	.read		= seq_read,
>+	.llseek		= seq_lseek,
>+	.release	= seq_release,
>+};
>
> static int init_inodecache(void)
> {
>+	struct proc_dir_entry *p;
> 	ext3_inode_cachep = kmem_cache_create("ext3_inode_cache",
> 					     sizeof(struct ext3_inode_info),
> 					     0, SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
> 					     init_once, NULL);
> 	if (ext3_inode_cachep == NULL)
> 		return -ENOMEM;
>+	p = create_proc_entry("fs/ext3", S_IRUGO, NULL);
>+	if (p) {
>+		p->owner = THIS_MODULE;
>+		p->proc_fops = &ext3_cache_operations;
>+	}
> 	return 0;
> }
>
> static void destroy_inodecache(void)
> {
>+	remove_proc_entry("fs/ext3", NULL);
> 	if (kmem_cache_destroy(ext3_inode_cachep))
> 		printk(KERN_INFO "ext3_inode_cache: not all structures were
> freed\n"); }
>diff -urN RC8-current/include/linux/ext3_fs_i.h
> RC8-leak/include/linux/ext3_fs_i.h ---
> RC8-current/include/linux/ext3_fs_i.h	Thu Oct  9 17:34:54 2003 +++
> RC8-leak/include/linux/ext3_fs_i.h	Sun Aug 15 04:11:03 2004 @@
> -107,6 +107,7 @@
> 	 * by other means, so we have truncate_sem.
> 	 */
> 	struct semaphore truncate_sem;
>+	struct list_head list;
> 	struct inode vfs_inode;
> };
----------
I'll put this in right now.  Thanks.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
