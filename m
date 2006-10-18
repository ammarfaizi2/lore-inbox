Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWJREu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWJREu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWJREu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:50:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932081AbWJREu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:50:27 -0400
Date: Tue, 17 Oct 2006 21:48:03 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Paolo Abeni <paolo.abeni@email.it>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: [PATCH] usbmon: add binary interface
Message-Id: <20061017214803.6ecc374d.zaitcev@redhat.com>
In-Reply-To: <1160557065.9547.12.camel@localhost.localdomain>
References: <1160557065.9547.12.camel@localhost.localdomain>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 10:57:45 +0200, Paolo Abeni <paolo.abeni@email.it> wrote:

In the patch I see these main issues: object layout, and API design.
The rest is minor. I am going to use most of the patch and fix it up.
Unfortunately, it's not going to be binary compatible with your API.

* Objects are all screwed up

Old hierarchy:
mon_reader
  mon_reader_text

New:
mon_reader
  mon_reader_list
    mon_reader_text

And the intent was:
mon_reader
  mon_reader_text
  mon_reader_bin

In the patch, text reader inherits from binary, which obviously reflects
your viewpoint about the supremacy of binary. This is a matter of taste,
obviously. I prefer the symmetry.

* API

I think that reading structured data from read(2) is rather dirty.
This is what ioctl is for.

But even then, there were some mistakes. I'm going to point them
out for the record. Look at the data layout and the read function:

> +struct mon_event_hdr {
> +	s32 type;	/* submit, complete, etc. */
> +	u32 pipe;	/* Pipe */
> +	u64 id;	        /* Incremental id */
> +	struct timeval tstamp;
> +	u32 length;	/* Depends on type: xfer length or act length */
> +	s32 status;
> +	s8 setup_flag;
> +	s8 data_flag;
> +};
> +
> +struct mon_event_list {
> +	struct list_head e_link;
> +        struct mon_event_hdr hdr;
> +	unsigned char setup[SETUP_MAX];
> +	unsigned char* data;
> +};

> +static ssize_t mon_binary_read(struct file *file, char __user *buf,
> +				size_t nbytes, loff_t *ppos)
> +{
> +	struct mon_event_list *ep;

> +	/* check out how much URB data is present in this buffer*/
> +	if ((ep->hdr.length > 0) && (ep->hdr.data_flag == 0))
> +		data_len = (ep->hdr.length > rp->data_max) ? rp->data_max: 
> +								ep->hdr.length;
> +	
> +	/* avoid overrun user buffer; copy as much data as possible*/
> +	hdr_bytes = sizeof(struct mon_event_list) > nbytes ? nbytes: 
> +						sizeof(struct mon_event_list);
> +	nbytes -= hdr_bytes;
> +	if (ep->hdr.setup_flag == 0)
> +		setup_len = SETUP_MAX;
> +	setup_bytes =  setup_len > nbytes ? nbytes : setup_len;
> +	nbytes -= setup_bytes;
> +	data_bytes = data_len > nbytes ? nbytes: data_len;
> +	
> +	cnt = hdr_bytes + setup_bytes + data_bytes;
> +	if (copy_to_user(buf, ep, hdr_bytes))
> +	{
> +		cnt = -EFAULT;
> +		goto out;
> +	}
> +	if ((setup_bytes > 0) && copy_to_user(buf+hdr_bytes, ep->setup, 
> +								setup_bytes))
> +	{
> +		cnt = -EFAULT;
> +		goto out;
> +	}
> +	if ((data_bytes > 0) && copy_to_user(buf+hdr_bytes, ep->data, 
> +								data_bytes))
> +		cnt = -EFAULT;
> +out:        
> +	kmem_cache_free(rp->e_slab, ep);
> +	return cnt;
> +}

- Leaving data_flag in the header makes no sense, because length is
  included.

- Setup packet is copied out twice.

- Internal kernel pointers are needlessly sent to user mode.

- struct timeval is written in write()

- Because of the two issues above the size of the header is not
  mode-independent, so you can't use a 32-bit usbmon or Wireshark
  on a 64-bit system. And since you use write() a translation is
  impossible.
 
Going further...

