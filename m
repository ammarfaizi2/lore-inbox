Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291752AbSBNQkX>; Thu, 14 Feb 2002 11:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291766AbSBNQkR>; Thu, 14 Feb 2002 11:40:17 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:29968 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S291775AbSBNQkJ>; Thu, 14 Feb 2002 11:40:09 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 14 Feb 2002 16:40:02 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch/RfC] videodev redesign -- #3
Message-ID: <20020214164002.D8112@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

A new batch of patches for 2.5.5-pre1 is available from
http://bytesex.org/patches/2.5/

New are the video_exclusive_open/release functions.  While fixing the
radio drivers I've noticed they all had open/close functions doing
exactly the same, so I've moved that to videodev.c ...

The full description of the patches and the videodev patch itself are
below...

  Gerd

=========================== [ cut here ] ===========================

Patch descriptions
------------------

00_*
	Some trivial build fixes (might be present or not ...).

10_videodev
	videodev.[ch] redesign.  It does:

	 * drop the function pointers (read/write/mmap/poll/...) from
	   struct video_device, use struct file_operations directly
	   instead.  Dispatching to different drivers by minor number
	   is done the same way soundcore.o handles this: swap
	   file->f_fops at open() time.
	 * also drop the now obsolete video_red/write/mmap/poll/...
	   functions from videodev.c
	 * provide a video_generic_ioctl() function which can (and
	   should) be used by v4l drivers to handle copying from and
	   to userspace.
	 * provide video_exclusive_open/release functions which can
	   be used by v4l drivers to make sure only one process at a
	   time opens the device.  They can be hooked directly into
	   struct file_operations if some driver has nothing to
	   initialize at open time (which is true for many drivers in
	   drivers/media/radio/).

20_*
	Patches to adopt drivers to the new videodev interface.  For
	now I've fixed all drivers below drivers/media/, unless they
	are broken due to virt_to_bus() being gone anyway.

	ov511 updates are here:
		http://alpha.dyndns.org/ov511/download.html
	The other USB cam drivers are not updated yet.

30_bttv-i2c
	Update the small bttv i2c helper modules (tuner, tvaudio,
	msp3400, ...) to the latest versions (bttv 0.7.x).

31_bttv
	Major bttv update (0.7.x => 0.8.x).  Changes:

	 * Uses new videodev interface.
	 * Rewrite of the drivers core code (memory management, capture
	   code paths, ...), drops lot of historical cruft.
	 * v4l2 support (compile time option, needs additional v4l2
	   patch to work actually).

patch-<version>
	[x] all of the above

=========================== [ cut here ] ===========================
--- linux-2.5.5-pre1/include/linux/videodev.h	Thu Feb 14 12:10:32 2002
+++ linux/include/linux/videodev.h	Thu Feb 14 14:22:01 2002
@@ -4,6 +4,18 @@
 #include <linux/types.h>
 #include <linux/version.h>
 
+#if 0
+/*
+ * v4l2 is still work-in-progress, integration planed for 2.5.x
+ *   v4l2 project homepage:   http://www.thedirks.org/v4l2/
+ *   patches available from:  http://bytesex.org/patches/
+ */ 
+# define HAVE_V4L2 1
+# include <linux/videodev2.h>
+#else
+# undef HAVE_V4L2
+#endif
+
 #ifdef __KERNEL__
 
 #include <linux/poll.h>
