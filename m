Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWAVR5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWAVR5K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWAVR5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:57:09 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:25170 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751299AbWAVR5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:57:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=PdVdn37dPk2EnO2iuYMTUvP+iSn6Ycvjcart0NYMx643MNUa/nb/+cgEXyyUzPyaWLz258nE3RXijGOUYXopR+zu6hX81xZ+VieaQlv0glWbmEmSEFPzNYIt0Ilp1VZ+iA5y/VvbIbm0wHwLyCVLzmsHTLHpO+Y3G3vpf/x2beU=
Message-ID: <9a8748490601220950o7306c082gaac72be87c333b8a@mail.gmail.com>
Date: Sun, 22 Jan 2006 18:50:25 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
Cc: Arjan van de Ven <arjan@infradead.org>, davej@redhat.com, bunk@stusta.de,
       linux-kernel@vger.kernel.org, pbadari@us.ibm.com,
       kenneth.w.chen@intel.com
In-Reply-To: <20060121133503.353ad1be.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19938_12341766.1137952225155"
References: <20060119030251.GG19398@stusta.de>
	 <20060118194103.5c569040.akpm@osdl.org>
	 <1137833547.2978.7.camel@laptopd505.fenrus.org>
	 <20060121194102.GB28051@redhat.com>
	 <20060121131718.1b6bbcdc.akpm@osdl.org>
	 <1137878739.23974.23.camel@laptopd505.fenrus.org>
	 <20060121133503.353ad1be.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_19938_12341766.1137952225155
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 1/21/06, Andrew Morton <akpm@osdl.org> wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > another thing we really should do is making such "obsolete to be phased
> >  out" things printk (at least once per boot ;) so that people see it in
> >  their logs, not just in the kernel source.
>
> Like sys_bdflush() has been doing for 3-4 years.  That still comes out on
> a few of my test boxes, but I'm a distro recidivist.
>

How about something like this?

- We extend the deadline by a year - that should give most people enough ti=
me.
- We make it *very clear* in text both in source comments, Kconfig,
  feature-removal-schedule and elsewhere that this feature *will* die soon.
- We make the build spit lots of 'deprecated' warnings when people build it=
.
- We make use of RAW devices printk() a warning so even people who don't re=
ad
  kernel documentation nor build their own kernels will notice.

Then next january we can kill the feature and rightfully claim that ample
warning has been given on all levels.


(patch also attached since gmail will likely break the inline version).


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/feature-removal-schedule.txt |    6 +++---
 Documentation/ioctl-mess.txt               |    2 ++
 drivers/char/Kconfig                       |   14 ++++++++++----
 drivers/char/raw.c                         |   28 +++++++++++++++++-------=
----
 fs/compat_ioctl.c                          |    8 ++++----
 include/linux/compat_ioctl.h               |    2 +-
 include/linux/raw.h                        |    5 +++++
 7 files changed, 42 insertions(+), 23 deletions(-)

--- linux-2.6.16-rc1-mm2-orig/Documentation/feature-removal-schedule.txt=09=
2006-01-20
21:50:43.000000000 +0100
+++ linux-2.6.16-rc1-mm2/Documentation/feature-removal-schedule.txt=092006-=
01-22
18:19:17.000000000 +0100
@@ -18,9 +18,9 @@ Who:=09Greg Kroah-Hartman <greg@kroah.com>
 ---------------------------

 What:=09RAW driver (CONFIG_RAW_DRIVER)
-When:=09December 2005
-Why:=09declared obsolete since kernel 2.6.3
-=09O_DIRECT can be used instead
+When:=09January 2007
+Why:=09Declared obsolete since kernel 2.6.3
+=09O_DIRECT can be used instead.
 Who:=09Adrian Bunk <bunk@stusta.de>

 ---------------------------
