Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266707AbTGFRIj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266709AbTGFRIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:08:39 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:25362 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266707AbTGFRIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:08:32 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.73] stack corruption in devfs_lookup
Date: Sun, 6 Jul 2003 21:06:53 +0400
User-Agent: KMail/1.5
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru> <Pine.LNX.4.55.0304231157560.1309@marabou.research.att.com> <Pine.LNX.4.55.0305050005230.1278@marabou.research.att.com>
In-Reply-To: <Pine.LNX.4.55.0305050005230.1278@marabou.research.att.com>
Cc: devfs@oss.sgi.com
MIME-Version: 1.0
Message-Id: <200307062058.40797.arvidjaar@mail.ru>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tcFC/K5rog3javx"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tcFC/K5rog3javx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Doing concurrent lookups for the same name in devfs with devfsd and modules 
enabled may result in stack coruption.

When devfs_lookup needs to call devfsd it arranges for other lookups for the 
same name to wait. It is using local variable as wait queue head. After 
devfsd returns devfs_lookup wakes up all waiters and returns. Unfortunately 
there is no garantee all waiters will actually get chance to run and clean up 
before devfs_lookup returns. so some of them attempt to access already freed 
storage on stack.

It is trivial to trigger with SMP kernel (I have single-CPU system if it 
matters) doing

while true
do
  ls /dev/foo &
done

With spinlock debug enabled this results in large number of stacks similar to

------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:120!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c012004c>]    Tainted: G S
EFLAGS: 00010082
EIP is at remove_wait_queue+0xac/0xc0
eax: 0000000e   ebx: f6617e4c   ecx: 00000000   edx: 00000001
esi: f6747dd0   edi: f6616000   ebp: f6617e10   esp: f6617df0
ds: 007b   es: 007b   ss: 0068
Process ls (pid: 1517, threadinfo=f6616000 task=f6619900)
Stack: c03eb9d5 c011ffa0 00000286 f6617e24 c0443880 f6747dd0 f6616000 f6617e4c 
       f6617e78 c01cb3e6 c04470c0 f6616000 00000246 f6747dcc c1a6f1dc 00000000 
       f6619900 c011d4e0 00000000 00000000 f7d4b73c f663d005 f6759828 00000000
Call Trace:
 [<c011ffa0>] remove_wait_queue+0x0/0xc0
 [<c01cb3e6>] devfs_d_revalidate_wait+0x1d6/0x1f0
 [<c011d4e0>] default_wake_function+0x0/0x30
 [<c011d4e0>] default_wake_function+0x0/0x30
 [<c017201a>] do_lookup+0x5a/0xa0
 [<c017261e>] link_path_walk+0x5be/0xb20
 [<c0148ceb>] kmem_cache_alloc+0x14b/0x190
 [<c01730fe>] __user_walk+0x3e/0x60
 [<c016d13e>] vfs_stat+0x1e/0x60
 [<c0154c5b>] do_brk+0x12b/0x200
 [<c016d7bb>] sys_stat64+0x1b/0x40
 [<c01532e2>] sys_brk+0xf2/0x120
 [<c011a820>] do_page_fault+0x0/0x4c5
 [<c0109919>] sysenter_past_esp+0x52/0x71

Code: 0f 0b 78 00 6c b0 3e c0 e9 72 ff ff ff 8d b4 26 00 00 00 00
 <6>note: ls[1517] exited with preempt_count 1
eip: c011ffa0

without spinlock debug system usually hung dead with reset button as the only 
possibility.

I was not able to reproduce it on 2.4 on single-CPU system - in 2.4 
devfs_d_revalidate_wait does not attempt to remove itself from wait queue so 
it appears to be safe.

attached patch is against 2.5.73 but applies to 2.5.74 as well. It makes 
lookup struct be allocated from heap and adds reference counter to free it 
when no more needed.

regards

-andrey



--Boundary-00=_tcFC/K5rog3javx
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.5.73-devfs_stack_corruption.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.73-devfs_stack_corruption.patch"

--- linux-2.5.73/fs/devfs/base.c.stack	2003-06-23 19:46:44.000000000 +0400
+++ linux-2.5.73/fs/devfs/base.c	2003-06-26 21:01:45.000000000 +0400
@@ -2208,8 +2208,46 @@ struct devfs_lookup_struct
 {
     devfs_handle_t de;
     wait_queue_head_t wait_queue;
+    atomic_t count;
 };
 
