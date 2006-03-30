Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWC3IBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWC3IBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWC3IBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:01:13 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:39850 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751185AbWC3IBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:01:11 -0500
In-Reply-To: <20060329225548.25585.73037.stgit@gitlost.site>
References: <20060329225505.25585.30392.stgit@gitlost.site> <20060329225548.25585.73037.stgit@gitlost.site>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8C52750C-8BC3-4815-834C-6DBEA714BA0F@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Date: Thu, 30 Mar 2006 02:01:20 -0600
To: Chris Leech <christopher.leech@intel.com>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 29, 2006, at 4:55 PM, Chris Leech wrote:

> Provides an API for offloading memory copies to DMA devices
>
> Signed-off-by: Chris Leech <christopher.leech@intel.com>
> ---
>
>  drivers/Kconfig           |    2
>  drivers/Makefile          |    1
>  drivers/dma/Kconfig       |   13 +
>  drivers/dma/Makefile      |    1
>  drivers/dma/dmaengine.c   |  405 ++++++++++++++++++++++++++++++++++ 
> +++++++++++
>  include/linux/dmaengine.h |  337 ++++++++++++++++++++++++++++++++++ 
> +++
>  6 files changed, 759 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 9f5c0da..f89ac05 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -72,4 +72,6 @@ source "drivers/edac/Kconfig"
>
>  source "drivers/rtc/Kconfig"
>
> +source "drivers/dma/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 4249552..9b808a6 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -74,3 +74,4 @@ obj-$(CONFIG_SGI_SN)		+= sn/
>  obj-y				+= firmware/
>  obj-$(CONFIG_CRYPTO)		+= crypto/
>  obj-$(CONFIG_SUPERH)		+= sh/
> +obj-$(CONFIG_DMA_ENGINE)	+= dma/
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> new file mode 100644
> index 0000000..f9ac4bc
> --- /dev/null
> +++ b/drivers/dma/Kconfig
> @@ -0,0 +1,13 @@
> +#
> +# DMA engine configuration
> +#
> +
> +menu "DMA Engine support"
> +
> +config DMA_ENGINE
> +	bool "Support for DMA engines"
> +	---help---
> +	  DMA engines offload copy operations from the CPU to dedicated
> +	  hardware, allowing the copies to happen asynchronously.
> +
> +endmenu
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> new file mode 100644
> index 0000000..10b7391
> --- /dev/null
> +++ b/drivers/dma/Makefile
> @@ -0,0 +1 @@
> +obj-y += dmaengine.o
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> new file mode 100644
> index 0000000..683456a
> --- /dev/null
> +++ b/drivers/dma/dmaengine.c
> @@ -0,0 +1,405 @@
> +/*
> + * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or  
> modify it
> + * under the terms of the GNU General Public License as published  
> by the Free
> + * Software Foundation; either version 2 of the License, or (at  
> your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,  
> but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of  
> MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public  
> License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public  
> License along with
> + * this program; if not, write to the Free Software Foundation,  
> Inc., 59
> + * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + *
> + * The full GNU General Public License is included in this  
> distribution in the
> + * file called COPYING.
> + */
> +
> +/*
> + * This code implements the DMA subsystem. It provides a HW- 
> neutral interface
> + * for other kernel code to use asynchronous memory copy  
> capabilities,
> + * if present, and allows different HW DMA drivers to register as  
> providing
> + * this capability.
> + *
> + * Due to the fact we are accelerating what is already a  
> relatively fast
> + * operation, the code goes to great lengths to avoid additional  
> overhead,
> + * such as locking.
> + *
> + * LOCKING:
> + *
> + * The subsystem keeps two global lists, dma_device_list and  
> dma_client_list.
> + * Both of these are protected by a spinlock, dma_list_lock.
> + *
> + * Each device has a channels list, which runs unlocked but is  
> never modified
> + * once the device is registered, it's just setup by the driver.
> + *
> + * Each client has a channels list, it's only modified under the  
> client->lock
> + * and in an RCU callback, so it's safe to read under rcu_read_lock 
> ().
> + *
> + * Each device has a kref, which is initialized to 1 when the  
> device is
> + * registered. A kref_put is done for each class_device  
> registered.  When the
> + * class_device is released, the coresponding kref_put is done in  
> the release
> + * method. Every time one of the device's channels is allocated to  
> a client,
> + * a kref_get occurs.  When the channel is freed, the coresponding  
> kref_put
> + * happens. The device's release function does a completion, so
> + * unregister_device does a remove event, class_device_unregister,  
> a kref_put
> + * for the first reference, then waits on the completion for all  
> other
> + * references to finish.
> + *
> + * Each channel has an open-coded implementation of Rusty  
> Russell's "bigref,"
> + * with a kref and a per_cpu local_t.  A single reference is set  
> when on an
> + * ADDED event, and removed with a REMOVE event.  Net DMA client  
> takes an
> + * extra reference per outstanding transaction.  The relase  
> function does a
> + * kref_put on the device. -ChrisL
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/hardirq.h>
> +#include <linux/spinlock.h>
> +#include <linux/percpu.h>
> +#include <linux/rcupdate.h>
> +
> +static DEFINE_SPINLOCK(dma_list_lock);
> +static LIST_HEAD(dma_device_list);
> +static LIST_HEAD(dma_client_list);
> +
> +/* --- sysfs implementation --- */
> +
> +static ssize_t show_memcpy_count(struct class_device *cd, char *buf)
> +{
> +	struct dma_chan *chan = container_of(cd, struct dma_chan,  
> class_dev);
> +	unsigned long count = 0;
> +	int i;
> +
> +	for_each_cpu(i)
> +		count += per_cpu_ptr(chan->local, i)->memcpy_count;
> +
> +	return sprintf(buf, "%lu\n", count);
> +}
> +
> +static ssize_t show_bytes_transferred(struct class_device *cd,  
> char *buf)
> +{
> +	struct dma_chan *chan = container_of(cd, struct dma_chan,  
> class_dev);
> +	unsigned long count = 0;
> +	int i;
> +
> +	for_each_cpu(i)
> +		count += per_cpu_ptr(chan->local, i)->bytes_transferred;
> +
> +	return sprintf(buf, "%lu\n", count);
> +}
> +

What is the utility of exporting memcpy_count, and bytes_transferred  
to userspace via sysfs?  Is this really for debug (and thus should be  
under debugfs?)

> +static ssize_t show_in_use(struct class_device *cd, char *buf)
> +{
> +	struct dma_chan *chan = container_of(cd, struct dma_chan,  
> class_dev);
> +
> +	return sprintf(buf, "%d\n", (chan->client ? 1 : 0));
> +}
> +
> +static struct class_device_attribute dma_class_attrs[] = {
> +	__ATTR(memcpy_count, S_IRUGO, show_memcpy_count, NULL),
> +	__ATTR(bytes_transferred, S_IRUGO, show_bytes_transferred, NULL),
> +	__ATTR(in_use, S_IRUGO, show_in_use, NULL),
> +	__ATTR_NULL
> +};
> +

[snip]

- kumar
