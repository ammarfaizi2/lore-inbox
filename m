Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758700AbWK2Bkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758700AbWK2Bkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758705AbWK2Bkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:40:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:39338 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758700AbWK2Bku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:40:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oHg0gc6B+g5/230x9XooXJEFt82dy9PST708md0P8uPcxNoPLPkz6k6YPy55El7q70nmP1b9B8hVlp7hlha/ZaqSCavFtQumzRFKzApGAisByqADjYEHK9wSql1pp2pwvX8Xc+i6QJBjZsJKQvIvPgh+JQ96xttI0nVNG88Nr9k=
Message-ID: <9aa54c260611281740j2de8ebd7ga4bf47a9905e5e27@mail.gmail.com>
Date: Tue, 28 Nov 2006 17:40:45 -0800
From: "Sujoy Gupta" <sujoyg@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH][UPDATE] i2c: Add support for virtual I2C adapters
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, "Greg KH" <greg@kroah.com>
In-Reply-To: <1E2624A3-3014-4FF6-9690-752347E1AAAB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.44.0603301700160.10117-100000@gate.crashing.org>
	 <1E2624A3-3014-4FF6-9690-752347E1AAAB@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reason why the files and config options have been renamed
from i2c-virtual to i2c-virt?

On 4/7/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> Any comments or acceptance of this patch?
>
> - k
>
> On Mar 30, 2006, at 5:05 PM, Kumar Gala wrote:
>
> > Virtual adapters are useful to handle multiplexed I2C bus
> > topologies, by
> > presenting each multiplexed segment as a I2C adapter.  Typically,
> > either
> > a mux (or switch) exists which is an I2C device on the parent bus.
> > One
> > selects a given child bus via programming the mux and then all the
> > devices
> > on that bus become present on the parent bus.  The intent is to allow
> > multiple devices of the same type to exist in a system which would
> > normally
> > have address conflicts.
> >
> > Since virtual adapters will get registered in an I2C client's detect
> > function we have to expose versions of i2c_{add,del}_adapter for
> > i2c_{add,del}_virt_adapter to call that don't lock.
> >
> > Additionally, i2c_virt_master_xfer (and i2c_virt_smbus_xfer) acquire
> > the parent->bus_lock and call the parent's master_xfer directly.  This
> > is because on a i2c_virt_master_xfer we have issue an i2c write on
> > the parent bus to select the given virtual adapter, then do the i2c
> > operation on the parent bus, followed by another i2c write on the
> > parent to deslect the virtual adapter.
> >
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> >
> > ---
> > commit 862cbc263e3d3e44028d7465a912847cf5366163
> > tree 2c91bad8eb66cab9727f3071831a916ada41edf8
> > parent 5d4fe2c1ce83c3e967ccc1ba3d580c1a5603a866
> > author Kumar Gala <galak@kernel.crashing.org> Thu, 30 Mar 2006
> > 17:03:42 -0600
> > committer Kumar Gala <galak@kernel.crashing.org> Thu, 30 Mar 2006
> > 17:03:42 -0600
> >
> >  drivers/i2c/Kconfig    |    9 ++
> >  drivers/i2c/Makefile   |    1
> >  drivers/i2c/i2c-core.c |   42 ++++++++----
> >  drivers/i2c/i2c-virt.c |  173 +++++++++++++++++++++++++++++++++++++
> > +++++++++++
> >  include/linux/i2c-id.h |    2 +
> >  include/linux/i2c.h    |   20 ++++++
> >  6 files changed, 234 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> > index 24383af..b8a8fc1 100644
> > --- a/drivers/i2c/Kconfig
> > +++ b/drivers/i2c/Kconfig
> > @@ -34,6 +34,15 @@ config I2C_CHARDEV
> >         This support is also available as a module.  If so, the module
> >         will be called i2c-dev.
> >
> > +config I2C_VIRT
> > +     tristate "I2C virtual adapter support"
> > +     depends on I2C
> > +     help
> > +       Say Y here if you want the I2C core to support the ability to have
> > +       virtual adapters. Virtual adapters are useful to handle
> > multiplexed
> > +       I2C bus topologies, by presenting each multiplexed segment as a
> > +       I2C adapter.
> > +
> >  source drivers/i2c/algos/Kconfig
> >  source drivers/i2c/busses/Kconfig
> >  source drivers/i2c/chips/Kconfig
> > diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> > index 71c5a85..4467db2 100644
> > --- a/drivers/i2c/Makefile
> > +++ b/drivers/i2c/Makefile
> > @@ -3,6 +3,7 @@
> >  #
> >
> >  obj-$(CONFIG_I2C)            += i2c-core.o
> > +obj-$(CONFIG_I2C_VIRT)               += i2c-virt.o
> >  obj-$(CONFIG_I2C_CHARDEV)    += i2c-dev.o
> >  obj-y                                += busses/ chips/ algos/
> >
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 45e2cdf..64c1c9e 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -150,22 +150,31 @@ static struct device_attribute dev_attr_
> >   */
> >  int i2c_add_adapter(struct i2c_adapter *adap)
> >  {
> > +     int res;
> > +
> > +     mutex_lock(&core_lists);
> > +     res = i2c_add_adapter_nolock(adap);
> > +     mutex_unlock(&core_lists);
> > +
> > +     return res;
> > +}
> > +
> > +int i2c_add_adapter_nolock(struct i2c_adapter *adap)
> > +{
> >       int id, res = 0;
> >       struct list_head   *item;
> >       struct i2c_driver  *driver;
> >
> > -     mutex_lock(&core_lists);
> > -
> >       if (idr_pre_get(&i2c_adapter_idr, GFP_KERNEL) == 0) {
> >               res = -ENOMEM;
> > -             goto out_unlock;
> > +             goto out;
> >       }
> >
> >       res = idr_get_new(&i2c_adapter_idr, adap, &id);
> >       if (res < 0) {
> >               if (res == -EAGAIN)
> >                       res = -ENOMEM;
> > -             goto out_unlock;
> > +             goto out;
> >       }
> >
> >       adap->nr =  id & MAX_ID_MASK;
> > @@ -203,21 +212,29 @@ int i2c_add_adapter(struct i2c_adapter *
> >                       driver->attach_adapter(adap);
> >       }
> >
> > -out_unlock:
> > -     mutex_unlock(&core_lists);
> > +out:
> >       return res;
> >  }
> >
> > -
> >  int i2c_del_adapter(struct i2c_adapter *adap)
> >  {
> > +     int res;
> > +
> > +     mutex_lock(&core_lists);
> > +     res = i2c_del_adapter_nolock(adap);
> > +     mutex_unlock(&core_lists);
> > +
> > +     return res;
> > +}
> > +
> > +int i2c_del_adapter_nolock(struct i2c_adapter *adap)
> > +{
> >       struct list_head  *item, *_n;
> >       struct i2c_adapter *adap_from_list;
> >       struct i2c_driver *driver;
> >       struct i2c_client *client;
> >       int res = 0;
> >
> > -     mutex_lock(&core_lists);
> >
> >       /* First make sure that this adapter was ever added */
> >       list_for_each_entry(adap_from_list, &adapters, list) {
> > @@ -228,7 +245,7 @@ int i2c_del_adapter(struct i2c_adapter *
> >               pr_debug("i2c-core: attempting to delete unregistered "
> >                        "adapter [%s]\n", adap->name);
> >               res = -EINVAL;
> > -             goto out_unlock;
> > +             goto out;
> >       }
> >
> >       list_for_each(item,&drivers) {
> > @@ -238,7 +255,7 @@ int i2c_del_adapter(struct i2c_adapter *
> >                               dev_err(&adap->dev, "detach_adapter failed "
> >                                       "for driver [%s]\n",
> >                                       driver->driver.name);
> > -                             goto out_unlock;
> > +                             goto out;
> >                       }
> >       }
> >
> > @@ -251,7 +268,7 @@ int i2c_del_adapter(struct i2c_adapter *
> >                       dev_err(&adap->dev, "detach_client failed for client "
> >                               "[%s] at address 0x%02x\n", client->name,
> >                               client->addr);
> > -                     goto out_unlock;
> > +                     goto out;
> >               }
> >       }
> >
> > @@ -272,8 +289,7 @@ int i2c_del_adapter(struct i2c_adapter *
> >
> >       dev_dbg(&adap->dev, "adapter [%s] unregistered\n", adap->name);
> >
> > - out_unlock:
> > -     mutex_unlock(&core_lists);
> > +out:
> >       return res;
> >  }
> >
> > diff --git a/drivers/i2c/i2c-virt.c b/drivers/i2c/i2c-virt.c
> > new file mode 100644
> > index 0000000..2bd9ea3
> > --- /dev/null
> > +++ b/drivers/i2c/i2c-virt.c
> > @@ -0,0 +1,173 @@
> > +/*
> > + * i2c-virtual.c - Virtual I2C bus driver.
> > + *
> > + * Simplifies access to complex multiplexed I2C bus topologies, by
> > presenting
> > + * each multiplexed bus segment as a virtual I2C adapter.
> > Supports multi-level
> > + * mux'ing (mux behind a mux).
> > + *
> > + * Based on:
> > + *    i2c-virtual.c from Copyright (c) 2004 Google, Inc. (Ken
> > Harrenstien)
> > + *    i2c-virtual.c from Brian Kuschak <bkuschak@yahoo.com>
> > + * which was:
> > + *    Adapted from i2c-adap-ibm_ocp.c
> > + *    Original file Copyright 2000-2002 MontaVista Software Inc.
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2. This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/i2c-id.h>
> > +
> > +struct i2c_virt_priv {
> > +     struct i2c_adapter *parent_adap;
> > +     struct i2c_client *client;      /* The mux chip/device */
> > +
> > +     u32 id;                         /* the mux id */
> > +
> > +     /* fn which enables the mux */
> > +     int (*select) (struct i2c_adapter *, struct i2c_client *, u32);
> > +
> > +     /* fn which disables the mux */
> > +     int (*deselect) (struct i2c_adapter *, struct i2c_client *, u32);
> > +};
> > +
> > +#define VIRT_TIMEOUT         (HZ/2)
> > +#define VIRT_RETRIES         3
> > +
> > +static int
> > +i2c_virt_master_xfer(struct i2c_adapter *adap, struct i2c_msg msgs
> > [], int num)
> > +{
> > +     struct i2c_virt_priv *priv = adap->algo_data;
> > +     struct i2c_adapter *parent = priv->parent_adap;
> > +     int ret;
> > +
> > +     /* Grab the lock for the parent adapter.  We already hold the
> > lock for
> > +        the virtual adapter.  Then select the right mux port and perform
> > +        the transfer.
> > +      */
> > +
> > +     mutex_lock(&parent->bus_lock);
> > +     if ((ret = priv->select(parent, priv->client, priv->id)) >= 0) {
> > +             ret = parent->algo->master_xfer(parent, msgs, num);
> > +     }
> > +     priv->deselect(parent, priv->client, priv->id);
> > +     mutex_unlock(&parent->bus_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static int
> > +i2c_virt_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> > +                 unsigned short flags, char read_write,
> > +                 u8 command, int size, union i2c_smbus_data *data)
> > +{
> > +     struct i2c_virt_priv *priv = adap->algo_data;
> > +     struct i2c_adapter *parent = priv->parent_adap;
> > +     int ret;
> > +
> > +     /* Grab the lock for the parent adapter.  We already hold the
> > lock for
> > +        the virtual adapter.  Then select the right mux port and perform
> > +        the transfer.
> > +      */
> > +
> > +     mutex_lock(&parent->bus_lock);
> > +     if ((ret = priv->select(parent, priv->client, priv->id)) == 0) {
> > +             ret = parent->algo->smbus_xfer(parent, addr, flags,
> > +                                            read_write, command, size, data);
> > +     }
> > +     priv->deselect(parent, priv->client, priv->id);
> > +     mutex_unlock(&parent->bus_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +/* return the parent's functionality for the virtual adapter */
> > +static u32 i2c_virt_functionality(struct i2c_adapter *adap)
> > +{
> > +     struct i2c_virt_priv *priv = adap->algo_data;
> > +     struct i2c_adapter *parent = priv->parent_adap;
> > +
> > +     return parent->algo->functionality(parent);
> > +}
> > +
> > +struct i2c_adapter *
> > +i2c_add_virt_adapter(struct i2c_adapter *parent, struct i2c_client
> > *client,
> > +                  u32 mux_val,
> > +                  int (*select_cb) (struct i2c_adapter *,
> > +                                    struct i2c_client *, u32),
> > +                  int (*deselect_cb) (struct i2c_adapter *,
> > +                                      struct i2c_client *, u32))
> > +{
> > +     struct i2c_adapter *adap;
> > +     struct i2c_virt_priv *priv;
> > +     struct i2c_algorithm *algo;
> > +
> > +     if (!(adap = kzalloc(sizeof(struct i2c_adapter)
> > +                          + sizeof(struct i2c_virt_priv)
> > +                          + sizeof(struct i2c_algorithm), GFP_KERNEL)))
> > +             return NULL;
> > +
> > +     priv = (struct i2c_virt_priv *)(adap + 1);
> > +     algo = (struct i2c_algorithm *)(priv + 1);
> > +
> > +     /* Set up private adapter data */
> > +     priv->parent_adap = parent;
> > +     priv->client = client;
> > +     priv->id = mux_val;
> > +     priv->select = select_cb;
> > +     priv->deselect = deselect_cb;
> > +
> > +     /* Need to do algo dynamically because we don't know ahead
> > +        of time what sort of physical adapter we'll be dealing with.
> > +      */
> > +     algo->master_xfer = (parent->algo->master_xfer
> > +                          ? i2c_virt_master_xfer : NULL);
> > +     algo->smbus_xfer = (parent->algo->smbus_xfer
> > +                         ? i2c_virt_smbus_xfer : NULL);
> > +     algo->functionality = i2c_virt_functionality;
> > +
> > +     /* Now fill out new adapter structure */
> > +     snprintf(adap->name, sizeof(adap->name),
> > +              "Virtual I2C (i2c-%d, mux %02x:%02x)",
> > +              i2c_adapter_id(parent), client->addr, mux_val);
> > +     adap->id = I2C_HW_VIRT | i2c_adapter_id(parent);
> > +     adap->algo = algo;
> > +     adap->algo_data = priv;
> > +     adap->timeout = VIRT_TIMEOUT;
> > +     adap->retries = VIRT_RETRIES;
> > +     adap->dev.parent = &parent->dev;
> > +
> > +     if (i2c_add_adapter_nolock(adap) < 0) {
> > +             kfree(adap);
> > +             return NULL;
> > +     }
> > +
> > +     printk(KERN_NOTICE "i2c-%d: Virtual I2C bus "
> > +            "(Physical bus i2c-%d, multiplexer 0x%02x port %d)\n",
> > +            i2c_adapter_id(adap), i2c_adapter_id(parent),
> > +            client->addr, mux_val);
> > +
> > +     return adap;
> > +}
> > +
> > +int i2c_del_virt_adapter(struct i2c_adapter *adap)
> > +{
> > +     int ret;
> > +
> > +     if ((ret = i2c_del_adapter_nolock(adap)) < 0)
> > +             return ret;
> > +     kfree(adap);
> > +
> > +     return 0;
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(i2c_add_virt_adapter);
> > +EXPORT_SYMBOL_GPL(i2c_del_virt_adapter);
> > +
> > +MODULE_AUTHOR("Kumar Gala <galak@kernel.crashing.org>");
> > +MODULE_DESCRIPTION("Virtual I2C driver for multiplexed I2C busses");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
> > index c8b81f4..66d5533 100644
> > --- a/include/linux/i2c-id.h
> > +++ b/include/linux/i2c-id.h
> > @@ -265,4 +265,6 @@
> >  #define I2C_HW_SAA7146               0x060000 /* SAA7146 video decoder bus */
> >  #define I2C_HW_SAA7134               0x090000 /* SAA7134 video decoder bus */
> >
> > +#define I2C_HW_VIRT          0x80000000 /* a virtual adapter */
> > +
> >  #endif /* LINUX_I2C_ID_H */
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index 1635ee2..ba41f97 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -294,6 +294,10 @@ struct i2c_client_address_data {
> >  extern int i2c_add_adapter(struct i2c_adapter *);
> >  extern int i2c_del_adapter(struct i2c_adapter *);
> >
> > +/* Assume the caller has the core_list lock already */
> > +extern int i2c_add_adapter_nolock(struct i2c_adapter *);
> > +extern int i2c_del_adapter_nolock(struct i2c_adapter *);
> > +
> >  extern int i2c_register_driver(struct module *, struct i2c_driver *);
> >  extern int i2c_del_driver(struct i2c_driver *);
> >
> > @@ -440,6 +444,22 @@ union i2c_smbus_data {
> >  #define I2C_SMBUS_I2C_BLOCK_DATA    6
> >  #define I2C_SMBUS_BLOCK_PROC_CALL   7                /* SMBus 2.0 */
> >
> > +/*
> > + * Called to create a 'virtual' i2c bus which represents a
> > multiplexed bus
> > + * segment.  The client and mux_val are passed to the select and
> > deselect
> > + * callback functions to perform hardware-specific mux control.
> > + *
> > + * The caller is expected to have the core_lists lock
> > + */
> > +struct i2c_adapter *
> > +i2c_add_virt_adapter(struct i2c_adapter *parent, struct i2c_client
> > *client,
> > +                  u32 mux_val,
> > +                  int (*select_cb) (struct i2c_adapter *,
> > +                                    struct i2c_client *, u32),
> > +                  int (*deselect_cb) (struct i2c_adapter *,
> > +                                      struct i2c_client *, u32));
> > +
> > +int i2c_del_virt_adapter(struct i2c_adapter *adap);
> >
> >  /* ----- commands for the ioctl like i2c_command call:
> >   * note that additional calls are defined in the algorithm and hw
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
