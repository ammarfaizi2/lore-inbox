Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263542AbTGAT4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTGAT4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:56:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:3248 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263542AbTGAT4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:56:05 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: DevMapper <dm-devel@sistina.com>
Subject: Re: [RFC 3/3] dm: v4 ioctl interface
Date: Tue, 1 Jul 2003 15:05:07 -0500
User-Agent: KMail/1.5
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
References: <20030701145812.GA1596@fib011235813.fsnet.co.uk> <20030701150246.GD1596@fib011235813.fsnet.co.uk>
In-Reply-To: <20030701150246.GD1596@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307011505.07184.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 July 2003 10:02, Joe Thornber wrote:
> --- diff/drivers/md/dm-ioctl-v4.c	1970-01-01 01:00:00.000000000 +0100
> +++ source/drivers/md/dm-ioctl-v4.c	2003-07-01 15:36:42.000000000 +0100

> +#define NUM_BUCKETS 64
> +#define MASK_BUCKETS (NUM_BUCKETS - 1)
> +static struct list_head _name_buckets[NUM_BUCKETS];
> +static struct list_head _uuid_buckets[NUM_BUCKETS];
> +
> +void dm_hash_remove_all(void);
> +
> +/*
> + * Guards access to all three tables.

Guards access to both tables. (The third table used to be for looking up 
devices based on kdev_t.)

> + */
> +static DECLARE_RWSEM(_hash_lock);
> +


> +/*
> + * The kdev_t and uuid of a device can never change once it is
> + * initially inserted.
> + */
> +int dm_hash_insert(const char *name, const char *uuid, struct
> mapped_device *md) +{
> +	struct hash_cell *cell;
> +
> +	/*
> +	 * Allocate the new cells.
> +	 */
> +	cell = alloc_cell(name, uuid, md);
> +	if (!cell)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Insert the cell into all three hash tables.

Again, just two tables. :)

> +	 */
> +	down_write(&_hash_lock);
> +	if (__get_name_cell(name))
> +		goto bad;
> +



> +int dm_hash_rename(const char *old, const char *new)
> +{
> +	char *new_name, *old_name;
> +	struct hash_cell *hc;
> +
> +	/*
> +	 * duplicate new.
> +	 */
> +	new_name = kstrdup(new);
> +	if (!new_name)
> +		return -ENOMEM;
> +
> +	down_write(&_hash_lock);
> +
> +	/*
> +	 * Is new free ?
> +	 */
> +	hc = __get_name_cell(new);
> +	if (hc) {
> +		DMWARN("asked to rename to an already existing name %s -> %s",
> +		       old, new);
> +		up_write(&_hash_lock);
> +		kfree(new_name);
> +		return -EBUSY;
> +	}
> +
> +	/*
> +	 * Is there such a device as 'old' ?
> +	 */
> +	hc = __get_name_cell(old);
> +	if (!hc) {
> +		DMWARN("asked to rename a non existent device %s -> %s",
> +		       old, new);
> +		up_write(&_hash_lock);
> +		kfree(new_name);
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * rename and move the name cell.
> +	 */
> +	list_del(&hc->name_list);
> +	old_name = hc->name;
> +	hc->name = new_name;
> +	list_add(&hc->name_list, _name_buckets + hash_str(new_name));
> +
> +	/* rename the device node in devfs */
> +	unregister_with_devfs(hc);

The "unregister" call needs to be before the actual rename. Same patch as a 
couple weeks ago.

> +	register_with_devfs(hc);
> +
> +	up_write(&_hash_lock);
> +	kfree(old_name);
> +	return 0;
> +}


> +static int check_name(const char *name)
> +{
> +	if (strchr(name, '/')) {
> +		DMWARN("invalid device name");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Can't we allow slashes in device names? I thought we discussed this before 
(http://marc.theaimsgroup.com/?t=104628092700011&r=1&w=2). Any reason for the 
change?

> +static int resume(struct dm_ioctl *param)
> +{
> +	int r = 0;
> +	struct hash_cell *hc;
> +	struct mapped_device *md;
> +	struct dm_table *new_map;
> +
> +	down_write(&_hash_lock);
> +
> +	hc = __find_device_hash_cell(param);
> +	if (!hc) {
> +		DMWARN("device doesn't appear to be in the dev hash table.");
> +		up_write(&_hash_lock);
> +		return -ENXIO;
> +	}
> +
> +	md = hc->md;
> +	dm_get(md);
> +
> +	new_map = hc->new_map;
> +	hc->new_map = NULL;
> +	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
> +
> +	up_write(&_hash_lock);
> +
> +	/* Do we need to load a new map ? */
> +	if (new_map) {
> +		/* Suspend if it isn't already suspended */
> +		if (!dm_suspended(md))
> +			dm_suspend(md);
> +
> +		r = dm_swap_table(md, new_map);
> +		if (r) {
> +			dm_put(md);
> +			dm_table_put(new_map);
> +			return r;
> +		}

Does this imply that if the dm_swap_table() call fails, then the "inactive" 
mapping is automatically deleted? Although....looking at the dm_swap_table() 
code, it looks like it can't actually fail (the only reason it could fail is 
if the device wasn't suspended, which is verified before calling 
dm_swap_table - and the _hash_lock prevent another process from trying to 
unsuspend the device in-between the calls).

As a side note, the __bind() function in dm.c currently will never return an 
error, so dm_swap_table() doesn't necessarily need to check for one.

> +
> +		if (!(dm_table_get_mode(new_map) & FMODE_WRITE))
> +			set_disk_ro(dm_disk(md), 1);
> +
> +		dm_table_put(new_map);
> +	}
> +
> +	if (dm_suspended(md))
> +		r = dm_resume(md);
> +
> +	if (!r)
> +		r = __dev_status(md, param);
> +
> +	dm_put(md);
> +	return r;
> +}
> +

On first pass through this file, everything looks pretty good. As long as the 
actual definition of the interface isn't going to change, I'd say go ahead 
and include this. After it's merged, we'll put together a version of EVMS 
that will support the new interface.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