--- linux-2.6.16-rc1-mm2-orig/drivers/char/Kconfig=092006-01-20
21:50:44.000000000 +0100
+++ linux-2.6.16-rc1-mm2/drivers/char/Kconfig=092006-01-22
18:39:23.000000000 +0100
@@ -945,10 +945,11 @@ config RAW_DRIVER
 =09  The raw driver permits block devices to be bound to /dev/raw/rawN.
 =09  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O.
 =09  See the raw(8) manpage for more details.
-
-          The raw driver is deprecated and will be removed soon.
-          Applications should simply open the device (eg /dev/hda1)
-          with the O_DIRECT flag.
+=09
+=09  Feature removal warning:
+=09  The raw driver is deprecated and will be removed in January 2007.
+=09  Applications should simply open the device (eg /dev/hda1)
+=09  with the O_DIRECT flag.

 config MAX_RAW_DEVS
 =09int "Maximum number of RAW devices to support (1-8192)"
@@ -958,6 +959,11 @@ config MAX_RAW_DEVS
 =09  The maximum number of RAW devices that are supported.
 =09  Default is 256. Increase this number in case you need lots of
 =09  raw devices.
+=09
+=09  Feature removal warning:
+=09  The raw driver is deprecated and will be removed in January 2007.
+=09  Applications should simply open the device (eg /dev/hda1)
+=09  with the O_DIRECT flag.

 config HPET
 =09bool "HPET - High Precision Event Timer" if (X86 || IA64)
--- linux-2.6.16-rc1-mm2-orig/include/linux/raw.h=092006-01-03
04:21:10.000000000 +0100
+++ linux-2.6.16-rc1-mm2/include/linux/raw.h=092006-01-22 18:20:30.00000000=
0 +0100
@@ -1,3 +1,8 @@
+/*
+ * The RAW driver is obsolete and will go away in January 2007.
+ * Please use O_DIRECT instead.
+ */
+
 #ifndef __LINUX_RAW_H
 #define __LINUX_RAW_H

--- linux-2.6.16-rc1-mm2-orig/include/linux/compat_ioctl.h=092006-01-20
21:50:57.000000000 +0100
+++ linux-2.6.16-rc1-mm2/include/linux/compat_ioctl.h=092006-01-22
18:21:56.000000000 +0100
@@ -568,7 +568,7 @@ COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
 COMPATIBLE_IOCTL(DEVFSDIOC_RELEASE_EVENT_QUEUE)
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_DEBUG_MASK)
-/* Raw devices */
+/* Raw devices (obsolete and will go away January 2007 - don't use) */
 COMPATIBLE_IOCTL(RAW_SETBIND)
 COMPATIBLE_IOCTL(RAW_GETBIND)
 /* SMB ioctls which do not need any translations */
--- linux-2.6.16-rc1-mm2-orig/fs/compat_ioctl.c=092006-01-20
21:50:48.000000000 +0100
+++ linux-2.6.16-rc1-mm2/fs/compat_ioctl.c=092006-01-22 18:23:37.000000000 =
+0100
@@ -2148,7 +2148,7 @@ struct raw32_config_request
         __u64   block_minor;
 } __attribute__((packed));