+static struct devfs_lookup_struct *
+new_devfs_lookup_struct(void)
+{
+	struct devfs_lookup_struct *p = kmalloc(sizeof(*p), GFP_KERNEL);
+
+	if (!p)
+		return NULL;
+
+	init_waitqueue_head (&p->wait_queue);
+	atomic_set(&p->count, 1);
+	return p;
+}
+
+static void
+get_devfs_lookup_struct(struct devfs_lookup_struct *info)
+{
+	if (info)
+		atomic_inc(&info->count);
+	else {
+		printk(KERN_ERR "null devfs_lookup_struct pointer\n");
+		dump_stack();
+	}
+}
+
+static void
+put_devfs_lookup_struct(struct devfs_lookup_struct *info)
+{
+	if (info) {
+		if (!atomic_dec_and_test(&info->count))
+			return;
+		kfree(info);
+	} else {
+		printk(KERN_ERR "null devfs_lookup_struct pointer\n");
+		dump_stack();
+	}
+}
+
 /* XXX: this doesn't handle the case where we got a negative dentry
         but a devfs entry has been registered in the meanwhile */
 static int devfs_d_revalidate_wait (struct dentry *dentry, int flags)
@@ -2252,11 +2290,13 @@ static int devfs_d_revalidate_wait (stru
     read_lock (&parent->u.dir.lock);
     if (dentry->d_fsdata)
     {
+	get_devfs_lookup_struct(lookup_info);
 	set_current_state (TASK_UNINTERRUPTIBLE);
 	add_wait_queue (&lookup_info->wait_queue, &wait);
 	read_unlock (&parent->u.dir.lock);
 	schedule ();
 	remove_wait_queue (&lookup_info->wait_queue, &wait);
+	put_devfs_lookup_struct(lookup_info);
     }
     else read_unlock (&parent->u.dir.lock);
     return 1;
@@ -2268,7 +2308,7 @@ static int devfs_d_revalidate_wait (stru
 static struct dentry *devfs_lookup (struct inode *dir, struct dentry *dentry)
 {
     struct devfs_entry tmp;  /*  Must stay in scope until devfsd idle again  */
-    struct devfs_lookup_struct lookup_info;
+    struct devfs_lookup_struct *lookup_info;
     struct fs_info *fs_info = dir->i_sb->s_fs_info;
     struct devfs_entry *parent, *de;
     struct inode *inode;
@@ -2285,9 +2325,10 @@ static struct dentry *devfs_lookup (stru
     read_lock (&parent->u.dir.lock);
     de = _devfs_search_dir (parent, dentry->d_name.name, dentry->d_name.len);
     read_unlock (&parent->u.dir.lock);
-    lookup_info.de = de;
-    init_waitqueue_head (&lookup_info.wait_queue);
-    dentry->d_fsdata = &lookup_info;
+    lookup_info = new_devfs_lookup_struct();
+    if (!lookup_info) return ERR_PTR(-ENOMEM);
+    lookup_info->de = de;
+    dentry->d_fsdata = lookup_info;
     if (de == NULL)
     {   /*  Try with devfsd. For any kind of failure, leave a negative dentry
 	    so someone else can deal with it (in the case where the sysadmin
@@ -2297,6 +2338,7 @@ static struct dentry *devfs_lookup (stru
 	if (try_modload (parent, fs_info,
 			 dentry->d_name.name, dentry->d_name.len, &tmp) < 0)
 	{   /*  Lookup event was not queued to devfsd  */
+	    put_devfs_lookup_struct(lookup_info);
 	    d_add (dentry, NULL);
 	    return NULL;
 	}
@@ -2309,7 +2351,7 @@ static struct dentry *devfs_lookup (stru
     up (&dir->i_sem);
     wait_for_devfsd_finished (fs_info);  /*  If I'm not devfsd, must wait  */
     down (&dir->i_sem);      /*  Grab it again because them's the rules  */
-    de = lookup_info.de;
+    de = lookup_info->de;
     /*  If someone else has been so kind as to make the inode, we go home
 	early  */
     if (dentry->d_inode) goto out;
@@ -2333,10 +2375,11 @@ static struct dentry *devfs_lookup (stru
 	     de->name, de->inode.ino, inode, de, current->comm);
     d_instantiate (dentry, inode);
 out:
+    write_lock (&parent->u.dir.lock);
     dentry->d_op = &devfs_dops;
     dentry->d_fsdata = NULL;
-    write_lock (&parent->u.dir.lock);
-    wake_up (&lookup_info.wait_queue);
+    wake_up (&lookup_info->wait_queue);
+    put_devfs_lookup_struct(lookup_info);
     write_unlock (&parent->u.dir.lock);
     devfs_put (de);
     return retval;

--Boundary-00=_tcFC/K5rog3javx--