@@ -13,24 +25,25 @@
 struct video_device
 {
 	struct module *owner;
-	char name[32];
-	int type;
+     	char name[32];
+ 	int type;       /* v4l1 */
+ 	int type2;      /* v4l2 */
 	int hardware;
+	int minor;
 
-	int (*open)(struct video_device *, int mode);
-	void (*close)(struct video_device *);
-	long (*read)(struct video_device *, char *, unsigned long, int noblock);
-	/* Do we need a write method ? */
-	long (*write)(struct video_device *, const char *, unsigned long, int noblock);
-#if LINUX_VERSION_CODE >= 0x020100
-	unsigned int (*poll)(struct video_device *, struct file *, poll_table *);
-#endif
-	int (*ioctl)(struct video_device *, unsigned int , void *);
-	int (*mmap)(struct vm_area_struct *vma, struct video_device *, const char *, unsigned long);
-	int (*initialize)(struct video_device *);	
+ 	/* new interface -- we will use file_operations directly
+ 	 * like soundcore does.
+ 	 * kernel_ioctl() will be called by video_generic_ioctl.
+ 	 * video_generic_ioctl() does the userspace copying of the
+ 	 * ioctl arguments */
+ 	struct file_operations *fops;
+ 	int (*kernel_ioctl)(struct inode *inode, struct file *file,
+ 			    unsigned int cmd, void *arg);
 	void *priv;		/* Used to be 'private' but that upsets C++ */
-	int busy;
-	int minor;
+
+	/* for videodev.c intenal usage -- don't touch */
+	int users;
+	struct semaphore lock;
 	devfs_handle_t devfs_handle;
 };
 
@@ -43,8 +56,13 @@
 #define VFL_TYPE_VTX		3
 
 extern void video_unregister_device(struct video_device *);
-#endif
+extern struct video_device* video_devdata(struct file*);
 
+extern int video_exclusive_open(struct inode *inode, struct file *file);
+extern int video_exclusive_release(struct inode *inode, struct file *file);
+extern int video_generic_ioctl(struct inode *inode, struct file *file,
+			       unsigned int cmd, unsigned long arg);
+#endif /* __KERNEL__ */
 
 #define VID_TYPE_CAPTURE	1	/* Can capture */
 #define VID_TYPE_TUNER		2	/* Can tune */
@@ -150,6 +168,7 @@
 #define VIDEO_AUDIO_VOLUME	4
 #define VIDEO_AUDIO_BASS	8
 #define VIDEO_AUDIO_TREBLE	16	
+#define VIDEO_AUDIO_BALANCE	32
 	char    name[16];
 #define VIDEO_SOUND_MONO	1
 #define VIDEO_SOUND_STEREO	2
@@ -379,4 +398,10 @@
 #define VID_HARDWARE_MEYE	32	/* Sony Vaio MotionEye cameras */
 #define VID_HARDWARE_CPIA2	33
 
-#endif
+#endif /* __LINUX_VIDEODEV_H */
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
--- linux-2.5.5-pre1/drivers/media/video/videodev.c	Thu Feb 14 08:10:30 2002
+++ linux/drivers/media/video/videodev.c	Thu Feb 14 14:22:01 2002
@@ -25,15 +25,13 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <linux/videodev.h>
 #include <linux/init.h>
-
+#include <linux/kmod.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/semaphore.h>
 
-#include <linux/kmod.h>
-
+#include <linux/videodev.h>
 
 #define VIDEO_NUM_DEVICES	256 
 
@@ -62,61 +60,20 @@
 
 #endif /* CONFIG_PROC_FS && CONFIG_VIDEO_PROC_FS */
 
-
-/*
- *	Read will do some smarts later on. Buffer pin etc.
- */
- 
-static ssize_t video_read(struct file *file,
-	char *buf, size_t count, loff_t *ppos)
-{
-	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
-	if(vfl->read)
-		return vfl->read(vfl, buf, count, file->f_flags&O_NONBLOCK);
-	else
-		return -EINVAL;
-}
-
-
-/*
- *	Write for now does nothing. No reason it shouldnt do overlay setting
- *	for some boards I guess..
- */
-
-static ssize_t video_write(struct file *file, const char *buf, 
-	size_t count, loff_t *ppos)
-{
-	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
-	if(vfl->write)
-		return vfl->write(vfl, buf, count, file->f_flags&O_NONBLOCK);
-	else
-		return 0;
-}
-
-/*
- *	Poll to see if we're readable, can probably be used for timing on incoming
- *	frames, etc..
- */
-
-static unsigned int video_poll(struct file *file, poll_table * wait)
+struct video_device* video_devdata(struct file *file)
 {
-	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
-	if(vfl->poll)
-		return vfl->poll(vfl, file, wait);
-	else
-		return 0;
+	return video_device[minor(file->f_dentry->d_inode->i_rdev)];
 }
 
