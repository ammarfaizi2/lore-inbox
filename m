Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290502AbSBKVKv>; Mon, 11 Feb 2002 16:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290500AbSBKVKq>; Mon, 11 Feb 2002 16:10:46 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:17418 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S290496AbSBKVK1>; Mon, 11 Feb 2002 16:10:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Feb 2002 22:10:21 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: linux-kernel@vger.kernel.org,
        video4linux list <video4linux-list@redhat.com>,
        Alan Cox <alan@redhat.com>
Subject: [PATCH/RFC] videodev.[ch] redesign -- take #2
Message-ID: <20020211221021.A10304@bytesex.org>
In-Reply-To: <20020209194602.A23061@bytesex.org> <200202100203.g1A23To32387@devserv.devel.redhat.com> <slrna6cdk1.ret.kraxel@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrna6cdk1.ret.kraxel@bytesex.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Ok, next batch of patches.  Below are the videodev.c patches for both
2.5.x and 2.4.x.  The 2.5.x patches drop the old function pointers from
struct video_device and switch over to the new, struct file_operations
based setup completely (which breaks almost all existing v4l drivers).
The 2.4.x version of the patch supports both old (for backward
compatibility) and new (for 2.5.x compatibility) way to register v4l
drivers.

Related stuff:
  http://bytesex.org/patches/11_v4l_skel-2.4.18-pre9.diff
	The skeleton driver, if you want some sample code how to use
	the new-style v4l registration.  Last patch version had this
	included, I've separated it now.

  http://bytesex.org/bttv/
	bttv 0.8.x uses the new-style v4l registration too.

  http://bytesex.org/patches/2.5/
	Patches for 2.5.x, fix drivers to use the new-style v4l
	registration.  Right now there are a few patches for some of the
	radio drivers, more patches will follow next days.  Testers
	are very welcome ...

  Gerd

========== [ 2.5.x patch ] ==================================
--- linux-2.5.4/include/linux/videodev.h	Mon Feb 11 12:49:31 2002
+++ linux/include/linux/videodev.h	Mon Feb 11 19:29:43 2002
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
@@ -13,21 +25,20 @@
 struct video_device
 {
 	struct module *owner;
-	char name[32];
-	int type;
+     	char name[32];
+ 	int type;       /* v4l1 */
+ 	int type2;      /* v4l2 */
 	int hardware;
 
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
+
 	void *priv;		/* Used to be 'private' but that upsets C++ */
 	int busy;
 	int minor;
@@ -43,8 +54,11 @@
 #define VFL_TYPE_VTX		3
 
 extern void video_unregister_device(struct video_device *);
-#endif
+extern struct video_device* video_devdata(struct file*);
 
+extern int video_generic_ioctl(struct inode *inode, struct file *file,
+			       unsigned int cmd, unsigned long arg);
+#endif /* __KERNEL__ */
 
 #define VID_TYPE_CAPTURE	1	/* Can capture */
 #define VID_TYPE_TUNER		2	/* Can tune */
@@ -150,6 +164,7 @@
 #define VIDEO_AUDIO_VOLUME	4
 #define VIDEO_AUDIO_BASS	8
 #define VIDEO_AUDIO_TREBLE	16	
+#define VIDEO_AUDIO_BALANCE	32
 	char    name[16];
 #define VIDEO_SOUND_MONO	1
 #define VIDEO_SOUND_STEREO	2
@@ -379,4 +394,10 @@
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
--- linux-2.5.4/drivers/media/video/videodev.c	Mon Feb 11 11:57:11 2002
+++ linux/drivers/media/video/videodev.c	Mon Feb 11 15:09:50 2002
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
@@ -129,88 +86,89 @@
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
+	fops_put(old_fops);
+	return err;
 	
-	if(vfl->owner)
-		__MOD_INC_USE_COUNT(vfl->owner);
-	
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
-}
 
