Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbUL3Obx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbUL3Obx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 09:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUL3Obx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 09:31:53 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46992 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261642AbUL3Obk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 09:31:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 7/8] s390: new DCSS SHM device driver
Date: Thu, 30 Dec 2004 15:24:49 +0100
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Carsten Otte <cotte@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20041228082837.GH7988@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20041228082837.GH7988@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Message-Id: <200412301524.50557.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_y+A1BYgvcZHIWAi";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_y+A1BYgvcZHIWAi
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dinsdag 28 Dezember 2004 09:28, Heiko Carstens wrote:
> [PATCH 7/8] s390: dcss shared memory.
>=20
> From: Carsten Otte <cotte@de.ibm.com>
>=20
> Add support for shared memory using z/VM DCSS.

I'd rather not see this driver merged at this point. It's completely
lacking support for class devices, which means it will not work
with udev. Also, I'm still feeling the interface should much more
resemble Posix shared memory rather than 'use sysfs to create a
character device per shared memory segment'.

Ideally, we should have some user interface that also makes sense
for cross-guest shared memory on UML/Xen/etc.

Regarding the use of sysfs, I also think the memory segment
'devices' should share the name space with the ones used in dcssblk,
since they are actually the same resources, just used by different
device drivers. So instead of having

/sys/block/dcssblk/dcssblk0/device -> ../../../devices/dcssblk/foo
/sys/devices/dcssblk/foo/
/sys/devices/dcssshm/bar/

it rather should be

/sys/block/dcssblk/dcssblk0/device -> ../../../devices/dcss/foo
/sys/class/dcssshm/yourseg/device -> ../../../devices/dcss/bar
/sys/devices/dcss/foo/
/sys/devices/dcss/bar/

I'd really like to hear an outside opinion on this.

Since Carsten is currently on vacation, he won't be able to reply
too soon, so I suggest we postpone this for now.

Carsten, sorry I couldn't look over this before Heiko sent it out,
the next evening out is on me.

There are also a few smaller nits I'd like to pick:

> +#include <asm/ccwdev.h>  // for s390_root_dev_(un)register()

This seems to be getting out of the original scope. I don't know
if anything better exists already, but I don't think registering
bus devices at the /sys/devices should depend on architecture
specific code. Either we agree that such a function is needed
for all architectures, or we should stop using it.

> +#define DCSSSHM_DEBUG  /* Debug messages on/off */
> +#define DCSSSHM_NAME "dcssshm"
> +#ifdef DCSSSHM_DEBUG
> +#define PRINT_DEBUG(x...) printk(KERN_DEBUG DCSSSHM_NAME " debug: " x)
> +#else
> +#define PRINT_DEBUG(x...) do {} while (0)
> +#endif
> +#define PRINT_INFO(x...)  printk(KERN_INFO DCSSSHM_NAME " info: " x)
> +#define PRINT_WARN(x...)  printk(KERN_WARNING DCSSSHM_NAME " warning: " =
x)
> +#define PRINT_ERR(x...)   printk(KERN_ERR DCSSSHM_NAME " error: " x)

IMHO, it would be better to use pr_info/pr_debug for new code.

> +
> +static ssize_t dcssshm_add_store(struct device * dev, const char * buf,
> +      size_t count);
> +static ssize_t dcssshm_remove_store(struct device * dev, const char * bu=
f,
> +      size_t count);
> +static ssize_t dcssshm_save_store(struct device * dev, const char * buf,
> +      size_t count);
> +static ssize_t dcssshm_save_show(struct device *dev, char *buf);
> +static ssize_t dcssshm_shared_store(struct device * dev, const char * bu=
f,
> +      size_t count);
> +static ssize_t dcssshm_shared_show(struct device *dev, char *buf);
> +
> +static int   dcssshm_open(struct inode *inode, struct file *filp);
> +static int   dcssshm_release(struct inode *inode, struct file *filp);
> +static int dcssshm_mmap(struct file * file, struct vm_area_struct * vma);
> +static struct page * dcssshm_nopage_in_place(struct vm_area_struct * are=
a,
> +          unsigned long address, int* type);
> +static loff_t dcssshm_llseek (struct file* file, loff_t offset, int orig=
);

If you move all functions into call graph order, you don't need any forward
declarations and at the same time it becomes obvious that there are no
direct recursions.

> +static DEVICE_ATTR(add, S_IWUSR, NULL, dcssshm_add_store);
> +static DEVICE_ATTR(remove, S_IWUSR, NULL, dcssshm_remove_store);

