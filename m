Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbSBISp0>; Sat, 9 Feb 2002 13:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282902AbSBISpT>; Sat, 9 Feb 2002 13:45:19 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:7694 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S282845AbSBISpI>; Sat, 9 Feb 2002 13:45:08 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Sat, 9 Feb 2002 19:46:02 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Kernel List <linux-kernel@vger.kernel.org>,
        video4linux list <video4linux-list@redhat.com>
Subject: [PATCH/RFC] videodev.[ch] redesign
Message-ID: <20020209194602.A23061@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

In 2.5.x I want to drop the open/read/write/poll/mmap/... function
pointers from struct video_device and all the useless
video_read/write/poll/mmap/...  wrapper functions from videodev.c.

Instead, I'd like to see the video4linux drivers use struct
file_operations directly and handle the device registration like
soundcore does it for the sound drivers: simply swap file->f_op in
video_open().

The patch below does part one of the plan -- for 2.4.x kernels.  It adds
the fops pointer to struct video_device and makes video_open use it if
available, so both old + new style drivers will work.

It also provides a ioctl wrapper function which handles copying the
ioctl args from/to userspace, so we have this at one place can drop all
the copy_from/to_user calls within the v4l device driver ioctl handlers.

Comments?

  Gerd

[mailed to both lkml + video4linux list]

-------------------------- cut here -------------------------
--- linux-2.4.18-pre8/include/linux/videodev.h	Tue Feb  5 11:21:37 2002
+++ linux/include/linux/videodev.h	Tue Feb  5 11:33:04 2002
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
 
+	/* old, obsolete interface -- to be removed some day (2.5.x ?) */
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
--- linux-2.4.18-pre8/drivers/media/video/Config.in	Tue Feb  5 11:21:40 2002
+++ linux/drivers/media/video/Config.in	Tue Feb  5 11:33:04 2002
@@ -8,6 +8,7 @@
 dep_tristate '  I2C on parallel port' CONFIG_I2C_PARPORT $CONFIG_PARPORT $CONFIG_I2C
 
 comment 'Video Adapters'
+dep_tristate '  Skeleton Driver Video For Linux' CONFIG_VIDEO_SKELETON $CONFIG_VIDEO_DEV
 if [ "$CONFIG_I2C_ALGOBIT" = "y" -o "$CONFIG_I2C_ALGOBIT" = "m" ]; then
    dep_tristate '  BT848 Video For Linux' CONFIG_VIDEO_BT848 $CONFIG_VIDEO_DEV $CONFIG_PCI $CONFIG_I2C_ALGOBIT
 fi
--- linux-2.4.18-pre8/drivers/media/video/Makefile	Tue Feb  5 11:21:32 2002
+++ linux/drivers/media/video/Makefile	Tue Feb  5 11:33:04 2002
@@ -33,6 +33,7 @@
 
 obj-$(CONFIG_VIDEO_DEV) += videodev.o
 
+obj-$(CONFIG_VIDEO_SKELETON) += skeleton.o
 obj-$(CONFIG_BUS_I2C) += i2c-old.o
 obj-$(CONFIG_VIDEO_BT848) += bttv.o msp3400.o tvaudio.o \
 	tda7432.o tda9875.o tuner.o
