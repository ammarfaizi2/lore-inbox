Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261899AbSJDOwf>; Fri, 4 Oct 2002 10:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261909AbSJDOwb>; Fri, 4 Oct 2002 10:52:31 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:58642 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261899AbSJDOvI>; Fri, 4 Oct 2002 10:51:08 -0400
Date: Fri, 4 Oct 2002 15:56:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EVMS core 1/4: evms.c
Message-ID: <20021004155639.A32001@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org
References: <02100307355501.05904@boiler> <02100317115209.05904@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02100317115209.05904@boiler>; from corryk@us.ibm.com on Thu, Oct 03, 2002 at 05:11:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#include <net/checksum.h>

Networking headers in volume managment code?

> +/*
> + * string used when validating & logging redundant metadata
> + */
> +u8 *evms_primary_string = "primary";
> +EXPORT_SYMBOL(evms_primary_string);
> +u8 *evms_secondary_string = "secondary";
> +EXPORT_SYMBOL(evms_secondary_string);

Why do you export strings?  Wouldn't a simple cpp symbol do it?
Also the symbol names are bigger than the actual string they
represent..  Looks a little pointless :)

> +/**
> + * SYSCTL - EVMS folder definitions/variables
> + **/
> +#ifdef CONFIG_PROC_FS

Needs to be checked for CONFIG_SYSCTL instead.

> +/**********************************************************/
> +/* START -- arch ioctl32 support                          */
> +/**********************************************************/

IMHO this is the wrong place.  What about an conditionally compiled
evms_ioctl32.c file?

> +/**
> + * find_next_volume - locates first or next logical volume
> + * @lv:		current logical volume
> + *
> + * returns the next logical volume or NULL
> + **/

All user of this look like they better used list_for_each?

> +
> +/**
> + * find_next_volume_safe - locates first or next logical volume (safe for removes)
> + * @next_lv:	ptr to next logical volume
> + *
> + * returns the next logical volume or NULL
> + **/

Dito with list_for_each_safe

> +/**
> + * lookup_volume - finds a logical volume by minor number
> + * @minor:	minor number of logical volume to be found
> + *
> + * returns the logical volume of the specified minor or NULL.
> + **/
> +static struct evms_logical_volume *
> +lookup_volume(int minor)

Very bad if you ever want to be able to use more than one major
number.

> +/**********************************************************/
> +/* START -- exported functions/Common Services            */
> +/**********************************************************/
> +
> +/**
> + * evms_cs_get_version - returns the current EVMS version
> + * @major:	returned major value
> + * @minor:	returned minor value
> + **/
> +void
> +evms_cs_get_version(int *major, int *minor)
> +{
> +	*major = EVMS_MAJOR_VERSION;
> +	*minor = EVMS_MINOR_VERSION;
> +}
> +
> +EXPORT_SYMBOL(evms_cs_get_version);

Scap this.  Modules under linux aren't binary compatible.

