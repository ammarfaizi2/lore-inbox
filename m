Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289892AbSAKH57>; Fri, 11 Jan 2002 02:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289893AbSAKH5t>; Fri, 11 Jan 2002 02:57:49 -0500
Received: from [202.135.142.194] ([202.135.142.194]:19975 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S289892AbSAKH5c>; Fri, 11 Jan 2002 02:57:32 -0500
Date: Fri, 11 Jan 2002 16:55:16 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
Message-Id: <20020111165516.61ede3f8.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0201092319080.31300-100000@sphinx.mythic-beasts.com>
In-Reply-To: <Pine.LNX.4.33.0201081443540.8169-100000@penguin.transmeta.com>
	<Pine.LNX.4.33.0201092319080.31300-100000@sphinx.mythic-beasts.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002 23:23:55 +0000 (GMT)
Matthew Kirkwood <matthew@hairy.beasts.org> wrote:

> Both user and kernel bits are, of course, improvable, but
> this should at least show that the approach works.

Hi Matthew,

	Prefer the "char device" approach myself.  open = create, read = down,
write = up.  Following (completely untested) patch stole your work to
implement "/dev/usem". Added bonus is the ability to mmap the fd to map in
the shared page, which means the fd carries a shared region with it (hey,
it was 14 more lines).

	Userspace needs corrsponding updates, but this is basically FYI.

Cheers,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.2-pre11/drivers/char/Makefile working-2.5.2-pre11-usem/drivers/char/Makefile
--- linux-2.5.2-pre11/drivers/char/Makefile	Tue Nov 27 16:52:09 2001
+++ working-2.5.2-pre11-usem/drivers/char/Makefile	Fri Jan 11 16:30:33 2002
@@ -16,7 +16,7 @@
 
 O_TARGET := char.o
 
-obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o raw.o pty.o misc.o random.o
+obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o raw.o pty.o misc.o random.o usersem.o
 
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.2-pre11/drivers/char/usersem.c working-2.5.2-pre11-usem/drivers/char/usersem.c
--- linux-2.5.2-pre11/drivers/char/usersem.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.2-pre11-usem/drivers/char/usersem.c	Fri Jan 11 16:25:04 2002
@@ -0,0 +1,93 @@
+/*
+ *  Lightweight user-level semaphores
+ *  (C) 2002 Matthew Kirkwood <matthew@hairy.beasts.org>
+ *  Made into a char device by Rusty Russell.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+/* Experimental major */
+#define USEM_MAJOR (240)
+
+struct usersem
+{
+	/* The kernel mutex itself */
+	struct semaphore mutex;
+	/* The shared page for users' convenience */
+	void *shared_page;
+};
+
+/* Read one byte = take mutex */
+static ssize_t read_usem(struct file *file, char *buf,
+			 size_t count, loff_t *ppos)
+{
+	struct usersem *usem = file->private_data;
+	return down_interruptible(&usem->mutex);
+}
+
+/* Write one byte = give up mutex */
+static ssize_t write_usem(struct file *file, const char *buf, 
+			  size_t count, loff_t *ppos)
+{
+	struct usersem *usem = file->private_data;
+	up(&usem->mutex);
+	return 1;
+}
+
+/* Access page attached to the file descriptor. */
+static int mmap_usem(struct file *file, struct vm_area_struct *vma)
+{
+	struct usersem *usem = file->private_data;
+
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EINVAL;
+
+	return remap_page_range(vma->vm_start,
+				virt_to_phys(usem->shared_page),
+				vma->vm_end - vma->vm_start,
+				vma->vm_page_prot);
+}
+
+/* Open = create new usem */
+static int open_usem(struct inode *inode, struct file *filp)
+{
+	struct usersem *usem;
+
+	usem = kmalloc(sizeof(struct usersem), GFP_KERNEL);
+	if (!usem)
+		return -ENOMEM;
+	usem->shared_page = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!usem->shared_page) {
+		kfree(usem);
+		return -ENOMEM;
+	}
+	sema_init(usem->mutex, 1);
+	filp->private_data = usem;
+	return 0;
+}
+
+static int release(struct inode *inode, struct file *filp)
+{
+	struct usersem *usem = file->private_data;
+
+	free_page(usem->shared_page);
+	kfree(usem);
+	return 0;
+}
+
+static struct file_operations usem_fops = {
+	read:		read_usem,
+	write:		write_usem,
+	open:		open_usem,
+	release:	release_usem,
+};
+
+int __init usem_init(void)
+{
+	if (devfs_register_chrdev(USEM_MAJOR, "usem", &usem_fops))
+		printk("unable to get major %d for usem devs\n", USEM_MAJOR);
+	return 0;
+}
+
+__initcall(usem_init);
