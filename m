Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbSJOLzH>; Tue, 15 Oct 2002 07:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbSJOLzH>; Tue, 15 Oct 2002 07:55:07 -0400
Received: from angband.namesys.com ([212.16.7.85]:6272 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262568AbSJOLzF>; Tue, 15 Oct 2002 07:55:05 -0400
Date: Tue, 15 Oct 2002 16:00:59 +0400
From: Oleg Drokin <green@namesys.com>
To: Jeff Dike <jdike@karaya.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.42-1
Message-ID: <20021015160059.A6187@namesys.com>
References: <200210150058.TAA05520@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200210150058.TAA05520@ccure.karaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Oct 14, 2002 at 07:58:28PM -0500, Jeff Dike wrote:
> UML has been updated to 2.5.42 and UML 2.4.19-12.  In non-numeric terms,
> this means the following:
> 	the usual build fixes to keep up with kbuild
> 	the SMP work from UML 2.4.19-12 - it seems reasonably functional
> and stable, but there are some unexplained crashes still.  Also, the fixes
> from UML 2.4.19-13 aren't in yet, so an SMP UML will leave children around
> after exiting (the idle threads for processors 1 ... ncpus - 1).  These 
> children will interfere with rebooting, and will also hold down host memory.
> 	various cleanups and bug fixes

Reviewing your patch I spotted some locking inconsistencies.
Also Nikita Danilov have spotted a double unlock in irq_user.c:reactivate_fd(),
you forgot to do return before "out" label.
Below is quotes from the patch, and at the very end of the message
there is a my proposed patch to fix all uncovered problems, patch was tested
as in "compiles and runs ok for me".

Also
arch/um/drivers/ubd_kern.c:
@@ -892,8 +948,11 @@

        n = minor(rdev) >> UBD_SHIFT;
        dev = &ubd_dev[n];
+
+       err = 0;
+       spin_lock(&ubd_lock);
        if(dev->is_dir)
-               return(0);
+               goto out;

        err = ubd_file_size(dev, &size);
        if (!err) {
@@ -902,7 +961,8 @@
                        set_capacity(fake_gendisk[n], size / 512);
                dev->size = size;
        }
-
+       spin_unlock(&ubd_lock);
+ out:
        return err;
 }

Here you forget to unlock ubd_lock if dev->is_dir is true.

arch/um/kernel/irq_user.c
+       /* Actually, it only looks like it can be called from interrupt
+        * context.  The culprit is reactivate_fd, which calls
+        * maybe_sigio_broken, which calls write_sigio_workaround,
+        * which calls activate_fd.  However, write_sigio_workaround should
+        * only be called once, at boot time.  That would make it clear that
+        * this is called only from process context, and can be locked with
+        * a semaphore.
+        */
+       flags = irq_lock();
+       for(irq_fd = active_fds; irq_fd != NULL; irq_fd = irq_fd->next){
+               if((irq_fd->fd == fd) && (irq_fd->type == type)){
+                       printk("Registering fd %d twice\n", fd);
+                       printk("Irqs : %d, %d\n", irq_fd->irq, irq);
+                       printk("Ids : 0x%x, 0x%x\n", irq_fd->id, dev_id);
+                       goto out_free;
+               }
+       }
...
+ out_unlock:
+       irq_unlock(flags);
+ out_free:
        kfree(new_fd);
+ out:
        return(err);

Here you forgot to do irq_unlock()


Also there are number "32" is hardcoded into arch/um/kernel/trap_user.c
in some arrays, taht you probably actually want to make dependent on
CONFIG_NR_CPUS

Bye,
    Oleg
===== arch/um/drivers/ubd_kern.c 1.9 vs edited =====
--- 1.9/arch/um/drivers/ubd_kern.c	Tue Oct 15 10:44:19 2002
+++ edited/arch/um/drivers/ubd_kern.c	Tue Oct 15 15:18:43 2002
@@ -961,8 +961,8 @@
 			set_capacity(fake_gendisk[n], size / 512);
 		dev->size = size;
 	}
-	spin_unlock(&ubd_lock);
  out:
+	spin_unlock(&ubd_lock);
 	return err;
 }
 
===== arch/um/kernel/irq_user.c 1.3 vs edited =====
--- 1.3/arch/um/kernel/irq_user.c	Tue Oct 15 10:44:20 2002
+++ edited/arch/um/kernel/irq_user.c	Tue Oct 15 15:21:16 2002
@@ -157,7 +157,7 @@
 			printk("Registering fd %d twice\n", fd);
 			printk("Irqs : %d, %d\n", irq_fd->irq, irq);
 			printk("Ids : 0x%x, 0x%x\n", irq_fd->id, dev_id);
-			goto out_free;
+			goto out_unlock;
 		}
 	}
 
@@ -209,7 +209,6 @@
 
  out_unlock:
 	irq_unlock(flags);
- out_free:
 	kfree(new_fd);
  out:
 	return(err);
@@ -344,6 +343,7 @@
 	 * section.
 	 */
 	maybe_sigio_broken(fd, irq->type);
+	return;
  out:
 	irq_unlock(flags);
 }
