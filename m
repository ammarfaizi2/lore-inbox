Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVBUIZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVBUIZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVBUIZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:25:17 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59271 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261918AbVBUIZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:25:02 -0500
References: <16918.10967.325166.756203@tut.ibm.com>
In-Reply-To: <16918.10967.325166.756203@tut.ibm.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com
Subject: Re: relayfs redux, part 5
Date: Mon, 21 Feb 2005 10:24:58 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42199ADA.000008F4@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom, 

More nitpick follows. 

> diff -urpN -X dontdiff linux-2.6.10/fs/Makefile linux-2.6.10-cur/fs/Makefile
> --- linux-2.6.10/fs/Makefile	2004-12-24 15:34:58.000000000 -0600
> +++ linux-2.6.10-cur/fs/Makefile	2005-02-06 21:32:49.000000000 -0600
> +/**
> + *	relay_create_buf - allocate and initialize a channel buffer
> + *	@alloc_size: size of the buffer to allocate
> + *	@n_subbufs: number of sub-buffers in the channel
> + *
> + *	Returns channel buffer if successful, NULL otherwise
> + */
> +struct rchan_buf *relay_create_buf(struct rchan *chan)
> +{
> +	struct rchan_buf *buf = kcalloc(1, sizeof(struct rchan_buf), GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	buf->padding = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
> +	if (!buf->padding)
> +		goto free_buf;
> +	
> +	buf->commit = kmalloc(chan->n_subbufs * sizeof(unsigned *), GFP_KERNEL);
> +	if (!buf->commit)
> +		goto free_padding;
> +
> +	buf->start = relay_alloc_buf(chan->alloc_size, &buf->page_array, &buf->page_count);
> +	if (!buf->start)
> +		goto free_commit;
> +
> +	buf->chan = chan;
> +	kref_get(&buf->chan->kref);
> +	return buf;
> +
> +free_commit:
> +	kfree(buf->commit);
> +
> +free_padding:
> +	kfree(buf->padding);
> +
> +free_buf:
> +	kfree(buf);
> +	return NULL;
> +}

kfree() deals with NULL pointers and since we're zeroing all of them when
we call kcalloc(), you only need one failure goto where you unconditionally
execute all kfree() calls. 

> diff -urpN -X dontdiff linux-2.6.10/fs/relayfs/inode.c linux-2.6.10-cur/fs/relayfs/inode.c
> --- linux-2.6.10/fs/relayfs/inode.c	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.10-cur/fs/relayfs/inode.c	2005-02-14 20:10:33.000000000 -0600
> @@ -0,0 +1,426 @@
> +/**
> + *	relayfs_create_file - create a file in the relay filesystem
> + *	@name: the name of the file to create
> + *	@parent: parent directory
> + *	@mode: mode, if not specied the default perms are used
> + *	@chan: channel associated with the file
> + *
> + *	Returns file dentry if successful, NULL otherwise.
> + *
> + *	The file will be created user r on behalf of current user.
> + */
> +struct dentry *relayfs_create_file(const char *name, struct dentry *parent,
> +				   int mode, struct rchan *chan)
> +{
> +	if (!mode)
> +		mode = S_IRUSR;
> +	mode = (mode & S_IALLUGO) | S_IFREG;
> +
> +	return relayfs_create_entry(name, parent, mode, chan);

Shouldn't we check if name is NULL here like in relayfs_create_dir? Perhaps
the check should be moved to relayfs_create_entry(). 

> diff -urpN -X dontdiff linux-2.6.10/include/linux/relayfs_fs.h linux-2.6.10-cur/include/linux/relayfs_fs.h
> --- linux-2.6.10/include/linux/relayfs_fs.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.10-cur/include/linux/relayfs_fs.h	2005-02-14 01:32:16.000000000 -0600
> @@ -0,0 +1,269 @@
> +
> +/*
> + * Relay attribute flags
> + */
> +#define RELAY_MODE_CONTINUOUS		0x1
> +#define RELAY_MODE_NO_OVERWRITE		0x2

These are mutually exclusive so they're really a boolean that states
whether overwrite is allowed or not. Therefore please either make struct
rchan flags a boolean (it is only used for this) or turn the above to a 
single bit flag (cleared for not allowed, set for allowed) and then drop 
check_attribute_flags(). 

                      Pekka 