-
 /*
  *	Open a video device.
  */
-
 static int video_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = minor(inode->i_rdev);
-	int err, retval = 0;
+	int err = 0;
 	struct video_device *vfl;
+	struct file_operations *old_fops;
 	
 	if(minor>=VIDEO_NUM_DEVICES)
 		return -ENODEV;
@@ -129,88 +86,115 @@
 		request_module(modname);
 		vfl=video_device[minor];
 		if (vfl==NULL) {
-			retval = -ENODEV;
+			err = -ENODEV;
 			goto error_out;
 		}
 	}
-	if(vfl->busy) {
-		retval = -EBUSY;
-		goto error_out;
+	unlock_kernel();
+
+	old_fops = file->f_op;
+	file->f_op = fops_get(vfl->fops);
+	if(file->f_op->open)
+		err = file->f_op->open(inode,file);
+	if (err) {
+		fops_put(file->f_op);
+		file->f_op = fops_get(old_fops);
 	}
-	vfl->busy=1;		/* In case vfl->open sleeps */
-	
-	if(vfl->owner)
-		__MOD_INC_USE_COUNT(vfl->owner);
+	fops_put(old_fops);
+	return err;
 	
-	if(vfl->open)
-	{
-		err=vfl->open(vfl,0);	/* Tell the device it is open */
-		if(err)
-		{
-			vfl->busy=0;
-			if(vfl->owner)
-				__MOD_DEC_USE_COUNT(vfl->owner);
-			
-			unlock_kernel();
-			return err;
-		}
-	}
-	unlock_kernel();
-	return 0;
 error_out:
 	unlock_kernel();
-	return retval;
+	return err;
 }
 
 /*
- *	Last close of a video for Linux device
+ * ioctl helper function -- handles userspace copying
  */
+int
+video_generic_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	struct  video_device *vfl = video_devdata(file);
+	char	sbuf[128];
+	void    *mbuf = NULL;
+	void	*parg = NULL;
+	int	err  = -EINVAL;
 	
-static int video_release(struct inode *inode, struct file *file)
-{
-	struct video_device *vfl;
-	lock_kernel();
-	vfl=video_device[minor(inode->i_rdev)];
-	if(vfl->close)
-		vfl->close(vfl);
-	vfl->busy=0;
-	if(vfl->owner)
-		__MOD_DEC_USE_COUNT(vfl->owner);
-	unlock_kernel();
-	return 0;
-}
+	if (vfl->kernel_ioctl == NULL)
+		return -EINVAL;
 
-static int video_ioctl(struct inode *inode, struct file *file,
-	unsigned int cmd, unsigned long arg)
-{
-	struct video_device *vfl=video_device[minor(inode->i_rdev)];
-	int err=vfl->ioctl(vfl, cmd, (void *)arg);
+	/*  Copy arguments into temp kernel buffer  */
+	switch (_IOC_DIR(cmd)) {
+	case _IOC_NONE:
+		parg = (void *)arg;
+		break;
+	case _IOC_READ: /* some v4l ioctls are marked wrong ... */
+	case _IOC_WRITE:
+	case (_IOC_WRITE | _IOC_READ):
+		if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
+			parg = sbuf;
+		} else {
+			/* too big to allocate from stack */
+			mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
+			if (NULL == mbuf)
+				return -ENOMEM;
+			parg = mbuf;
+		}
+		
+		err = -EFAULT;
+		if (copy_from_user(parg, (void *)arg, _IOC_SIZE(cmd)))
+			goto out;
+		break;
+	}
 