> @@ -320,11 +321,22 @@ static void mon_bus_init(struct dentry *
>  		goto err_create_s;
>  	mbus->dent_s = d;
>  
> +	rc = snprintf(name, NAMESZ, "%db", ubus->busnum);
> +	if (rc <= 0 || rc >= NAMESZ)
> +		goto err_print_b;
> +	d = debugfs_create_file(name, 0600, mondir, mbus, &mon_fops_binary);
> +	if (d == NULL)
> +		goto err_create_b;

This is not a mistake, but a design decision as we discussed before.
I think I'm going use a character device in preference.

> +struct mon_event_hdr {
> +	s32 type;	/* submit, complete, etc. */
> +	u32 pipe;	/* Pipe */
> +	u64 id;	        /* Incremental id */
> +	struct timeval tstamp;
> +	u32 length;	/* Depends on type: xfer length or act length */
> +	s32 status;
> +	s8 setup_flag;
> +	s8 data_flag;
> +};

I'm going to use the header which you used with small modifications
for the ioctl. For one thing, we need two lengths: the actual length
of URB data, and the length of data delivered to the application.

* Reallocation - a smaller issue

> +int mon_list_resize(struct mon_reader_list* rp, int data_max)
> +{
> +	if ((new_e_slab = kmem_cache_create(new_name,
> +	    sizeof(struct mon_event_list)+data_max, sizeof(long), 0,
> +	    mon_list_ctor, NULL)) == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}

The function is unfinished, because this is the only time where
new_e_slab is used!

> +	/* event list must be flushed because old entries have different size */
> +	spin_lock_irqsave(&rp->r.m_bus->lock, flags);
> +	INIT_LIST_HEAD(&rp->e_list);
> +	rp->nevents = 0;
> +	spin_unlock_irqrestore(&rp->r.m_bus->lock, flags);

That's wrong. And to think that you abstracted mon_list_destroy.

In any case, I think this reallocation business is sad.
Let's switch to separate allocations and not reallocate
on resizes. This will just happen under the mbus->lock.

* Small things

> +	if (_IOC_TYPE(cmd) != MON_IOC_MAGIC)
> +		return -ENOTTY;
Not necessary due to switch below

> +/*
> + * This limit can be changed using ioctl
> + */
> +#define DATA_DFL  32
> +#define DATA_MIN  16
> +#define DATA_MAX  1024

This is too much to put into slab. We should change mon_event_alloc
if this is allowed. We discussed this.

> +/*
> + * This limit exists to prevent OOMs when the user process stops reading.
> + * If usbmon were available to unprivileged processes, it might be open
> + * to a local DoS. But we have to keep to root in order to prevent
> + * password sniffing from HID devices.
> + */
> +#define EVENT_MAX  (2*PAGE_SIZE / sizeof(struct mon_event_list))

This is obviosly incorrect when resizing is allowed.

> +static u64 mon_make_id(void* urb)

This is taking the idea too far, too early.

>  mon_common.c |  329 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

I think these things can go into mon_main.c, if any.

> +#define MON_IOCT_DATA_MAX _IO(MON_IOC_MAGIC, 1)
> +#define MON_IOCG_DATA_MAX _IOR(MON_IOC_MAGIC, 2, u32)

OK, this seems like correct sizing, but I need to check.

> +#define MON_IOC_MAXNR	2

Not used anywhere.

* Spelling errors

> +		/* try to allocate new buffer before relasing old one
> +		 * to be safe*/

"releasing", and don't save on spaces

> + * Temporary remove reader from reader list during resize.

"Temporarily"

> + * Initialize list reader. Must be called with mon_lock hold and before 
> + * mon_reader_add

This is "held".

I'm going to post what I came up with some time this week.

Cheers,
-- Pete

P.S. I think this shouldn't be done:

> A binary interface is added to usbmon. For each USB bus present on the host system a new file is added to the debugfs directory, in the form "usb%db".

It would be better to limit the line length in changelog, because it's
not just an e-mail message (in fact it would be great to do it for
e-mail messages as well).

P.P.S. We have to think about the size limits very carefuly, because
one of the design parameters for the universal binary interface is
an intercept of all data, including that sent in very long chunks.
And URBs can have virtually unlimited data lengths. Simply bumping
the limit is not the answer, because then we're pressed against the
limits of kmalloc(). We might need to have URBs refcounted like skbuffs.
This would be helpful to reduce the copying.
