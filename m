Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbVA2I20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVA2I20 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 03:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVA2I20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 03:28:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:19148 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262881AbVA2I2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 03:28:07 -0500
Date: Sat, 29 Jan 2005 00:15:27 -0800
From: Greg KH <greg@kroah.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 2
Message-ID: <20050129081527.GD7738@kroah.com>
References: <16890.38062.477373.644205@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16890.38062.477373.644205@tut.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 01:38:22PM -0600, Tom Zanussi wrote:
> +extern void * alloc_rchan_buf(unsigned long size,
> +			      struct page ***page_array,
> +			      int *page_count);
> +extern void free_rchan_buf(void *buf,
> +			   struct page **page_array,
> +			   int page_count);

As these will be "polluting" the global namespace of the kernel, could
you add "relayfs_" to the front of them?

Also, any reason why you haven't exported the fops of relayfs so that
others can use this in their filesystems (like proc and debugfs)?

> +/**
> + *	rchan_create_file - create relay file, including parent directories
> + *	@chanpath: path to file, including filename
> + *	@dentry: result dentry
> + *	@data: data to associate with the file
> + *
> + *	Returns 0 if successful, negative otherwise.
> + */
> +static inline int rchan_create_file(const char *chanpath,
> +				    struct dentry **dentry,
> +				    struct rchan_buf *data)
> +{
> +	int err;
> +	const char * fname;
> +	struct dentry *topdir;
> +
> +	err = rchan_create_dir(chanpath, &fname, &topdir);
> +	if (err && (err != -EEXIST))
> +		return err;
> +
> +	err = relayfs_create_file(fname, topdir, dentry, data, S_IRUSR);
> +
> +	return err;
> +}

Why not just return the * to the dentry?  Gets rid of one paramater...

Also, if a path is passed to this function, when the "channel" is
finally torn down, that path is not removed, right?  Or did I miss that
in the code somewhere?

> +/**
> + *	check_attribute_flags - check sanity of channel attributes
> + *	@flags: channel attributes
> + *
> + *	Returns 0 if successful, negative otherwise.
> + */
> +static inline int check_attribute_flags(u32 *attribute_flags)
> +{
> +	u32 flags = *attribute_flags;
> +
> +	if ((flags & RELAY_MODE_CONTINUOUS) &&
> +	    (flags & RELAY_MODE_NO_OVERWRITE))
> +		return -EINVAL; /* Can't have it both ways */
> +
> +	if (!(flags & RELAY_MODE_CONTINUOUS) &&
> +	    !(flags & RELAY_MODE_NO_OVERWRITE))
> +		*attribute_flags |= RELAY_MODE_CONTINUOUS; /* Default */
> +
> +	return 0;
> +}

Why be nice to your caller?  Just force them to get the flags right, and
if not, error out, you don't have to provide a "default" as this is a
required parameter to start up a channel, right?

> +/*
> + * Per-cpu relay channel buffer
> + */
> +struct rchan_buf
> +{
> +	void *start;			/* start of channel buffer */
> +	void *data;			/* start of current sub-buffer */
> +	local_t offset;			/* current offset into sub-buffer */
> +	unsigned bufsize;		/* sub-buffer size */
> +	unsigned alloc_size;		/* total buffer size allocated */
> +	unsigned nbufs;			/* number of sub-buffers */
> +	unsigned bufs_produced;		/* count of sub-buffers produced */
> +	unsigned bufs_consumed;		/* count of sub-buffers consumed */
> +	wait_queue_head_t read_wait;	/* reader wait queue */
> +	struct work_struct wake_readers; /* reader wake-up work struct */
> +	struct rchan_callbacks *cb;	/* client callbacks */
> +	struct work_struct work;	/* remove file work struct */
> +	u32 flags;			/* relay channel attributes */
> +	struct dentry *dentry;		/* channel file dentry */
> +	atomic_t refcount;		/* channel refcount */

Please use struct kref for this.

> +	struct page **page_array;	/* array of current buffer pages */
> +	int page_count;			/* number of current buffer pages */
> +	unsigned *padding;		/* padding counts per sub-buffer */
> +	unsigned *commit;		/* commit counts per sub-buffer */
> +	int finalized;			/* buffer has been finalized */
> +} ____cacheline_aligned;

thanks,

greg k-h