-	if(err!=-ENOIOCTLCMD)
-		return err;
-	
-	switch(cmd)
+	/* call driver */
+	err = vfl->kernel_ioctl(inode, file, cmd, parg);
+	if (err == -ENOIOCTLCMD)
+		err = -EINVAL;
+	if (err < 0)
+		goto out;
+
+	/*  Copy results into user buffer  */
+	switch (_IOC_DIR(cmd))
 	{
-		default:
-			return -EINVAL;
+	case _IOC_READ:
+	case (_IOC_WRITE | _IOC_READ):
+		if (copy_to_user((void *)arg, parg, _IOC_SIZE(cmd)))
+			err = -EFAULT;
+		break;
 	}
+
+out:
+	if (mbuf)
+		kfree(mbuf);
+	return err;
 }
 
 /*
- *	We need to do MMAP support
+ * open/release helper functions -- handle exclusive opens
  */
-  
-int video_mmap(struct file *file, struct vm_area_struct *vma)
+extern int video_exclusive_open(struct inode *inode, struct file *file)
 {
-	int ret = -EINVAL;
-	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
-	if(vfl->mmap) {
-		lock_kernel();
-		ret = vfl->mmap(vma, vfl, (char *)vma->vm_start, 
-				(unsigned long)(vma->vm_end-vma->vm_start));
-		unlock_kernel();
+	struct  video_device *vfl = video_devdata(file);
+	int retval = 0;
+
+	down(&vfl->lock);
+	if (vfl->users) {
+		retval = -EBUSY;
+	} else {
+		vfl->users++;
 	}
-	return ret;
+	up(&vfl->lock);
+	return retval;
+}
+
+extern int video_exclusive_release(struct inode *inode, struct file *file)
+{
+	struct  video_device *vfl = video_devdata(file);
+	
+	vfl->users--;
+	return 0;
 }
 
 /*
@@ -398,7 +382,6 @@
 {
 	int i=0;
 	int base;
-	int err;
 	int end;
 	char *name_base;
 	char name[16];
@@ -452,17 +435,7 @@
 	vfd->minor=i;
 	up(&videodev_register_lock);
 
-	/* The init call may sleep so we book the slot out
-	   then call */
 	MOD_INC_USE_COUNT;
-	if(vfd->initialize) {
-		err=vfd->initialize(vfd);
-		if(err<0) {
-			video_device[i]=NULL;
-			MOD_DEC_USE_COUNT;
-			return err;
-		}
-	}
 	sprintf (name, "v4l/%s%d", name_base, i - base);
 	/*
 	 *	Start the device root only. Anything else
@@ -474,6 +447,7 @@
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				&video_fops,
 				NULL);
+	init_MUTEX(&vfd->lock);
 	
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 	sprintf (name, "%s%d", name_base, i - base);
@@ -509,13 +483,7 @@
 {
 	owner:		THIS_MODULE,
 	llseek:		no_llseek,
-	read:		video_read,
-	write:		video_write,
-	ioctl:		video_ioctl,
-	mmap:		video_mmap,
 	open:		video_open,
-	release:	video_release,
-	poll:		video_poll,
 };
 
 /*
@@ -540,12 +508,9 @@
 
 static void __exit videodev_exit(void)
 {
-#ifdef MODULE		
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 	videodev_proc_destroy ();
 #endif
-#endif
-	
 	devfs_unregister_chrdev(VIDEO_MAJOR, "video_capture");
 }
 
@@ -554,6 +519,10 @@
 
 EXPORT_SYMBOL(video_register_device);
 EXPORT_SYMBOL(video_unregister_device);
+EXPORT_SYMBOL(video_devdata);
+EXPORT_SYMBOL(video_generic_ioctl);
+EXPORT_SYMBOL(video_exclusive_open);
+EXPORT_SYMBOL(video_exclusive_release);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Device registrar for Video4Linux drivers");
