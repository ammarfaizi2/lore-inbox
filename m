Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263314AbSJCOpC>; Thu, 3 Oct 2002 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263316AbSJCOpC>; Thu, 3 Oct 2002 10:45:02 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:32012 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263314AbSJCOo7>; Thu, 3 Oct 2002 10:44:59 -0400
Date: Thu, 3 Oct 2002 15:50:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kevin Corry <corryk@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [PATCH] EVMS core 2/4: evms.h
Message-ID: <20021003155023.C17513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kevin Corry <corryk@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100307363402.05904@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02100307363402.05904@boiler>; from corryk@us.ibm.com on Thu, Oct 03, 2002 at 07:36:34AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -Naur linux-2.5.40/include/linux/evms/evms.h linux-2.5.40-evms/include/linux/evms/evms.h
> --- linux-2.5.40/include/linux/evms/evms.h	Sun Jul 17 18:46:18 1994
> +++ linux-2.5.40-evms/include/linux/evms/evms.h	Tue Oct  1 15:30:14 2002

What about drivers/md?

> @@ -0,0 +1,613 @@
> +/* -*- linux-c -*- */
> +/*
> + *   Copyright (c) International Business Machines  Corp., 2000

Has this file _really_ not been touched for two years??

> +/*
> + * linux/include/linux/evms/evms.h
> + *
> + * EVMS kernel header file
> + *
> + */

This comment sais exactly nothing.  You aswell just remove it..

> +
> +#ifndef __EVMS_INCLUDED__
> +#define __EVMS_INCLUDED__
> +
> +#include <linux/blk.h>
> +#include <linux/genhd.h>
> +#include <linux/fs.h>
> +#include <linux/iobuf.h>

I can't see the need for this include anywhere in the file.  Please check
whether you need all these includes.
> +
> +/**
> + * general defines section
> + **/
> +#define FALSE                           0
> +#define TRUE                            1

Please just use 0/1 directly just like everyone else..

> +#define DEV_PATH			"/dev"
> +#define EVMS_DIR_NAME			"evms"
> +#define EVMS_DEV_NAME			"block_device"
> +#define EVMS_DEV_NODE_PATH		DEV_PATH "/" EVMS_DIR_NAME "/"
> +#define EVMS_DEVICE_NAME		DEV_PATH "/" EVMS_DIR_NAME "/" EVMS_DEV_NAME

The kernel doesn't know about device names at all.

> +
> +/**
> + * list_for_each_entry_safe -	iterate over list safe against removal of list entry
> + * @pos:        the type * to use as a loop counter.
> + * @n: 	       	another type * to use as temporary storage
> + * @head:       the head for your list.
> + * @member:     the name of the list_struct within the struct.
> + */
> +#define list_for_each_entry_safe(pos, n, head, member)                      \
> +        for (pos = list_entry((head)->next, typeof(*pos), member),          \
> +		    n = list_entry(pos->member.next, typeof(*pos), member); \
> +		&pos->member != (head); 				    \
> +		pos = n,                                                    \
> +		    n = list_entry(pos->member.next, typeof(*pos), member))
> +/**
> + * list_member - tests whether a list member is currently on a list
> + * @member: 	member to evaulate
> + */
> +static inline int
> +list_member(struct list_head *member)
> +{
> +	return ((!member->next || !member->prev) ? FALSE : TRUE);
> +}

This should go into list.h

> +
> +/**
> + * kernel logging levels defines 
> + **/
> +#define EVMS_INFO_CRITICAL              0
> +#define EVMS_INFO_SERIOUS               1
> +#define EVMS_INFO_ERROR                 2
> +#define EVMS_INFO_WARNING               3
> +#define EVMS_INFO_DEFAULT               5
> +#define EVMS_INFO_DETAILS               6
> +#define EVMS_INFO_DEBUG                 7
> +#define EVMS_INFO_EXTRA                 8
> +#define EVMS_INFO_ENTRY_EXIT            9
> +#define EVMS_INFO_EVERYTHING            10

