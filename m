Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWAUWDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWAUWDl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWAUWDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:03:39 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:35899 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932401AbWAUWDS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:03:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z54qhL1GrYyHvuuBlilGWC1xLMxiitzmkeux9OLDwoTrREJTvJ06peLYmqfZhRCHnFSQ6OPG7y9eqmer+HoApE7WIa6XLpeVvvY/F10tze3kRMWZ82I0ZBkb6dXVQDKU1xpappaJX1O/8ZxdrQ8LS3hWCbEku+/vxsPjo/Rr/r0=
Message-ID: <21d7e9970601211403g44ce4845yd03f12f64142ef36@mail.gmail.com>
Date: Sun, 22 Jan 2006 11:03:16 +1300
From: Dave Airlie <airlied@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] cleanup of the drm sysfs code.
Cc: airlied@linux.ie, Kay Sievers <kay.sievers@vrfy.org>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20060120233337.GA22848@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060120233337.GA22848@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kay pointed out today that the drm code creates a "dev" file in sysfs,
> yet doesn't tell the driver core about it.  Normally this would be just
> fine, as you are exporting the value in the proper style, but now there
> are programs that are only watching the hotplug/uevent netlink messages
> and not reading directly from sysfs to get this kind of information.
> The patch below is a cleanup of the drm sysfs code, as much of the same
> functionality that you want is already present in the driver core, so it
> is not good to duplicate it.

Greg it looks fine to me, I'm LCA'ing at the moment, so if you can
push it via your tree I'm fine with it, if you can let it sit in an
-mm picked up tree for a bit I'd appreciate it, but we don't do much
with sysfs anyways other than create the dev..

I'm going to hopefully get around to the drm/fb merge layer in the
next month so I'd prefer to start from a clean state..

Dave.

