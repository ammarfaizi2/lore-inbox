Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUCVMaP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 07:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbUCVMaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 07:30:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12965 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261937AbUCVM3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 07:29:53 -0500
Date: Mon, 22 Mar 2004 18:01:57 +0530
From: Raghavan <raghav@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Fixing race in the ioctl32 emulation table
Message-ID: <20040322123157.GA8090@in.ibm.com>
Reply-To: raghav@in.ibm.com
References: <20040310130357.GA21839@in.ibm.com> <20040310140410.GA26602@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310140410.GA26602@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 10, 2004 at 03:04:10PM +0100, Andi Kleen wrote:
> On Wed, Mar 10, 2004 at 06:33:57PM +0530, Raghavan wrote:
> > Hi Andi,
> > 
> > I am trying to fix the problem in the ioctl32 emulation code(fs/compat.c) 
> > where the ioctl_trans structure does not get freed because of a potential race
> > problem between the searching and the delete thread.RCU is a potential 
> > fix(there is a line in the file that actually suggests usage of RCU) 
> > However I have the following doubts which I would like to get clarified:
> > 
> > 1) What is the exact scenario of the problem hapenning? As I understand the 
> > problem happens when a module that has registered for the ioctl32 conversion 
> > gets unloaded when the ioctl is hapenning. Isn't the 2.6 kernel module
> > architecture have fixed the races while doing module unloading? Or is this a 
> > problem encountered when doing a forced module unload?
> 
> Module unload when the ioctl chain is being walked. I wrote the comment
> originally in 2.4 and it was merged into 2.6 before the new module loader
> existed, i haven't checked if it prevents it.
> 
> > 
> > 2) In the 2.6 kernel; when a sys_ioctl() is called, the actual ioctl handler is
> > called with the BKL held. Most of the ioctls that register for the 32 bit 
> > emulation seem to be calling the 64 bit ioctl handlers after translating the
> > required parameters. So it looks the ioctl handlers get called with the BKL held
> > when they are called from 64 bit programs and without BKL when they are called
> > from 32 bit programs. Isn't this a cause of potential misbehaviour? (I was 
> > looking at the driver drivers/ieee1394/dv1394.c and there the ioctl handler 
> > assumes that ioctls are serialised using the BKL!)
> 
> That was fixed recently. Actually the translation wrappers normally only
> do translation and don't need locking, but call sys_ioctl which sets BKL
> then before calling the true ioctl. But as it's possible that some drivers
> do real work in the 32bit handler it was fixed to call these with BKL too.
> 
> > 3) How can RCU fix the problem in case the ioctl handler blocks? (i.e the 
> > process gets preempted while blocking on a resource inside the ioctl handler) 
> > After the process gets rescheduled, there is a very good chance that 
> > the ioctl_trans structure would have been freed.
> 
> Hmm, good point. I don't know.
> 
> I was only thinking about the ioctl chains by themselves, which are not
> accessed afterwards, but of course the translation handler itself has to
> be protected too. Normally the translators are either in the main kernel
> or in the same module that also implements the main ioctl (but even then
> there is no guarantee that it won't unload inbetween). It's probably
> buggy.
> 
> -Andi



Hi Andy,

Thanks for the answers.

I looked into the 2.6.4 code; I still see 2 possible cases of races between the
search and delete code(basically because search is not locked):

1) When the search is hapenning, if any ioctl_trans structure gets deleted; then
rather than searching the hash table, the code will start searching the free
list.

while (t && t->cmd != cmd)
 	---->Deletion of t happens here; t->next points to ioctl_free_list
	t = (struct ioctl_trans *)t->next;
	---->Now t will point to the ioctl_free_list

2) Another race is when  the delete happens while the search holds the pointer
 to ioctl_trans. In this case the ioctl_trans structure is added to head of
the ioctl_free_list. In the meanwhile if another module is registering, then
the ioctl_trans from the head of the queue is given. This causes corruption.