--- linux-2.4.18-pre8/drivers/media/video/skeleton.c	Tue Feb  5 11:33:04 2002
+++ linux/drivers/media/video/skeleton.c	Tue Feb  5 12:27:18 2002
@@ -0,0 +1,249 @@
+/*
+ * video4linux driver skeleton
+ *
+ *   You can build and insmod it.  It doesn't do anything fancy, just
+ *   prints some messages when the file_operations functions are called.
+ *
+ *   written by Gerd Knorr <kraxel@bytesex.org>
+ *   this source file is public domain, you can do with it
+ *   whatever you like ...
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/videodev.h>
+
+#define DEVNAME "skeleton"
+
+/* ------------------------------------------------------------------ */
+
+struct device_data {
+	struct list_head     devlist;
+	struct video_device  vdev;
+	struct semaphore     lock;
+	int                  users;
+	/* more device specific stuff */
+};
+
+struct file_data {
+	struct device_data   *dev;
+
+	/* just some random value to show how to keep multiple file
+	 * handles apart and decorate the debug printk's a bit */
+	int                  cookie; 
+
+	/* more filehandle specific data */
+};
+
+/* ------------------------------------------------------------------ */
+
+static unsigned int exclusive = 0;
+static unsigned int debug = 1;
+static unsigned int video_nr = -1;
+MODULE_PARM(debug,"i");
+MODULE_PARM_DESC(debug,"enable debug messages (default: on)");
+MODULE_PARM(exclusive,"i");
+MODULE_PARM_DESC(exclusive,"only one process can open the device (default: off)");
+MODULE_PARM(video_nr,"i");
+MODULE_PARM_DESC(video_nr,"device number");
+
+MODULE_AUTHOR("Gerd Knorr");
+MODULE_DESCRIPTION("video4linux driver skeleton");
+MODULE_LICENSE("GPL and additional rights");
+
+#define dprintk(fmt, arg...)	if (debug) \
+	printk(KERN_DEBUG DEVNAME ": " fmt, ## arg)
+
+static struct list_head skeldev;
+
+/* ------------------------------------------------------------------ */
+
+static int skeleton_open(struct inode *inode, struct file *file)
+{
+	static int cookie = 42;
+	unsigned int minor = MINOR(inode->i_rdev);
+	struct device_data *h,*dev = NULL;
+	struct file_data *fh;
+	struct list_head *list;
+	
+	dprintk("open: looking for my device [minor=%d]\n",minor);
+
+	list_for_each(list,&skeldev) {
+		h = list_entry(list, struct device_data, devlist);
+		if (h->vdev.minor == minor)
+			dev = h;
+	}
+	if (NULL == dev)
+		return -ENODEV;
+	
+	down(&dev->lock);
+	dprintk("open: device found (%d users)\n",dev->users);
+	if (exclusive && dev->users > 0) {
+		dprintk("open: device busy\n");
+		up(&dev->lock);
+		return -EBUSY;
+	}
+	
+	/* allocate + initialize per filehandle data */
+	fh = kmalloc(sizeof(*fh),GFP_KERNEL);
+	if (NULL == fh)
+		return -ENOMEM;
+	file->private_data = fh;
+	memset(fh,0,sizeof(*fh));
+	fh->dev    = dev;
+	fh->cookie = cookie++;
+
+	dprintk("open successful [minor=%d,cookie=%d]\n",
+		dev->vdev.minor,fh->cookie);
+	dev->users++;
+	up(&dev->lock);
+        return 0;
+}
+
+static int skeleton_release(struct inode *inode, struct file *file)
+{
+	struct file_data *fh    = file->private_data;
+	struct device_data *dev = fh->dev;
+
+	dprintk("release called [minor=%d,cookie=%d]\n",
+		dev->vdev.minor,fh->cookie);
+	file->private_data = NULL;
+	kfree(fh);
+	dev->users--;
+	return 0;
+}
+
+static ssize_t
+skeleton_read(struct file *file, char *data, size_t count, loff_t *ppos)
+{
+	struct file_data *fh    = file->private_data;
+	struct device_data *dev = fh->dev;
+
+	dprintk("read called [minor=%d,cookie=%d]\n",
+		dev->vdev.minor,fh->cookie);
+	return 0; /* EOF */
+}
+
+static int
+skeleton_mmap(struct file *file, struct vm_area_struct * vma)
+{
+	struct file_data *fh    = file->private_data;
+	struct device_data *dev = fh->dev;
+
+	dprintk("mmap called [minor=%d,cookie=%d]\n",
+		dev->vdev.minor,fh->cookie);
+	return -EINVAL;
+}
+
+/*
+ * This function is _not_ called directly, but from
+ * video_generic_ioctl (and maybe others).  userspace
+ * copying is done already, arg is a kernel pointer.
+ */
+static int skeleton_ioctl(struct inode *inode, struct file *file,
+			  unsigned int cmd, void *arg)
+{
+	struct file_data *fh    = file->private_data;
+	struct device_data *dev = fh->dev;
+
+	dprintk("ioctl called [minor=%d,cookie=%d,cmd=0x%x,arg=%p]\n",
+		dev->vdev.minor,fh->cookie,cmd,arg);
+	switch (cmd) {
+	case VIDIOCGCAP:
+	{
+                struct video_capability *cap = arg;
+		memset(cap,0,sizeof(*cap));
+		strcpy(cap->name,dev->vdev.name);
+                return 0;
+	}
+	/* all the ioctls go here */
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
+static struct file_operations skeleton_fops =
+{
+	owner:	  THIS_MODULE,
+	open:	  skeleton_open,
+	release:  skeleton_release,
+	read:	  skeleton_read,
+	mmap:	  skeleton_mmap,
+	ioctl:	  video_generic_ioctl,
+	llseek:   no_llseek,
+};
+
+static struct video_device skeleton_template =
+{
+	name:          "undef",
+	type:          0,
+	hardware:      0,
+	fops:          &skeleton_fops,
+	kernel_ioctl:  skeleton_ioctl,
+	minor:         -1,
+};
+
+/* ------------------------------------------------------------------ */
+
+int skeleton_initdev(char *name)
+{
+	struct device_data *dev;
+	int err;
+
+	dev = kmalloc(sizeof(*dev),GFP_KERNEL);
+	if (NULL == dev)
+		return -ENOMEM;
+	memset(dev,0,sizeof(*dev));
+        init_MUTEX(&dev->lock);
+
+	/* initialize device here */
+
+	dev->vdev = skeleton_template;
+	strcpy(dev->vdev.name, name);
+	dev->vdev.priv = dev;
+	err = video_register_device(&dev->vdev,VFL_TYPE_GRABBER,video_nr);
+	if (err < 0) {
+		kfree(dev);
+		return err;
+	}
+	list_add_tail(&dev->devlist,&skeldev);
+	dprintk("registered device %s [minor=%d]\n",name,dev->vdev.minor);
+	return 0;
+}
+
+int skeleton_init(void)
+{
+	dprintk("video4linux skeleton driver loaded\n");
+	INIT_LIST_HEAD(&skeldev);
+	skeleton_initdev("skeleton-1");
+	skeleton_initdev("skeleton-2");
+	return 0;
+}
+
+void skeleton_fini(void)
+{
+	struct device_data *dev;
+
+	while (!list_empty(&skeldev)) {
+		dev = list_entry(skeldev.next, struct device_data, devlist);
+		video_unregister_device(&dev->vdev);
+		kfree(dev);
+		list_del(&dev->devlist);
+	}
+	dprintk("unloaded\n");
+}
+
+module_init(skeleton_init);
+module_exit(skeleton_fini);
+
+/*
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
--- linux-2.4.18-pre8/drivers/media/video/videodev.c	Tue Feb  5 11:21:16 2002
+++ linux/drivers/media/video/videodev.c	Tue Feb  5 11:33:04 2002
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
 
@@ -554,6 +636,8 @@
 
 EXPORT_SYMBOL(video_register_device);
 EXPORT_SYMBOL(video_unregister_device);
+EXPORT_SYMBOL(video_devdata);
+EXPORT_SYMBOL(video_generic_ioctl);
 
 MODULE_AUTHOR("Alan Cox");
 MODULE_DESCRIPTION("Device registrar for Video4Linux drivers");
--- linux-2.4.18-pre8/Documentation/Configure.help	Tue Feb  5 11:21:49 2002
+++ linux/Documentation/Configure.help	Tue Feb  5 11:33:04 2002
@@ -21269,6 +21269,19 @@
   To use this option, you have to check, that the "/proc file system
   support" (CONFIG_PROC_FS) is enabled too.
 
+Skeleton Video Capture Driver
+CONFIG_VIDEO_SKELETON
+  This code is a skeleton driver that only illustrates how V4L
+  drivers register and communicate with the Video for Linux subsystem.
+  It does nothing.
+
+  This driver is also available as a module called skeleton.o ( = code
+  which can be inserted in and removed from the running kernel 
+  whenever you want). If you want to compile it as a module, say M 
+  here and read Documentation/modules.txt.
+
+  If unsure, say N, otherwise say N anyway.
+
 AIMSlab RadioTrack (aka RadioReveal) support
 CONFIG_RADIO_RTRACK
   Choose Y here if you have one of these FM radio cards, and then fill