>
> Big benifit of this patch is it deletes a lot of unneeded code :)
>
> I've tested this patch out on my one laptop that uses drm, and it seems
> to work just fine.
>
> If you want, I can forward this on to Linus in my driver tree, or feel
> free to do it yourself.
>
> thanks,
>
> greg k-h
>
> -----------------
> From: Greg Kroah-Hartman <gregkh@suse.de>
> Subject: DRM: fix up classdev interface for drm core
>
> Current drm code doesn't work with userspace programs that listen only
> to the kernel event netlink socket as it is trying to create its own dev
> interface.  Turns out lots of code can just be deleted as the driver
> core can do all of this work automatically for you.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
>
>  drivers/char/drm/drmP.h      |   10 +--
>  drivers/char/drm/drm_stub.c  |    2
>  drivers/char/drm/drm_sysfs.c |  129 +++++++++----------------------------------
>  3 files changed, 34 insertions(+), 107 deletions(-)
>
> --- gregkh-2.6.orig/drivers/char/drm/drm_sysfs.c        2006-01-17 08:27:27.000000000 -0800
> +++ gregkh-2.6/drivers/char/drm/drm_sysfs.c     2006-01-20 14:45:39.000000000 -0800
> @@ -1,3 +1,4 @@
> +
>  /*
>  * drm_sysfs.c - Modifications to drm_sysfs_class.c to support
>  *               extra sysfs attribute from DRM. Normal drm_sysfs_class
> @@ -19,36 +20,6 @@
>  #include "drm_core.h"
>  #include "drmP.h"
>
> -struct drm_sysfs_class {
> -       struct class_device_attribute attr;
> -       struct class class;
> -};
> -#define to_drm_sysfs_class(d) container_of(d, struct drm_sysfs_class, class)
> -
> -struct simple_dev {
> -       dev_t dev;
> -       struct class_device class_dev;
> -};
> -#define to_simple_dev(d) container_of(d, struct simple_dev, class_dev)
> -
> -static void release_simple_dev(struct class_device *class_dev)
> -{
> -       struct simple_dev *s_dev = to_simple_dev(class_dev);
> -       kfree(s_dev);
> -}
> -
> -static ssize_t show_dev(struct class_device *class_dev, char *buf)
> -{
> -       struct simple_dev *s_dev = to_simple_dev(class_dev);
> -       return print_dev_t(buf, s_dev->dev);
> -}
> -
> -static void drm_sysfs_class_release(struct class *class)
> -{
> -       struct drm_sysfs_class *cs = to_drm_sysfs_class(class);
> -       kfree(cs);
> -}
> -
>  /* Display the version of drm_core. This doesn't work right in current design */
>  static ssize_t version_show(struct class *dev, char *buf)
>  {
> @@ -69,38 +40,16 @@
>  * Note, the pointer created here is to be destroyed when finished by making a
>  * call to drm_sysfs_destroy().
>  */
> -struct drm_sysfs_class *drm_sysfs_create(struct module *owner, char *name)
> +struct class *drm_sysfs_create(struct module *owner, char *name)
>  {
> -       struct drm_sysfs_class *cs;
> -       int retval;
> +       struct class *class;
> +
> +       class = class_create(owner, name);
> +       if (!class)
> +               return class;
>
> -       cs = kmalloc(sizeof(*cs), GFP_KERNEL);
> -       if (!cs) {
> -               retval = -ENOMEM;
> -               goto error;
> -       }
> -       memset(cs, 0x00, sizeof(*cs));
> -
> -       cs->class.name = name;
> -       cs->class.class_release = drm_sysfs_class_release;
> -       cs->class.release = release_simple_dev;
> -
> -       cs->attr.attr.name = "dev";
> -       cs->attr.attr.mode = S_IRUGO;
> -       cs->attr.attr.owner = owner;
> -       cs->attr.show = show_dev;
> -       cs->attr.store = NULL;
> -
> -       retval = class_register(&cs->class);
> -       if (retval)
> -               goto error;
> -       class_create_file(&cs->class, &class_attr_version);
> -
> -       return cs;
> -
> -      error:
> -       kfree(cs);
> -       return ERR_PTR(retval);
> +       class_create_file(class, &class_attr_version);
> +       return class;
>  }
>
>  /**
> @@ -110,12 +59,13 @@
>  * Note, the pointer to be destroyed must have been created with a call to
>  * drm_sysfs_create().
>  */
> -void drm_sysfs_destroy(struct drm_sysfs_class *cs)
> +void drm_sysfs_destroy(struct class *class)
>  {
> -       if ((cs == NULL) || (IS_ERR(cs)))
> +       if ((class == NULL) || (IS_ERR(class)))
>                return;
>
> -       class_unregister(&cs->class);
> +       class_remove_file(class, &class_attr_version);
> +       class_destroy(class);
>  }
>
>  static ssize_t show_dri(struct class_device *class_device, char *buf)
> @@ -132,7 +82,7 @@
>
>  /**
>  * drm_sysfs_device_add - adds a class device to sysfs for a character driver
> - * @cs: pointer to the struct drm_sysfs_class that this device should be registered to.
> + * @cs: pointer to the struct class that this device should be registered to.
>  * @dev: the dev_t for the device to be added.
>  * @device: a pointer to a struct device that is assiociated with this class device.
>  * @fmt: string for the class device's name
> @@ -141,46 +91,26 @@
>  * class.  A "dev" file will be created, showing the dev_t for the device.  The
>  * pointer to the struct class_device will be returned from the call.  Any further
>  * sysfs files that might be required can be created using this pointer.
> - * Note: the struct drm_sysfs_class passed to this function must have previously been
> + * Note: the struct class passed to this function must have previously been
>  * created with a call to drm_sysfs_create().
>  */
> -struct class_device *drm_sysfs_device_add(struct drm_sysfs_class *cs,
> -                                         drm_head_t *head)
> +struct class_device *drm_sysfs_device_add(struct class *cs, drm_head_t *head)
>  {
> -       struct simple_dev *s_dev = NULL;
> -       int i, retval;
> +       struct class_device *class_dev;
> +       int i;
>
> -       if ((cs == NULL) || (IS_ERR(cs))) {
> -               retval = -ENODEV;
> -               goto error;
> -       }
> -
> -       s_dev = kmalloc(sizeof(*s_dev), GFP_KERNEL);
> -       if (!s_dev) {
> -               retval = -ENOMEM;
> -               goto error;
> -       }
> -       memset(s_dev, 0x00, sizeof(*s_dev));
> -
> -       s_dev->dev = MKDEV(DRM_MAJOR, head->minor);
> -       s_dev->class_dev.dev = &(head->dev->pdev)->dev;
> -       s_dev->class_dev.class = &cs->class;
> -
> -       snprintf(s_dev->class_dev.class_id, BUS_ID_SIZE, "card%d", head->minor);
> -       retval = class_device_register(&s_dev->class_dev);
> -       if (retval)
> -               goto error;
> +       class_dev = class_device_create(cs, NULL,
> +                                       MKDEV(DRM_MAJOR, head->minor),
> +                                       &(head->dev->pdev)->dev,
> +                                       "card%d", head->minor);
> +       if (!class_dev)
> +               return NULL;
>
> -       class_device_create_file(&s_dev->class_dev, &cs->attr);
> -       class_set_devdata(&s_dev->class_dev, head);
> +       class_set_devdata(class_dev, head);
>
>        for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
> -               class_device_create_file(&s_dev->class_dev, &class_device_attrs[i]);
> -       return &s_dev->class_dev;
> -
> -error:
> -       kfree(s_dev);
> -       return ERR_PTR(retval);
> +               class_device_create_file(class_dev, &class_device_attrs[i]);
> +       return class_dev;
>  }
>
>  /**
> @@ -192,10 +122,9 @@
>  */
>  void drm_sysfs_device_remove(struct class_device *class_dev)
>  {
> -       struct simple_dev *s_dev = to_simple_dev(class_dev);
>        int i;
>
>        for (i = 0; i < ARRAY_SIZE(class_device_attrs); i++)
> -               class_device_remove_file(&s_dev->class_dev, &class_device_attrs[i]);
> -       class_device_unregister(&s_dev->class_dev);
> +               class_device_remove_file(class_dev, &class_device_attrs[i]);
> +       class_device_unregister(class_dev);
>  }
> --- gregkh-2.6.orig/drivers/char/drm/drmP.h     2006-01-17 08:27:27.000000000 -0800
> +++ gregkh-2.6/drivers/char/drm/drmP.h  2006-01-20 14:30:33.000000000 -0800
> @@ -979,7 +979,7 @@
>  extern unsigned int drm_debug;
>  extern unsigned int drm_cards_limit;
>  extern drm_head_t **drm_heads;
> -extern struct drm_sysfs_class *drm_class;
> +extern struct class *drm_class;
>  extern struct proc_dir_entry *drm_proc_root;
>
>                                /* Proc support (drm_proc.h) */
> @@ -1010,11 +1010,9 @@
>  extern void drm_pci_free(drm_device_t * dev, drm_dma_handle_t * dmah);
>
>                               /* sysfs support (drm_sysfs.c) */
> -struct drm_sysfs_class;
> -extern struct drm_sysfs_class *drm_sysfs_create(struct module *owner,
> -                                               char *name);
> -extern void drm_sysfs_destroy(struct drm_sysfs_class *cs);
> -extern struct class_device *drm_sysfs_device_add(struct drm_sysfs_class *cs,
> +extern struct class *drm_sysfs_create(struct module *owner, char *name);
> +extern void drm_sysfs_destroy(struct class *cs);
> +extern struct class_device *drm_sysfs_device_add(struct class *cs,
>                                                 drm_head_t *head);
>  extern void drm_sysfs_device_remove(struct class_device *class_dev);
>
> --- gregkh-2.6.orig/drivers/char/drm/drm_stub.c 2006-01-17 08:27:27.000000000 -0800
> +++ gregkh-2.6/drivers/char/drm/drm_stub.c      2006-01-20 14:30:33.000000000 -0800
> @@ -50,7 +50,7 @@
>  module_param_named(debug, drm_debug, int, 0600);
>
>  drm_head_t **drm_heads;
> -struct drm_sysfs_class *drm_class;
> +struct class *drm_class;
>  struct proc_dir_entry *drm_proc_root;
>
>  static int drm_fill_in_dev(drm_device_t * dev, struct pci_dev *pdev,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