> +int
> +evms_cs_check_version(struct evms_version *required,
> +		      struct evms_version *actual)
> +{
> +	if ((required->major != actual->major) ||
> +	    (required->minor > actual->minor) ||
> +	    ((required->minor == actual->minor) &&
> +	     (required->patchlevel > actual->patchlevel)))
> +		return (-EINVAL);
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL(evms_cs_check_version);

Dito.

> +
> +/**
> + * evms_cs_allocate_logical_node - allocates an evms logical node structure
> + * @pp:		address of the pointer which will contain the address of newly allocated node
> + *
> + * allocates and zeros an evms_logical_node structure.
> + *
> + * returns: 0 if sucessful
> + *          -ENOMEM if unsuccessful
> + **/
> +int
> +evms_cs_allocate_logical_node(struct evms_logical_node **pp)
> +{
> +	*pp = kmalloc(sizeof (struct evms_logical_node), GFP_KERNEL);
> +	if (*pp == NULL) {
> +		return -ENOMEM;
> +	}
> +	memset(*pp, 0, sizeof (struct evms_logical_node));
> +	return 0;

A helper for kmalloc + memset looks rather pointles..

> +#define CRC_POLYNOMIAL     0xEDB88320L
> +static u32 crc_table[256];
> +static u32 crc_table_built = FALSE;
> +
> +/**
> + * build_crc_table
> + *
> + * initialzes the internal crc table
> + **/
> +static void
> +build_crc_table(void)
> +{
> +	u32 i, j, crc;
> +
> +	for (i = 0; i <= 255; i++) {
> +		crc = i;
> +		for (j = 8; j > 0; j--) {
> +			if (crc & 1)
> +				crc = (crc >> 1) ^ CRC_POLYNOMIAL;
> +			else
> +				crc >>= 1;
> +		}
> +		crc_table[i] = crc;
> +	}
> +	crc_table_built = TRUE;
> +}

Is this a different crc from the lib/crc32.c one?

> +	done = FALSE;
> +	while (!done) {
> +		new_entry = mempool_alloc(evms_io_notify_pool, GFP_NOIO);
> +		if (!new_entry) {
> +			schedule();
> +			continue;
> +		}

Umm..


> +int
> +evms_cs_volume_request_in_progress(kdev_t dev,
> +				   int operation, int *current_count)
> +{
> +	struct evms_logical_volume *volume = lookup_volume(minor(dev));
> +	if (!volume || !volume->node) {
> +		return -ENODEV;
> +	}
> +	if (operation > 0) {
> +		atomic_inc(&volume->requests_in_progress);
> +	} else if (operation < 0) {
> +		atomic_dec(&volume->requests_in_progress);
> +	}
> +	if (current_count) {
> +		*current_count = atomic_read(&volume->requests_in_progress);
> +	}
> +	return 0;

This function should be three ones for the different functionality.
Also kdev_t won't last long for block devices..

> +/**
> + * is_busy - determines if a block_devices is currently in use
> + * @dev:	device to check
> + *
> + * determines if a block_device is in use or not
> + *
> + * returns: 0 = device is not in use
> + *	    -EBUSY if device is in use
> + *	    -ENOMEM if unable to get a bdev
> + **/
> +static int
> +is_busy(kdev_t dev)
> +{
> +	struct block_device *bdev;
> +
> +	bdev = bdget(kdev_t_to_nr(dev));
> +	if (!bdev)
> +		return (-ENOMEM);
> +	if (bd_claim(bdev, is_busy))
> +		return (-EBUSY);
> +	bd_release(bdev);
> +	return (0);

I don't think this is_busy check is a good idea.  Anyways
it should be better something like this (then in block_dev.c):

int bd_busy(struct block_device *bdev)
{
	int res = 0;
	spin_lock(&bdev_lock);
	if (bdev->bd_holder)
		res = -EBUSY;
	spin_unlock(&bdev_lock);
	return res;
}


> +static int
> +evms_ioctl_cmd_get_info_level(void *arg)
> +{
> +	/* copy info to userspace */
> +	if (copy_to_user(arg, &evms_info_level, sizeof (evms_info_level)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
>
> 
> +
> +/**
> + * evms_ioctl_cmd_set_info_level
> + * @arg:	int value
> + *
> + * sets the evms info (syslog logging) level
> + *
> + * returns: 0 = success
> + *	    otherwise error code
> + **/
> +static int
> +evms_ioctl_cmd_set_info_level(void *arg)
> +{
> +	int temp;
> +
> +	/* copy info from userspace */
> +	if (copy_from_user(&temp, arg, sizeof (temp)))
> +		return -EFAULT;
> +	evms_info_level = temp;
> +
> +	return 0;
> +}

Didn't you already export these two through /proc?

> +	if (qv->command) {
> +		/* After setting the volume to
> +		 * a quiesced state, there could
> +		 * be threads (on SMP systems)
> +		 * that are executing in the
> +		 * function, evms_handle_request,
> +		 * between the "wait_event" and the
> +		 * "atomic_inc" lines. We need to
> +		 * provide a "delay" sufficient
> +		 * to allow those threads to
> +		 * to reach the atomic_inc's
> +		 * before executing the while loop
> +		 * below. The "schedule" call should
> +		 * provide this.
> +		 */
> +		schedule();
> +		/* wait for outstanding requests to complete */
> +		while (atomic_read(&volume->requests_in_progress) > 0)
> +			schedule();

ever heard of waitqueues and wait_event?

> +/**
> + * evms_ioctl_cmd_rediscover_volumes
> + * @inode:	vfs ioctl parameter
> + * @file:	vfs ioctl parameter
> + * @cmd:	vfs ioctl parame

Looks like even the EVMS list snipped the rest of the mail :)
