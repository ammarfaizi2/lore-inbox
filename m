Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265182AbUD3NKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbUD3NKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 09:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265184AbUD3NKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 09:10:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45772 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265182AbUD3NJj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 09:09:39 -0400
Date: Fri, 30 Apr 2004 18:41:07 +0530
From: Raghavan <raghav@in.ibm.com>
To: akpm@osdl.org, ak@suse.de
Cc: linux-kernel@vger.kernel.org, raghav@in.ibm.com
Subject: [PATCH] Fixes in 32 bit ioctl emulation code
Message-ID: <20040430131107.GA13126@in.ibm.com>
Reply-To: raghav@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andi & Andrew,

I am submitting a patch that fixes 2 race conditions in the 32 bit ioctl
emulation code.(fs/compat.c) Since the search is not locked; when a 
ioctl_trans structure is deleted, corruption can occur.

The following scenarios discuss the race conditions:

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
to protect the searching. The fallout of this solution is that ioctl_free_list
is not required any more.

Thanks
Raghav

--- compat.c.old	2004-04-30 15:01:35.000000000 +0530
+++ compat.c	2004-04-30 14:33:34.000000000 +0530
@@ -282,18 +282,6 @@
 
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
-
 int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned int, unsigned int, unsigned long, struct file *))
 {
 	struct ioctl_trans *t;
@@ -310,15 +298,10 @@
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
@@ -358,10 +341,10 @@
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
@@ -372,10 +355,10 @@
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
@@ -404,43 +387,50 @@
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
