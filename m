Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbUAZPlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUAZPlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:41:25 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:45321 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265102AbUAZPka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:40:30 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>, Jim Faulkner <jfaulkne@ccs.neu.edu>
Subject: Re: kernel BUG under 2.6.1-mm5
Date: Mon, 26 Jan 2004 18:30:24 +0300
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.58.0401211708090.15123@denali.ccs.neu.edu> <20040121144804.598c2998.akpm@osdl.org>
In-Reply-To: <20040121144804.598c2998.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401261827.50169.arvidjaar@mail.ru>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RKTFA2jNDwdu8eQ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_RKTFA2jNDwdu8eQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 22 January 2004 01:48, Andrew Morton wrote:
> Jim Faulkner <jfaulkne@ccs.neu.edu> wrote:
> > Hello,
> >
> > I am seeing some scary looking kernel bug entries in my dmesg under
> > 2.6.1-mm5.
> > ...
> >
> > kernel BUG at fs/dcache.c:760!
> > invalid operand: 0000 [#1]
> > PREEMPT SMP
> > CPU:    0
> > EIP:    0060:[<c0179627>]    Not tainted VLI
> > EFLAGS: 00010287
> > EIP is at d_instantiate+0x17/0x90
> > eax: f7baf200   ebx: c1b8bac0   ecx: 000021a4   edx: 00000000
> > esi: f7a4f868   edi: f7baf200   ebp: f7a4f840   esp: f7a79e3c
> > ds: 007b   es: 007b   ss: 0068
> > Process hotplug (pid: 24, threadinfo=f7a78000 task=c1b06d00)
> > Stack: 00000000 f7a992e4 c1b8bac0 c1b35940 f7a78000 f7a4f840 c01ad6de
> > f7a4f840
> >        f7baf200 f7a4f840 f7a41e1c c1bbeb40 00000000 c1b06d00 c011f5b0
> > 00000000
> >        00000000 f7a96d00 c1b06d00 c011bb7d 00000000 c1b06d00 c011f5b0
> > 00000000
> > Call Trace:
> >  [<c01ad6de>] devfs_d_revalidate_wait+0xbe/0x1b0
> >  [<c011f5b0>] default_wake_function+0x0/0x20
> >  [<c011bb7d>] do_page_fault+0x32d/0x512
> >  [<c011f5b0>] default_wake_function+0x0/0x20
> >  [<c016e868>] do_lookup+0x68/0xb0
> >  [<c016ede8>] link_path_walk+0x538/0xa30
> >  [<c016fd03>] open_namei+0x83/0x420
> >  [<c011b850>] do_page_fault+0x0/0x512
> >  [<c040d4cb>] error_code+0x2f/0x38
> >  [<c015e61e>] filp_open+0x3e/0x70
> >  [<c015eb9b>] sys_open+0x5b/0x90
> >  [<c040c992>] sysenter_past_esp+0x43/0x65
>
> hmm.  There was a patch in that area which I have subsequently dropped
> because it was really fixing devfs problems in the wrong place.
>
hmm ... 

> Perhaps Andrey can ask you to test a subsequent patch if he takes another
> look at this.

please try this one. This basically does the same inside of devfs. It passed 
usual sanity checks here; I cannot reproduce oops you have (do you have SMP 
system?)

I appreciate if someone with more intimate knowledge of fs/namei.c comments if 
conditions in devfs_d_revalidate_wait make sense.

-andrey 

--Boundary-00=_RKTFA2jNDwdu8eQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.2-rc2-devfs-d_revalidate-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.2-rc2-devfs-d_revalidate-2.patch"

--- linux-2.6.2-rc2/fs/devfs/base.c.nd	2004-01-26 13:25:38.000000000 +0300
+++ linux-2.6.2-rc2/fs/devfs/base.c	2004-01-26 15:52:11.000000000 +0300
@@ -676,6 +676,7 @@
 #include <linux/smp.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/namei.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -2223,6 +2224,34 @@ static int devfs_d_revalidate_wait (stru
     devfs_handle_t parent = get_devfs_entry_from_vfs_inode (dir);
     struct devfs_lookup_struct *lookup_info = dentry->d_fsdata;
     DECLARE_WAITQUEUE (wait, current);
+    int need_lock;
+
+    /*
+     * FIXME HACK
+     *
+     * make sure that
+     *   d_instantiate always runs under lock
+     *   we release i_sem lock before going to sleep
+     *
+     * unfortunately sometimes d_revalidate is called with
+     * and sometimes without i_sem lock held. The following checks
+     * attempt to deduce when we need to add (and drop resp.) lock
+     * here. This relies on current (2.6.2) calling coventions:
+     *
+     *   lookup_hash is always run under i_sem and is passing NULL
+     *   as nd
+     *
+     *   open(...,O_CREATE,...) calls _lookup_hash under i_sem
+     *   and sets flags to LOOKUP_OPEN|LOOKUP_CREATE
+     *
+     *   all other invocations of ->d_revalidate seem to happen
+     *   outside of i_sem
+     */
+    need_lock = nd &&
+		(!(nd->flags & LOOKUP_CREATE) || (nd->flags & LOOKUP_PARENT));
+
+    if (need_lock)
+	down(&dir->i_sem);
 
     if ( is_devfsd_or_child (fs_info) )
     {
@@ -2233,33 +2262,40 @@ static int devfs_d_revalidate_wait (stru
 		 "(%s): dentry: %p inode: %p de: %p by: \"%s\"\n",
 		 dentry->d_name.name, dentry, dentry->d_inode, de,
 		 current->comm);
-	if (dentry->d_inode) return 1;
+	if (dentry->d_inode)
+	    goto out;
 	if (de == NULL)
 	{
 	    read_lock (&parent->u.dir.lock);
 	    de = _devfs_search_dir (parent, dentry->d_name.name,
 				    dentry->d_name.len);
 	    read_unlock (&parent->u.dir.lock);
-	    if (de == NULL) return 1;
+	    if (de == NULL)
+		goto out;
 	    lookup_info->de = de;
 	}
 	/*  Create an inode, now that the driver information is available  */
 	inode = _devfs_get_vfs_inode (dir->i_sb, de, dentry);
-	if (!inode) return 1;
+	if (!inode)
+	    goto out;
 	DPRINTK (DEBUG_I_LOOKUP,
 		 "(%s): new VFS inode(%u): %p de: %p by: \"%s\"\n",
 		 de->name, de->inode.ino, inode, de, current->comm);
 	d_instantiate (dentry, inode);
-	return 1;
+	goto out;
     }
-    if (lookup_info == NULL) return 1;  /*  Early termination  */
+    if (lookup_info == NULL)
+	goto out;  /*  Early termination  */
     read_lock (&parent->u.dir.lock);
     if (dentry->d_fsdata)
     {
 	set_current_state (TASK_UNINTERRUPTIBLE);
 	add_wait_queue (&lookup_info->wait_queue, &wait);
 	read_unlock (&parent->u.dir.lock);
+	/* at this point it is always (hopefully) locked */
+	up(&dir->i_sem);
 	schedule ();
+	down(&dir->i_sem);
 	/*
 	 * This does not need nor should remove wait from wait_queue.
 	 * Wait queue head is never reused - nothing is ever added to it
@@ -2271,6 +2307,10 @@ static int devfs_d_revalidate_wait (stru
 
     }
     else read_unlock (&parent->u.dir.lock);
+
+out:
+    if (need_lock)
+	up(&dir->i_sem);
     return 1;
 }   /*  End Function devfs_d_revalidate_wait  */
 
@@ -2320,6 +2360,7 @@ static struct dentry *devfs_lookup (stru
 	revalidation  */
     up (&dir->i_sem);
     wait_for_devfsd_finished (fs_info);  /*  If I'm not devfsd, must wait  */
+    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     de = lookup_info.de;
     /*  If someone else has been so kind as to make the inode, we go home
 	early  */
@@ -2349,7 +2390,6 @@ out:
     dentry->d_fsdata = NULL;
     wake_up (&lookup_info.wait_queue);
     write_unlock (&parent->u.dir.lock);
-    down (&dir->i_sem);      /*  Grab it again because them's the rules  */
     devfs_put (de);
     return retval;
 }   /*  End Function devfs_lookup  */

--Boundary-00=_RKTFA2jNDwdu8eQ--