-/*
- *	We need to do MMAP support
- */
-  
-int video_mmap(struct file *file, struct vm_area_struct *vma)
-{
-	int ret = -EINVAL;
-	struct video_device *vfl=video_device[minor(file->f_dentry->d_inode->i_rdev)];
-	if(vfl->mmap) {
-		lock_kernel();
-		ret = vfl->mmap(vma, vfl, (char *)vma->vm_start, 
-				(unsigned long)(vma->vm_end-vma->vm_start));
-		unlock_kernel();
-	}
-	return ret;
+out:
+	if (mbuf)
+		kfree(mbuf);
+	return err;
 }
 
 /*
@@ -398,7 +356,6 @@
 {
 	int i=0;
 	int base;
-	int err;
 	int end;
 	char *name_base;
 	char name[16];
@@ -452,17 +409,7 @@
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
@@ -509,13 +456,7 @@
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
@@ -540,12 +481,9 @@
 
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
 
@@ -554,6 +492,8 @@
 
 EXPORT_SYMBOL(video_register_device);
 EXPORT_SYMBOL(video_unregister_device);
+EXPORT_SYMBOL(video_devdata);
+EXPORT_SYMBOL(video_generic_ioctl);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Device registrar for Video4Linux drivers");
========== [ 2.4.x patch ] ==================================
--- linux-2.4.18-pre9/include/linux/videodev.h	Mon Feb 11 13:20:44 2002
+++ linux/include/linux/videodev.h	Mon Feb 11 15:11:05 2002
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
@@ -12,22 +24,31 @@
 struct video_device
 {
 	struct module *owner;
-	char name[32];
-	int type;
+    	char name[32];
+	int type;       /* v4l1 */
+	int type2;      /* v4l2 */
 	int hardware;
 
+	/* old, obsolete interface -- dropped in 2.5.x, don't use it */
 	int (*open)(struct video_device *, int mode);
 	void (*close)(struct video_device *);
 	long (*read)(struct video_device *, char *, unsigned long, int noblock);
-	/* Do we need a write method ? */
 	long (*write)(struct video_device *, const char *, unsigned long, int noblock);
-#if LINUX_VERSION_CODE >= 0x020100
 	unsigned int (*poll)(struct video_device *, struct file *, poll_table *);
-#endif
 	int (*ioctl)(struct video_device *, unsigned int , void *);
 	int (*mmap)(struct video_device *, const char *, unsigned long);
-	int (*initialize)(struct video_device *);	
-	void *priv;		/* Used to be 'private' but that upsets C++ */
+	int (*initialize)(struct video_device *);       
+
+	/* new interface -- we will use file_operations directly
+	 * like soundcore does.
+	 * kernel_ioctl() will be called by video_generic_ioctl.
+	 * video_generic_ioctl() does the userspace copying of the
+	 * ioctl arguments */
+	struct file_operations *fops;
+	int (*kernel_ioctl)(struct inode *inode, struct file *file,
+			    unsigned int cmd, void *arg);
+
+	void *priv; /* Used to be 'private' but that upsets C++ */
 	int busy;
 	int minor;
 	devfs_handle_t devfs_handle;
@@ -42,8 +63,11 @@
 #define VFL_TYPE_VTX		3
 
 extern void video_unregister_device(struct video_device *);
-#endif
+extern struct video_device* video_devdata(struct file*);
 
+extern int video_generic_ioctl(struct inode *inode, struct file *file,
+			       unsigned int cmd, unsigned long arg);
+#endif /* __KERNEL__ */
 
 #define VID_TYPE_CAPTURE	1	/* Can capture */
 #define VID_TYPE_TUNER		2	/* Can tune */
@@ -149,6 +173,7 @@
 #define VIDEO_AUDIO_VOLUME	4
 #define VIDEO_AUDIO_BASS	8
 #define VIDEO_AUDIO_TREBLE	16	
+#define VIDEO_AUDIO_BALANCE	32
 	char    name[16];
 #define VIDEO_SOUND_MONO	1
 #define VIDEO_SOUND_STEREO	2
@@ -378,4 +403,10 @@
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
--- linux-2.4.18-pre9/drivers/media/video/videodev.c	Mon Feb 11 13:20:08 2002
+++ linux/drivers/media/video/videodev.c	Mon Feb 11 15:06:35 2002
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
 
