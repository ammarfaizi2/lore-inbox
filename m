Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282116AbRKWKro>; Fri, 23 Nov 2001 05:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282117AbRKWKrf>; Fri, 23 Nov 2001 05:47:35 -0500
Received: from ns.caldera.de ([212.34.180.1]:18326 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S282116AbRKWKrT>;
	Fri, 23 Nov 2001 05:47:19 -0500
Date: Fri, 23 Nov 2001 11:47:10 +0100
Message-Id: <200111231047.fANAlA105874@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [PATCH] Remove needless BKL from release functions
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.SOL.4.33.0111231106530.7403-100000@sun3.lrz-muenchen.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.SOL.4.33.0111231106530.7403-100000@sun3.lrz-muenchen.de> you wrote:
> While this is doubtlessly true, please don't do things like removing the
> lock from interfaces like the call to open() in the input subsystem.
> People may depend on the lock being held there. Having open() under BKL
> simplifies writing USB device drivers.

Beeing completly single-threaded also simplifies writing unclean drivers..

BTW, I've attached a patch that fixes the largest input races (against 2.4.6),
I don't see how to change the total lack of locking for other data structures
without an API change, though.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.

--- linux-2.4.6/drivers/input/input.c	Mon Jun  4 21:17:55 2001
+++ linux/drivers/input/input.c	Sun Jul  8 22:58:10 2001
@@ -57,6 +57,7 @@
 static devfs_handle_t input_devfs_handle;
 static int input_number;
 static long input_devices[NBITS(INPUT_DEVICES)];
+static DECLARE_MUTEX(input_lock);
 
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
@@ -222,6 +223,8 @@
 	struct input_handler *handler = input_handler;
 	struct input_handle *handle;
 
+	down(&input_lock);
+	
 /*
  * Initialize repeat timer to default values.
  */
@@ -257,6 +260,8 @@
 			input_link_handle(handle);
 		handler = handler->next;
 	}
+
+	up(&input_lock);
 }
 
 void input_unregister_device(struct input_dev *dev)
@@ -265,6 +270,8 @@
 	struct input_dev **devptr = &input_dev;
 	struct input_handle *dnext;
 
+	down(&input_lock);
+	
 /*
  * Kill any pending repeat timers.
  */
@@ -294,6 +301,8 @@
 
 	if (dev->number < INPUT_DEVICES)
 		clear_bit(dev->number, input_devices);
+
+	up(&input_lock);
 }
 
 void input_register_handler(struct input_handler *handler)
@@ -301,6 +310,8 @@
 	struct input_dev *dev = input_dev;
 	struct input_handle *handle;
 
+	down(&input_lock);
+	
 /*
  * Add minors if needed.
  */
@@ -324,6 +335,8 @@
 			input_link_handle(handle);
 		dev = dev->next;
 	}
+
+	up(&input_lock);
 }
 
 void input_unregister_handler(struct input_handler *handler)
@@ -332,6 +345,8 @@
 	struct input_handle *handle = handler->handle;
 	struct input_handle *hnext;
 
+	down(&input_lock);
+
 /*
  * Tell the handler to disconnect from all devices it keeps open.
  */
@@ -358,38 +373,60 @@
 
 	if (handler->fops != NULL)
 		input_table[handler->minor >> 5] = NULL;
+
+	up(&input_lock);
 }
 
 static int input_open_file(struct inode *inode, struct file *file)
 {
-	struct input_handler *handler = input_table[MINOR(inode->i_rdev) >> 5];
 	struct file_operations *old_fops, *new_fops = NULL;
+	struct input_handler *handler;
+	unsigned int minor = MINOR(inode->i_rdev), index;
	int err;
 
-	/* No load-on-demand here? */
-	if (!handler || !(new_fops = fops_get(handler->fops)))
+	if (minor >= INPUT_DEVICES)
 		return -ENODEV;
 
-	/*
-	 * That's _really_ odd. Usually NULL ->open means "nothing special",
-	 * not "no device". Oh, well...
-	 */
-	if (!new_fops->open) {
-		fops_put(new_fops);
-		return -ENODEV;
+	down(&input_lock);
+	index = minor >> 5;
+	handler = input_table[index];
+
+	if (handler)
+		new_fops = fops_get(handler->fops);
+	if (!new_fops) {
+		char modname[32];
+		
+		up(&input_lock);
+		sprintf(modname, "input-handler-%d", index);
+		request_module(modname);
+		down(&input_lock);
+
+		err = -ENODEV;
+		handler = input_table[index];
+		if (!handler)
+			goto end;
+		if (!(new_fops = fops_get(handler->fops)))
+			goto end;
 	}
+	
 	old_fops = file->f_op;
 	file->f_op = new_fops;
 
-	lock_kernel();
-	err = new_fops->open(inode, file);
-	unlock_kernel();
+	if (new_fops->open) {
+		lock_kernel();
+		err = new_fops->open(inode, file);
+		unlock_kernel();
+	} else
+		err = 0;
 
 	if (err) {
 		fops_put(file->f_op);
 		file->f_op = fops_get(old_fops);
 	}
+
 	fops_put(old_fops);
+end:
+	up(&input_lock);
 	return err;
 }
 
