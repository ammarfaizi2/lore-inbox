Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbSJCSu0>; Thu, 3 Oct 2002 14:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbSJCSu0>; Thu, 3 Oct 2002 14:50:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38548 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261320AbSJCSuY>;
	Thu, 3 Oct 2002 14:50:24 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF25D731E3.0E245DDC-ON85256C47.00645AA7@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 3 Oct 2002 13:59:47 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/03/2002 02:54:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/2002 at 9:50 AM, Christoph Hellwig wrote:

>> +/**
>> + * helpful PROCFS macro
>> + **/
>> +#ifdef CONFIG_PROC_FS
>> +#define PROCPRINT(msg, args...) (sz += sprintf(page + sz, msg, ##
args));\
>> +              if (sz < off)\
>> +                    off -= sz, sz = 0;\
>> +              else if (sz >= off + count)\
>> +                    goto out
>> +#endif

> I think this really wants to be converted to the seq_file interface..

We plan to.

>> +
>> +/**
>> + * PluginID convenience macros
>> + *
>> + * An EVMS PluginID is a 32-bit number with the following bit
positions:
>> + * Top 16 bits: OEM identifier. See IBM_OEM_ID.
>> + * Next 4 bits: Plugin type identifier. See evms_plugin_code.
>> + * Lowest 12 bits: Individual plugin identifier within a given plugin
type.
>> + **/
>> +#define SetPluginID(oem, type, id) ((oem << 16) | (type << 12) | id)
>> +#define GetPluginOEM(pluginid) (pluginid >> 16)
>> +#define GetPluginType(pluginid) ((pluginid >> 12) & 0xf)
>> +#define GetPluginID(pluginid) (pluginid & 0xfff)

> What is the prupose of OEM IDs?

To allow unique identification of plugins. If you wrote
plugin, you might give it an ID of 1. Someone else
may do the same thing. However, by letting you add
something specific which identifies you (i.e. like
your initials), then possibility of collisions is
reduced.

>> +struct evms_plugin_header {
>> +  u32 id;
>> +  struct evms_version version;
>> +  struct evms_version required_services_version;
>> +  struct evms_plugin_fops *fops;
>> +  struct list_head headers;
>> +};

> What is the required services version?

The common services are a set of functions exported
by the core code. We have major,minor,patchlevel
versions for them. Plugin writers specify the
version of the interface they are coded to comply
with. Mismatching core services and plugin
version expectations are caught at plugin registration
(load) time, and prevented from being usable.

>> +struct evms_plugin_fops {

> What about evms_plugin_ops?

>> +  int (*ioctl) (struct evms_logical_node *, struct inode *,
>> +              struct file *, u32, unsigned long);
>> +  int (*direct_ioctl) (struct inode *, struct file *,
>> +                   u32, unsigned long);

> Umm, why do you need two ioctl handlers?

the IOCTL entry point is used to send to volumes.
the DIRECT_IOCTL entry point is used for point-
to-point ioctls between corresponding user space
and kernel space plugins.

>> +/**
>> + * convenience macros to use plugin's fops entry points
>> + **/
>> +#define DISCOVER(node, list) ((plugin)->fops->discover(list))
>> +#define END_DISCOVER(node, list) ((plugin)->fops->end_discover(list))
>> +#define DELETE(node) ((node)->plugin->fops->delete(node))
>> +#define SUBMIT_IO(node, bio) ((node)->plugin->fops->submit_io(node,
bio))
>> +#define INIT_IO(node, rw_flag, start_sec, num_secs, buf_addr) >((node)
->plugin->fops->init_io(node, rw_flag, start_sec, num_secs, buf_addr))
>> +#define IOCTL(node, inode, file, cmd, arg)    ((node)
->plugin->fops->ioctl(node, >inode, file, cmd, arg))
>> +#define DIRECT_IOCTL(plugin, inode, file, cmd, arg)   >((plugin)
->fops->direct_ioctl(inode, file, cmd, arg))

> Do you really need those wrapper?

No the wrappers aren't really needed. However they do make the
code a great deal more readable.

> They just obsfucate the code

The same argument could be made about *all* macros then.
Its simply a tradeoff between readability and potential
hiding.

>> +/**
>> + * struct evms_pool_mgmt - anchor block for private pool management
>> + * @cachep:         kmem_cache_t variable
>> + * @member_size:    size of each element in the pool
>> + * @head:
>> + * @waiters:        count of waiters
>> + * @wait_queue:     list of waiters
>> + * @name:           name of the pool (must be less than 20 chars)
>> + *
>> + * anchor block for private pool management
>> + **/
>> +struct evms_pool_mgmt {
>> +  kmem_cache_t *cachep;
>> +  int member_size;
>> +  void *head;
>> +  atomic_t waiters;
>> +  wait_queue_head_t wait_queue;
>> +  u8 *name;
>> +};

> What's the pruipose of this?  Is it really evms-specific?

Its a reminent of 2.4 stuff before mempool was available.
Its gone.

>> +
>> +/*
>> + * Notes:
>> + *      All of the following kernel thread functions belong to EVMS
base.
>> + *      These functions were copied from md_core.c
>> + */

> What about moving them to the core kernel code so everyone
> can use them?

I've got no problem with doing that.

>> +/* Have to include this at the end, since it depends
>> + * on structures and definitions in this file.
>> + */
>> +#include <linux/evms/evms_ioctl.h>

> Just remove this and make the individual sources include it

Sure, its easy to do. Having nested includes allowed us
to enforce include ordering.

Mark