What about just using normal logging levels?

> +/**
> + * helpful PROCFS macro
> + **/
> +#ifdef CONFIG_PROC_FS
> +#define PROCPRINT(msg, args...) (sz += sprintf(page + sz, msg, ## args));\
> +			if (sz < off)\
> +				off -= sz, sz = 0;\
> +			else if (sz >= off + count)\
> +				goto out
> +#endif

I think this really wants to be converted to the seq_file interface..

> +
> +/**
> + * PluginID convenience macros
> + *
> + * An EVMS PluginID is a 32-bit number with the following bit positions:
> + * Top 16 bits: OEM identifier. See IBM_OEM_ID.
> + * Next 4 bits: Plugin type identifier. See evms_plugin_code.
> + * Lowest 12 bits: Individual plugin identifier within a given plugin type.
> + **/
> +#define SetPluginID(oem, type, id) ((oem << 16) | (type << 12) | id)
> +#define GetPluginOEM(pluginid) (pluginid >> 16)
> +#define GetPluginType(pluginid) ((pluginid >> 12) & 0xf)
> +#define GetPluginID(pluginid) (pluginid & 0xfff)

What is the prupose of OEM IDs?

> +struct evms_plugin_header {
> +	u32 id;
> +	struct evms_version version;
> +	struct evms_version required_services_version;
> +	struct evms_plugin_fops *fops;
> +	struct list_head headers;
> +};

What is the required services version?

> +struct evms_plugin_fops {

What about evms_plugin_ops?

> +	int (*ioctl) (struct evms_logical_node *, struct inode *,
> +		      struct file *, u32, unsigned long);
> +	int (*direct_ioctl) (struct inode *, struct file *,
> +			     u32, unsigned long);

Umm, why do you need two ioctl handlers?

> +/**
> + * convenience macros to use plugin's fops entry points  
> + **/
> +#define DISCOVER(node, list) ((plugin)->fops->discover(list))
> +#define END_DISCOVER(node, list) ((plugin)->fops->end_discover(list))
> +#define DELETE(node) ((node)->plugin->fops->delete(node))
> +#define SUBMIT_IO(node, bio) ((node)->plugin->fops->submit_io(node, bio))
> +#define INIT_IO(node, rw_flag, start_sec, num_secs, buf_addr) ((node)->plugin->fops->init_io(node, rw_flag, start_sec, num_secs, buf_addr))
> +#define IOCTL(node, inode, file, cmd, arg)    ((node)->plugin->fops->ioctl(node, inode, file, cmd, arg))
> +#define DIRECT_IOCTL(plugin, inode, file, cmd, arg)   ((plugin)->fops->direct_ioctl(inode, file, cmd, arg))

Do you really need those wrapper?  They just obsfucate the code

> +/**
> + * struct evms_pool_mgmt - anchor block for private pool management
> + * @cachep: 		kmem_cache_t variable
> + * @member_size: 	size of each element in the pool
> + * @head:
> + * @waiters: 		count of waiters
> + * @wait_queue: 	list of waiters
> + * @name: 		name of the pool (must be less than 20 chars)
> + *
> + * anchor block for private pool management
> + **/
> +struct evms_pool_mgmt {
> +	kmem_cache_t *cachep;
> +	int member_size;
> +	void *head;
> +	atomic_t waiters;
> +	wait_queue_head_t wait_queue;
> +	u8 *name;
> +};

What's the pruipose of this?  Is it really evms-specific?

> +
> +/*
> + * Notes:  
> + *	All of the following kernel thread functions belong to EVMS base.
> + *	These functions were copied from md_core.c
> + */

What about moving them to the core kernel code so everyone
can use them?

> +/* Have to include this at the end, since it depends
> + * on structures and definitions in this file.
> + */
> +#include <linux/evms/evms_ioctl.h>

Just remove this and make the individual sources include it