Maybe it's just me, but these edge-triggered event attributes in sysfs
feel wrong.

> +struct dcssshm_dev_info {
> + struct list_head lh;
> + struct device dev;
> + struct cdev *cdev;
> + char segment_name[BUS_ID_SIZE];
> + atomic_t use_count;
> + unsigned long start;
> + unsigned long end;
> + int segment_type;
> + unsigned char save_pending;
> + unsigned char is_shared;
> + unsigned char is_ro;
> + int minor;
> +};
It may be better to have two structures here, on that embeds the device
and one that embeds the cdev and class_device.

> +static struct vm_operations_struct dcssshm_vm_ops =3D {
> + .nopage  =3D dcssshm_nopage_in_place,
> +};
> +
> +static struct file_operations dcssshm_fops =3D
> +{
Slightly inconsistent indentation here.

> +static struct list_head dcssshm_devices =3D LIST_HEAD_INIT(dcssshm_devic=
es);
> +static struct rw_semaphore dcssshm_devices_sem;
static LIST_HEAD(dcssshm_devices);
static DECLARE_MUTEX(dcssshm_devices_sem);

> +/*
> + * release function for segment device.
> + */
> +static void
> +dcssshm_release_segment(struct device *dev)
> +{
> + PRINT_DEBUG("segment release fn called for %s\n", dev->bus_id);
> + kfree(container_of(dev, struct dcssshm_dev_info, dev));
> + module_put(THIS_MODULE);
> +}
AFAICS, there is still a tiny race against module unload here:
module_put(THIS_MODULE) is practically always a bug!

> +
> +/*
> + * get a minor number. needs to be called with
> + * down_write(&dcssshm_devices_sem) and the
> + * device needs to be enqueued before the semaphore is
> + * freed.
> + */
> +static inline int
> +dcssshm_assign_free_minor(struct dcssshm_dev_info *dev_info)
> +{
> + int minor, found;

This can probably be done much simpler using idr.

> + local_buf =3D kmalloc(count + 1, GFP_KERNEL);
> + if (local_buf =3D=3D NULL) {
> +  rc =3D -ENOMEM;
> +  goto out_nobuf;
> + }

Why use kmalloc for this, when the buffer must not exceed 9 bytes?


> + if (imajor(filp->f_dentry->d_inode) !=3D dcssshm_major)
> +  return -ENODEV;

huh?

> +
> + minor =3D iminor(filp->f_dentry->d_inode);

iminor(inode) ?

> + down_write(&dcssshm_devices_sem);
> + dev_info =3D dcssshm_get_device_by_minor(minor);
> + if (!dev_info) {
> +  rc =3D -ENODEV;
> +  goto up_read;
> + }
> +
> +
> + filp->private_data =3D dev_info;
> + atomic_inc(&dev_info->use_count);

Why the extra use count?

> +
> + rc =3D 0;
> +up_read:
> + up_write(&dcssshm_devices_sem);

Interesting label name 8-)

> +static loff_t
> +dcssshm_llseek (struct file* file, loff_t offset, int orig)
> +{
> + loff_t ret;
> + struct dcssshm_dev_info *dev_info =3D (struct dcssshm_dev_info*)
> +      file->private_data;

Is seek actually useful if you don't have read/write?

> + rc =3D device_create_file(dcssshm_root_dev, &dev_attr_remove);
> + if (rc) {
> +  PRINT_ERR("device_create_file(remove) failed!\n");
> +  s390_root_dev_unregister(dcssshm_root_dev);
> +  return rc;
> + }
> + rc =3D alloc_chrdev_region (&dev, 0, 256, "dcssshm");
> + if (rc) {
> +         PRINT_ERR("alloc_chrdev_region falied!\n");
> +  s390_root_dev_unregister(dcssshm_root_dev);
> +  return rc;
> + }

Why the limit to 256 segments? The rest of the driver appears
to be written to avoid such limitations. Also, using goto for
error handling, like in the other functions, would make this more
readable.

	Arnd <><



--Boundary-02=_y+A1BYgvcZHIWAi
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB1A+y5t5GS2LDRf4RApi0AKCMD3V/m1IEhirNLWN5AgHROhfPIgCgnK+9
Lb0BDHAw4Xdu1HR9R4jOWn0=
=uKaA
-----END PGP SIGNATURE-----

--Boundary-02=_y+A1BYgvcZHIWAi--