@@ -70,7 +68,7 @@
 static ssize_t video_read(struct file *file,
 	char *buf, size_t count, loff_t *ppos)
 {
-	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct video_device *vfl = video_devdata(file);
 	if(vfl->read)
 		return vfl->read(vfl, buf, count, file->f_flags&O_NONBLOCK);
 	else
@@ -86,13 +84,18 @@
 static ssize_t video_write(struct file *file, const char *buf, 
 	size_t count, loff_t *ppos)
 {
-	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct video_device *vfl = video_devdata(file);
 	if(vfl->write)
 		return vfl->write(vfl, buf, count, file->f_flags&O_NONBLOCK);
 	else
 		return 0;
 }
 
+struct video_device* video_devdata(struct file *file)
+{
+	return video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+}
+
 /*
  *	Poll to see if we're readable, can probably be used for timing on incoming
  *	frames, etc..
@@ -100,7 +103,7 @@
 
 static unsigned int video_poll(struct file *file, poll_table * wait)
 {
-	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct video_device *vfl = video_devdata(file);
 	if(vfl->poll)
 		return vfl->poll(vfl, file, wait);
 	else
@@ -133,6 +136,22 @@
 			goto error_out;
 		}
 	}
+	if (vfl->fops) {
+		int err = 0;
+		struct file_operations *old_fops;
+
+		unlock_kernel();
+		old_fops = file->f_op;
+                file->f_op = fops_get(vfl->fops);
+                if(file->f_op->open)
+                        err = file->f_op->open(inode,file);
+                if (err) {
+                        fops_put(file->f_op);
+                        file->f_op = fops_get(old_fops);
+                }
+                fops_put(old_fops);
+                return err;
+	}
 	if(vfl->busy) {
 		retval = -EBUSY;
 		goto error_out;
@@ -170,7 +189,7 @@
 {
 	struct video_device *vfl;
 	lock_kernel();
-	vfl=video_device[MINOR(inode->i_rdev)];
+	vfl = video_devdata(file);
 	if(vfl->close)
 		vfl->close(vfl);
 	vfl->busy=0;
@@ -183,7 +202,7 @@
 static int video_ioctl(struct inode *inode, struct file *file,
 	unsigned int cmd, unsigned long arg)
 {
-	struct video_device *vfl=video_device[MINOR(inode->i_rdev)];
+	struct video_device *vfl = video_devdata(file);
 	int err=vfl->ioctl(vfl, cmd, (void *)arg);
 
 	if(err!=-ENOIOCTLCMD)
@@ -203,7 +222,7 @@
 int video_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret = -EINVAL;
-	struct video_device *vfl=video_device[MINOR(file->f_dentry->d_inode->i_rdev)];
+	struct video_device *vfl = video_devdata(file);
 	if(vfl->mmap) {
 		lock_kernel();
 		ret = vfl->mmap(vfl, (char *)vma->vm_start, 
@@ -214,6 +233,69 @@
 }
 
 /*
+ * ioctl helper function -- handles userspace copying
+ */
+int
+video_generic_ioctl(struct inode *inode, struct file *file,
+		    unsigned int cmd, unsigned long arg)
+{
+	struct  video_device *vfl = video_devdata(file);
+	char	sbuf[128];
+	void    *mbuf = NULL;
+	void	*parg = NULL;
+	int	err  = -EINVAL;
+	
+	if (vfl->kernel_ioctl == NULL)
+		return -EINVAL;
+
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
+
+	/* call driver */
+	err = vfl->kernel_ioctl(inode, file, cmd, parg);
+	if (err == -ENOIOCTLCMD)
+		err = -EINVAL;
+	if (err < 0)
+		goto out;
+
+	/*  Copy results into user buffer  */
+	switch (_IOC_DIR(cmd))
+	{
+	case _IOC_READ:
+	case (_IOC_WRITE | _IOC_READ):
+		if (copy_to_user((void *)arg, parg, _IOC_SIZE(cmd)))
+			err = -EFAULT;
+		break;
+	}
+
+out:
+	if (mbuf)
+		kfree(mbuf);
+	return err;
+}
+
+/*
  *	/proc support
  */
 
@@ -540,12 +622,9 @@
 
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
 
@@ -554,6 +633,8 @@
 
 EXPORT_SYMBOL(video_register_device);
 EXPORT_SYMBOL(video_unregister_device);
+EXPORT_SYMBOL(video_devdata);
+EXPORT_SYMBOL(video_generic_ioctl);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Device registrar for Video4Linux drivers");
