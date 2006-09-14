Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWINJ7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWINJ7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 05:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWINJ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 05:59:10 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:63699 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1750763AbWINJ7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 05:59:06 -0400
Date: Thu, 14 Sep 2006 18:58:50 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 10/11] LTTng-core 0.5.108 : relayfs
Message-ID: <20060914095850.GB6780@localhost.usen.ad.jp>
References: <20060914034940.GK2194@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914034940.GK2194@Krystal>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 11:49:40PM -0400, Mathieu Desnoyers wrote:
> --- a/Documentation/ioctl-number.txt
> +++ b/Documentation/ioctl-number.txt
> @@ -190,3 +190,6 @@ Code	Seq#	Include File		Comments
>  					<mailto:aherrman@de.ibm.com>
>  0xF3	00-3F	video/sisfb.h		sisfb (in development)
>  					<mailto:thomas@winischhofer.net>
> +0xF4	00-3F	linux/relayfs_fs.h RelayFS
> +					<mailto:mathieu.desnoyers@polymtl.ca>
> +
Even if you were to add the file system back in for some nonsensical
reason, the header is still wrong.

> --- a/include/linux/relay.h
> +++ b/include/linux/relay.h
> @@ -1,6 +1,7 @@
>  /*
>   * linux/include/linux/relay.h
>   *
> + * Copyright (C) 2005, Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
>   * Copyright (C) 2002, 2003 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
>   * Copyright (C) 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
>   *
> @@ -37,11 +38,13 @@ struct rchan_buf
>  	size_t offset;			/* current offset into sub-buffer */
>  	size_t subbufs_produced;	/* count of sub-buffers produced */
>  	size_t subbufs_consumed;	/* count of sub-buffers consumed */
> +	atomic_t full;		/* buffer is in full state */
>  	struct rchan *chan;		/* associated channel */
>  	wait_queue_head_t read_wait;	/* reader wait queue */
>  	struct work_struct wake_readers; /* reader wake-up work struct */
>  	struct dentry *dentry;		/* channel file dentry */
>  	struct kref kref;		/* channel buffer refcount */
> +	atomic_t open_count;			/* file open count */
>  	struct page **page_array;	/* array of current buffer pages */
>  	unsigned int page_count;	/* number of current buffer pages */
>  	unsigned int finalized;		/* buffer has been finalized */
> @@ -60,11 +63,18 @@ struct rchan
>  	size_t subbuf_size;		/* sub-buffer size */
>  	size_t n_subbufs;		/* number of sub-buffers per buffer */
>  	size_t alloc_size;		/* total buffer size allocated */
> +	int overwrite;			/* overwrite buffer when full? */
>  	struct rchan_callbacks *cb;	/* client callbacks */
> +	struct file_operations *fops; 	/* file operations */
> +	void *client_data; 		/* client data associated with the
> +					   client callbacks */
> +	void (*free_client_data_cb)(void*); /* Callback function to free the
> +					       client data */
>  	struct kref kref;		/* channel refcount */
>  	void *private_data;		/* for user-defined data */
>  	size_t last_toobig;		/* tried to log event > subbuf size */
>  	struct rchan_buf *buf[NR_CPUS]; /* per-cpu channel buffers */
> +	struct module *client_module;	/* Client module */
>  };
>  
>  /*
> @@ -76,6 +86,7 @@ struct rchan_callbacks
>  	 * subbuf_start - called on buffer-switch to a new sub-buffer
>  	 * @buf: the channel buffer containing the new sub-buffer
>  	 * @subbuf: the start of the new sub-buffer
> +	 * @prev_subbuf_idx: the previous sub-buffer's index
>  	 * @prev_subbuf: the start of the previous sub-buffer
>  	 * @prev_padding: unused space at the end of previous sub-buffer
>  	 *
> @@ -95,6 +106,18 @@ struct rchan_callbacks
>  			     size_t prev_padding);
>  
>  	/*
> +	 * deliver - deliver a guaranteed full sub-buffer to client
> +	 * @buf: the channel buffer containing the sub-buffer
> +	 * @subbuf_idx: the sub-buffer's index
> +	 * @subbuf: the start of the new sub-buffer
> +	 *
> +	 * Only works if relay_commit is also used
> +	 */
> +	void (*deliver) (struct rchan_buf *buf,
> +			 unsigned subbuf_idx,
> +			 void *subbuf);
> +
> +	/*
>  	 * buf_mapped - relay buffer mmap notification
>  	 * @buf: the channel buffer
>  	 * @filp: relay file pointer
> @@ -113,6 +136,7 @@ struct rchan_callbacks
>  	 */
>          void (*buf_unmapped)(struct rchan_buf *buf,
>  			     struct file *filp);
> +
>  	/*
>  	 * create_buf_file - create file to represent a relay channel buffer
>  	 * @filename: the name of the file to create
> @@ -153,6 +177,31 @@ struct rchan_callbacks
>  	 * The callback should return 0 if successful, negative if not.
>  	 */
>  	int (*remove_buf_file)(struct dentry *dentry);
> +
> +	/*
> +	 * buf_full - relayfs buffer full notification
> +	 * @buf: the channel channel buffer
> +	 * @subbuf_idx: the current sub-buffer's index
> +	 * @subbuf: the start of the current sub-buffer
> +	 *
> +	 * Called when a relayfs buffer becomes full
> +	 */
> +	void (*buf_full)(struct rchan_buf *buf,
> +			unsigned subbuf_idx,
> +			void *subbuf);
> +
> +	/*
> +	 * buf_unfull - relayfs buffer unfull notification
> +	 * @buf: the channel channel buffer
> +	 * @subbuf_idx: the current sub-buffer's index
> +	 * @subbuf: the start of the current sub-buffer
> +	 *
> +	 * Called when a relayfs buffer passes from full to not full
> +	 */
> +	void (*buf_unfull)(struct rchan_buf *buf,
> +			unsigned subbuf_idx,
> +			void *subbuf);
> +
>  };
>  
>  /*
> @@ -163,7 +212,12 @@ struct rchan *relay_open(const char *bas
>  			 struct dentry *parent,
>  			 size_t subbuf_size,
>  			 size_t n_subbufs,
> -			 struct rchan_callbacks *cb);
> +			 int overwrite,
> +			 struct module *client_module,
> +			 struct rchan_callbacks *cb,
> +			 struct file_operations *fops,
> +			 void *client_data,
> +			 void (*free_client_data_cb)(void*));
>  extern void relay_close(struct rchan *chan);
>  extern void relay_flush(struct rchan *chan);
>  extern void relay_subbufs_consumed(struct rchan *chan,

These should be split out with the corresponding kernel/relay.c updates
and posted separately. fops as an argument looks very suspect.

> @@ -175,6 +229,17 @@ extern int relay_buf_full(struct rchan_b
>  extern size_t relay_switch_subbuf(struct rchan_buf *buf,
>  				  size_t length);
>  
> +extern struct dentry *relayfs_create_dir(const char *name,
> +					 struct dentry *parent);
> +extern int relayfs_remove_dir(struct dentry *dentry);
> +extern struct dentry *relayfs_create_file(const char *name,
> +					  struct dentry *parent,
> +					  int mode,
> +					  struct file_operations *fops,
> +					  void *data);
> +extern int relayfs_remove_file(struct dentry *dentry);
> +
> +
>  /**
>   *	relay_write - write data into the channel
>   *	@chan: relay channel
> @@ -251,6 +316,7 @@ static inline void *relay_reserve(struct
>  		if (!length)
>  			return NULL;
>  	}
> +
>  	reserved = buf->data + buf->offset;
>  	buf->offset += length;
>  
None of this matters, use debugfs, it already does it for you.