-static int get_raw32_request(struct raw_config_request *req, struct
raw32_config_request __user *user_req)
+static int __deprecated get_raw32_request(struct raw_config_request
*req, struct raw32_config_request __user *user_req)
 {
         int ret;

@@ -2162,7 +2162,7 @@ static int get_raw32_request(struct raw_
         return ret ? -EFAULT : 0;
 }

-static int set_raw32_request(struct raw_config_request *req, struct
raw32_config_request __user *user_req)
+static int __deprecated set_raw32_request(struct raw_config_request
*req, struct raw32_config_request __user *user_req)
 {
 =09int ret;

@@ -2176,7 +2176,7 @@ static int set_raw32_request(struct raw_
         return ret ? -EFAULT : 0;
 }

-static int raw_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
+static int __deprecated raw_ioctl(unsigned fd, unsigned cmd, unsigned long=
 arg)
 {
         int ret;

@@ -2913,7 +2913,7 @@ HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgets
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
 HANDLE_IOCTL(REISERFS_IOC_UNPACK32, reiserfs_ioctl32)
-/* Raw devices */
+/* Raw devices (obsolete and will go away January 2007 - don't use) */
 HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
 HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
 /* Serial */
--- linux-2.6.16-rc1-mm2-orig/Documentation/ioctl-mess.txt=092006-01-20
21:50:43.000000000 +0100
+++ linux-2.6.16-rc1-mm2/Documentation/ioctl-mess.txt=092006-01-22
18:25:55.000000000 +0100
@@ -3385,6 +3385,8 @@ N: RAID_VERSION
 I: -
 O: struct mdu_version_s

+# Raw devices are obsolete and will go away in January 2007.
+# Please use O_DIRECT instead.
 N: RAW_GETBIND
 I: struct raw_config_request
 O: struct raw_config_request
--- linux-2.6.16-rc1-mm2-orig/drivers/char/raw.c=092006-01-20
21:50:44.000000000 +0100
+++ linux-2.6.16-rc1-mm2/drivers/char/raw.c=092006-01-22 18:36:07.000000000=
 +0100
@@ -6,6 +6,9 @@
  *
  * We reserve minor number 0 for a control interface.  ioctl()s on this
  * device are used to bind the other minor numbers to block devices.
+ *
+ * Raw devices are obsolete and going away in January 2007 in favour of
+ * O_DIRECT.
  */

 #include <linux/init.h>
@@ -43,12 +46,15 @@ static struct file_operations raw_ctl_fo
  * Set the device's soft blocksize to the minimum possible.  This gives th=
e
  * finest possible alignment and has no adverse impact on performance.
  */
-static int raw_open(struct inode *inode, struct file *filp)
+static int __deprecated raw_open(struct inode *inode, struct file *filp)
 {
 =09const int minor =3D iminor(inode);
 =09struct block_device *bdev;
 =09int err;

+=09printk(KERN_WARNING "RAW devices are obsolete and *WILL* be removed in"
+=09=09=09    " January 2007. Please use O_DIRECT instead.\n");
+
 =09if (minor =3D=3D 0) {=09/* It is the control device */
 =09=09filp->f_op =3D &raw_ctl_fops;
 =09=09return 0;
@@ -95,7 +101,7 @@ out:
  * When the final fd which refers to this character-special node is closed=
, we
  * make its ->mapping point back at its own i_data.
  */
-static int raw_release(struct inode *inode, struct file *filp)
+static int __deprecated raw_release(struct inode *inode, struct file *filp=
)
 {
 =09const int minor=3D iminor(inode);
 =09struct block_device *bdev;
@@ -117,8 +123,8 @@ static int raw_release(struct inode *ino
 /*
  * Forward ioctls to the underlying block device.
  */
-static int
-raw_ioctl(struct inode *inode, struct file *filp,
+static int
+__deprecated raw_ioctl(struct inode *inode, struct file *filp,
 =09=09  unsigned int command, unsigned long arg)
 {
 =09struct block_device *bdev =3D filp->private_data;
@@ -126,7 +132,7 @@ raw_ioctl(struct inode *inode, struct fi
 =09return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
 }

-static void bind_device(struct raw_config_request *rq)
+static void __deprecated bind_device(struct raw_config_request *rq)
 {
 =09class_device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
 =09class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, rq->raw_minor),
@@ -137,7 +143,7 @@ static void bind_device(struct raw_confi
  * Deal with ioctls against the raw-device control interface, to bind
  * and unbind other raw devices.
  */
-static int raw_ctl_ioctl(struct inode *inode, struct file *filp,
+static int __deprecated raw_ctl_ioctl(struct inode *inode, struct file *fi=
lp,
 =09=09=09unsigned int command, unsigned long arg)
 {
 =09struct raw_config_request rq;
@@ -239,8 +245,8 @@ out:
 =09return err;
 }

-static ssize_t raw_file_write(struct file *file, const char __user *buf,
-=09=09=09=09   size_t count, loff_t *ppos)
+static ssize_t __deprecated raw_file_write(struct file *file,
+=09=09=09const char __user *buf, size_t count, loff_t *ppos)
 {
 =09struct iovec local_iov =3D {
 =09=09.iov_base =3D (char __user *)buf,
@@ -250,8 +256,8 @@ static ssize_t raw_file_write(struct fil
 =09return generic_file_write_nolock(file, &local_iov, 1, ppos);
 }

-static ssize_t raw_file_aio_write(struct kiocb *iocb, const char __user *b=
uf,
-=09=09=09=09=09size_t count, loff_t pos)
+static ssize_t __deprecated raw_file_aio_write(struct kiocb *iocb,
+=09=09=09const char __user *buf, size_t count, loff_t pos)
 {
 =09struct iovec local_iov =3D {
 =09=09.iov_base =3D (char __user *)buf,
@@ -324,7 +330,7 @@ error:
 =09return 1;
 }

-static void __exit raw_exit(void)
+static void __deprecated __exit raw_exit(void)
 {
 =09int i;


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_19938_12341766.1137952225155
Content-Type: application/octet-stream; name=deprecate-raw.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="deprecate-raw.patch"


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/feature-removal-schedule.txt |    6 +++---
 Documentation/ioctl-mess.txt               |    2 ++
 drivers/char/Kconfig                       |   14 ++++++++++----
 drivers/char/raw.c                         |   28 +++++++++++++++++-----------
 fs/compat_ioctl.c                          |    8 ++++----
 include/linux/compat_ioctl.h               |    2 +-
 include/linux/raw.h                        |    5 +++++
 7 files changed, 42 insertions(+), 23 deletions(-)

--- linux-2.6.16-rc1-mm2-orig/Documentation/feature-removal-schedule.txt	2006-01-20 21:50:43.000000000 +0100
+++ linux-2.6.16-rc1-mm2/Documentation/feature-removal-schedule.txt	2006-01-22 18:19:17.000000000 +0100
@@ -18,9 +18,9 @@ Who:	Greg Kroah-Hartman <greg@kroah.com>
 ---------------------------
 
 What:	RAW driver (CONFIG_RAW_DRIVER)
-When:	December 2005
-Why:	declared obsolete since kernel 2.6.3
-	O_DIRECT can be used instead
+When:	January 2007
+Why:	Declared obsolete since kernel 2.6.3
+	O_DIRECT can be used instead.
 Who:	Adrian Bunk <bunk@stusta.de>
 
 ---------------------------
--- linux-2.6.16-rc1-mm2-orig/drivers/char/Kconfig	2006-01-20 21:50:44.000000000 +0100
+++ linux-2.6.16-rc1-mm2/drivers/char/Kconfig	2006-01-22 18:39:23.000000000 +0100
@@ -945,10 +945,11 @@ config RAW_DRIVER
 	  The raw driver permits block devices to be bound to /dev/raw/rawN. 
 	  Once bound, I/O against /dev/raw/rawN uses efficient zero-copy I/O. 
 	  See the raw(8) manpage for more details.
-
-          The raw driver is deprecated and will be removed soon.
-          Applications should simply open the device (eg /dev/hda1)
-          with the O_DIRECT flag.
+	  
+	  Feature removal warning:
+	  The raw driver is deprecated and will be removed in January 2007.
+	  Applications should simply open the device (eg /dev/hda1)
+	  with the O_DIRECT flag.
 
 config MAX_RAW_DEVS
 	int "Maximum number of RAW devices to support (1-8192)"
@@ -958,6 +959,11 @@ config MAX_RAW_DEVS
 	  The maximum number of RAW devices that are supported.
 	  Default is 256. Increase this number in case you need lots of
 	  raw devices.
+	  
+	  Feature removal warning:
+	  The raw driver is deprecated and will be removed in January 2007.
+	  Applications should simply open the device (eg /dev/hda1)
+	  with the O_DIRECT flag.
 
 config HPET
 	bool "HPET - High Precision Event Timer" if (X86 || IA64)
--- linux-2.6.16-rc1-mm2-orig/include/linux/raw.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc1-mm2/include/linux/raw.h	2006-01-22 18:20:30.000000000 +0100
@@ -1,3 +1,8 @@
+/*
+ * The RAW driver is obsolete and will go away in January 2007.
+ * Please use O_DIRECT instead.
+ */
+
 #ifndef __LINUX_RAW_H
 #define __LINUX_RAW_H
 
--- linux-2.6.16-rc1-mm2-orig/include/linux/compat_ioctl.h	2006-01-20 21:50:57.000000000 +0100
+++ linux-2.6.16-rc1-mm2/include/linux/compat_ioctl.h	2006-01-22 18:21:56.000000000 +0100
@@ -568,7 +568,7 @@ COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
 COMPATIBLE_IOCTL(DEVFSDIOC_RELEASE_EVENT_QUEUE)
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_DEBUG_MASK)
-/* Raw devices */
+/* Raw devices (obsolete and will go away January 2007 - don't use) */
 COMPATIBLE_IOCTL(RAW_SETBIND)
 COMPATIBLE_IOCTL(RAW_GETBIND)
 /* SMB ioctls which do not need any translations */
--- linux-2.6.16-rc1-mm2-orig/fs/compat_ioctl.c	2006-01-20 21:50:48.000000000 +0100
+++ linux-2.6.16-rc1-mm2/fs/compat_ioctl.c	2006-01-22 18:23:37.000000000 +0100
@@ -2148,7 +2148,7 @@ struct raw32_config_request
         __u64   block_minor;
 } __attribute__((packed));
 
-static int get_raw32_request(struct raw_config_request *req, struct raw32_config_request __user *user_req)
+static int __deprecated get_raw32_request(struct raw_config_request *req, struct raw32_config_request __user *user_req)
 {
         int ret;
 
@@ -2162,7 +2162,7 @@ static int get_raw32_request(struct raw_
         return ret ? -EFAULT : 0;
 }
 
-static int set_raw32_request(struct raw_config_request *req, struct raw32_config_request __user *user_req)
+static int __deprecated set_raw32_request(struct raw_config_request *req, struct raw32_config_request __user *user_req)
 {
 	int ret;
 
@@ -2176,7 +2176,7 @@ static int set_raw32_request(struct raw_
         return ret ? -EFAULT : 0;
 }
 
-static int raw_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
+static int __deprecated raw_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
 {
         int ret;
 
@@ -2913,7 +2913,7 @@ HANDLE_IOCTL(BLKGETSIZE64_32, do_blkgets
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_BOTH32, vfat_ioctl32)
 HANDLE_IOCTL(VFAT_IOCTL_READDIR_SHORT32, vfat_ioctl32)
 HANDLE_IOCTL(REISERFS_IOC_UNPACK32, reiserfs_ioctl32)
-/* Raw devices */
+/* Raw devices (obsolete and will go away January 2007 - don't use) */
 HANDLE_IOCTL(RAW_SETBIND, raw_ioctl)
 HANDLE_IOCTL(RAW_GETBIND, raw_ioctl)
 /* Serial */
--- linux-2.6.16-rc1-mm2-orig/Documentation/ioctl-mess.txt	2006-01-20 21:50:43.000000000 +0100
+++ linux-2.6.16-rc1-mm2/Documentation/ioctl-mess.txt	2006-01-22 18:25:55.000000000 +0100
@@ -3385,6 +3385,8 @@ N: RAID_VERSION
 I: -
 O: struct mdu_version_s
 
+# Raw devices are obsolete and will go away in January 2007.
+# Please use O_DIRECT instead.
 N: RAW_GETBIND
 I: struct raw_config_request
 O: struct raw_config_request
--- linux-2.6.16-rc1-mm2-orig/drivers/char/raw.c	2006-01-20 21:50:44.000000000 +0100
+++ linux-2.6.16-rc1-mm2/drivers/char/raw.c	2006-01-22 18:36:07.000000000 +0100
@@ -6,6 +6,9 @@
  *
  * We reserve minor number 0 for a control interface.  ioctl()s on this
  * device are used to bind the other minor numbers to block devices.
+ *
+ * Raw devices are obsolete and going away in January 2007 in favour of
+ * O_DIRECT.
  */
 
 #include <linux/init.h>
@@ -43,12 +46,15 @@ static struct file_operations raw_ctl_fo
  * Set the device's soft blocksize to the minimum possible.  This gives the
  * finest possible alignment and has no adverse impact on performance.
  */
-static int raw_open(struct inode *inode, struct file *filp)
+static int __deprecated raw_open(struct inode *inode, struct file *filp)
 {
 	const int minor = iminor(inode);
 	struct block_device *bdev;
 	int err;
 
+	printk(KERN_WARNING "RAW devices are obsolete and *WILL* be removed in"
+			    " January 2007. Please use O_DIRECT instead.\n");
+
 	if (minor == 0) {	/* It is the control device */
 		filp->f_op = &raw_ctl_fops;
 		return 0;
@@ -95,7 +101,7 @@ out:
  * When the final fd which refers to this character-special node is closed, we
  * make its ->mapping point back at its own i_data.
  */
-static int raw_release(struct inode *inode, struct file *filp)
+static int __deprecated raw_release(struct inode *inode, struct file *filp)
 {
 	const int minor= iminor(inode);
 	struct block_device *bdev;
@@ -117,8 +123,8 @@ static int raw_release(struct inode *ino
 /*
  * Forward ioctls to the underlying block device.
  */
-static int
-raw_ioctl(struct inode *inode, struct file *filp,
+static int 
+__deprecated raw_ioctl(struct inode *inode, struct file *filp,
 		  unsigned int command, unsigned long arg)
 {
 	struct block_device *bdev = filp->private_data;
@@ -126,7 +132,7 @@ raw_ioctl(struct inode *inode, struct fi
 	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
 }
 
-static void bind_device(struct raw_config_request *rq)
+static void __deprecated bind_device(struct raw_config_request *rq)
 {
 	class_device_destroy(raw_class, MKDEV(RAW_MAJOR, rq->raw_minor));
 	class_device_create(raw_class, NULL, MKDEV(RAW_MAJOR, rq->raw_minor),
@@ -137,7 +143,7 @@ static void bind_device(struct raw_confi
  * Deal with ioctls against the raw-device control interface, to bind
  * and unbind other raw devices.
  */
-static int raw_ctl_ioctl(struct inode *inode, struct file *filp,
+static int __deprecated raw_ctl_ioctl(struct inode *inode, struct file *filp,
 			unsigned int command, unsigned long arg)
 {
 	struct raw_config_request rq;
@@ -239,8 +245,8 @@ out:
 	return err;
 }
 
-static ssize_t raw_file_write(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t __deprecated raw_file_write(struct file *file,
+			const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct iovec local_iov = {
 		.iov_base = (char __user *)buf,
@@ -250,8 +256,8 @@ static ssize_t raw_file_write(struct fil
 	return generic_file_write_nolock(file, &local_iov, 1, ppos);
 }
 
-static ssize_t raw_file_aio_write(struct kiocb *iocb, const char __user *buf,
-					size_t count, loff_t pos)
+static ssize_t __deprecated raw_file_aio_write(struct kiocb *iocb,
+			const char __user *buf, size_t count, loff_t pos)
 {
 	struct iovec local_iov = {
 		.iov_base = (char __user *)buf,
@@ -324,7 +330,7 @@ error:
 	return 1;
 }
 
-static void __exit raw_exit(void)
+static void __deprecated __exit raw_exit(void)
 {
 	int i;
 

------=_Part_19938_12341766.1137952225155--