if (t) {
        -----> t gets deleted, added to free list and gets alloted again
        if (t->handler) {
        ------> t is corrupted


The solution as I see it is to protect the search too. Since anyway the BKL
needs to be used while calling the emulation handler, it can be pushed above
to protect the searching. (Also as we discussed over the last mail, RCU might
not be a good solution since the handler may itself block; hence the BKL) The
fallout of this solution is that ioctl_free_list is not required any more.

I am submitting the patch that implements the above.

Regards 
Raghav


--- linux-2.6.4/fs/compat.c	2004-03-22 17:36:37.000000000 +0530
+++ linux-patch/fs/compat.c	2004-03-22 17:38:57.000000000 +0530
@@ -279,17 +279,6 @@ static int __init init_sys32_ioctl(void)
 
 __initcall(init_sys32_ioctl);
 
-static struct ioctl_trans *ioctl_free_list;
-
-/* Never free them really. This avoids SMP races. With a Read-Copy-Update
-   enabled kernel we could just use the RCU infrastructure for this. */
-static void free_ioctl(struct ioctl_trans *t) 
-{ 
-	t->cmd = 0; 
-	mb();
-	t->next = ioctl_free_list;
-	ioctl_free_list = t;
-} 
 
 int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
 {
@@ -307,15 +296,10 @@ int register_ioctl32_conversion(unsigned
 		}
 	} 
 
-	if (ioctl_free_list) { 
-		t = ioctl_free_list; 
-		ioctl_free_list = t->next; 
-	} else { 
-		t = kmalloc(sizeof(struct ioctl_trans), GFP_KERNEL); 
-		if (!t) { 
-			unlock_kernel();
-			return -ENOMEM;
-		}
+	t = kmalloc(sizeof(struct ioctl_trans), GFP_KERNEL); 
+	if (!t) { 
+		unlock_kernel();
+		return -ENOMEM;
 	}
 	
 	t->next = NULL;
@@ -355,10 +339,10 @@ int unregister_ioctl32_conversion(unsign
 			printk("%p tried to unregister builtin ioctl %x\n",
 			       __builtin_return_address(0), cmd);
 		} else { 
-		ioctl32_hash_table[hash] = t->next;
-			free_ioctl(t); 
+			ioctl32_hash_table[hash] = t->next;
 			unlock_kernel();
-		return 0;
+			kfree(t); 
+			return 0;
 		}
 	} 
 	while (t->next) {
@@ -369,10 +353,10 @@ int unregister_ioctl32_conversion(unsign
 				       __builtin_return_address(0), cmd);
 				goto out;
 			} else { 
-			t->next = t1->next;
-				free_ioctl(t1); 
+				t->next = t1->next;
 				unlock_kernel();
-			return 0;
+				kfree(t1); 
+				return 0;
 			}
 		}
 		t = t1;
@@ -401,43 +385,50 @@ asmlinkage long compat_sys_ioctl(unsigne
 		goto out;
 	}
 
+	lock_kernel();
+
 	t = (struct ioctl_trans *)ioctl32_hash_table [ioctl32_hash (cmd)];
 
 	while (t && t->cmd != cmd)
 		t = (struct ioctl_trans *)t->next;
 	if (t) {
 		if (t->handler) { 
-			lock_kernel();
 			error = t->handler(fd, cmd, arg, filp);
 			unlock_kernel();
-		} else
+		} else {
+			unlock_kernel();
 			error = sys_ioctl(fd, cmd, arg);
-	} else if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
-		error = siocdevprivate_ioctl(fd, cmd, arg);
-	} else {
-		static int count;
-		if (++count <= 50) { 
-			char buf[10];
-			char *path = (char *)__get_free_page(GFP_KERNEL), *fn = "?"; 
-
-			/* find the name of the device. */
-			if (path) {
-		       		fn = d_path(filp->f_dentry, filp->f_vfsmnt, 
-					    path, PAGE_SIZE);
+		}
+	} else 
+	{
+		unlock_kernel();
+		if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
+			error = siocdevprivate_ioctl(fd, cmd, arg);
+		} else {
+			static int count;
+			if (++count <= 50) { 
+				char buf[10];
+				char *path = (char *)__get_free_page(GFP_KERNEL), *fn = "?"; 
+	
+				/* find the name of the device. */
+				if (path) {
+			       		fn = d_path(filp->f_dentry, filp->f_vfsmnt, 
+						    path, PAGE_SIZE);
+				}
+	
+				sprintf(buf,"'%c'", (cmd>>24) & 0x3f); 
+				if (!isprint(buf[1]))
+				    sprintf(buf, "%02x", buf[1]);
+				printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
+				       "cmd(%08x){%s} arg(%08x) on %s\n",
+				       current->comm, current->pid,
+				       (int)fd, (unsigned int)cmd, buf, (unsigned int)arg,
+				       fn);
+				if (path) 
+					free_page((unsigned long)path); 
 			}
-
-			sprintf(buf,"'%c'", (cmd>>24) & 0x3f); 
-			if (!isprint(buf[1]))
-			    sprintf(buf, "%02x", buf[1]);
-			printk("ioctl32(%s:%d): Unknown cmd fd(%d) "
-			       "cmd(%08x){%s} arg(%08x) on %s\n",
-			       current->comm, current->pid,
-			       (int)fd, (unsigned int)cmd, buf, (unsigned int)arg,
-			       fn);
-			if (path) 
-				free_page((unsigned long)path); 
+			error = -EINVAL;
 		}
-		error = -EINVAL;
 	}
 out:
 	fput(filp);
